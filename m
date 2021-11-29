Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3356462106
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380026AbhK2TxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26414 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351704AbhK2TvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:04 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJUubE021038;
        Mon, 29 Nov 2021 19:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=99GwF2neOpDIPVbAa0kOxzXzoJ0tueHGomv3Dt5a1nk=;
 b=kvld/ZaB3sqa+URGBqWHe0ikQiUE3WAMLdg7YCvyz+lLJFPgeJIn4SWXKvd3wr6+dezW
 ZKhEZxKx78guGC3VmnikBvHXsb0H/J+A+EungPQVVxHEmmrJsGjSqtuBOcwcueJc0oe3
 8OAKkhbrJJmvFE/Beuk18CLYmL+hna2W1+FKqlUwi+0rKlUHvMGeM6A2iZC6QKZGgOBk
 vFJuhys2AhCkLJ+yp4ptNtczeQzB0pPq2KHBfyAwmR3vcsDzHq4fJHP+/ScVLE5HkReO
 kbaRAgxQ59Hxlc5Gk1lt1F5lAhBmY88vU6Ai/wAKHVB6MrJYpCXiFndQizy6+tqU+cdz 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwknt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8e181733;
        Mon, 29 Nov 2021 19:47:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZjy+GliT41KBvPABjxKsXDNV9S8cf8/b/AlpZKTYsXJUM4Z84vN6wXKtw/nGLturGr74+93F1B4FnIrKrcJWKJtdHtxqhsUW8hYybGK5BYWTV225jhVu5BNBODSWh+5dBAD6+dSU4mEPvHmYDTyecaW1jAqA8H4X1ZLxpGLNclnkFjSy9xljV1n9W7N7mNiK4T07065E71HMaR6wsgj3VwUSWqlWuScxLdQj4LWuFqjOb/YS4VLEWfVIoIG1ohpNHkS2XxU7RWQIwFXZZuga+IZntWgO1XHAzXZRfKz11Y5fiHHHXuHIwQWqBdakCFOBu2m0qKbiqFfid3HX9OPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99GwF2neOpDIPVbAa0kOxzXzoJ0tueHGomv3Dt5a1nk=;
 b=j43KmFXs5By/RuF+YvASDVHsXQUgak+DJ+pZSY2y07Nl/dwsNt+7STrDVIhpSDUzZ30V6IwJ4XF3MV6fjvjlyJkemnHE2CMQZpuzmxNff2zqcdhRoLB5i0MZZKhzCLXpR1qis7qgEV/60c9/PdhwmJ1iHs7J7LcAqU6GgeEEdDuWTnmOwm+F7gdbOx7Uf3koou1Fa098MG95UmwUAdHqc7pxGWfeO13IuWTrZBBTkokiZHId/gW+u0m7Tn6w4BeQWG4jNhKzBKajpv1XYl5Pi8Lm/QbjupSO7XgOv/hRJ4nuqg3zDqH3nIUjta5X5ojKegYhAdSWX1PedJ7xHy59rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99GwF2neOpDIPVbAa0kOxzXzoJ0tueHGomv3Dt5a1nk=;
 b=AsJ99K0DkdkpmJJZR4OU5DGi7wayCHfVOtshzJC+ekZ4OanyyLgxOGyDOW3bCbJ9NZCg8p/RWwHwM9jepNW56zHIfUT8FeWiKfuIf02lRjqjEWKjsq19uV17P5Z4SiE5F4jTOeqbNVh/AYl42ZkDHqeJ2sIjhDzlFnTGZG8VJAU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:21 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:21 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 06/10] fork: add helpers to clone a process for kernel use
