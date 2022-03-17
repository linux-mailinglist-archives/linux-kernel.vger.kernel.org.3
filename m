Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A664DC019
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiCQH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiCQH15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698881C16D9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3H1g6018273;
        Thu, 17 Mar 2022 07:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vjIy2CZyR2qcJnnZPwnQbvvc5WyJj/N15QAe5S32D3c=;
 b=runQVVMf216Y6a5RO3D4c02KjS2xpFEfzEIbE9YLBvvqfvm4vtrG5dM3CEW26N+SnavU
 +5Goij/6AaVNvpT9e+6CelSdLLO7c7MCZrRnUGp5mfsyujWXz3f7DKCrbRbOmwu0skh3
 ChRHvpHa2zJ7VCtzC8DN0NRWhNumHLwqbLrOUghOE9sLLy2fh5aWnjCYo2DqDbGTZdoL
 +qttSOtRmZ3q3SQxBEb7RIkXeCyr9jOBvkexXkiV1du/OyYvaYTZ4Ob5dcYHzTgOH8B/
 kgbSL32XKNV4ClfkyUz3f02rZNQKYfczCpdSR/MU31dXXxtUZtXluZOwpUUh6duPyFMy 4g== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rrdkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7C5CB131035;
        Thu, 17 Mar 2022 07:26:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3et64u19xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxbVo5gBJCtUUqoTt16YKBrkuY0wHC+bncWSpTOkSDlwsu0nmQVg7fdZv0dMN0iTZIouWXaSOqs/ef1CgJGF8emSXBbzjUl1LkpWl9DJKWbYmq6dol0vQKVNKH67iXMplOSZCE1lxX0ZzVJCEk8DYrCC5WqZzjcoyWGby5BPEGDpcT23Xjo2YtETmYu/I2qeKA9B2fASnzN/Jj245V45ox3wpVf3+lEphbQKUT0IjvxnmH4tOgqQnRkUlt8GPH0H0frH9wH/3UqPKc9Zt0dT2fRqv07WMI8ai0mVvk+3ZYEtZDConbu3zV0TWdnQcPllLidkWHc/GQbeMstnZbcOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjIy2CZyR2qcJnnZPwnQbvvc5WyJj/N15QAe5S32D3c=;
 b=d73wZQsZRqKjhTxcER4VJWoi7qqcGR+8hawJEqt3aWEE1Wk+SEh2qu3MLaaxUR6/FtiGmWaGbVCz4XNUosqsKSXHrf93l2QNDDuXjLKGGg644d3bpv3/4xi7PvFB+g5cjRpof5lJBqsJwz4sy1196c/FopnuRfP9/aEylv2uN4a1l+/Ls4Xlrkv3MSPGjaddBb7imSygZ/6/dA8Kk/rf2AVwpRyixgyFc40UJHVfC+Bdzk+UddfqbJRIBO6sE9KbDJ88HVQOttYWoiw7LgTdGsBMlw3DmgFvslZseAsRU8+81S4PDqMogE5LY0304HqSGP+26yWF0RHgLKivdrt05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjIy2CZyR2qcJnnZPwnQbvvc5WyJj/N15QAe5S32D3c=;
 b=Hw4SxUTZJQnbYf2Zoqpr6s9RiNicWuv6AZh6Oux1IsJgpWVzf8Nyctj5P7xzikr6gloXVF/96DwdhE5O/9ywholSUQRCft2DRKrwFMF7FYX8u2e63lHlo6TVPdb9Xm/ZGtycmU7qQTbMUhMthUqmJm9lCF2W6rVigUMdQTAko1I=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3067.namprd10.prod.outlook.com (2603:10b6:5:6e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 07:26:30 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:30 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 3/8] kernfs: Introduce interface to access kernfs_open_node_lock.
