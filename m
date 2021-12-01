Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7963C46501D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbhLAOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:43:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32750 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350101AbhLAOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:36:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDQ89010080;
        Wed, 1 Dec 2021 14:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=monZ3IS4GyoCe7hTBYeShQkMFIgkW8jQuOmMuMyvB4U=;
 b=nR2VAG3acFzenr0GHDvas4aMUHeNBVJ7j3cHDCUzY+pgOPPvqFkMhhDau25XT+2Uiz5H
 88nT3YnRBOZyluICFRFrnCLHEHDbHQ9vPHnicL20zgkSBrwYnjY3HSfCq0D6S4OUXlpm
 U5NFIJ/2tb0Wwa8XbWBVjal+b/p+WzlCP0NxB07Q9Z881sm132ReB4Q9rag7UNejRckx
 Nrd3UNtc2E7JoAihSVWGqfjg6knuqSt9Qo4nXimc6DDV0h4bd+EFRoDG2kPBsG/CBJEn
 ERT9tVpIdHd0VJa+Rot1PyQrPccJqjX62IEqBUwIjXH4Sdn1/BtOhKPJFooTO411IRxD Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwc109866;
        Wed, 1 Dec 2021 14:31:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyCdCOqN1P5BVM1EvZlS7624Gcmj5CfYEbXCUPAEcsyfCEevzwUxBC2PTqahpaOsFi0k09ff3Cgl5ibont+LDainfaxclKuk2q3TmhRhRx0uIuDcWMZmxJLW7aTCljgPi9RaFJDvF7ea0KCQTGVoJV9fDMJjLUgpqwLt2favtw5zDT7G+e8bsSDXNKg5wjR3gIo6OWVsC+/RUDA0rGhQLi9ZLH4+WOt5X8Wjlcs0jYXwD1mnZp+zw//9lr2Wu7I/uxMH3Rk409NSsJDul0bBZwG3lcG2bIoFEKXrQ6nsW8tGIkEAuMUNVBlWdxLT3YvDDgTENq8kWVcGANBG2dgiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=monZ3IS4GyoCe7hTBYeShQkMFIgkW8jQuOmMuMyvB4U=;
 b=idM67C9neGTu84RrrYO+Blrk08adLht3PTlkyFrG7ER6a2LId3UXJolfNlH0XFeyQ5CTFf9YAhGY67w05KCEnvCC8BmIDOBPMLUZrjDWtw8l8zFJJI1xZg4YoHoUtOyqFW+kYC7gaL0ewgBKZ2QtOghxo0skLRMZqXJtILFyQepLqsxLNnwCgUHDV2z2nURBd8ls0VVK6YXjg5Sj7ZCgU4s6a5IICcl0ws6KEz7xqqOF1L8cTg0pWDyDP4z5xjp+yLCnCoLMFg9ykKhiTu9KzzeE6mDFqvTYKWl44kqMtvcI9j6f2Av3CQ80+92NE0/mdseG+I0NdgSdPztGQcwY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=monZ3IS4GyoCe7hTBYeShQkMFIgkW8jQuOmMuMyvB4U=;
 b=Fkr+O+JzQzL4kCPnVO9vggABZpJhKIUmBMjo7LluhVKnldO8BIXYsR2FH/3WrOldUBzOq6q35jPGyodzwxOLE/XF2il9Ocawz0ci5JGm4Pxb4nipShLn6GVu6chji1qKRhVJdLC8lKkcEkz9yQ3NAVja/ot6Of13iXWxUlqEl+c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:14 +0000
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
Subject: [PATCH v4 65/66] mm: Remove the vma linked list
Thread-Topic: [PATCH v4 65/66] mm: Remove the vma linked list
Thread-Index: AQHX5r/8JI3RkHfoRE+zvsTKv6Ugjg==
Date:   Wed, 1 Dec 2021 14:30:28 +0000
Message-ID: <20211201142918.921493-66-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7dd24fc-1ac5-484c-034e-08d9b4d73a6f
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB24641106464663EA907FE216FD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9PNtnk7kjGPxHhAXyWWG9V7zubi5i8OME4C5FFZjj7WRO/L3DZtDekyU7ZFelQYpNxeZzz3/xh3ODvGPMrW2d0OdcqmJPODiBmpZm6xShBeSfhvoFRHOn4RdMGvqN4YY+aQ+ieoTpH8DpFOKrsnuDn/phVSIqwgej3YNB1vdSVc9wbj72U2NZx7Qnq0yQs8+spYOvk5rKWkG1QqnjrajKd51Ay87Ot9nAevEKOsUU4VQbDplK74jijjMlbn9ETRRrCIMK4yICU9qrdgZQ94TRcDIW2Az+4mBr06as5+5qIyxgGDItQBH6f0u/IQwVej/PHGtwPAGMFjP9NnExlN8F9YVG2vXErbOZJIRIYJEiEtTgxhJReOyrsC1HroKCjrDJflHCPkqTukvaR0/V21sleNi3WdHcVB50cXuepLE+UO70IgitFK+quROyBop59hRzNB6S42aFFiE7EgTFisaE+bCTBD0GCFlxHT1H/7hl1qDLfGwqZrYt78JC9HgglKSxYiMbbPt1BaIBKNYGqFYC3exaxg9xPk9lTk2iI07UT4kOeHymBwNWwXRFZy59xtf0j1jQn8rI8PXTXLLB8XvjkGejgBJkAQo/TaVF+gTnkfIiwp6/o1ddBGl+X908CyuEu2aKeypOnyrWrR+zvAaIf7YCXQ766n6uw6v4WHRB1YgMUqWcZYnzrsXGVUJ8ZHViGQixuhH2ymruWBigtJEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(30864003)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fWX9oIZY09Ml6D8dVmN1z3tjt6DTpXdnpxKJ0Pa/bUyhsKtEhoOy0Q+w1P?=
 =?iso-8859-1?Q?6ljT6K1mZ/Qp5kRafeozEOHHVvLhi7ehxx1EwHISq8jkmLcNcXX9jPqpAC?=
 =?iso-8859-1?Q?t7/D+zBlgeflgJNQGigDlWte1MyCWFH8YO6TNcTbDMoVjRdmmCFW8NXeGv?=
 =?iso-8859-1?Q?lhw4nKLBkwSabxAk/Cw6lJErL0ZFH5M7KDw5eprOlo429ewsXhVVwUwZB4?=
 =?iso-8859-1?Q?2/2CULloy/3AXnGc+d9dGw+MtilyL5KWxtroKLcAZNpVEHKtdl+SG1wkCm?=
 =?iso-8859-1?Q?ee7q//oFnYN63N1Ww399PqcDZ4Ug53ET1xk6OU0BVC9r46NE2hZH0hMFAH?=
 =?iso-8859-1?Q?pGnYhzPYKNkRkqjKFb+oZ4m4l22LQZJrR+Bo4n5YBGeKf+oby4DFcO8zPk?=
 =?iso-8859-1?Q?ykLhZ8nhEXlDoPfHdxCeDu+kr46Jhmbpzy4+OG4Oou7JX9M+JEW1ImkmY/?=
 =?iso-8859-1?Q?pJe1ZqyfKzaimErWbibhDMF3doIC6QZRLryLvVS6xtP8LBIP1M02zArEgr?=
 =?iso-8859-1?Q?WPPwyXalgGXZfmeHA78RWuHcAgcGzeCvwlgAoDyFoMJJDEkfA5Z3LC8EgF?=
 =?iso-8859-1?Q?Vg/8iRtGBYU1KDOM4rMzpd6igzVXNapDEiNvu6TtUv+TA7rTon0064oy2P?=
 =?iso-8859-1?Q?/tK5nKsG6x6l0bGnwKmJk7WdoatQMIc6I5E2kaw1xXLjYNNmPXy42cYDmu?=
 =?iso-8859-1?Q?QTZcXMhwE2fsPK84QhNHkrJsDTgO1hLmKIU+4EU1ubg9Ut48hDrGwnDcR9?=
 =?iso-8859-1?Q?gWckd3X+YFKZq912yUkvlFeqH6rB7mUExnSgA8GvjVUJ6eBK3tCqOHBbwt?=
 =?iso-8859-1?Q?xGrjGscp5OA67cOZzuWY+5Ez3H20PIP/Z0glI+u1pUTPzdV3JUoI6sYFUB?=
 =?iso-8859-1?Q?Shy/3xnCVbqlaNyxKnh1z9NPZUYce41u1H7Y6vrTGmZxDnbxysqJ0lTDIJ?=
 =?iso-8859-1?Q?NpgUNiZnz0SmxkZFx4hmsQaipuLlK9L+N/HipiyJgTJHVjr46vWphA1pjr?=
 =?iso-8859-1?Q?LqLPV78e8+ybkemqOcpDzae89z2ECXnFp8CEJ3x65S4gGCO6UaL9QkzHg0?=
 =?iso-8859-1?Q?vLC84nGaTWdvveHrgGKnzBzd1mSt+VKqx+RTSGcAMeEIOYUQBkw33Sk3iR?=
 =?iso-8859-1?Q?TXfCVvq5OQ4nRDB2SrLY+ZSKe5cXFfkTAtifvU38T266+Js7p4Oo6Q6WfB?=
 =?iso-8859-1?Q?7TJXRW3f7q3+RyuchSnTK0/CEgdtpN+m+ACJoei1SVws/yH9+g8crE8tgk?=
 =?iso-8859-1?Q?2F1WsiAfozfxo2z3pl/4COGtsfCnLP7WRHi3gaTwpIHy3o3fsSO5MxKD26?=
 =?iso-8859-1?Q?1UnWQ//82LUQd/0m1v2En2EKuDr8pfq22zmDyA7o6SZ280dDFO0pAAEOjf?=
 =?iso-8859-1?Q?Y0HRbt7qNxk52Nrh1hLQGks0vTi82YlfsQGUC1ObOXGaddb+u7dtlAJ9b7?=
 =?iso-8859-1?Q?ZP0WR06OGYv1Hi2An/4SO015uxwEgxnflOdF/IAksty8BiLyxKyog2kv3X?=
 =?iso-8859-1?Q?iZ3PVyXEAxRwHFVPNlP1kBa0Z5wETs9Z64KVvonClsTsc/8PbHqtQFTwvt?=
 =?iso-8859-1?Q?JHwrRsVuPSZWFY+s2Qh6uInH1tRvfUD4jZ3FbgZfMlJhDbl+uMeRC50fD1?=
 =?iso-8859-1?Q?LJWFa1PrquVXPLRqSMECgUM96ktvdqMup/p6vcnmmE1FPzXDGjECuKU19g?=
 =?iso-8859-1?Q?jT0eBGVc5x7th0MGJ+c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dd24fc-1ac5-484c-034e-08d9b4d73a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:28.3618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1RIhKecdoj4ZVVcJUuzVE4lW+Y/bmLUTSxHriA20PxKX29VXzWIM1QbBLNO0hU8E4rXMhP0qzPNRnR3gBtzjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: TZ_qQDyREFbCZq64znjvbWjgg-FSECyz
