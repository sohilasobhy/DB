create database Amazon_clothing

create table Account(
AID int primary key,
email varchar(30)not null,
pass varchar(30) not null, 
firstname varchar(30) not null,
lastname varchar(30) not null,
countryname varchar(30) not null,
phone char(11))



create table Account_type(
A_type varchar(30) check (A_type in ('customer','seller','employee')),
AT_ID int foreign key references Account (AID),
primary key(A_type,AT_ID))

select * from orders
create table customer_account(
CID int primary key,
FOREIGN KEY (CID) REFERENCES Account (AID),
wallet_balacne  money,
wid int foreign key references whishlist (WID),
)

create table Customer_address(
CID int foreign key references customer_account (CID) ,
cust_address varchar(30),
primary key(CID, cust_address))


create table seller_account(
S_ID int primary key foreign key references Account (AID),
overall_rate int,
)
select * from seller_account

create table employee_account(
E_ID int primary key foreign key references Account (AID),
)

---2------
create table orders (
OID int primary key,
total_price money check (total_price>0) not null,
order_type text not null,
date datetime not null default(getdate()),
C_id int foreign key references customer_account (CID),
O_H_ID int foreign key references order_history (id),
) 

ALTER TABLE Orders
ADD orders_payment INT;

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_payment
FOREIGN KEY (orders_payment) REFERENCES  payment(payid);

ALTER TABLE Orders
ADD orders_shipment INT;

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_shipment
FOREIGN KEY (orders_shipment) REFERENCES  shipment(ship_id);


create table order_detail (
oid int foreign key references orders (OID),
pid int foreign key references product(PR_ID),
ordered_qty int not null default(1),
primary key (oid,pid)
)

create table order_history (
id int primary key,
)

create table returned_orders (
R_O_ID int primary key foreign key references orders (OID),
refund_amount money check (refund_amount>0) not null,
reason_of_return text,
status_of_return text,
status_of_refund text,
)

create table completed_orders (
C_O_ID int primary key foreign key references orders (OID),
shiping_date date,
)

--3------
create table store ( 
st_id int primary key,
s_name varchar(50) not null,
S_id int foreign key references seller_account (S_ID)
)

create table whishlist (
WID int primary key,
date_added date not null
)
select * from whishlist

create table whishlist_details (
wish_id int foreign key references whishlist (WID),
pid int foreign key references product (PR_ID),
primary key (wish_id, pid))

create table shopping_cart (
shop_id int primary key,
date_added date not null,
cust_id int foreign key references customer_account (CID) ,
)

create table warehouse (
ware_id int primary key,
warehouse_address varchar(50) not null,
quantity int not null,
quantity_added_date date not null,
)

-4---

create table shipment (
ship_id int primary key ,
Shipfees int CHECK(Shipfees > 0) not null  ,
Ship_Instructions varchar(100) not null ,
Ship_Address VARCHAR(100)  not null ,
Rate_of_shipping int CHECK(Rate_of_shipping >= 0 AND Rate_of_shipping <= 5),
shipId int foreign key references shipping_party (shipPartyId),
)


create table payment (
payid int primary key ,
payMethod varchar(50) not null,
DisOnMethod int null ,
PR_ID int foreign key references promo_code (promoid),   
)

create table invoice (
invid int primary key ,
invDate datetime default(getdate()) not null,
invTotal money check (invTotal>0) not null ,
INV_O_ID int foreign key references orders (OID),
)

create table shipping_party (
shipPartyId int primary key
)


create table promo_code (
promoid int primary key ,
PromoStartdate datetime default(getdate()) not null,
promoEnddate datetime not null ,
PromoMax int not null 
)
-5----
create table languages(
E_language varchar(50)  not null,
Eid int foreign key references employee_account (E_ID), 
primary key(E_language,Eid),
) 


create table feedback(
Rate int null check (rate >= 0 && rate <=5),
Comment varchar(100) null,
Date datetime null
default (getdate()),
product_ID int foreign key references product(PR_ID),
cust_ID int foreign key references customer_account(CID),
primary key (product_ID,cust_ID)
)


create table Question
(Question varchar(100) null,
cust_ID int foreign key references customer_account (CID),
product_ID int foreign key references product (PR_ID),
primary key (cust_ID,product_ID))


create table Skills(
Eskills varchar(70) not null,
EID int foreign key references Employee_account (E_ID),
primary key(Eskills,EID))



create table Rate 
(custrate  int null,
CID int foreign key references customer_account (CID),
S_ID int foreign key references seller_account (S_ID),
primary key(CID,S_ID))

--6---
create table Product(
PR_ID int primary key,
Name varchar(60) not null,
product_material varchar(50) not null ,
color varchar(50) not null,
Size varchar(5) not null,
price money check (price>0) not null,
img varchar(50) not null,
Description varchar(200) null,
Brand varchar(60) not null,
Discount varchar(10) null,
Store_ID int foreign key references Store(st_id),   
Cat_ID int foreign key references Category (catID),    
warehouse_ID int foreign key references warehouse(ware_id),
)

create table Returned_product(
RP_ID int primary key foreign key references Product (PR_ID),
)


create table Returned_details(
RD_ID int foreign key references Returned_product(RP_ID),
R_O_ID int foreign key references Returned_orders(R_O_ID),    
Quantity int not null,
primary key (RD_ID,R_O_ID) )

select * from Returned_product
select * from Returned_orders
select * from Returned_details
create table Category(
catID int primary key,
Catname varchar(50) not null,
) 


create table Sub_category(
subid int primary key,
subname varchar(50) not null,
Cat_ID int foreign key references Category(catID))



create table Cart_details(
PID int foreign key references Product(PR_ID),
Cart_ID  int foreign key references Shopping_cart(shop_id),
primary key (PID,Cart_ID ),
Quantity int not null)

select * from shopping_cart
 INSERT INTO Account (AID, email, pass, firstname, lastname, countryname, phone)
