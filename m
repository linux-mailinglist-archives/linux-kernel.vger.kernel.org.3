Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5507D49F481
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346932AbiA1HkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346915AbiA1HkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83817C061714;
        Thu, 27 Jan 2022 23:40:18 -0800 (PST)
Date:   Fri, 28 Jan 2022 07:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnRxvwTjREBrJ8eQ8kqu54VszJv35kLuK+3TBBC/hOE=;
        b=SGTm4nSAoSbm18ik51FcfkzvC+ugbzpvknSJlX02qMlUtiAUtSeZ0X0dFF+udvegoHY9rR
        yOgM+iicfBbBqKFYkK+bUxgFvNC9CiLagemhVjYaviY7Wa38FooGSp1ufDQorgXd3wHJTw
        8ResOIVNDUXUFTKwikNsEZPutyGP/uovoPMMyLPm4Cn0cO4Fpmt56ovjam8mi5Dlbg0QXx
        rkPBXW7f1TqlWvyMyyajbYlDqvKiMfucwZRhXIQqdApYEGPqRmqg6vQMFgpFto/7AjkPi0
        wZnw53NcRCZklZrIpjwGbRkr5pCS6gep7Kwc/+0czcytDV4QbDd4oyabriJGfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnRxvwTjREBrJ8eQ8kqu54VszJv35kLuK+3TBBC/hOE=;
        b=xEZZ6JM/4gc/lZh1AoYwpR2sXPAe0E/fQVOnWpbGD0D76NAqTtqJVSN/xDAEwJZmrUYuSH
        dVV8CiEhXuyD6ZAg==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/sugov: Ignore 'busy' filter when rq is capped
 by uclamp_max
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211216225320.2957053-2-qais.yousef@arm.com>
References: <20211216225320.2957053-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <164335561611.16921.13963600715090987694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7a17e1db1265471f7718af100cfc5e41280d53a7
Gitweb:        https://git.kernel.org/tip/7a17e1db1265471f7718af100cfc5e41280d53a7
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 16 Dec 2021 22:53:19 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:19 +01:00

sched/sugov: Ignore 'busy' filter when rq is capped by uclamp_max

sugov_update_single_{freq, perf}() contains a 'busy' filter that ensures
we don't bring the frqeuency down if there's no idle time (CPU is busy).

The problem is that with uclamp_max we will have scenarios where a busy
task is capped to run at a lower frequency and this filter prevents
applying the capping when this task starts running.

We handle this by skipping the filter when uclamp is enabled and the rq
is being capped by uclamp_max.

We introduce a new function uclamp_rq_is_capped() to help detecting when
this capping is taking effect. Some code shuffling was required to allow
using cpu_util_{cfs, rt}() in this new function.

On 2 Core SMT2 Intel laptop I see:

Without this patch:

	uclampset -M 0 sysbench --test=cpu --threads = 4 run

produces a score of ~3200 consistently. Which is the highest possible.

Compiling the kernel also results in frequency running at max 3.1GHz all
the time - running uclampset -M 400 to cap it has no effect without this
patch.

With this patch:

	uclampset -M 0 sysbench --test=cpu --threads = 4 run

produces a score of ~1100 with some outliers in ~1700. Uclamp max
aggregates the performance requirements, so having high values sometimes
is expected if some other task happens to require that frequency starts
running at the same time.

When compiling the kernel with uclampset -M 400 I can see the
frequencies mostly in the ~2GHz region. Helpful to conserve power and
prevent heating when not plugged in.

Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211216225320.2957053-2-qais.yousef@arm.com
---
 kernel/sched/cpufreq_schedutil.c |  10 +-
 kernel/sched/sched.h             | 181 ++++++++++++++++--------------
 2 files changed, 107 insertions(+), 84 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2677888..62d98b0 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -348,8 +348,11 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
+	 *
+	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
+	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
+	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
 		/* Restore cached freq as next_freq has changed */
@@ -395,8 +398,11 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the target performance level if the CPU has not been
 	 * idle recently, as the reduction is likely to be premature then.
