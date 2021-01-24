#insert into test2 values("张三","语文", 81);
#insert into test2 values("张三","数学", 75);
#insert into test2 values("李四","语文", 76);
#insert into test2 values("李四","数学", 90);
#insert into test2 values("王五","语文", 81);
#insert into test2 values("王五","数学", 100);
#insert into test2 values("王五","英语", 90);

#select name from test2 group by name having min(grad) > 70;

#delete from test2 

#select a.name, b.name from test3 a, test3 b where a.name < b.name;

/*
select year,
(select amount from table m where month = 1 and m.year = table.year) as m1, 
(select amount from table m where month = 2 and m.year = table.year) as m2,
(select amount from table m where month = 3 and m.year = table.year) as m3,
(select amount from table m where month = 4 and m.year = table.year) as m4
from table group by year;
*/

/*
select p_id,
	sum(case when s_id=1 then p_num else 0 end) as s1_id,
    sum(case when s_id=2 then p_num else 0 end) as s2_id,
    sum(case when s_id=3 then p_num else 0 end) as s3_id
from myPro group by p_id;
*/

#create table Student(Sid varchar(6) , Sname varchar(10), Sage datetime, Ssex varchar(10)); 
#alter table Student convert to character set utf8;

/*
insert into Student values('01' , '赵雷' , '1990-01-01' , '男');
insert into Student values('02' , '钱电' , '1990-12-21' , '男');
insert into Student values('03' , '孙风' , '1990-05-20' , '男');
insert into Student values('04' , '李云' , '1990-08-06' , '男');
insert into Student values('05' , '周梅' , '1991-12-01' , '女');
insert into Student values('06' , '吴兰' , '1992-03-01' , '女');
insert into Student values('07' , '郑竹' , '1989-07-01' , '女');
insert into Student values('08' , '王菊' , '1990-01-20' , '女');
*/

#create table SC(Sid varchar(10) CHARACTER SET utf8, Cid varchar(10) CHARACTER SET utf8, score decimal(18,1)) charset=utf8;

/*
insert into SC values('01' , '01' , 80);
insert into SC values('01' , '02' , 90);
insert into SC values('01' , '03' , 99);
insert into SC values('02' , '01' , 70);
insert into SC values('02' , '02' , 60);
insert into SC values('02' , '03' , 80);
insert into SC values('03' , '01' , 80);
insert into SC values('03' , '02' , 80);
insert into SC values('03' , '03' , 80);
insert into SC values('04' , '01' , 50);
insert into SC values('04' , '02' , 30);
insert into SC values('04' , '03' , 20);
insert into SC values('05' , '01' , 76);
insert into SC values('05' , '02' , 87);
insert into SC values('06' , '01' , 31);
insert into SC values('06' , '03' , 34);
insert into SC values('07' , '02' , 89);
insert into SC values('07' , '03' , 98);
*/

/*
create table Teacher(Tid varchar(10) CHARACTER SET utf8,Tname varchar(10) CHARACTER SET utf8) charset=utf8;
insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');
*/

/*
create table Course(Cid varchar(10) CHARACTER SET utf8,Cname varchar(10) CHARACTER SET utf8,Tid varchar(10) CHARACTER SET utf8) charset=utf8;
insert into Course values('01' , '语文' , '02');
insert into Course values('02' , '数学' , '01');
insert into Course values('03' , '英语' , '03');
*/

/*
# 单独抽出来
select s.*, a.score as score_01, b.score as score_02
from Student s,
	(select sid, score from SC where cid=01) a,
    (select sid, score from SC where cid=02) b
where a.sid = b.sid and a.score > b.score and s.sid = a.sid
*/

#select a.Sid, a.Sname, b.avg from Student a,(select Sid,avg(score)avg from SC group by Sid having avg >= 60) b where a.Sid = b.Sid;

#select a.* from Student a, (select Sid from SC group by Sid) b where a.Sid = b.Sid;
#select * from student where sid in (select sid from sc where score is not null)