VALUES
  (1, 'john@gmail.com', 'J0hnDoe!', 'John', 'Doe', 'USA', '1234567890'),
  (2, 'jane@gmail.com', 'P@ssw0rd2', 'Jane', 'Smith', 'Canada', '9876543210'),
  (3, 'alex@gmail.com', 'Passw0rd!', 'Alex', 'Johnson', 'UK', '8765432109'),
  (4, 'sarah@gmail.com', 'S@rahDav1s', 'Sarah', 'Davis', 'Australia', '7654321098'),
  (5, 'michael@gmail.com', 'M1chaelW!', 'Michael', 'Wilson', 'USA', '6543210987'),
  (6, 'emily@gmail.com', 'Ems1234!', 'Emily', 'Taylor', 'Canada', '5432109876'),
  (7, 'david@gmail.com', 'Dav!dBr0wn', 'David', 'Brown', 'USA', '4321098765'),
  (8, 'olivia@gmail.com', 'Oliv1aLee!', 'Olivia', 'Lee', 'Canada', '3210987654'),
  (9, 'james@gmail.com', 'J@m3sGarc!a', 'James', 'Garcia', 'USA', '2109876543'),
  (10, 'emma@gmail.com', 'Emm@Martz', 'Emma', 'Martinez', 'Canada', '1098765432'),
  (11, 'william@gmail.com', 'W1llR0b!nson', 'William', 'Robinson', 'USA', '0987654321'),
  (12, 'mia@gmail.com', 'M!aLopez87', 'Mia', 'Lopez', 'Canada', '9876543210'),
  (13, 'ethan@gmail.com', '3thanHern@ndez', 'Ethan', 'Hernandez', 'USA', '8765432109'),
  (14, 'ava@gmail.com', 'AvaH!ll12', 'Ava', 'Hill', 'Canada', '7654321098'),
  (15, 'mason@gmail.com', 'MasonY0ung', 'Mason', 'Young', 'USA', '6543210987'),
  (16, 'chloe@gmail.com', 'Chloe@ll3n', 'Chloe', 'Allen', 'Canada', '5432109876'),
  (17, 'logan@gmail.com', 'LoganK1ng!', 'Logan', 'King', 'USA', '4321098765'),
  (18, 'mia@gmail.com', 'M!aSc0tt', 'Mia', 'Scott', 'Canada', '3210987654'),
  (19, 'jacob@gmail.com', 'J@c0bGr33n', 'Jacob', 'Green', 'USA', '2109876543'),
  (20, 'olivia@gmail.com', 'Ol!viaB@ker', 'Olivia', 'Baker', 'Canada', '1098765432'),
  (21, 'daniel@gmail.com', 'D@n!elAdams', 'Daniel', 'Adams', 'USA', '0987654321'),
  (22, 'sophia@gmail.com', 'S0ph!aM1tch', 'Sophia', 'Mitchell', 'Canada', '9876543210'),
  (23, 'jackson@gmail.com', 'J@cksonCl@rk', 'Jackson', 'Clark', 'USA', '8765432109'),
  (24, 'ava@gmail.com', 'Av@H!ll23', 'Ava', 'Hill', 'Canada', '7654321098'),
  (25, 'ethan@gmail.com', 'Eth@nY0ung', 'Ethan', 'Young', 'USA', '6543210987'),
  (26, 'sophia@gmail.com', 'S0ph!aM0rr1s', 'Sophia', 'Morris', 'Canada', '5432109876'),
  (27, 'noah@gmail.com', 'N0@hC00per', 'Noah', 'Cooper', 'USA', '4321098765'),
  (28, 'mia@gmail.com', 'M!aB3nn3tt', 'Mia', 'Bennett', 'Canada', '3210987654'),
  (29, 'james@gmail.com', 'J@mesH0ward', 'James', 'Howard', 'USA', '2109876543'),
  (30, 'emma@gmail.com', 'Emm@Gr@y22', 'Emma', 'Gray', 'Canada', '1098765432'),
  (31, 'william@gmail.com', 'W1llReed', 'William', 'Reed', 'USA', '0987654321'),
  (32, 'lily@gmail.com', 'L1lyW@rd', 'Lily', 'Ward', 'Canada', '9876543210'),
  (33, 'owen@gmail.com', '0wenB3ll', 'Owen', 'Bell', 'USA', '8765432109'),
  (34, 'harper@gmail.com', 'H@rperC0x', 'Harper', 'Cox', 'Canada', '7654321098'),
  (35, 'lucas@gmail.com', 'Lucus123!', 'Lucas', 'Thompson', 'USA', '6543210987'),
  (36, 'olivia@gmail.com', 'Ol!v14And3rson', 'Olivia', 'Anderson', 'Canada', '5432109876'),
  (37, 'noah@gmail.com', 'N0ahM00re', 'Noah', 'Moore', 'USA', '4321098765'),
  (38, 'ava@gmail.com', 'Av@Cl@rk', 'Ava', 'Clark', 'Australia', '3210987654'),
  (39, 'william@gmail.com', 'W!llWalk3r', 'William', 'Walker', 'USA', '2109876543'),
  (40, 'mia@gmail.com', 'M!aTurner', 'Mia', 'Turner', 'Canada', '1098765432');

  select * from product

  INSERT INTO Account_type (A_type, AT_ID)
VALUES
  ('customer', 1),
  ('customer', 2),
  ('customer', 3),
  ('seller', 4),
  ('seller', 5),
  ('customer', 6),
  ('customer', 7),
  ('employee', 8),
  ('employee', 9),
  ('customer', 10),
  ('customer', 11),
  ('customer', 12),
  ('seller', 13),
  ('seller', 14),
  ('customer', 15),
  ('customer', 16),
  ('employee', 17),
  ('customer', 18),
  ('customer', 19),
  ('customer', 20),
  ('seller', 21),
  ('seller', 22),
  ('customer', 23),
  ('customer', 24),
  ('employee', 25),
  ('customer', 26),
  ('customer', 27),
  ('customer', 28),
  ('seller', 29),
  ('seller', 30),
  ('customer', 31),
  ('customer', 32),
  ('employee', 33),
  ('customer', 34),
  ('customer', 35),
  ('customer', 36),
  ('seller', 37),
  ('seller', 38),
  ('customer', 39),
  ('customer', 40);
  
  INSERT INTO customer_account (CID, wallet_balacne, wid)
VALUES
  (1, 0, 1),
  (2, 250.00, 2),
  (3, 1000.00, 3),
  (6, 600.00, 6),
  (7, 0, 7),
  (10, 350.00, 10),
  (11, 450.00, 11),
  (12, 0, 12),
  (15, 150.00, 15),
  (16, 0, 16),
  (19, 500.00, 19),
  (20, 0, 20),
  (23, 0, 23),
  (24, 0, 24),
  (26, 0, 26),
  (28, 150.00, 28),
  (31, 0, 31),
  (32, 500.00, 32),
  (34, 350.00, 34),
  (35, 0, 35),
  (36, 0, 36),
  (39, 550.00, 39 ),
  (40, 0, 40);

  INSERT INTO whishlist (WID, date_added)
VALUES
  (1, '2023-05-01'),
  (2, '2023-05-02'),
  (3, '2023-05-03'),
  (6, '2023-05-06'),
  (7, '2023-05-07'),
  (10, '2023-05-10'),
  (11, '2023-05-11'),
  (12, '2023-05-12'),
  (15, '2023-05-15'),
  (16, '2022-6-05'),
  (19, '2022-6-28'),
  (20, '2023-05-20'),
  (23, '2023-05-23'),
  (24, '2023-05-24'),
  (26, '2023-05-26'),
  (28, '2023-05-28'),
  (31, '2023-05-31'),
  (32, '2023-06-01'),
  (34, '2023-06-03'),
  (35, '2023-06-04'),
  (36, '2023-06-05'),
  (39, '2023-05-10'),
  (40, '2023-05-24');

  INSERT INTO Customer_address (CID, cust_address)
VALUES
  (1, '123 Main Street'),
  (2, '456 Elm Avenue'),
  (3, '789 Oak Drive'),
  (6, '987 Cedar Court'),
  (7, '135 Walnut Circle'),
  (10, '579 Willow Lane'),
  (11, '802 Ash Road'),
  (12, '413 Oakwood Drive'),
  (15, '528 Pinehurst Court'),
  (16, '365 Maplewood Avenue'),
  (19, '683 Birchwood Avenue'),
  (20, '932 Spruce Lane'),
  (23, '745 Birch Hill Drive'),
  (24, '493 Magnolia Road'),
  (26, '132 Oakridge Drive'),
  (28, '902 Cedar Avenue'),
  (31, '930 Willowbrook Road'),
  (32, '376 Oakdale Avenue'),
  (34, '539 Spruce Lane'),
  (35, '176 Hemlock Court'),
  (36, '612 Sycamore Drive'),
  (39, '723 Chestnut Lane'),
  (40, '269 Oakridge Road');

  INSERT INTO seller_account (S_ID, overall_rate)
