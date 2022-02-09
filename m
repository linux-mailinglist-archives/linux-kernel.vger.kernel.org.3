Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83664AEF07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiBIKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:12:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153FE049A5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAOVCYFtEyXnMccmZWGkH/KKntXeIGJ3EnoOLY3MfJ19+LMW37V95ts4nvbkEsQ5OvFVlvjDLjqv7a2v0G1rJ6jK5GdVO6KVoHd8DZ/Fyi8SphZOTnDjh2BvsQTAVYpiqff4Yl8+5u9vTMLEP519oAJ5PlBHowju/8o7EgbiY7Txpt58BKBByC5lkdT5FYVTmEKEls1FpB01GmNps8gCgsAaIrlaX29Erc+TQ0ZF9Bab7G+c2JGIxKXcOho11JtgFrzIHqZkRJfv4vZbOrJeoi0Xbkwpd43GV68Jiyn2Y6/J8zD/dW+ob3EqrQOGoBYElEVXS3e2OIzfrIa/9XrdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SawBbmLcqX59DO08kmVoxx8yclRRXi+dBXHq4BLdwKQ=;
 b=PUP/kX9G3U/1cFwrRVWJW1t/zyYFKgWyRBNyC5w2afAh9Oow0FhIqibH2IzbO00VZrBIl0yTyzfLXXWXGHZ1d9KJioDogpF9EbkuUEneqFmqLjjOeYG1QCLt/5HN3+2izeVH3nPJWA7MrRrtfpzY4lv0wVvz0+irI15rikGiG8DP1NDiCtOifzD/SHt0I8+tna9FZTEy1oC/Rb1rIfGARdyWzx0Tc/Bmdv0oewYZ1/umXgwMTInzeIE76px+Ot0nxebrNKMLHCtu/hoUxSZEt5Rfa8wx3u0xcbp2v7Yj/eeMRv5i1SaKBXhxYa0gMF86wO4y+RResdEP+ElcX4tyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SawBbmLcqX59DO08kmVoxx8yclRRXi+dBXHq4BLdwKQ=;
 b=AVe4stYBePLwMs97fZYBxGdmGQBdsp6JIfnMZOTdyggjqr0U6Z9aEZPjBlmGvW3ib1PXXSB0JL13NqlfrVLXuJm9n+LnwKeKRXTyXhqzJ6DBP/yacMxbty0mm9csPcG45vZLr+vARvUQihxnr/ROmK87FVh5XPeukTz0GNZiFMc=
