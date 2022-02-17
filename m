Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074714B97FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiBQFFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:05:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiBQFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:05:08 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE0D2A5237
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:04:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFS9dF1CBYiRDm6dWHAdsRZhExreH7DKjLIP7qEsuL0vJMfmcDBxeYopPWaLFufvVazlNP1fXXh6YY8tEchJLq/d2QxDEJAcxj/YSwlmw1/KC1sgCN4Ro8SvsyYiNZ0DeOu+SfnSbyncE6oj5D7xwIAA8WocbjEIFsI2Z1ckieAnDhFuwQDe72cK1F5V1ul6x2xcUUSLW6dm6YR93avw/LYzq2cQOHLV8D6ttqbdtwUEqFuD44dA6qqYoPmJwnjdme77SaMltRs4T3Tf0CpB/EOiXza1q35mgfth4+hyGTbYADXk9Os6Y+sOFb9cMF+sXD8WRkR64XEtaAF6mKYLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0yDdq5QdnyI7yYdO63gSKHHf1ItRxLoUaKhEY6pATw=;
 b=WyaCo9W9qazRXlUuHkmEQjlhW5UZTe4SKS3QZqe/VVRzr7mWIjf33sJs+6SQDfZLqwp0QKECYOXN3lz6Ivp9Eu/CttztFHzubNPuyCwVVVUmBMO4wGtFaPjs6AV7V8PJD5VzcfJkRTLjIwS4nnJqvfaokE5gNZWTva5zxNvKHBrjHIV5rWKUohHm0YbsUX6ZvjKurDmZ+v8xOGuy0KcBTk8O7mG8y92TEQh8REm4S7j5tR4N9UmJZG3Zo8IlHg821pEh5aacuDtyEfoU4lWZlBFNm34Jw2tEMIfOf6+rFLFz6+HRAYyPsstAH4NXWFzFONXocfBVMQHnha5f98Xx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0yDdq5QdnyI7yYdO63gSKHHf1ItRxLoUaKhEY6pATw=;
 b=fZWAGdsXPUBhnqIJUKq07NEiwLsxBx4ddnWDK04hOe+Oi9uzbohDH+2ivp4fI3fCoUh71zbfKfbCKzBndcM8hzPNlfsuZhXAjGfaAwXc+PfSEGouV1DKO8QvhbKRwB+1ql/n7KpySIff/0A7iml4cVvIBQTn8/uGUSd99on0TeQ=
Received: from CO2PR04CA0144.namprd04.prod.outlook.com (2603:10b6:104::22) by
 BN8PR12MB3057.namprd12.prod.outlook.com (2603:10b6:408:64::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Thu, 17 Feb 2022 05:04:50 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::e6) by CO2PR04CA0144.outlook.office365.com
 (2603:10b6:104::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Thu, 17 Feb 2022 05:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 05:04:49 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 23:04:44 -0600
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v3] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group
Date:   Thu, 17 Feb 2022 10:32:20 +0530
Message-ID: <20220217050220.27799-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d6a8954-9e1d-4a93-85dd-08d9f1d30670
X-MS-TrafficTypeDiagnostic: BN8PR12MB3057:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB305786C5C427C4CC099BB12798369@BN8PR12MB3057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iImtpN6IdpvAETAF03WJ7FSH1Cas2c4YzQqu7G7wkApaaWxFGseJGGUGlgE555kair1RGRUxspTyDjaH/X9iGJPK4nLLe6glkodD69qkonRbst1sOk3C6sCz1gVkl0F213U13VKUP8lavm6M+BVjjiaD5E8SEWT00jwY2GbY0etpVg4LGFVqS5fawZ7/wy/7yeYCfJ3fy6wkgQpU9g6QlhPyWd0BDiAZ5iTbnjpBZOVbV40TUONH6tseGGYQiNxaGfJ/QYIiTH0ELxfVBiIFWXcGkge5zZLed6199Uk75C05WdFvJG1XxAnQU7AxaJN0b6OdKrTVFezPtkfQjAxl3z2o7e+G7XFEDSoJ+sAJUMMbsK4TGXWWfBy3NCPTIgwh11JScHxC1iyLUPmWf4ZDhFkUTMJqTSbm+DXxem0l5WhRaNgZD/I4rYfI7k1ggmHrNMYywpgPMxed0WrepzwO2FzDaosBUXdWQsJns8XEB57IxX8zc+o6kHGjBiiS//vLVWr5OSE7wnWq0IzKCVxlA2B5ybfDzIgUUSSPtfvwcPgy28KMSHPhoV4J72ZsSqEJXoeZu2LObm5bPMIf0ejEKykSvz6nDTSDkuYfGScesmxbsGXqUmyk/BhuSwDudMNWQcop5dWbuTlVpkm9/OuksLug6jgYy36Ofj8EDvq/trm0ShnVgJChFxN1i8QaWa4z+Tird8k/FTDbC9wNww7G7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(8936002)(82310400004)(54906003)(426003)(6916009)(26005)(1076003)(316002)(47076005)(336012)(356005)(8676002)(186003)(70586007)(81166007)(2616005)(83380400001)(86362001)(4326008)(2906002)(7696005)(16526019)(5660300002)(36756003)(508600001)(6666004)(36860700001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:04:49.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6a8954-9e1d-4a93-85dd-08d9f1d30670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AMD Zen like systems which contains multiple LLCs per socket,
users want to spread bandwidth hungry applications across multiple
LLCs. Stream is one such representative workload where the best
performance is obtained by limiting one stream thread per LLC. To
ensure this, users are known to pin the tasks to a specify a subset of
the CPUs consisting of one CPU per LLC while running such bandwidth
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
Commit: e496132ebedd (sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs)
it is now equal to number of LLCs in the NUMA domain, for processors
with multiple LLCs (in this case threshold = 8).

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
Changelog v2-->v3:
 -  More detailed commit log highlighting the problem.
 -  Include numbers for dual socket Intel Skylake machine.
Changelog v1-->v2:
 -  Rebase changes on top of v6 of Mel's
    "Adjust NUMA imbalance for multiple LLCs" patchset.
 -  Reuse select_idle_mask ptr to store result of cpumask_and
    based on Mel's suggestion.
---
 kernel/sched/core.c | 3 +++
 kernel/sched/fair.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d863d7f6ad7..9a92ac42bb24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9294,6 +9294,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, find_idlest_group_mask);
 
 void __init sched_init(void)
 {
@@ -9344,6 +9345,8 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(find_idlest_group_mask, i) = (cpumask_var_t)kzalloc_node(
+			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index babf3b65db38..ffced741b244 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5751,6 +5751,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+DEFINE_PER_CPU(cpumask_var_t, find_idlest_group_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -9022,6 +9023,7 @@ static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
 static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(find_idlest_group_mask);
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
 	struct sg_lb_stats *sgs;
@@ -9130,6 +9132,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_has_spare:
 		if (sd->flags & SD_NUMA) {
+			int imb;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9150,7 +9153,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * allowed. If there is a real need of migration,
 			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
+			cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+			imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
 				return NULL;
 		}
 
-- 
2.25.1