VALUES
  (4, 5),
  (5, 3),
  (13, 3),
  (14, 4),
  (21, 4),
  (22, 5),
   (28, 3),
  (29, 4),
  (30, 5),
  (37,3),
  (38,5);

  INSERT INTO employee_account (E_ID)
VALUES
  (8),
  (9),
  (17),
  (25),
  (33);

  INSERT INTO orders (OID, total_price, order_type, date, C_id, O_H_ID)
VALUES
  (1, 50.00, 'completed', GETDATE(), 1, 1),
  (2, 75.50, 'completed', GETDATE(), 2, 2),
  (3, 30.00, 'not yet dispatched', GETDATE(), 3, 3),
  (6, 20.25, 'not yet dispatched', GETDATE(), 6, 6),
  (7, 38.90, 'completed', GETDATE(), 7, 7),
  (10, 42.25, 'not yet dispatched', GETDATE(), 10, 10),
  (11, 68.75, 'returned', GETDATE(), 11, 11),
  (12, 25.80, 'completed', GETDATE(), 12, 12),
  (15, 45.50, 'not yet dispatched', GETDATE(), 15, 15),
  (16, 62.25, 'completed', GETDATE(), 16, 16),
  (19, 57.90, 'returned', GETDATE(), 19, 19),
  (20, 95.00, 'completed', GETDATE(), 20, 20),
    (23, 30.00, 'not yet dispatched', GETDATE(), 23, 23),
  (24, 45.75, 'completed', GETDATE(), 24, 24),
   (26, 20.25, 'not yet dispatched', GETDATE(), 26, 26),
  (28, 80.00, 'not yet dispatched', GETDATE(), 28, 28),
  (31, 68.75, 'returned', GETDATE(), 31, 31),
  (32, 25.80, 'completed', GETDATE(), 32, 32),
  (34, 90.00, 'not yet dispatched', GETDATE(), 34, 34),
  (35, 45.50, 'not yet dispatched', GETDATE(), 35, 35),
  (36, 62.25, 'completed', GETDATE(), 36, 36),
  (39, 57.90, 'returned', GETDATE(), 39, 39),
  (40, 95.00, 'completed', GETDATE(), 40, 40),
  (41, 150.00, 'completed','2023-01-01' , 20, 41),
  (42, 234.00, 'completed', '2022-09-05', 26, 42),
  (43, 305.00, 'completed', '2022-08-30', 7, 43),
  (44, 75.00, 'completed', '2022-12-30', 1, 44);

  INSERT INTO order_history (id)
VALUES
  (1),
  (2),
  (3),
  (6),
  (7),
  (10),
  (11),
  (12),
  (15),
  (16),
  (19),
  (20),
  (23),
  (24),
  (26),
  (28),
  (31),
  (32),
  (34),
  (35),
  (36),
  (39),
  (40),
  (41),
  (42),
  (43),
  (44);

select * from order_history


INSERT INTO store (st_id, s_name, S_id)
VALUES
  (4, 'Beauty Boutique', 4),
  (5, 'Gourmet Delights', 5),
  (13, 'Outdoor Adventures', 13),
  (14, 'Health Emporium', 14),
  (21, 'Gadget Zone', 21),
  (22, 'Luxury Living', 22),
  (28, 'Gaming Paradise', 28),
  (29, 'Baby Bliss', 29),
  (30, 'Fashion Forward', 30),
  (37, 'Gourmet Delights', 37),
  (38, 'Fashion Trends', 38);

  INSERT INTO warehouse (ware_id, warehouse_address, quantity, quantity_added_date)
VALUES
  (1, '567 Birch Avenue', 100, '2023-01-01'),
  (2, '567 Birch Avenue', 200, '2023-02-15'),
  (3, '567 Birch Avenue', 150, '2023-03-10'),
  (4, '567 Birch Avenue', 120, '2023-04-05'),
  (5, '567 Birch Avenue', 180, '2023-05-20'),
  (6, '567 Birch Avenue', 90, '2023-06-15'),
  (7, '567 Birch Avenue', 250, '2023-07-01'),
  (8, '567 Birch Avenue', 140, '2023-08-10'),
  (9, '567 Birch Avenue', 170, '2023-09-05'),
  (10, '567 Birch Avenue', 220, '2023-10-20'),
  (11, '567 Birch Avenue', 130, '2023-11-15'),
  (12, '567 Birch Avenue', 190, '2023-12-01'),
  (13, '567 Birch Avenue', 80, '2024-01-10'),
  (14, '567 Birch Avenue', 230, '2024-02-05'),
  (15, '567 Birch Avenue', 160, '2024-03-20'),
  (16, '567 Birch Avenue', 210, '2024-04-15'),
  (17, '567 Birch Avenue', 100, '2024-05-01'),
  (18, '567 Birch Avenue', 250, '2024-06-10'),
  (19, '567 Birch Avenue', 140, '2024-07-05'),
  (20, '567 Birch Avenue', 180, '2024-08-20'),
  (21, '567 Birch Avenue', 90, '2024-09-15'),
  (22, '567 Birch Avenue', 260, '2024-10-01'),
  (23, '567 Birch Avenue', 150, '2024-11-10'),
  (24, '567 Birch Avenue', 200, '2024-12-05'),
  (25, '567 Birch Avenue', 120, '2025-01-20'),
  (26, '567 Birch Avenue', 170, '2025-02-15'),
  (27, '567 Birch Avenue', 110, '2025-03-01'),
  (28, '567 Birch Avenue', 240, '2025-04-10'),
  (29, '567 Birch Avenue', 130, '2025-05-05'),
  (30, '567 Birch Avenue', 190, '2025-06-20'),
  (31, '567 Birch Avenue', 80, '2025-07-15'),
  (32, '567 Birch Avenue', 230, '2025-08-01'),
  (33, '567 Birch Avenue', 160, '2025-09-10'),
  (34, '567 Birch Avenue', 210, '2025-10-05'),
  (35, '567 Birch Avenue', 100, '2025-11-20'),
  (36, '567 Birch Avenue', 250, '2025-12-15'),
  (37, '123 Walnut Street', 140, '2026-01-01'),
  (38, '567 Birch Avenue', 180, '2026-02-10'),
  (39, '567 Birch Avenue', 90, '2026-03-05'),
  (40, '567 Birch Avenue', 220, '2026-04-20');

  INSERT INTO Category (catID, Catname)
VALUES
  (1, 'men'),
  (2, 'women'),
  (3, 'kids'),
  (4, 'women'),
  (5, 'men'),
  (6, 'kids'),
  (7, 'men'),
  (8, 'women'),
  (9, 'kids'),
  (10, 'men'),
  (11, 'women'),
  (12, 'kids'),
  (13, 'men'),
  (14, 'women'),
  (15, 'kids'),
  (16, 'men'),
  (17, 'women'),
  (18, 'kids'),
  (19, 'men'),
  (20, 'women'),
  (21, 'kids'),
  (22, 'men'),
  (23, 'women'),
  (24, 'kids'),
  (25, 'men'),
  (26, 'women'),
  (27, 'kids'),
  (28, 'men'),
  (29, 'women'),
  (30, 'kids'),
  (31, 'men'),
  (32, 'women'),
  (33, 'kids'),
  (34, 'men'),
  (35, 'women'),
  (36, 'kids'),
  (37, 'men'),
  (38, 'women'),
  (39, 'kids'),
  (40, 'men');

  INSERT INTO Product (PR_ID, Name, product_material, color, Size, price, img, Description, Brand, Discount, Store_ID, Cat_ID, warehouse_ID)
