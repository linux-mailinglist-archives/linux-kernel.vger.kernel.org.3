Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850445A2B78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbiHZPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiHZPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:43:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61978B02BB;
        Fri, 26 Aug 2022 08:43:03 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:43:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661528581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MQlzsaE27JaeeqzzrEe/UskuJhdgIaCy1K1oy1IM8Bo=;
        b=ZyVfSyaK6w6byjOhZLJz8LIo6MsGkmj4NbWAUD71F/x55ZZmLJQ7wrtyd97+dxpeA9w7no
        +TzZhV/45YJnMnazPe11GTBhipwlgROGHtEhrja7481IlvAhYRjwoIddHAdo0H3swVg/Yg
        73yNChTipX51uD+K2wVOKHuvidAknaSJ9GIMI6Jw7yEp391cDljMS3lmKuH3CJgQAJGvXE
        hSww5nvKNAy10MFb1NPzQ2BeLAvi2bK+/3Iu1tiI3gzX/KEKvFfvexoWvRO7Ak12WtxIC5
        RggW0UP0hmsOQ/cx1c9QhaVmG65uQD+lFDyfUXK8mZf97OQwkIdjFc/d8pjgGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661528581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MQlzsaE27JaeeqzzrEe/UskuJhdgIaCy1K1oy1IM8Bo=;
        b=agYL+SDs7oEeO+qTAIi5oNHfg0Aj9JdbGjDQDCCAwvhHMmNACgFtE4j5DOg3WEcJmY07Qz
        fnv+cstPd9EALDBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.0-rc2-rt4
Message-ID: <YwjqBJNOHlw6nBhM@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.0-rc2-rt4 patch set. 

Changes since v6.0-rc2-rt3:

  - Move the defines into Kconfig for do_softirq_own_stack().

  - A small clean up of broken of u64_stats_fetch_begin() users. Impacts
    "only" statistics on 32bit.

  - Make sure code fails to compile if rwlock.h is included directly.

  - Update the "Replace PREEMPT_RT ifdefs with
    preempt_[dis|en]able_nested()." series to v2.

  - Reorder the softirq code slightly to avoid a sparse warning.
    Reported by kernel test robot (lkp@intel.com).

  - Add Vlastimil's "softirq: Redorder the code slightly." series.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v6.0-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/incr/patch-6.0-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.0-rc2-rt4

The RT patch against v6.0-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patch-6.0-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patches-6.0-rc2-rt4.tar.xz

Sebastian

diff --git a/arch/Kconfig b/arch/Kconfig
index 5dbf11a5ba4e8..8b311e400ec14 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -923,6 +923,9 @@ config HAVE_SOFTIRQ_ON_OWN_STACK
 	  Architecture provides a function to run __do_softirq() on a
 	  separate stack.
 
