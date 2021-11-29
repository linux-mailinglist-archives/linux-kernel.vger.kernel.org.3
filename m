Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3765B462107
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380071AbhK2TxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351872AbhK2TvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJV3JE028124;
        Mon, 29 Nov 2021 19:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qV7PqssXqUU8T+bJXqu04KrTBtYtiapct/HQox+jAEY=;
 b=bna/Y2HpfcxbBoE/LYGhMCgSf0t0POVU0M0VVqw8hCbTy0JAz0XEnmT8EgCH/ItirZqY
 WWQzG/V4Lgd18WWkiuOGpM2WK6y7W7ZKJBIgh446CTH4/DB05Uoleyx5tw4QdcAi8vT2
 WSePSKx+J9zJVNA/D/CqUomO/24osveGw/fg+a0qsTJhkZng/X4fc0rGDAViYaANWG1o
 Ct6ufAad3YaahdsglcxoV6w3Fqy1C0yNCletH6kXU3tRprjR3l4BH2p2/vx9a5vuqAUp
 PpXOim6sYEnnAoSdCMj4u+7uFHNlBJg8nijxDkzzfaVseZ6+UKJkieQDYow9vwirDCcs kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wbqxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8b181733;
        Mon, 29 Nov 2021 19:47:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpsgPHgrJNrW/fE5Zpn/R6MpfogS54i95VXRvegbkV+mnio/Zrd8aCAT7gf8aKl+hDga0kJP7V0lto5hRQUJxNCaAm4PCM8ApMb5TYAT8R0ojGPjldd8J9YIMg1s51tOJvS3/XCJF7uV6PBpqBCLqEenjPvljdJCZh0pdCYR12pvuE5/+zj0vEpcoB0MhMr7z2TEyozwae9VnSAR5VyHU6YCXFdOZCONngDyaQE0kfLtdWPkQHHwl5MQEwZ57sY+qNs19FEaWFdH5ZXa7V98mRBFtO6SWrpQamPGTGwIy8XqlEt6KSfW4BMKEV+pVmj5vjrhgJwSkG8HMImGn0H9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV7PqssXqUU8T+bJXqu04KrTBtYtiapct/HQox+jAEY=;
 b=WisAscbNXtX30D40Ozq4DDSXFlTvfEkNfHxN6u3PfD6ostQjF8FXzvjSshIixbcpjzF8Yv6oEKwPg9+KTdqpa3uO8TuB+M2XJEOEqJ7Gto3OCl0G+RuaKUAR4jx1iNzkqZE2+SlR5y4qgNR4zNGs5ujsSXn6gplqcQjXoiY8nONNhk8tfNKGWJ5ONFo5vhDb5iK8FKcZq2FMN9fUPYonCGw7FrDq8PNo2dB5Igzt+qeahtn/BJf60RMVYSafq4sVHUkTnuVvkaSf9pD5N5NWyq5aLj+PYebZjomjE6d04q3VxvdPwPfCdAeyvNM3UgVXnrH2cO5ua7DyOopZk6HncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV7PqssXqUU8T+bJXqu04KrTBtYtiapct/HQox+jAEY=;
 b=oWnutVFf1xEsNx1nZMtxkEMdwYcJbWqt3+JGatnVgFpz5GdiF31Q1FDW3aXMU/bqWJHU2KMGWwnL6qZ3o8evu7BXENtGo9mWIZLQxMrWN97C8YAzeG8HBJWaRvHxDJBdzaCUcZmLmkUs17GOjjmr3yNmz7JdTr6+rrU6e3vozcs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:18 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:18 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 03/10] fork: add USER_WORKER flag to not dup/clone files
