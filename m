Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F04DC016
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiCQH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiCQH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AD1C16D2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3W20E001976;
        Thu, 17 Mar 2022 07:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=w9v6Okrw47UDDstUUTI8u1jBGKw4bPhhow4H3bw/SpQ=;
 b=XhPxFbdj6rnEZ/X6swcLJePxxDd/Y7jnpwknNGifZO3Ts8VhfEXorrbz08oT+k90SsFF
 oU4/qGBscpKdht2MhYDsOWoAEImoCH00sKQcqkff1sf/cKirBtNuP59sTlq5+FbyAgeR
 0QLmGPQfDil3E9JKToGXwSa5FjFbxCXdOQ9e8o55atZbIsLXPQHdgH/AKvDAd+maiur0
 5U9WEYXdRJkLWlcZojGgbqAo5Dt9mqfYYn92Z4/rm9qrHEHQF4oEhH8qAVTPy5GWe0F5
 Ti0zn6mFbBNyCADsOh1ew2WLp35eFCOkg8Wh3rThbBguD3d99A504tSoKt1p1YjRYSJI zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwr4ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7CDfd012724;
        Thu, 17 Mar 2022 07:26:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3et64m4wvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab23S7bQTRpoqEpL7FNrwBYqoYI9dMf+R1kU9HtZ/9/8AZd/BIa4VWHFRQ5xCjQACkMLbsfzzg1Z4mNQTel7yGAWdhlrU/qNvgNRP2URG5o0X6x9lyCl9lmHn76iMAX9JabzU2K/iBOfmNBDJM77FXj27hNxLIynihRft6Pm4BRrXxc5NOFEOZHWowbgR19MTZ+ygP74b07uhKNhonW9zEGs8z5M1T7c8zmgNznveh/KeMrY+8czDrU3c5IDsuiA3kjBFabEdKdBVQaUKbartQgeMw7b2X6Jk9M1ztPioWNf1b7hjFu16ICK7lJ00dM/D7XW2m6rRPL+mgBFoiSQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9v6Okrw47UDDstUUTI8u1jBGKw4bPhhow4H3bw/SpQ=;
 b=Gx8/0WGdSscqCM/lXz2les82GrlusRvkxXBYUMauapkTVqJbU1e9Ql3/jbGTARlRkCBKcFiWSk8butHKAw5eNFBesmohF1585Wh9Tv6VCF8PkRfNP0VtzvT8O4QdLmy8k7k5BN8CW+Q8HdLUvKoidnKCG2VjlhA9tSHfX7bcBVbNUhZI6mrHKzJlTJH05gDBVwdNjukQHNRLcOQkC2yQN46uVhLQUmnV44Vxx8CqMgoMB/5vH9Fsntg4ZDXlYWyg64w0QLvTESL93Rp9/X2tuMZ3YVQskHAjtAr5EFwbpNyhmkShWR6Ew64MArcIiF1PKtfNLI8+Tpdvkhm30kM1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9v6Okrw47UDDstUUTI8u1jBGKw4bPhhow4H3bw/SpQ=;
 b=wc9uOVMFJIiAyINo10fUNDSwllly/O3Ycxm3f9GOJ0/DMnr5yRneG/YYZ8+2qmDkWGOhSS4zEE5UHsCGiJox+Bq9gc6zGjmRBFE6Dribt7UIjYA3drXxaX/VJPCjNNVto9nrcrqpGqDVhm2DrQ7R0WpP7kZ/WKK2vR0HbnR2jcg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 07:26:28 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:28 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 2/8] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Thu, 17 Mar 2022 18:26:06 +1100
