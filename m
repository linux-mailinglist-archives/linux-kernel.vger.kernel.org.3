Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D624A6A07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiBBCmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42118 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243941AbiBBCmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:16 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120PIsE004733;
        Wed, 2 Feb 2022 02:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=by76hBFP/K66xoY8jqr2oYeW6B+BpMXgyo7K/o+Hjes=;
 b=IRwpfOWhxv9O0xWxJlZiR+ybNKjibHdF8Xi9Ik8NRS+dBpUZhZXLcfetU1Q+QcnMnVM2
 afXD6QfbSQya7D/F06ysqnvG8lWFtEKgeNkJb7zRCuG6U6iQOo94+/N6EC4w/hAMKn4+
 5fhVYwb6xhTjqLJFXVuQHwGv/29AKhwzOqyPv0LwbPqXuaPfkunBUxjhPZe3IQqNcnrs
 yt8OJtVPLuionu5ouPDFmPkQ9GD98lfu92gBEX7lcwiUBPUkU9nVUkBgoQ+RQhRFWuC2
 q8856WZ/p7EqL5y0+OdKdZtaMX2Lik7EaCky78BriCIXDvK113SyGEvnvwFKLVfKOXUw cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkN015152;
        Wed, 2 Feb 2022 02:42:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBO2vMxspud/+k2gs1kNKX7yc9gsfCwDevKOV9H2fvd3L2c6sAbyLNyKoXqYXu+KJneom3t37FZTCOsJOYUyWqG/7wKvD20sJxiaaOL3EKNqu7bBuFABUGo6QMlw4u2awRSv76kF2C1qYPuVqte0RkcbYn8dGM3iyLugJNe0FCgEx6KQ3Enb7EtEUh6++jNKkr+9SxH1qW0sja1mFmlDXzoJN+84kNxv43fnljx/UdUVvIPci0sjz4B2qzYuz/OkrUr2XE9UTxmUhFtb3hckDoRlhqDfezBx1qPDE9G4RXlZ+32vE6jEiY2cHbKCw10ZJ4uLBoC+MABA46aT9W2jLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by76hBFP/K66xoY8jqr2oYeW6B+BpMXgyo7K/o+Hjes=;
 b=QnGlvj83vfqhFTQHnMpF5WfwVvedqG19bnt1LFnEgm/e9wqrONA0+4WbGM8Tafif8xfN66iUwCLXoD97PXF8e30C2Y+uPAFAZAZBAonq6dP2GI097Pg36VrfCZYrLO2nHkn0kZg+szCdHk/pxRXidk/zMtgQVaLlzgEGKZTfQT7+CfjADmVSjyhJ0WsAhY5m6MQIdpL7WOBdjixK+zlHRe9KedxfJLEAgTFG/DyqTVzDTQ5BK2tgaBjtZECMLV4+U68KhwzneMZjQMJlx1S068JJG7p2oFUegHM0r1QErTNusTqYvceVEsB22vt0XrG00jYxfhymSXe7+j/uXHLuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by76hBFP/K66xoY8jqr2oYeW6B+BpMXgyo7K/o+Hjes=;
 b=p2p5bFyDlltK7mrUfxUjKtKJuxMsRgA7xKf6VVTa5lGS3dRLIDM/mQLCI69T13MRtO+zp5B/H+G8vxdMhlMWWz3yomfEYQLYQTYI+Q3AOxudTkndHGRS1sqLonH2+P4pw0H4dGviXnHzfgQDA6wAO9loElgkiBmPiZniZDB7nVo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 15/70] kernel/fork: Use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v5 15/70] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYF951lzhurrNAW02to7QCIMdfVw==
