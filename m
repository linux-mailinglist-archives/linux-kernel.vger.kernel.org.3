Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE28482F15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiACIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:46:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbiACIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:46:26 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2038bxjJ030681;
        Mon, 3 Jan 2022 08:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Tr5IdIej7w8t06MtKZSvL7ylp57VYNBXvJUNPgkML50=;
 b=ovyNmTgXj5Rp4lfhECumcwWcoEE9NSymSOS2NAGxfSwlQAGR7q58UynCrChWzQ18RLIS
 00Hg4RniMKBRJx+WjJsU/7BE9RXHKrWcN4Dxy/JoDVWTe01RCkXOw+FO/Rn1UtHrE5Gt
 nDOHlqUstTtSywlyElgIaVKb8xEfOVgHQsufRoLR7MZp+1/TCj/QF5g1DQoiC55fnwci
 7AvaX+m1u/QXpKe8gTeeM/8TeiYk+lOjrHYW8n2ncz20AWo4/B7LhHkJRXD/zz2jqrPD
 ZzirAEKNC5H+4blPmOaZ9hUnk0SfTd6qztC8Od4drtC2m1FA2AZY7583Pyg0To4BjVSH 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dadj1t7tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 08:46:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2038fAWs016692;
        Mon, 3 Jan 2022 08:46:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3dagdkd7f5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 08:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMXv+gMLoWjc1N6sVyg0dHv+tM5ERqmzYoFvCSoAEymwoczj6wBFMxsAu+dsQEHaCsUKW5pLN5Ee8BPnHpxgR1wcoTSzDNK6p7L0sTjN+92zvLtyBCwsM8O3jy+7UdQm82fdXzWUMbdtKKW8UU2PJZyNtLAaUzY6aU3MLVENTQJu+ZTt7E8uoz9qT03FpXpYDr6hTX8/yt1SmJ9B3FG+AfdTcFuzCd33++f5+D6PvezNwgxaE5UDTUbJm83hUEeLi/doZnXJwJRuxkePIpQBkbRHVGnyzi9JR8vhpDwWkVThRTRXfKIbBN1u0EtTjY+UH3q0LYymkA9wE6/1Vq/LDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr5IdIej7w8t06MtKZSvL7ylp57VYNBXvJUNPgkML50=;
 b=UgiVP91nEwS7PH13HCJS1bsVF5ZCjNIckElCWQvuzbFUGHqofdNsoqJP4+OOblWi68Oj3lLG1lEsiPJVOD6WJgZ4u0oshyYiDEJl3LlcW15P3Gi7+eRlZCkhkUsjPCzVYlOvKukgoaOIRr/DD7OYpO4jXSZNRhpLB9jhKabXsgWC+x5nXyN5IVkD5LEQbAneyvnVkYN0o6ouI/LLxeDV015xMXGN8hoYbvApXLl+XoWWNJ5RTHKRR/C3lcQGMgaK9wHRENEk+Ex516DLAE297568SzxS6WD9WaKvzr8USo82I44vE3yPb2caYYOIhCu9EPvgc7tqsp4CCwNGvkhQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr5IdIej7w8t06MtKZSvL7ylp57VYNBXvJUNPgkML50=;
 b=h4CQBAEeBkhZ+5YPNRNIWA4ny7yJybBwA9oeUDjudGwnGWpTOS0wrcASHk9noqTwBdWoKF0pyAA/7U+yfA4OoZHO0tXh/PghAcghGww7c4KMEbf3+kBpEeop79R2m9i5o9ZvNq+L2909xBeMgt+4+dmQsyqV0FnajQ4HjLT9/8A=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 08:46:14 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 08:46:14 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and spinlock.
