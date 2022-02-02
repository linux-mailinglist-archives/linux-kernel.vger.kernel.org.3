Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E74A6A38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiBBCpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49238 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244262AbiBBCnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:10 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120bDdr015804;
        Wed, 2 Feb 2022 02:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qA8vMoB7l083Q63xAY6AychJP+sRI03WI1rkY8W9gKs=;
 b=aRxfw+9VLfM++09krNfvt7Z/+wBXgmjEaWChU9ck34fB2JWBSHxhnImz9eHVU3r0Wjt7
 yrcNSGQmEql3mfCrmizfBYyllY5cSO6bKmnTOOQwlI9rqUz+DV2vABqG9x0TUeT7BOWy
 IzPhmhSQln12Nqu8a/xE+69wkWwm9tQ6QiNBo9bJV4iLWR1AoqsmJ0N+05YYRegbYuyu
 jv43Q0RGrYZp6OIAwmHsTHWasrru/QUrYgP97yTtIdeBuQg/ANzKmogjx/LhoE7p3+za
 IIZBPFTEctduZ4rlAh5BAOyP1ASych7uEyTs6msvY3qs5oNQZwqaoc6klKx5j1o8bXrW xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwrl015281;
        Wed, 2 Feb 2022 02:42:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dvumggud1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+ABBl/h8RMU3VxjsFftBjP2QUuoKbMWxtTjReVMmSl+OhRm1GrwtTcv2mIHkU/xsCM+4S9LN6COcZOyATZbEShY2ooX1dAHG3KGo8dWwQXHocAUkuxCPUesxEzNTtsAv2Ltg6Ktjt2AFCeCoAWc4JO01SdBRGVzVoF9AGaki1Va6Ljch3N2f6aCPwNO9H7cWJY6XXhlEai5GmW0oFsiY7jVwJLI374kvQPDdb6C21QqAxT/GEjSKY5FU3r2jYJ5HylPYdT67RVuDlGvsqE9tF8CGQSL1ySXMHUmDPZil94Re33ZhFKqA4dcvhw6FTl7o8qet1OqiP/jenPfYhcQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA8vMoB7l083Q63xAY6AychJP+sRI03WI1rkY8W9gKs=;
 b=iAGpPp0rjPAJ60JsGEW5MBze+4aQCyHMYq/0PtxWZf2aIEzJWzjDbBaB3VdUSpYGd1M09F4LVcTE22YYzVRIEzIx6RalSyBsyGPHpHzb2w9u66xTWerq0alyZPKIQBaVyM+dlJfbt9kepuLwroRE3lLxW9KkoMVVpiSuiP4XasJZ1eQJk3MHuzNW6uJ/2oFPz8nroUansFtivwh5GBdhQLXxC51KZibp3E6UgWqd7nQNMijR528CeC02MT0lK5VaBix6KL6v13L2KsGoCA01zGhkDTdXRfjZfggdwqRCCBoEys+uWV5S1B4Jv5R+nq9EXEb3YEvEFhhPHRU1njS4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA8vMoB7l083Q63xAY6AychJP+sRI03WI1rkY8W9gKs=;
 b=SAcnIfFPRS5licEXb4w2P+XYXLhSCT2G2cvtzLoXY9ktFflUHZF/RrBHq1RaYAjsUJJisp7GCZu8/WndCRV7MkLwSC4y2UN1UcPcs2P4ToN14QskFBKZFd91wMLpUP/E8zdAy/dcQnPB2t5UoTOmgMKW029WbtggZwpqbbdIKRU=
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
Subject: [PATCH v5 57/70] mm/mempolicy: Use vma iterator & maple state instead
 of vma linked list
