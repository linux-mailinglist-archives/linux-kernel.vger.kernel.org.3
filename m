Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB045702E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiGKMnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiGKMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:42:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EDF5322;
        Mon, 11 Jul 2022 05:42:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF821576;
        Mon, 11 Jul 2022 05:42:57 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BC873F792;
        Mon, 11 Jul 2022 05:42:55 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org
Subject: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
Date:   Mon, 11 Jul 2022 13:42:29 +0100
Message-Id: <20220711124229.16516-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep the max CPU capacity in the per_cpu instance.
Furthermore, there is no need to check and update that variable
(sg_cpu->max) everytime in the frequency change request, which is part
of hot path. Instead use struct sugov_policy to store that information.
Initialize the max CPU capacity during the setup and start callback.
We can do that since all CPUs in the same frequency domain have the same
max capacity (capacity setup and thermal pressure are based on that).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1207c78f85c1..9161d1136d01 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -25,6 +25,9 @@ struct sugov_policy {
 	unsigned int		next_freq;
 	unsigned int		cached_raw_freq;
 
+	/* max CPU capacity, which is equal for all CPUs in freq. domain */
+	unsigned long		max;
+
 	/* The next fields are only needed if fast switch cannot be used: */
 	struct			irq_work irq_work;
 	struct			kthread_work work;
@@ -48,7 +51,6 @@ struct sugov_cpu {
 
 	unsigned long		util;
 	unsigned long		bw_dl;
-	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -158,7 +160,6 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
@@ -253,6 +254,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  */
 static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long boost;
 
 	/* No boost currently required */
@@ -280,7 +282,8 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
+	boost = sg_cpu->iowait_boost * sg_policy->max;
+	boost >>= SCHED_CAPACITY_SHIFT;
 	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
@@ -337,7 +340,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	if (!sugov_update_single_common(sg_cpu, time, flags))
 		return;
 
-	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
+	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_policy->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -373,6 +376,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 				     unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long prev_util = sg_cpu->util;
 
 	/*
@@ -399,7 +403,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), sg_cpu->max);
+				   map_util_perf(sg_cpu->util),
+				   sg_policy->max);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -408,25 +413,19 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned long util = 0, max = 1;
+	unsigned long util = 0;
 	unsigned int j;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
-		unsigned long j_util, j_max;
 
 		sugov_get_util(j_sg_cpu);
 		sugov_iowait_apply(j_sg_cpu, time);
-		j_util = j_sg_cpu->util;
-		j_max = j_sg_cpu->max;
 
-		if (j_util * max > j_max * util) {
-			util = j_util;
-			max = j_max;
-		}
+		util = max(j_sg_cpu->util, util);
 	}
 
-	return get_next_freq(sg_policy, util, max);
+	return get_next_freq(sg_policy, util, sg_policy->max);
 }
 
 static void
@@ -752,7 +751,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
-	unsigned int cpu;
+	unsigned int cpu = cpumask_first(policy->cpus);
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
@@ -760,6 +759,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->work_in_progress		= false;
 	sg_policy->limits_changed		= false;
 	sg_policy->cached_raw_freq		= 0;
+	sg_policy->max				= arch_scale_cpu_capacity(cpu);
 
 	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 
-- 
2.17.1

