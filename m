Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAE4DC015
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiCQH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiCQH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF21C16DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3QShl011957;
        Thu, 17 Mar 2022 07:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=aKKfsoguAZ+NCAuCve7CTRrQl855Qm/5JqQcqayjUlc=;
 b=wvFSW7MfyBF9JyeVjojHF+oXq96VZltCxuwRw1jr2t9vLRXvMEdHg3pDUNdXZjDfm6Z3
 /w1I+xVVkgbBRgW3p0DkjtTx5rIFKHptNVU8LIi0s0C2gx2txwLkEvhoLmHHU/BQRMC4
 Et3kIkNOHUf3JrpnKCG5olMN5SwUZYueJ+wsliiZqsXyYK1gyr4gkbmYS/jE6bmDFiF2
 1zz6gghkI/ugfH6QuEU8lrrwwLsULwJg6JuzLnXArhbFtk8bi5Px94FLnRemqB/FZG/x
 kWjMbKJvuk0qACxP5sKJUvj3TT9DJqZI947vWYwVw/k8d6DZEsd9MupOUmljaQdc+ksA DQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rg5yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7C5CC131035;
        Thu, 17 Mar 2022 07:26:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3et64u19xp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdTetOx/7031LxdsIXaTQYYvRooLtFp2xIZzOdr2CSBbCVpJVjczp/MsfwaWJtRBGFWVHUVAPUBuWeCNz7hyXek6r6VVlzaIiAclYprinvyBo7Xket974ipNeo9VtbyNZDg8UGcwFUqo6i+K76uch0LvVic5HIS0FEgXLNCZBOJmT/eTLn5Sb7Hj2UXzcIlkNKl3u4fdALsPKzJytNH9PIxKvqvt2uL74XYeuJpRVWuEgav63zBhbKJfELsBQtNw/j4ehazLLNWjnr/H+plC1yOqlKhebRg+RDeItdZfEgtQHtZen5RQALKwHvMompXcOBtnARVFpJlN9VeT3IqWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKKfsoguAZ+NCAuCve7CTRrQl855Qm/5JqQcqayjUlc=;
 b=hOwJIanoUo4HlBBV4qeEUvGQ/Hq2KpUUJPmq4o+5h8glTu/zLGxoh1Oa0Ydwu47Lrb8QfCiCZk9BbOB17OvLl0l+MNPGe52sOqWiromaBCanQQwT4tsd1WWKEewOggIRhqSu27oheHi9RfNMp/6oHoqDNs/lTxKOQVPNP4R3z5gewbxl0YjG0UkTZXfPYE93rvU/ceyi7NVhIguqUY7cvv41fpB99zBOq1gU4gESajAaJK/Li6dp/7SWxb3G1obCSSHHhThHpzM0WnwHnYVB0Hs5NT640szbbaMQwWoCnks9fWhhNyNIy+SihGphx2NIOSTStqIbMmSitASiMRNyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKKfsoguAZ+NCAuCve7CTRrQl855Qm/5JqQcqayjUlc=;
 b=uTAVtfpihoZZ+78LgWM2DHapkrTRYiUhN1dH+eVHwu0gO8zMXYdM5pEN150Qm8lxvw+bfpDAWs9E5nTn89HRa6bSPAFS1jk2Cg6XqPJvLHUp4LEPPDp9oryuac0J/B4fZwFz1m+AdXcdNm6ASvZ7d6SetRYphVWtkSBORwjGZb0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3067.namprd10.prod.outlook.com (2603:10b6:5:6e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 07:26:32 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:32 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 4/8] kernfs: Replace global kernfs_open_node_lock with hashed spinlocks.