# select a.Sid, a.Sname, b.total, b.sum from Student a left join (select Sid, count(Cid) total, sum(score) sum from SC group by Sid) b on a.Sid = b.Sid;

#select * from Student where Sid in (select Sid from SC group by Sid);

/*
select S.Sid, S.Sname, count(*) as 选课总数, sum(score) as 总成绩, 
	sum(case when Cid = 01 then score else null end) as score_01,
    sum(case when Cid = 02 then score else null end) as score_02,
    sum(case when Cid = 03 then score else null end) as score_03
from Student as S, SC
where S.Sid = SC.Sid
group by S.Sid;
*/

#select count(*) from Teacher where Tname like "李%"

#select a.* from Student a where Sid in (select Sid cnt from SC group by Sid having count(*) < (select count(*) from Course));

/*
select Sname from Student where Sid not in
(select Sid from SC where Cid in
(select a.Cid from Course a join Teacher b on a.Tid = b.Tid where Tname = "张三"));
*/

#select a.Sid, b.Sname, avg(score) avg from SC a join (select a.Sid, a.Sname from Student a join (select Sid from SC where score < 60 group by Sid having count(*) >= 2) b on a.Sid = b.Sid) b on a.Sid = b.Sid group by Sid

#select a.*, b.score from Student a join (select Sid,score from SC where Cid = "01" and score < 60 order by score desc) b on a.Sid = b.Sid;

#select Sid,sum(case when Cid="01" then score else null end)c1, sum(case when Cid="02" then score else null end)c2,sum(case when Cid="03" then score else null end)c3,avg(score)avg from SC group by Sid order by avg desc;

/*
select b.Cname, a.* from
(select Cid, max(score)max, min(score)min, avg(score)avg,
	count(*)选修人数,
	sum(case when score >= 60 then 1 else 0 end)及格率,
    sum(case when score >= 70 and score <= 80 then 1 else 0 end)中等率,
    sum(case when score >= 80 and score <= 90 then 1 else 0 end)优良率,
    sum(case when score >= 90 then 1 else 0 end)优秀率
from SC group by Cid order by 选修人数 desc) a join Course b on a.Cid = b.Cid order by a.Cid asc;
*/

#select a.*, @curRank:=@curRank+1 as rank from (select @curRank := 0) p,(select Sid,avg(score)avg from SC group by Sid order by avg desc) a;
#select sid, RANK() over(partition by Cid order by score desc) as rank_01 from sc where cid = 01;

#select Sid,@curRank:=@curRank+1 as rank from SC, (select @curRank := 0) p  where Cid = "01" order by score desc;
#select Sid,@curRank:=@curRank+1 as rank from SC, (select @curRank := 0) p  where Cid = "02" order by score desc;
#select Sid,@curRank:=@curRank+1 as rank from SC, (select @curRank := 0) p  where Cid = "03" order by score desc;
#select a.*,@curRank:=@curRank+1 as rank from (select Sid, avg(score)avg from SC where Cid = "03" group by Sid order by score desc) a, (select @curRank := 0) p;

/*
select s.*, rank1, rank2, rank3, rankall
from Student s
left join (select Sid,@curRank1:=@curRank1+1 as rank1 from SC, (select @curRank1 := 0) p  where Cid = "01" order by score desc) A on A.Sid = s.Sid
left join (select Sid,@curRank2:=@curRank2+1 as rank2 from SC, (select @curRank2 := 0) p  where Cid = "02" order by score desc) B on B.Sid = s.Sid
left join (select Sid,@curRank3:=@curRank3+1 as rank3 from SC, (select @curRank3 := 0) p  where Cid = "03" order by score desc) C on C.Sid = s.Sid
left join (select Sid,@curRank4:=@curRank4+1 as rankall from (select Sid, avg(score)avg from SC group by Sid order by avg desc) a, (select @curRank4 := 0) p) D on D.Sid = s.Sid
order by rankall asc;
*/

