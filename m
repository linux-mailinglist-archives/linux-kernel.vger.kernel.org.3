Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12490464FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350636AbhLAOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47708 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350081AbhLAOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EK9EZ012065;
        Wed, 1 Dec 2021 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JzKUWwbZwn43FV3hmpFRmczudy7ssUxHOA8AReXzeoU=;
 b=njLxwZm3MZ0EhK/NSsZxy4rBxKGyPptTOvexaXGorJQEpxqZIzoUalg4YV0uOZ4M/TP7
 ynC0xyKJkIO66nt4enxdQHmDxVLhdIjwXeA46FFhr7DjeZTYPyx3+epRK/DLlALn3qvm
 lBYVy3L4yepfTuX9xBzZcSiVpR5hEA0GpEiLkzk5o6fefrw725AmpH0tBMBmrGQf4e45
 5qC9vKD5NmsLiTByPrPnpr81UEDKXqBGmTuA7egOlNTA+RZJQlvlnm5u6ho65esyLUBR
 JFjJCyloQc/rCTKjQ/ML3cakD9L5E/Von+BSrgGGgtlKJiY6CKpGyRS/Q9KskQGOQp5E Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBoq5037533;
        Wed, 1 Dec 2021 14:30:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3ck9t1v74d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiiOmnOau9piVf25dgFTIcFgMdLuxDEpQ0zGYVTIZ8uKKX3WLuYg3k5Qbkai7UkArCSVBFkh3AOOf+/tnEbzfxwNY3wEubWVNL/Xs0Yxj3yqx2J+eK4BhewNIff17w7jwIbjyhIcEFzfKG5eyfqp3iHqJ6QYCc+9VS6TGx5rThN8e5WQ4tPRHOaeXGF3Yt/CaOkctigg/ezz9vUnQnEPolagLZTcynki7FzBTcrvjl63x2n9BM0krJDWk9yPCNxJkmPmyYJ6llzat2bQiYWpt8AVO3tPYlqz/Rb8smRAjfWReL5wBOdV2xB03cNj6ajlCgvZrgDHHTSTkHoxdRKzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzKUWwbZwn43FV3hmpFRmczudy7ssUxHOA8AReXzeoU=;
 b=NIJkvcBNFOmLuRw0PmwI79LhzMk1Z37jHI569rdHLafqhEwsuGQPLXhBbIbPtLWE5s4+2g/MuHGIQI4/fZGn11vfCnXJKFphqmzmHXei0iryeHJNuVKT8VJCd1vuDQOhWUrKIachycOmFbugde3L+ju45zGzqnM7X0MzT5mCCCRQJpnJPKOyLjJ8j3KflXypdW2bFsE+ltQeZdNhtkn6l/5vGUKfuqDlQxsujBPtLWNVyX/MJS+xORyX0+puHD4HPe1bK6AmU+RWBK5TLB1MsKuHdFTtwB8meFVXuYZEEfxkqSsN1zgbjtPqfdU3rwu4SiTmfmakVKEHThzbHfb4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzKUWwbZwn43FV3hmpFRmczudy7ssUxHOA8AReXzeoU=;
 b=CTSTLJJzZmUQh3EQ8/Ja+xtxCuApm8hqujy8oi/U056SgBShgSmt6hoTVzGT4yDrhevjYpfeNI7kl+ujXxslD0PgzVcEsOHGbPkQMjmCg0ALkeQzDhCa0oJpe2tD6DBSwNv4QJ2xZn1bVxBU4eJdclmaU+ZVlOkyrceAI1usj4Q=
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
Subject: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/0Jk+tXlVP4UiIr9o8XNMVtg==
Date:   Wed, 1 Dec 2021 14:30:14 +0000
Message-ID: <20211201142918.921493-56-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fb325f3-220e-47c4-bc84-08d9b4d726cc
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB2464AE71C563F0449B52435BFD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBKyYaOwDjxoVUmlIhbwwNd+Urk2P8P6zFQ2iFLIlEXtxXknPNIaK+njLrygpymwSa/j86hey334Fjv7rSCfCvcsVZvL8f6hxqK+rRQAdwAEQPJTGGE4uKjpFOL838/vuMGC1J54acuFTGKHEAObSzqlt75GVlcqQWYyLZZLRLSuUiRJkQw/lhIByploiu89JVvZkPFcFfNJXyYWUJjiyFkccy4PuqbKG8wr+/e0BNM1Co67EcFLwaMayhodDC7JQTXOIFP/nVtYIrNP1pYJVOF9lUfkbdPNpukTFb6PhV86Tnx5cz3cAKj2fi49S9MGNpDnGmu7tOfZoco+mtFabuuRw2mjGt/D5nEdJ90Wg23myJ5EqAfa1Le2uiWykUKkTbVhGvwjq6WBirixn0DVBBH88uSmcoxNTqISBYY6URoZ0LsXdXFrY0KIj2KAWwFlAoP6zAyxHDZ/3SODElnh77Y+TU4NLOwgSLb6UhCBkjtHlQWbg+jpEqLXt8/LGmUCNMA/I2ySeU8qLfK5molVomf6HI7QmDGSNkrQm0+zMuAxXRfUxrlCfcTXqTD17Y75T318r8VjVN+kiQ1Eue53cyRYoQs03L2Q5hdJKTyBRNL0iWYfR5+22vk43p8YbpYkolbKpKreVVNpFkZX5hoduVGMx5+M41h+4MXFSDiTOHfxltThpsaRpXtIkgzCIcwZIPnni8+u7tUs5A0tqwnCbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y11ZEHZTDQ3sMyU+7ziiM50Z4F7PebItQSRP3emY9KjGi3RIvV9r11witP?=
 =?iso-8859-1?Q?WiapZ1A3oU7MyDlFWdowesZ/jOb+Gh6LdmoLnOtczD0ue71lvly/NCFJCs?=
 =?iso-8859-1?Q?NYQT+AVdId5fAVtVSaIedpLqzjkE24de7d3/WCmICG0cEVi+0bsStwD0so?=
 =?iso-8859-1?Q?H/9zhKm02SvNBiF+Nlczk6EPVbwqOSGi0ZTM8G6bnI5e1CsgZTXiR23R/R?=
 =?iso-8859-1?Q?ffD7/VMVuSzPl3XVA7RG9iL7a/gc2SBRi0+fTRca5C+VUEpk24xvek87gC?=
 =?iso-8859-1?Q?7zemr3O5ULf+XWfphMaLDvzvSgr0j8NyDm0VoP6BfaEm88EZm59ZC+N1Zy?=
 =?iso-8859-1?Q?aoWckZDEdlee4KQoT9eXdrqn6xPFkMG8Fg1oez+iDZL6rb+jD7xnoY4xmC?=
 =?iso-8859-1?Q?mMwnpWs6fH9JniaWPXgB8iryZKldt1gFot1zntdcqIKuRxu4df1bQ0FM4Y?=
 =?iso-8859-1?Q?Nkyu1G3rp78JDkgifMzxruT5IiRXg31lZHWXkePuOM3PDP10iwrmYuaULJ?=
 =?iso-8859-1?Q?HZa9c7JTO9klyC+pUAotFj1ELwmsAseckfIhFuqLcKcHCWbFLkzmmULoMh?=
 =?iso-8859-1?Q?fcRu6LXPTvsleZX4y3eY8kCklcrjL6dv587uZUyPPUtzpmf3npY0IgLYYc?=
 =?iso-8859-1?Q?U90gHkU/p61ZDTk1JptOzLQsOYNXoq4ZbE6uRsbn5TG+w0FkFETg+8/SyS?=
 =?iso-8859-1?Q?XwgEFYxANvbHdeK6XT4ad/kUa9338eQTcj0l0Ys/7klVyAdKV/rccGZNDr?=
 =?iso-8859-1?Q?lIadvpU17yITdG4osY8i5WWKBfN1bn5xoXOpC5QQOe0B1MvQ7dLu9zktQw?=
 =?iso-8859-1?Q?IUVfWZBiy0Gs6LRSpuL0dctGqLWS7+5BgrTamQk1KmnnFwQ1t+XkgSTQjk?=
 =?iso-8859-1?Q?i+rbK4pe3DtB/ZPFp19OHx2HMlEjLTqwQu7BHyRSsLtd9qBxUZ/TQKqlF7?=
 =?iso-8859-1?Q?uJ2BJzo8uQOtGHykRdATuLDUwVohL0hzocNjDvjw49FqPFLxyazCCSU0Kz?=
 =?iso-8859-1?Q?tFJO301Nm7UD1/wmlDVCcEXaToU/kGQikVKtuN+jHInljEhNMPcdkniASb?=
 =?iso-8859-1?Q?6IBhsWlUrYovyZ7X48g4+S/BDFcLlm4FPokyb5uX18NyjAQVoyonB3ZBI9?=
 =?iso-8859-1?Q?Qckceo1SHavXdCbn2vmewXgEJAS0r8mxyEJzsDK+4Q1Ky9wg0aNtCOKisV?=
 =?iso-8859-1?Q?uPD+BgnpjhTjqZexQqA6h3CqbGX7/hFDxwakSl5TcPpxcYKoz/TIedbNGB?=
 =?iso-8859-1?Q?LvlCT2j1RQWh/ptqCdAxm0MP9HCjGMh3P3LDYxUQkDjTZIyxab9uJH4mtt?=
 =?iso-8859-1?Q?0zeYnzNuWhA3Jj5wjAhbK9kwUAw3xVS+FimoiZxyBzr8/9G00M70NstcPm?=
 =?iso-8859-1?Q?mEnIdQVtTiN9jttfjSwU+8205KzzGVb5txI2ejhGB9echpfYVqFWlor509?=
 =?iso-8859-1?Q?pcuu0mBTtOxNQ550aOHkDn4dSO0+OlMvJMNpgmT9KKEmnqoeZpmzkwNcrH?=
 =?iso-8859-1?Q?aVVfFAS4EHGFW63OViKiAkacCSjU+TGqrpcfQHX8oFO7KFsSL1McpCWL4C?=
 =?iso-8859-1?Q?bwX2gnmZIp7YENAFxBET1g9aqys+qSBxnSHvnoCx3bSHW/MkUoVlamln4m?=
 =?iso-8859-1?Q?jgldVZQwx24AFw/VqUlEq4ATIepQToXyzy9Hkw7nOSNAeaY8gn9h+KJaaz?=
 =?iso-8859-1?Q?rHNYuM8g5gN6WSUZ1lI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb325f3-220e-47c4-bc84-08d9b4d726cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:14.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRSp+VlBAPRP69FnfGvQg2gapkMlN88enjtU59UFUlwkePoTL4dKwsPdvwR0Hq3TI5Ks7teTJMbJ8GIi+P8kOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: qneRTRhRpyVDpLmMLc6zIalFPhFNJltK
X-Proofpoint-GUID: qneRTRhRpyVDpLmMLc6zIalFPhFNJltK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 53 ++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10e9c87260ed..0e2d918f4f30 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -377,9 +377,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	mas_for_each(&mas, vma, ULONG_MAX)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -652,7 +653,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -667,9 +668,10 @@ static int queue_pages_test_walk(unsigned long start, =
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
@@ -783,28 +785,24 @@ static int vma_replace_policy(struct vm_area_struct *=
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
+	do {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -812,8 +810,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx);
 		if (prev) {
+			mas_pause(&mas);
 			vma =3D prev;
-			next =3D vma->vm_next;
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -823,19 +821,23 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
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
-	}
+next:
+		prev =3D vma;
+	} while ((vma =3D mas_next(&mas, end - 1)) !=3D NULL);
=20
- out:
+out:
 	return err;
 }
=20
@@ -1053,6 +1055,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1068,8 +1071,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
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
@@ -1198,13 +1202,12 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (PageHuge(page)) {
--=20
2.30.2
