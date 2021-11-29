Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21D4620FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379165AbhK2TxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48808 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348333AbhK2Tu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:50:58 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVDrT026596;
        Mon, 29 Nov 2021 19:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bcJBzdi2Vr81OfZ3lTm7xNp6wiwRCly6zeJtRJIBF1s=;
 b=dwC0SdRQNo+96A1Zt96/SzoXlqvCHzyn9yIPFRl8UHMQURfb1kqlVgeotYZCoikCcYGa
 F+VL3gc4Slhjb17ziGYAffylCLXJjr820PRkw1rjmkx2jtwVTPb3hTAY8d/iOZc43waA
 9nPBC9EhxuYSG2UORvBQOrPVFCHE7UC0C9K6usmxdgP2RSqM9m0B1wMepX/M6Y6vHlBX
 dVZ8nYnqvb4kixM3EGXBHuZqLMTbSsv1gdAGY1hZa8Ls5DJnNPJtydMPFpe4/x+04PYG
 4XxHiG5te2rPw3YSovaVXgogFRzsPCO67wVKqXuL9gMkXswVUjyi6ldnJ3Tly4GXiZjn oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c3wje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8f181733;
        Mon, 29 Nov 2021 19:47:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhJ8USzR1Ilcyxw8E1TCYJ9H1J5gS/81BHcSRQv5Xo/DI0sZ9X3eTNLtOOBcrINHCqaHk2YYlcimegjgCWfrl5l6lzweR5SGPQSvEVMPZhWZpZB/T/xgGpmpF3hN4k4Dtc5vGPYZA+4WNzXgJd63R5h+YS6ARINbkpU4fgcy4jXP47gPyXtsg61kW/xFZDqLWY3jdNFv1GtJjqCbM5lvHgmVDDNeIgeBw/Uk75I7qU5OryEMa19qrKzkrArM+4KAG1hqKNbrxVMBVKfSAdNPKSyHDB7zxZj0jRAQUBz3W5nSpqW5/fT5wpd+JhFOrD9FuwBqLqb+3+YTVp8hacyniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcJBzdi2Vr81OfZ3lTm7xNp6wiwRCly6zeJtRJIBF1s=;
 b=Sq3ZtIEpUSASpccGSfZKriOaFkkkctNw2WNK94hFu2Hqc3uSovivoxRP6uCd+ps9Lm8u+8TkxyCOHZ9G/Jj4qRKsdLSUJQ2EGilQ+ghd0cO/7TlkfVQGzgiUXMCo64AcX5xmfjCCrMk0qKk7iuHBF8OpJJqRzODWu0kjl52XTuJZ/nqNjN35GaK3KSLmgTxAsIMXGiD9CZx6O4CgC8vugIuXUWnQS8BpOsev+a9vFFiFZkpzqBsWZVFg1bI5KnvTpEkOOixhNRwxD+YN/VyG97RkOKAagAVB9Y/WDRVT4hMHByJsS/oLSsKs03fReg4x+p6FTaUbyC2/6oE3JcqDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcJBzdi2Vr81OfZ3lTm7xNp6wiwRCly6zeJtRJIBF1s=;
 b=oTEOa0dueK74m5QbRvWlBTO1PoLB4aHTlo/FALfWbjBJSfDDtx3QtwADMiBlkrcx46SrxKKMQCzXB9RAf4sM4JkVisUN1MRTPWr4uJDMZbS6oILqq7Jg3fetPpq/NbI17hmj67Q0LNJaNcE5ZcgYiAhM0dnPxZCsOawJpgsy0i8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:23 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:22 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V6 07/10] io_uring: switch to user_worker
