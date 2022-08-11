Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247658F5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiHKB6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHKB6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:58:17 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820FE83BF6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:58:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c11-20020a170902d48b00b0016f093907e0so10762133plg.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=QZwR3RkTdeOZA+Wvrh//Z0GCnPnnKRbLd9hxNUvHbyg=;
        b=U7khL806XpNVqGvz7LY+he+wYECPws0UQkPRkUCwhQxZqwGCBW6amnaxD6tAC3wHt8
         Y3GD7FrBhjeyWK8yYMP3nfNhDyAOcpQ8Z0oGmTvCW/XQxVNRzVJNf+4NY0nsoIKHbKMb
         mObQrr3BmjA0VSFL/NdfLUmWFxdWPH2bA75P5Qc0Yfqf97VuGeuy7NP6Mb7/3SXd2kCi
         u9wRLHjLbgjz9Q0KxddIdRxo1dUmY43YLhYQEc7aBlVsQPvGMZjVLKBMnwwiEFa5VYyM
         d+DcpZCM7I9TddAOC6l/sl6JES/9BUXm0lrgusyK30d8BKiMcb7tdZY6n92S0d/Kgkm3
         yaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=QZwR3RkTdeOZA+Wvrh//Z0GCnPnnKRbLd9hxNUvHbyg=;
        b=ubbgydM3DSqElbJ91HRcWwbk9yAsiWm8NKjV2a76krl/P03xYRhm5NWfAR0/do9era
         vF1PSGyTyv+JFWFlsGydt+rntxy2cuVkY/V/zEieRkBkMrhB2AqpWDSypqZI4DPk/K3c
         GbAaK9jm7WP8ajAhvy6AZpuqJ1YKBMnigW+Sp7wVwWpAIiCaumdkct9ueez2bnhH5fxy
         zOcCFJLMEwxAzywrS1wsjTGuNY9lz83KYNJ8JIm5pXoUHkw4brAaQ1P2QpxqKa80Qivx
         26C2Nwolnca0MNWPyPkkhHnVfXglDEORFE8J4xSUby7BPJG2xC6m8vefLZZsOUML87dH
         7mvQ==
X-Gm-Message-State: ACgBeo2MhJL75iy7N940+KRA71r+/ud/xwgfqljqDwjiDSwtWt/4rYqN
        BSGYI5BMl2KDSuBJVsRvUPQ5h5tSfgZbdClgXbbzLvG7fn8eTOLy86q6OIZz5H3mphX83MAimSD
        Q5ueurBoDxVFMEoTHVZSpJbxyJ7fZ70GN6gkd2zUsEuOAzXXduulTyv6NduUL701frLcrSY0=
X-Google-Smtp-Source: AA6agR44jVawS1h1eBP2k2NDu2hHPaHIVBjPvnmebProz/ZXtBvbVYrMq3zh+eI+EcgJMg6TPZcvPyZqWRDU
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:390c:b0:1f5:5bbc:2e8 with SMTP id
 ob12-20020a17090b390c00b001f55bbc02e8mr6487952pjb.233.1660183095926; Wed, 10
 Aug 2022 18:58:15 -0700 (PDT)
Date:   Thu, 11 Aug 2022 01:57:57 +0000
In-Reply-To: <20220811015758.3001641-1-jstultz@google.com>
Message-Id: <20220811015758.3001641-2-jstultz@google.com>
Mime-Version: 1.0
References: <20220811015758.3001641-1-jstultz@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [RFC][PATCH 1/2] sched: Avoid placing RT threads on cores handling
 long softirqs
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
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

From: Connor O'Brien <connoro@google.com>

In certain audio use cases, scheduling RT threads on cores that
are handling softirqs can lead to glitches. Prevent this
behavior in cases where the softirq is likely to take a long
time. To avoid unnecessary migrations, the old behavior is
preserved for RCU, SCHED and TIMER irqs which are expected to be
relatively quick.

This patch reworks and combines two related changes originally
by John Dias <joaodias@google.com>

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Chris Redpath <chris.redpath@arm.com>,
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: John Dias <joaodias@google.com>
[elavila: Port to mainline, amend commit text]
Signed-off-by: J. Avila <elavila@google.com>
[connoro: Reworked, simplified, and merged two patches together]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Further simplified and fixed issues, reworded commit
 message]
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/linux/interrupt.h |  7 +++++
 init/Kconfig              | 11 +++++++
 kernel/sched/rt.c         | 65 +++++++++++++++++++++++++++++++++------
 kernel/softirq.c          |  9 ++++++
 4 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..bac9da05b9c8 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -571,6 +571,12 @@ enum
  * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
  */
 #define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
