Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192AA562EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiGAIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiGAItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FE12AC3;
        Fri,  1 Jul 2022 01:48:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9c+93pWsfLUrO1CEJS8smA08Awr6Kss+iJNo0dJA4Ck=;
        b=aea6zA05iO444LZ55LEATbPXDzJO+f8gDG6xOhtnkqnWbNeM3wxrYaFnuANikfRn8Aroi0
        wa4cEACebPq6+gjqCfNhiObAwXTSqSLjhef/FJhIkWix1u1GgisP4CV1bGxjZanZUwQQ4z
        UgSdF1MRlj3CUt51u7GciRc1Jp5YasfO7um4wljodrdD5I4KRImls8rezCKQmEpn1QFQwH
        HWFlwbzd6tkaNOqIFJrxdG21vHHqpbmc1ahh/yzOgnTOISH4xpK5Q4dvUgE0Kj6n/8GKM8
        cDilB/GhqWAB5IJBl2ZBgENasL/cx6FRMd90FtnYBmkmKtFPIvZ8Diir/cPsvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9c+93pWsfLUrO1CEJS8smA08Awr6Kss+iJNo0dJA4Ck=;
        b=qjjPciC6Ku9+ctzcYlQ1d8vQGd75EscdJofgVRBB+e7PKcpyo9WDiP3JOWtGpD3UL0cx9g
        63VWtzyph3QCNrCA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, drivers: Remove max param from
 effective_cpu_util()/sched_cpu_util()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621090414.433602-4-vdonnefort@google.com>
References: <20220621090414.433602-4-vdonnefort@google.com>
MIME-Version: 1.0
Message-ID: <165660183658.15455.4050288098144742316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bb4479994945e9170534389a7762eb56149320ac
Gitweb:        https://git.kernel.org/tip/bb4479994945e9170534389a7762eb56149320ac
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Tue, 21 Jun 2022 10:04:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:17:46 +02:00

sched, drivers: Remove max param from effective_cpu_util()/sched_cpu_util()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20220621090414.433602-4-vdonnefort@google.com
---
 drivers/powercap/dtpm_cpu.c       | 33 ++++++++----------------------
 drivers/thermal/cpufreq_cooling.c |  6 +----
 include/linux/sched.h             |  2 +-
 kernel/sched/core.c               | 11 +++++-----
 kernel/sched/cpufreq_schedutil.c  |  5 ++---
 kernel/sched/fair.c               | 21 +++++++++----------
 kernel/sched/sched.h              |  2 +-
 7 files changed, 31 insertions(+), 49 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index f5eced0..6a88eb7 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -71,34 +71,19 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
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
index b8151d9..b263b0f 100644
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
index c46f3a6..88b8817 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2257,7 +2257,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 }
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
-unsigned long sched_cpu_util(int cpu, unsigned long max);
+unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d3e2c5a..c538a0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7125,12 +7125,14 @@ struct task_struct *idle_task(int cpu)
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
@@ -7210,10 +7212,9 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
index 3dbf351..1207c78 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -157,11 +157,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
index 80be1f1..6de09b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6712,12 +6712,11 @@ static long
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
@@ -6754,10 +6753,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
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
@@ -6766,12 +6765,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
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
index 76b0027..73ae328 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2886,7 +2886,7 @@ enum cpu_util_type {
 };
 
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum cpu_util_type type,
+				 enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
