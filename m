Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF194AAD7B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381584AbiBFCSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiBFCSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:18:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7CC043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:18:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215JXofV007408;
        Sun, 6 Feb 2022 01:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lrqpq6IoCWrPdDLDJOV+NUYMYprJ4k5bUqgJNg/bM4g=;
 b=QxJmuDnIg6ZqenDPuSMtc1qJdav7zMDB4DyuDRn9tIXW74rQP5ZUfUlDTlBpWbBGS4CB
 oQHP5AthhT3hKYSaz4n6XwSRR2eIOjtbB+Iupn7XVKu/Nmr0OWInQanQzbxj0QIH65Ki
 VO6qhU4Btylj6kYZAOMuGc4W2vlTlLFPdjLkgkbmYfH0e+vSLOnViX7ZV3+de+Cjel4a
 OXaEM/xKg5vWVU/ol4x9xNHzyAsHRehC67gs9DiSgt8A//e2dYIN25EAzuvr7nNpYued
 UjgFWGRHfj/ms+79ZLY4qWpq1+Hd2TCxkTw5VoXVXuHkaEJJMmlIN5YAAir/IRYrbmzN 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1gussy1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 01:09:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21615v7o035580;
        Sun, 6 Feb 2022 01:09:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3e1f9bgxjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 01:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aajeD0kLGX7YYvt89iyNln59RQSNswJfzNdFFnDIEgfIG1+arp5YBxBUMFd7Gw9od4QLOqoHr+9vAWy5Pn3J3Vv0dFyS9qDr6T7nHJauSpQCjmrbR7WBpPS+4hY90t3+7fdZ3DHSUwUVYcAuItt93XAMaRF2OuTIMed2ox9XDc9FdyRhllV3jFO9B+CtAOeSTzjYPH7I3jSkTEex4R0ZCu3Zos5RL0m7Y7Bog6SaDWG/BiZcHYdV4OIhs4km3l5gH0CmffM0A7jzUO/GK+NnsuaJ6RC1SdANvKpLaY7259qfhwBKPFZgNlhdWkhkEsfJCIKBS9EMSWaT04LFjw4Wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrqpq6IoCWrPdDLDJOV+NUYMYprJ4k5bUqgJNg/bM4g=;
 b=Bet9bz4iA4dmkYhHqcW1dO1sGUJp2MjNffRAF02j2jOLXAxZkLdm4dHLBzyWRZ+XBnsLwN8O4DS1gad5Wc6AKe5YvA1Hk8uVpfhyS+l7AH9SnextyaRngWs/5D7bz8OIR/rgH53+i0PBPvcl2hRb3I5gqWN8JXxWzbFKU7hj4Y00Qqt8sp7as23kgLon96WfdljQd3qVd4sEaDnU80aoK187CCuHxG3r1S5+t4ZJpK36o41cAz+qVO3zsdDev2P7bnM57H99E7EQeTiMaSG74njgi1/cK2drOZBmM4H4T4zDFeHrx1nOYWadrcQd01ksQEAJ5jF/2f0TtKz9P6OFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrqpq6IoCWrPdDLDJOV+NUYMYprJ4k5bUqgJNg/bM4g=;
 b=qAOiYKXAC1olXLiX9wrHAcy8vu3LR1d+bLJU6+PqkJS9JLBz2CnSz4L19DTcC18Yb0DAPVMx17v26rp/lGeRdF9sGhlklYxZxyaxTCIh3rh71xAz0FB912C9wGbHakRl902/yYbd8scynK6wZ5IY22nct18FoCgbcK1KJBuB5Nc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4079.namprd10.prod.outlook.com (2603:10b6:208:1b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 01:09:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.017; Sun, 6 Feb 2022
 01:09:48 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] kernfs: use hashed mutex and spinlock in place of global ones.
