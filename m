Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A03464FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350858AbhLAOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63416 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349948AbhLAOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EGXh0017179;
        Wed, 1 Dec 2021 14:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xc1nPb6L1kC9bXBMRDie6o+mvdL3FssVZJRSfw/mHOg=;
 b=BgzLGC/EqXzHvtqyGvAZ0Ct+c0XnGrKc41EOvLRMeum1p3jqYatCCf3z3QNgZ4+P7NHi
 dZAbPWUwfwBQix1gR3ApQb+Kr4wr7lDjSpH39Z6QrPv3ZyyWD9yZGJeoyGOMLBFX0+v0
 gl8Ibm1Ersd+RKCGqgkeO3f41/kT/SNDZofQgSTu5x+AeR/y2Gj0S1i6JOwZaV5Y37FB
 yVEwyTN55XMOdXkPam6VuSkl859luSsYylsOtsP1ZrTmXb/WqfO+X0SwAU46bgB34sLa
 X5eScm39BhUQmf2Ddrhl2oGWUVZe9B/kNwi1pRfFcdq0xMCUfflpP3NiplbJU3ctzF0I 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7d109791;
        Wed, 1 Dec 2021 14:30:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJleJKLJjpTvQXy2WAZGNGgJcImMCIbCZHOaLEC5dZcFi+KiFF2A2wUyw7T78OiMR9NRrGv8cYnsPL+Wr3ZGl6vxKBCPPt7cAUoRc8LyCzo9KffO3zv0ZQU5BUjLVKBi3pOCoZbuI29UzaZ1BV+CJfTyMOH0P3mq5mRAOgdUXM/E6IYG/3HTMffhObPioZEnQbZY8wk2VN7IzclPjiQh+vJyhKULTYqZE6Ld9LuTluv1nkS2Qa+vbYVz3ziz/x1yScr/PKyRvwF+kRXD5vZgURuRAme48+QdyYEvN24UCd/tEqcPtyVXokVM+sK1pY7cxz0iMb4IENb0T3m3SC0reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc1nPb6L1kC9bXBMRDie6o+mvdL3FssVZJRSfw/mHOg=;
 b=PI6OvIuZJIVtT+6E8ETW1FdYrxqtwvNeKH0wLRm6KM//n1yY6a/t9+NJtx4bSq6jJkarnN56S5GV09/hQlI498rvheRTutw1sVSHTuv4VNIdCVLrhJXUm/cTCOdMPu+w1gt2zyDuHKPDxAo7LYV5zyxjmMyZnE1kydihMxZS/nSK+rjXTaQoAhBFH8GzvRoBvp4nl2ElIX0623PmAyD5AyWsMyeO2wTC2FXi7pOBtnhj/J5c9S4sm5/lYgU7WStgbk+JI0Pd8nprKeKyTIaVUP54LYaPv0QeEIXaPq9f/EGWF9KolYgkjxxJXpbAGZbE3vb8yvWXtJWNuWWNbw1h3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc1nPb6L1kC9bXBMRDie6o+mvdL3FssVZJRSfw/mHOg=;
 b=qfmcxBzXiBSpg83QSi0QD/z6REghouocJ1aYHwD/KMeRthHsj777Cxtig0xIzVJUEvs7IobFUi7jcmWmX207JqmxJsdB3sYj1kvhSzPckfpW30axxmlGo7zFSqNPj4+MKoE26i+M9d6UK1Kxe4EkJGNj80YynXIZlB2o2WSBAEw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 47/66] sched: Use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v4 47/66] sched: Use maple tree iterator to walk VMAs