X-Proofpoint-GUID: TZ_qQDyREFbCZq64znjvbWjgg-FSECyz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Replace any vm_next use with vma_find().

Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
maple tree.

Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
At the same time, alter the loop to be more compact.

Now that free_pgtables() and unmap_vmas() take a maple tree as an
argument, rearrange do_mas_align_munmap() to use the new table to hold
the lock

Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
used to update the linked list

Rework validation of tree as it was depending on the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       |   5 +-
 include/linux/mm_types.h |   4 -
 kernel/fork.c            |  13 +-
 mm/debug.c               |  14 +-
 mm/gup.c                 |   2 +-
 mm/internal.h            |  10 +-
 mm/memory.c              |  33 ++-
 mm/mmap.c                | 497 ++++++++++++++++++---------------------
 mm/nommu.c               |   2 -
 mm/util.c                |  40 ----
 10 files changed, 269 insertions(+), 351 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 199f66716eef..f5a1394bad61 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1883,8 +1883,9 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigne=
d long address,
 		  unsigned long size);
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
-void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end);
=20
 struct mmu_notifier_range;
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ab6260fb164..1d41cef68f73 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -400,8 +400,6 @@ struct vm_area_struct {
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
=20
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -454,7 +452,6 @@ struct vm_area_struct {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -469,7 +466,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
=20
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index 6de302e93519..c748b7457693 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -363,7 +363,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struc=
t *orig)
 		 */
 		*new =3D data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next =3D new->vm_prev =3D NULL;
 	}
 	return new;
 }