Date:   Sun,  6 Feb 2022 12:09:24 +1100
Message-Id: <20220206010925.1033990-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206010925.1033990-1-imran.f.khan@oracle.com>
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:10:31::31) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 897fa74a-11a0-4b58-de75-08d9e90d5e6c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4079:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4079B0167AF05207147CD565B02B9@MN2PR10MB4079.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: we8OIEdlMwtWw800myat6lr6rUVeCn5vDyfO6ZzjksEi4tO5O3diQkIkIhglsrgoo0jLV7BJcJNUocn/UfpHYvL6tFq6Ir7bIfH661SezYeJtN+xdqS4gTjwo9V+LoMd9UQ5P6HF9V+ti85UD1EPF2r+Oh3cN+Q2+4bIRR/X2YISbAwhI88UQ2JTmzhAXtgJs+kbI+2llpC38yhhJt77eA+dPUyP28PdJ8+ZJhOz1cSjQhL+YzMEoA94YMW0qWLeghmDNOjXGF/T+F6pwF/LfGqoFK/ihvCOXyI6t3ywnvOaidjiRSiv0Ksg/DN5neCzx7n55I4noK3KVJqw1f9AbQV+cpR/GUV1ADkXvPXsJHEnMeTeOtgfNBSDoADapImuWKkuZE0AGjAujYDWGCi5vqN2JBvuVsTBxQ93PQIVVsr5tKx2LCN55HW8tcJhiy0CAFlQgFCAQf8E6PqRySJYUrIO2yu2Y6xPkRn7nTbo0lWXYdfyi/FAEqsLT3Fc+aq8eH/+fhIoXhPPZTyCD1Z+4QASSSw6KnIUX08xNVbAslcAngv4d1rOfrvQMga96CbetMDvIZxY1U1C9aABwNUUYH655pZMX7P7X7amKljR7moCPK3c9SMLFpODD+zaHHnnXGcZJKI+gfBZOmgcYjPEoTfy+5SuWdOgmQ7ivy/KvlnxQr8nCQ2hn02uhvyMvXix3P7Xs35k9UXEIrRanI4WJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(6486002)(38100700002)(6506007)(86362001)(508600001)(8936002)(8676002)(4326008)(316002)(6666004)(38350700002)(52116002)(6512007)(2616005)(36756003)(5660300002)(1076003)(186003)(26005)(103116003)(2906002)(83380400001)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSHW7/akOSQom3ForVBarYQ5qhU8d/CLIvUNSd86V3FJkS0vMfQwMLxS2kZp?=
 =?us-ascii?Q?XdiS0A6/UR8MFb4ATjDwcVNQnoISztOiosSNjFI17UwDLTiaMYfE0HlVOw6i?=
 =?us-ascii?Q?VTtus28IDwlDzVb0AMQJgF5t+e+314bullebmLhASUDrT8PDwdyMeX5xudfX?=
 =?us-ascii?Q?Rqhk8YkQY8xJJk3KKqaXnvomFc52mmDn0w2S8Uxy++v2es1EPQ+g0jqhUHTc?=
 =?us-ascii?Q?fvE5fJ3f0QbxxNe3/fbSrZRKM23/ErucGMjhd1sBnTu90HfgD51OcPAVYOZ4?=
 =?us-ascii?Q?sXrX/7/tB9n52uHHRCXUd4QqQDK5IBCv9E+mbcGxVCelXjzQjc2gLgSLS0lz?=
 =?us-ascii?Q?1bcSFzgI1Ob0aIdCmnlmJ21ZyA+L+pzeURTQAbvqal/x3ktk1gT11dNebNef?=
 =?us-ascii?Q?EyLlmFxTID6fGBmZCKsb/c46D48aKyjHqwlVF9cY0Up3l51U1xaydu1rGYdV?=
 =?us-ascii?Q?kCxn1T3gp1PDgpbERBkIe4f2VzXVm7XMEfSzYnh0qCT2H6S4u4UNu1xq3WBn?=
 =?us-ascii?Q?bEjREfTQJ2n95KJYPzoEXx6JKrUP/ktFFZS6b4ydgugDuJp+Uwsxsz36OUDI?=
 =?us-ascii?Q?ABl29eDenUakSOgBvGl/4dFknPo2NFYgzJqcMP+pInp5dDiW3yA1dxu3E1BJ?=
 =?us-ascii?Q?XGIaA63tZxT4JG+5gsztVdQAEj0dpPxy8ZtTR4rhsLw+489yWcHo0eWdPMfQ?=
 =?us-ascii?Q?Ktb11UxJzoIcmYIAthxisyOxeTb3AWJuMB3cuYwpd5biYYK5aYlOK0d80J61?=
 =?us-ascii?Q?ceBi3GH+eHIqgfhp0LXqXQNUexBcUfMeGRRH3SBPpFB6v66J2czv5tl1PZOn?=
 =?us-ascii?Q?IlTez0qdR4qHA0u2n3OYb9Pi25YbIx4kHjYzxiXywQSe7Mdv0TGb+rFJPtQM?=
 =?us-ascii?Q?KpWOaiw0HVulbaVgL+yevG/eUYEW3MtIxnIx5pclCifNQvkehfC5vEOsIn5N?=
 =?us-ascii?Q?36yB/zL0C0c3Y9Kd4nRnhQ2q2jKsgbfLvMVeubes/kCO9iHgz3WTttvYAiTr?=
 =?us-ascii?Q?XeQyM1EwdIF64F37Btpwf75NbxKHmMIBEeH9/vhh8d6be8mQHt/8TMpHO85W?=
 =?us-ascii?Q?vK9iPBcCwyf/JQFhXybeZ7dyRlTsZQ0+tXyCKrEM0rPy7m5tdPBCYVrqx+4n?=
 =?us-ascii?Q?Zft40C0SLplh+r3nlY+udUOWM7TJbkFAeP+3COhUsFT40pvb6m8T7PgygNeP?=
 =?us-ascii?Q?GpymsGFj0cUTgXQp/RpwW1mIoBFOTwsOWNHTARueqKuCosecye1IhS4xJqlG?=
 =?us-ascii?Q?1x+sqDWoOP1LrifbjE9GV1MN+e0lPmEkVT8PsdtI2Ovkh7IzDO9fdfCBi0lW?=
 =?us-ascii?Q?wPbnABMKFDNEuLwF1EqYA1SK5rBg/Zik7JgxrkiE+B9kkq/qZRrUWGcVI03Q?=
 =?us-ascii?Q?ZNqEdEqdXGjA0MXC8DRzhunXxIWkDfC/GrqSoPUdbcYQ7nggKgHB+2pje3bf?=
 =?us-ascii?Q?Pl9SjktjMEfQgIpOQRJsmnBXHkEXHmAOce4OFeH/LendN7Az1Hy14Vz+s7gU?=
 =?us-ascii?Q?3a6jKY3BBqjI7XOL7wYSgo6oyJ2bTBz8rDJtR3GqwNSWWOz7e2/BoSW/AZhA?=
 =?us-ascii?Q?5ksMyyTLMxB1JGX5p5MI7K+G7vkLRS4DPrbC4whrrcEYDMLxVktQA2jRarSw?=
 =?us-ascii?Q?lqJFidBc0GNJ3jkXm7znN5U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897fa74a-11a0-4b58-de75-08d9e90d5e6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 01:09:48.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QGPgugeHAP/O2OHi03Shs9b8/VFETjHpgNoiiw1OKGLtMVM97iVwh+12o8wdHcfGIVJnYjoAPfP9rssL8XCsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4079
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060005
X-Proofpoint-ORIG-GUID: ptD0e4r1Iu6oFTtgAHrVsLqIooq6JpiD
X-Proofpoint-GUID: ptD0e4r1Iu6oFTtgAHrVsLqIooq6JpiD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now a global mutex (kernfs_open_file_mutex) protects list of
kernfs_open_file instances corresponding to a sysfs attribute. So even
if different tasks are opening or closing different sysfs files they
can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time. Since each list of kernfs_open_file belongs to a
kernfs_open_node instance which in turn corresponds to one kernfs_node,
moving global kernfs_open_file_mutex within kernfs_node would sound like
fixing this contention but it has unwanted side effect of bloating up
kernfs_node size and hence kobject memory usage.

