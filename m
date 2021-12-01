Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C705465013
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbhLAOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52498 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350198AbhLAOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:54 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EOuIb023540;
        Wed, 1 Dec 2021 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C3lUzOPpfZDtDhX8B8cIHBzj/PPX07AZKR/15slVePI=;
 b=shU03tAgw7kFok1TycTy3DcY3hcmIrzxvRFUjPZCozrMs+MpoJzRcIeyJtUe9qRj+Z8K
 dKYtfgY7BF7e6gJ+e4k/OGX9iwvs587iW2rrKC55rL8OHmdPdMtB5WGWZ6iKOMz7T0P7
 IQ6cjDwK0Mt10uPMx6iOOSUapiathY/GFQpphcYxg60KQKsvu8vUj+vUtBRbMoxep8eD
 ac/iyIVPL1mW0Onwj/UjJbs0/Hknv6v+R/RfeQO8LNvuqvyBmArmAfj91x+Im691El4m
 BWE2ekVphZXb7VTDHqFT25eOjGoP3ue6UiKjR+uALpGQJLSCOlvmiokjRKxtUppZqgoN DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkggb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL57032122;
        Wed, 1 Dec 2021 14:30:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djYxVQlwHVRuJ5HgDSnhKsjcLWGNCtxE5MXMernuTlfnc0LiyqWwnCUT8Db3uwGaU/6IX+yKwRiP3Yyo8VgIrD12ZmT27SzHFlvuL04Uv0vvMNYMGqfc3sDbiSVZ4oDzo3E/x0SNPc6pkMYNOtbF3jgCo+taanIxR+GwbY18/+RUNPoQ/5a5EfFIfiAhjJOUxWw0iDFEMWisNg9vRcbi32iPeEMl4kwL17HfnmBmWlfI5pzkm7P+lj0PesQ3blyNGnHgclNzJ3ycAN613VX4CLWSO4DoVcAw/K2+ZWazvrZtp3Cs5hFFILoY/Mxwqu5xDpl8rGcuVp61yYFjD8+3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3lUzOPpfZDtDhX8B8cIHBzj/PPX07AZKR/15slVePI=;
 b=WofJ2Dy1fLDhcxchtZMbQuTgo3HLsVqTsfm3S0vO7MBeZl1DyjmyMdYwDuKThY86KKus+RNEj4bKeV//PuyHf668nJRf+DYDkAPU1dk4s40H+ZaQvb2YA6+teRVJn3tegv/6lqpG/atJxFWMGxbV+rsrozAVxFG556GFYLSBei1Z7jdkiT06JNEQnw4QanHfLxQXFi6bJaTBXSioBUjHSaNVSUlKk2Q5EUUsG0XyeddN8pMEkzVTuS27QDW8W2WVndIPFXqIkN7Juv2m0ORkiXJdk+319sCtAya+4vwR0YRSI39owAN32Y87ENTSaBAveAxLX6cwFnv4nv9j8X7zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3lUzOPpfZDtDhX8B8cIHBzj/PPX07AZKR/15slVePI=;
 b=z4BY0+vsH2k3Me36mqnywnF6MG3Ub0j7zDHBnt+riJG1uBcDrcUbBHb1d6/pJa8NhWemF81J+yIJrdydejzMo1crR+Ag0T6JZZrl02o3rvBK+Ipm3u2aP7RQUdIMMgNFbCAkmVBCDkdMxGTzfuEq9IRlF/9V7VH38psZVpWEoHg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:29:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:59 +0000
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
Subject: [PATCH v4 21/66] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v4 21/66] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHX5r/rzykS1Bt/D0K2KeUVeWbMGA==
Date:   Wed, 1 Dec 2021 14:29:58 +0000
Message-ID: <20211201142918.921493-22-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb25dd76-5e48-4a06-0113-08d9b4d70dc8
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB30213B5C027FD8E348E88529FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOykKi6zB2VBEY5BEU/xK9aKe0mmyvWUsNRm0+vjiCzWjOTAk1ppsQo1SWYu6w9ahz/RoVoBCnhR6+xYv1V/Hm0NU0+JdL9u2RdCdwAi2gAQnkcsKFYg+5cxO5V7GXinCjYK2I0UFp9BE2TBNIg6mfJkH5RYwUeqEpd9ysH6gFzLodLvicoaykl9hzSsB9BUAWncRq+2zm6nNpRat8CMDWDkjZPXzgRR7qFNRAOgkVfQSSBx+cyQeJGVsGENclyEB+SZg8+ul6SzD3CfY0yuUvRzj41faYXj4yEKJGjxnaYX5D7cyq3xXgPdiAYyKB2dQJs9Z/DeezlN5w9c6yYWLfeoW6A7YZ5yuC3v04koCfvNlpCttClz5Pkd21zqEq1SQLhySQhrJfS8qY4Nk7Mg/MZ6fkhqOZBuAt+EYWZSYfE7FJS+bXQrHb35ZHyXhJLtCjgsG68fkE0aUaSTC+hbmbibBlOAZKyauF5awyFz9pByylQdjB9SV/R2gsC5qlaitRdI3cEz3iT/eiYJJC9GPKbnmgYEQpY/kw9neO9+Mj444wOkYqrK8WfO9Tbq3QsibbYt8gUQ4+WgW1UYEuQeu3pbVY+xAReIAY5pm9Lr8ipcdX0cnHe3i7JDuVQN6J8PQ/cX90LutZbR7SpyOW30JwwFy1EwI93FxVIthOFZvzs9GBMv1HI4T6PbvDSWGZJH+pMu6QM6v/lvlUA7YEJQ5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(30864003)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uBN5Xn3mYsG0sULc7etw8LjUsRTNcUf19KuYxaYB1sK4NOczNqqsT2gOYk?=
 =?iso-8859-1?Q?7MLhtnOhIUkhpRCkZJf53p+HCJKj2yxLWPE16fLETcGGwjC5ydgcKCIGb8?=
 =?iso-8859-1?Q?xV27C4sc4rutSpkuzS2iAF9Fa5NkJX719oEhs2C+Dyxvb2HsSTg2vpwkih?=
 =?iso-8859-1?Q?iOy1bgcvXrLQ38Qgw+2/ImUJivsty07SDL8su1REkj1b7/MfSbwXp+FMt8?=
 =?iso-8859-1?Q?eUvtypQ6lHLjtk75bl+M1XkD02X1v/Pul7sxcqoTZ+6io91l14EUf1m5yz?=
 =?iso-8859-1?Q?RpPgCK+r357EV6vwT215mWOofkpDgKI/CGG71DNAPhlTA5lNdTVheP4Ms+?=
 =?iso-8859-1?Q?0eNxZLwLl2jt4IpUyrbS8B6xmRoD1WF9Jo9R3x2KBClqNuPRRpzVtPoHY3?=
 =?iso-8859-1?Q?4wlTyNQGp1j/7TmOLLPpwTVukDGr3VZZuiiei++NXk2sokNeshVkqCAqiH?=
 =?iso-8859-1?Q?YZPoSTcTGQV8H0pHuqyp0/F3HNwjprPz8sESLMVxuPBG/T5FJh24BAFJ06?=
 =?iso-8859-1?Q?T0CSOEPIWkR3pvDgk5TKSD11IErSxBXXPD3V937Okp047QpmA3MhkPxL6Z?=
 =?iso-8859-1?Q?Jc8lWFfO4xIP30iJn7ZCDx/yF+A9jeEmCg4+CI2Z1XyE+hC9uk1Z6/WEda?=
 =?iso-8859-1?Q?4tmh8zgsCWmsLK7ijwjiXRHnHKPCzsVBVASeqYbXwR4TpYtMwtgDLMK+Yv?=
 =?iso-8859-1?Q?remL8aOmubcyBfaKkcwLPJqvBzlksmRceUDa8XE57LRZNOfhBvUDn9u+U2?=
 =?iso-8859-1?Q?N8EnjavtXMV85sUE420XRGgNBA9h6qLU1WaNZOi2C8Iphv5OnzIvwzat30?=
 =?iso-8859-1?Q?hkxe2D8bC7pmnlo5HVXZgU+aXk8yLBXrL7i98Dw852uK01SfN/O0sL+1+s?=
 =?iso-8859-1?Q?1zrwdqzFc0mZpHkudUBP4SmIiQzQlqKAXO2014NO0gB0klzyGXH3kqf/Rs?=
 =?iso-8859-1?Q?5H9tfQjMXFAa7OFfS19JWs2citJbKGCmCb8aLD4WI+FzypYqCKNDnyNdcH?=
 =?iso-8859-1?Q?B/z6SbakMg/UYZ1Kbm/kQDg7RLlDy34KCNQXFq/Ka39qRttnL0hxKufqxW?=
 =?iso-8859-1?Q?7onfFYQgIeVW+5/2/zTC9MMmi/eTVpCc2Pl9hgpK5dgo7rmIcjVImRy+cv?=
 =?iso-8859-1?Q?MGtoL/1kXpiaOhkPcmSqvBOV57pTrnm01pNUhOH7V+MclVqpQEOIUCDGJd?=
 =?iso-8859-1?Q?0GrEB4jtz9MemLkS7Vi10aDGj05hPZLr7cyXtPPKQjh44QEt2fEr6MBk/g?=
 =?iso-8859-1?Q?PHNdf24xe+Ie9fBWrd5W44hRdk8axZVDm2ageoCQADTsLyIObHsKCFAShA?=
 =?iso-8859-1?Q?s7q1fOeQmbWZ65n1acksF1ViNNvvfqJlU/239Wy/iWg5yT2gxFJ/t/ATba?=
 =?iso-8859-1?Q?hPv5+olzeaGNdrv34CDqwgQ6ixEPMqpqmAOJ6cFYdBh403L823TqUyptHY?=
 =?iso-8859-1?Q?yQ/By71DAv18AKo/4WretW0tR5ioJNHi5ZInqYlDlTM+fq3Nutu/BYuCBz?=
 =?iso-8859-1?Q?cO87alZzlFGZy+ZSfjlyrgLLKO4303D0FLrGK6hCZedZdEhXPWG5/O/b1u?=
 =?iso-8859-1?Q?zoRffz41InjezzXlQ9DyuhubIxaghodvv3LhNV4Don4OC44hoCWiWEdGM9?=
 =?iso-8859-1?Q?fkF/Q7dhiM9Ln7TGSdA7PgW/yfk1cNgQN6y0P7rTqxxcenZTnN0psRxVfd?=
 =?iso-8859-1?Q?a2qzgUGeg6rmetXfWnA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb25dd76-5e48-4a06-0113-08d9b4d70dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:59.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkDLGGBIBZbgD3ODUjj7BYv/H2nt7GGCOhN4R0TQwNULaNuqfS2BY3bmu8WEJZbz/ykVIFx6AXnBmb/nP4NsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: iezHDkqztrZahBHDq8FO1fMD_PbupuS5
