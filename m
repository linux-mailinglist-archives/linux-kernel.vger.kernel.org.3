Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57434BF5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiBVKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiBVKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:22:38 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5A380200
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwPY6cxmODz25wcOG386F6N0d/Vco+K60ba18/hMy+vxVn2TFZtjohL1dfb29Y/4y0P2G2EcjHbTslzHQyz5XgZAtfdcAhkdEvgbtXFTwqw/YdbkU1TJ6YGQIwSqZYPTdIXYH1xgn4cybZtmWZ2KcF3ARZxM2cu6HcMz06+L2oA81z4oL0k+tQ5tuDIIB6MKSMoV3j7BZGn9MUnJv8koy7H6h6oXrFfEXfVtEu6AIKBDgo8Caqhg7cBfU2wXO37dNR6daBTo8mLgX//CP1nRq8vokcmE4PLq2PeSDB65ipMqZDXmzniKPYVaLaEuk9hvGO9iFBUVPiHzQTi13rJhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv7g3cIFgxVgbZQaaxi6KWXjUelLTO/Hr1NO4mWfRg0=;
 b=lDb9K04HmNBGR3tQn5d3SYEcTrfsIZpNwP0ih2WNTFdd4Jb/LCwkUlZ4nX7MNW6xy77S3Ef6VqyXiJJ8nuMidOBMOovlEqpR9bbcWSy3VHN4AtrURPQwpRJ3CgL6v0nvgIjeGH1ApSbH/h+IEnRlOEyMycoY13h24681DQzp7xFF0EoT5lquYjuCjLxEcTwccveI4nRB+ew3rKqR9o1ReH/n9aWWVcaYAlv1CNwj4pKpeish+DBCZjPg8yGGdhz9t12QesmG1kAkoflFbIJhyj9jWX52O6dmJ1R0FyKEqQrAPJnR6MlTtibDyxMJUvNTa3k0Khad6wcLGfKdj+rHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv7g3cIFgxVgbZQaaxi6KWXjUelLTO/Hr1NO4mWfRg0=;
 b=kB06XpmyuE+3nzJ8fKi0FIoqysidvpmZdlqTVE4Y+cN5bOnz5XduW7Kq4ZqCv/n75sjaApDxmcuHljUSYLV2m6u/x3ZoVUlVXas/8zlOYRD4E6vonZkxVwmpaxl5Zuz+HnYns/tVA2teHPcso61OuYMb8TW1ZBXhDNFHo2dW9fw=