Also since kernfs_node->attr.open points to kernfs_open_node instance
corresponding to the kernfs_node, we can use a kernfs_node specific
spinlock in place of current global spinlock i.e kernfs_open_node_lock.
But this approach will increase kobject memory usage as well.

Use per-fs hashed locks in place of above mentioned global locks to reduce
kernfs access contention without increasing kobject memory usage.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             |  5 +++
 fs/kernfs/file.c            | 61 ++++++++++++++++---------------------
 fs/kernfs/kernfs-internal.h | 51 +++++++++++++++++++++++++++++++
 include/linux/kernfs.h      | 39 ++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 34 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4ca..d26fb3bffda92 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -909,6 +909,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 {
 	struct kernfs_root *root;
 	struct kernfs_node *kn;
+	int lock_count;
 
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
 	if (!root)
@@ -916,6 +917,10 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
+	for (lock_count = 0; lock_count < NR_KERNFS_LOCKS; lock_count++) {
+		spin_lock_init(&root->open_node_locks[lock_count].lock);
+		mutex_init(&root->open_file_mutex[lock_count].lock);
+	}
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f4..018d038b72fdd 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,20 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
- */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
-static DEFINE_MUTEX(kernfs_open_file_mutex);
-
 struct kernfs_open_node {
 	atomic_t		refcnt;
 	atomic_t		event;
@@ -524,10 +510,11 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
-
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
+	mutex = kernfs_open_file_mutex_lock(kn);
+	lock = kernfs_open_node_lock(kn);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -540,8 +527,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irq(lock);
+	mutex_unlock(mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -575,10 +562,14 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	mutex = kernfs_open_file_mutex_lock(kn);
+	lock = kernfs_open_node_lock_ptr(kn);
+
+	spin_lock_irqsave(lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -588,8 +579,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irqrestore(lock, flags);
+	mutex_unlock(mutex);
 
 	kfree(on);
 }
@@ -729,11 +720,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @open_file_mutex is enough.  @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -750,11 +741,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *lock = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		lock = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(lock);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -769,19 +761,21 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = kernfs_open_node_lock(kn);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -793,8 +787,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
-
+	mutex_unlock(mutex);
 	kernfs_put_open_node(kn, NULL);
 }
 
@@ -922,13 +915,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(kernfs_open_node_lock_ptr(kn), flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(kernfs_open_node_lock_ptr(kn), flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1b..cc49a6cd94154 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -31,6 +31,7 @@ struct kernfs_iattrs {
 	atomic_t		user_xattr_size;
 };
 
+
 /* +1 to avoid triggering overflow warning when negating it */
 #define KN_DEACTIVATED_BIAS		(INT_MIN + 1)
 
@@ -147,4 +148,54 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+static inline spinlock_t *kernfs_open_node_lock_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	return &root->open_node_locks[idx].lock;
+}
+
+static inline spinlock_t *kernfs_open_node_lock(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	spinlock_t *lock;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	lock = &root->open_node_locks[idx].lock;
+
+	spin_lock_irq(lock);
+
+	return lock;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	return &root->open_file_mutex[idx].lock;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	struct mutex *lock;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	lock = &root->open_file_mutex[idx].lock;
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29f..5bf9f02ce9dce 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,8 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +36,40 @@ struct kernfs_fs_context;
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
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+struct kernfs_open_node_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
@@ -90,6 +126,7 @@ enum kernfs_root_flag {
 	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
 };
 
+
 /* type-specific structures for kernfs_node union members */
 struct kernfs_elem_dir {
 	unsigned long		subdirs;
@@ -201,6 +238,8 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
 };
 
 struct kernfs_open_file {
-- 
2.30.2