VALUES
  (1, 'T-Shirt', 'Cotton', 'Red', 'M', 19.99, 'tshirt1.jpg', 'Classic red T-shirt', 'Fashion Avenue', NULL, 4, 1, 1),
  (2, 'Jeans', 'Denim', 'Blue', 'S', 49.99, 'jeans1.jpg', 'Slim-fit denim jeans', 'Everyday Styles', '20% off', 5, 2, 1),
  (3, 'Dress', 'Polyester', 'Black', 'L', 59.99, 'dress1.jpg', 'Elegant black dress', 'Chic Boutique', NULL, 4, 3, 1),
  (4, 'Shirt', 'Cotton', 'White', 'L', 29.99, 'shirt1.jpg', 'Classic white shirt', 'Fashion Avenue', NULL, 13, 1, 2),
  (5, 'Skirt', 'Chiffon', 'Pink', 'S', 39.99, 'skirt1.jpg', 'Flowy pink skirt', 'Glamorous Trends', '10% off', 14, 2, 2),
  (6, 'Jacket', 'Leather', 'Brown', 'M', 79.99, 'jacket1.jpg', 'Stylish brown leather jacket', 'Urban Outfit', NULL, 21, 3, 2),
  (7, 'Sweatshirt', 'Cotton', 'Gray', 'XL', 34.99, 'sweatshirt1.jpg', 'Comfortable gray sweatshirt', 'Cozy Knits', '15% off', 22, 1, 3),
  (8, 'Shorts', 'Denim', 'Black', 'M', 24.99, 'shorts1.jpg', 'Casual black denim shorts', 'Everyday Styles', NULL, 28, 2, 3),
  (9, 'Blouse', 'Silk', 'White', 'S', 49.99, 'blouse1.jpg', 'Elegant white silk blouse', 'Chic Boutique', NULL, 29, 3, 3),
  (10, 'Trousers', 'Polyester', 'Navy Blue', 'L', 39.99, 'trousers1.jpg', 'Formal navy blue trousers', 'Fashion Avenue', '10% off', 30, 1, 4),
  (11, 'Sweater', 'Wool', 'Gray', 'M', 59.99, 'sweater1.jpg', 'Warm gray wool sweater', 'Cozy Knits', NULL, 37, 2, 4),
  (12, 'Blazer', 'Cotton', 'Black', 'L', 69.99, 'blazer1.jpg', 'Stylish black cotton blazer', 'Urban Outfit', '20% off', 38, 3, 4),
  (13, 'Top', 'Chiffon', 'Yellow', 'S', 29.99, 'top1.jpg', 'Bright yellow chiffon top', 'Glamorous Trends', NULL, 13, 1, 5),
  (14, 'Shorts', 'Cotton', 'Beige', 'XL', 24.99, 'shorts1.jpg', 'Comfortable beige shorts', 'Everyday Styles', '15% off', 28, 2, 5),
  (15, 'Dress', 'Polyester', 'Red', 'M', 49.99, 'dress1.jpg', 'Classic red party dress', 'Chic Boutique', NULL, 21, 3, 5),
  (16, 'Shirt', 'Cotton', 'Blue', 'L', 29.99, 'shirt1.jpg', 'Casual blue shirt', 'Fashion Avenue', NULL, 5, 1, 6),
  (17, 'Skirt', 'Denim', 'Black', 'S', 39.99, 'skirt1.jpg', 'Stylish black denim skirt', 'Glamorous Trends', '10% off', 38, 2, 6),
  (18, 'Jacket', 'Leather', 'Brown', 'M', 79.99, 'jacket1.jpg', 'Brown leather jacket with fur collar', 'Urban Outfit', NULL, 4, 3, 6),
  (19, 'Sweatshirt', 'Cotton', 'Gray', 'XL', 34.99, 'sweatshirt1.jpg', 'Comfortable gray sweatshirt', 'Cozy Knits', '20% off', 30, 1, 7),
  (20, 'Shorts', 'Denim', 'Light Blue', 'M', 24.99, 'shorts1.jpg', 'Light blue denim shorts', 'Everyday Styles', NULL, 29, 2, 7),
  (21, 'Blouse', 'Silk', 'Pink', 'S', 49.99, 'blouse1.jpg', 'Elegant pink silk blouse', 'Chic Boutique', NULL, 30, 3, 7),
  (22, 'Trousers', 'Polyester', 'Black', 'L', 39.99, 'trousers1.jpg', 'Formal black trousers', 'Fashion Avenue', '10% off', 5, 1, 8),
  (23, 'Sweater', 'Wool', 'Gray', 'M', 59.99, 'sweater1.jpg', 'Warm gray wool sweater', 'Cozy Knits', NULL, 21, 2, 8),
  (24, 'Blazer', 'Cotton', 'Navy Blue', 'L', 69.99, 'blazer1.jpg', 'Stylish navy blue cotton blazer', 'Urban Outfit', '15% off', 4, 3, 8),
  (25, 'Top', 'Chiffon', 'Purple', 'S', 29.99, 'top1.jpg', 'Pretty purple chiffon top', 'Glamorous Trends', NULL, 30, 1, 9),
  (26, 'Shorts', 'Cotton', 'Gray', 'XL', 24.99, 'shorts1.jpg', 'Casual gray shorts', 'Everyday Styles', '10% off', 22, 2, 9),
  (27, 'Dress', 'Polyester', 'Black', 'M', 49.99, 'dress1.jpg', 'Black party dress with lace details', 'Chic Boutique', NULL, 30, 3, 9),
  (28, 'Shirt', 'Cotton', 'White', 'L', 29.99, 'shirt1.jpg', 'Classic white shirt', 'Fashion Avenue', NULL, 4, 1, 10),
  (29, 'Skirt', 'Denim', 'Blue', 'S', 39.99, 'skirt1.jpg', 'Blue denim skirt with button-front', 'Glamorous Trends', '20% off', 5, 2, 10),
  (30, 'Jacket', 'Leather', 'Black', 'M', 79.99, 'jacket1.jpg', 'Stylish black leather jacket', 'Urban Outfit', NULL, 21, 3, 10),
  (31, 'Sweatshirt', 'Cotton', 'Gray', 'XL', 34.99, 'sweatshirt1.jpg', 'Cozy gray sweatshirt with hood', 'Cozy Knits', '10% off', 14, 1, 11),
  (32, 'Shorts', 'Denim', 'Light Blue', 'M', 24.99, 'shorts1.jpg', 'Light blue denim shorts', 'Everyday Styles', NULL, 13, 2, 11),
  (33, 'Blouse', 'Silk', 'White', 'S', 49.99, 'blouse1.jpg', 'White silk blouse with lace trim', 'Chic Boutique', NULL, 13, 3, 11),
  (34, 'Trousers', 'Polyester', 'Gray', 'L', 39.99, 'trousers1.jpg', 'Classic gray trousers', 'Fashion Avenue', '15% off', 37, 1, 12),
  (35, 'Sweater', 'Wool', 'Brown', 'M', 59.99, 'sweater1.jpg', 'Warm brown wool sweater', 'Cozy Knits', NULL, 4, 2, 12),
  (36, 'Blazer', 'Cotton', 'Black', 'L', 69.99, 'blazer1.jpg', 'Black cotton blazer with gold buttons', 'Urban Outfit', '10% off', 21, 3, 12),
  (37, 'Top', 'Chiffon', 'Pink', 'S', 29.99, 'top1.jpg', 'Pretty pink chiffon top', 'Glamorous Trends', NULL, 4, 1, 13),
  (38, 'Shorts', 'Cotton', 'Beige', 'XL', 24.99, 'shorts1.jpg', 'Casual beige shorts', 'Everyday Styles', '20% off', 13, 2, 13),
  (39, 'Dress', 'Polyester', 'Red', 'M', 49.99, 'dress1.jpg', 'Red party dress with floral print', 'Chic Boutique', NULL, 37, 3, 13),
  (40, 'Shirt', 'Cotton', 'Blue', 'L', 29.99, 'shirt1.jpg', 'Classic blue shirt', 'Fashion Avenue', NULL, 21, 1, 14);

  INSERT INTO order_detail (oid, pid, ordered_qty)