/*
select a.Cname, b.* from Course a,
(select cid , 
sum(case when score >= 85 then 1 else 0 end)/count(cid) as 100_85,
sum(case when score < 85 and score >= 70 then 1 else 0 end)/count(cid) as 85_70,
sum(case when score < 70 and score >= 60 then 1 else 0 end)/count(cid) as 70_60,
sum(case when score < 60 and score >= 0 then 1 else 0 end)/count(cid) as 60_0
from SC group by cid) b where a.Cid = b.Cid;
*/

#select * from (select *, @num := @num + 1 as rank from SC, (select @num := 0) p where Cid = 03) a where a.rank <= 3

#select a.Sid, a.Sname,cnt from Student a join (select Sid, Cid, count(Cid)cnt from SC group by Sid having count(Cid) = 2) b on a.Sid = b. Sid 

#select * from Student where month(Sage) = 10;

#select * from Student a join (select Sid, max(Score) from SC where Cid in (select Cid from Course a join (select Tid from Teacher where Tname = "张三") b on a.Tid = b.Tid) group by Cid) b on a.Sid = b.Sid;

#select Sid, Sname, year(now())-year(Sage)age from Student;

#select Sid, Sname, timestampdiff(year, sage, now()), year(now())-year(Sage) from Student;

#select * from Student where month(now()) = month(Sage);

#select * from Student where month(now())+1 = month(Sage);

/*
select * from 
Student a join
(select a.sid, score1, score2 from 
SC a,
(select sid, score score1 from SC where cid = "01") b,
(select sid, score score2 from SC where cid = "02") c
where a.sid = b.sid and b.sid = c.sid and score1 > score2 group by sid) b
on a.Sid = b.Sid;
*/

/*
select * from 
(select Sid from SC where Cid = "01") a,
(select Sid from SC where Cid = "02") b
where a.Sid = b.Sid
*/

#select * from SC where SC.Sid not in (select Sid from SC where Cid = "01") and SC.Cid = "02"

/*
select a.Sid, a.Sname, b.avg
from Student a
join
(select Sid, avg(score)avg from SC  group by Sid having avg >= 70) b
on a.Sid = b.Sid
*/

#select a.* from Student a where Sid in (select Sid from SC group by Sid);

/*
select a.Sid, a.Sname, b.class_num,b.score_sum
from Student a join 
(select Sid, count(Cid)class_num, sum(score)score_sum from SC group by Sid) b
on a.Sid=b.Sid;
*/

/*
select a.Sid, a.Sname, b.class_num,b.score_sum
from Student a left join 
(select Sid, count(Cid)class_num, sum(score)score_sum from SC group by Sid) b
on a.Sid=b.Sid;
on a.Sid=b.Sid;
*/

/*
select * from Student where Sid in 
(select Sid from SC);
*/

#select count(*) from Teacher where Tname like "李%"

/*
select * from Student where Sid in
(select Sid from SC where Cid in
(select Cid from Course
where Tid = (select Tid from Teacher where Tname = "张三"))
group by Sid)
*/

/*
select * from Student where Sid not in
(select Sid from SC group by Sid having count(Cid) = (select count(*) from Course))
*/

/*
select * from Student where Student.sid in(
	select SC.sid from SC
    where SC.cid in (
		select SC.cid from SC
        where SC.sid = '01'
    )
)
*/

#select a.Sid, group_concat(cid order by cid) as Cids from SC a where a.Sid <> "01" group by a.Sid having Cids = (select group_concat(cid order by cid) as Cids from SC where Sid = "01" group by sid)

/*
select Sname from Student where Sid not in(
select Sid from SC where Cid in (
select Cid from Course a
join
(select Tid from Teacher where Tname = "张三") b 
on a.Tid = b.Tid));
*/

/*
select a.Sid, a.Sname, b.avg
from Student a
join
(select Sid, avg(score)avg, sum(case when score < 60 then 1 else 0 end)fail from SC group by Sid having fail >= 2) b
on a.Sid = b.Sid
*/

#show create table Student;

/*
select a.*,b.score from 
Student a
join 
(select Sid,score from SC where Cid = "01" and score < 60 ) b
on a.Sid = b.Sid
order by b.score desc
*/

