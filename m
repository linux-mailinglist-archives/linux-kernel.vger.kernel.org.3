Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9704F7DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiDGLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbiDGLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:15:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6213B5468E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7jstDd/B6Njov5ZpHgDLZBlff65d9SQRRMEsOocqhXvh91FPg8ETNd7mHQEkoGO9ozk8mcPNd6IQYteNEiEoSSLdG6yTplA0qFf4TVGDB803FpbooUjUGh/rPRLmKS1vcZV++bKbaDoDs3uF4rKH0gCXbUJFsSB2hYIyQdV3g1o57agkPJ3t+icpH9d8vxMVzEy7tAW+UCWZOEEb2qnW/meInDPON1Rh/O45i4JeJHK7kOYM45xfErlNCuyzn+vleP4ALjRncG8DJzhfZn2ppwsltb8u1jhDWXtEW0xMQXyHbCwYdBxSUtMmocuxvpWVUGLZstU+R6J/lsSz443Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1F86HW0giitiNxhFDoA0daVDS7z4QRA0+/CN9iHP6s=;
 b=i4n3SPriTU4nYcJkXS9OWtskb2TXc6+i7kqLIFxbk7nU+R5QJXIR1oEwrK/tKWz6ffTk3GoxmjCJDUuAEFOfs9avxl5RfbqPiVDtKFSv2ovJNutqXnaiEJaJk+ba7jcb9gUqQ2kOecc6UY3DOk6rPF/S59ByqA7HwKDFIFgknWVIBcuxmb3J3B4BYnE4ljlJrB3X6aPIeCnMlc54fKU+OT4UvWHitXJdWCSk5PKu/+wB6UWBJXd8hELLPKQya3DqDhL9CGBOr8EM6o83zEuDwZhyAoDsxUT/bJmo2thpb0Ktuy926bMrAImdpm38/t9LCkPqW9cQfqKbNOLNWJtUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1F86HW0giitiNxhFDoA0daVDS7z4QRA0+/CN9iHP6s=;
 b=oq1vD9GRNmGIxApxWVKTG90w3vhB2ZEKiHwsYfxwP9IPkKtmpmtsqZ6SRb50Xfds1vXyRd286M1XLPkkhf4aD1SyymfDK9F8oM/SyZE/ELSt5NohFVgLj1Muicd6vristPXHs6Le9tVl6Jr2HTNn2VdjrGuTsQ4vRBYPCJ49zjg=