VALUES
  (1, 1, 2),
  (1, 2, 3),
  (2, 3, 2),
  (2, 4, 4),
  (3, 5, 3),
  (3, 6, 1),
  (12, 7, 2),
  (12, 8, 5),
  (15, 9, 4),
  (15, 10, 2),
  (6, 11, 3),
  (6, 12, 1),
  (7, 13, 2),
  (7, 14, 3),
  (11, 15, 4),
  (12, 16, 2),
  (15, 17, 3),
  (16, 18, 4),
  (19, 19, 2),
  (10, 20, 3),
  (11, 21, 4),
  (11, 22, 1),
  (12, 23, 3),
  (12, 24, 5),
  (15, 25, 4),
  (15, 26, 2),
  (16, 27, 3),
  (16, 28, 1),
  (15, 29, 2),
  (15, 30, 3),
  (16, 31, 4),
  (16, 32, 2),
  (23, 33, 3),
  (23, 34, 4),
  (24, 35, 2),
  (24, 36, 3),
  (19, 37, 4),
  (19, 38, 1),
  (26, 39, 3),
  (26, 40, 5);

  INSERT INTO returned_orders (R_O_ID, refund_amount, reason_of_return, status_of_return, status_of_refund)
VALUES
  (11, 50.00, 'Wrong size', 'Returned', 'Refunded'),
  (19, 75.50, 'Defective item', 'not yet returned', 'not yet refunded'),
  (31, 120.00, 'Item not as described', 'Returned', 'Refunded'),
  (39, 95.00, 'Changed my mind', 'not yet returned', 'not yet refunded');

  INSERT INTO completed_orders (C_O_ID, shiping_date)
VALUES
  (1, '2023-05-01'),
  (2, '2023-05-02'),
  (7, '2023-05-03'),
  (12, '2023-05-04'),
  (16, '2023-05-05'),
  (20, '2023-05-06'),
  (24, '2023-05-07'),
  (32, '2023-05-08'),
  (36, '2023-05-09'),
  (39, '2023-05-10'),
  (40, '2023-05-11');

  INSERT INTO whishlist_details (wish_id, pid)
VALUES 
  (1, 1),
  (2, 3),
  (3, 5),
  (6, 2),
  (6, 4),
  (10, 6),
  (10, 7),
  (7, 9),
  (7, 11),
  (11, 8),
  (12, 10),
  (15, 12),
  (16, 13),
  (19, 15),
  (20, 17),
  (23, 14),
  (24, 16),
  (26, 18),
  (28, 19),
  (31, 21),
  (32, 23),
  (34, 20),
  (35, 22),
  (36, 24),
  (39, 25),
  (40, 27),
  (12, 29),
  (28, 26),
  (11, 28),
  (11, 30),
  (11, 31),
  (11, 33),
  (11, 35),
  (16, 32),
  (16, 34),
  (16, 36),
  (3, 37),
  (3, 39),
  (3, 40),
  (15, 38),
  (15, 1),
  (15, 2);

  INSERT INTO shopping_cart (shop_id, date_added, cust_id)
VALUES 
  (1, '2023-05-23', 1),
  (2, '2023-05-23', 2),
  (3, '2023-05-23', 3),
  (4, '2023-05-23', 6),
  (5, '2023-05-23', 7),
  (6, '2023-05-23', 10),
  (7, '2023-05-23', 11),
  (8, '2023-05-23', 12),
  (9, '2023-05-23', 15),
  (10, '2023-05-23', 16),
  (11, '2023-05-23', 19),
  (12, '2023-05-23', 20),
  (13, '2023-05-23', 23),
  (14, '2023-05-23', 24),
  (15, '2023-05-23', 26),
  (16, '2023-05-23', 28),
  (17, '2023-05-23', 31),
  (18, '2023-05-23', 32),
  (19, '2023-05-23', 34),
  (20, '2023-05-23', 35),
  (21, '2023-05-23', 36),
  (22, '2023-05-23', 39),
  (23, '2023-05-23', 40);

  INSERT INTO shipping_party (shipPartyId) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);