+config SOFTIRQ_ON_OWN_STACK
+	def_bool HAVE_SOFTIRQ_ON_OWN_STACK && !PREEMPT_RT
+
 config ALTERNATE_USER_ADDRESS_SPACE
 	bool
 	help
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 034cb48c9eeb8..fe28fc1f759d9 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -70,7 +70,7 @@ static void __init init_irq_stacks(void)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(void *arg)
 {
 	__do_softirq();
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index fbb882cb8dbb5..b05055f3ba4b8 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -480,7 +480,7 @@ static void execute_on_irq_stack(void *func, unsigned long param1)
 	*irq_stack_in_use = 1;
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	execute_on_irq_stack(__do_softirq, 0);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0f17268c1f0bb..9ede61a5a469e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -199,7 +199,7 @@ static inline void check_stack_overflow(unsigned long sp)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static __always_inline void call_do_softirq(const void *sp)
 {
 	/* Temporarily switch r1 to sp, call __do_softirq() then restore r1. */
@@ -335,7 +335,7 @@ void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void *softirq_ctx[NR_CPUS] __read_mostly;
 void *hardirq_ctx[NR_CPUS] __read_mostly;
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	call_do_softirq(softirq_ctx[smp_processor_id()]);
diff --git a/arch/s390/include/asm/softirq_stack.h b/arch/s390/include/asm/softirq_stack.h
index af68d6c1d5840..1ac5115d3115e 100644
--- a/arch/s390/include/asm/softirq_stack.h
+++ b/arch/s390/include/asm/softirq_stack.h
@@ -5,7 +5,7 @@
 #include <asm/lowcore.h>
 #include <asm/stacktrace.h>
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static inline void do_softirq_own_stack(void)
 {
 	call_on_stack(0, S390_lowcore.async_stack, void, __do_softirq);
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 9092767380780..4e6835de54cf8 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -149,7 +149,7 @@ void irq_ctx_exit(int cpu)
 	hardirq_ctx[cpu] = NULL;
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct thread_info *curctx;
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 41fa1be980a33..72da2e10e2559 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -855,7 +855,7 @@ void __irq_entry handler_irq(int pil, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	void *orig_sp, *sp = softirq_stack[smp_processor_id()];
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 63f818aedf770..147cb8fdda92e 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -203,7 +203,7 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 /*
  * Macro to invoke __do_softirq on the irq stack. This is only called from
  * task context when bottom halves are about to be reenabled and soft
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index e5dd6da78713b..01833ebf5e8e3 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,7 +132,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 3887ed33c5fe2..fa622639d6401 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -109,6 +109,7 @@ static void xrs700x_read_port_counters(struct xrs700x *priv, int port)
 {
 	struct xrs700x_port *p = &priv->ports[port];
 	struct rtnl_link_stats64 stats;
+	unsigned long flags;
 	int i;
 
 	memset(&stats, 0, sizeof(stats));
@@ -138,9 +139,9 @@ static void xrs700x_read_port_counters(struct xrs700x *priv, int port)
 	 */
 	stats.rx_packets += stats.multicast;
 
-	u64_stats_update_begin(&p->syncp);
+	flags = u64_stats_update_begin_irqsave(&p->syncp);
 	p->stats64 = stats;
-	u64_stats_update_end(&p->syncp);
+	u64_stats_update_end_irqrestore(&p->syncp, flags);
 
 	mutex_unlock(&p->mib_mutex);
 }
diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/softirq_stack.h
index d3e2d81656e04..2a67aed9ac528 100644
--- a/include/asm-generic/softirq_stack.h
+++ b/include/asm-generic/softirq_stack.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
 #define __ASM_GENERIC_SOFTIRQ_STACK_H
 
-#if defined(CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK) && !defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 8f416c5e929ea..c0ef596f340b5 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_RWLOCK_H
 #define __LINUX_RWLOCK_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c5174155d0..1341f7d62da44 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_SPINLOCK_H
 #define __LINUX_SPINLOCK_H
+#define __LINUX_INSIDE_SPINLOCK_H
 
 /*
  * include/linux/spinlock.h - generic spinlock/rwlock declarations
@@ -492,4 +493,5 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+#undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 51fa0dab68c4d..89eb6f4c659c7 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_API_SMP_H
 #define __LINUX_SPINLOCK_API_SMP_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index b8ba00ccccdeb..819aeba1c87e6 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_API_UP_H
 #define __LINUX_SPINLOCK_API_UP_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 835aedaf68acd..61c49b16f69ab 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_SPINLOCK_RT_H
 #define __LINUX_SPINLOCK_RT_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 #error Do not include directly. Use spinlock.h
 #endif
 
diff --git a/include/linux/spinlock_up.h b/include/linux/spinlock_up.h
index 16521074b6f7c..c87204247592f 100644
--- a/include/linux/spinlock_up.h
+++ b/include/linux/spinlock_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_UP_H
 #define __LINUX_SPINLOCK_UP_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9513cc64ae615..ab1fe34326bab 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -637,6 +637,7 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
+#ifdef CONFIG_PREEMPT_RT
 DEFINE_PER_CPU(struct task_struct *, timersd);
 DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
 
@@ -648,6 +649,12 @@ static void wake_timersd(void)
                 wake_up_process(tsk);
 }
 
+#else
+
+static inline void wake_timersd(void) { }
+
+#endif
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -657,10 +664,13 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
-		invoke_softirq();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !in_interrupt() && local_pending_timers())
-		wake_timersd();
+	if (!in_interrupt()) {
+		if (local_softirq_pending())
+			invoke_softirq();
+
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers())
+			wake_timersd();
+	}
 
 	tick_irq_exit();
 }
@@ -989,6 +999,7 @@ static struct smp_hotplug_thread softirq_threads = {
 	.thread_comm		= "ksoftirqd/%u",
 };
 
+#ifdef CONFIG_PREEMPT_RT
 static void timersd_setup(unsigned int cpu)
 {
         sched_set_fifo_low(current);
@@ -1014,7 +1025,6 @@ static void run_timersd(unsigned int cpu)
 	ksoftirqd_run_end();
 }
 
-#ifdef CONFIG_PREEMPT_RT
 static void raise_ktimers_thread(unsigned int nr)
 {
 	trace_softirq_raise(nr);
@@ -1035,7 +1045,6 @@ void raise_timer_softirq(void)
 	wake_timersd();
 	local_irq_restore(flags);
 }
-#endif
 
 static struct smp_hotplug_thread timer_threads = {
         .store                  = &timersd,
@@ -1044,15 +1053,16 @@ static struct smp_hotplug_thread timer_threads = {
         .thread_fn              = run_timersd,
         .thread_comm            = "ktimers/%u",
 };
+#endif
 
 static __init int spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		BUG_ON(smpboot_register_percpu_thread(&timer_threads));
-
+#ifdef CONFIG_PREEMPT_RT
+	BUG_ON(smpboot_register_percpu_thread(&timer_threads));
+#endif
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 655dc1f6510aa..83332fefa6f42 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -70,7 +70,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	 */
 	if (events <= 1)
 		return false;
-	preempt_disable();
+	preempt_disable_nested();
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -= events >> periods;
@@ -78,7 +78,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
-	preempt_enable();
+	preempt_enable_nested();
 
 	return true;
 }
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
diff --git a/mm/Kconfig b/mm/Kconfig
index a0506a54a4f3f..3897e924e40f2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -581,6 +581,7 @@ config COMPACTION
 
 config COMPACT_UNEVICTABLE_DEFAULT
 	int
+	depends on COMPACTION
 	default 0 if PREEMPT_RT
 	default 1
 
diff --git a/mm/slub.c b/mm/slub.c
index 5f7c5b5bd49f9..a738020a60faf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -50,7 +50,7 @@
  *   1. slab_mutex (Global Mutex)
  *   2. node->list_lock (Spinlock)
  *   3. kmem_cache->cpu_slab->lock (Local lock)
- *   4. slab_lock(slab) (Only on some arches or for debugging)
+ *   4. slab_lock(slab) (Only on some arches)
  *   5. object_map_lock (Only for debugging)
  *
  *   slab_mutex
@@ -64,8 +64,9 @@
  *   The slab_lock is a wrapper around the page lock, thus it is a bit
  *   spinlock.
  *
- *   The slab_lock is only used for debugging and on arches that do not
- *   have the ability to do a cmpxchg_double. It only protects:
+ *   The slab_lock is only used on arches that do not have the ability
+ *   to do a cmpxchg_double. It only protects:
+ *
  *	A. slab->freelist	-> List of free objects in a slab
  *	B. slab->inuse		-> Number of objects in use
  *	C. slab->objects	-> Number of objects in slab
@@ -94,6 +95,9 @@
  *   allocating a long series of objects that fill up slabs does not require
  *   the list lock.
  *
+ *   For debug caches, all allocations are forced to go through a list_lock
+ *   protected region to serialize against concurrent validation.
+ *
  *   cpu_slab->lock local lock
  *
  *   This locks protect slowpath manipulation of all kmem_cache_cpu fields
@@ -167,9 +171,7 @@
 #ifndef CONFIG_PREEMPT_RT
 #define slub_get_cpu_ptr(var)		get_cpu_ptr(var)
 #define slub_put_cpu_ptr(var)		put_cpu_ptr(var)
-#define use_lockless_fast_path()	(true)
-#define slub_local_irq_save(flags)	local_irq_save(flags)
-#define slub_local_irq_restore(flags)	local_irq_restore(flags)
+#define USE_LOCKLESS_FAST_PATH()	(true)
 #else
 #define slub_get_cpu_ptr(var)		\
 ({					\
@@ -181,9 +183,7 @@ do {					\
 	(void)(var);			\
 	migrate_enable();		\
 } while (0)
-#define use_lockless_fast_path()	(false)
-#define slub_local_irq_save(flags)	do { } while (0)
-#define slub_local_irq_restore(flags)	do { } while (0)
+#define USE_LOCKLESS_FAST_PATH()	(false)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -450,7 +450,7 @@ slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 /*
  * Per slab locking using the pagelock
  */
-static __always_inline void __slab_lock(struct slab *slab)
+static __always_inline void slab_lock(struct slab *slab)
 {
 	struct page *page = slab_page(slab);
 
@@ -458,7 +458,7 @@ static __always_inline void __slab_lock(struct slab *slab)
 	bit_spin_lock(PG_locked, &page->flags);
 }
 
-static __always_inline void __slab_unlock(struct slab *slab)
+static __always_inline void slab_unlock(struct slab *slab)
 {
 	struct page *page = slab_page(slab);
 
@@ -466,29 +466,19 @@ static __always_inline void __slab_unlock(struct slab *slab)
 	__bit_spin_unlock(PG_locked, &page->flags);
 }
 
-static __always_inline void slab_lock(struct slab *slab, unsigned long *flags)
-{
-	slub_local_irq_save(*flags);
-	__slab_lock(slab);
-}
-
-static __always_inline void slab_unlock(struct slab *slab, unsigned long *flags)
-{
-	__slab_unlock(slab);
-	slub_local_irq_restore(*flags);
-}
-
 /*
  * Interrupts must be disabled (for the fallback code to work right), typically
- * by an _irqsave() lock variant. Except on PREEMPT_RT where locks are different
- * so we disable interrupts as part of slab_[un]lock().
+ * by an _irqsave() lock variant. Except on PREEMPT_RT where these variants do
+ * not actually disable interrupts. On the other hand the migrate_disable()
+ * done by bit_spin_lock() is sufficient on PREEMPT_RT thanks to its threaded
+ * interrupts.
  */
 static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-	if (use_lockless_fast_path())
+	if (USE_LOCKLESS_FAST_PATH())
 		lockdep_assert_irqs_disabled();
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
@@ -500,18 +490,15 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
 	} else
 #endif
 	{
-		/* init to 0 to prevent spurious warnings */
-		unsigned long flags = 0;
-
-		slab_lock(slab, &flags);
+		slab_lock(slab);
 		if (slab->freelist == freelist_old &&
 					slab->counters == counters_old) {
 			slab->freelist = freelist_new;
 			slab->counters = counters_new;
-			slab_unlock(slab, &flags);
+			slab_unlock(slab);
 			return true;
 		}
-		slab_unlock(slab, &flags);
+		slab_unlock(slab);
 	}
 
 	cpu_relax();
@@ -542,16 +529,16 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		__slab_lock(slab);
+		slab_lock(slab);
 		if (slab->freelist == freelist_old &&
 					slab->counters == counters_old) {
 			slab->freelist = freelist_new;
 			slab->counters = counters_new;
-			__slab_unlock(slab);
+			slab_unlock(slab);
 			local_irq_restore(flags);
 			return true;
 		}
-		__slab_unlock(slab);
+		slab_unlock(slab);
 		local_irq_restore(flags);
 	}
 
@@ -567,7 +554,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
 
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
-static DEFINE_RAW_SPINLOCK(object_map_lock);
+static DEFINE_SPINLOCK(object_map_lock);
 
 static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
 		       struct slab *slab)
@@ -601,30 +588,6 @@ static bool slab_add_kunit_errors(void)
 static inline bool slab_add_kunit_errors(void) { return false; }
 #endif
 
-/*
- * Determine a map of objects in use in a slab.
- *
- * Node listlock must be held to guarantee that the slab does
- * not vanish from under us.
- */
-static unsigned long *get_map(struct kmem_cache *s, struct slab *slab)
-	__acquires(&object_map_lock)
-{
-	VM_BUG_ON(!irqs_disabled());
-
-	raw_spin_lock(&object_map_lock);
-
-	__fill_map(object_map, s, slab);
-
-	return object_map;
-}
-
-static void put_map(unsigned long *map) __releases(&object_map_lock)
-{
-	VM_BUG_ON(map != object_map);
-	raw_spin_unlock(&object_map_lock);
-}
-
 static inline unsigned int size_from_object(struct kmem_cache *s)
 {
 	if (s->flags & SLAB_RED_ZONE)
@@ -1330,17 +1293,14 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 }
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
-					struct slab *slab,
-					void *object, unsigned long addr)
+					struct slab *slab, void *object)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
 			goto bad;
 	}
 