+	 *
+	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
+	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be9..9b33ba9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2841,88 +2841,6 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
-#ifdef CONFIG_UCLAMP_TASK
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
-
-/**
- * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
- * @rq:		The rq to clamp against. Must not be NULL.
- * @util:	The util value to clamp.
- * @p:		The task to clamp against. Can be NULL if you want to clamp
- *		against @rq only.
- *
- * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
- *
- * If sched_uclamp_used static key is disabled, then just return the util
- * without any clamping since uclamp aggregation at the rq level in the fast
- * path is disabled, rendering this operation a NOP.
- *
- * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
- * will return the correct effective uclamp value of the task even if the
- * static key is disabled.
- */
-static __always_inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	unsigned long min_util = 0;
-	unsigned long max_util = 0;
-
-	if (!static_branch_likely(&sched_uclamp_used))
-		return util;
-
-	if (p) {
-		min_util = uclamp_eff_value(p, UCLAMP_MIN);
-		max_util = uclamp_eff_value(p, UCLAMP_MAX);
-
-		/*
-		 * Ignore last runnable task's max clamp, as this task will
-		 * reset it. Similarly, no need to read the rq's min clamp.
-		 */
-		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-			goto out;
-	}
-
-	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
-	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
-out:
-	/*
-	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
-	 * RUNNABLE tasks with _different_ clamps, we can end up with an
-	 * inversion. Fix it now when the clamps are applied.
-	 */
-	if (unlikely(min_util >= max_util))
-		return min_util;
-
-	return clamp(util, min_util, max_util);
-}
-
-/*
- * When uclamp is compiled in, the aggregation at rq level is 'turned off'
- * by default in the fast path and only gets turned on once userspace performs
- * an operation that requires it.
- *
- * Returns true if userspace opted-in to use uclamp and aggregation at rq level
- * hence is active.
- */
-static inline bool uclamp_is_used(void)
-{
-	return static_branch_likely(&sched_uclamp_used);
-}
-#else /* CONFIG_UCLAMP_TASK */
-static inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	return util;
-}
-
-static inline bool uclamp_is_used(void)
-{
-	return false;
-}
-#endif /* CONFIG_UCLAMP_TASK */
-
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
 #  define arch_scale_freq_invariant()	true
@@ -3020,6 +2938,105 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_UCLAMP_TASK
+unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+
+/**
+ * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
+ * @rq:		The rq to clamp against. Must not be NULL.
+ * @util:	The util value to clamp.
+ * @p:		The task to clamp against. Can be NULL if you want to clamp
+ *		against @rq only.
+ *
+ * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
+ *
+ * If sched_uclamp_used static key is disabled, then just return the util
+ * without any clamping since uclamp aggregation at the rq level in the fast
+ * path is disabled, rendering this operation a NOP.
+ *
+ * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
+ * will return the correct effective uclamp value of the task even if the
+ * static key is disabled.
+ */
+static __always_inline
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
+{
+	unsigned long min_util = 0;
+	unsigned long max_util = 0;
+
+	if (!static_branch_likely(&sched_uclamp_used))
+		return util;
+
+	if (p) {
+		min_util = uclamp_eff_value(p, UCLAMP_MIN);
+		max_util = uclamp_eff_value(p, UCLAMP_MAX);
+
+		/*
+		 * Ignore last runnable task's max clamp, as this task will
+		 * reset it. Similarly, no need to read the rq's min clamp.
+		 */
+		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+			goto out;
+	}
+
+	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
+	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
+out:
+	/*
+	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
+	 * RUNNABLE tasks with _different_ clamps, we can end up with an
+	 * inversion. Fix it now when the clamps are applied.
+	 */
+	if (unlikely(min_util >= max_util))
+		return min_util;
+
+	return clamp(util, min_util, max_util);
+}
+
+/* Is the rq being capped/throttled by uclamp_max? */
+static inline bool uclamp_rq_is_capped(struct rq *rq)
+{
+	unsigned long rq_util;
+	unsigned long max_util;
+
+	if (!static_branch_likely(&sched_uclamp_used))
+		return false;
+
+	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
+	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+
+	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
+}
+
+/*
+ * When uclamp is compiled in, the aggregation at rq level is 'turned off'
+ * by default in the fast path and only gets turned on once userspace performs
+ * an operation that requires it.
+ *
+ * Returns true if userspace opted-in to use uclamp and aggregation at rq level
+ * hence is active.
+ */
+static inline bool uclamp_is_used(void)
+{
+	return static_branch_likely(&sched_uclamp_used);
+}
+#else /* CONFIG_UCLAMP_TASK */
+static inline
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
+{
+	return util;
+}
+
+static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
+
+static inline bool uclamp_is_used(void)
+{
+	return false;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