Message-Id: <20220317072612.163143-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: decfdbe2-7900-4250-7d18-08da07e77372
X-MS-TrafficTypeDiagnostic: DM6PR10MB4332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43325EC589EA10D5886CE0EBB0129@DM6PR10MB4332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0VYJMf42BY4Q4t4V9zC4Oa6EzxBP3/w74uozNiiLosT3t0qvr1/9ZF+guyMrmhqkJr/qxT3n9Ft+Rlh1AoWR23NSTXJYpTFeq/5OQdFdDX0fDlyTyztIcXNrSWO0WLdV6xKIpiZ4vjr6SGevoIP8Qle6ZTNGJutGcBKZOJ03fNA53MdxWNffYqG0baf1JhI0xRHrjLBUPtjok808DXhmRpUhqG6gXR2j4OCZyf+D/vlEII+AYIJJH9+iQ/Z/MoS/Z/BoU2IcJ1bq5e8Yzy81OC5fArxmVTxfM7BNoqe0hyJ9h77aXsrFYLEg+MKraG4wQBF0uT94gud2ZMaCOWoYmekkNeJ8SNlAZV6iEBlC824oVkpwy+up9RNygWo7FNQ2FuFM02diJQBlvCy81FhcbOpM47i4hJLzrYWSJo5AjsnjGHK3SClIXvmCWpGhxtkN5r9I5vtPlR+h81GBQInOyP3QULI5378tGqp0+frsQkTISY9TbWmd+5/ptsxBc4dvWe4UY/0Ft9J4vJgBvL/am4bHIed642gNgn/cEVq8Q0iJFCDqAvcL7wBC0tiZPNGYP21qMUA/62jZFbFRmMmzwbAf/GyfcYQAaErzBs6DEpvWcwX6co5Cs9/vs1t94eP1j71/eDCUatSaJppvtxXt2GeC/NGJSJiaEwIPSmmcc3PBdkS4SCgsqUvpjKmNnyWcoGqU0XIXt4N42FE5OmDcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(8936002)(26005)(52116002)(36756003)(38100700002)(316002)(186003)(38350700002)(103116003)(6506007)(86362001)(6666004)(83380400001)(1076003)(5660300002)(4326008)(66946007)(6486002)(8676002)(66556008)(66476007)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?At9tqtj9JepwWv5OcgKvA5YSlzh0xLQv0qTBv9uJgFzPqJXbjwtq0o74nO0i?=
 =?us-ascii?Q?VvYto9wYToTz+VNipP4FZPgZXbBeJNfAu6CBmxh/xMxsmpV2EgfecWrflrv6?=
 =?us-ascii?Q?EUKIcsjVrbbw/3zuspHyrlLOQdQKl7W89w0EZM0euv79n/QZEsFJjrg1SlGf?=
 =?us-ascii?Q?RhjhwnylYDMjPirIYhtcVeAaafxs9HD1nGd49wATNsrnYNLevN/tbL1/OPl8?=
 =?us-ascii?Q?95Hi44vnGWyb+VmZxX94tHbCPen+oihnBx3qNxj7LSCGMm0MvK7yb5jBTouo?=
 =?us-ascii?Q?NHEqOCSm75EnbU7wjMCxOxQxuyVEImjNfjALPtHNZJNCFj87x7wUrOGkhyKe?=
 =?us-ascii?Q?y1SHG4SvDCTYilM/L5fPx01eAdr89mNz+Ablpwwlt5+Bhho/7hDWkMPIEDsa?=
 =?us-ascii?Q?tETTxiJ0AgM4E3lphU3+1CSBa9hUBZKNo044aC2WyjIzX5raOf2suClZO3ox?=
 =?us-ascii?Q?MtWWUGGu0smjd//SUP1m+KnG6O4NQvwJt8HXH+swyZm3zN4BFIUftLQLf4Nb?=
 =?us-ascii?Q?nd9s3Z6jlcKP3QGuFPAHkC7FaKRJr0NmBPN7gorO/oT+sqQNE4YFrOUCCCUK?=
 =?us-ascii?Q?SCNI0XMwtnx8Dzs5rt2Y0F9JRCS7NBy8j3eFiLlUJufxuVVSWVtbQFMxA4c8?=
 =?us-ascii?Q?W92HU+b5zuWHjgkuT9afpj0sKRdDHSI3Y82zpyUx5LDE93VUGKndq59EUfHb?=
 =?us-ascii?Q?8HhfXtJVr46R+1rmw6Y33WFuo33i4qVaAzQsnHDxq6DBs3IYdKfusAmB98vc?=
 =?us-ascii?Q?7BYroC64mDhHt87vPXxZ5c/i4WsnXcfOXczGbW2tN9Qzk8s8EUBept6KDGMS?=
 =?us-ascii?Q?jmJp4ybdTRFMQlIMOyU5jEHXadQG7B5+Itq90HvG3krkBDStdCUNCQfProZC?=
 =?us-ascii?Q?OH6eoG2RZeVspbkKmcqVAzkrODXtxnXhoqyAh0GuLfMNz43IwENt0ci4BpvQ?=
 =?us-ascii?Q?Vi5xY4Jypt/p/ztGwpXr1V7o57+e6z4XkH/oLsQIgHJaWcphWiRWydZNMPq/?=
 =?us-ascii?Q?9oTRReaP8BHGEDoJTa5rVTa0cJ1tvVc8Cp0hHi2/1RSWyAFm2bB8G4snKJwP?=
 =?us-ascii?Q?b2zHTzTxtZbIymL5W6hGvDOWButMCPFnn/+CW8IUL2w0LME4/eQ/Dc6jjkym?=
 =?us-ascii?Q?YmmL8SSkrf4UHdxXsVZX9TaLkxUAqQbv2bbOTh9KHUCrskOw8M5qZy0bAKxv?=
 =?us-ascii?Q?CiLHNg6CFHe2Z2WlkCJ3bArgL0uRJSR6xghzW0IStTY+9Qd1YBA9Kpvs60D0?=
 =?us-ascii?Q?zPUJ3UvbDgrKDizUTCc9FGpfRKPTY9IEAPGTgJgNkilts/+EOjsLptZO/xyv?=
 =?us-ascii?Q?V55ro3edMrOH6O+foP8IrNch1g7LJo6kOICyR0goLd6TAP5wQKHRgU1KCYTy?=
 =?us-ascii?Q?uBWQ3Sj+nu8ssfsRseYT7G5l72TaHpvIWTmnQZm4WzZtywi8vh8+ntrgWmQt?=
 =?us-ascii?Q?lO4YVZaLw4K2Q6fqMkT8+xr3KSdcniYnXzeiBVxoMEUvCZMfQzmurA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decfdbe2-7900-4250-7d18-08da07e77372
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:28.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXZUdfxd7TL+pEJ6sap4Kk6CKNPmrqFlOYOStOZel5lnhdGOxvdgaOXmmOntoMdK5q9qXxfHAc3FuJLEwJmDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-GUID: iR_-V1OYfp-2R79s5-7Yy7OJlHiDDCTJ
X-Proofpoint-ORIG-GUID: iR_-V1OYfp-2R79s5-7Yy7OJlHiDDCTJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single mutex, kernfs_open_file_mutex, protects
the list of kernfs_open_file instances corresponding to a sysfs attribute.
So even if different tasks are opening or closing different sysfs files
they can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time.

