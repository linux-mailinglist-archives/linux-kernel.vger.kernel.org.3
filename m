Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5256464FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350676AbhLAOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49460 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350086AbhLAOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:25 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EOuJI023540;
        Wed, 1 Dec 2021 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RZT1kr5PGIoOsnaO5c86U9aVkvMOoA5jUV9pXKZXd2Q=;
 b=cAJrQlnrSGPKANZ1N+tewsZMfBeRwc3U0wGwKfZvPzDzYNP+o2HllcBB9NIWVtprMjYH
 zEGjrx3Z19Mo0ontPYbPj2bNP4wmxvnp1jY4ncJVHhRvYNzbf2yihvV4mvESOJk4Tsdi
 WI01REqhw2H7kPpE2F1M0Mfnmg8N8gBkMqtl2L1+vzTN4CT21pLoYcBw5zLvs3lv3yZ/
 bT9cfjC4jyJE2mnwWBv41+nN1428zx4niCS/Q6sl/+j8O6BbjO9rBm427w0z1sNAsBg5
 jEWeHNHJ/enbmNtlQnFMfE/3FLCrwiYdgD8u/6ajr4FTMrE8+RZAtdlRsaQVWi0G1bUX Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkgghx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBoq7037533;
        Wed, 1 Dec 2021 14:30:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3ck9t1v74d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHbI9wkqMYKJv5zNf/FJo0qiVeZ7BFDJdrFVVsjr5j9FsdtzqCgYpI2V4GXLWF8+7sXwk49hzdHC2KwPjbgxTBXla9QKqF/W2Pm0509LwSEoSkGZR5EPVSHkP+cCWJbMMEOQHohfJ7hgGDrhsuWA7wzSTv+N55R+x27Dh7UYvd3Tn6YmpIEqtMgxh/tuEVRk/Zc3zpKWDx/w7NscwdSGhdXNoYW2y0sUeDgZ4rf0H4KofT8Zhj6HCQjJA4pnXupcgP5jZ5L6bJxyrUuJPEdlrHuXm00vhbyUrmfr/lKEjx5kLH0RFY+F0jFqmZPHU9NQtAYyJyFr2JJMqZfrs3Mnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZT1kr5PGIoOsnaO5c86U9aVkvMOoA5jUV9pXKZXd2Q=;
 b=KiiuesEtG7xMcP6bC6rHI1qpPcDTJUPX1CufEQSZlEprMb9VJzE3BwU+N9t3/X1Tv6U1CYkYYkI2dHFAkMsYbsPr5uyJXF85+/mOi5EqAV/XsP51L9awgVAmcBdFyB6B5KLz5GJdrERAND6vBWiEGcsXrxbSVJn6x/PRzryRGuUr1SmxsPXRXxaYdTANzfrhucsk07vTm+f0cPSl0FXFixvwE9zVuee+zhScGbevBCt2x4y2FMdlxeM0oCdfbz7sfY14XoKOfK+Qg/1vx10Mj1T9T82n9a9Olp+Ga+P7n4Ja5cWJNrh3PgXF3yqTCXP93qqu1QSxNO9+jxCPfuZdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZT1kr5PGIoOsnaO5c86U9aVkvMOoA5jUV9pXKZXd2Q=;
 b=KSVmwN/SxqeLN4zXmlQOX2BXXdZ8ltIMmwy7RFz1ke9xl1jMF/0XisoxKhG7AIwqyZQx9/vOmLNyelme46yGxCX6+IU6EvGIy2tbkWLgnF23g3SCGnp7kWDByXfOra6vzYl40DFzlQeZXPbRGIBvEsJh9P7a/wkUDvrvNFUXTHg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:30:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:41 +0000
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
Subject: [PATCH v4 56/66] mm/mlock: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v4 56/66] mm/mlock: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHX5r/0n+VjSgFv/U2n/DOQtwVgxg==
Date:   Wed, 1 Dec 2021 14:30:15 +0000
Message-ID: <20211201142918.921493-57-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dcafc40-109c-43f0-c44a-08d9b4d72717
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB24641708875A4A0D46A077BAFD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RZES8BdRt78tWya3kPLOc6Cx7saGrA7HBq49L60lNPPtQM6TqmC8dSgl7AoNPt2nEQmcAEkGPdxD/r6gL0civv3YhKMgPbMcK1QMS3wELWWSJ/CPQmhHklXA5qCFDFCVb+HOi722C0E934cGUOUr7DhjEHjEUP5YM6MIhqQJc6rAHQHeJ6JXiefDLUmzUTECs+lvf4jEKF+Y7Rf3In9AWS2TZWczr5qrxV7VCwffC0remLVRDc4nJuyIqr0j3IdRI2aHZJFBlsb786jVLDKA4yDPqy5D24GHwrPMRBKTRiBu1cJVEMKvlZfbCgKMSpLap5PQdzulYs/CCV3/40imU+Uqz7krT725GhvmZ5/SCnd9O1cbP0Dl+it0dX1HcbtOCsTpAtX47Ab5Ckrx2deezE5+tTBmi5HVKCVNeZYQ+0X77PgGrdvG8cp/FAJj058QlcE73q9eJanR4a1RDdqeRiyTnB2psb9yWacoGMWDEob/6uFh2PbEqkcDPTCA4zuj0jQGh4TDK5xMKvm6oPv9txfJqR1DZDps0g3MLHHXufigQuY4HlRyXyN1XaXM7M0sCqLEAnHXS7+tNig13utLT6a0NBWSz/H7bU69fs6F3CLgdTX7u8Bvqeaju8ClLqo9+nC9MJK990FnAPffEoe9wdM4inzpUO5B6QMluFPse+l2IJ0HB3FtFx7RBkOzTPScA5buSgTfi72Ca8GJfVHzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zdb4m6/tCqMZbEEnsD4qbAcx1bVlmbb8dWctc83rYhSEn2qofsO/AVidvL?=
 =?iso-8859-1?Q?p5qSQT1L/KuS8HWBhE+Lrt0SokMwMQ6ZbGUdtoto7/8q/An6HqBR/7vVao?=
 =?iso-8859-1?Q?ZEyr6sF43m5C7/kJF2Y4GbYPRw+IysW6/++xLbHWeE53saSHCeG8MZCfWZ?=
 =?iso-8859-1?Q?IVqJwy+aulNrUPsJ9Ir1j+/uYNnoCnml7972VVD8lXXzH/RZuSqjI4iqTD?=
 =?iso-8859-1?Q?pBs0N+qbn5HdZpgSxjs2Tx//tD3QBTwwyVf2nQIvhadNhF56QjmzyUsiX8?=
 =?iso-8859-1?Q?8a3PD7LlgBbtGH4JCJcObGQVf6oRJVnLMdVbG/QtKMEGvLpVPfd/6rxbL2?=
 =?iso-8859-1?Q?2fZ2Vnpi2mreuu8GDiCWfaLlrk8BOTNEOuMk5Jxy/U4kKXS8KXpWtwDceT?=
 =?iso-8859-1?Q?kkO7Ot2Z42MzgBIue5Wk+piScp5/Fv36eflKhzs7NAvMdrJ1PoZ+/fO+SZ?=
 =?iso-8859-1?Q?An+uuYc3QkjaoY3TlmY0upfQd69V9gFEFYfTMsAPz+Jr896qSLX/61ZbV8?=
 =?iso-8859-1?Q?CbymFfQT3zwG8IO4wlXAUg1pyf7puOkSJkEzN5IGS1sHje+YqX54CelAcE?=
 =?iso-8859-1?Q?phMrNx4WuN5oih9LrdV894oigc7DS36BRdzsvULX/qNrK0fM9Yi/GV04St?=
 =?iso-8859-1?Q?CFYClXVwLvwfpZ19jv+MzKezk4pezRv/bxqDHnbZ5D4D4BWAO/8E88qggf?=
 =?iso-8859-1?Q?5sJAqFR34h8QCKUdTDJrpyQF62oPmyWyq1o62+GdKOtE0qCPf3LFUFFPVW?=
 =?iso-8859-1?Q?K1hnhHKMD8SbHXasvB5QrABvevHKv20b8dfN73Qa3g08kSy53Xq5ROewrQ?=
 =?iso-8859-1?Q?owvel4KMI7WY+QHez9ytabV6S2JAKA0m8FvcedHEp18S8qFygZ7oOedK1y?=
 =?iso-8859-1?Q?IwxM/GFuEJW7qrH/ka9oCFDj27MiHM+N7sWL1lLEdPQfjGBV94hbj6XoEj?=
 =?iso-8859-1?Q?f/AxRJxF6Z9214fQdNNfJAzYlWG5p8jbs5Yh5hp+FWuhPLxjNeVWAne0uo?=
 =?iso-8859-1?Q?VwvPSlanQp7MPmu4ydQ914yzqSbYvamP4X1xtaXmUU3gDvwHYk+uzv0XqV?=
 =?iso-8859-1?Q?+pJf42HQtZpMqygP5WZ76wT7wd/NEzt+NWY0QN0aVweKVKSSNKV+mSK4cP?=
 =?iso-8859-1?Q?GatODAO8RTz3T/v2nEn+K/KmGt+ZcXFTgUxYlNhBnGTmyl4sMJq3JzV+gI?=
 =?iso-8859-1?Q?MK0P3IYMr7gRk02ncFGYilgsA+fh5O4HJaMXrKpW0ggyqWB6LojM5duw/v?=
 =?iso-8859-1?Q?kqQ/QEgMKDhbiRVUWmavrh9C46PXhpLtNNTmcCPYDG4D3cHMh6cxlvWTyx?=
 =?iso-8859-1?Q?4+Ce8C+Yc8XPgOrK6udvdzsMGKr0LQdEyZmThdzydKkJ1AMyAgsWthHf9/?=
 =?iso-8859-1?Q?lMRQnAAzJOvQ7aT2OXUS7dezwSvo/XH7XpRTij1f6x1s9pxhn3RCLXeVr9?=
 =?iso-8859-1?Q?kNUW/FBO6PR14fial6wUUWkjDQo+1CNk3vvmI0ijSGeUegwxRyoqWRcH40?=
 =?iso-8859-1?Q?szbBbTAaaeX5NpazTU7o/Mg/2hTQerI0bnOibZ98NLWy6wNl/uAE1un1gt?=
 =?iso-8859-1?Q?iex91PyRgJy7yTMIBWhmMZ+AyT9ASvoiR1PDiOhq8TmmV/ERI00GWHdNXF?=
 =?iso-8859-1?Q?e9Bs7WEnsjbG1BTT0viL/skLT45ckwpXYJl0jS1F3KYYPxVVV9/A9KIQC6?=
 =?iso-8859-1?Q?u7h7uFBMfiR2gp54UNo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcafc40-109c-43f0-c44a-08d9b4d72717
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:15.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SONUEqX8TiwyGd7x6oL7/4lBr6fawu6bA31FuskNMLzfwGkYAiMJd4o/fDdSxmVLuUVb3YPThiNu8DOyfySM9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: gNURNBZ4Em8LUnk1dBri3SYEPTPyX0wp
X-Proofpoint-GUID: gNURNBZ4Em8LUnk1dBri3SYEPTPyX0wp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index e263d62ae2d0..feb691eb4c64 100644
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
@@ -571,11 +572,11 @@ static int apply_vma_lock_flags(unsigned long start, =
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
+	prev =3D mas_prev(&mas, 0);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
@@ -597,7 +598,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -618,15 +619,12 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, start + len) {
 		if (start >=3D vma->vm_end)
 			continue;
 		if (start + len <=3D  vma->vm_start)
@@ -741,6 +739,7 @@ static int apply_mlockall_flags(int flags)
 {
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
+	unsigned long addr =3D 0;
=20
 	current->mm->def_flags &=3D VM_LOCKED_CLEAR_MASK;
 	if (flags & MCL_FUTURE) {
@@ -759,7 +758,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mt_for_each(&current->mm->mm_mt, vma, addr, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
--=20
2.30.2