@@ -497,7 +496,7 @@ static void dup_mm_exe_file(struct mm_struct *mm, struc=
t mm_struct *oldmm)
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp, *prev;
 	int retval;
 	unsigned long charge =3D 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -524,7 +523,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -605,14 +603,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
=20
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev =3D tmp;
-		pprev =3D &tmp->vm_next;
-		tmp->vm_prev =3D prev;
-		prev =3D tmp;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1052,7 +1042,6 @@ static void mm_init_uprobes_state(struct mm_struct *m=
m)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
diff --git a/mm/debug.c b/mm/debug.c
index 440a0614d14a..3b6fb26934c1 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -191,13 +191,11 @@ EXPORT_SYMBOL(dump_page);
=20
 void dump_vma(const struct vm_area_struct *vma)
 {
-	pr_emerg("vma %px start %px end %px\n"
-		"next %px prev %px mm %px\n"
+	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -207,11 +205,11 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -235,11 +233,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/gup.c b/mm/gup.c
index 60892e5df6a2..ba6249fab982 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1731,7 +1731,7 @@ size_t fault_in_safe_writeable(const char __user *uad=
dr, size_t size)
 			mmap_read_lock(mm);
 			vma =3D find_vma(mm, nstart);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		if (!vma || vma->vm_start >=3D end)
 			break;
 		nend =3D end ? min(end, vma->vm_end) : vma->vm_end;
diff --git a/mm/internal.h b/mm/internal.h
index 7ec79cef3ea9..c617291f6d5f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -65,8 +65,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *start_vma, unsigned long floor,
+		   unsigned long ceiling);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
=20
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
@@ -455,11 +456,6 @@ static inline int vma_mas_remove(struct vm_area_struct=
 *vma, struct ma_state *ma
 	return ret;
 }
=20
-/* mm/util.c */
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev);
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
-
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..445c4a06d7f7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -398,12 +398,21 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr =3D next, addr !=3D end);
 }
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next =3D vma->vm_next;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
+
+	do {
 		unsigned long addr =3D vma->vm_start;
+		struct vm_area_struct *next;
+
+		/*
+		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
+		 * be 0.  This will underflow and is okay.
+		 */
+		next =3D mas_find(&mas, ceiling - 1);
=20
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -422,7 +431,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma =3D next;
-				next =3D vma->vm_next;
+				next =3D mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
@@ -430,7 +439,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 				floor, next ? next->vm_start : ceiling);
 		}
 		vma =3D next;