Received: from BN6PR22CA0025.namprd22.prod.outlook.com (2603:10b6:404:37::11)
 by BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 10:22:07 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::22) by BN6PR22CA0025.outlook.office365.com
 (2603:10b6:404:37::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 22 Feb 2022 10:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 10:22:06 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 04:21:53 -0600
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v5] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group
Date:   Tue, 22 Feb 2022 15:51:33 +0530
Message-ID: <20220222102133.2956-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 675fe542-0978-46fd-8bd4-08d9f5ed2d86
X-MS-TrafficTypeDiagnostic: BN8PR12MB3633:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB36334C9672119769DE72DBE5983B9@BN8PR12MB3633.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ly8coSIVeWlxEGxIaTJAIq0A26ailNKT30S2ioNWcQ5ozLUroMalRb+NpVU7PoWSxsUHJMM9ZkR+68UStiwrppMoZfgEzibEXd7t12WbWabwsKWvWesRQzUTVd4DG+M/S+0ZWPaYr2r05tF38gpsKLXgXf5jiXiAEr1mWA7rNPSEuEePGx5tfywF098EXQhEKXWetZha++/VXq3yCcHLj9W/DMKI2Q0k0GUv56z0zOowXsyNzkcow225AXBB7VUoTJqCx5/SGcDzHbsODlkZYxK+VIdOSF+Qp5GHFFUk4cEUwW9j19bbdGpGDghEH7XSDRuSnc89/MR4qswNnhFKvW1EdOEB9e5PPdd8F1SQ87NQKZKPunGbKGm3t2uqf2WiCT2dckJ2fswPFX6lotc6aRSLxakmXU3o0EGFAi0rC9y5R6vl2EN48xcGJmZBWhlMz+ytAw5StxTHAtdKtgzhii/NuZqpAeIJs1RaWcy0fc2fKyQi8CRLiCNONw3Lkt/3Lw/fPKeCYAVb3hXSmwwNa4Hm4j9WG9G7HjTcs18yA2BUohf7ghCHOM9Xh5BVr9LynLY8IykMXXmGrwlBRcuIQ+o0mg0zpSSyscRZ4okj2UVzzopAwgJf1eHDDbv9GeszJn6S7Y/3F4IvqY5QkwZcmIws9QVANlie2/kNiOm1BoGWRTFj8AZpJDwg7+kAou7j/pKKcna0xzsr/VpIi7XWJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(6916009)(54906003)(6666004)(316002)(8936002)(40460700003)(36756003)(508600001)(7696005)(2616005)(70586007)(336012)(4326008)(7416002)(86362001)(82310400004)(426003)(186003)(26005)(16526019)(1076003)(36860700001)(81166007)(8676002)(5660300002)(356005)(70206006)(83380400001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 10:22:06.8701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675fe542-0978-46fd-8bd4-08d9f5ed2d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

stream-5045    [032] d..2.   167.914699: sched_wakeup_new: comm=stream pid=5047 prio=120 target_cpu=048
stream-5045    [032] d..2.   167.914746: sched_wakeup_new: comm=stream pid=5048 prio=120 target_cpu=000
stream-5045    [032] d..2.   167.914846: sched_wakeup_new: comm=stream pid=5049 prio=120 target_cpu=016
stream-5045    [032] d..2.   167.914891: sched_wakeup_new: comm=stream pid=5050 prio=120 target_cpu=032
stream-5045    [032] d..2.   167.914928: sched_wakeup_new: comm=stream pid=5051 prio=120 target_cpu=032
stream-5045    [032] d..2.   167.914976: sched_wakeup_new: comm=stream pid=5052 prio=120 target_cpu=032
stream-5045    [032] d..2.   167.915011: sched_wakeup_new: comm=stream pid=5053 prio=120 target_cpu=032

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

stream-4733    [032] d..2.   116.017980: sched_wakeup_new: comm=stream pid=4735 prio=120 target_cpu=048
stream-4733    [032] d..2.   116.018032: sched_wakeup_new: comm=stream pid=4736 prio=120 target_cpu=000
stream-4733    [032] d..2.   116.018127: sched_wakeup_new: comm=stream pid=4737 prio=120 target_cpu=064
stream-4733    [032] d..2.   116.018185: sched_wakeup_new: comm=stream pid=4738 prio=120 target_cpu=112
stream-4733    [032] d..2.   116.018235: sched_wakeup_new: comm=stream pid=4739 prio=120 target_cpu=096
stream-4733    [032] d..2.   116.018289: sched_wakeup_new: comm=stream pid=4740 prio=120 target_cpu=016
stream-4733    [032] d..2.   116.018334: sched_wakeup_new: comm=stream pid=4741 prio=120 target_cpu=080

We see that threads are using all of the allowed CPUs and there is
no pileup.

No output is generated for tracepoint sched_migrate_task with this
patch due to a perfect initial placement which removes the need
for balancing later on - both across NUMA boundaries and within
NUMA boundaries for stream.

Following are the results from running 8 Stream threads with and
without pinning on a dual socket Zen3 Machine (2 x 64C/128T):

Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8

	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:    97699.28 (0.00 pct)     95933.60  (-1.80 pct)    156578.91 (60.26 pct)
Scale:   107754.15 (0.00 pct)     91869.88 (-14.74 pct)    149783.25 (39.00 pct)
  Add:   126383.29 (0.00 pct)    105730.86 (-16.34 pct)    186493.09 (47.56 pct)
Triad:   124896.78 (0.00 pct)    106394.38 (-14.81 pct)    184733.48 (47.90 pct)

Pinning currently hurts the performance compared to unbound case on
tip/sched/core. With the addition of this patch, we are able to
outperform tip/sched/core by a good margin with pinning.

Following are the results from running 16 Stream threads with and
without pinning on a dual socket Skylake Machine (2 x 24C/48T):

Pinning is done using: numactl -C 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ./stream16

	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:   126620.67 (0.00 pct)     141062.10 (11.40 pct)    147615.44 (16.58 pct)
Scale:   91313.51 (0.00 pct)      112879.61 (23.61 pct)    122591.28 (34.25 pct)
  Add:   102035.43 (0.00 pct)     125889.98 (23.37 pct)    138179.01 (35.42 pct)
Triad:   102281.91 (0.00 pct)     123743.48 (20.98 pct)    138940.41 (35.84 pct)

In case of Skylake machine, with single LLC per socket, we see good
improvement brought about by pinning which is further benefited by
this patch.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v4-->v5:
 -  Only perform cpumask operations if nr_cpus_allowed
    is not equal to num_online_cpus based on Mel's
    suggestion.
Changelog v3-->v4:
 -  Update the patch diff to use Mel's suggestion on v1
    which was left out in v3.
Changelog v2-->v3:
 -  More detailed commit log highlighting the problem.
 -  Include numbers for dual socket Intel Skylake machine.
Changelog v1-->v2:
 -  Rebase changes on top of v6 of Mel's
    "Adjust NUMA imbalance for multiple LLCs" patchset.
 -  Reuse select_idle_mask ptr to store result of cpumask_and
    based on Mel's suggestion.
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4bfffe8c2c..7dd7cfe11383 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9130,6 +9130,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_has_spare:
 		if (sd->flags & SD_NUMA) {
+			struct cpumask *cpus;
+			int imb;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9147,10 +9149,18 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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
+				cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			}
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
 				return NULL;
 		}
 
-- 
2.25.1