Date:   Thu, 17 Mar 2022 18:26:08 +1100
Message-Id: <20220317072612.163143-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220317072612.163143-1-imran.f.khan@oracle.com>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea79e9bd-9ef0-4d2e-4464-08da07e775bd
X-MS-TrafficTypeDiagnostic: DM6PR10MB3067:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3067807C7CFD1CA2A52E713DB0129@DM6PR10MB3067.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8z+pVpXb2sF0gdIby8X56InvN1i3iGOlpljXsSXScCMOn8MVrEFgBjeD4FHr0v4Rq8xjL7CUnJZvBbGgDOBJL9ALAtgP4frANTKs2mgB60JcXNPQY2Gv48Ui2ArS0QgEhAQHYXJC7Hq11HqHArO4nB5ZUmio6gwqw5z1YZ77Ds48RM9eG+phka6tIy/Bp32FSHT2OhMi4TzVp4gba2gXT69Xk6Z3Cz2gIXDqX9GCycxNsSiZyR6MCWlsAU1xXxZAXC19CQtlfzrxiiyL5W5a4mojJ7A83BaL2R/3MVwl4xoqsWDpCEv8gDNntsiMKm7A2sBra7d430+Qi6ADTP4cgTl2tmq/uWvOblFPrtr9J+GboHbF1fwAcbg4RCMHmd9Ya9GnUIXphWS5emeLPknX9cGFJ/jCLUb9O+983Uj4IAiX9L/C0ZrehSz7NucAiv8ZMkIPJgUIh5MpHnJLo4zQQ+ujcvYXfmWRt9UFmdveWuAjYCfygbTRfiFFhit74m3qnliamio04wz3dInKSnd/01aDQMT9sFvT/d5+J5mOmoOQ4wJHaEOOdSOuPBZKEfeQXpllg5zU8QbQkwf7tjUA9ZzlPOalmmXpNwhBtbBP2KnzkEdAuDuwm9FcUM13YOpqDgMwdfeCoZ2O3ShietSB+5mkYIGCmJTOam7RaNwQgsNXxb8CXLxSAN3zeR9PvBBf0iYqiNl7lLQykX7oMBgY7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(2616005)(26005)(186003)(6506007)(6512007)(6666004)(52116002)(2906002)(83380400001)(5660300002)(8936002)(508600001)(6486002)(66476007)(66946007)(66556008)(4326008)(8676002)(316002)(38350700002)(38100700002)(103116003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JAqQx+NBqWrJIL+oUI7bB9qzifUuHPGITQIWhJ62sFG/lpui9GMdahQGD+p+?=
 =?us-ascii?Q?CYj9vGT2dv8r4CVFrAGylpeB1IIsnsDM7yVA5B/xcrDSYof3q829u7sja7Na?=
 =?us-ascii?Q?okHX+Sux1ElbCpI6Djq12xmPTsV4DwOXBGZsrSUuxviW4w+dS9bBtdtPYq3x?=
 =?us-ascii?Q?XIofeLBxdlhlvh2SE2pBjbPAZBzZtlkenM61UilR7ATGUoGYdrP7bGOn1dpb?=
 =?us-ascii?Q?/BFI8OYvoT/fnBGMSOQboSNOqPe3/SrOo5OwgpcOX3lF9E9bMZDGtDKgieH+?=
 =?us-ascii?Q?y4es8+kY8drD5u6CMMLJwSXr4v9Q3hdkLcNWbYVxZGU/LrNsAHTVBbIbaiMv?=
 =?us-ascii?Q?xhUx1lZdy7eYzSaAoLT6SuN0gvRl9PhVOeRDBx6fB3Wb/eEpf+VhRM0jAAEO?=
 =?us-ascii?Q?lI33fD8rH8CKKKa3LKVLDm1QkAzHm9Z32IH/URvEeZWyBYf8WhWv2wvKsQP7?=
 =?us-ascii?Q?kf6c7Z3xNWQttcxHf44RbO/2lwuCg4Azb595Ac4REGAVPi+m0JzLvio73+ad?=
 =?us-ascii?Q?lhiZ3/LhS2pExTSDaCnfmAOqA0sH1HnjzIyfJPobX6yKc6aisimpFP1/2SC4?=
 =?us-ascii?Q?P/iOCvXcSgaYrrG9rePTC0eT3fZslEmmbaMzeKw0wIhfgZlbpJbedK98gEkg?=
 =?us-ascii?Q?WQZ9oSJ1xSc1tSSfs/j5rcdWsLhgHR5OO8yD0Baw35Kzml4y05nXu78YXv5m?=
 =?us-ascii?Q?TBrI+0fa3T2UarbEARFEtKVlAtrjyARzuIF28Vgac20G0iicWnRM20lFsiKI?=
 =?us-ascii?Q?75UKiZ+haytMEljxlNLgOm31Fsmy/BRBgKxiAHdmtey0vHyMiwdJs1RiVRVy?=
 =?us-ascii?Q?E+AgvWsy0RJfvxVFNvbODWZjXZmwNYk5Wm7HlcoUG5zoMUpW1iI/W9UsnID9?=
 =?us-ascii?Q?SsLILJuK2x6V0kCsYskU0PTreDekmHBmMURhuXmDCnPSfyBVIDBDMRuzUqyj?=
 =?us-ascii?Q?6Dg9v8TT87gI1Z2ED/SydPqiG/35Tkyf/W482KYF8NMTOuoGL3x8UUc7e2ie?=
 =?us-ascii?Q?ZCprf8JsIRL72ei5qgpk99FLwm+M1+vlsFJoP5w9xkNQjEMx3S8F2I5mKJpy?=
 =?us-ascii?Q?3Tutk0A8S5qk9JorfXjNi7NAoBfKaUt072fVIDAkrn6V5BtbJ6UrwanCVjb2?=
 =?us-ascii?Q?oRIpVBAJ1nsaaW+4c+llCMOqgswpNSzEpWwKyHsic1tu8eZrNYRiMJ8oooCp?=
 =?us-ascii?Q?abe0QlfVQPgRKPI+ZYlc3FusvBnmQz/13Zh47krcjqOvCv5CjXoT9G/HmYMD?=
 =?us-ascii?Q?h0wFNn79coDljudO7zambHpzqvgUdYgQl8HkYksfgbD3rHIFYuFkBt4+7fu8?=
 =?us-ascii?Q?eSlVt95y9fcL2Y6Qo/K3LwMBiyn02dausREzYc+C3UJPndkK6HRRacIeuD0P?=
 =?us-ascii?Q?mEQ0c+Ohx1W0jw/kJ11DNIGhxHVCLVB31c1l0SEHEsPaQltfN5ujl8UbSiBW?=
 =?us-ascii?Q?m04sCMDv/6qE1R9eECUirhAy7wYVUM/bGT1r+A/xIrQFf0a1wbs/FA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea79e9bd-9ef0-4d2e-4464-08da07e775bd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:32.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykfQXR0Sw1cfyIc6aDl+br66Tj8puvHYqqthlQWx+nw7wAT3NQEVLtSiT3IWVUrrfFt/lDGg2Eb96O4wNLTCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3067
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170042
X-Proofpoint-GUID: xofnCzL-nS6Bea0raId9d86jhVlp0PtC
X-Proofpoint-ORIG-GUID: xofnCzL-nS6Bea0raId9d86jhVlp0PtC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single spinlock, kernfs_open_node_lock, protects
the kernfs_node->attr.open i.e kernfs_open_node instances corresponding to
a sysfs attribute. So separate tasks, which are opening or closing separate
sysfs files, can contend on this spinlock. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time.

Using hashed spinlocks in place of a single global spinlock, can reduce
contention around global spinlock and hence provide better scalability.
Moreover as these hashed spinlocks are not part of kernfs_node objects we
will not see any singnificant change in memory utilization of kernfs based
file systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed
spinlocks. Use kernfs_node address as hashing key.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            |  9 ---------
 fs/kernfs/kernfs-internal.h |  6 +++---
 fs/kernfs/mount.c           |  4 +++-
 include/linux/kernfs.h      | 10 +++++++++-
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 1658bfa048df..95426df9f030 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,15 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.
- */
-DEFINE_SPINLOCK(kernfs_open_node_lock);
-
 struct kernfs_open_node {
 	atomic_t		refcnt;
 	atomic_t		event;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 60404a93c28a..25c3329bd60e 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -169,8 +169,6 @@ extern const struct inode_operations kernfs_symlink_iops;
  */
 extern struct kernfs_global_locks *kernfs_locks;
 
-extern spinlock_t kernfs_open_node_lock;
-
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
 	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
@@ -191,7 +189,9 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 
 static inline spinlock_t *kernfs_open_node_spinlock_ptr(struct kernfs_node *kn)
 {
-	return &kernfs_open_node_lock;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_node_locks[idx].lock;
 }
 
 static inline spinlock_t *kernfs_open_node_spinlock(struct kernfs_node *kn)
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index fa3fa22c95b2..809b738739b1 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -395,8 +395,10 @@ void __init kernfs_lock_init(void)
 	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
 	WARN_ON(!kernfs_locks);
 
-	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
 		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+		spin_lock_init(&kernfs_locks->open_node_locks[count].lock);
+	}
 }
 
 void __init kernfs_init(void)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 1de54f4bdcc5..e82e57c007e9 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 #include <linux/cache.h>
+#include <linux/spinlock.h>
 
 struct file;
 struct dentry;
@@ -75,20 +76,27 @@ struct kernfs_iattrs;
  * kernfs_open_file.
  * kernfs_open_files are chained at kernfs_open_node->files, which is
  * protected by kernfs_open_file_mutex.lock.
+ *
+ * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
+ * protected by kernfs_open_node_lock.lock.
  */
 
 struct kernfs_open_file_mutex {
 	struct mutex lock;
 } ____cacheline_aligned_in_smp;
 
+struct kernfs_open_node_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
 /*
  * To reduce possible contention in sysfs access, arising due to single
  * locks, use an array of locks and use kernfs_node object address as
  * hash keys to get the index of these locks.
  */
-
 struct kernfs_global_locks {
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
-- 
2.30.2

