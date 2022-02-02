Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25C4A6A11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244323AbiBBCnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48364 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243932AbiBBCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:22 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Nsv91022152;
        Wed, 2 Feb 2022 02:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JyuVDoIiGUn5mgzO8dhF60aWuk04/ks/4UkXaN68zJ0=;
 b=LK1Zg7AksZbN1xxDKgyx/S7LVtTrglWAQNZJoE0T42tqJ1quCLHQWBLjTGyG/Q8ofuYw
 GHeolTipJChA0eBtaPIJSHLrsAdXwiwW6NSVnOcGiXrvDDaZfqVQJbSsdhj0NPLcGQrD
 sXnKbNcXgvnzvlsWU6TAo2QMfyz53roZTkZQUDfnEINDHyqtKjSNW1SSDhNLcAi7Gdqf
 4Pwq1ik/YQmBwPWSLxXaxd4CnxHVnSoOl8pChNUs3kNOv+mnYTU9tCZB5Cukzgua6BqY
 QV0IAB+w2ufO27bcGHvSWaKIB+ShVmanHl4uvfMhs9Alkds/rTvafpg4n16mfl+d36u9 Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSK126532;
        Wed, 2 Feb 2022 02:42:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX1UWS0eWTjvKGbm20ivTIkL3N9vTjfkTmNSxZsf2AH9TKTgkZ7EMzOY+8vKdGwEciJlXYFnCa2Zc7PFp/9+pGjIRVFjTWAjL1ZSXkqSxkmdzzkamE9N2kBg/JFAjv+QOg/+0veE74liyCsm7pnIlIxK/vhK0bmIS5a+ksmZK/PbsgG8RNqDubUtSvhH/lOeAkz+vqhhlYRdkWWucux3mU1GvCJ0QvTWI75g/v+SKW3Uj/dWs2dokTjfmRvI9qyGW6wb0Fzi396Zr1liQhtkyUVv8OtkvcBguCyCwJWSbNUx49kmsYNdIvX+Ap6O+CLzv+CMh9ZuW3IFogz8+7t9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyuVDoIiGUn5mgzO8dhF60aWuk04/ks/4UkXaN68zJ0=;
 b=A1zvLudZqlEGsdDD1X5H6FJHAXPAH4JwhDOeW3ayAv0AEZ43di0m0CsXgtN1wlaBXORR2ePxQffy+7dEQxw4sdLOSdJaeHttygEk5rGaXffGsklvsUZu0/NXuBva45/DTWC6jcyUAOuodCWuKjGhR4PwbMl/F97MLwaB0ezQCLjJmo/dmtQboavdgZMWMbGCS4LRFUeI7/nzLuqrFKa8+rv7LYgNGe+phAcpuoITZGpm4h+3z47IxVH9c7uvCUviuXbn1tZ1SVmL1bjNii+eifkAwo9QmLeoZATn4AhuerOkX2T/oXSciWeLUMZCV3hMC3xbKA0iG2h6cqz8r5tFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyuVDoIiGUn5mgzO8dhF60aWuk04/ks/4UkXaN68zJ0=;
 b=sxR21Q76A1Nszpu86inqGgG+s6azHGE3dIOe236Ch+dZKV0yrG/AJ/vR2MbuLvj4l7V/rIg5SY4zgMp/XXC+3k5PAX9h3q9A3n4fpKu++U0qMYkPsPL9lcRKG6eVW+041tVoniXU6kDnQiPQT+xbnWNeTSzRw7DEryx5VaUSO4g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 24/70] mm: Use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v5 24/70] mm: Use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYF955VQwPaHjAtkK53GGYoOOlVw==
