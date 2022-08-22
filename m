Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726FA59C7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiHVTFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiHVTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:05:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2A813F92
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:05:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k1-20020a17090a658100b001fb35f86ccdso1944846pjj.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=fRVYXLDIctciukFUKSd2/GooWNYoTVmdQcxMFuUrumY=;
        b=KKkDGSumaIg53jK3OgpGqth05MPWF/QD24vh55Bcxqs4g+35kL1S/z9Gz4AMcb17V3
         laERCP0k0YN7Pz3u29nxktavuY2NpWkqECtzIkpDkvTzfjRJTekym7nuXb8RBzI4sdnu
         J0aKMoghALFXZ/Lr0o4k5OYB/pshunGPx0dOdAbfbiA0V6VYfb52AfL2UdTgqAFySoyc
         sR2QbSjqsCy/icBtkaFIqBd6iBqTbVdk669B2HgSDJX0j+wkOfIDfK/iBHB8qKECpNfU
         vTwxLPMcKTXSMQxPVFmWY9Y37jkW6HMK0TQeOI2PaAv4qNKIg94dXhSdOEb3c3oe5O4/
         qXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=fRVYXLDIctciukFUKSd2/GooWNYoTVmdQcxMFuUrumY=;
        b=mktwGMVdR6xzXYtGLzCKhNOAFp9CaMLe6XMX+2zr0GNJ7BpemA39DyTREjflXRfkCa
         uANqYvdw1x7Np6DobLLxA6VqHpVJxSHUET8tWGogqEe8RoarJ36kBqPQkhAGXWftaimS
         LCWtKa1gYRw5lAnDtQ1I2hwB0TqVWwWl02qOsN9dvr68ZWXT4RshmvzVnGd9rXlHDugi
         +9iR1Im1IwZU04nUDls9gaqbvGCGWUx+1qR+C6pooytgWBsjHxTA9E2SfxNcAjMVAzdr
         Aqqg4ZWR2h3dr1aVh1NSlkKPas5sJ6g6MKed0TeTRcSXvwJoJVC8BaRpht1MykeMlzEB
         66AQ==
X-Gm-Message-State: ACgBeo1DuRj82tkfOJm0NELTPtP3ZkI5kLdp80PWcAPTzj9akVFtW6AC
        VCnDmFoSlNgMAgeFwQm+BmZND2qUNSAqA/DwK5cO9N1baztlGpDi9MMrvF1PoLJY/Mok0Yy+DLy
        X5BKQkB4iSkivQSohYR1YpS9L4Te3WnpzaahI2alRVudJNOtJ0I64RuLpmeKp2aHQ6Q8oACw=
X-Google-Smtp-Source: AA6agR4o3ck3mbS34wCnLNWitDB95b+fiEIgKN3Jf0cV/Ttq3uu3wArzsn70bq8B6AqhCGj/CA7pKgwPaYlR
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:1b69:b0:1fa:f9de:fbcf with SMTP id
 q96-20020a17090a1b6900b001faf9defbcfmr14929866pjq.201.1661195106810; Mon, 22
 Aug 2022 12:05:06 -0700 (PDT)
Date:   Mon, 22 Aug 2022 19:05:00 +0000
In-Reply-To: <20220822190501.2171100-1-jstultz@google.com>
Message-Id: <20220822190501.2171100-2-jstultz@google.com>
Mime-Version: 1.0
References: <20220822190501.2171100-1-jstultz@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC][PATCH v2 1/2] sched: Avoid placing RT threads on cores handling
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
Cc: Chris Redpath <chris.redpath@arm.com>
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
 message, removed arm64-isms]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Reformatted Kconfig entry to match coding style
  (Reported-by: Randy Dunlap <rdunlap@infradead.org>)
* Made rt_task_fits_capacity_and_may_preempt static to
  avoid warnings (Reported-by: kernel test robot <lkp@intel.com>)
* Rework to use preempt_count and drop kconfig dependency on ARM64
---
 include/linux/interrupt.h |  7 +++++
 init/Kconfig              | 10 ++++++
 kernel/sched/rt.c         | 65 +++++++++++++++++++++++++++++++++------
 kernel/softirq.c          |  9 ++++++
 4 files changed, 82 insertions(+), 9 deletions(-)

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
index 532362fcfe31..8b5add74b6cb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1284,6 +1284,16 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
+config RT_SOFTIRQ_OPTIMIZATION
+	bool "Improve RT scheduling during long softirq execution"
+	depends on SMP
+	default n
+	help
+	  Enable an optimization which tries to avoid placing RT tasks on CPUs
+	  occupied by nonpreemptible tasks, such as a long softirq or CPUs
+	  which may soon block preemptions, such as a CPU running a ksoftirq
+	  thread which handles slow softirqs.
+
 config SYSFS_DEPRECATED
 	bool "Enable deprecated sysfs features to support old userspace tools"
 	depends on SYSFS
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55f39c8f4203..5a5cf396d0d2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1599,12 +1599,50 @@ static void yield_task_rt(struct rq *rq)
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
+		  preempt_count() & SOFTIRQ_MASK));
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
+static bool rt_task_fits_capacity_and_may_preempt(struct task_struct *p, int cpu)
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
@@ -1616,7 +1654,12 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
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
@@ -1641,9 +1684,10 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
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
@@ -1656,11 +1700,14 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
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
 
@@ -1901,11 +1948,11 @@ static int find_lowest_rq(struct task_struct *task)
 
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
index c8a6913c067d..35ee79dd8786 100644
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
2.37.1.595.g718a3a8f04-goog