-	}
+	} while (vma);
 }
=20
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
@@ -1602,17 +1611,19 @@ static void unmap_single_vma(struct mmu_gather *tlb=
,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb,
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	} while ((vma =3D mas_find(&mas, end_addr - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
=20
@@ -1627,8 +1638,11 @@ void unmap_vmas(struct mmu_gather *tlb,
 void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 		unsigned long size)
 {
+	struct maple_tree *mt =3D &vma->vm_mm->mm_mt;
+	unsigned long end =3D start + size;
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -1636,8 +1650,9 @@ void zap_page_range(struct vm_area_struct *vma, unsig=
ned long start,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	} while ((vma =3D mas_find(&mas, end - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index dde74e0b195d..e13c6ef76697 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -74,9 +74,10 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_ARCH_M=
MAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
=20
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end);
=20
 /* description of effects of mapping type and prot in current implementati=
on.
  * this is due to the limited x86 page protection hardware.  The expected
@@ -173,10 +174,8 @@ void unlink_file_vma(struct vm_area_struct *vma)
 /*
  * Close a vm structure and free it, returning the next.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next =3D vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -184,15 +183,14 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
=20
 static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
-			unsigned long addr, unsigned long request,
-			unsigned long flags);
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+		struct vm_area_struct *brkvma, unsigned long addr,
+		unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
@@ -203,6 +201,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct ma_state ma_neighbour;
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -259,7 +258,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		mas.last =3D oldbrk - 1;
 		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
@@ -270,26 +268,26 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mm->brk =3D origbrk;
 		goto out;
 	}
+	ma_neighbour =3D mas;
+	next =3D mas_next(&ma_neighbour, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area */
-	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
-	brkvma =3D mas_prev(&mas, mm->start_brk);
+	brkvma =3D mas_prev(&ma_neighbour, mm->start_brk);
 	if (brkvma) {
 		if (brkvma->vm_start >=3D oldbrk)
 			goto out; // Trying to map over another vma.
=20
-		if (brkvma->vm_end <=3D min_brk) {
+		if (brkvma->vm_end <=3D min_brk)
 			brkvma =3D NULL;
-			mas_reset(&mas);
-		}
 	}
=20
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&mas, &ma_neighbour, brkvma, oldbrk,
+			 newbrk - oldbrk, 0) < 0)
 		goto out;
=20
 	mm->brk =3D brk;
@@ -300,6 +298,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mmap_read_unlock(mm);
 	else
 		mmap_write_unlock(mm);
+
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
@@ -318,44 +317,22 @@ extern void mt_dump(const struct maple_tree *mt);
 static void validate_mm_mt(struct mm_struct *mm)
 {
 	struct maple_tree *mt =3D &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+	struct vm_area_struct *vma_mt;
=20
 	MA_STATE(mas, mt, 0, 0);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
=20
-		if (!vma)
-			break;
-
-		if ((vma !=3D vma_mt) ||
-		    (vma->vm_start !=3D vma_mt->vm_start) ||
-		    (vma->vm_end !=3D vma_mt->vm_end) ||
-		    (vma->vm_start !=3D mas.index) ||
-		    (vma->vm_end - 1 !=3D mas.last)) {
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if ((vma_mt->vm_start !=3D mas.index) ||
+		    (vma_mt->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
 #ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
-#endif
+#endif // CONFIG_DEBUG_VM
 			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %px %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %px %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %px %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -372,11 +349,7 @@ static void validate_mm_mt(struct mm_struct *mm)
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
 		}
-		VM_BUG_ON(vma !=3D vma_mt);
-		vma =3D vma->vm_next;
-
 	}
-	VM_BUG_ON(vma);
 	mt_validate(&mm->mm_mt);
 }
=20
@@ -384,12 +357,12 @@ static void validate_mm(struct mm_struct *mm)
 {
 	int bug =3D 0;
 	int i =3D 0;
-	unsigned long highest_address =3D 0;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	validate_mm_mt(mm);
=20
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -401,20 +374,12 @@ static void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-
-		highest_address =3D vm_end_gap(vma);
-		vma =3D vma->vm_next;
 		i++;
 	}
 	if (i !=3D mm->map_count) {
 		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
-	if (highest_address !=3D mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
-		bug =3D 1;
-	}
 	VM_BUG_ON_MM(bug, mm);
 }
=20
@@ -472,29 +437,13 @@ bool range_has_overlap(struct mm_struct *mm, unsigned=
 long start,
 	struct vm_area_struct *existing;
=20
 	MA_STATE(mas, &mm->mm_mt, start, start);
+	rcu_read_lock();
 	existing =3D mas_find(&mas, end - 1);
 	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return existing ? true : false;
 }
=20
-/*
- * __vma_next() - Get the next VMA.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -559,8 +508,7 @@ void vma_store(struct mm_struct *mm, struct vm_area_str=
uct *vma)
 	mas_store_gfp(&mas, vma, GFP_KERNEL);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -570,7 +518,6 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	}
=20
 	vma_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -586,12 +533,7 @@ static void vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
 {
-	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
-
-	prev =3D mas_prev(&mas, 0);
 	vma_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
=20
@@ -650,15 +592,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
-
-	} else if (!next) {
-		mm->highest_vm_end =3D vm_end_gap(vma);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
 	if (anon_vma) {
@@ -699,7 +634,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
+	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
+	struct vm_area_struct *orig_vma =3D vma;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
@@ -741,7 +677,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 				 */
 				remove_next =3D 1 + (end > next->vm_end);
 				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next->vm_next->vm_end);
+					   end !=3D find_vma(mm, next->vm_end)->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end =3D next->vm_end;
 			}
@@ -754,7 +690,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next->vm_next;
+				exporter =3D find_vma(mm, next->vm_end);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -845,8 +781,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		} else
 			vma_changed =3D true;
 		vma->vm_end =3D end;
-		if (!next)
-			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
 	if (vma_changed) {
@@ -871,10 +805,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		flush_dcache_mmap_unlock(mapping);
 	}
=20
-	if (remove_next) {
-		__vma_unlink_list(mm, next);
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
@@ -921,7 +853,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * "next->vm_prev->vm_end" changed and the
 			 * "vma->vm_next" gap must be updated.
 			 */
-			next =3D vma->vm_next;
+			next =3D find_vma(mm, vma->vm_end);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -939,33 +871,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			remove_next =3D 1;
 			end =3D next->vm_end;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next =3D=3D 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next =3D=3D 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next =3D=3D 3).
-			 *
-			 * We reach this only in the remove_next =3D=3D 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end =3D=3D "end" and the extended
-			 * "vma" has vma->vm_end =3D=3D next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next =3D=3D 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end !=3D vm_end_gap(vma));
 		}
 	}