Date:   Wed, 2 Feb 2022 02:42:03 +0000
Message-ID: <20220202024137.2516438-16-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca36bd5-3349-4a81-304a-08d9e5f59a08
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397073360B1253B52ED0E10AFD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrDSlK2kSDHxF6uMxeFkDH9W04tfH1FbnvokjPRTTsDp5IBZQDlHfIslPr+aAAQgg3xDGSHZd5KHsGg4JBsKbtcRPCxDsqtLKPBX0Av6sZh66A3IGZz79Tqga/aYwJ9u/TOaLoQtVGVmzycdJOUzUM2b0oCM1QCDv0RUbqYDeg5w9oKoPuWIrGeyU/73L1t7y5Y1o+q32lyO+NGQttlUddUnM62eKCo5r2gyoYpoA1Z8qMgeWLNwsRiYe3a/QDRooRrpBV8KVGJDF7TE3tSVSN5l1OWFLEnP1jhzp+HfiCT1t4cBMK3xVVG0of9cOZ4oLpDLKDgVXtSRZQxi1+0aYZUpG/FKZPZJplqFRUe6UTEWy8hafiGfYIWvcOIVK2y9E5hzFBgFCPwxGwITxkvvoORG5HZ3Aht1fkNtIiMyolgGojhckOfJPJ2oSD1kM1kOZccLtM4ocwQwxQxADUgsfy9zb4V+IFG/8bQxHKbWLX/A1PUZ7K+IRoXY7yRe3rRgVEjrY7XS7Jw6oeVyRgIM7kslX9XUcNKb3kRIwUFWsjGx8HBoH2cSEpBj9CwCZSyinULQ3k+gJTJnOrY1V1D1RIvtJZLf7Zs9EBTBWSEUsc6o5P2soMfa0ZgMjRArI+Q4uln6cYRRcXYEtmDt62D6NyhBZy9TSyTOiNo6vI2VrXQEu7aiofDtzDJ2c7Vxd5tccVLTJB3FJx4ysaMVIped4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6666004)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZBz0Cf5AFhOeDci6Zjr9n1rK/JQ+NGFJbXF/s+x/6pNoG7DHZpCUBurF2J?=
 =?iso-8859-1?Q?HGyTSNlLsKaCCVGnt1q4RNBFHDNXyX0m5N/g3K/ezfQCf2jKdRFYdVflO2?=
 =?iso-8859-1?Q?BRMb8Yv1v4aKC+DXuUCpNab2KauJzvVXZnJVDql6ryud4ADhK4w4yKCQYe?=
 =?iso-8859-1?Q?EK8VKBEFaa0tEUrlgVExPRuBkdnEZPojRAoEPN0dHgS7d/vgAn2Gp62frO?=
 =?iso-8859-1?Q?JV13rcY0RQ3pDUD24S1IRDS1yl0eqt+fZc5Z0Z+nE26bqBxkYRvVwbl/fd?=
 =?iso-8859-1?Q?6TamdnmVQWZAmLU13jeDbhkJudiGjQCM7QgWxkXAwbDQmUpZimKxZokBdY?=
 =?iso-8859-1?Q?omI3a6vzN0uRAgA1c2wJbSXislPiftS7HMnheRbR/WZbTvZe2YO8g+TeoG?=
 =?iso-8859-1?Q?FTe62ESVZpARyyGTsfBKJJY/7xtaVeGdl2ySOLBBAOCoxzPs3HcG+uQ5At?=
 =?iso-8859-1?Q?/ZK0k9TUExdAeCXsvkhbD/YDF1sz1Wu/RLKa15XqGSl6JVQwEVfwISGGfu?=
 =?iso-8859-1?Q?ww4ozMhpX7zBcyivW2XBBqkReCtoriMoy953M+8DWuFbQnXyzhgkkIlCC9?=
 =?iso-8859-1?Q?Ppv3y+0NDOi1PrE873dVrkshwOn3Fu1O49+rNyh9UldxmZ0qWngxMzI0FT?=
 =?iso-8859-1?Q?Oga+s1lPIcnhYITA3YJi+LSpwa50gklU7p1w/RfBxgrstuSvs/COp7jcBq?=
 =?iso-8859-1?Q?RGJWyJGJ8Zv8uQSwx3T7l7lPMVHLBopoXfqYdaMhpOoINAbL7hDky8ZJCm?=
 =?iso-8859-1?Q?xtQopnSyP+iFath8ZYbN5/W5HUx3pWAfPN6VhgEqDcRlR4r02qycn4Z34q?=
 =?iso-8859-1?Q?FA+Z9Kv81x4oiescx3U8eWyntbl3XSUokuoijiq5UsVzaZ1udmX4GV3kuW?=
 =?iso-8859-1?Q?r85aBy4XXJ+2XfHCRDGU8V18XgFNgzL9WRuowqdhDMbzhLujUAlGVEdgVB?=
 =?iso-8859-1?Q?gX/hCbeJqXN/COyvABVES/pJ2Su6l46nZlMK5v95NzkmZhCwT6jKhjyq/+?=
 =?iso-8859-1?Q?ielKrCfFF2QeEmKGZ/LgaEcCElBUadW4r+T8FujWJEoW07zsDXLDs7CJIh?=
 =?iso-8859-1?Q?CnXdgdjGSCJux94GKzMC0e584eDhalzyEcfvS1MXICnbVVX4q2f94k64oW?=
 =?iso-8859-1?Q?tnHO0UPKNNjlGHAWNkOabBtUJCl6Thd6xomdjVB/qRoVrnB2MIaQwWO2Qi?=
 =?iso-8859-1?Q?wg1Jc3sV/cb8hz6As5qQ5xDWmdhx2Zbc06jQKahIVdcFyQhrnVjLzmoo96?=
 =?iso-8859-1?Q?8TaslwBq+FKp/7GmQQDjKtPQIjdWYcTOlTJyKyHIghAmeoudSwXefZy+Rs?=
 =?iso-8859-1?Q?WJaIQvONCI42aXP1A6vcbaDIBHOBlvkEKrqNU21Q3In64N1RxawcquVZVO?=
 =?iso-8859-1?Q?ynzMDTP/LRCTqq1CQo4W01RLyOfI262jgqyNn8Y55lVFCdN4ljJgSn/bdJ?=
 =?iso-8859-1?Q?t16XqpdHmVBmw4yhFE60vJpcPlRyzztUSVD6aH/kKZyajcS/aWXTEVkEVM?=
 =?iso-8859-1?Q?ou4VvkKLgPkVIgP7kxWj8vjFIdmpjAnwIjKP9MqxkdQ6GllqcBlI0XFAWc?=
 =?iso-8859-1?Q?8SDnC5bELGoxti6cuX4oxLkq9Wyubu7XqdVUo7QzU4IlMRAsMR6gnZS0Ol?=
 =?iso-8859-1?Q?dOro2QbvJjJo9abt9P+dTWaMAg20+09Cbe8kvdkBhYPM6WUsylCQzytaZr?=
 =?iso-8859-1?Q?JquNFosKLrZdWYbjwAU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca36bd5-3349-4a81-304a-08d9e5f59a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:03.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJB7EONsTEHJzEn+CiMHBnGc2e+ZvKG1kPlzKdVVQS5R13KTHJ9Bx35dS4xZCNvv8ghXGbedSpJpRhSLVBv4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: LGgQkzmZ2SZ2-PavRz3PPXtVWuA6yylj
