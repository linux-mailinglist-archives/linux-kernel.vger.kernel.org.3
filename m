Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3E4A6A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbiBBCpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244265AbiBBCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:11 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZm015788;
        Wed, 2 Feb 2022 02:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tmGIdJkibtbU1A2f/iYrQfNi/bAe/Pn/qRenGK9KFF0=;
 b=kLrWwm1BEemihCzCljhOe+nbG2uX6F/5XWCdqjqwoZEw9on6Bl5IAIv2vBX9UGMB8HcQ
 mRfgES3g5N9SfRJgqvQSSf7LN6kn5G19WQgxmvR6kBVjDbtIyrwevwH7jc+vNtjOGXrm
 xKRylpTgc+CVizIfMBJJAJmbKr/8jPuHYIungBUss4Bx8WwWpGgtV443Oe7/6usRxA7S
 QmXZbfpSBX8pmprHH1gUCuw7sqLTUKHZfZ/xtGR/ewvVwVUXMG2OhVZVACn7JIkOySfx
 cCSD/XX+Ua+KzKENMlHv0toXfiQr1uj8py8H/+tggA1vWGQues45orcdoj3NvWb6jbpk tQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvWn015147;
        Wed, 2 Feb 2022 02:42:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgguct-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuqzS3rHLUQ4Ul36g1XEiasifm4qUmHFQ6R4knaw7RgsIctqXxC+9LOyjR8NaL7K/LZoIKoai/BKNND3svP25dEP5QixmZBgzeFD1pvffgEL73VxXKUMSzwp+fQlnQPKav2oriHGjiG/mx3miUYjvCw1DcVqADU/ZOyrI91pp0SedshlKZB5pPMcR43GwnPQZ0bx3lG+d7LjN192NvPpq6Ir4Mkan+hlbd2Sc9sOJu5KiaC9Bt9h8YBGlqH5nZNkQHtEkjlZFDY/NHm8WuiOGprySoZcMneEkYaCaO/7aqDEpGsHqgKACm5KN5TSpES+GxfMUQaKf7T+MF+qRBwHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmGIdJkibtbU1A2f/iYrQfNi/bAe/Pn/qRenGK9KFF0=;
 b=doucQdp/A8g8kDWpYIrgOb6onPfHwXifUUJWXl+r20LaY0UdqlTuE2ysnR0UyZe6NiOLreVKAPJnBpGDi1gj7OtEPOipdp0s0J30BeNLIF95ZuSfNNUb0LVbKMguWE1WvX+ore1vU0QkdurlBC3+3ZMHrsfdxJy1nbd3Lgyl2FIEJvJcQtwcvKQ4TM1B3+P0HdJKgnElB9lzbzoPKzv3uFKA7X+KzGbAWARxCtrRDMtDc/4v7mPJKmrD+L8tTGjGwPnkp+0bHdHNUyGTYd1vsNOuODW9/Td+dUfLE1c9oshgYr3j5gTnT6SjdrYlJ4LI3J8lZv30BTszDKxT9B2qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmGIdJkibtbU1A2f/iYrQfNi/bAe/Pn/qRenGK9KFF0=;
 b=T6HEOrS9B7DeNKkyr9VSarPjs8Q/yq+N4g4BFTstxrSuCI3WyIKXtOdke1Noyab7R/ElsBZMqsbYOc7W5sh8xVZw24gxZQL4YBw8m1Bv+JB7idd2VYfpPktjt0vuBywni77Ai9MiuDWENc/z0l/PA+V/Sw1/07UIrs1fisORgK4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 58/70] mm/mlock: Use vma iterator and instead of vma linked
 list
Thread-Topic: [PATCH v5 58/70] mm/mlock: Use vma iterator and instead of vma
 linked list