-	if (insert && file)
+	if (insert && file) {
 		uprobe_mmap(insert);
+	}
=20
 	validate_mm(mm);
+
 	return 0;
 }
=20
@@ -1119,10 +1032,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D __vma_next(mm, prev);
+	next =3D find_vma(mm, prev ? prev->vm_end : 0);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
-		next =3D next->vm_next;
+		next =3D find_vma(mm, next->vm_end);
=20
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
@@ -1256,18 +1169,24 @@ static struct anon_vma *reusable_anon_vma(struct vm=
_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
 	struct anon_vma *anon_vma =3D NULL;
+	struct vm_area_struct *prev, *next;
=20
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next =3D mas_walk(&mas);
+	if (next) {
+		anon_vma =3D reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
=20
+	prev =3D mas_prev(&mas, 0);
+	VM_BUG_ON_VMA(prev !=3D vma, vma);
+	prev =3D mas_prev(&mas, 0);
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	if (prev)
+		anon_vma =3D reusable_anon_vma(prev, prev, vma);
=20
 	/*
 	 * We might reach here with anon_vma =3D=3D NULL if we can't find
@@ -1906,10 +1825,10 @@ struct vm_area_struct *find_vma_intersection(struct=
 mm_struct *mm,
 					     unsigned long start_addr,
 					     unsigned long end_addr)
 {
-	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
+	unsigned long index =3D start_addr;
=20
 	mmap_assert_locked(mm);
-	return mas_find(&mas, end_addr - 1);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
 }
 EXPORT_SYMBOL(find_vma_intersection);
=20
@@ -1923,8 +1842,10 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
 {
-	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
-	return find_vma_intersection(mm, addr, 0);
+	unsigned long index =3D addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, ULONG_MAX);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -2026,7 +1947,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr =3D TASK_SIZE;
=20
-	next =3D vma->vm_next;
+	next =3D vma_find(mm, vma->vm_end);
 	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
@@ -2072,8 +1993,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vma->vm_end =3D address;
 				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2100,7 +2019,7 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 		return -EPERM;
=20
 	/* Enforce stack_guard_gap */
-	prev =3D vma->vm_prev;
+	find_vma_prev(mm, vma->vm_start, &prev);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2235,20 +2154,22 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
  *
  * Called with the mm semaphore held.
  */
-static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *v=
ma)
+static inline void remove_mt(struct mm_struct *mm, struct maple_tree *deta=
ched)
 {
 	unsigned long nr_accounted =3D 0;
+	unsigned long index =3D 0;
+	struct vm_area_struct *vma;
=20
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mt_for_each(detached, vma, index, ULONG_MAX) {
 		long nrpages =3D vma_pages(vma);
=20
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma =3D remove_vma(vma);
-	} while (vma);
+		remove_vma(vma);
+	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
 }
@@ -2258,18 +2179,18 @@ static void remove_vma_list(struct mm_struct *mm, s=
truct vm_area_struct *vma)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mt, vma, start, end);
+	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 }
@@ -2310,8 +2231,9 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	if (err)
 		goto out_free_mpol;