X-Proofpoint-GUID: iezHDkqztrZahBHDq8FO1fMD_PbupuS5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to
split or coalesce.  This avoids unnecessary allocations/frees of maple
tree nodes and VMAs.

Use the advanced API for the maple tree to avoid unnecessary walks of
the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 258 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 207 insertions(+), 51 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c5f92666d145..e4c8ce377f2c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -188,17 +188,22 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -238,37 +243,56 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
-	/*
-	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
-	 */
-	if (brk <=3D mm->brk) {
+	mas_set(&mas, newbrk);
+	brkvma =3D mas_walk(&mas);
+	if (brkvma) { // munmap necessary, there is something at newbrk.
+		/*
+		 * Always allow shrinking brk.
+		 * do_brk_munmap() may downgrade mmap_lock to read.
+		 */
 		int ret;
=20
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; // mapping intersects with an existing non-brk vma.
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
-	}
+			goto success;
+		} else if (!ret)
+			goto success;
=20
+		mm->brk =3D origbrk;
+		goto out;
+	}
+	/* Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area */
+	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
+	if (brkvma) {
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; // Trying to map over another vma.
+
+		if (brkvma->vm_end <=3D min_brk) {
+			brkvma =3D NULL;
+			mas_reset(&mas);
+		}
+	}
+
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -1989,6 +2013,7 @@ EXPORT_SYMBOL(get_unmapped_area);
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -1996,7 +2021,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
+	vma =3D mas_find(&mas, -1);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
@@ -2713,16 +2738,105 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
+ */
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); // cause a re-walk for the first overlap.
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
+
+	// Change the oldbrk of vma to the newbrk of the munmap area
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (unmap.vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
+	if (unmap.vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
+	struct vm_area_struct *prev =3D NULL;
 	int error;
 	unsigned long mapped_addr;
 	validate_mm_mt(mm);
@@ -2740,11 +2854,7 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len,
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
-
-	/* Check against address space limits *after* clearing old maps... */
+	/* Check against address space limits by the changed size */
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2754,28 +2864,57 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
+	mas->last =3D addr + len - 1;
+	if (vma) {
+		/* Expand the existing vma if possible; almost never a singular
+		 * list, so this will almost always fail. */
=20
-	/*
-	 * create a vma struct for an anonymous mapping
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+		if ((!vma->anon_vma ||
+		     list_is_singular(&vma->anon_vma_chain)) &&
+		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
+			mas->index =3D vma->vm_start;
+
+			vma_adjust_trans_huge(vma, addr, addr + len, 0);
+			if (vma->anon_vma) {
+				anon_vma_lock_write(vma->anon_vma);
+				anon_vma_interval_tree_pre_update_vma(vma);
+			}
+			vma->vm_end =3D addr + len;
+			vma->vm_flags |=3D VM_SOFTDIRTY;
+			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+				goto mas_mod_fail;
+
+			if (vma->anon_vma) {
+				anon_vma_interval_tree_post_update_vma(vma);
+				anon_vma_unlock_write(vma->anon_vma);
+			}
+			khugepaged_enter_vma_merge(vma, flags);
+			goto out;
+		}
+		prev =3D vma;
 	}
+	mas->index =3D addr;
+	mas_walk(mas);
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	if (vma_mas_store(vma, mas))
+		goto mas_store_fail;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2785,15 +2924,31 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_mod_fail:
+	vma->vm_end =3D addr;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
-	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2804,10 +2959,11 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	// This vma left intentionally blank.
+	mas_walk(&mas);
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
-	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
--=20
2.30.2