INSERT INTO shipment (ship_id, Shipfees, Ship_Instructions, Ship_Address, Rate_of_shipping, shipId)
VALUES
  (1, 50, 'Handle with care', '123 ABC Street, Cairo', 4, 1),
  (2, 30, 'Priority shipment', '456 XYZ Street, Alexandria', 3, 2),
  (3, 20, 'Fast delivery required', '789 DEF Street, Giza', 5, 3),
  (4, 40, 'Deliver during business hours', '321 MNO Street, Luxor', 4, 4),
  (5, 25, 'Delivery confirmation needed', '654 PQR Street, Aswan', 2, 5),
  (6, 35, 'Priority shipment', '987 STU Street, Sharm El Sheikh', 3, 6),
  (7, 50, 'Priority shipment', '159 VWX Street, Hurghada', 4, 7),
  (8, 30, 'Handle with gloves', '753 YZA Street, Marsa Alam', 2, 8),
  (9, 20, 'Priority shipment', '852 BCD Street, Dahab', 1, 9),
  (10, 40, 'Priority shipment', '369 EFG Street, Nuweiba', 5, 10),
  (11, 25, 'Deliver to back entrance', '246 HIJ Street, Tanta', 3, 11),
  (12, 35, 'Deliver to back entrance', '468 KLM Street, Mansoura', 4, 12),
  (13, 50, 'Handle with care', '753 NOP Street, Damietta', 4, 13),
  (14, 30, 'Deliver to back entrance', '951 QRS Street, Sohag', 2, 14),
  (15, 20, 'Secure packaging required', '357 TUV Street, Luxor', 3, 15),
  (16, 40, 'Deliver during weekends', '864 WXY Street, Aswan', 4, 16),
  (17, 25, 'Delivery to front desk', '369 ZAB Street, Alexandria', 1, 17),
  (18, 35, 'Deliver to back entrance', '753 CDE Street, Cairo', 3, 18),
  (19, 50, 'Deliver to back entrance', '951 FGH Street, Giza', 4, 19),
  (20, 30, 'Handle with care', '753 IJK Street, Alexandria', 2, 20),
  (21, 20, 'Fast delivery required', '246 LMN Street, Cairo', 5, 21),
  (22, 40, 'Deliver to room 207', '468 OPQ Street, Luxor', 4, 22),
  (23, 25, 'Delivery confirmation needed', '852 RST Street, Aswan', 3, 23),
  (24, 35, 'Handle with gloves', '357 UVW Street, Alexandria', 2, 24),
  (25, 50, 'Deliver to back entrance', '753 WXY Street, Cairo', 4, 25),
  (26, 30, 'Deliver to back entrance', '951 ZAB Street, Giza', 3, 26),
  (27, 20, 'Handle with care', '753 CDE Street, Alexandria', 5, 27),
  (28, 40, 'Deliver to back entrance', '246 EFG Street, Luxor', 5, 28),
  (29, 25, 'Priority shipment', '468 HIJ Street, Aswan', 3, 29),
  (30, 35, 'Deliver to back entrance', '852 KLM Street, Alexandria', 4, 30),
  (31, 50, 'Deliver to back entrance', '753 NOP Street, Cairo', 4, 31),
  (32, 30, 'Handle with care', '951 QRS Street, Giza', 2, 32),
  (33, 20, 'Deliver to back entrance', '357 TUV Street, Alexandria', 3, 33),
  (34, 40, 'Secure packaging required', '753 WXY Street, Cairo', 4, 34),
  (35, 25, 'Deliver during weekends', '951 ZAB Street, Giza', 1, 35),
  (36, 35, 'Delivery to front desk', '357 CDE Street, Alexandria', 3, 36),
  (37, 50, 'Deliver to back entrance', '753 EFG Street, Cairo', 4, 37),
  (38, 30, 'Deliver to back entrance', '951 HIJ Street, Giza', 2, 38),
  (39, 20, 'Handle with care', '357 KLM Street, Alexandria', 5, 39),
  (40, 40, 'Fast delivery required', '753 NOP Street, Cairo', 4, 40);

  INSERT INTO promo_code (promoid, PromoStartdate, promoEnddate, PromoMax)
VALUES
  (1, '2023-05-23', '2023-06-30', 100),
  (2, '2023-05-23', '2023-07-15', 50),
  (3, '2023-05-23', '2023-08-31', 200),
  (4, '2023-05-23', '2023-09-30', 150),
  (5, '2023-05-23', '2023-10-15', 75),
  (6, '2023-05-23', '2023-11-30', 300),
  (7, '2023-05-23', '2023-12-31', 250),
  (8, '2023-05-23', '2024-01-15', 125),
  (9, '2023-05-23', '2024-02-29', 400),
  (10, '2023-05-23', '2024-03-31', 350),
  (11, '2023-05-23', '2024-04-15', 175),
  (12, '2023-05-23', '2024-05-31', 500),
  (13, '2023-05-23', '2024-06-30', 450),
  (14, '2023-05-23', '2024-07-15', 225),
  (15, '2023-05-23', '2024-08-31', 600),
  (16, '2023-05-23', '2024-09-30', 550),
  (17, '2023-05-23', '2024-10-15', 275),
  (18, '2023-05-23', '2024-11-30', 700),
  (19, '2023-05-23', '2024-12-31', 650),
  (20, '2023-05-23', '2025-01-15', 325),
  (21, '2023-05-23', '2025-02-28', 800),
  (22, '2023-05-23', '2025-03-31', 750),
  (23, '2023-05-23', '2025-04-15', 375),
  (24, '2023-05-23', '2025-05-31', 900),
  (25, '2023-05-23', '2025-06-30', 850),
  (26, '2023-05-23', '2025-07-15', 425),
  (27, '2023-05-23', '2025-08-31', 1000),
  (28, '2023-05-23', '2025-09-30', 950),
  (29, '2023-05-23', '2025-10-15', 475),
  (30, '2023-05-23', '2025-11-30', 1200),
  (31, '2023-05-23', '2025-12-31', 1150),
  (32, '2023-05-23', '2026-01-15', 575),
  (33, '2023-05-23', '2026-02-28', 1400),
  (34, '2023-05-23', '2026-03-31', 1350),
  (35, '2023-05-23', '2026-04-15', 675),
  (36, '2023-05-23', '2026-05-31', 1600),
  (37, '2023-05-23', '2026-06-30', 1550),
  (38, '2023-05-23', '2026-07-15', 775),
  (39, '2023-05-23', '2026-08-31', 1800),
  (40, '2023-05-23', '2026-09-30', 1750);

  INSERT INTO payment (payid, payMethod, DisOnMethod, PR_ID) VALUES
(1, 'Credit Card', NULL, 1),
(2, 'PayPal', 10, 2),
(3, 'Debit Card', NULL, 3),
(4, 'Cash On Delivery', NULL, NULL),
(5, 'Google Pay', 5, 5),
(6, 'Bank Transfer', NULL, NULL),
(7, 'Apple Pay', 15, 7),
(8, 'Stripe', NULL, 8),
(9, 'Venmo', NULL, NULL),
(10, 'Gift Card', 20, 10),
(11, 'Credit Card', NULL, NULL),
(12, 'PayPal', 10, 12),
(13, 'Debit Card', NULL, 13),
(14, 'Cash On Delivery', NULL, 14),
(15, 'Google Pay', 5, 15),
(16, 'Bank Transfer', NULL, NULL),
(17, 'Apple Pay', 15, 17),
(18, 'Stripe', NULL, 18),
(19, 'Venmo', NULL, NULL),
(20, 'Gift Card', 20, 20),
(21, 'Credit Card', NULL, 21),
(22, 'PayPal', 10, 22),
(23, 'Debit Card', NULL, 23),
(24, 'Cash On Delivery', NULL, 24),
(25, 'Google Pay', 5, 25),
(26, 'Bank Transfer', NULL, NULL),
(27, 'Apple Pay', 15, 27),
(28, 'Stripe', NULL, 28),
(29, 'Venmo', NULL, NULL),
(30, 'Gift Card', 20, 30),
(31, 'Credit Card', NULL, 31),
(32, 'PayPal', 10, 32),
(33, 'Debit Card', NULL, 33),
(34, 'Cash On Delivery', NULL, 34),
(35, 'Google Pay', 5, 35),
(36, 'Bank Transfer', NULL, NULL),
(37, 'Apple Pay', 15, 37),
(38, 'Stripe', NULL, 38),
(39, 'Venmo', NULL, NULL),
(40, 'Gift Card', 20, 40);

INSERT INTO invoice (invid, invDate, invTotal, INV_O_ID) VALUES
(1, GETDATE(), 100.00, 1),
(2, GETDATE(), 75.50, 2),
(3, GETDATE(), 50.00, 3),
(4, GETDATE(), 120.25, 6),
(5, GETDATE(), 80.80, 7),
(6, GETDATE(), 95.75, 10),
(7, GETDATE(), 60.50, 11),
(8, GETDATE(), 110.00, 12),
(9, GETDATE(), 45.25, 15),
(10, GETDATE(), 70.00, 16),
(11, GETDATE(), 105.50, 19),
(12, GETDATE(), 88.75, 20),
(13, GETDATE(), 60.25, 23),
(14, GETDATE(), 92.80, 24),
(15, GETDATE(), 75.50, 26),
(16, GETDATE(), 40.00, 28),
(17, GETDATE(), 115.25, 31),
(18, GETDATE(), 80.80, 32),
(19, GETDATE(), 95.75, 34),
(20, GETDATE(), 50.50, 35),
(21, GETDATE(), 90.00, 36),
(22, GETDATE(), 55.25, 39),
(23, GETDATE(), 100.50, 40);

