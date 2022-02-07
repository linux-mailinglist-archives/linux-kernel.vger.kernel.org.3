Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C54AC4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbiBGQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384530AbiBGQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:00:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7793C0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:00:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkyYCnAhH+Ileiwx7szXf/V1zoPqdu1TPqYVz5Za4yj4XYbw/bxPCKOMMUGDaOLUOfYTOnk5OYQKN2c0v3oAZ973MAxthgXssMAXU6FHyqzqNx6Ro2GKZDMdJbaxN4fUtCEe5GaYx6f8pQ9wQSIAWsrsYdP0jGQKM1PJlT1mLWr5h77nVzU6xSCAWGA277PzKRh1uv82MsBwElQ9yklGWe40ZgDdZ9V9KZbH48mvBjGd44bbmj/R+iPTPL/dF3QLV2+kreCJeVE6HzVp9iMLicuw3w8+iWbkf445IFRr+ULuBdqIFJ3CXX6ho3A/Lg6EX+yEbcMb03uBTvVdiJuN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24nxa10g4gma+53eO2vWWN01muFAXWU5dLm6s0yzvI4=;
 b=mC/TP5HlaQqhRt+Al5uBAPN/J8KqN0GE0dbtWkxeAnxHsFIwuoEnngkn9QdkAy1ynyKCuyQu+YhqFRH7bWpNNzpTPMSm4nspJrgyETTPKlxCeW7vT+LGliJzXzfWXnZoI1mHHBHDHrLz5dUp0QGg9LKf64IpDL32GUqv1ToyTVNyKWPpbsq2EGVPo74pHA8Zh2N8WgjHXyDr3jWJbR6UbRFFO3acuGHcEwAfw8COyDIQAtl5iHLAKZUFPJcAo2zrjAZh7L7ZvXBMVILM1pzyfaZQBm588am/LlmZf1/DuQJRai79Ps6Qm2rABvCcvmdNh/X8MjMln3Fwc5lIoGUnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24nxa10g4gma+53eO2vWWN01muFAXWU5dLm6s0yzvI4=;
 b=VsG5ohk0KzZLS76S4gHGyN7gZ6FogWs6gXuHvtz32JR/CyBVqniU7ufl4qJiZbo+t3PYAQENqiCuiVKdwzMriUcRba5INnA4XZ/Z2G+YRaG5AegWJoKnGwJo1ichzx3rCYQEW0tVXpo/1NsKZbLAyLHY5vZmx/nfPNL37EBlqss=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Mon, 7 Feb 2022 16:00:46 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::8) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 16:00:46 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 10:00:39 -0600
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group
Date:   Mon, 7 Feb 2022 21:29:21 +0530
Message-ID: <20220207155921.21321-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7fa0e85-ddd1-4481-875e-08d9ea5300d5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45228D85A7D00C23F5A3CF4A982C9@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPEamAFeVKTBiO2v6D6Uq/sdxrTXQjbJSuvKQYDnSs5vvkW4ygoie0/DQbhgPKiWbYLcq9hRAtX/49fhASF4QwaKx1Q/xuq99iQypgnOj3PRi0tYBOVNTRHhhWUBkL2le8BLzMquOWphiQzePLB89fbkKUc2CkT3/lpKVQGtmQdxck9mYN7yCvWH9qjRjM3kapj8QiqWw2Iz6McMCF6kN2O36D5caSLFWqdGggg7A9ytdKBhrz8qWAAbxipKCjyDj5EJpwzE7YBgHIHOpXabL8QHXUWJRvIEKe/di6EgsFQbVwaLLCiDGU2DEcttuiycDZGJmC9NydRMRWWDexHIINiTHxd5QlYW1wGZY9EUF65AwNrFFW6gDoqz/yRYHApBQ/I6GolFhsFcD4ZssFwoqEadRJ5fIGk9dIhd7YtBFmyRAWAeRQmQsUcgKy8Ta6dfNkWL9yATGMQNlY5vqDDdiEld1Lp2F0ISN3YseBvbGL4A9YafVy24DAbgUOdN5pO7u1H9Z3FdYkj0xWafjxjLpLPUn0S/ifROlG24/JMh0zP6egA1TRTzeWaHmr5n8+CKh4gcq+7r4LOyBSh83JSQ7S9L1SX95ZlvFkDX6Y1LlnR874mWbk8OwhxCy+l4AOn46x5VZHpDzAGBgQZTZn5fGMVtbo3Gak0D814GgbE5Eph4dpwZaJnC/23gRr6B+FPFBuGawlvr1xzqwVUjqtF0TlRQ6CRUjJGqRNduq+LadTz11eWI9uvAXIg5QHmYbIIbwJqrGM4d7w3QvgQ1kJBKFgbMMqE8L/OoWmf4FhCbt08=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(6916009)(82310400004)(8936002)(36860700001)(8676002)(70206006)(316002)(86362001)(70586007)(54906003)(2906002)(47076005)(7696005)(2616005)(508600001)(83380400001)(6666004)(36756003)(81166007)(26005)(356005)(16526019)(40460700003)(186003)(1076003)(7416002)(5660300002)(426003)(966005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:00:46.5721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fa0e85-ddd1-4481-875e-08d9ea5300d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither the sched/tip nor Mel's v5 patchset [1] provides an optimal
new-task wakeup strategy when the tasks are affined to a subset of cpus
which can result in piling of tasks on the same set of CPU in a NUMA
group despite there being other cpus in a different NUMA group where the
task could have run in. A good placement makes a difference especially
in case of short lived task where the delay in load balancer kicking in
can cause degradation in perfromance.

Benchmark is performed using pinned run of STREAM, parallelized with OMP,
on a Zen3 machine. STREAM is configured to run 8 threads with CPU affinity
set to cpus 0,16,32,48,64,80,96,112.
This ensures an even distribution of allowed cpus across the NUMA groups
in NPS1, NPS2 and NPS4 modes.
The script running the stream itself is pinned to cpus 8-15 to maintain
consistency across runs and to make sure the script runs on an LLC
not part of stream cpulist so as to not interfere with the benchmark.

Changes are based on top of v5 of Mel's patchset
"Adjust NUMA imbalance for multiple LLCs" [1]

Following are the results:

	 5.17.0-rc1              5.17.0-rc1              5.17.0-rc1
	 tip sched/core          tip sched/core          tip sched/core
				 + mel-v5                + mel-v5
							 + this-fix

NPS Mode - NPS1

 Copy:	 92133.36 (0.00 pct)	 117595.57 (27.63 pct)	 150655.69 (63.51 pct)
Scale:	 90847.82 (0.00 pct)	 114525.59 (26.06 pct)	 148939.47 (63.94 pct)
  Add:	 103585.04 (0.00 pct)	 137548.40 (32.78 pct)	 186323.75 (79.87 pct)
Triad:	 100060.42 (0.00 pct)	 133695.34 (33.61 pct)	 184203.97 (84.09 pct)

NPS Mode - NPS 2

 Copy:	 52969.12 (0.00 pct)	 76969.90 (45.31 pct)	 165892.91 (213.18 pct)
Scale:	 49209.91 (0.00 pct)	 69200.05 (40.62 pct)	 152210.69 (209.30 pct)
  Add:	 60106.69 (0.00 pct)	 92049.47 (53.14 pct)	 195135.02 (224.64 pct)
Triad:	 60052.66 (0.00 pct)	 88323.03 (47.07 pct)	 193672.59 (222.50 pct)

NPS Mode - NPS4

 Copy:	 44122.00 (0.00 pct)	 157154.70 (256.18 pct)	 169755.52 (284.74 pct)
Scale:	 41730.68 (0.00 pct)	 172303.88 (312.89 pct)	 170247.06 (307.96 pct)
  Add:	 51666.98 (0.00 pct)	 214293.71 (314.75 pct)	 213560.61 (313.34 pct)
Triad:	 50489.87 (0.00 pct)	 212242.49 (320.36 pct)	 210844.58 (317.59 pct)

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in mel-v5 in NPS2 mode:

stream-4578    [016] d..2.    81.970702: sched_wakeup_new: comm=stream pid=4580 prio=120 target_cpu=000
stream-4578    [016] d..2.    81.970760: sched_wakeup_new: comm=stream pid=4581 prio=120 target_cpu=016
stream-4578    [016] d..2.    81.970823: sched_wakeup_new: comm=stream pid=4582 prio=120 target_cpu=048
stream-4578    [016] d..2.    81.970875: sched_wakeup_new: comm=stream pid=4583 prio=120 target_cpu=032
stream-4578    [016] d..2.    81.970920: sched_wakeup_new: comm=stream pid=4584 prio=120 target_cpu=016
stream-4578    [016] d..2.    81.970961: sched_wakeup_new: comm=stream pid=4585 prio=120 target_cpu=016
stream-4578    [016] d..2.    81.971039: sched_wakeup_new: comm=stream pid=4586 prio=120 target_cpu=112

Three stream threads pile up on cpu 16 initially and in case of
short runs, where the load balancer doesn't have enough time to kick in
to migrate task, performance might suffer. This pattern is observed
consistently where tasks pile on one cpu of the group where the
runner script is pinned to.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks with this fix in NPS2 mode:

stream-4639    [032] d..2.   102.903581: sched_wakeup_new: comm=stream pid=4641 prio=120 target_cpu=016
stream-4639    [032] d..2.   102.903698: sched_wakeup_new: comm=stream pid=4642 prio=120 target_cpu=048
stream-4639    [032] d..2.   102.903762: sched_wakeup_new: comm=stream pid=4643 prio=120 target_cpu=080
stream-4639    [032] d..2.   102.903823: sched_wakeup_new: comm=stream pid=4644 prio=120 target_cpu=112
stream-4639    [032] d..2.   102.903879: sched_wakeup_new: comm=stream pid=4645 prio=120 target_cpu=096
stream-4639    [032] d..2.   102.903938: sched_wakeup_new: comm=stream pid=4646 prio=120 target_cpu=000
stream-4639    [032] d..2.   102.903991: sched_wakeup_new: comm=stream pid=4647 prio=120 target_cpu=064

The tasks have been distributed evenly across all the allowed cpus
and no pile up can be seen.

Aggressive NUMA balancing is only done when needed. We select the
minimum of number of allowed cpus in sched group and the calculated
sd.imb_numa_nr as our imbalance threshold and the default behavior
of mel-v5 is only modified when the former is smaller than
the latter.

This can help is case of embarrassingly parallel programs with tight
cpus affinity set.

[1] https://lore.kernel.org/lkml/20220203144652.12540-1-mgorman@techsingularity.net/

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
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