=20
-	if (new->vm_file)
+	if (new->vm_file) {
 		get_file(new->vm_file);
+	}
=20
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
@@ -2353,28 +2275,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline int
-unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
-	     unsigned long limit)
-{
-	struct mm_struct *mm =3D start->vm_mm;
-	struct vm_area_struct *tmp =3D start;
-	int count =3D 0;
-
-	while (tmp && tmp->vm_start < limit) {
-		*tail =3D tmp;
-		count++;
-		if (tmp->vm_flags & VM_LOCKED) {
-			mm->locked_vm -=3D vma_pages(tmp);
-			munlock_vma_pages_all(tmp);
-		}
-
-		tmp =3D tmp->vm_next;
-	}
-
-	return count;
-}
-
 /*
  * do_mas_align_munmap() - munmap the aligned region from @start to @end.
  * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
@@ -2393,9 +2293,14 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_=
area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	struct vm_area_struct *prev, *last;
-	/* we have start < vma->vm_end  */
+	struct vm_area_struct *prev, *next;
+	struct maple_tree mt_detach;
+	int count =3D 0;
+	MA_STATE(mas_detach, &mt_detach, start, end - 1);
+	mt_init_flags(&mt_detach, MM_MT_FLAGS);
+	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
+	prev =3D next =3D NULL;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2403,6 +2308,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
+
+	/* Does it split the first one? */
 	if (start > vma->vm_start) {
 		int error;
=20
@@ -2414,31 +2321,49 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			return -ENOMEM;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		/*
+		 * mas_pause() is not needed since mas->index needs to be set
+		 * differently than vma->vm_end anyways.
+		 */
+		error =3D __split_vma(mm, vma, start, 1);
 		if (error)
 			return error;
-		prev =3D vma;
-		vma =3D __vma_next(mm, prev);
-		mas->index =3D start;
-		mas_reset(mas);
+
+		mas_set(mas, start - 1);
+		prev =3D mas_walk(mas);
 	} else {
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(mas, 0);
+		if (unlikely((!prev)))
+			mas_set(mas, start);
 	}
=20
-	if (vma->vm_end >=3D end)
-		last =3D vma;
-	else
-		last =3D find_vma_intersection(mm, end - 1, end);
+	/*
+	 * Detach a range of VMAs from the mm. Using next as a temp variable as
+	 * it is always overwritten.
+	 */
+	mas_for_each(mas, next, end - 1) {
+		/* Does it split the end? */
+		if (next->vm_end > end) {
+			int error;
=20
-	/* Does it split the last one? */
-	if (last && end < last->vm_end) {
-		int error =3D __split_vma(mm, last, end, 1);
-		if (error)
-			return error;
-		vma =3D __vma_next(mm, prev);
-		mas_reset(mas);
+			error =3D __split_vma(mm, next, end, 0);
+			if (error)
+				return error;
+			mas_set(mas, end);
+		}
+		count++;
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+		BUG_ON(next->vm_start < start);
+		BUG_ON(next->vm_start > end);
+#endif
+		vma_mas_store(next, &mas_detach);
+		if (next->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(next);
+			munlock_vma_pages_all(next);
+		}
 	}
=20
+	next =3D mas_find(mas, ULONG_MAX);
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2455,47 +2380,48 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			return error;
 	}