X-Proofpoint-ORIG-GUID: LGgQkzmZ2SZ2-PavRz3PPXtVWuA6yylj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to
the maple tree advanced API to avoid multiple walks of the tree during
insert operations.  Unexport the now-unused vma_store() function.

We track whether we need to free the VMAs and tree nodes through RCU
(ie whether there have been multiple threads that can see the mm_struct
simultaneously; by pthread(), ptrace() or looking at /proc/$pid/maps).
This setting is sticky because it's too tricky to decide when it's safe
to exit RCU mode.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does
not allow for the most efficient copy method of the tree and so a bulk
loading algorithm is used.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h       |  2 --
 include/linux/sched/mm.h | 13 +++++++++++++
 kernel/fork.c            | 35 +++++++++++++++++++++++++++++------
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0353e9a902a8..cc6f72c86f3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2609,8 +2609,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aa5f09ca5bcf..f1226b49742e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/maple_tree.h>
=20
 /*
  * Routines for handling mm_structs
@@ -78,6 +79,8 @@ static inline void mmdrop_sched(struct mm_struct *mm)
 }
 #endif
=20
+void mm_set_in_rcu(struct mm_struct *mm);
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
@@ -96,11 +99,21 @@ static inline void mmdrop_sched(struct mm_struct *mm)
  */
 static inline void mmget(struct mm_struct *mm)
 {
+	if (!mt_in_rcu(&mm->mm_mt))
+		mm_set_in_rcu(mm);
 	atomic_inc(&mm->mm_users);
 }
=20
 static inline bool mmget_not_zero(struct mm_struct *mm)
 {
+	/*
+	 * There is a race below during task tear down that can cause the maple
+	 * tree to enter rcu mode with only a single user.  If this race
+	 * happens, the result would be that the maple tree nodes would remain
+	 * active for an extra RCU read cycle.
+	 */
+	if (!mt_in_rcu(&mm->mm_mt))
+		mm_set_in_rcu(mm);
 	return atomic_inc_not_zero(&mm->mm_users);
 }
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index 51a7971651ef..8ea683fcefcd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -377,6 +377,16 @@ void vm_area_free(struct vm_area_struct *vma)
 	kmem_cache_free(vm_area_cachep, vma);
 }
=20
+void mm_set_in_rcu(struct mm_struct *mm)
+{
+	if (!mt_in_rcu(&mm->mm_mt))
+		return;
+	mmap_write_lock(mm);
+	mm->mm_mt.ma_flags |=3D MT_FLAGS_USE_RCU;
+	mmap_write_unlock(mm);
+}
+EXPORT_SYMBOL(mm_set_in_rcu);
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	void *stack =3D task_stack_page(tsk);
@@ -494,7 +504,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -528,7 +540,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -542,7 +559,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -608,7 +625,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -618,10 +637,13 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -637,7 +659,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1112,6 +1134,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
=20
+	mt_clear_in_rcu(&mm->mm_mt);
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
--=20
2.34.1