Received: from DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11)
 by DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 11:13:14 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::72) by DM6PR02CA0109.outlook.office365.com
 (2603:10b6:5:1b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Thu, 7 Apr 2022 11:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 11:13:13 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 06:13:09 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group
Date:   Thu, 7 Apr 2022 16:42:22 +0530
Message-ID: <20220407111222.22649-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 682cb23c-41ac-4317-ba5f-08da18879bc6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1257:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12574030585D6DF4DE4EBB9F98E69@DM5PR12MB1257.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAGMOJBO1qd8vH8pHLLLGZjBnaw7OPXuaPSh8Aa6L82uK1helDvQNlphOus+bfOZxYeL0bMzgM4M3EQil8+D2ZAsDtTSc04tQiMoAyvx5r3rrRbqzzbImzSwZ1IYf0AqetUJXRKFZeJxJLqRU0MI3qSID7hXFjvfmIfptqsjIVvoiwZUe+JCoLUfTHzFKqbpXmDjAlOVseXKr2SWd8dB2+T65RGrg9UymkxjB0x1a2oMS2Eb6SrCnB1J9tGLhcahNAgCZAlI6JTEn/ywVcVYB9saFKnd1YSvjpb6W6dVO+egN3AIqgMAFHIXpM4zZF8FeVmfR/rZxdlp08EZcoAsgBKByG2LB5IAvpZKj4wIQjxhwuRNdQyTpSIaInYyotk8FftmJ3Krq98lw24C7DP8MzqFcT7iu/+5wW8G1/cnOaPB9UIH/cFAAOT5b/W1l67O+CWBrVVZWYi5yaR13Lycu9eHdaJuTl10OZXcSAnFfrNw5+RPzJbgBcNlo/Ql/iSNk05IGqo7ZfWWfOmRGddpgi3E9ZyrYGurYjbc2OvWlPlZOsX9vvssr8gr9T5VuudQmEVKGhPlncQA+nmXNfk9A9hzW7PEOP56iD4g8wIVEI0cs1dcGRFcLGGfjtYi8Juymt44n+qXqC3hVmWWpex/QpZ+DIMk9gJ7dmcpC/hFvSFtscrEp1k6RUpJEHRPeoFYRYlP6JpHNr62mEhNhLQgvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(8676002)(83380400001)(40460700003)(70586007)(70206006)(82310400005)(4326008)(54906003)(86362001)(6666004)(16526019)(26005)(426003)(316002)(336012)(508600001)(186003)(6916009)(36860700001)(8936002)(2906002)(2616005)(356005)(7696005)(36756003)(47076005)(1076003)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 11:13:13.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682cb23c-41ac-4317-ba5f-08da18879bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of systems containing multiple LLCs per socket, like
AMD Zen systems, users want to spread bandwidth hungry applications
across multiple LLCs. Stream is one such representative workload where
the best performance is obtained by limiting one stream thread per LLC.
To ensure this, users are known to pin the tasks to a specify a subset
of the CPUs consisting of one CPU per LLC while running such bandwidth
hungry tasks.

Suppose we kickstart a multi-threaded task like stream with 8 threads
using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
server where each socket contains 128 CPUs
(0-63,128-191 in one socket, 64-127,192-255 in another socket)

Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8

Here each CPU in the list is from a different LLC and 4 of those LLCs
are on one socket, while the other 4 are on another socket.

Ideally we would prefer that each stream thread runs on a different
CPU from the allowed list of CPUs. However, the current heuristics in
find_idlest_group() do not allow this during the initial placement.

Suppose the first socket (0-63,128-191) is our local group from which
we are kickstarting the stream tasks. The first four stream threads
will be placed in this socket. When it comes to placing the 5th
thread, all the allowed CPUs are from the local group (0,16,32,48)
would have been taken.

However, the current scheduler code simply checks if the number of
tasks in the local group is fewer than the allowed numa-imbalance
threshold. This threshold was previously 25% of the NUMA domain span
(in this case threshold = 32) but after the v6 of Mel's patchset
"Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
in the NUMA domain, for processors with multiple LLCs.
(in this case threshold = 8).

For this example, the number of tasks will always be within threshold
and thus all the 8 stream threads will be woken up on the first socket
thereby resulting in sub-optimal performance.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in the current tip/sched/core on the Zen3 machine:

stream-5313    [016] d..2.   627.005036: sched_wakeup_new: comm=stream pid=5315 prio=120 target_cpu=032
stream-5313    [016] d..2.   627.005086: sched_wakeup_new: comm=stream pid=5316 prio=120 target_cpu=048
stream-5313    [016] d..2.   627.005141: sched_wakeup_new: comm=stream pid=5317 prio=120 target_cpu=000
stream-5313    [016] d..2.   627.005183: sched_wakeup_new: comm=stream pid=5318 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005218: sched_wakeup_new: comm=stream pid=5319 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005256: sched_wakeup_new: comm=stream pid=5320 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005295: sched_wakeup_new: comm=stream pid=5321 prio=120 target_cpu=016

Once the first four threads are distributed among the allowed CPUs of
socket one, the rest of the treads start piling on these same CPUs
when clearly there are CPUs on the second socket that can be used.

Following the initial pile up on a small number of CPUs, though the
load-balancer eventually kicks in, it takes a while to get to {4}{4}
and even {4}{4} isn't stable as we observe a bunch of ping ponging
between {4}{4} to {5}{3} and back before a stable state is reached
much later (1 Stream thread per allowed CPU) and no more migration is
required.

We can detect this piling and avoid it by checking if the number of
allowed CPUs in the local group are fewer than the number of tasks
running in the local group and use this information to spread the
5th task out into the next socket (after all, the goal in this
slowpath is to find the idlest group and the idlest CPU during the
initial placement!).

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks after adding this fix on the Zen3 machine:

stream-4485    [016] d..2.   230.784046: sched_wakeup_new: comm=stream pid=4487 prio=120 target_cpu=032
stream-4485    [016] d..2.   230.784123: sched_wakeup_new: comm=stream pid=4488 prio=120 target_cpu=048
stream-4485    [016] d..2.   230.784167: sched_wakeup_new: comm=stream pid=4489 prio=120 target_cpu=000
stream-4485    [016] d..2.   230.784222: sched_wakeup_new: comm=stream pid=4490 prio=120 target_cpu=112
stream-4485    [016] d..2.   230.784271: sched_wakeup_new: comm=stream pid=4491 prio=120 target_cpu=096
stream-4485    [016] d..2.   230.784322: sched_wakeup_new: comm=stream pid=4492 prio=120 target_cpu=080
stream-4485    [016] d..2.   230.784368: sched_wakeup_new: comm=stream pid=4493 prio=120 target_cpu=064

We see that threads are using all of the allowed CPUs and there is
no pileup.

No output is generated for tracepoint sched_migrate_task with this
patch due to a perfect initial placement which removes the need
for balancing later on - both across NUMA boundaries and within
NUMA boundaries for stream.

Following are the results from running 8 Stream threads with and
without pinning on a dual socket Zen3 Machine (2 x 64C/128T):

During the testing of this patch, the tip sched/core was at
commit: 089c02ae2771 "ftrace: Use preemption model accessors for trace
header printout"

Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8

	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                + pinning              + this-patch
								       + pinning

 Copy:   109364.74 (0.00 pct)     94220.50 (-13.84 pct)    158301.28 (44.74 pct)
Scale:   109670.26 (0.00 pct)     90210.59 (-17.74 pct)    149525.64 (36.34 pct)
  Add:   129029.01 (0.00 pct)    101906.00 (-21.02 pct)    186658.17 (44.66 pct)
Triad:   127260.05 (0.00 pct)    106051.36 (-16.66 pct)    184327.30 (44.84 pct)

Pinning currently hurts the performance compared to unbound case on
tip/sched/core. With the addition of this patch, we are able to
outperform tip/sched/core by a good margin with pinning.

Following are the results from running 16 Stream threads with and
without pinning on a dual socket IceLake Machine (2 x 32C/64T):

NUMA Topology of Intel Skylake machine:
Node 1: 0,2,4,6 ... 126 (Even numbers)
Node 2: 1,3,5,7 ... 127 (Odd numbers)

Pinning is done using: numactl -C 0-15 ./stream16

	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:    85815.31 (0.00 pct)     149819.21 (74.58 pct)    156807.48 (82.72 pct)
Scale:    64795.60 (0.00 pct)      97595.07 (50.61 pct)     99871.96 (54.13 pct)
  Add:    71340.68 (0.00 pct)     111549.10 (56.36 pct)    114598.33 (60.63 pct)
Triad:    68890.97 (0.00 pct)     111635.16 (62.04 pct)    114589.24 (66.33 pct)

In case of Icelake machine, with single LLC per socket, pinning across
the two sockets reduces cache contention, thus showing great
improvement in pinned case which is further benefited by this patch.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v6-->v7:
 -  Rebased the changes on the latest sched-tip.
 -  Updated commit log with numbers comparing patch with the latest
    sched-tip on AMD Zen3 and Intel Icelake based server offerings.
 -  Collected tags from v6.
Changelog v5-->v6:
 -  Move the cpumask variable declaration to the block it is used in.
 -  Collect tags from v5.
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..520593bf0de6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9215,6 +9215,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_has_spare:
 		if (sd->flags & SD_NUMA) {
+			int imb;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9232,10 +9233,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
 			 * would remain below threshold where an imbalance is
-			 * allowed. If there is a real need of migration,
-			 * periodic load balance will take care of it.
+			 * allowed while accounting for the possibility the
+			 * task is pinned to a subset of CPUs. If there is a
+			 * real need of migration, periodic load balance will
+			 * take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
+			imb = sd->imb_numa_nr;
+			if (p->nr_cpus_allowed != num_online_cpus()) {
+				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+
+				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			}
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
 				return NULL;
 		}
 
-- 
2.25.1