=20
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -=3D unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+	/* Make sure no VMAs are about to be lost. */
+	{
+		MA_STATE(test, &mt_detach, start, end - 1);
+		struct vm_area_struct *vma_mas, *vma_test;
+		int test_count =3D 0;
+
+		rcu_read_lock();
+		vma_test =3D mas_find(&test, end - 1);
+		mas_for_each(mas, vma_mas, end - 1) {
+			BUG_ON(vma_mas !=3D vma_test);
+			test_count++;
+			vma_test =3D mas_next(&test, end - 1);
+		}
+		rcu_read_unlock();
+		BUG_ON(count !=3D test_count);
+		mas_set_range(mas, start, end - 1);
+	}
+#endif
 	mas_store_gfp(mas, NULL, GFP_KERNEL);
-
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev =3D NULL;
-	if (prev)
-		prev->vm_next =3D last->vm_next;
-	else
-		mm->mmap =3D last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev =3D prev;
-		last->vm_next =3D NULL;
-	} else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-
+	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (last && (last->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN))
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
-		else {
+		else
 			mmap_write_downgrade(mm);
-		}
 	}
=20
-	unmap_region(mm, vma, prev, start, end);
-
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end);
+	/* Statistics and freeing VMAs */
+	remove_mt(mm, &mt_detach);
+	validate_mm(mm);
+	__mt_destroy(&mt_detach);
=20
 	return downgrade ? 1 : 0;
 }
@@ -2661,6 +2587,11 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		}
=20
 		vma->vm_file =3D get_file(file);
+		/*
+		 * call_mmap() may sleep, but will not alter the maple tree
+		 * since the mmap_lock is held.  This is safe and will be
+		 * changed later.
+		 */
 		error =3D call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -2724,7 +2655,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2775,7 +2705,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
 	charged =3D 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2864,11 +2794,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 		goto out;
=20
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		VMA_ITERATOR(vmi, mm, vma->vm_end);
+		struct vm_area_struct *next, *prev =3D vma;
=20
-		for (next =3D vma->vm_next; next; next =3D next->vm_next) {
+		for_each_vma_range(vmi, next, start + size) {
 			/* hole between vmas ? */
-			if (next->vm_start !=3D next->vm_prev->vm_end)
+			if (next->vm_start !=3D prev->vm_end)
 				goto out;
=20
 			if (next->vm_file !=3D vma->vm_file)
@@ -2877,8 +2808,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 			if (next->vm_flags !=3D vma->vm_flags)
 				goto out;
=20
-			if (start + size <=3D next->vm_end)
-				break;
+			prev =3D next;
 		}
=20
 		if (!next)
@@ -2924,7 +2854,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
=20
@@ -2941,6 +2871,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
+
 	ret =3D 1;
=20
 	// Change the oldbrk of vma to the newbrk of the munmap area
@@ -2954,9 +2885,12 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma_init(&unmap, mm);
 	unmap.vm_start =3D newbrk;
 	unmap.vm_end =3D oldbrk;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
+	vma->vm_end =3D newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
@@ -2968,8 +2902,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
 	}
=20
+	next =3D mas_next(mas, ULONG_MAX);
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	unmap_region(mm, mas->tree, &unmap, vma, next, newbrk, oldbrk);
 	/* Statistics */
 	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
 	if (unmap.vm_flags & VM_ACCOUNT)
@@ -2980,6 +2915,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	return ret;
=20
 mas_store_fail:
+	mas_unlock(mas);
 	vma->vm_end =3D oldbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
