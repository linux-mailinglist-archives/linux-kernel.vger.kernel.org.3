Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4F4624C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhK2W1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhK2WZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:25:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F879C0A3BCF;
        Mon, 29 Nov 2021 12:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAA5B81646;
        Mon, 29 Nov 2021 20:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B75CC53FC7;
        Mon, 29 Nov 2021 20:43:44 +0000 (UTC)
Date:   Mon, 29 Nov 2021 15:43:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.10.78-rt56
Message-ID: <20211129154343.441b0729@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.10.78-rt56 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b6e6e068b00abdbc569c14733cfc08dabfe59109


Or to build 5.10.78-rt56 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.78.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.78-rt56.patch.xz



You can also build from 5.10.78-rt55 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.78-rt55-rt56.patch.xz



Enjoy,

-- Steve


Changes from v5.10.78-rt55:

---

Mike Galbraith (1):
      mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t

Sebastian Andrzej Siewior (11):
      sched: Fix get_push_task() vs migrate_disable()
      sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
      preempt: Move preempt_enable_no_resched() to the RT block
      mm: Disable NUMA_BALANCING_DEFAULT_ENABLED and TRANSPARENT_HUGEPAGE on PREEMPT_RT
      fscache: Use only one fscache_object_cong_wait.
      fscache: Use only one fscache_object_cong_wait.
      locking: Drop might_resched() from might_sleep_no_state_check()
      drm/i915/gt: Queue and wait for the irq_work item.
      irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.
      irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
      irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT

Steven Rostedt (VMware) (1):
      Linux 5.10.78-rt56

----
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c |   5 +-
 fs/fscache/internal.h                       |   1 -
 fs/fscache/main.c                           |   6 --
 fs/fscache/object.c                         |  13 +--
 include/linux/irq_work.h                    |  31 ++++--
 include/linux/kernel.h                      |   2 +-
 include/linux/preempt.h                     |   6 +-
 init/Kconfig                                |   2 +-
 kernel/irq_work.c                           | 143 +++++++++++++++++++++-------
 kernel/sched/core.c                         |   2 +-
 kernel/sched/sched.h                        |   3 +
 kernel/time/timer.c                         |   2 -
 localversion-rt                             |   2 +-
 mm/zsmalloc.c                               |  12 +--
 14 files changed, 155 insertions(+), 75 deletions(-)
---------------------------
diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index 0040b4765a54..3f4f854786f2 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -342,10 +342,9 @@ void intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 	/* Kick the work once more to drain the signalers */
 	irq_work_sync(&b->irq_work);
 	while (unlikely(READ_ONCE(b->irq_armed))) {
-		local_irq_disable();
-		signal_irq_work(&b->irq_work);
-		local_irq_enable();
+		irq_work_queue(&b->irq_work);
 		cond_resched();
+		irq_work_sync(&b->irq_work);
 	}
 	GEM_BUG_ON(!list_empty(&b->signalers));
 }
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 64aa552b296d..7dae569dafb9 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -95,7 +95,6 @@ extern unsigned fscache_debug;
 extern struct kobject *fscache_root;
 extern struct workqueue_struct *fscache_object_wq;
 extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
 
 extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
 
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 4207f98e405f..85f8cf3a323d 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -41,8 +41,6 @@ struct kobject *fscache_root;
 struct workqueue_struct *fscache_object_wq;
 struct workqueue_struct *fscache_op_wq;
 
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
 /* these values serve as lower bounds, will be adjusted in fscache_init() */
 static unsigned fscache_object_max_active = 4;
 static unsigned fscache_op_max_active = 2;
@@ -138,7 +136,6 @@ unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
 static int __init fscache_init(void)
 {
 	unsigned int nr_cpus = num_possible_cpus();
-	unsigned int cpu;
 	int ret;
 
 	fscache_object_max_active =
@@ -161,9 +158,6 @@ static int __init fscache_init(void)
 	if (!fscache_op_wq)
 		goto error_op_wq;
 
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
-
 	ret = fscache_proc_init();
 	if (ret < 0)
 		goto error_proc;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index cb2146e02cd5..fb9794dce721 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -807,6 +807,8 @@ void fscache_object_destroy(struct fscache_object *object)
 }
 EXPORT_SYMBOL(fscache_object_destroy);
 
+static DECLARE_WAIT_QUEUE_HEAD(fscache_object_cong_wait);
+
 /*
  * enqueue an object for metadata-type processing
  */
@@ -815,16 +817,12 @@ void fscache_enqueue_object(struct fscache_object *object)
 	_enter("{OBJ%x}", object->debug_id);
 
 	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