Date:   Mon, 29 Nov 2021 13:47:04 -0600
Message-Id: <20211129194707.5863-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f159af9-6f8c-43cb-a3b1-08d9b3710fbd
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307C855A39E4EFFDCA70493F1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecFJWFxtR/o66GMqJeGzzVuz+sbDDMXP+Lrcfw6/xRGtcNxo0ZSkwqctl2wisbrtwSv+tZLOsv1jcC5zjtMhiFtIzvmzgCU+Z3bqcbjI7djUWRFCPcVoudVQdWzLxNyuoI/B7yH+O8Hr33HPaU/5td+/HZS2v2wUfnbG3vej16J+T+uNWOKj2JUNMAqPGpRNvQNa3pJ1jHt0T2x/DJmnO+tEyxFyB3b7dJvkopYeLDWeXZt1utX6iYAEbk6FpVNy/UvPIfMkrzs/BPV4vFwifqbyQp1E4m39gZou9H2K/UF+/+nHQ8gptIGHzhR0kZXz4MQ/6WwBKdkhruBcB5c2Fhnh5F/f6Bp0eSsCy2bcr2gl9DhXi+iBk5b39iVePrKcHPaxAIVOf4xX6U5f0AvTaUwY3q/z6X8LxpSMcrFo29FVwD2myzOJmU05pjlEB12KC7m8xj6kw5Awi8T066dZ47YbXASOXhTyAf3sy3M/Fzuq6uiXdOBzNwhKXN+IdFNnapqLKgpQH3DmKy6rnU+FQQlm9neXjXsEAWxJcOXAGqcUd7/sB9MojjxZJnqzF+/cLmr3hshlaErNkAwrtZEtctYz8v+yIfGCAZMSkbZp3D5/qqQhnACuOPCrJNpdSsNxl/3Fg6EwGsgh/fB5uoE1HlCxNzlQ65ew50lJw0AvrkhVJQ6iE3NIYzl7ixSGsULaE/+D0eAEAEKoN2nneBbDyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(107886003)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlnuRJh2fEEIFy8JNqFpdb5j32shWZByETceo1VqxDA+bYO5Vuz6M5QCRgsJ?=
 =?us-ascii?Q?N1BINCik0BTkxvhn3HgpNgJcp7N4tyeBdIVVGkep7O8WAXtjPmNw6BdRbe7f?=
 =?us-ascii?Q?jDwtG/gN/4J/oxx2xDm5hGoWs86/Oj7JPPkrM/fNF9tq3MRqBQYJgmmmCFwM?=
 =?us-ascii?Q?1WwC4R656tw40quGcx3TjcVhWIJv5ElA+B5vV4hv4jcSGfNgznrQYBsCd9e6?=
 =?us-ascii?Q?a44yc/U0sYr9Q6/K7JC6I2wShHWHu4uxwgNcbNHSsFJudEyO533DKe866IKr?=
 =?us-ascii?Q?JYNhM9ErAnSS9mMWi86Lny0io+IkTMGkFkX9e19TefhRXwcXh+eAznHO0z8E?=
 =?us-ascii?Q?Vk6dyvl3ZlXassRukln0sB44NUAl4SL/9sMgwDpVqqCuZlMUtvMifZlpv/iv?=
 =?us-ascii?Q?ZsHll0fSMWUXm2H/NpHjzAJhG4bC1bQW1xAyDz+mOnNfI1oWZNqEI4ExeJ1l?=
 =?us-ascii?Q?9018v4MBQHUoxzCjVExhvi7tlUgMZ5FnzhqMrFpNPYzNF44gm/4JebONZQN6?=
 =?us-ascii?Q?rPu4iABXVv1ESXdN3SoO6nIgtgdUxMJCOMs6GbM+zWsNrMkA31HeygGml2bX?=
 =?us-ascii?Q?czyNLm/aHzoLTchmOXZUO3E0flG8CXIy+mFjwwRIYMkZnxYAXX0q11/4yWNa?=
 =?us-ascii?Q?mO1dX5m89/tl2K74uySbPjZ7iMVxddy5hblwTLKwtecP40g2QxgTng1sdlNl?=
 =?us-ascii?Q?UrAAByNbhY57RLttIbgPe0PwvX387AlCWAaF18TW6AfCv4ztPlr8NU5C30R4?=
 =?us-ascii?Q?fLgnPNb+XjVEvdZ4rD4dJpU4kzFMnkLHe+TrAF24llcsdq/WMJpwnIraMPRy?=
 =?us-ascii?Q?sxENNOXs4Q4iE+C+7Srl0VdogxZMRxYNQOFNxOhuT5JFdMJsD73kLY7Bp9po?=
 =?us-ascii?Q?Ik1F0BtSs8Fn4yG0j/mIViPs/ntheACCmOV/16myBbsoxO60bJpIW6bi4mKv?=
 =?us-ascii?Q?+y/Dwmu5bUDPT6pwGR5Rc/7/ovRZOauaOyCbTFCSQB406m9ATDTSeQ2aQNDj?=
 =?us-ascii?Q?eFocm92lQZdMhP10wQuO+SrAspneP3nW23Wyh3NBbxMoiHfsrkIhapysNlnu?=
 =?us-ascii?Q?LRurgCGmxaCz+ag2zLm1rcOGRQxAFt4RaET+TMsK/H5+bE3AWPcEdBcFVbiy?=
 =?us-ascii?Q?UthhZhAnrMyhBpgTownqqWH+KoWbma9I6GYKbiwumuo+sCA5WeBCRGRItd4J?=
 =?us-ascii?Q?87hLYzM40reXBL0JDMnCNnQyBxF77wPoX6C8cqClRGrgmLleEe+7M7TF/Fit?=
 =?us-ascii?Q?k2LVdNWHHnhgwYcNIPZf99nk9d7PKp5OxO/lS7MAGBlbpxMdvtGR7GFdmmny?=
 =?us-ascii?Q?OyJecOxHTHp0tRiilU7mhDYOjtwKpNU0ALqtDle82fxADPtWkD+tGlphWY5a?=
 =?us-ascii?Q?5kAj02JeFLkeDOYdMO69QcYJEfS87NFqvOs6YtFYb6aNBSCGloAAlkB9nNSU?=
 =?us-ascii?Q?vMZKkG+LqPWUrNVf+6XRBOwcdrTWEAyGeVq+aiI6VR/XXiRRjPj7N9KkH4wq?=
 =?us-ascii?Q?dLqOejdYERHCIUKZLqNS+mASC6cOnLMkiixVxSyZ2sXHWjibINfm59VSrhSj?=
 =?us-ascii?Q?a5iJRJcO6k1RuUJR5vC1UQLpuycZWwIiNdps+BJM/+BE2KOHvE2L4T4OQJdq?=
 =?us-ascii?Q?zB1zJVzCf5HXIherdgE4dcE0Pio6Oogucg9A5fjdCDPwZmq8Gue9x6FMYyRi?=
 =?us-ascii?Q?PmIBvw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f159af9-6f8c-43cb-a3b1-08d9b3710fbd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:22.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CHnaKi5Phqb+JBG/8cn4tyihPR3vh3ZSHkGWXPvWfo5ie8iraLtMktNW/pgGKOWaAj68Td8MR7ASOk52ppoFjPDjs5rtpzfOgRi+0wvtGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-ORIG-GUID: LgP6_UajEmjfvlmOutvSRphcVDsyhout