-	/* Success perform special debug activities for allocs */
-	if (s->flags & SLAB_STORE_USER)
-		set_track(s, object, TRACK_ALLOC, addr);
+	/* Success. Perform special debug activities for allocs */
 	trace(s, slab, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
@@ -1391,63 +1351,6 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 	return 1;
 }
 
-/* Supports checking bulk free of a constructed freelist */
-static noinline int free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr)
-{
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	void *object = head;
-	int cnt = 0;
-	unsigned long flags, flags2;
-	int ret = 0;
-	depot_stack_handle_t handle = 0;
-
-	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
-
-	spin_lock_irqsave(&n->list_lock, flags);
-	slab_lock(slab, &flags2);
-
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!check_slab(s, slab))
-			goto out;
-	}
-
-next_object:
-	cnt++;
-
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!free_consistency_checks(s, slab, object, addr))
-			goto out;
-	}
-
-	if (s->flags & SLAB_STORE_USER)
-		set_track_update(s, object, TRACK_FREE, addr, handle);
-	trace(s, slab, object, 0);
-	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
-	init_object(s, object, SLUB_RED_INACTIVE);
-
-	/* Reached end of constructed freelist yet? */
-	if (object != tail) {
-		object = get_freepointer(s, object);
-		goto next_object;
-	}
-	ret = 1;
-
-out:
-	if (cnt != bulk_cnt)
-		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
-			 bulk_cnt, cnt);
-
-	slab_unlock(slab, &flags2);
-	spin_unlock_irqrestore(&n->list_lock, flags);
-	if (!ret)
-		slab_fix(s, "Object at 0x%p not freed", object);
-	return ret;
-}
-
 /*
  * Parse a block of slub_debug options. Blocks are delimited by ';'
  *
@@ -1667,16 +1570,18 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, unsigned long addr) { return 0; }
+	struct slab *slab, void *object) { return 0; }
 
-static inline int free_debug_processing(
+static inline void free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,
-	unsigned long addr) { return 0; }
+	unsigned long addr) {}
 
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
+static inline void set_track(struct kmem_cache *s, void *object,
+			     enum track_item alloc, unsigned long addr) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -1982,11 +1887,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 */
 		slab = alloc_slab_page(alloc_gfp, node, oo);
 		if (unlikely(!slab))
