create database bank_loan;
use bank_loan;

select * from finance_1;
select * from finance_2 ;

## 1. Year wise loan amount Stats
## 2. Grade and sub grade wise revol_bal
## 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status
## 4. State wise and month wise loan status
## 5. Home ownership Vs last payment date stats

select count(*) from finance_1;
select count(*) from finance_2;

------ ## kpi 1--------
## 1. Year wise loan amount Stats
select year(issue_d) as year_of_issue_d ,concat("$",round(sum(loan_amnt)/1000000,0),"M") as total_loan_amt
from finance_1
group by year_of_issue_d
order by year_of_issue_d;

-------- ## kpi 2------
## 2. Grade and sub grade wise revol_bal
select
grade , sub_grade , concat("$",round(sum(revol_bal)/1000000,0),"M") as total_revol_bal
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by grade , sub_grade
order by grade , sub_grade;

------- ## kpi 3-------
## 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status , concat("$",round(sum(total_pymnt)/1000000,0),"M") as total_payment
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by verification_status having verification_status in ("verified" ,"not verified");

-------- ## kpi 4--------
## 4. State wise and month wise loan status
select addr_State , month , loan_Status
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by addr_State , month , loan_Status
order by month ;

------- ##KPI 5------
## 5. Home ownership Vs last payment date stats
select
home_ownership,count(home_ownership) ,right(last_pymnt_d,4)  as year
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by 
home_ownership ,year
order by 
home_ownership, year ;