Received: from BN6PR1401CA0009.namprd14.prod.outlook.com
 (2603:10b6:405:4b::19) by PH7PR12MB5688.namprd12.prod.outlook.com
 (2603:10b6:510:13c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 10:07:00 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::bb) by BN6PR1401CA0009.outlook.office365.com
 (2603:10b6:405:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 10:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 10:06:59 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 04:06:53 -0600
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group
Date:   Wed, 9 Feb 2022 15:35:34 +0530
Message-ID: <20220209100534.12813-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db1e145-9374-4690-4ce2-08d9ebb3e97b
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5688A396FAAEC242103893E0982E9@PH7PR12MB5688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/d3WFoYrxCzRfgtFuFT6LdTdyPSH/oJh1ME85g2H0Xs9OHZKxjj4Eqks72PS7qtASlfMG4Lf3eogG1RhHT73xZJCEEuMeovWIWoAKPXAHzBcSZ+BR12lm7dZlFGNXyssWNHxDLKiq94KxWXhAhdLg7P9LNAyj57Ozq/NB9CWH2ParSquFWFlipkuvnXWO1AdvkYseXR1kgkbZh8uvOCWhNV1tycq4bMijCHrw6KFsG75vPEg9K7t7Bzd7VYj2Lxcpw7MDT6HCZVdlzJt/YFmDDuwmK8f+KVgYHrbjCPOO3wjPRYD613iCHVwWY52fSlEg0EY4JXsLElvPaS9rHshVFwq6+HdVMdEqfqW01o+tuwaLMYXlvCHc94wZGYxeoxTz1DTAUKsfZA2cbMsg1W1tnhCjAI4oOZzSbBx9y76ZkMBXnX5jQAJWkmHmJXQ+6IqjB0M+N6ghweiKWeAKfazP7oYnEOvZ4+zvgpYxGDj59dvBhtX47Hmgw65gAeaICLLkJObPq1+Ny9NjWlzSXGBomCvdO7+N4NMG8wuCwukch4heKtGwglGw1/sTT6ONKhbRGDwSKkCKAOUVnyJCLxTfW4NLEXTz4DM1Fjdjwnn4XN5NwGRtgpDHz8TqfMGsJpdsCuBae6yXt+CJjiot+T4ZuGORLa1QGATN6D+m/Lx8d5LLXUKiil/G/pcmPSw0kiU4eyjK2qGDmJo32ZMfTOaqYs1oRjtTx+K/XLVzDzv9Vv95/pgVVxfgKEnIh1U3qIGWvj1mkdg7qM5kAZhVILNZL3XCd2dXGWoYK//+d/5aM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(8676002)(966005)(2616005)(36756003)(54906003)(40460700003)(6916009)(2906002)(7696005)(6666004)(508600001)(8936002)(316002)(86362001)(82310400004)(7416002)(426003)(4326008)(356005)(336012)(26005)(70586007)(70206006)(5660300002)(83380400001)(81166007)(186003)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:06:59.7856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db1e145-9374-4690-4ce2-08d9ebb3e97b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sched/tip allows a generous amount of NUMA imbalance when it
comes to task wakeup. In case of processes affined to a subset of cpus
in the NUMA group, the current behavior can lead to piling of processes
on allowed cpus of one NUMA group when there exists an opportunity to
run it on a cpu of different NUMA group.
Mel Gorman's NUMA balance across LLCs v6 patchset [1] improves the
behavior of task placement on systems with smaller LLCs. However, there
still exists an opportunity to aggressively balance in case of processes
affined to a subset of group cpus.
A good placement makes a difference especially in case of short lived
tasks where the delay in load balancer kicking in can cause degradation
in performance.

Benchmark is performed using pinned run of STREAM, parallelized with OMP,
on a Zen3 machine. STREAM is configured to run 8 threads with CPU affinity
set to cpus 0,16,32,48,64,80,96,112.
This ensures an even distribution of allowed cpus across the NUMA groups
in NPS1, NPS2 and NPS4 modes.
The script running the stream itself is pinned to cpus 8-15 to maintain
consistency across runs and to make sure the script runs on an LLC
not part of stream cpulist so as to not interfere with the benchmark.

Changes are based on top of v6 of Mel's patchset
"Adjust NUMA imbalance for multiple LLCs" [1]

Following are the results:

	 5.17.0-rc1              5.17.0-rc1              5.17.0-rc1
	 tip sched/core          tip sched/core          tip sched/core
				 + mel-v6                + mel-v6
							 + this-fix

NPS Mode - NPS1

 Copy:   93918.06 (0.00 pct)     109462.74 (16.55 pct)   159529.28 (69.86 pct)
Scale:   93587.15 (0.00 pct)     107532.66 (14.90 pct)   149857.47 (60.12 pct)
  Add:   109049.25 (0.00 pct)    125020.15 (14.64 pct)   187370.68 (71.82 pct)
Triad:   110837.20 (0.00 pct)    120235.47 (8.47 pct)    184970.30 (66.88 pct)

NPS Mode - NPS2

 Copy:   72897.93 (0.00 pct)     67735.80 (-7.08 pct)    158353.23 (117.22 pct)
Scale:   67053.02 (0.00 pct)     63938.28 (-4.64 pct)    151405.05 (125.79 pct)
  Add:   82369.06 (0.00 pct)     79950.10 (-2.93 pct)    195779.90 (137.68 pct)
Triad:   86169.70 (0.00 pct)     83096.03 (-3.56 pct)    192829.44 (123.77 pct)

NPS Mode - NPS4

 Copy:   47215.25 (0.00 pct)     76329.25 (61.66 pct)    166127.12 (251.85 pct)
Scale:   44749.85 (0.00 pct)     68847.86 (53.85 pct)    157443.02 (251.82 pct)
  Add:   56184.15 (0.00 pct)     92570.93 (64.76 pct)    199190.89 (254.53 pct)
Triad:   52530.37 (0.00 pct)     88348.62 (68.18 pct)    197430.72 (275.84 pct)


The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in mel-v6 in NPS2 mode:

stream-5261    [016] d..2.   262.189413: sched_wakeup_new: comm=stream pid=5263 prio=120 target_cpu=000
stream-5261    [016] d..2.   262.189459: sched_wakeup_new: comm=stream pid=5264 prio=120 target_cpu=016
stream-5261    [016] d..2.   262.189568: sched_wakeup_new: comm=stream pid=5265 prio=120 target_cpu=016
stream-5261    [016] d..2.   262.189621: sched_wakeup_new: comm=stream pid=5266 prio=120 target_cpu=048
stream-5261    [016] d..2.   262.189678: sched_wakeup_new: comm=stream pid=5267 prio=120 target_cpu=032
stream-5261    [016] d..2.   262.189720: sched_wakeup_new: comm=stream pid=5268 prio=120 target_cpu=016
stream-5261    [016] d..2.   262.189758: sched_wakeup_new: comm=stream pid=5269 prio=120 target_cpu=016

Four stream threads pile up on cpu 16 initially and in case of
short runs, where the load balancer doesn't have enough time to kick in
to migrate task, performance might suffer. This pattern is observed
consistently where tasks pile on one cpu of the group where the
runner script is pinned to.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks with this fix in NPS2 mode:

stream-5260    [016] d..2.   212.794629: sched_wakeup_new: comm=stream pid=5262 prio=120 target_cpu=000
stream-5260    [016] d..2.   212.794683: sched_wakeup_new: comm=stream pid=5263 prio=120 target_cpu=048
stream-5260    [016] d..2.   212.794789: sched_wakeup_new: comm=stream pid=5264 prio=120 target_cpu=032
stream-5260    [016] d..2.   212.794850: sched_wakeup_new: comm=stream pid=5265 prio=120 target_cpu=112
stream-5260    [016] d..2.   212.794903: sched_wakeup_new: comm=stream pid=5266 prio=120 target_cpu=096
stream-5260    [016] d..2.   212.794961: sched_wakeup_new: comm=stream pid=5267 prio=120 target_cpu=080
stream-5260    [016] d..2.   212.795018: sched_wakeup_new: comm=stream pid=5268 prio=120 target_cpu=064

The tasks have been distributed evenly across all the allowed cpus
and no pile up can be seen.


Aggressive NUMA balancing is only done when needed. We select the
minimum of number of allowed cpus in sched group and the calculated
sd.imb_numa_nr as our imbalance threshold and the default behavior
of mel-v5 is only modified when the former is smaller than
the latter.

This can help is case of embarrassingly parallel programs with tight
cpus affinity set.


[1] https://lore.kernel.org/lkml/20220208094334.16379-1-mgorman@techsingularity.net/

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v1-->v2:
 -  Rebase changes on top of v6 of Mel's
    "Adjust NUMA imbalance for multiple LLCs" patchset
 -  Reuse select_idle_mask ptr to store result of cpumask_and based
    on Mel's suggestion
---
 kernel/sched/fair.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4bfffe8c2c..6e875f1f34e2 100644
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
@@ -9147,10 +9149,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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
+			cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+			cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+			imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
 				return NULL;
 		}
 
-- 
2.25.1