@@ -3000,15 +2936,14 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
-			unsigned long addr, unsigned long len,
-			unsigned long flags)
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *prev =3D NULL;
 	int error;
 	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	validate_mm(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3033,7 +2968,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	mas->last =3D addr + len - 1;
 	if (vma) {
 		/* Expand the existing vma if possible; almost never a singular
 		 * list, so this will almost always fail. */
@@ -3041,7 +2975,8 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		if ((!vma->anon_vma ||
 		     list_is_singular(&vma->anon_vma_chain)) &&
 		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
-			mas->index =3D vma->vm_start;
+			ma_prev->index =3D vma->vm_start;
+			ma_prev->last =3D addr + len - 1;
=20
 			vma_adjust_trans_huge(vma, addr, addr + len, 0);
 			if (vma->anon_vma) {
@@ -3050,7 +2985,24 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			}
 			vma->vm_end =3D addr + len;
 			vma->vm_flags |=3D VM_SOFTDIRTY;
-			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+			/* Make sure no VMAs are about to be lost. */
+			{
+				MA_STATE(test, ma_prev->tree, vma->vm_start,
+					 vma->vm_end - 1);
+				struct vm_area_struct *vma_mas;
+				int count =3D 0;
+
+				mas_for_each(&test, vma_mas, vma->vm_end - 1)
+					count++;
+
+				BUG_ON(count !=3D 1);
+				mas_set_range(ma_prev, vma->vm_start,
+					      vma->vm_end - 1);
+			}
+#endif
+			if (mas_store_gfp(ma_prev, vma, GFP_KERNEL))
 				goto mas_mod_fail;
=20
 			if (vma->anon_vma) {
@@ -3060,10 +3012,7 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			khugepaged_enter_vma_merge(vma, flags);
 			goto out;
 		}
-		prev =3D vma;
 	}
-	mas->index =3D addr;
-	mas_walk(mas);
=20
 	/* create a vma struct for an anonymous mapping */
 	vma =3D vm_area_alloc(mm);
@@ -3076,14 +3025,15 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_mas_store(vma, mas))
-		goto mas_store_fail;
-
-	if (!prev)
-		prev =3D mas_prev(mas, 0);
-
-	__vma_link_list(mm, vma, prev);
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	vma_mas_store(vma, mas);
 	mm->map_count++;
+	if (vma->vm_file) {
+		__vma_link_file(vma);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3091,10 +3041,9 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return 0;
=20
-mas_store_fail:
 	vm_area_free(vma);
 vma_alloc_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
@@ -3128,9 +3077,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	// This vma left intentionally blank.
-	mas_walk(&mas);
-	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
+	ret =3D do_brk_flags(&mas, &mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	if (populate && !ret)
@@ -3151,6 +3098,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int count =3D 0;
=20
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3186,12 +3135,19 @@ void exit_mmap(struct mm_struct *mm)
 	 * Lockdep will complain about not holding the mmap_lock, so we lie.
 	 */
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
-	if (mm->locked_vm)
-		unlock_range(mm->mmap, &vma, ULONG_MAX);
+	if (mm->locked_vm) {
+		mas_for_each(&mas, vma, ULONG_MAX) {
+			if (vma->vm_flags & VM_LOCKED) {
+				mm->locked_vm -=3D vma_pages(vma);
+				munlock_vma_pages_all(vma);
+			}
+		}
+		mas_set(&mas, 0);
+	}
=20
 	arch_exit_mmap(mm);
=20
-	vma =3D mm->mmap;
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)	/* Can happen if dup_mmap() received an OOM */
 		return;
=20
@@ -3200,20 +3156,24 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CE=
ILING);
 	tlb_finish_mmu(&tlb);
=20
 	/*
-	 * Walk the list again, actually closing and freeing it,
-	 * with preemption enabled, without holding any MM locks.
+	 * Walk the list again, actually closing and freeing it, with preemption
+	 * enabled, without holding any MM locks besides the unreachable
+	 * mmap_write_lock.
 	 */
-	while (vma) {
+	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		vma =3D remove_vma(vma);
+		remove_vma(vma);
+		count++;
 		cond_resched();
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+
+	BUG_ON(count !=3D mm->map_count);
=20
 	trace_exit_mmap(mm);
 	__mt_destroy(&mm->mm_mt);
@@ -3254,7 +3214,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev);
+	vma_link(mm, vma);
 	return 0;
 }
=20
@@ -3282,7 +3242,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (range_has_overlap(mm, addr, addr + len, &prev))
+	new_vma =3D find_vma_prev(mm, addr, &prev);
+	if (new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
@@ -3325,7 +3286,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev);
+		vma_link(mm, new_vma);
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
@@ -3625,12 +3586,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
=20
 	mutex_lock(&mm_all_locks_mutex);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3638,7 +3600,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3646,7 +3609,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3705,11 +3669,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index acb9aafb0afc..cb03f9c304d6 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -574,7 +574,6 @@ static void add_vma_to_mm(struct mm_struct *mm, struct =
vm_area_struct *vma)
 	mas_reset(&mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 }
=20
 /*
@@ -599,7 +598,6 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
diff --git a/mm/util.c b/mm/util.c
index ab02382c2d57..934a120d1c96 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -271,46 +271,6 @@ void *memdup_user_nul(const void __user *src, size_t l=
en)
 }
 EXPORT_SYMBOL(memdup_user_nul);
=20
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev =3D prev;
-	if (prev) {
-		next =3D prev->vm_next;
-		prev->vm_next =3D vma;
-	} else {
-		next =3D mm->mmap;
-		mm->mmap =3D vma;
-	}
-	vma->vm_next =3D next;
-	if (next)
-		next->vm_prev =3D vma;
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next =3D vma->vm_next;
-	prev =3D vma->vm_prev;
-	if (prev)
-		prev->vm_next =3D next;
-	else
-		mm->mmap =3D next;
-	if (next)
-		next->vm_prev =3D prev;
-	else {
-		if (prev)
-			mm->highest_vm_end =3D vm_end_gap(prev);
-		else
-			mm->highest_vm_end =3D 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
--=20
2.30.2