Date:   Mon,  3 Jan 2022 19:45:43 +1100
Message-Id: <20220103084544.1109829-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103084544.1109829-1-imran.f.khan@oracle.com>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc96457-d918-4fba-47de-08d9ce957fe4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4417D38C7F1CBB14A0EF7238B0499@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7jG7G/zDdUaGMvkPE7Rm2WUNoeQD7xMsxOkO3jPg+l23JRYQW7LfSqjvHkgrLEsbvD3xhtk3FmEUrpJL/skJ3qwd4g1a7SJkBW5v6KHP0Eb7VOrIa3PFGwnRedWFVwHCReghBKk8AwTNPf6qVwHuTmHKWlaggUnwn6CIvI+jzQy4nIYK5mFs5UHMMtsA2MP7EbbUcs/hKcI8WdncNZYu/7DGOgdPK6AUO5oUOxrV1/WoTyh1jt3B9t7nbdjeu11Nricdau7n/qUcrMC9rqVDr7jt8uCcFjL2PF1neY7bcxS30AR5bkvd1jbtFjCu3weVl9Ur1uDz00pRVq+g2JnEp/AjLX3zQsrlWWb1Py/h+4RSAgB0KBXzPlcIZ4ds1nOrYQDgplOuOhvsGCMCaSvrv5Xf3tx9mWsvzLjryOXyMRZwBzjBrgRPMFXfZHeBuFp0ysBZOhooOxMDfvW0CJYR0EXjIgqJM0T41Ol56yEerDRVCiZ35EgvfGAEqcfOxMgksUdsG8PST7jA3N0IVUx2MhiouzZU0+8dhA1cg/COh9x/m3zEQWRHoUJyzjr62asKxRmt8Sd8/axD5CfxI6me+PTVF1igTAiThh+BlB8ywhZEKGtC5zezpA2LZYXKgj8JOzCSnvJql4jfKv9eWN4PUaCCCSiHkPyHTZL7eZOyGxHnHnW3Zc8ROpxLKDR9Zuakr/W0eAxY8w3vifqOJnL0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(103116003)(1076003)(8676002)(508600001)(8936002)(38100700002)(5660300002)(86362001)(83380400001)(316002)(36756003)(26005)(38350700002)(186003)(2616005)(52116002)(4326008)(6506007)(6512007)(2906002)(6486002)(66476007)(66946007)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aBLOOnO81B3sq5dh1uYBz+LFF2JeZnWnbeysdwNozeUsVoJPUUmRlUw1mivG?=
 =?us-ascii?Q?5nDmJKtTQ8GXC1u340rR4bi9By1l/2u9WrsMBHx+y/x7vbpT3NpMnU+LP8p9?=
 =?us-ascii?Q?XS5cAz10WqolqIh9rn55IRXjJcn5bBYmtW5u5bErvDO+jLdCjXYD2KDLdUMj?=
 =?us-ascii?Q?8vkp9+OvqMaJvumJOlP6vsrf1Gxv9Ni/4Ma4OQf+IHK26xM8hoT6hlO8JaxQ?=
 =?us-ascii?Q?6hbyj2WKt+1qTtx+UxuRHtDaUFp90wtkwGMHRDKwGdsAp2mDOYVQZIulxmnz?=
 =?us-ascii?Q?I0Rfbs6H/CTSVaIZg1WkiGouXOPoi1JKe8ujtqqJ7li1I3e+5yvPD651zCI1?=
 =?us-ascii?Q?wRmjhoZi9GWbalyjNPuHw8kfgflcmuut38Crbxh2sUovPB4buhmLHht0YeYZ?=
 =?us-ascii?Q?lkVPCT1kvoA8DOuYGB584lOAVv+5t1iEXL6yEJ/mMtHvWVFW33h4vPDQNP6R?=
 =?us-ascii?Q?xphJfrkYeZ4WaivB1DW/eI4ZNo3BHQdCiJIVhIEiOYFeOjPGmmqzO+gA6c9W?=
 =?us-ascii?Q?lZUVJR9kKO+AOqkZ7mjCPU6DTgDZSU1JarZXrjwngi+rzqzMpUoiqzm+pREZ?=
 =?us-ascii?Q?0gc/syCUYHxy7WYtkeMrwjJc2SsqjwIrkycCinJX5ijNzC2yGnQg0+FXFrQg?=
 =?us-ascii?Q?Z8JzarCN7scXU38ahz7ug1Mk9/lSyPnjzESvupmqeUmJPhihgsXBeAQeLhOX?=
 =?us-ascii?Q?VeeSgEnuSWB/25O6BuzgHYtCTa/+df9GcA0R3COrKIBzxDswlekxPLC2Hdq7?=
 =?us-ascii?Q?ccSvO0liBNiY9u5maEvbdrgStXoUpd6hW8TfPqzsS9UL3u7tIEBlNa3IsrGp?=
 =?us-ascii?Q?HEwqdoG3ZsOJNYL8nlpJBKAr/yYJ1/jhJROdFeZ7B3TtnUOtWcMj2Ci05qyx?=
 =?us-ascii?Q?AEXd98c4pHF8Wqzbip80t38+nSJYYZByey0TjStLOQShIJSZ636AVT3/46nQ?=
 =?us-ascii?Q?XH9VpqJHy3AYOnueMcOx187a1CDpdhKvydj7g4ZYfcWAebfFKouDB+ZXaXF6?=
 =?us-ascii?Q?EbaWQTAMhpa8W9KG2lUwWUgQdcbdgIXePV3tuOrW5oQLoVtlTyp0eICU8fyh?=
 =?us-ascii?Q?oikNVSQmL2IpxLLv+jd1gROfuXzomwJBPk4xpnxnwadwGAePG7Ye4NSkWT7W?=
 =?us-ascii?Q?OdAqqgjm1L15TjV0rex58V3MoVNZ5GzjWKAIFvxASo0sJ/xk9hx66HaSZtkA?=
 =?us-ascii?Q?40ZYZ+U/EdGaTMl/KmN/zhKL7TQ7A9RNXpn2v7kSbQox+dDhFGNqCaKIQKI0?=
 =?us-ascii?Q?LoXLgA6rwXYKL2c1tddr5C+iRGwCTAfAMZyTJzG0zYcjDSA7p6t5KfAMR+mX?=
 =?us-ascii?Q?QpYelDWmF9RG7eBWTCposKIBJA+Zfnb9dMXjbHfJomUtGWdgL30lLx23Y2ov?=
 =?us-ascii?Q?nLQ5URwBtfhaR7mPc0RsGm6wmO2irAR/8Cs72+/sctQDe++hinCkMLl1ZR7m?=
 =?us-ascii?Q?ifMhtTIr3ygv4F2ZzhkOLff7YuWRsBBJO2DDvF0ILeT+Q+vdESGJTb7XV57K?=
 =?us-ascii?Q?/mmPfSQZelii0Z5w9Cb+AMsiNPDzRGe+lhN73jMsuZl9dllDv/LnMCU69WnH?=
 =?us-ascii?Q?wOi3YIyd35J7YL46FsNAWLGDCbEJitPdDWzilDPmrhXj7VA5r41+o/X0DAxd?=
 =?us-ascii?Q?GkNO1m1zjfVG4NM/MYbopbA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc96457-d918-4fba-47de-08d9ce957fe4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 08:46:14.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3hPoJPyvduo84OFhLWcapOmrYoj7vUugywWRKEwxONUNWttTK/VYVQumoKErFkpPgY2PIf7Ty9OS/TvGIfdgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10215 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030058