Date:   Mon, 29 Nov 2021 13:47:00 -0600
Message-Id: <20211129194707.5863-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73a33d6a-6bb9-4e65-1c86-08d9b3710d37
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307367466538E0EC0DEF0FAF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaGjGAvN+gF3tHPCamtP/le5LT+ccu9lJpCvsUDcq3SGn/JV32tTDqMuuyO3gNDHWEJOYTXkZ/vuC1ssE/7JvpkCWeYNzM3jaZUiuNb6p94d41J/3lMw5r4juXQsOeZYMu+lTpeCLiGN/O/SfNmm5aAbbCPMu9yEaoMS82ZAPntoM1V1yINHH37BW64PL/f7LjG4L0c0GeDcL4cEnhlkpYMY9KLmfPL3iXBdVwFh1fBGHEnVMC/mMglFP0UcjtKkL3BSxoVxC5g8GfpxrIdqKsFqMf0Cd5xARGYiFUkLblX7GytXuiO4U5/pNhMWvPGlZHaNkIskYVpFyNSy4miSPXacuc7Mj6Q1wbHrJbdMzIgfe0A26LX0IqPOtnL6pxWG8cvI0Ui4TCSzMSsocWkViRxlBoaKNDibee+4F5VbF1N5oftullglWfOvtMeCm8ElLaeC/h0CILrcP33tO1bNY0u9Zk6pZRNyQ4D0Ot9hOrAg1pSFTx/q/xU2E8BsVQ1qV4r+70m/Boelp57o75vN677nVMQBlyQMYvRKT1EuoI0HC6B2TstpvSn45ER3lrXXptwU0GgOZ2fj8PRhcuk8eqH6e+YKDgILyIP9WeiPPM75LcLo/oKGydQw/0u5QBdpNVBoSMr5zPTWaOosKt4+07qUYBm4LO9vT/SJVJGjwX5AFffYHszRaKtb5bP6eqWfBTzk/V+MhL549Qj67GcyS4/ooZ6Drf8wyYd2MkDouIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(54906003)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kb+4/N0GNVVSTSxFKLjvSXNTOV9hMeWHs43u/FTLRwpWb7fKh6IpC2N1t0xZ?=
 =?us-ascii?Q?Y1yHZBTTbKChSG9wuxsAZOn2IxTXDga6jyOjPOvHS7n643JsW02vh4fZXFL4?=
 =?us-ascii?Q?fXj+RAbHHY3Q+kL3CmYoDLijc3PWXF0RMFL8hWhoExE2DgRiC57NsnAqM2Jc?=
 =?us-ascii?Q?JZ28w748S0yfqh1/ruru/qgTnjnB71FVVJbVLHENe+9SLJBJSG0JtOgXYye0?=
 =?us-ascii?Q?mss+0/p+gAolw3ymQV+xiXXIiezDWcF4QulHp+pVD15QWYxIGj2fG+x58dqn?=
 =?us-ascii?Q?U0JOrmtQQFINeqREjWF2Benv+ycJOX/l63azAwEIzCVdm60xV1K1OCW5xeXn?=
 =?us-ascii?Q?uAegIPtRbrKgNZFUBI2PEZKCpAnc9aE3H/NnTbyNOKZK3bqS/+JVKnHVr1WS?=
 =?us-ascii?Q?DMVjEtvlIjomyO2HnJmO8pyQl9Cu0u+ww42jeol0uNHhQiWmR5PSW5sYIkeH?=
 =?us-ascii?Q?nr3F627KiwgfpFj86Is5ItbFG1VBJIMwIm4k+Y4B2Ue6q46JmT/D9oFAjkUw?=
 =?us-ascii?Q?RU/FCYxgagmMrZi5byRnF0WhOZmLfKGCRJGeboue7g+7ugfj04CXQ/t933UE?=
 =?us-ascii?Q?Hv3rVz2QoI/J2Ff6elrPMY+V/22VVSnRLjAvvx7RbrLlfkLjB3Q+5+6P69r+?=
 =?us-ascii?Q?S7azbwsaf6xXxIh9/G8mYrNaSRDQRvby4HKVX7gz0irVT2xFgrlaOY3qdOAE?=
 =?us-ascii?Q?JMtGBmB9+u887hZ1NaXk7PyrqRovESjR+fMQItYaeYXu23BP+b3+d2x6NALM?=
 =?us-ascii?Q?QgLXykeaXC0YBoMNixQz7GGIsv7385hvoiI8rINjVpcnOjkq2XoZ6dwZXTl2?=
 =?us-ascii?Q?7/fo/CG3woXcfAeld1jzOPYrYbE8Ob0LRfpVIt6KNI0RynnEKeG3n/SPMaGu?=
 =?us-ascii?Q?F2lc6xpMy7TSsI9pKmGNwrO0cGbUgTbI12jRPKuP6yhnDayucwm46YKDQeGy?=
 =?us-ascii?Q?Busumfn4oWQZgq9ZBjAcgRSMizu4xRFeYTk9RvGqXhfwIKaQ+nSSEYpfYlFX?=
 =?us-ascii?Q?kZVYzDBP160cURBuaObvMNWJxaZR3PMaFYfeN0opvfeh9q8QNhhdAi0g9ksO?=
 =?us-ascii?Q?QWfNXDxUTR45s6eSCBKYXvX6z7E2jW87E95UgBnCcfWebHiUOJY6XJp+Ft4q?=
 =?us-ascii?Q?KMAzFFvMFFmjarj8AKz8mAkzAlS0Gkmr7YzwvHy6/1lrXIYo6gOk5pVC6d68?=
 =?us-ascii?Q?nsM+OIMI5u72sRZjkvYzkNhE84niM9m5KfhuqrE8PQWH+ZYrsnDYsoaEg0uL?=
 =?us-ascii?Q?UDkvL+ZPGA2pQ6YPUV8jdsZI6ypVgqHKbzUl9Ls5S1EuVaaq/NkMpJycIw5z?=
 =?us-ascii?Q?EVGUVacMQshMfTOVzWKRNs8ea/tccOhva814vxaK7PG14l3EFwI2PuA2Kija?=
 =?us-ascii?Q?8+k5G4kOs4dNI7OE7jAulEaDY0gcvHBdCeYE81UpbH2VJIhMyTUW5W6doSqn?=
 =?us-ascii?Q?cNgbo0n1Y3h8L2o4pjvjfG0zzwGdoWq2/v+FvNsna5GEN0smaFZqRu4uPSUJ?=
 =?us-ascii?Q?VF5NNbjs5WU8N79MAgGHQoUXGO1g6DPGhqHEJKgvlDaO6PyQqLoSTvDMK3/Q?=
 =?us-ascii?Q?1+AktUX4grzy9sqRV5ys6gRhNuonJVx/pk/2oZp/W2Okf4R47JQDLlATmp7Y?=
 =?us-ascii?Q?JqJlLmUevjKKTAMziQ8oQdNeumU1QXmSkX5ZoMPmDV9KdUTvjDPWwFlYxPuS?=
 =?us-ascii?Q?OYsMHA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a33d6a-6bb9-4e65-1c86-08d9b3710d37
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:18.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbKtTlM2exA8JGXSjtvYs5Gvxw59E6XF2+oOkC0ZgVWIl8ET5UcaMjkWl2zfILDy8EfYpzLkkGmxl4qTqAnPQyoH4jQRFzcavcAkWNAcQbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: hFBxfjlbjvXoNnpIYBJxqeCZqEvuPBl1
X-Proofpoint-ORIG-GUID: hFBxfjlbjvXoNnpIYBJxqeCZqEvuPBl1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it calls the user_worker() function added in
the next patch we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index b7861cb6a74b..e094502b2eea 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
+#define USER_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d278ac26f2f..a47bec00f37c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1529,7 +1529,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1541,6 +1542,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2179,7 +2185,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & USER_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