-			goto out;
+			return NULL;
 		stat(s, ORDER_FALLBACK);
 	}
 
 	slab->objects = oo_objects(oo);
+	slab->inuse = 0;
+	slab->frozen = 0;
 
 	account_slab(slab, oo_order(oo), s, flags);
 
@@ -2013,15 +1920,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		set_freepointer(s, p, NULL);
 	}
 
-	slab->inuse = slab->objects;
-	slab->frozen = 1;
-
-out:
-	if (!slab)
-		return NULL;
-
-	inc_slabs_node(s, slab_nid(slab), slab->objects);
-
 	return slab;
 }
 
@@ -2108,6 +2006,75 @@ static inline void remove_partial(struct kmem_cache_node *n,
 	n->nr_partial--;
 }
 
+/*
+ * Called only for kmem_cache_debug() caches instead of acquire_slab(), with a
+ * slab from the n->partial list. Remove only a single object from the slab, do
+ * the alloc_debug_processing() checks and leave the slab on the list, or move
+ * it to full list if it was the last free object.
+ */
+static void *alloc_single_from_partial(struct kmem_cache *s,
+		struct kmem_cache_node *n, struct slab *slab)
+{
+	void *object;
+
+	lockdep_assert_held(&n->list_lock);
+
+	object = slab->freelist;
+	slab->freelist = get_freepointer(s, object);
+	slab->inuse++;
+
+	if (!alloc_debug_processing(s, slab, object)) {
+		remove_partial(n, slab);
+		return NULL;
+	}
+
+	if (slab->inuse == slab->objects) {
+		remove_partial(n, slab);
+		add_full(s, n, slab);
+	}
+
+	return object;
+}
+
+/*
+ * Called only for kmem_cache_debug() caches to allocate from a freshly
+ * allocated slab. Allocate a single object instead of whole freelist
+ * and put the slab to the partial (or full) list.
+ */
+static void *alloc_single_from_new_slab(struct kmem_cache *s,
+					struct slab *slab)
+{
+	int nid = slab_nid(slab);
+	struct kmem_cache_node *n = get_node(s, nid);
+	unsigned long flags;
+	void *object;
+
+
+	object = slab->freelist;
+	slab->freelist = get_freepointer(s, object);
+	slab->inuse = 1;
+
+	if (!alloc_debug_processing(s, slab, object))
+		/*
+		 * It's not really expected that this would fail on a
+		 * freshly allocated slab, but a concurrent memory
+		 * corruption in theory could cause that.
+		 */
+		return NULL;
+
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	if (slab->inuse == slab->objects)
+		add_full(s, n, slab);
+	else
+		add_partial(n, slab, DEACTIVATE_TO_HEAD);
+
+	inc_slabs_node(s, nid, slab->objects);
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	return object;
+}
+
 /*
  * Remove slab from the partial list, freeze it and
  * return the pointer to the freelist.
@@ -2188,6 +2155,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		if (!pfmemalloc_match(slab, gfpflags))
 			continue;
 
+		if (kmem_cache_debug(s)) {
+			object = alloc_single_from_partial(s, n, slab);
+			if (object)
+				break;
+			continue;
+		}
+
 		t = acquire_slab(s, n, slab, object == NULL);
 		if (!t)
 			break;
@@ -2794,6 +2768,109 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 {
 	return atomic_long_read(&n->total_objects);
 }
+
+/* Supports checking bulk free of a constructed freelist */
+static noinline void free_debug_processing(
+	struct kmem_cache *s, struct slab *slab,
+	void *head, void *tail, int bulk_cnt,
+	unsigned long addr)
+{
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
+	struct slab *slab_free = NULL;
+	void *object = head;
+	int cnt = 0;
+	unsigned long flags;
+	bool checks_ok = false;
+	depot_stack_handle_t handle = 0;
+
+	if (s->flags & SLAB_STORE_USER)
+		handle = set_track_prepare();
+
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+		if (!check_slab(s, slab))
+			goto out;
+	}
+
+	if (slab->inuse < bulk_cnt) {
+		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
+			 slab->inuse, bulk_cnt);
+		goto out;
+	}
+
+next_object:
+
+	if (++cnt > bulk_cnt)
+		goto out_cnt;
+
+	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+		if (!free_consistency_checks(s, slab, object, addr))
+			goto out;
+	}
+
+	if (s->flags & SLAB_STORE_USER)
+		set_track_update(s, object, TRACK_FREE, addr, handle);
+	trace(s, slab, object, 0);
+	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
+	init_object(s, object, SLUB_RED_INACTIVE);
+
+	/* Reached end of constructed freelist yet? */
+	if (object != tail) {
+		object = get_freepointer(s, object);
+		goto next_object;
+	}
+	checks_ok = true;
+
+out_cnt:
+	if (cnt != bulk_cnt)
+		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
+			 bulk_cnt, cnt);
+
+out:
+	if (checks_ok) {
+		void *prior = slab->freelist;
+
+		/* Perform the actual freeing while we still hold the locks */
+		slab->inuse -= cnt;
+		set_freepointer(s, tail, prior);
+		slab->freelist = head;
+
+		/* Do we need to remove the slab from full or partial list? */
+		if (!prior) {
+			remove_full(s, n, slab);
+		} else if (slab->inuse == 0) {
+			remove_partial(n, slab);
+			stat(s, FREE_REMOVE_PARTIAL);
+		}
+
+		/* Do we need to discard the slab or add to partial list? */
+		if (slab->inuse == 0) {
+			slab_free = slab;
+		} else if (!prior) {
+			add_partial(n, slab, DEACTIVATE_TO_TAIL);
+			stat(s, FREE_ADD_PARTIAL);
+		}
+	}
+
+	if (slab_free) {
+		/*
+		 * Update the counters while still holding n->list_lock to
+		 * prevent spurious validation warnings
+		 */
+		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
+	}
+
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	if (!checks_ok)
+		slab_fix(s, "Object at 0x%p not freed", object);
+
+	if (slab_free) {
+		stat(s, FREE_SLAB);
+		free_slab(s, slab_free);
+	}
+}
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
@@ -3042,36 +3119,52 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
+	stat(s, ALLOC_SLAB);
+
+	if (kmem_cache_debug(s)) {
+		freelist = alloc_single_from_new_slab(s, slab);
+
+		if (unlikely(!freelist))
+			goto new_objects;
+
+		if (s->flags & SLAB_STORE_USER)
+			set_track(s, freelist, TRACK_ALLOC, addr);
+
+		return freelist;
+	}
+
 	/*
 	 * No other reference to the slab yet so we can
 	 * muck around with it freely without cmpxchg
 	 */
 	freelist = slab->freelist;
 	slab->freelist = NULL;