Thread-Index: AQHYF96AQnzr5LY3D0KiA/5/4RSbVg==
Date:   Wed, 2 Feb 2022 02:42:22 +0000
Message-ID: <20220202024137.2516438-59-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 501fd0b7-e5a4-42a6-f191-08d9e5f5b89a
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58653285C7B54CE61326BA2AFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sx92FGvsdfGBaL2fYU7CfEoE6/gu92FN4/ZwEFwGLLhHbBQMS/zFduLd+fCYF/0LaMbRbdLWJV8TM0eCoPdguSyRHFr98z2GRTRH/kItCsCNHzGEVijepiZTXVtLh5Pv5OdRJ7P/dGoIPrKrN2WOJqXEqczSEP17W6kahnpjvA5LC7NiKxZ87pb5xFVdtZkGYfAybYkZiAvFtSt65ktDVpEiwHHlWpbLzcxL1rSAPZJPU4qMY31u1nOATIUXIcqFUcvnmSWlD1dXf3y0daH8qYxSn/4j2QEAIWkVOReDCTfBF1eKsuffsDvDWWSPDayt7LxnwxAkRu7Zdmn2OD8VsHt3Svqoicoufpg2aEtUcQU1FViLe7sI39QzrFRDZAZNT1GTDtho95xwDeJqN5z9UYZqRxeG9RnHLN/rcUHbY5Y8bQDDxQ/ep38+CekZq9eeFTNp7KjJiLGbKjBkbaw80RaDGEVdlCur+c4wpqonMG7wC6Bb8jss3WwseRpcP5QHe/MAXrBVd0T5UduNY+Xeb+Ug+HulRMa0LgC+ym+wg2+3X4hI5p1auVBvLQVv6CjvX0w5RczFpzfGFgYEPWbktrmKDtnjeS+tclJwRf7b/0ufeamjrPg74ZO8c82gULoTGJq7evZyG4GCUibprWTkspSEPVn8IwyTPvrj8laKGF0oVz3zmKiZ7MzJ1MD4Omg8y2sOof8ucc0FVLzRBx+soA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s4g3HJE3RMIkuh+v/MNhlLb7Nsbdha2O98wTlJqtNwX/Wo2+/Ip8TGgJ4o?=
 =?iso-8859-1?Q?ebr1LnUdwHHL+CYQtPH8MynSby8jdRgTsTVt7MGn2CMbw96iCo3Q8swnds?=
 =?iso-8859-1?Q?ENr8bzAmVKrqJviCDQE1mjBM4WoROtsZbP4ZbNp4Y6NnjWbWtLw7zxG06N?=
 =?iso-8859-1?Q?ybXYJiQi/bCuSC9RMGJW2jjSFkcVwFDEfBYpYoPdq0CtyKgKyywpa+IZRc?=
 =?iso-8859-1?Q?XXVH1Pop3MiW0qRlvQzT/0chTc5tjd281C43G6+D9pwPCoVb0Q1Arm8o+1?=
 =?iso-8859-1?Q?KMX9WnFGF81rhco+V1aZqCrZ2GHIv/u1MttnFFljHH/X5MNqwuaWxZ5nDu?=
 =?iso-8859-1?Q?kfPeRj1Nr8axomJfoXKzHFJR3LOL74O2HZvIyumFV1IQZE5roJFnsD9Xm2?=
 =?iso-8859-1?Q?upcZ7QjGl+EOYkAZIkQGhk4IjVdV6D8l7yoQsHVhb5/J3THk8ASmnaQPTi?=
 =?iso-8859-1?Q?84xaETO1MW9hzZDStAFOY2dOvSPJ1C7CStZ1+Gv6/rRqMJak5GLHy2OxFN?=
 =?iso-8859-1?Q?ZfanBNp5xCnL4sKiYDa4rm8q7MAT8gLpC1SBhZI7dfppNtrScIJXQLn/vF?=
 =?iso-8859-1?Q?7GX0YhMJ0uuhqsKrqqASWBN6yQvxOrkAdcyGcRF+7V5UdFGr3WzuMpZCVl?=
 =?iso-8859-1?Q?huUbdiO+Ado4Mr60h/FfmhnhjNg5JsG3MdZlvRqS2TrlFXSv5/O486y7st?=
 =?iso-8859-1?Q?JBbl3oBoUI9kh9WK8Lr7Az4iuMZTawrrKdKonqSoAhnZtUl9QRqf3IKaXL?=
 =?iso-8859-1?Q?aNn43famlHncVcerl1WpENBk5/fq7Q9T+NhJJ13iMpIkvlPZ1Rgm9iS1el?=
 =?iso-8859-1?Q?n9d0N0S2DOKWmtqgm7VnRCygZSNLRhvbpr9fjSCsL7tCERTlVcK/8OAhNk?=
 =?iso-8859-1?Q?8nXtYexgRRoIyJxwkvl0ROGRbXc0jx4bJfpe+BhvI7a3qpFEBWLT+Nx2OG?=
 =?iso-8859-1?Q?hNB0WCPz+Xturo1h6TSSxZT9K4S3nEdlUE1IM4yOsFpX+0UaquwC+lxJVY?=
 =?iso-8859-1?Q?NQgwSN28tKDh96jLiRY3WP2mB5rKNB/qH60zw+2VWBMcILdBchH0mAw732?=
 =?iso-8859-1?Q?93UgiIZH2omVc2D8+N4h7e79N3EALzHp6xzHJsqOQcfvXhJzAHq7ZQXKGd?=
 =?iso-8859-1?Q?7qQZACfs+YzdHQuucjOg5UeJKcjzhujt+gvseFjJ9M3SEYkHBPyOWvdoWd?=
 =?iso-8859-1?Q?eeN53b6a0MH1gAwiFl9nt+K6G4ZLmjVyY7+tc+E92mFsDLE8yFIAhjz8vc?=
 =?iso-8859-1?Q?b4p8WaXH+cmMnxcpq0vm5vrFh+4RSNzCFr26bZUHgSH3y+DRz/u1EoBi3N?=
 =?iso-8859-1?Q?1HkBWLz8SRsFP8r6Ny4HvADtsgqwoZaLaAcS98J/pM04nIlQtwetF0FV4H?=
 =?iso-8859-1?Q?ZZ4tUMjlZs+Lnkss7UH9ySlTqVIdOJ/ihRdfbMUrXAq5PcfpIlanLyWa1i?=
 =?iso-8859-1?Q?q+VvFi1GwZt+mYCJEKIus6Oj3Z5mWPQ9B8epw2gBFbPnPxsV3tpLquWWBj?=
 =?iso-8859-1?Q?3uPPfyAYV+MK02ghVUzgBSFLb/aJBym5VyCrhvT7IQ/457E5SEpUkbyPGk?=
 =?iso-8859-1?Q?xr5iQKMRGVBZE2ZjLMoI5yAVrkKKc9yyolU8k2WSZ5Md7RvxMIBwKTTCaD?=
 =?iso-8859-1?Q?LC1Sc/9PnM8UuDEW4pW2DnXeFgL2egbv65vWAfH/iZB8gZtbt1cRdgP47u?=
 =?iso-8859-1?Q?OUcIsXAfgXt3yEiX2ew=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501fd0b7-e5a4-42a6-f191-08d9e5f5b89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:22.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhSet0R4z8EHFvAKW82pPR/lT+dBwMMtqnyVDWSu1+QYHYMogFkP7AUa+bVkZ9zXYxsx1X3o30at0nJKvonmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: RGOg-WCz_EGUA3CvTNp-NSgEhAmAXoOX
X-Proofpoint-GUID: RGOg-WCz_EGUA3CvTNp-NSgEhAmAXoOX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..8d54f355080f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -563,6 +563,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -571,13 +572,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -597,7 +599,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -618,24 +620,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -739,6 +740,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -759,7 +761,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
--=20
2.34.1
