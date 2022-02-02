Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6743D4A6A12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiBBCnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49016 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243966AbiBBCmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120LxWw008539;
        Wed, 2 Feb 2022 02:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5CEsctlv2BmLTmYIeFi4p3MfdUywkN+RcJCnrjvOCk4=;
 b=uKa6IWViOFiMaIxpVI9PXSxHV+kU6jQCU59JXx0KEjAXOflT/9FjE9/G4eAJJeCAnGiN
 83Ask6mCzxdtTIPZH19fdl45D4JrFVbmjcXCF+xQLbOzU0tVnSe8OUuXUCVXamPt/gno
 sdUIpTww4MWC50qL82wZa2xo50EP6c0ykRDQuG6rlyoOl4Q5aoauWOBGcN0WwvVFIXsG
 tzIPBoutwZ+UVGE7JiDy6aejGt4o2Lk+HgTOSzhLciO0912GHDmyFtJ7/0K2HxO4uf1s
 WYXmBkMfjM0XsrR1IJBCzVSf1yccmsDzzKp+3koajx7PueM/n6Clb0jPPdCZw+hZdAcw Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvufc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSM126532;
        Wed, 2 Feb 2022 02:42:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjRJYlrHshTLPczW7J9vnu/1J7yNl5C4Ux73wnhgjjth5aM0P5hgYtIo22Lg2p1GO4R60Ze66LShsQl6xCi4w9U/dbN7AJL8PQ1NbmC5ixqP1UxCvGn9EidcNJQnIdd3hSNlpblsKLCmZAvrN0QNqmWQk7D6mzhb7mol6Aybeaq5rT0aLazda84rNL/XHAiz6G+S6iedm1GqTU8axMVtxj1MTHm77Mwm7XpKp3wv2d75RZZXFye7MbB4F/sPch1X2PHKofYiHb1gyjYzL9i2EGVaSsTZ43OHs0dk9r8W/uBqeUznTd0DYDk5UyXX5mpuVxTQWLWz8TsSAWBdlo/smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CEsctlv2BmLTmYIeFi4p3MfdUywkN+RcJCnrjvOCk4=;
 b=MxywtId8RVIIv+2sCsL5f+N4Qu+9XWCDfEg7UxtHPfa0COpDwzCenyqGrgFpDdoSdyqrnzqNdlyRuB4+wutgnQKGqjlIgyGsr+eMy9p3j1bWXp1ZVhTQ/N4xKZiC5+0t2n59FASIt0kYg4QtrQrjiQHgVqSAiYD9vuo4Xvv2yk4ih3hS9ivuFo9jV5mfLmosqbM4D67SUmRJP8vNS6HNe9fJBS6iZ+rkQk5ooWwKvaeYiXm6KcasrPm0p7bnOTtzmXIiG1fuoJDD61bkHsY9+kz/PJZK3yoyiz0BZTZhgPwO/gpNKhwpWHvqheLVWEFM1aqQk25XvBQnqtKGfQJedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CEsctlv2BmLTmYIeFi4p3MfdUywkN+RcJCnrjvOCk4=;
 b=rvOuLpyQF6jGAvZWYBL365sS+HebjuEsZV7j9Y+o1+twyVuTl1T4bkbI3/zPctPfYRgvXpGQeFc5XzwP7Gm2YvNPFITTDE8VxPhoOEfF+Jca+6HPbJIRoRYGMwaytljYhNq7f9ziI6Lahykq9A08Yi1DF9OOzJQ8PDHxZacWW7E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 26/70] mm: Remove vmacache