INSERT INTO languages (E_language, Eid) VALUES
('English', 8),
('Arabic', 8),
('English', 9),
('Spanish', 9),
('English', 17),
('French', 17),
('Arabic', 17),
('German', 33),
('Italian', 25);

INSERT INTO feedback (Rate, Comment, Date, product_ID, cust_ID) VALUES
(4, 'Great product!', '2023-05-23', 1, 1),
(5, 'Excellent service!', '2023-05-23', 2, 2),
(3, 'Average quality.', '2023-05-23', 3, 3),
(2, 'Needs improvement.', '2023-05-23', 4, 6),
(4, 'Satisfied with the purchase.', '2023-05-23', 5, 7),
(5, 'Highly recommended!', '2023-05-23', 6, 10),
(1, 'Poor customer support.', '2023-05-23', 7, 11),
(3, 'Decent product for the price.', '2023-05-23', 8, 12),
(5, 'Fast shipping!', '2023-05-23', 9, 15),
(4, 'Good value for money.', '2023-05-23', 10, 16),
(2, 'Not as described.', '2023-05-23', 11, 19),
(4, 'Prompt delivery.', '2023-05-23', 12, 20),
(5, 'Love the product!', '2023-05-23', 13, 23),
(3, 'Could be better.', '2023-05-23', 14, 24),
(4, 'Nice packaging.', '2023-05-23', 15, 26),
(5, 'Great customer service!', '2023-05-23', 16, 28),
(2, 'Disappointed with the quality.', '2023-05-23', 17, 31),
(4, 'Good experience overall.', '2023-05-23', 18, 32),
(5, 'Impressed with the product.', '2023-05-23', 19, 34),
(3, 'Average customer support.', '2023-05-23', 20, 35),
(4, 'Recommended seller.', '2023-05-23', 21, 36),
(5, 'Happy with my purchase!', '2023-05-23', 22, 39),
(2, 'Not worth the price.', '2023-05-23', 23, 40),
(4, 'Good quality item.', '2023-05-23', 24, 1),
(5, 'Outstanding service!', '2023-05-23', 25, 2),
(3, 'Average product.', '2023-05-23', 26, 3),
(2, 'Needs improvement.', '2023-05-23', 27, 6),
(4, 'Satisfied customer.', '2023-05-23', 28, 7),
(5, 'Highly satisfied!', '2023-05-23', 29, 10),
(1, 'Terrible experience.', '2023-05-23', 30, 11);

INSERT INTO Question (Question, cust_ID, product_ID) VALUES
  ('What is the material used for this product?', 1, 1),
  ('Does this product come with a warranty?', 2, 2),
  ('What are the available color options for this product?', 3, 3),
  ('Is this product suitable for outdoor use?', 6, 4),
  ('Can this product be shipped internationally?', 7, 5),
  ('How long does the battery last for this device?', 10, 6),
  ('Does this product require assembly?', 11, 7),
  ('What is the weight capacity of this product?', 12, 8),
  ('Is this product suitable for sensitive skin?', 15, 9),
  ('What are the care instructions for this product?', 16, 10),
  ('Is this product available in different sizes?', 19, 11),
  ('Can I return this product if Iam not satisfied?', 20, 12),
  ('Is this product suitable for indoor use only?', 23, 13),
  ('Does this product come with a user manual?', 24, 14),
  ('What is the expected delivery time for this product?', 26, 15),
  ('Does this product require any special maintenance?', 28, 16),
  ('Are there any additional accessories included?', 31, 17),
  ('What is the voltage requirement for this product?', 32, 18),
  ('Can this product be used for professional purposes?', 34, 19),
  ('Is this product compatible with other devices?', 35, 20),
  ('Does this product have any certifications?', 36, 21),
  ('Are there any color variations for this product?', 39, 22),
  ('What is the power source for this device?', 40, 23),
  ('Can this product be personalized?', 1, 24),
  ('Is this product suitable for outdoor activities?', 2, 25),
  ('Does this product have adjustable settings?', 3, 26),
  ('What is the warranty period for this product?', 6, 27),
  ('Can I track the shipment of this product?', 7, 28),
  ('What is the return policy for this product?', 10, 29),
  ('Does this product require any special installation?', 11, 30),
  ('What are the dimensions of this product?', 12, 31),
  ('Is this product eco-friendly?', 15, 32),
  ('Are there any color fading issues with this product?', 16, 33),
  ('Can I customize the design of this product?', 19, 34),
  ('Is this product suitable for all hair types?', 20, 35),
  ('What is the energy efficiency rating for this product?', 23, 36),
  ('Does this product have any safety certifications?', 24, 37),
  ('What is the recommended age group for this product?', 26, 38),
  ('Can this product be used in extreme weather conditions?', 28, 39),
  ('Are there any ongoing promotions or discounts for this product?', 31, 40);

  INSERT INTO Skills (Eskills, EID) VALUES
  ('Programming', 8),
  ('Marketing', 8),
  ('Graphic Design', 8),
  ('Data Analysis', 9),
   ('Problem Solving', 9),
   ('Presentation Skills', 9),
  ('Project Management', 17),
  ('Time Management', 17),
  ('Creativity', 25),
  ('Leadership', 25),
   ('Communication', 33),
  ('Teamwork', 33);

  INSERT INTO Rate (custrate, CID, S_ID) VALUES
  (5, 1, 4),
  (4, 2, 5),
  (3, 3, 13),
  (2, 6, 14),
  (5, 7, 21),
  (4, 10, 22),
  (3, 11, 28),
  (2, 12, 29),
  (5, 15, 30),
  (4, 16, 37),
  (3, 19, 38),
  (2, 20, 4),
  (5, 23, 5),
  (4, 24, 13),
  (3, 26, 14),
  (2, 28, 21),
  (5, 31, 22),
  (4, 32, 28),
  (3, 34, 29),
  (2, 35, 30),
  (5, 36, 37),
  (4, 39, 38),
  (3, 40, 4),
  (2, 1, 5),
  (5, 2, 13),
  (4, 3, 14),
  (3, 6, 21),
  (2, 7, 22),
  (5, 10, 28),
  (4, 11, 29);

  INSERT INTO Returned_product (RP_ID) VALUES
  (1),
  (4),
  (8),
  (12),
  (15),
  (20),
  (23),
  (28),
  (31),
  (36);