Thread-Index: AQHX5r/yrE5Bi998mU2IglLSh3JMzw==
Date:   Wed, 1 Dec 2021 14:30:11 +0000
Message-ID: <20211201142918.921493-48-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb3ebf3a-728f-4a03-a3bf-08d9b4d725c0
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB45081E023BEA10D72897101FFD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0p3hfCAV4rlcYtFZyj5JfDZCVXW4xj1rIHoWW8Zjgn7klMO7xYkbuNxCg7dCL4XPpRwyt/4a0Mwb8Zd/RLA0pttxOrS5SyBD9xT276z/gS85GB2VnN9844esVSrdaB7mAm/D4whKzerQqq8Um0Hda/dPdRxLDxG2beZ54KK2R8ltof4gzhppckFAvwYf2wgCgiXhMgTyM9nhPrwxdOdjo0WGwkIVsq2BTXAXWIVQxfPD9Yt7OtRydxQY6B5suQoQwewv+rBfuA0+zIJUE8Xqt/96qjfMSlp4KZ/FKdMCkFyUfkS9b8f1ZCQB/J07fgel3G3J+r7Y/7MWaNRJB9MpFqHT/5uRC8bP757TFeAPjLfFGRUCKRbuX7+4TloVz+2OTGele/Ros89iYgi5paNcRIaeJOcvOS67yZeWflwKSiccXLFIqONFewxbbzM+A6O9ICn0gzFkCg3G4dHzQNbYBmb3GbLTyquRiA76M+NIPnayjPijoMTtSZQYSJP1cBEi96iDbVHx3e+gPUDgRZ7PG8i8whe+U46Yf3diXDy3//cmvJSZdhIbC4JLYQaeM9JbCBOwj5xwSp6meV1Z3L1vn8+0nVGyWfo/5g/YkUiV9gB2MfVgpLbkTiOx6hk5qV3TC3JVIEkzL9i9fKFgE2LGjl74EDaSvzJBiI2Ff1mZVDx2Qia+ToCNZXG5WQ46pDK6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1+v4e4mu4tBRzOAftezk78gi/Kir4IIVncYvK6mhhRqEVYq4lZcDgnJkxU?=
 =?iso-8859-1?Q?CO4xPc3K8YWy8gW0y5/AS2gr2n1oUOpQUgquyGTzuwemIUqdpsDCDDCviJ?=
 =?iso-8859-1?Q?opJ8a9Y0toiylkh6VVe3EPByqep/gLWyWVMmb24MPyF7TkgQNKg2zhia5g?=
 =?iso-8859-1?Q?LX/tpioiq2fNMEDOUNd/QxDk3xD4O2yYAqwGZVoFF2FcTN/Md0i3mPYSE8?=
 =?iso-8859-1?Q?uZ57tNmEIoZRWKjCpQSfHiivHN/u8f/PrfdExV1Ns/wzyIULVzwgJLUzzQ?=
 =?iso-8859-1?Q?LdYHhFoWsbXwu4SMJyNQ6sLSRx3zEjjYlqAygJ3hmQYuKBteOv58IebjPT?=
 =?iso-8859-1?Q?LOtwpDH3rE0s46Q7UvWYWQ2jJiO3et5nrazE9Zgj0lTSzc8hqv5dfn42Of?=
 =?iso-8859-1?Q?Va2nMD8Z8Ee6Bw8SU42bfTvDE4Lx40cETv7eOg1ciOwBNKLvYhYVnqLdFd?=
 =?iso-8859-1?Q?fZ2XbGF+A8TX1OFtKyJA8+bV+EJgUfJ2efg2cozDWWeo81FpRNxNol7wTY?=
 =?iso-8859-1?Q?xJBxJdIH2WIHTny8D2579dlUCKahq8jjvSzkqjHLOApf6Oib1l3299sqzO?=
 =?iso-8859-1?Q?Zj7lH0logTzW0euZE8OgOUVjMOG2SaIQQlwP0KeDrDROm3Pa65B8hk7Kol?=
 =?iso-8859-1?Q?LAuSRq6DaLQ8AnlvZKJ0D7w1jgWwJUA33kiSN7xd8g2fsfUebgWuBC4F8F?=
 =?iso-8859-1?Q?aIObhK9FJEdTbRNhVhKnS8kpYXgWax7UszzmS19tbRIOW1gUXUB7Kj0f3j?=
 =?iso-8859-1?Q?5oFV6nVfu7PS4E13ew5bnpmnOlUddyV/SOIIj2ZlXJRfFyvsIiGhexIVRm?=
 =?iso-8859-1?Q?SJ62LevKt3VCAYrZgkc9vJPw2er8gLqukPATEg4RJu9/Ri348xEU+SQSGs?=
 =?iso-8859-1?Q?Ae1/NADYlEyPC2EgdMwzcTXeiXVDVove+I7kRn1W0NHvmi7L1mefXVaM9m?=
 =?iso-8859-1?Q?GICYcxbJOCiDodBEmvzomzqxzE8SUMkNVuSIqjLWBkW8DEBZEmT+sWfC0m?=
 =?iso-8859-1?Q?HfvdQBcHcSpyPl87hxKKDufQ8vbDObIZIZ8nc/gBShV0RZ92ywPjpDEY3w?=
 =?iso-8859-1?Q?mHwd00J1MzRc1oS6BvL7ZnYeL2gGn+4NL2yIOeRar5Fm6L88sS5+7HRgUv?=
 =?iso-8859-1?Q?svp+9uBIxS+dmdLEtjrFPxWfLJyVpLPaFfkDXNiAiircCvMZaLo6IygAKD?=
 =?iso-8859-1?Q?hpsYkGk5X8qAsycToOmDN28xYiuM+dR2TbHOMWf/QDQjsMjB54pHSJXg3K?=
 =?iso-8859-1?Q?keUKyQ9ZeCER7UhyhEjTfC2xrRAlvi/uj9ZogtN44x94xgKgRxZQ+ptVfe?=
 =?iso-8859-1?Q?4GEn0ucQhw/Oma3VCfKOF3uQmD5KLpMGh65sc4Q++456CSwt2X+ttyAgaS?=
 =?iso-8859-1?Q?x6tS3PUzUPfyL+zr7FT7pyerucvHOpQLsf80n6wnpHQCmgE7yPYQ7trk3I?=
 =?iso-8859-1?Q?GbGqUTMl5OlMAvXqgCHgdGTkrGwVUa8QYP5yeGrW29ubOHMKLx0+BabUzN?=
 =?iso-8859-1?Q?JSkoG9tSUz6dEmYqQjU1+wDMYSaz68r+bdsl9B8m+FovnMY3RSxqIt0kMg?=
 =?iso-8859-1?Q?ziLgBj7DmGbR+oNERmTkMODyY0BNWnSEs+Wqv0KDkJO+0ADPPZvYEpvRoS?=
 =?iso-8859-1?Q?/iZlmDX0WUyXS1uCGOviFWIF8v+CPGYzSsXcZa9Ka8DlUmkD58UuJ3/vg2?=
 =?iso-8859-1?Q?+AphtX0dHGntsPGDvlg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ebf3a-728f-4a03-a3bf-08d9b4d725c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:11.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgglggDQCRi07Dt02d8qh2soNZp8VJFmdLgv7st2SQP7lKvM9oJcjgKC1147vjf75MKowtpA+CI9DeAyw7CuFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: qW7zYIr58mlmK_AjOVqfjFWa3ZM1zbjc
X-Proofpoint-GUID: qW7zYIr58mlmK_AjOVqfjFWa3ZM1zbjc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The linked list is slower than walking the VMAs using the maple tree.
We can't use the VMA iterator here because it doesn't support
moving to an earlier position.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..39bb4a6c8507 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2672,6 +2672,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2728,13 +2729,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.30.2