Thread-Topic: [PATCH v5 26/70] mm: Remove vmacache
Thread-Index: AQHYF955a9M6bpSsk0eWW93Exu1B8w==
Date:   Wed, 2 Feb 2022 02:42:09 +0000
Message-ID: <20220202024137.2516438-27-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f61d842-88e3-4df7-82a9-08d9e5f59d75
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129C6D5A5382F9AC86A1BC5FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jeAXmPIHidfc8iy1mY2kpLjYxS6JV9635Y0/H2FZ1a9SEQ4rleT/Ogy/8p3kAqx5BjcaZANsXxI3laAlkacZxPua98nTY1okGoyimeldWrbKEZZjxBNI2qY+w/8YWtEGQqDf5qXxZPV+8T1l/MCxezcio3gWCInSSSBScqpitXLWpUTbS68eaYuGcfjZaqbWaAIlob0NKcZkvzEGT8kn1FAYcsmtYwe1VlVWKrmzQ4EY2hcrROb1ga/uMpHqGplEDwdp8+LRaX0AvTiTNH9KHi58aAd26bMwlZf9h4y5pDoIqfXOLTSYkGnUi6tfaSHezsJixxl9/MSw5sLWOnIZw1+dIokSV5qIvpE8z0DkcVE9E76bmC/X1Mcfeyxphmmp5HbnkZvo8jePLLc5MBCimJQWdNbQNQ8xRVYYYjgJjd8eVJoND6SapiaaobGz13z1El2iDO5nqsRhyFtlayiLxYRZ8NUSHo0ZctV+dypbBWi26jEn0/sUej9Y0W9LEEbw+gCBsOI8Eth2aHTtQR89iL8P6dlgNeouoLG7cIB6Bi/Iy3KbE5QqChwtHzxZRIAwuxpd7QE3/2J++bKQPyrIX30ZAlmIPxvz6jLTEOeJBYE2Rx+FlB+xa47ilIjRWG9k+wqM/aTQ5p4M58KwPtuVWQBRe4HiR2+0Jv7Ai7Ck8AdwReHLP4cYc0rZf7dd3QXqH0IFAaxIfS8MZxjCGok/NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(30864003)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(6666004)(508600001)(6512007)(71200400001)(6506007)(86362001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?omXfBt5TWcGbFxVEY0ZvLT7uNx+1aSQ7CpYVA3UcRZ/+lEAEqThyxqIzhS?=
 =?iso-8859-1?Q?llReYNh6Zd68pua3xhM/AeldC64FKV5Ltgxq2SlSDY3QZ5jpwocBGtUHIa?=
 =?iso-8859-1?Q?dolqK42eKEt1+YGSle/WB2N6p1RxXW+NLj/xdHEl+Tmw1SglKJzVMakEXm?=
 =?iso-8859-1?Q?XclVukUa6bnkB4vCWqKWMQxZdU99JZcfKGj9VOrYyZhixRuELwYdTlBuoZ?=
 =?iso-8859-1?Q?mWWa3fYNH5Itie0iK6zK8wswXaFxX9pw5laYCdRbEqOuG1b228g4YecBVJ?=
 =?iso-8859-1?Q?wdl4ODMeeUHT+sBLlzsm4AStbG1gNILMW6GRyEYjgVAVFNRWgvINNrlqL1?=
 =?iso-8859-1?Q?viGnCgmVjYMs36hJbwMNP3AdxEqB3coevs/OVhsISGUxIYpaNCx+4woR9w?=
 =?iso-8859-1?Q?Ve+gLg0S7lFpSMntWwwO5nf0GIKBGsmgZYFgZRTBNCbti5PInDtKPc6wlT?=
 =?iso-8859-1?Q?++29ZASb11Pv9lOHqHMVq460jpfGxgR64nM8jmgmWlnyGEuKwdL5xXBt6W?=
 =?iso-8859-1?Q?DiShzlGscNRqvEVmgN3d3+TKir17YM8A6pMJZ0nE4CczqhpG7srUfbgZCm?=
 =?iso-8859-1?Q?18+GV0RSPsBZAsz2P5MvMJwKsgm9Y6flEwBVnNRnqmGmZaSqgUvG9KunRd?=
 =?iso-8859-1?Q?2Q4K74EbYdXWioavfJW66V/mRCSFpQqUWMITdFBh2FH6eOTYtA6RmUU7E9?=
 =?iso-8859-1?Q?wGyKGp6ZZ+EeTPFCgwoXKCNYZ1ERWtrpoNIjG3YU0jWlBYDI8jAI6yE2Gh?=
 =?iso-8859-1?Q?QoAXHYERQwTewuu97PaENpALlSNLCi75be85qLSqgRCvQne7CANy3yThx1?=
 =?iso-8859-1?Q?6wygM94zhQXbxsOU9Ldz8r5YYBBozK36OuTRKRpEfva2uEm0p/q/fzatj5?=
 =?iso-8859-1?Q?zwHgwsgkYbp0TeJoq/B+cw2tlyisxvLKxqFfr6c4fPsRHlYX+vwvVa9at5?=
 =?iso-8859-1?Q?oIKdN66cjCmEQpufVmVo9ZeF2g3nC7ieytb7J5bhNe+AQqsFwGHE3eNVRZ?=
 =?iso-8859-1?Q?fqHR/oeCkJvWl7shVytK/L1xHvWF0K9cwMblTughpLAzucEBPHW+2JFxp+?=
 =?iso-8859-1?Q?DlX+1K5VVYGOj8NrtcBVEW+Lh8WrfW4CHp6DNVWBP8Hg6bW/4eDHkDZmkW?=
 =?iso-8859-1?Q?XJQDPeppghfR+o97qSBKfSdU6jAAI9vZfDtKozqZ3d8IPwmT0Mlqh3h3KG?=
 =?iso-8859-1?Q?gnY+CFG3Bs6E1v5KV3IxQ7rEEUFbnsZ1i50zvZFRaWYMh1+AbM4/ijEvn5?=
 =?iso-8859-1?Q?cUH6luW+bySZ3AIxS3luxZYZ65it0QRHw/AkNjBWe4UivTsAty+tQN9uoJ?=
 =?iso-8859-1?Q?OFkaOJ/gzCOZGAOYHqdYNJaC6jPl2ARR64pBJ+hCwrk12cc3hknWRxOkZu?=
 =?iso-8859-1?Q?zAzACwhrTC8bJPdRKGG22WjcgjwX6AcIvWl0yGV0SweP7CfKP3zv2onpDI?=
 =?iso-8859-1?Q?IH5ParkMUVcVSK9iEDxLm/tvcSFhhp0+CfwimPIjQXp2d6EhXn6bCmNWvr?=
 =?iso-8859-1?Q?epj0cpkRZTHibCXJQDTtSTOHW+1RqCkmKHBF9iB1KFhuiELwMczt/yNP5q?=
 =?iso-8859-1?Q?6e6FbnwhIgyp8T5/b9ImCdFhw59sdhhl3EnEM3ira4qWNPXRyim66ytz9w?=
 =?iso-8859-1?Q?3XQlU5nVh62guhAb6YdEeKinSOJUblrd2Er6K1vDDIIKlnyUk7KNfuckSD?=
 =?iso-8859-1?Q?+NSkTPnqheMibUa0qOo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f61d842-88e3-4df7-82a9-08d9e5f59d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:09.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDPXDYJFUFcOjVQPy0CsfhsNQnABP3LzX9qG0eUl40IkV355pWHiLK6/NOwV9GurYgypHaX89BWdyESFWSl6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: HuOayP4zWPtBn7EpSrq3N7h0a6Qkf8HC
X-Proofpoint-ORIG-GUID: HuOayP4zWPtBn7EpSrq3N7h0a6Qkf8HC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/exec.c                     |   3 -
 fs/proc/task_mmu.c            |   1 -
 include/linux/mm_types.h      |   1 -
 include/linux/mm_types_task.h |  12 ----
 include/linux/sched.h         |   1 -
 include/linux/vm_event_item.h |   4 --
 include/linux/vmacache.h      |  28 --------
 include/linux/vmstat.h        |   6 --
 kernel/debug/debug_core.c     |  12 ----
 kernel/fork.c                 |   5 --
 lib/Kconfig.debug             |  10 ---
 mm/Makefile                   |   2 +-
 mm/debug.c                    |   4 +-
 mm/mmap.c                     |  32 +---------
 mm/nommu.c                    |  37 ++---------
 mm/vmacache.c                 | 117 ----------------------------------
 mm/vmstat.c                   |   4 --
 17 files changed, 9 insertions(+), 270 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..0c34b17932fb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1018,8 +1017,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 18f8c3acbb85..f57a98a39152 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bc5e55be5029..c36a3c4fc086 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -444,7 +444,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..0bb4b6da9993 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -24,18 +24,6 @@
 		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
 #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
=20
-/*
- * The per task VMA cache array:
- */
-#define VMACACHE_BITS 2
-#define VMACACHE_SIZE (1U << VMACACHE_BITS)
-#define VMACACHE_MASK (VMACACHE_SIZE - 1)
-
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..e55c0ebcff9c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -861,7 +861,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7b2363388bfa..30bfbd9ec213 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -122,10 +122,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_TLB_LOCAL_FLUSH_ALL,
 		NR_TLB_LOCAL_FLUSH_ONE,
 #endif /* CONFIG_DEBUG_TLBFLUSH */
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-		VMACACHE_FIND_CALLS,
-		VMACACHE_FIND_HITS,
-#endif
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588..000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..19cf5b6892ce 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,12 +125,6 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
=20
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..c4e6f5159bed 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -50,7 +50,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
=20
@@ -282,17 +281,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
=20
-	if (current->mm) {
-		int i;
-
-		for (i =3D 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 9858ce389afd..2a17d348c3a1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -43,7 +43,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1057,7 +1056,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1513,9 +1511,6 @@ static int copy_mm(unsigned long clone_flags, struct =
task_struct *tsk)
 	if (!oldmm)
 		return 0;
=20
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm =3D oldmm;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b72647c12940..d3bfa7dbbbfa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -809,16 +809,6 @@ config DEBUG_VM
=20
 	  If unsure, say N.
=20
-config DEBUG_VM_VMACACHE
-	bool "Debug VMA caching"
-	depends on DEBUG_VM
-	help
-	  Enable this to turn on VMA caching debug information. Doing so
-	  can cause significant overhead, so only enable it in non-production
-	  environments.
-
-	  If unsure, say N.
-
 config DEBUG_VM_RB
 	bool "Debug VM red-black trees"
 	depends on DEBUG_VM
diff --git a/mm/Makefile b/mm/Makefile
index 70d4309c9ce3..524b3799617a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:=3D filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
=20
diff --git a/mm/debug.c b/mm/debug.c
index bc9ac87f0e08..ef3555d07179 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -159,7 +159,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -187,7 +187,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index d70900dbcbea..40940fab9714 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -14,7 +14,6 @@
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -694,9 +693,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
=20
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
=20
@@ -922,8 +918,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2190,19 +2184,10 @@ struct vm_area_struct *find_vma_intersection(struct=
 mm_struct *mm,
 					     unsigned long start_addr,
 					     unsigned long end_addr)
 {
-	struct vm_area_struct *vma;
 	unsigned long index =3D start_addr;
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
-	if (vma)
-		vmacache_update(start_addr, vma);
-	return vma;
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
 }
 EXPORT_SYMBOL(find_vma_intersection);
=20
@@ -2216,19 +2201,10 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
 {
-	struct vm_area_struct *vma;
 	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
-	if (vma)
-		vmacache_update(addr, vma);
-	return vma;
+	return mt_find(&mm->mm_mt, &index, ULONG_MAX);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -2607,9 +2583,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
@@ -2991,7 +2964,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 9b8c033ef997..f500c57a59f3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -19,7 +19,6 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
-#include <linux/vmacache.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/file.h>
@@ -583,23 +582,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
  */
 static void delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	int i;
-	struct address_space *mapping;
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct task_struct *curr =3D current;
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
-	mm->map_count--;
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		/* if the vma is cached, invalidate the entire cache */
-		if (curr->vmacache.vmas[i] =3D=3D vma) {
-			vmacache_invalidate(mm);
-			break;
-		}
-	}
-
+	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
+		struct address_space *mapping;
 		mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
@@ -611,7 +599,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -633,20 +621,9 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mas_walk(&mas);
-
-	if (vma)
-		vmacache_update(addr, vma);
-
-	return vma;
+	return mas_walk(&mas);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -680,11 +657,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
_struct *mm,
 	unsigned long end =3D addr + len;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find_exact(mm, addr, end);
-	if (vma)
-		return vma;
-
 	vma =3D mas_walk(&mas);
 	if (!vma)
 		return NULL;
@@ -693,7 +665,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 	if (vma->vm_end !=3D end)
 		return NULL;
=20
-	vmacache_update(addr, vma);
 	return vma;
 }
=20
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1..000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a =
good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to th=
is mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm =3D=3D mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] =3D newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr =3D current;
-	if (mm->vmacache_seqnum !=3D curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum =3D mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long a=
ddr)
-{
-	int idx =3D VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm !=3D mm))
-				break;
-#endif
-			if (vma->vm_start <=3D addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx =3D VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start =3D=3D start && vma->vm_end =3D=3D end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-#endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..9940b51a922b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1378,10 +1378,6 @@ const char * const vmstat_text[] =3D {
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-	"vmacache_find_calls",
-	"vmacache_find_hits",
-#endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
--=20
2.34.1