Using hashed mutexes in place of a single global mutex, can significantly
reduce contention around global mutex and hence can provide better
scalability. Moreover as these hashed mutexes are not part of kernfs_node
objects we will not see any singnificant change in memory utilization of
kernfs based file systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed
mutexes. Use kernfs_node address as hashing key.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            |  7 +----
 fs/kernfs/kernfs-internal.h |  9 ++++--
 fs/kernfs/mount.c           | 13 ++++++++
 include/linux/kernfs.h      | 59 +++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 99793c32abc3..8996b00568c3 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -19,18 +19,13 @@
 #include "kernfs-internal.h"
 
 /*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
  * protected by kernfs_open_node_lock.
  *
  * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
+ * kernfs_open_file.
  */
 static DEFINE_SPINLOCK(kernfs_open_node_lock);
-DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index df00a5f5a367..4ab696fb2040 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -164,11 +164,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
-extern struct mutex kernfs_open_file_mutex;
+/*
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
-	return &kernfs_open_file_mutex;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_file_mutex[idx].lock;
 }
 
 static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..fa3fa22c95b2 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,6 +20,7 @@
 #include "kernfs-internal.h"
 
 struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+struct kernfs_global_locks *kernfs_locks;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -387,6 +388,17 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+void __init kernfs_lock_init(void)
+{
+	int count;
+
+	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
+	WARN_ON(!kernfs_locks);
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +409,5 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+	kernfs_lock_init();
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 62aff082dc3f..1de54f4bdcc5 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,7 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +35,62 @@ struct kernfs_fs_context;
 struct kernfs_open_node;
 struct kernfs_iattrs;
 
+/*
+ * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
+ * table of locks.
+ * Having a small hash table would impact scalability, since
+ * more and more kernfs_node objects will end up using same lock
+ * and having a very large hash table would waste memory.
+ *
+ * At the moment size of hash table of locks is being set based on
+ * the number of CPUs as follows:
+ *
+ * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
+ *   1                  1                       2
+ *  2-3                 2                       4
+ *  4-7                 4                       16
+ *  8-15                6                       64
+ *  16-31               8                       256
+ *  32 and more         10                      1024
+ *
+ * The above relation between NR_CPU and number of locks is based
+ * on some internal experimentation which involved booting qemu
+ * with different values of smp, performing some sysfs operations
+ * on all CPUs and observing how increase in number of locks impacts
+ * completion time of these sysfs operations on each CPU.
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+/*
+ * There's one kernfs_open_file for each open file and one kernfs_open_node
+ * for each kernfs_node with one or more open files.
+ *
+ * filp->private_data points to seq_file whose ->private points to
+ * kernfs_open_file.
+ * kernfs_open_files are chained at kernfs_open_node->files, which is
+ * protected by kernfs_open_file_mutex.lock.
+ */
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks and use kernfs_node object address as
+ * hash keys to get the index of these locks.
+ */
+
+struct kernfs_global_locks {
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
@@ -417,6 +474,8 @@ void kernfs_kill_sb(struct super_block *sb);
 
 void kernfs_init(void);
 
+void kernfs_lock_init(void);
+
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id);
 #else	/* CONFIG_KERNFS */
-- 
2.30.2