+/* Softirq's where the handling might be long: */
+#define LONG_SOFTIRQ_MASK ((1 << NET_TX_SOFTIRQ)       | \
+			   (1 << NET_RX_SOFTIRQ)       | \
+			   (1 << BLOCK_SOFTIRQ)        | \
+			   (1 << IRQ_POLL_SOFTIRQ) | \
+			   (1 << TASKLET_SOFTIRQ))
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
@@ -606,6 +612,7 @@ extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
+DECLARE_PER_CPU(u32, active_softirqs);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
 {
diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f1..b0dde2771314 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1278,6 +1278,17 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
+config RT_SOFTIRQ_OPTIMIZATION
+       bool "Improve RT scheduling during long softirq execution"
+       depends on ARM64
+       depends on SMP
+       default n
+       help
+         Enable an optimization which tries to avoid placing RT tasks on CPUs
+	 occupied by nonpreemptible tasks, such as a long softirq or CPUs
+	 which may soon block preemptions, such as a CPU running a ksoftirq
+	 thread which handles slow softirqs.
+
 config SYSFS_DEPRECATED
 	bool "Enable deprecated sysfs features to support old userspace tools"
 	depends on SYSFS
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..22f491c8af3a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1596,12 +1596,50 @@ static void yield_task_rt(struct rq *rq)
 #ifdef CONFIG_SMP
 static int find_lowest_rq(struct task_struct *task);
 
+#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
+/*
+ * Return whether the task on the given cpu is currently non-preemptible
+ * while handling a potentially long softirq, or if the task is likely
+ * to block preemptions soon because it is a ksoftirq thread that is
+ * handling slow softirq.
+ */
+static bool task_may_preempt(struct task_struct *task, int cpu)
+{
+	u32 softirqs = per_cpu(active_softirqs, cpu) |
+		       per_cpu(irq_stat, cpu).__softirq_pending;
+
+	struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
+	struct task_struct *curr;
+	struct rq *rq = cpu_rq(cpu);
+	int ret;
+
+	rcu_read_lock();
+	curr = READ_ONCE(rq->curr); /* unlocked access */
+	ret = !((softirqs & LONG_SOFTIRQ_MASK) &&
+		 (curr == cpu_ksoftirqd ||
+		  task_thread_info(curr)->preempt_count & SOFTIRQ_MASK));
+	rcu_read_unlock();
+	return ret;
+}
+#else
+static bool task_may_preempt(struct task_struct *task, int cpu)
+{
+	return true;
+}
+#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
+
+bool rt_task_fits_capacity_and_may_preempt(struct task_struct *p, int cpu)
+{
+	return task_may_preempt(p, cpu) && rt_task_fits_capacity(p, cpu);
+}
+
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
 	bool test;
+	bool may_not_preempt;
 
 	/* For anything but wake ups, just return the task_cpu */
 	if (!(flags & (WF_TTWU | WF_FORK)))
@@ -1613,7 +1651,12 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	curr = READ_ONCE(rq->curr); /* unlocked access */
 
 	/*
-	 * If the current task on @p's runqueue is an RT task, then
+	 * If the current task on @p's runqueue is a softirq task,
+	 * it may run without preemption for a time that is
+	 * ill-suited for a waiting RT task. Therefore, try to
+	 * wake this RT task on another runqueue.
+	 *
+	 * Also, if the current task on @p's runqueue is an RT task, then
 	 * try to see if we can wake this RT task up on another
 	 * runqueue. Otherwise simply start this RT task
 	 * on its current runqueue.
@@ -1638,9 +1681,10 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * requirement of the task - which is only important on heterogeneous
 	 * systems like big.LITTLE.
 	 */
-	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	may_not_preempt = !task_may_preempt(curr, cpu);
+	test = (curr && (may_not_preempt ||
+			 (unlikely(rt_task(curr)) &&
+			  (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio))));
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1653,11 +1697,14 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 			goto out_unlock;
 
 		/*
-		 * Don't bother moving it if the destination CPU is
+		 * If cpu is non-preemptible, prefer remote cpu
+		 * even if it's running a higher-prio task.
+		 * Otherwise: Don't bother moving it if the destination CPU is
 		 * not running a lower priority task.
 		 */
 		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
+		    (may_not_preempt ||
+		     p->prio < cpu_rq(target)->rt.highest_prio.curr))
 			cpu = target;
 	}
 
@@ -1898,11 +1945,11 @@ static int find_lowest_rq(struct task_struct *task)
 
 		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
-					  rt_task_fits_capacity);
+					  rt_task_fits_capacity_and_may_preempt);
 	} else {
 
-		ret = cpupri_find(&task_rq(task)->rd->cpupri,
-				  task, lowest_mask);
+		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
+					  task, lowest_mask, task_may_preempt);
 	}
 
 	if (!ret)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9f0aef8aa9ff..92fa82400a80 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -60,6 +60,13 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+/*
+ * active_softirqs -- per cpu, a mask of softirqs that are being handled,
+ * with the expectation that approximate answers are acceptable and therefore
+ * no synchronization.
+ */
+DEFINE_PER_CPU(u32, active_softirqs);
+
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
@@ -551,6 +558,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
+	__this_cpu_write(active_softirqs, pending);
 
 	local_irq_enable();
 
@@ -580,6 +588,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
+	__this_cpu_write(active_softirqs, 0);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
 	    __this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
-- 
2.37.1.559.g78731f0fdb-goog

