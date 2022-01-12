Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81F448C805
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355063AbiALQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:15:52 -0500
Received: from foss.arm.com ([217.140.110.172]:32980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355047AbiALQOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:14:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 235961FB;
        Wed, 12 Jan 2022 08:14:50 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.10.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A160F3F774;
        Wed, 12 Jan 2022 08:14:48 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com
Subject: [PATCH v2 3/7] sched, drivers: Remove max param from effective_cpu_util()/sched_cpu_util()
Date:   Wed, 12 Jan 2022 16:12:26 +0000
Message-Id: <20220112161230.836326-4-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112161230.836326-1-vincent.donnefort@arm.com>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

effective_cpu_util() already has a `int cpu' parameter which allows to
retrieve the CPU capacity scale factor (or maximum CPU capacity) inside
this function via an arch_scale_cpu_capacity(cpu).

A lot of code calling effective_cpu_util() (or the shim
sched_cpu_util()) needs the maximum CPU capacity, i.e. it will call
arch_scale_cpu_capacity() already.
But not having to pass it into effective_cpu_util() will make the EAS
wake-up code easier, especially when the maximum CPU capacity reduced
by the thermal pressure is passed through the EAS wake-up functions.

Due to the asymmetric CPU capacity support of arm/arm64 architectures,
arch_scale_cpu_capacity(int cpu) is a per-CPU variable read access via
per_cpu(cpu_scale, cpu) on such a system.
On all other architectures it is a a compile-time constant
(SCHED_CAPACITY_SCALE).

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..0d57bcf83ae5 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -70,34 +70,19 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
 {
-	unsigned long max = 0, sum_util = 0;
+	unsigned long max, sum_util = 0;
 	int cpu;
 
-	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
-
-		/*
-		 * The capacity is the same for all CPUs belonging to
-		 * the same perf domain, so a single call to
-		 * arch_scale_cpu_capacity() is enough. However, we
-		 * need the CPU parameter to be initialized by the
-		 * loop, so the call ends up in this block.
-		 *
-		 * We can initialize 'max' with a cpumask_first() call
-		 * before the loop but the bits computation is not
-		 * worth given the arch_scale_cpu_capacity() just
-		 * returns a value where the resulting assembly code
-		 * will be optimized by the compiler.
-		 */
-		max = arch_scale_cpu_capacity(cpu);
-		sum_util += sched_cpu_util(cpu, max);
-	}
-
 	/*
-	 * In the improbable case where all the CPUs of the perf
-	 * domain are offline, 'max' will be zero and will lead to an
-	 * illegal operation with a zero division.
+	 * The capacity is the same for all CPUs belonging to
+	 * the same perf domain.
 	 */
-	return max ? (power * ((sum_util << 10) / max)) >> 10 : 0;
+	max = arch_scale_cpu_capacity(cpumask_first(pd_mask));
+
+	for_each_cpu_and(cpu, pd_mask, cpu_online_mask)
+		sum_util += sched_cpu_util(cpu);
+
+	return (power * ((sum_util << 10) / max)) >> 10;
 }
 
 static u64 get_pd_power_uw(struct dtpm *dtpm)
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 43b1ae8a7789..f499f3c0e633 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -137,11 +137,9 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 		    int cpu_idx)
 {
-	unsigned long max = arch_scale_cpu_capacity(cpu);
-	unsigned long util;
+	unsigned long util = sched_cpu_util(cpu);
 
-	util = sched_cpu_util(cpu, max);
-	return (util * 100) / max;
+	return (util * 100) / arch_scale_cpu_capacity(cpu);
 }
 #else /* !CONFIG_SMP */
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2e261adb8ea..d9e672ab71f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2176,7 +2176,7 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
 #ifdef CONFIG_SMP
 /* Returns effective CPU energy utilization, as seen by the scheduler */
-unsigned long sched_cpu_util(int cpu, unsigned long max);
+unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11c6aeef4583..668ffae1888e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7086,12 +7086,14 @@ struct task_struct *idle_task(int cpu)
  * required to meet deadlines.
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum cpu_util_type type,
+				 enum cpu_util_type type,
 				 struct task_struct *p)
 {
-	unsigned long dl_util, util, irq;
+	unsigned long dl_util, util, irq, max;
 	struct rq *rq = cpu_rq(cpu);
 
+	max = arch_scale_cpu_capacity(cpu);
+
 	if (!uclamp_is_used() &&
 	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
 		return max;
@@ -7171,10 +7173,9 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	return min(max, util);
 }
 
-unsigned long sched_cpu_util(int cpu, unsigned long max)
+unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), max,
-				  ENERGY_UTIL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 26778884d9ab..9b88fc8c6ea8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -164,11 +164,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
-	sg_cpu->max = max;
+	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu), max,
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 046d5397eb8a..4fc63deda620 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6558,12 +6558,11 @@ static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
 	struct cpumask *pd_mask = perf_domain_span(pd);
-	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
-	unsigned long max_util = 0, sum_util = 0;
-	unsigned long _cpu_cap = cpu_cap;
+	unsigned long max_util = 0, sum_util = 0, cpu_cap;
 	int cpu;
 
-	_cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
+	cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
+	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
 
 	/*
 	 * The capacity state of CPUs of the current rd can be driven by CPUs
@@ -6600,10 +6599,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
-					      ENERGY_UTIL, NULL);
+		cpu_util = effective_cpu_util(cpu, util_running, ENERGY_UTIL,
+					      NULL);
 
-		sum_util += min(cpu_util, _cpu_cap);
+		sum_util += min(cpu_util, cpu_cap);
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -6612,12 +6611,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
-					      FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, min(cpu_util, _cpu_cap));
+		cpu_util = effective_cpu_util(cpu, util_freq, FREQUENCY_UTIL,
+					      tsk);
+		max_util = max(max_util, min(cpu_util, cpu_cap));
 	}
 
-	return em_cpu_energy(pd->em_pd, max_util, sum_util, _cpu_cap);
+	return em_cpu_energy(pd->em_pd, max_util, sum_util, cpu_cap);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fdf2a9e54c0e..135c37358dc0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2997,7 +2997,7 @@ enum cpu_util_type {
 };
 
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum cpu_util_type type,
+				 enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
-- 
2.25.1