Date:   Thu, 17 Mar 2022 18:26:07 +1100
Message-Id: <20220317072612.163143-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 687b6bf4-ae1f-4cad-416b-08da07e7749a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3067:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30676AA3E4A26725601EBECEB0129@DM6PR10MB3067.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGitE4NQmhabD/CvzWImO4S8WD0+zWSOp6gsSdt3Z5djgj98qagS33PM2U08AKxYkt8T0Jmphm4HhaMlNFvFo4bIOsP3QyY9mzk/cz38si1O7qvf8OXT3/Wj6be1rlEyBAVJk9k0M/CyKKNW0vUuBZ7h5QL5P6jYF5AuLe+x5rJpr71KyCgLC8sKQil2OVRuipvLH1W/6v4qaA0WYhU+aFJUt9ywNCtO7kr6AU5l8KfZASZsWk7ZoOeAKK1u/xJCAD6cjtdP1/42hMMpHnL3HxvEPqJBW27vXxid5keVzLNcoAowMRZAO6pPHwUmUU4v3N4Jqv+dCAB7E5I2cfOl6tbt3v7OjaMvsCDHwjVGNSOs/BM/Pxwgd0LcebCbyozb51hEydEw0+8450D6jNhUH5jzg/I67qcNVEsa/PKqQ4xhrCUY1iu3iUKGzx3NEwLnsoikb1zV6vS4vFIolXhAOtrAU1dvCVWOspmXBdecYwKIYYIC+l24AwWfmujdlJLEQONFmqX/UpnBr1jKYhtbI+tpjvreedKxEiOq4fqQmq5yvI09L5pvpULB4CFhW5VJAiZqRSaE/vku/Md7d6PcJIYLCKvqyvpNZnGUbFYdNvgc8nfyhQzIz01/x8YOzVnesX+Bjl3O46BqJwUUzUHa+tAmdVzEa4gSmcNeIl7rVi2wRtI5hcjCcswVSczbYtnDBay2QI63Wj/U3Jim7eRa/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(2616005)(26005)(186003)(6506007)(6512007)(6666004)(52116002)(2906002)(83380400001)(5660300002)(8936002)(508600001)(6486002)(66476007)(66946007)(66556008)(4326008)(8676002)(316002)(38350700002)(38100700002)(103116003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxQlHNYJy+StmEo+G2reDnGrezG1ki4UPZPzDCKgn/2MhdWn3iRrqEv1zkfM?=
 =?us-ascii?Q?CB4SsHOvsKzmRYTrrVS7OQS+xgbb9rwQyW2XuBv+1PN0KpI7jYDp6YoakSKO?=
 =?us-ascii?Q?iffUI9thvbmpadyB/aIaE5gOFPRXHjk/XnADJaUMgAwp0xl0h97E0cUkg7QU?=
 =?us-ascii?Q?YSgUtldvX4Zg14ZGkMdEnJXGpDUSsjVNhaW5rN0KfnzF+BDaRooU05MpXoV+?=
 =?us-ascii?Q?oQDHOFDNBel1IT1xuqxS9shJLzapleD+pcZDLvJdgJGxk74lB5L4KGm4XKKF?=
 =?us-ascii?Q?KrTlEq0e+MUJcbQJ0B0BOjHIbkK6MbNbfu+HrqteZxWT8ZfisO4CkVQvbWJC?=
 =?us-ascii?Q?kU10PEGvvjCPCbJaDC6ImDPrH33yKt46W46Jzgu+2KUC1PKG/sE61YTU8TVB?=
 =?us-ascii?Q?1gGNNQ2vLU5t7vjxd0gDnFerYkwrOl7pw21s+DhGT1oJhyEo6SjGREBzD0A4?=
 =?us-ascii?Q?BqVZ9942K58RlvDaMAIJkBTwmejEHUxK/HMt937AeLuslZ0oiGEWBGDSFT9x?=
 =?us-ascii?Q?mvUrBIbauoMadLInFr2w6K5gjIz3SKGL3YzzMeqeu76JgaXdReE84v1N2flH?=
 =?us-ascii?Q?qXuAwsNyJcKdsCpzhrmcHQujRjNo9eHKg+xht+H9wjGo/FU6zr3MR3oXjrC+?=
 =?us-ascii?Q?2EJZblbQBfvqmKgmaX4iM9n190H5u9YNq2tRozIKYvZ7ZCZb91nObceNSQ/C?=
 =?us-ascii?Q?H9UpK/xUtBqKhqxUae3CvAbGqy3tBpNnbrSJQLdxVKsElSi5fI6WtMAnHfq9?=
 =?us-ascii?Q?Zg72H6BVIJWj0/674yznGpIZRggxhGi47GijmKP5ZZwMswVTKCvt4w3y1/IG?=
 =?us-ascii?Q?U95T9UuZsIAeh3ayOJ/sJJ3cmBpz9aXsZe6G5Cl/zQ9IjX6PBl/kvE7/cMmn?=
 =?us-ascii?Q?Qy5bbxoW2HSswvYbxIFpm5QfMvduO9hbSJ3FXDmGHlQ406Nz/bve5Bc7uSjH?=
 =?us-ascii?Q?i4mL41IuxiyiMHd/q0YhTJK05Qi4DUEmA+j7la3r9qDZ62QvjPSKmiSOnb+F?=
 =?us-ascii?Q?ExkvcrueWIoOB3MRGRvZY3gseP5k2vNHvOvP1UM+ntysA5/TFGbgnY3dgXlV?=
 =?us-ascii?Q?gt+b8pFc/x8iknFHSY3graWAWYji6SYu9u9idyR3c71dH6XzybKOKMW+YvZL?=
 =?us-ascii?Q?lHAiCDDIOiLyxBWbdB4UN8qWSrYNmgTqPACD16CkQ2wh0Aixq3u0o0fLTzQ+?=
 =?us-ascii?Q?Xib/DQDI5Jt9yzrDqa88J0QHG/AbTJ87dUdV0tv9M3M/NZwHjf1sBg0XwA9a?=
 =?us-ascii?Q?23JxFP7S5rVyFSsR1PWTI82LdlerFMLDxHNQxoWbJf9fZ2UmSp3uTWuQqGkR?=
 =?us-ascii?Q?mvhF0vBJuK2oFr4nljEMcEaxFabig3UWPItvzzyNvsyuahX/Q21nsCVqhCej?=
 =?us-ascii?Q?urP0m3I83lb555RGGbVSYnMjfm45h2jn+/sTh+FWjH0HadLKuo6Ej18LPHu7?=
 =?us-ascii?Q?DzrD7+X3/fjCZJhQuC1jkVkYc6m4SB5Wf1Wa5gfa3PxXkvSnTe3yzA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b6bf4-ae1f-4cad-416b-08da07e7749a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:30.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDxuMk92FwwlSkgnAwa0SYBOKXRaERYsKU3ZpEqMNnKxwQ/dXDHfcxEYVxS4TjxpaMHLaPWFP9djExiWmIiDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3067
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170042
X-Proofpoint-ORIG-GUID: HfGnwrlny1sOAU--EMYFdkXzdq0JKNBy
X-Proofpoint-GUID: HfGnwrlny1sOAU--EMYFdkXzdq0JKNBy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having an interface allows to change the underlying locking mechanism
without needing to change the user of the lock. For example next patch
modifies this interface to make use of hashed spinlocks in place of global
kernfs_open_node_lock.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            | 23 ++++++++++++++---------
 fs/kernfs/kernfs-internal.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8996b00568c3..1658bfa048df 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -25,7 +25,7 @@
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.
  */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
+DEFINE_SPINLOCK(kernfs_open_node_lock);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
@@ -515,10 +515,11 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
  retry:
 	mutex = kernfs_open_file_mutex_lock(kn);
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = kernfs_open_node_spinlock(kn);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -531,7 +532,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	mutex_unlock(mutex);
 
 	if (on) {
@@ -567,10 +568,13 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on = kn->attr.open;
 	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 	unsigned long flags;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	lock = kernfs_open_node_spinlock_ptr(kn);
+
+	spin_lock_irqsave(lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -580,7 +584,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 	mutex_unlock(mutex);
 
 	kfree(on);
@@ -763,15 +767,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
 	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = kernfs_open_node_spinlock(kn);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	if (!on)
 		return;
 
@@ -916,13 +921,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(kernfs_open_node_spinlock_ptr(kn), flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(kernfs_open_node_spinlock_ptr(kn), flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 4ab696fb2040..60404a93c28a 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -169,6 +169,8 @@ extern const struct inode_operations kernfs_symlink_iops;
  */
 extern struct kernfs_global_locks *kernfs_locks;
 
+extern spinlock_t kernfs_open_node_lock;
+
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
 	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
@@ -187,4 +189,20 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 	return lock;
 }
 
+static inline spinlock_t *kernfs_open_node_spinlock_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_node_lock;
+}
+
+static inline spinlock_t *kernfs_open_node_spinlock(struct kernfs_node *kn)
+{
+	spinlock_t *lock;
+
+	lock = kernfs_open_node_spinlock_ptr(kn);
+
+	spin_lock_irq(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
-- 
2.30.2