INSERT INTO Returned_details (RD_ID, R_O_ID, Quantity) VALUES
  (8, 11, 1),
  (12, 19, 2),
  (15, 31, 1);

  select * from Category
  
  INSERT INTO Sub_category (subid, subname, Cat_ID) VALUES
  (1, 'casual', 1),
  (2, 'sports', 1),
  (3, 'formal', 1),
  (4, 'casual', 2),
  (5, 'sports', 2),
  (6, 'formal', 2),
  (7, 'casual', 3),
  (8, 'sports', 3),
  (9, 'formal', 3),
  (10, 'casual', 4),
  (11, 'sports', 4),
  (12, 'formal', 4),
  (13, 'casual', 5),
  (14, 'sports', 5),
  (15, 'formal', 5),
  (16, 'casual', 6),
  (17, 'sports', 6),
  (18, 'formal', 6),
  (19, 'casual', 7),
  (20, 'sports', 7),
  (21, 'formal', 7),
  (22, 'casual', 8),
  (23, 'sports', 8),
  (24, 'formal', 8),
  (25, 'casual', 9),
  (26, 'sports', 9),
  (27, 'formal', 9),
  (28, 'casual', 10),
  (29, 'sports', 10),
  (30, 'formal', 10),
  (31, 'casual', 11),
  (32, 'sports', 11),
  (33, 'formal', 11),
  (34, 'casual', 12),
  (35, 'sports', 12),
  (36, 'formal', 12),
  (37, 'casual', 13),
  (38, 'sports', 13),
  (39, 'formal', 13),
  (40, 'casual', 14);

  INSERT INTO Cart_details (PID, Cart_ID, Quantity) VALUES
  (1, 1, 2),
  (2, 1, 1),
  (3, 1, 3),
  (4, 2, 1),
  (5, 2, 2),
  (6, 2, 1),
  (7, 3, 3),
  (8, 3, 1),
  (9, 3, 2),
  (10, 4, 1),
  (11, 4, 1),
  (12, 4, 3),
  (13, 5, 2),
  (14, 5, 1),
  (15, 5, 1),
  (16, 6, 3),
  (17, 6, 2),
  (18, 6, 1),
  (19, 7, 1),
  (20, 7, 1),
  (21, 7, 2),
  (22, 8, 1),
  (23, 8, 3),
  (24, 8, 1),
  (25, 9, 2),
  (26, 9, 1),
  (27, 9, 1),
  (28, 10, 3),
  (29, 10, 1),
  (30, 10, 2),
  (31, 11, 1),
  (32, 11, 2),
  (33, 11, 1),
  (34, 12, 1),
  (35, 12, 1),
  (36, 12, 3),
  (37, 13, 2),
  (38, 13, 1),
  (39, 13, 1),
  (40, 14, 3);

  select * from order_history where pid =1
  select * from orders 
  alter table orders set C_id =20  where OID=47 & OID=48 & OID=49 & OID=50 & OID=1
  INSERT INTO order_history (id)VALUES
    (35),
  (36),  (37),
  (38),  (39);
INSERT INTO orders (OID, total_price, order_type, date, C_id, O_H_ID)VALUES
  (51, 130.00, 'completed','2023-01-01' , 20, 51),  (53, 130.00, 'completed', '2022-09-05', 20, 53),
  (52, 130.00, 'completed', '2022-08-30', 20, 52),  (54, 130.00, 'completed', '2022-12-30', 20, 54);
  
INSERT INTO order_detail (oid, pid, ordered_qty)
VALUES
  (51, 1, 5),
  (52, 1, 7),
  (53, 1, 3),
  (54, 1, 3);

  INSERT INTO order_detail (oid, pid, ordered_qty)
VALUES
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (47, 1, 2),
  (48, 1, 2),
  (47, 1, 2),
  (48, 1, 2),
  (47, 1, 2),
  (48, 1, 2),
  (49, 1, 3),
  (49, 1, 3),
  (49, 1, 3),
  (49, 1, 3),
  (49, 1, 3),
  (50, 1, 3);

 --A query to return the most sold products

 SELECT top 3 pid, COUNT(*) AS SalesCount
FROM order_detail
GROUP BY pid
ORDER BY SalesCount DESC






select * from order_detail


SELECT top 3 COUNT(*) AS num_orders, Account.firstname
FROM  orders
    JOIN Account ON orders.C_id = Account.AID
    JOIN order_detail ON orders.OID = order_detail.OID
    JOIN product ON order_detail.pid = product.PR_ID
WHERE  orders.C_id IN (
        SELECT  C_id FROM orders
        WHERE  date BETWEEN '2022-01-01' AND '2024-12-31'
         GROUP BY    C_id
        HAVING  COUNT(DISTINCT (date)) > 1)
AND product.Name = 'T-Shirt'
GROUP BY  Account.firstname
order by num_orders desc
















--the seller id that sold the most product 
SELECT s.S_ID,  COUNT(od.pid) AS TotalSales
FROM seller_account s
JOIN product p ON s.S_ID = p.Store_ID
JOIN order_detail od ON p.PR_ID = od.pid
GROUP BY s.S_ID
ORDER BY TotalSales DESC

--return the best product rates 
SELECT top 3 p.PR_ID, p.Name, f.Rate
FROM product p
JOIN feedback f ON p.PR_ID = f.product_ID
WHERE f.Rate = (SELECT MAX(Rate) FROM feedback)

--return the least product rates 
SELECT top 3 p.PR_ID, p.Name, f.Rate
FROM product p
JOIN feedback f ON p.PR_ID = f.product_ID
WHERE f.Rate = (SELECT min(Rate) FROM feedback)


SELECT top 3 payMethod, COUNT(*) AS number_of_times_used
FROM payment
GROUP BY payMethod
ORDER BY number_of_times_used DESC

--This query returns the customer  id, name, product name, quantity, and price for each item in each order.
SELECT CID,firstname,orders.OID, Name, ordered_qty, total_price 
FROM Account 
INNER JOIN customer_account  ON Account.AID = customer_account.CID
INNER JOIN orders ON orders.C_id = customer_account.CID
INNER JOIN order_detail ON order_detail.oid = orders.OID
INNER JOIN product  ON product.PR_ID = order_detail.pid 

select * from orders













--This query returns the product name and quantity in warehouse at specific date 
SELECT Name, quantity, quantity_added_date
FROM product inner join warehouse
ON product.warehouse_ID = warehouse.ware_id
where quantity_added_date = '2023-09-05'



--Query that returns the products on sale
select * from Product where Discount is not null







--Query that returns customer id , name , order id, quentity, total price for products sold on sale 
SELECT CID,firstname,orders.OID, Name, ordered_qty,Discount, total_price 
FROM Account 
INNER JOIN customer_account  ON Account.AID = customer_account.CID
INNER JOIN orders ON orders.C_id = customer_account.CID
INNER JOIN order_detail ON order_detail.oid = orders.OID
INNER JOIN product  ON product.PR_ID = order_detail.pid 
where Discount is not null ;


-- This query returns product id, anme snd how many times it was returned 
SELECT PR_ID, Name, Quantity as returned_count 
FROM product INNER JOIN Returned_details
	ON PR_ID = RD_ID
ORDER BY Quantity DESC;



---This query joins returns the customer name and total amount spent on orders for each customer.
SELECT customer_account.CID, orders.OID, firstname  , SUM(total_price) AS total_spent
FROM Account INNER JOIN customer_account
ON Account.AID = customer_account.CID
INNER JOIN orders
ON orders.C_id = customer_account.CID
GROUP BY firstname,CID,OID;

--This query returns the product name and total quantity sold for each of the top-selling products.
SELECt Name, SUM(ordered_qty) AS total_quantity_sold
FROM orders
INNER JOIN order_detail  ON order_detail.oid = orders.OID
INNER JOIN product  ON product.PR_ID = order_detail.pid 
GROUP BY Name 
ORDER BY total_quantity_sold DESC;