/*
select Sid,
sum(case when Cid="01" then score end)class1,
sum(case when Cid="02" then score end)class2,
sum(case when Cid="03" then score end)class3, 
avg(score)avg
from SC group by Sid order by avg desc
*/

/*
select Cid, max(score)max, min(score)min,avg(score)avg, 
sum(case when score >= 60 then 1 else 0 end)/count(Sid) low,  
sum(case when score >= 70 and score < 80 then 1 else 0 end)/count(Sid) medium,  
sum(case when score >= 80 and score < 90 then 1 else 0 end)/count(Sid) more_medium,  
sum(case when score >= 90 then 1 else 0 end)/count(Sid) high,
count(*) num
from SC
group by Cid
order by num desc, Cid asc
*/

/*
select a.sid, a.cid, count(b.score)+1 rank
from SC as a
left join SC as b
on a.cid = b.cid and a.score < b.score
group by a.sid, a.cid
order by a.cid asc, rank asc
*/

/*
select a.Sid, count(b.Sid)+1 from
(select Sid, sum(score)score from SC group by Sid) a
left join 
(select Sid, sum(score)score from SC group by Sid) b
on a.score < b.score
group by a.Sid
*/

#select Sid, sum(score)score from SC group by Sid order by score desc

#select Sid, sum, @rank_i:=@rank_i+1 rank from (select @rank_i:=0) a,(select Sid, sum(score)sum from SC group by Sid order by sum desc) b 

/*
select * from Course a join
(select Cid, 
sum(case when score <=100 and score >= 85 then 1 else 0 end)/count(*)100_85,
sum(case when score < 85 and score >= 70 then 1 else 0 end)/count(*)85_70,
sum(case when score < 70 and score >= 60 then 1 else 0 end)/count(*)70_60,
sum(case when score < 60 and score >= 0 then 1 else 0 end)/count(*)60_0
from SC group by Cid) b 
on a.Cid = b.Cid
*/

#select a.Sid, a.Cid, count(b.Sid)+1 rank from SC a left join SC b on a.Cid = b.Cid and a.score < b.score group by a.Sid, a.Cid having rank <=3 order by a.Cid,rank

#select Cid, count(Sid) from SC group by Cid

/*
select a.Sid, a.Sname from Student a
join
(select Sid, count(Cid)cnt from SC group by Sid having cnt = 2) b
on a.Sid = b.Sid
*/

#select count(*) from Student group by Ssex

#select * from Student where Sname like "%风%"

#select Sname, count(*)cnt from Student group by Sname having cnt > 1

#select * from Student where year(Sage)=1990

#select Cid, avg(score)avg from SC group by Cid order by avg desc, Cid asc

/*
select a.Sid, a.Sname, b.avg from Student a
join
(select Sid, avg(score)avg from SC group by Sid having avg >= 85) b
on a.Sid = b.Sid
*/

/*
select a.Sname, b.score from Student a
join 
(select Sid, score from SC where Cid in 
(select Cid from Course where Cname="数学") and score < 60) b
on a.Sid = b.Sid
*/

#select * from Student a left join SC b on a.Sid = b.Sid 

/*
select a.Sname, b.Cname, c.score from
Student a join Course b join (select * from SC where score >= 70) c on a.Sid = c.Sid and b.Cid = c.Cid
*/

/*
select Student.sname, Course.cname,SC.score from Student,Course,SC
where SC.score>=70
and Student.sid = SC.sid
and SC.cid = Course.cid;
*/

#select * from SC where score < 60

/*
select a.Sid, a.Sname
from Student a 
join
(select * from SC where Cid = "01" and score >= 80) b
on a.Sid = b.Sid
*/

#select a.Cid, count(b.Sid) from Course a left join SC b on a.Cid = b.Cid group by a.Cid 

/*
select a.sid, a.cid, a.score from SC as a
left join SC as b
on a.cid = b.cid and a.score < b.score
group by a.cid, a.sid
having count(b.cid) < 2
order by a.cid
*/

#select Cid, count(Sid) from SC group by Cid having count(Sid) > 5

#select Sid, count(Cid) from SC group by Sid having count(Cid) >= 2


