-		wait_queue_head_t *cong_wq =
-			&get_cpu_var(fscache_object_cong_wait);
 
 		if (queue_work(fscache_object_wq, &object->work)) {
 			if (fscache_object_congested())
-				wake_up(cong_wq);
+				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
 	}
 }
 
@@ -842,16 +840,15 @@ void fscache_enqueue_object(struct fscache_object *object)
  */
 bool fscache_object_sleep_till_congested(signed long *timeoutp)
 {
-	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
 	DEFINE_WAIT(wait);
 
 	if (fscache_object_congested())
 		return true;
 
-	add_wait_queue_exclusive(cong_wq, &wait);
+	add_wait_queue_exclusive(&fscache_object_cong_wait, &wait);
 	if (!fscache_object_congested())
 		*timeoutp = schedule_timeout(*timeoutp);
-	finish_wait(cong_wq, &wait);
+	finish_wait(&fscache_object_cong_wait, &wait);
 
 	return fscache_object_congested();
 }
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index f941f2d7d71c..2c0059340871 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
 
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
 
 /*
  * An entry can be in one of four states:
@@ -22,6 +23,7 @@ struct irq_work {
 		};
 	};
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
 
 static inline
@@ -29,13 +31,34 @@ void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
 	atomic_set(&work->flags, 0);
 	work->func = func;
+	rcuwait_init(&work->irqwait);
 }
 
 #define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
 		.flags = ATOMIC_INIT(0),			\
-		.func  = (_f)					\
+		.func  = (_f),					\
+		.irqwait = __RCUWAIT_INITIALIZER(irqwait),	\
 }
 
+#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
+	.flags = ATOMIC_INIT(_flags),				\
+	.func = (_func),					\
+	.irqwait = __RCUWAIT_INITIALIZER(irqwait),		\
+}
+
+#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
+#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
+#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
+
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->flags) & IRQ_WORK_BUSY;
+}
+
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+	return atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ;
+}
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
@@ -55,10 +78,4 @@ static inline void irq_work_run(void) { }
 static inline void irq_work_single(void *arg) { }
 #endif
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
-void irq_work_tick_soft(void);
-#else
-static inline void irq_work_tick_soft(void) { }
-#endif
-
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2cff7554395d..6eb0ab994f4c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -222,7 +222,7 @@ extern void __cant_migrate(const char *file, int line);
 	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
 
 # define might_sleep_no_state_check() \
-	do { ___might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { ___might_sleep(__FILE__, __LINE__, 0); } while (0)
 
 /**
  * cant_sleep - annotation for functions that cannot sleep
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index af39859f02ee..7b5b2ed55531 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -208,12 +208,12 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 # define preempt_enable_no_resched() sched_preempt_enable_no_resched()
-# define preempt_check_resched_rt() preempt_check_resched()
+# define preempt_check_resched_rt() barrier();
 #else
 # define preempt_enable_no_resched() preempt_enable()
-# define preempt_check_resched_rt() barrier();
+# define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
diff --git a/init/Kconfig b/init/Kconfig
index 7ba2b602b707..9bfc60e7eead 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -861,7 +861,7 @@ config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	depends on SMP && NUMA && MIGRATION
+	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
 	  The mechanism is quite primitive and is based on migrating memory when
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 8183d30e1bb1..cbec10c32ead 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,12 +18,37 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/smpboot.h>
 #include <linux/interrupt.h>
 #include <asm/processor.h>
 
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
+static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+
+static void wake_irq_workd(void)
+{
+	struct task_struct *tsk = __this_cpu_read(irq_workd);
+
+	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
+		wake_up_process(tsk);
+}
+
+#ifdef CONFIG_SMP
+static void irq_work_wake(struct irq_work *entry)
+{
+	wake_irq_workd();
+}
+
+static DEFINE_PER_CPU(struct irq_work, irq_work_wakeup) =
+	IRQ_WORK_INIT_HARD(irq_work_wake);
+#endif
+
+static int irq_workd_should_run(unsigned int cpu)
+{
+	return !llist_empty(this_cpu_ptr(&lazy_list));
+}
 
 /*
  * Claim the entry so that no one else will poke at it.
@@ -54,20 +79,28 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT);
-
-	lazy_work = atomic_read(&work->flags) & IRQ_WORK_LAZY;
-
-	/* If the work is "lazy", handle it from next tick if any */
-	if (lazy_work || (realtime && !(atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ)))
+	bool rt_lazy_work = false;
+	bool lazy_work = false;
+	int work_flags;
+
+	work_flags = atomic_read(&work->flags);
+	if (work_flags & IRQ_WORK_LAZY)
+		lazy_work = true;
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		rt_lazy_work = true;
+
+	if (lazy_work || rt_lazy_work)
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
 