X-Proofpoint-GUID: LgP6_UajEmjfvlmOutvSRphcVDsyhout
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user_worker_create/start helpers allow callers to create threads that
copy or inherit the caller's attributes like mm, cgroups, namespaces, etc,
and are accounted for under the callers rlimits nproc value similar to if
the caller did a clone() in userspace. However, instead of returning to
userspace the thread is usable in the kernel for modules like vhost or
layers like io_uring.

The user_worker_create function provides the same functionality as
create_io_thread while also allowing different signal and file handling
for users like vhost, so this patch converts io_uring and io-wq. The next
patch will then remove the create_io_thread code.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 fs/io-wq.c    | 15 ++++++++-------
 fs/io_uring.c | 11 +++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 88202de519f6..761796c14d3b 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -70,6 +70,9 @@ struct io_worker {
 
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
+#define IO_WQ_CLONE_FLAGS	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND | \
+				 CLONE_THREAD | CLONE_IO)
+
 struct io_wqe_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
@@ -600,13 +603,9 @@ static int io_wqe_worker(void *data)
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 	bool last_timeout = false;
-	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
-	set_task_comm(current, buf);
-
 	audit_alloc_kernel(current);
 
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
@@ -704,7 +703,7 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	raw_spin_unlock(&wqe->lock);
-	wake_up_new_task(tsk);
+	user_worker_start(tsk, "iou-wrk-%d", wqe->wq->task->pid);
 }
 
 static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
@@ -734,7 +733,8 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = user_worker_create(io_wqe_worker, worker, wqe->node,
+				 IO_WQ_CLONE_FLAGS, USER_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -801,7 +801,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = user_worker_create(io_wqe_worker, worker, wqe->node,
+				 IO_WQ_CLONE_FLAGS, USER_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index c4f217613f56..d275f01c0828 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7475,12 +7475,8 @@ static int io_sq_thread(void *data)
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
-	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
-	set_task_comm(current, buf);
-
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
@@ -8709,6 +8705,8 @@ static __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		unsigned long flags = CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
+					CLONE_THREAD | CLONE_IO;
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -8754,7 +8752,8 @@ static __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = user_worker_create(io_sq_thread, sqd, NUMA_NO_NODE, flags,
+					 USER_WORKER_IO);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
@@ -8762,7 +8761,7 @@ static __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->thread = tsk;
 		ret = io_uring_alloc_task_context(tsk, ctx);
-		wake_up_new_task(tsk);
+		user_worker_start(tsk, "iou-sqp-%d", sqd->task_pid);
 		if (ret)
 			goto err;
 	} else if (p->flags & IORING_SETUP_SQ_AFF) {
-- 
2.25.1