X-Proofpoint-GUID: a0-JPZ6Ok4ChJ5ZEvkURydmaWjRn0KZT
X-Proofpoint-ORIG-GUID: a0-JPZ6Ok4ChJ5ZEvkURydmaWjRn0KZT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now a global mutex (kernfs_open_file_mutex) protects list of
kernfs_open_file instances corresponding to a sysfs attribute, so even
if different tasks are opening or closing different sysfs files they
can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time. Since each list of kernfs_open_file belongs to a
kernfs_open_node instance which in turn corresponds to one kernfs_node,
move global kernfs_open_file_mutex within kernfs_node so that it does
not block access to kernfs_open_file lists corresponding to other
kernfs_node.

Also since kernfs_node->attr.open points to kernfs_open_node instance
corresponding to the kernfs_node, we can use a kernfs_node specific
spinlock in place of current global spinlock i.e kernfs_open_node_lock.
So make this spinlock local to kernfs_node instance as well.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c        |  2 ++
 fs/kernfs/file.c       | 48 +++++++++++++++---------------------------
 include/linux/kernfs.h |  2 ++
 3 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4c..cd68ac30f71b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -603,6 +603,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
+	spin_lock_init(&kn->kernfs_open_node_lock);
+	mutex_init(&kn->kernfs_open_file_mutex);
 
 	kn->name = name;
 	kn->mode = mode;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f..4114745d80d5 100644
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
@@ -526,8 +512,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	struct kernfs_open_node *on, *new_on = NULL;
 
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
+	mutex_lock(&kn->kernfs_open_file_mutex);
+	spin_lock_irq(&kn->kernfs_open_node_lock);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -540,8 +526,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irq(&kn->kernfs_open_node_lock);
+	mutex_unlock(&kn->kernfs_open_file_mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -577,8 +563,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	struct kernfs_open_node *on = kn->attr.open;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	mutex_lock(&kn->kernfs_open_file_mutex);
+	spin_lock_irqsave(&kn->kernfs_open_node_lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -588,8 +574,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irqrestore(&kn->kernfs_open_node_lock, flags);
+	mutex_unlock(&kn->kernfs_open_file_mutex);
 
 	kfree(on);
 }
@@ -733,7 +719,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(&kn->kernfs_open_file_mutex);
 
 	if (!of->released) {
 		/*
@@ -752,9 +738,9 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 	struct kernfs_open_file *of = kernfs_of(filp);
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex_lock(&kn->kernfs_open_file_mutex);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(&kn->kernfs_open_file_mutex);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -773,15 +759,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	spin_lock_irq(&kn->kernfs_open_node_lock);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(&kn->kernfs_open_node_lock);
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex_lock(&kn->kernfs_open_file_mutex);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -793,7 +779,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(&kn->kernfs_open_file_mutex);
 
 	kernfs_put_open_node(kn, NULL);
 }
@@ -922,13 +908,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(&kn->kernfs_open_node_lock, flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(&kn->kernfs_open_node_lock, flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29..5ed4c9ed39af 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -164,6 +164,8 @@ struct kernfs_node {
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
+	spinlock_t kernfs_open_node_lock;
+	struct mutex kernfs_open_file_mutex;
 };
 
 /*
-- 
2.30.2