Thread-Topic: [PATCH v5 57/70] mm/mempolicy: Use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYF96A1IHWfKJi3Em6i+RYxd8Hsg==
Date:   Wed, 2 Feb 2022 02:42:21 +0000
Message-ID: <20220202024137.2516438-58-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33152de1-b202-4d45-07df-08d9e5f5b870
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58652E4729F1962A12EEAD7BFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qw7vfbAEkXnLXSq2ukvX3JVxTFHBq7FanZqvnvuXwJKMk5k3X/dBPUJnX5R2i7P9FooruWnv3CTGEWw4JT5QNhFWSIfoZRiUXBoJnvgI69CLtrSxQL9xQBqHU2+PzaYNSvjRgtraor5Jwtdd6PCBg7jNvyySiI0E2CLWLtgjFJCq6IyTA94o3J8HjcukSKxhTPX83V9o6i71xeK6Fm2cUBu17FbABrEdrlkXIDaZJUGj5zssjFXSXszMzUAxq+l8eOLfLkneFHxaHH3S1PEgWA/JEPfLnq+8q0ibM1EUm9rfFBOthGgl5pZDRGwYtRflvgtSBjF5rP52YS6y3ziY8SP+4c0LuRxCEf9uldE+/XElr7d5yM3YCZbFe5cLx8zXUqDjQZvK0JfA8+Emasbn0vjVG7x3NN9hKJd0mvJy4q7twBm/vAsCTM5tTh+1S6n1RvxLN3YBNVXfgRCL8SKzwkokwMWljQTXwm2q/Bmibm6Vd4SA5kUugrgahK5Uf4EFvYcGRNa1uYi7wuyAn4V8vC9exommMsy1wGz9AjjlzmhJpdl/qETbKSulv6yQgVNlpFi/P8oLHkX+5sSBMy1Skb/ZqDONvJRWvluGw944j5FzyDq1wtlnrMoi877zYHKzi7+YC6vxy11+bJ8zbkq9bmFgsK8zQ/dX5wKNxcHJ8KqDwpxstgJ/+TPAlXgGtK6Pu4+MB0+s8pcxU85nsF3aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UL1faLCM0dyFylemI5R0KmQllSMZeUgzXpcrzRrzDlaLPX7ftUZXPmEWz3?=
 =?iso-8859-1?Q?R89OZBUV/3Pf372RgG/N7lqJdSITo4394Zc0CPpOmeUKoNfcZ8yccL0UyF?=
 =?iso-8859-1?Q?bANyjyhlVZNpcOKLBPSSaS2YwzvtibkddhPdEP9XP5wz1FF2huxo1FPZE+?=
 =?iso-8859-1?Q?jKTCgQ6eHsUHNiib0bR3/KJYMegXFbaqsg1aACuS+wBXL7LYxhk2qhppQF?=
 =?iso-8859-1?Q?XFCziglsqNk5TNnXt6gPhQ4AZ6ukM/PAzYUbT6T3beAtkMWEGs/LGlfgeB?=
 =?iso-8859-1?Q?GGgsAspIN63DbKhto7JOadmxReZL9VBr3j7o2DAz1W+5IgDlvoCOwtAmwj?=
 =?iso-8859-1?Q?FfjmCYvnmM1FESn19Dau/cACl//Bt3u5WGCQxKpz/zPFuP6jfMVhEkOcZl?=
 =?iso-8859-1?Q?mA42N1ga56UXw3yv59QKRaAjuYThJYbAkmLxf8rHNKMDq7XSJbqI/p7BN+?=
 =?iso-8859-1?Q?ZBpySwFvim4ddTyBQ94ZufxLJmw3r+NtjVksp9jV9QTgcaHeauHmlH5Bsr?=
 =?iso-8859-1?Q?xEQ46zad6HZn6ZEJ5/Yn/PQvxNy8zqYAuolYCPQoHpiGn+CTgyaGm67BSx?=
 =?iso-8859-1?Q?U+mj/LziUSQcbVrP9O5IKpCfszQxBotV7UtvVsm8juEDlJ/N76FZXWQgo8?=
 =?iso-8859-1?Q?REziPZdduxiroQSGJOkTkPDWgebpS1r4qCYKRdZq3CNI0Shz3wI5BKIUHx?=
 =?iso-8859-1?Q?UQpdXR7BypIcwNQRh0rrC/GBV5eHE2YIsJLTOF7iZOc41uMzul/VJZtaeL?=
 =?iso-8859-1?Q?2c+xurTNjDpfeIhDzEhUXN8Qi8opifm7jorBl5p0LoSXWHSaXEmJqnL8dy?=
 =?iso-8859-1?Q?8TsTblgeALcxUjMpbm6BNQnKVDCE48NKMM9TMjbW4pxFFXoDXwibIl/3fQ?=
 =?iso-8859-1?Q?/F5KsnGdM2F059yaHh9QZcJiqg+eQkvtNw9ibdiQsnQtDIUsarGpDJrmWy?=
 =?iso-8859-1?Q?WhpfJO0etRGn2SyS/oekMGsctYlqiTsK5nlJAeS3JrZP+kklZTgn1gAbx7?=
 =?iso-8859-1?Q?igYN4zdrRDejVJjgOFn+/gl1yXAkV+/xH6IWDgS27FB3IZyEboTyVg/Ty4?=
 =?iso-8859-1?Q?doJ1rq1YiSgyMfI/ND2i3/hwXnBHOCi+cJalhsFKnDvKLcSA/7ynDDicS+?=
 =?iso-8859-1?Q?BboMR3cIsWkg+pkaYs13/qlcrFpxHc5fVuZoGFNe5SmXzJcyx/k+YSnz1v?=
 =?iso-8859-1?Q?IpBsOazHR6kR30YgQCmpIC+3MQi+sQW4Xg23G9bWYQpVTljvGbjOOD3F8x?=
 =?iso-8859-1?Q?U107WbV2WmtV5XIi0CURnnb23uI91AidUi7OSi0FzfqXuwtw7wSJ4jccw1?=
 =?iso-8859-1?Q?L4oB/Jd+kSi6sEmBis38lVwsbF2Nnt5zU7CLudCeld6e4iObhHmA71u/UP?=
 =?iso-8859-1?Q?mw28icQpUFlY5Vex4QSjWEXCsXrLoDfzNiOaFZo3/61hsH2/fatsVBrtPL?=
 =?iso-8859-1?Q?2DJwPiiQ1KQjpRKc69TrayBbwR7ZN3Vgvh4WXT0OAOmMR0ivv+vZg17y5g?=
 =?iso-8859-1?Q?Nc1pDBjS8LxY+2mnwdbKsJGpp+UVqiD09AM9d+8CvJOXOU9E3nfmFR4cPM?=
 =?iso-8859-1?Q?RmWIxz1AatgtVC6yfDge+PncFFQrhOnOqpLL+kvMN8qyhe+VeZn4MgBbPJ?=
 =?iso-8859-1?Q?tHA9FqY79iTSvsEZifhaoaxhTsT496R6yPuSsXCZdmpbpX/1XJA7ZsZUoQ?=
 =?iso-8859-1?Q?VTwqCKVYuOrxUn1LWdY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33152de1-b202-4d45-07df-08d9e5f5b870
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:21.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+LpikStG3IAAOXgz8lDsgwPjs2GsfX1B3YTxj+7h0d68zDxy+X7rng0GXS8hbf4mU51/Of/Yx8aZeArlR8kfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: c_SFG_bPRHCwFUujJVOsg_tosaPCxe6s
X-Proofpoint-GUID: c_SFG_bPRHCwFUujJVOsg_tosaPCxe6s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should
be no functional change to this scenario with the new code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 58 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 028e8dd82b44..d058b2be8655 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -380,9 +380,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -655,7 +656,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -670,9 +671,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -786,28 +788,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *next;
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
-		next =3D vma->vm_next;
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -816,8 +814,9 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 vma_anon_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
-			next =3D vma->vm_next;
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -827,19 +826,24 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* mas_pause() unnecessary as the loop is ending */
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1057,6 +1061,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1072,8 +1077,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1202,13 +1208,12 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (PageHuge(page)) {
@@ -1491,6 +1496,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1516,9 +1522,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.34.1
