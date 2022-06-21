Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7A552DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348560AbiFUJEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348779AbiFUJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:04:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FC17E1C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so2455998ybq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RAc4mXVipDiWq1PntAMbZwW5jl2XzWMCzcXzpYPwhS0=;
        b=luJTuDPSZU8s1ZP69Qb5oi63a6GaSfii9QMQjTg+wdDPooVmVR0G1uLoJRvlCAGceI
         Vo1fmcXgnFr01As6Xq0OIjUFl2RzAz1DZOJQ/HuHu0XGP1LG55q/9TGrnJE9EKoqtgNA
         Nts27fn+uVAJy6+DJIQNX/6i7IgVj6QUy+w1qTj5Ox/Odz0aZ8GOsqKFuTlb7i9vp5Dx
         vgzCLclICvA/9OmmGa6fxqorTQHTVv5+7gGi22I3hD57Nc826b4OvLKxHAhUs8tQ8486
         tJQCCLqvgY+6uyZaPRQ55C5/lQKe3RVQ3l5puyFgQu5a9JW6l/nKdYIP7F+Bk7hI8qzH
         Km2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RAc4mXVipDiWq1PntAMbZwW5jl2XzWMCzcXzpYPwhS0=;
        b=HhoTfKYuUD+Wld0X6wZBDCTwjFCR64r51TFXDS2q+jeR41mUhHJ08URppX4q7orsTX
         sge6Aa8EMBh3ELI5Yc1lG8p8mZsP/+h76mYbavT6IrfE10r8Ai8TXXRYUIylanJ0q6D3
         7tDhYV7w0yEs6i0Bv4AzHP+A3WB7nBuR2offyN3RwD1eV3uSj19iHRO5PxZCZOK0Exp2
         tc8wRAcJzcVMDlpD+yYP5bXw6AHuV2O6AsV/CxAyosvfJG6riMQVvgxxlaBo1jriYBbz
         INPs786fJQCJBCcoNwwJM7JlXewzcz05D58J4GlTCqP9mpD8XZbF2uMOjvs6CstNr4cv
         bMCA==
X-Gm-Message-State: AJIora/sXD3WS5Me71MvtYpGcRsrBeBIqylERLtYaL7hCf/TUeXa6OHA
        1l3TfShOT6IUZ1Ls25Sq803qFo72gcKRJg1b
X-Google-Smtp-Source: AGRyM1uyuNNoE44Dz7PvvdR5D70erWPAlfjh262lUeg2iqPKSvN+LMgTN8N8MffAEQzhnOCWTfK8qyYpk5C/8FdK
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP
 id v126-20020a812f84000000b003142bfdbf1fmr31529837ywv.320.1655802271348; Tue,
 21 Jun 2022 02:04:31 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:04:10 +0100
In-Reply-To: <20220621090414.433602-1-vdonnefort@google.com>
Message-Id: <20220621090414.433602-4-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220621090414.433602-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v11 3/7] sched, drivers: Remove max param from effective_cpu_util()/sched_cpu_util()
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index f5eced0842b3..6a88eb7e9f75 100644
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
index b8151d95a806..b263b0fde03c 100644
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
index 9776dee75048..05a5fb5ea46a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2258,7 +2258,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 }
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
-unsigned long sched_cpu_util(int cpu, unsigned long max);
+unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 263d76489a48..8fc1bd9f13b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7175,12 +7175,14 @@ struct task_struct *idle_task(int cpu)
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
@@ -7260,10 +7262,9 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
index 3dbf351d12d5..1207c78f85c1 100644
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
index 9e9622b770fa..ee034a89bc87 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6704,12 +6704,11 @@ static long
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
@@ -6746,10 +6745,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
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
@@ -6758,12 +6757,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
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
index 278760fb2ef0..887626f98292 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2901,7 +2901,7 @@ enum cpu_util_type {
 };
 
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum cpu_util_type type,
+				 enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
-- 
2.37.0.rc0.104.g0611611a94-goog