Date:   Wed, 2 Feb 2022 02:42:09 +0000
Message-ID: <20220202024137.2516438-25-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f840f632-4ff2-47dd-6391-08d9e5f59cf2
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41294512141193B942DFE0B1FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzHcq6kJGlLtnAqoDj1OX/fz4pCxgvKhkP9sQBm9chga/WN0JQCq4+S0PB3UXRheNg5k00ZU92aqHbz7d5/ijihxVVNQPkYgBvZRXO/nXKn05jHTkj4MeTwRHCor11sWtFfZez2VdNDvM8DJxI/PLCBOXM0zUw19p98tlYCemulTqec9lOWPB4Ijs9QAyqYhLVTlj2oeSEz0l55S3Mytf4JFCgKEIwFeW23RJLNbh/haeCIv6X+4lodUNwUu/Zikr4ENBZ2kI+azLpgJkeyMT9I95bKgg0vqF9S7R+2v/An4t41Nmf1DpGiOOh2moOrtd3HtxWKasqN+e6ci8Uw4VxDwH8h5xSgbKLcSb9dtHRts8odMAV5q+mYFZ79j3C6o1D3mkjiTfQc//UWDOT6KAQ0pLr607WL6PcrS75bNO+TZCkXbYMOOoE3Tzpa9gNc86Hh4COX4bO2y3jy7dLpw17EJ7eMgidz0IgNIn7ghKQ6J0Hd+LqaFu0xWGk8TuYF3P1WtqnL4dVcYaA++Y5Bn0yNMdYg9yz2aV7f3BRw2PNjKssAMCbSU5cM/5qu0A+ZP4tQh58R1C+saWw8QGOa/+qsakaT/irzHeoRd1lyRzs+j1UEZKOEws58BIsLF0opNlS72rS387TExYGbzJFdLpBhT33YSxeUTzKT7/oE3YArR+KOF7Vm1uPThpJbxhlbj2wgAPP1drcfixhgO83upUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kgbaTPvG7R5hK5aWTCoRCb/T73ApnAB+0zcXE39Fv5lIIP+1LQBlFMzhzE?=
 =?iso-8859-1?Q?sxn84XNt/4XC4DnpKRl++EZDxt2UG1IPGIe6MyloEFpSwhuRfTNcHPFXpb?=
 =?iso-8859-1?Q?SUClXyB7rfyQG7ahfiU97pUJiyWmvvfBQvI7s3Bo6RTctEGiKDDsp46439?=
 =?iso-8859-1?Q?vCTqt5fyXi1mQ2FS43ffJUmsbvM/LUd3iKxSGS5ZWuZLAfNeUyMu+RxTMK?=
 =?iso-8859-1?Q?Cs3T8L1M6WVYHYfBYJy5seN40xhEOYaxW6VjQQTxqOsA1+4NnNy3a0PQFT?=
 =?iso-8859-1?Q?dcmBNpKUzEHReeOv19q0ITFRUjb2HazitamOKGG+6iOGd/wWjt03XL3Lvp?=
 =?iso-8859-1?Q?PZL93kwBjtieP0z4DMttcrgCJSpg1bG85oth9Eu7bfVRf0HikRbMuQeuzx?=
 =?iso-8859-1?Q?zt5GsAk8AfoEV1wDDjhPEwgZ+S6+cCGMvt8aFUDIlgwnR8XN4cVyotvCIg?=
 =?iso-8859-1?Q?ErG1cbxDJGA7QxUn0dD3b/4K43UsSrnmOCLE+Am3dvnB65ZL1iYd6HROQl?=
 =?iso-8859-1?Q?Cr8iT7NNw7T88ncwnwkshW4QcGntfFjZKEVOigTElv4Q9QOQOZkf3e51Pu?=
 =?iso-8859-1?Q?UaCK+scHO7sMt5pHH+Qbcp3ashrlTDFTgU40GFgN+MBGL4awICDWh80wJl?=
 =?iso-8859-1?Q?n2KpmKsNgYNmry0zN91QSCpO5GkfzIX2Cx2j/QM513K4pEBzBKiU6cE8UV?=
 =?iso-8859-1?Q?Ost5tEL60St3TVRH/hEDUWY0e0f4ZqcwVGP13fK3ft9hZAPXdbIbyvZUuI?=
 =?iso-8859-1?Q?sy6EV2dFASRVDYrckoITfFYmoReoYEl3p1hmnhPVZCn+jK+0wH4S4dVVzi?=
 =?iso-8859-1?Q?XHVdaq94m1gTrZqeFt4CGFhasBrBp4uUIjqKQNNzgmM7RVD+uPtKnKcyWz?=
 =?iso-8859-1?Q?+5T9/50kvHAUzixAUWuKnf1ToElsnKmQlUU9qRXn77d/TIf4XEGykHs0bW?=
 =?iso-8859-1?Q?LJjiyOC80viKnxbVYmGkl4i+pzusQc7jEQ421VaRd02dmuWEbuRk2M7c/r?=
 =?iso-8859-1?Q?ADZD4BBi5lLhpsOK6b1n+5zW7pbHE/r4UycWuFcY7Lijdd4P8Y0VvHwm+D?=
 =?iso-8859-1?Q?tVQqiDFOHjpl5mbhDuDMMDtZ+QrAu5OjyVnnmUnoWlZt6blOAs2UgeamcO?=
 =?iso-8859-1?Q?L1PMFIuJ4gj/2enwGxLsZxWyuCwiilbc2mc8C5QpvhBgUAJvMDwOvSgCSP?=
 =?iso-8859-1?Q?ymWY9qzpE7EMcERtvl1kliFiEPvzIuzWw8Inv6zDVlo43itA3VdwSwbCR3?=
 =?iso-8859-1?Q?3Z7DTSbaYQbupQxe1+IzAjCGyErzvQkeVDcFfP0AE3KFbRwvvQM5fh+58O?=
 =?iso-8859-1?Q?eQOpIJgAtdaNEDGjCYv9TOg3LVhO/TUg9NAqBzoJSzYh3MCOGKHckBdOUR?=
 =?iso-8859-1?Q?mVIBV/pNUWMu8aPgkpnoD8EOso9qGpw1NKCmuFy29k15AiMPzN1iLwP47s?=
 =?iso-8859-1?Q?dzNahBwRF9sUgYyse9iG3A9+XTjIdA0+w1qb5t1DKkyFFBfwKjCM4WJjk+?=
 =?iso-8859-1?Q?S/9AZnSo8f9lZQ/PueGkh6zOxAM9o1l8bTGfgKj0P3oVec6xYfghdMDvEW?=
 =?iso-8859-1?Q?IQ66jdOxMR4kxVC8ilCKP2hYq1fQnaYj1lkGVOdKSvga7p8zr+hS4D1Svt?=
 =?iso-8859-1?Q?ISKtPXdOLt49hbV2nXXmiJdy28jo7xDMwb9HLj/khHd92XuzYhRCYBCqum?=
 =?iso-8859-1?Q?n2uWIJnGdtPPYijAuno=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f840f632-4ff2-47dd-6391-08d9e5f59cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:09.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cM2dOBmOcFWJ/qPjMyNk8UwsHpyEUqFMrdj8v2PekLb4fNFjGQLDkueOGVFE+luqzC/D14Kw9BDb16hg/ybFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: Dd4sYXtsoim1mmmFFtS8kT3ApBZu0IBM
X-Proofpoint-ORIG-GUID: Dd4sYXtsoim1mmmFFtS8kT3ApBZu0IBM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 25 ++++++-------------------
 mm/mmap.c          | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 110b1dcfb036..72654108380e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2784,26 +2784,13 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
-struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						    unsigned long start_addr,
+						    unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index b21fe2fa5846..8bfbaea0cffd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2037,6 +2037,35 @@ get_unmapped_area(struct file *file, unsigned long a=
ddr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	/* Check the cache first. */
+	vma =3D vmacache_find(mm, start_addr);
+	if (likely(vma))
+		return vma;
+
+	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
+	if (vma)
+		vmacache_update(start_addr, vma);
+	return vma;
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /**
  * find_vma() - Find the VMA for a given address, or the next vma.
  * @mm: The mm_struct to check
@@ -2045,7 +2074,7 @@ EXPORT_SYMBOL(get_unmapped_area);
  * Returns: The VMA associated with addr, or the next vma.
  * May return %NULL in the case of no vma at addr or above.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
 {
 	struct vm_area_struct *vma;
 	unsigned long index =3D addr;
--=20
2.34.1