Date:   Mon, 29 Nov 2021 13:47:03 -0600
Message-Id: <20211129194707.5863-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5facb12a-68da-4563-30d8-08d9b3710f14
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307CD1543EC74B5DE2392EDF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcseTCCm7BVLo9YQ5cq9Vexk16oX78hrGuYOpMflE/bUPQGEcS/9yX2xqiOiFlw3HQ1FuxM1HMOzS49SOrM+aMtlN/F2lhM2zLamZIRnf5MuzglA2S/55iV3AYrN/BunMy54ra480ZaV36wWBXh5txD3PFdmpWkaWXMPfGLqd56r3tVKJIp9cXaLWt6V6knp0s0Fvt3Um7O22MA/nj2E3dvgfTy0IRF4CsHjiNs5CNRkgOwMEjeGb2EpcZ7gFq7H2gGCseCNi6MuMabP2i7ljne+SyEbHaOstVxJtd6Ya8ThmkZmw3z4e5ae/A1VJo/KT6u8iDHknh2SdY+SiHIro7rQjzyPIdlJIemXKlAbVJq76/2BDWuVLWO70gng7xbXwpEo7C1LUuHRKLwIco1JgXQggaJ7ZWAo4Dgd/zBCIw0eGUNznKt3Kq1uHlfVswuFdssxE3TZIRZ/q46lMtkfGXDAQ7awoI9GZ4sIVVbITGwpIRzMUuKrRSRjJexllh3fBzqh32rINiOA1fNtU6gDgMCYsk1ciDS7sv/33JTEppPriodbNmunsrv5k4vtXi2K7IvdjW+IOEPP20eNMP28QUVtRQf3BaVfbWRvKIjsWFyw0XLFYq+XqrE0nqXVBit7zJs8SfYfpI8nZoE3B+9AQ5fLRYiGFudkhb5VLcmfD1+qVANI+c5GeZ32wTaqRWiryzxOyapCm2RqFGSQ+35Q95dgaJXcmRwzwKOxmMTGzj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(54906003)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LHze2e7wItqVtPubH7gwF+YrHPIUXrQAB1nmnVuDYIMaB7L8UiUfAumdc2K6?=
 =?us-ascii?Q?0T4Gt8rKIuIhXaGU5Q9zIRuqCTKswl9oXG6B4FgxlbbwWEHe7KzVtvtECtSm?=
 =?us-ascii?Q?J2lzy9Kv9UJk/fDhD+reMo9lhG2sgHPrFZUvKclgh88pWex3BaIA3KBFhg7a?=
 =?us-ascii?Q?yxQ0TWXXrH/gpc6+2yvHjsLBmmyL00lyQx4jPrGyEag9b21XdwznNRjztMih?=
 =?us-ascii?Q?IWxcAdH5Xj5zLugvkFl0hvIhu2j4Ij82LsPVXii5puFmaAyHL+/Ttnkhb3ZB?=
 =?us-ascii?Q?seThvJ81muSoWpkI/+EP+fO39ljkf1TaByrwSpzf7UewEvJO48XWnV+tFYfz?=
 =?us-ascii?Q?I4hwbzrtkUTpqOHHDLH6yco1L1Z1XXzqArWOny1om+cURycnGdpV2WgDG/HZ?=
 =?us-ascii?Q?VgHzjKlD1BXelqM2geEtkTcmUqF3YXOCn9kJHsOM8H9h/m/vhDhQoAYKu2nW?=
 =?us-ascii?Q?JRtJKO2cnY2jA6xmWu7OL1jTK+0TyQXZbSZQfEX+OifSWUyqluP8lzTKVlXA?=
 =?us-ascii?Q?Q/rms0McOKdT3QFUTPG33MvVhFlhWYuaB5dILTg1MjrPZ4nyBOONkz3bCP43?=
 =?us-ascii?Q?7N80PzyrqFIWbmtxhTe1PSr4naSMBYK3rZFJxVym/mHgcwbqDtwbBiKN6Z61?=
 =?us-ascii?Q?HzHhZ7r9euYlzFDrLnlS6fbWg8gwt0uQ0/nRBuvza3W2a5Q9qK4WDVKW1P84?=
 =?us-ascii?Q?0K0Sj1pZ1Rk2VBLScTlpmFH4wde9OKg4TgHjko1FBuEh9utHgiK4ZVFebPb2?=
 =?us-ascii?Q?sM4htbAzsWJ1hYG6DQG4lUf8E62bMdaocr7xMnZgGaPSxTct+6qOI3QaVo5x?=
 =?us-ascii?Q?FpauDj8oEyA6wjxIDOAPSoA5XH9M4u4L2X3WMBgOJZGR7uTZZOulEQGkcyzZ?=
 =?us-ascii?Q?99WorFSG419cE9nx+JtcK1hEf4aI/PhYiD/7Iif/UhcS8LzeIFB6QjeDJ5N8?=
 =?us-ascii?Q?NN8R+ZL5mlf1cQxe/IukREfUSVYxVEExUlTwbMPusNW+RoJgW6BvpT7K+y07?=
 =?us-ascii?Q?hVTXOpPI1Hv5oGnjlX6vUsjxPVjyt/FcElAy5Th0hRiDRxeeHTM5X9f+9qL1?=
 =?us-ascii?Q?bd6wTtvjzoHyoGELQVLf9gmHheXYAdX+ysey8R9euUP+MnDrho/cS7U/4FRc?=
 =?us-ascii?Q?1b9sjyCTsYrYlYCuq0idNjvgd6F6Kq/G1ys7w9ilCdhZLdU7B7KfnrmU/LfP?=
 =?us-ascii?Q?yeh04FcGXx0WPReo4t9wpsTCwOUs5p51AFME1pG4/iY/z7h9U+3ahXr06kJH?=
 =?us-ascii?Q?jXJQvKuQUtYDb1im0XUdc/tsj0jvxKA1F2XvSk3pMutNMCAvsXbBRQ+sSjlv?=
 =?us-ascii?Q?0ozFHs9cbVx4BfclXoULHyyAqZ0X0IHOqkOkjvvQ12bjmhXZp/swNrVZVKVU?=
 =?us-ascii?Q?XHsolcr5PO6TkRHWBcS7hgPkM5L/CkBk0eocinNZ8b4KkGKba061Rlbe/Ya+?=
 =?us-ascii?Q?7K17lTcSyXi4+wTNk8NnNYm9DcB6G6Z+Es254QV1JFB2PUT/OCJdZTz1R89z?=
 =?us-ascii?Q?5GysldKLIlov5A6UYldiB9vX0o+suEa3LsoyMAWysw+rU0p/NWs8InOLeUN+?=
 =?us-ascii?Q?dvxujbA6SYlpqKoflY0t8N67YnnJC8E7drsO/bjS4hDvpufOES9XjTfJjaiC?=
 =?us-ascii?Q?rlHVclgwcAH5ZR0kjmedhjLR3MyMkdbVuLbpRMPh8/mayVk4d8mjypzi0fC6?=
 =?us-ascii?Q?kpgA6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5facb12a-68da-4563-30d8-08d9b3710f14
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:21.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qomYUTXlHTnrO7qf9Q5WqLiBEXnb3lb5MazjnJMNGCIgNKdpfqOTmcGnyX1J9+0BcdnAa3nVw5F4f3CNryn9jTC/VjGyDBhQk53bqrDdV/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-ORIG-GUID: QbnHTMBfw-pyGM3x7IlABlbLco3vE3r3
X-Proofpoint-GUID: QbnHTMBfw-pyGM3x7IlABlbLco3vE3r3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vhost layer is creating kthreads to execute IO and management
operations. These threads need to share a mm with a userspace thread,
inherit cgroups, and we would like to have the thread accounted for
under the userspace thread's rlimit nproc value so a user can't overwhelm
the system with threads when creating VMs.

