Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24146540C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbhLARhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:37:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351941AbhLARgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:36:41 -0500
Date:   Wed, 1 Dec 2021 18:33:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638379997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h8UNBLiSkPlhvyZ4mn8yJQzaXY1b8kMQFH4oNN45s+E=;
        b=H4VTIjikZvnImdeUKXgGKHAWU2ksWjnAhdJpnXC/3WVQLLApGMNOdqED7cVyvSX7dRBoq3
        hS0wJs3G8O2+eRjr5ofid8n8yiitoK0wdrpKVRWSd6gKaK/oNeDvhte+Zq9wOFmXKLE48w
        AUTwGoPhLuxN3tWRCkyUgafF+Y9iyrVgn1WfVUxwiBnMoVZy4/E4fEz4jfSUsryG275mUI
        /rN2SMmdthIzoa2Un2xXWklyYWj/AIeZQ8EFogxb5wEa9RvF808pXINg9Jyj6hROOSMaXG
        AK7FxyGcJ7274QkpT8/F+9nsA/HbjqfvGl+o1N7CLpeXfP4VMn2faEza215MwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638379997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h8UNBLiSkPlhvyZ4mn8yJQzaXY1b8kMQFH4oNN45s+E=;
        b=7nR/OSrof3g7Lepe/dQhkdj4vK4mbpa7dzfH6Grsp7Xp5JK0kJFDhVeOFkqRQtcMVnefOR
        PDV+SH8+iO5rJpAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rc3-rt7
Message-ID: <20211201173316.rm6o67qapqsx2n47@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rc3-rt7 patch set. 

Changes since v5.16-rc3-rt6:

  - Drop the workaround for the initialisation of the stack canary on
    x86. It is no longer needed.

  - Introduce the `ktimers' thread which handles the softirq work of
    HRTIMER_SOFTIRQ and TIMER_SOFTIRQ. This avoids the wake up of
    ksoftirqd which then collects all softirqs.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16-rc3-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16-rc3-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rc3-rt7

The RT patch against v5.16-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rc3-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rc3-rt7.tar.xz

Sebastian

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 2fc22c27df183..24a8d6c4fb185 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -50,7 +50,7 @@
  */
 static __always_inline void boot_init_stack_canary(void)
 {
-	u64 canary = 0;
+	u64 canary;
 	u64 tsc;
 
 #ifdef CONFIG_X86_64
@@ -61,14 +61,8 @@ static __always_inline void boot_init_stack_canary(void)
 	 * of randomness. The TSC only matters for very early init,
 	 * there it already has some randomness on most systems. Later
 	 * on during the bootup the random pool has true entropy too.
-	 * For preempt-rt we need to weaken the randomness a bit, as
-	 * we can't call into the random generator from atomic context
-	 * due to locking constraints. We just leave canary
-	 * uninitialized and use the TSC based randomness on top of it.
 	 */
-#ifndef CONFIG_PREEMPT_RT
 	get_random_bytes(&canary, sizeof(canary));
-#endif
 	tsc = rdtsc();
 	canary += tsc + (tsc << 32UL);
 	canary &= CANARY_MASK;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1f22a30c09637..9c35024be9422 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -554,6 +554,22 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
+#ifdef CONFIG_PREEMPT_RT
+extern void raise_timer_softirq(void);
+extern void raise_hrtimer_softirq(void);
+
+#else
+static inline void raise_timer_softirq(void)
+{
+	raise_softirq(TIMER_SOFTIRQ);
+}
+
+static inline void raise_hrtimer_softirq(void)
+{
+	raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+}
+#endif
+
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 322b65d456767..e49fcdea145d8 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -623,6 +623,22 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
+static DEFINE_PER_CPU(struct task_struct *, timersd);
+static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
+
+static unsigned int local_pending_timers(void)
+{
+        return __this_cpu_read(pending_timer_softirq);
+}
+
+static void wake_timersd(void)
+{
+        struct task_struct *tsk = __this_cpu_read(timersd);
+
+        if (tsk)
+                wake_up_process(tsk);
+}
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -634,6 +650,8 @@ static inline void __irq_exit_rcu(void)
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !in_interrupt() && local_pending_timers())
+		wake_timersd();
 
 	tick_irq_exit();
 }
@@ -962,11 +980,69 @@ static struct smp_hotplug_thread softirq_threads = {
 	.thread_comm		= "ksoftirqd/%u",
 };
 
+static void timersd_setup(unsigned int cpu)
+{
+        sched_set_fifo_low(current);
+}
+
+static int timersd_should_run(unsigned int cpu)
+{
+        return local_pending_timers();
+}
+
+static void run_timersd(unsigned int cpu)
+{
+	unsigned int timer_si;
+
+	ksoftirqd_run_begin();
+
+	timer_si = local_pending_timers();
+	__this_cpu_write(pending_timer_softirq, 0);
+	or_softirq_pending(timer_si);
+
+	__do_softirq();
+
+	ksoftirqd_run_end();
+}
+
+#ifdef CONFIG_PREEMPT_RT
+static void raise_ktimers_thread(unsigned int nr)
+{
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, 1 << nr);
+}
+
+void raise_hrtimer_softirq(void)
+{
+	raise_ktimers_thread(HRTIMER_SOFTIRQ);
+}
+
+void raise_timer_softirq(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	raise_ktimers_thread(TIMER_SOFTIRQ);
+	wake_timersd();
+	local_irq_restore(flags);
+}
+#endif
+
+struct smp_hotplug_thread timer_threads = {
+        .store                  = &timersd,
+        .setup                  = timersd_setup,
+        .thread_should_run      = timersd_should_run,
+        .thread_fn              = run_timersd,
+        .thread_comm            = "ktimers/%u",
+};
+
 static __init int spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&timer_threads));
 
 	return 0;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb5163..dead5e738ecf1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1805,7 +1805,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next = KTIME_MAX;
 		cpu_base->softirq_activated = 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_hrtimer_softirq();
 	}
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1918,7 +1918,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next = KTIME_MAX;
 		cpu_base->softirq_activated = 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_hrtimer_softirq();
 	}
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e3d2c23c413d4..b276c34690fa2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1766,7 +1766,7 @@ static void run_local_timers(void)
 		if (time_before(jiffies, base->next_expiry))
 			return;
 	}
-	raise_softirq(TIMER_SOFTIRQ);
+	raise_timer_softirq();
 }
 
 /*
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