-	if (llist_add(&work->llnode, list)) {
-		if (!lazy_work || tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	}
+	if (!llist_add(&work->llnode, list))
+		return;
+
+	/* If the work is "lazy", handle it from next tick if any */
+	if (!lazy_work || tick_nohz_tick_stopped())
+		arch_irq_work_raise();
 }
 
 /* Enqueue the irq work @work on the current CPU */
@@ -110,15 +143,27 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ)) {
-			if (llist_add(&work->llnode, &per_cpu(lazy_list, cpu)))
-				arch_send_call_function_single_ipi(cpu);
-		} else {
-			__smp_call_single_queue(cpu, &work->llnode);
+		/*
+		 * On PREEMPT_RT the items which are not marked as
+		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
+		 * item is used on the remote CPU to wake the thread.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    !(atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ)) {
+
+			if (!llist_add(&work->llnode, &per_cpu(lazy_list, cpu)))
+				goto out;
+
+			work = &per_cpu(irq_work_wakeup, cpu);
+			if (!irq_work_claim(work))
+				goto out;
 		}
+
+		__smp_call_single_queue(cpu, &work->llnode);
 	} else {
 		__irq_work_queue_local(work);
 	}
+out:
 	preempt_enable();
 
 	return true;
@@ -165,6 +210,10 @@ void irq_work_single(void *arg)
 	 */
 	flags &= ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -172,12 +221,13 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
 
-#ifndef CONFIG_PREEMPT_RT
 	/*
-	 * nort: On RT IRQ-work may run in SOFTIRQ context.
+	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
+	 * in a per-CPU thread in preemptible context. Only the items which are
+	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
 	 */
-	BUG_ON(!irqs_disabled());
-#endif
+	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
+
 	if (llist_empty(list))
 		return;
 
@@ -193,16 +243,10 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		/*
-		 * NOTE: we raise softirq via IPI for safety,
-		 * and execute in irq_work_tick() to move the
-		 * overhead from hard to soft irq context.
-		 */
-		if (!llist_empty(this_cpu_ptr(&lazy_list)))
-			raise_softirq(TIMER_SOFTIRQ);
-	} else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
@@ -215,15 +259,10 @@ void irq_work_tick(void)
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
-void irq_work_tick_soft(void)
-{
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-}
-#endif
-
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
  * currently in use.
@@ -231,8 +270,42 @@ void irq_work_tick_soft(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
 
 	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+static void run_irq_workd(unsigned int cpu)
+{
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+static void irq_workd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static struct smp_hotplug_thread irqwork_threads = {
+	.store                  = &irq_workd,
+	.setup			= irq_workd_setup,
+	.thread_should_run      = irq_workd_should_run,
+	.thread_fn              = run_irq_workd,
+	.thread_comm            = "irq_work/%u",
+};
+
+static __init int irq_work_init_threads(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
+	return 0;
+}
+early_initcall(irq_work_init_threads);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f638d9420553..54fa3bb1b7c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2734,7 +2734,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 826ea17e144d..c2c9c386456d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1949,6 +1949,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return NULL;
 
+	if (p->migration_disabled)
+		return NULL;
+
 	rq->push_busy = true;
 	return get_task_struct(p);
 }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af3daf03c917..cd67ee6d2634 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1767,8 +1767,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
-	irq_work_tick_soft();
-
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
diff --git a/localversion-rt b/localversion-rt
index 51b05e9abe6f..fdb0f880c7e9 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt55
+-rt56
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 277d426c881f..3595c1644135 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -82,7 +82,7 @@
 
 struct zsmalloc_handle {
 	unsigned long addr;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 #define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
@@ -370,7 +370,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
-		mutex_init(&zh->lock);
+		spin_lock_init(&zh->lock);
 	}
 #endif
 	return (unsigned long)p;
@@ -930,7 +930,7 @@ static inline int testpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_is_locked(&zh->lock);
+	return spin_is_locked(&zh->lock);
 #else
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -941,7 +941,7 @@ static inline int trypin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_trylock(&zh->lock);
+	return spin_trylock(&zh->lock);
 #else
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -952,7 +952,7 @@ static void pin_tag(unsigned long handle) __acquires(bitlock)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_lock(&zh->lock);
+	return spin_lock(&zh->lock);
 #else
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -963,7 +963,7 @@ static void unpin_tag(unsigned long handle) __releases(bitlock)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_unlock(&zh->lock);
+	return spin_unlock(&zh->lock);
 #else
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