We have helpers for cgroups and mm but not for the rlimit nproc and in
the future we will probably want helpers for things like namespaces. For
those two items and to allow future sharing/inheritance, this patch adds
two helpers, user_worker_create and user_worker_start that allow callers
to create threads that copy or inherit the caller's attributes like mm,
cgroups, namespaces, etc, and are accounted for under the callers rlimits
nproc value similar to if the caller did a clone() in userspace. However,
instead of returning to userspace the thread is usable in the kernel for
modules like vhost or layers like io_uring.

[added flag validation code from Christian Brauner's SIG_IGN patch]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  5 +++
 kernel/fork.c              | 72 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f8a658700075..ecb21c0d95ce 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -95,6 +95,11 @@ struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
+struct task_struct *user_worker_create(int (*fn)(void *), void *arg, int node,
+				       unsigned long clone_flags,
+				       u32 worker_flags);
+__printf(2, 3)
+void user_worker_start(struct task_struct *tsk, const char namefmt[], ...);
 
 extern void free_task(struct task_struct *tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c9152596a285..e72239ae1e08 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2543,6 +2543,78 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	return copy_process(NULL, 0, node, &args);
 }
 
+static bool user_worker_flags_valid(struct kernel_clone_args *kargs)
+{
+	/* Verify that no unknown flags are passed along. */
+	if (kargs->worker_flags & ~(USER_WORKER_IO | USER_WORKER |
+				    USER_WORKER_NO_FILES | USER_WORKER_SIG_IGN))
+		return false;
+
+	/*
+	 * If we're ignoring all signals don't allow sharing struct sighand and
+	 * don't bother clearing signal handlers.
+	 */
+	if ((kargs->flags & (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND)) &&
+	    (kargs->worker_flags & USER_WORKER_SIG_IGN))
+		return false;
+
+	return true;
+}
+
+/**
+ * user_worker_create - create a copy of a process to be used by the kernel
+ * @fn: thread stack
+ * @arg: data to be passed to fn
+ * @node: numa node to allocate task from
+ * @clone_flags: CLONE flags
+ * @worker_flags: USER_WORKER flags
+ *
+ * This returns a created task, or an error pointer. The returned task is
+ * inactive, and the caller must fire it up through user_worker_start(). If
+ * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
+ */
+struct task_struct *user_worker_create(int (*fn)(void *), void *arg, int node,
+				       unsigned long clone_flags,
+				       u32 worker_flags)
+{
+	struct kernel_clone_args args = {
+		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
+				   CLONE_UNTRACED) & ~CSIGNAL),
+		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
+		.stack		= (unsigned long)fn,
+		.stack_size	= (unsigned long)arg,
+		.worker_flags	= USER_WORKER | worker_flags,
+	};
+
+	if (!user_worker_flags_valid(&args))
+		return ERR_PTR(-EINVAL);
+
+	return copy_process(NULL, 0, node, &args);
+}
+EXPORT_SYMBOL_GPL(user_worker_create);
+
+/**
+ * user_worker_start - Start a task created with user_worker_create
+ * @tsk: task to wake up
+ * @namefmt: printf-style format string for the thread name
+ * @arg: arguments for @namefmt
+ */
+void user_worker_start(struct task_struct *tsk, const char namefmt[], ...)
+{
+	char name[TASK_COMM_LEN];
+	va_list args;
+
+	WARN_ON(!(tsk->flags & PF_USER_WORKER));
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	set_task_comm(tsk, name);
+	va_end(args);
+
+	wake_up_new_task(tsk);
+}
+EXPORT_SYMBOL_GPL(user_worker_start);
+
 /*
  *  Ok, this is the main fork-routine.
  *
-- 
2.25.1