+	slab->inuse = slab->objects;
+	slab->frozen = 1;
 
-	stat(s, ALLOC_SLAB);
+	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
 check_new_slab:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, slab, freelist, addr)) {
-			/* Slab failed checks. Next slab needed */
-			goto new_slab;
-		} else {
-			/*
-			 * For debug case, we don't load freelist so that all
-			 * allocations go through alloc_debug_processing()
-			 */
-			goto return_single;
-		}
+		/*
+		 * For debug caches here we had to go through
+		 * alloc_single_from_partial() so just store the tracking info
+		 * and return the object
+		 */
+		if (s->flags & SLAB_STORE_USER)
+			set_track(s, freelist, TRACK_ALLOC, addr);
+		return freelist;
 	}
 
-	if (unlikely(!pfmemalloc_match(slab, gfpflags)))
+	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
 		 * we don't make further mismatched allocations easier.
 		 */
-		goto return_single;
+		deactivate_slab(s, slab, get_freepointer(s, freelist));
+		return freelist;
+	}
 
 retry_load_slab:
 
@@ -3095,11 +3188,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c->slab = slab;
 
 	goto load_freelist;
-
-return_single:
-
-	deactivate_slab(s, slab, get_freepointer(s, freelist));
-	return freelist;
 }
 
 /*
@@ -3204,7 +3292,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	object = c->freelist;
 	slab = c->slab;
 
-	if (!use_lockless_fast_path() ||
+	if (!USE_LOCKLESS_FAST_PATH() ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c);
 	} else {
@@ -3341,9 +3429,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	if (kfence_free(head))
 		return;
 
-	if (kmem_cache_debug(s) &&
-	    !free_debug_processing(s, slab, head, tail, cnt, addr))
+	if (kmem_cache_debug(s)) {
+		free_debug_processing(s, slab, head, tail, cnt, addr);
 		return;
+	}
 
 	do {
 		if (unlikely(n)) {
@@ -3483,7 +3572,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 		return;
 	}
 
-	if (use_lockless_fast_path()) {
+	if (USE_LOCKLESS_FAST_PATH()) {
 		freelist = READ_ONCE(c->freelist);
 
 		set_freepointer(s, tail_obj, freelist);
@@ -3930,6 +4019,7 @@ static void early_kmem_cache_node_alloc(int node)
 	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
 
 	BUG_ON(!slab);
+	inc_slabs_node(kmem_cache_node, slab_nid(slab), slab->objects);
 	if (slab_nid(slab) != node) {
 		pr_err("SLUB: Unable to allocate memory from node %d\n", node);
 		pr_err("SLUB: Allocating a useless per node structure in order to be able to continue\n");
@@ -3944,7 +4034,6 @@ static void early_kmem_cache_node_alloc(int node)
 	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
-	slab->frozen = 0;
 	kmem_cache_node->node[node] = n;
 	init_kmem_cache_node(n);
 	inc_slabs_node(kmem_cache_node, node, slab->objects);
@@ -4231,23 +4320,21 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = slab_address(slab);
-	unsigned long flags;
-	unsigned long *map;
 	void *p;
 
 	slab_err(s, slab, text, s->name);
-	slab_lock(slab, &flags);
 
-	map = get_map(s, slab);
+	spin_lock(&object_map_lock);
+	__fill_map(object_map, s, slab);
+
 	for_each_object(p, s, addr, slab->objects) {
 
-		if (!test_bit(__obj_to_index(s, addr, p), map)) {
+		if (!test_bit(__obj_to_index(s, addr, p), object_map)) {
 			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
 	}
-	put_map(map);
-	slab_unlock(slab, &flags);
+	spin_unlock(&object_map_lock);
 #endif
 }
 
@@ -4605,6 +4692,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 			if (free == slab->objects) {
 				list_move(&slab->slab_list, &discard);
 				n->nr_partial--;
+				dec_slabs_node(s, node, slab->objects);
 			} else if (free <= SHRINK_PROMOTE_MAX)
 				list_move(&slab->slab_list, promote + free - 1);
 		}
@@ -4620,7 +4708,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 
 		/* Release empty slabs */
 		list_for_each_entry_safe(slab, t, &discard, slab_list)
-			discard_slab(s, slab);
+			free_slab(s, slab);
 
 		if (slabs_node(s, node))
 			ret = 1;
@@ -4974,12 +5062,9 @@ static void validate_slab(struct kmem_cache *s, struct slab *slab,
 {
 	void *p;
 	void *addr = slab_address(slab);
-	unsigned long flags;
-
-	slab_lock(slab, &flags);
 
 	if (!check_slab(s, slab) || !on_freelist(s, slab, NULL))
-		goto unlock;
+		return;
 
 	/* Now we know that a valid freelist exists */
 	__fill_map(obj_map, s, slab);
@@ -4990,8 +5075,6 @@ static void validate_slab(struct kmem_cache *s, struct slab *slab,
 		if (!check_object(s, slab, p, val))
 			break;
 	}
-unlock:
-	slab_unlock(slab, &flags);
 }
 
 static int validate_slab_node(struct kmem_cache *s,
@@ -5595,7 +5678,7 @@ static ssize_t validate_store(struct kmem_cache *s,
 {
 	int ret = -EINVAL;
 
-	if (buf[0] == '1') {
+	if (buf[0] == '1' && kmem_cache_debug(s)) {
 		ret = validate_slab_cache(s);
 		if (ret >= 0)
 			ret = length;
