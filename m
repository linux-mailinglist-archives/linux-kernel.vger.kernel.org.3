Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1232F472C53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhLMMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhLMMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:32:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C6C061574;
        Mon, 13 Dec 2021 04:32:43 -0800 (PST)
Date:   Mon, 13 Dec 2021 13:32:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639398761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=F4+FlvEzRVslF1whkfwXHyEJnnuvAyLGfSmqr2OhHAo=;
        b=VsUMwBijyH8wTz1aBubNVUnz4oTPduJTOK7TC1bcvIGpO3q3sZogvk3Ij8H9DRewEG0L9O
        CXfpYzH17LGeIzd9iuWalogl10WTxtC/rF/539Dl0V7/mmhTgGgCeIgk5Bf/mgyALuoip+
        A8u2O/ARPESh0R9rBdsyAh8rys0uIjvs1lUo2sLVqigV0WemgucnF9Vq6AVGqJDnwB4SVC
        vRj9OBdtniBqYXB+Efgsf7dze8QsgG1i1swxSvUTUybbqgLJZl4KmiysQKy82gsQV5/SsA
        CXroZcKjY1qpFkwBFwjhYNbYgnH2JOrEuiAtCEWcI9TzArJFfbikW/Nw5eNa4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639398761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=F4+FlvEzRVslF1whkfwXHyEJnnuvAyLGfSmqr2OhHAo=;
        b=69f9kpzzv5dc8qURpfQOXIM+FoPKecTWom8Eqf0+d2yBLNc5WdBweQijqLQ6cV5TtMMJvT
        /Bh8UTpN63ANqEBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rc5-rt10
Message-ID: <Ybc9ZyKbxTkBpyc0@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rc5-rt10 patch set. 

Changes since v5.16-rc5-rt9:

  - Redo add_interrupt_randomness() handling on PREEMPT_RT.

  - Cosmetic changes to "u64_stats".

  - Cosmetic changes to how busylock is acquired in __dev_xmit_skb().

  - Cosmetic changes to one i915 patch.

  - The random oops_id has been replaced by 0.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16-rc5-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16-rc5-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rc5-rt10

The RT patch against v5.16-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rc5-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rc5-rt10.tar.xz

Sebastian

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 896986c8c01de..2a0f836789118 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -75,12 +75,11 @@ void hv_remove_vmbus_handler(void)
 DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_stimer0)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	u64 ip = regs ? instruction_pointer(regs) : 0;
 
 	inc_irq_stat(hyperv_stimer0_count);
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
-	add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0, ip);
+	add_interrupt_randomness(HYPERV_STIMER0_VECTOR);
 	ack_APIC_irq();
 
 	set_irq_regs(old_regs);
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 56b2d5a7e2a07..12fad0c2e61ff 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -200,7 +200,7 @@
  *	void add_device_randomness(const void *buf, unsigned int size);
  * 	void add_input_randomness(unsigned int type, unsigned int code,
  *                                unsigned int value);
- *	void add_interrupt_randomness(int irq, int irq_flags);
+ *	void add_interrupt_randomness(int irq);
  * 	void add_disk_randomness(struct gendisk *disk);
  *
  * add_device_randomness() is for adding data to the random pool that
@@ -1242,55 +1242,97 @@ static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
-void add_interrupt_randomness(int irq, int irq_flags, __u64 ip)
+static bool process_interrupt_randomness_pool(struct fast_pool *fast_pool)
 {
 	struct entropy_store	*r;
+
+	if (unlikely(crng_init == 0)) {
+		bool pool_reset = false;
+
+		if ((fast_pool->count >= 64) &&
+		    crng_fast_load((char *) fast_pool->pool,
+				   sizeof(fast_pool->pool)))
+			pool_reset = true;
+
+		return pool_reset;
+	}
+
+	if ((fast_pool->count < 64) &&
+	    !time_after(jiffies, fast_pool->last + HZ))
+		return false;
+
+	r = &input_pool;
+	if (!spin_trylock(&r->lock))
+		return false;
+
+	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
+	spin_unlock(&r->lock);
+
+	/* award one bit for the contents of the fast pool */
+	credit_entropy_bits(r, 1);
+	return true;
+}
+
+#ifdef CONFIG_PREEMPT_RT
+void process_interrupt_randomness(void)
+{
+	struct fast_pool *cpu_pool;
+	struct fast_pool fast_pool;
+
+	lockdep_assert_irqs_enabled();
+
+	migrate_disable();
+	cpu_pool = this_cpu_ptr(&irq_randomness);
+
+	local_irq_disable();
+	memcpy(&fast_pool, cpu_pool, sizeof(fast_pool));
+	local_irq_enable();
+
+	if (process_interrupt_randomness_pool(&fast_pool)) {
+		local_irq_disable();
+		cpu_pool->last = jiffies;
+		cpu_pool->count = 0;
+		local_irq_enable();
+	}
+	memzero_explicit(&fast_pool, sizeof(fast_pool));
+	migrate_enable();
+}
+#endif
+
+void add_interrupt_randomness(int irq)
+{
 	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
+	struct pt_regs		*regs = get_irq_regs();
 	unsigned long		now = jiffies;
 	cycles_t		cycles = random_get_entropy();
 	__u32			c_high, j_high;
+	__u64			ip;
 
 	if (cycles == 0)
-		cycles = get_reg(fast_pool, NULL);
+		cycles = get_reg(fast_pool, regs);
 	c_high = (sizeof(cycles) > 4) ? cycles >> 32 : 0;
 	j_high = (sizeof(now) > 4) ? now >> 32 : 0;
 	fast_pool->pool[0] ^= cycles ^ j_high ^ irq;
 	fast_pool->pool[1] ^= now ^ c_high;
-	if (!ip)
-		ip = _RET_IP_;
+	ip = regs ? instruction_pointer(regs) : _RET_IP_;
 	fast_pool->pool[2] ^= ip;
 	fast_pool->pool[3] ^= (sizeof(ip) > 4) ? ip >> 32 :
-		get_reg(fast_pool, NULL);
+		get_reg(fast_pool, regs);
 
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	if (unlikely(crng_init == 0)) {
-		if ((fast_pool->count >= 64) &&
-		    crng_fast_load((char *) fast_pool->pool,
-				   sizeof(fast_pool->pool))) {
-			fast_pool->count = 0;
+	/*
+	 * On PREEMPT_RT the entropy can not be fed into the input_pool because
+	 * it needs to acquire sleeping locks with disabled interrupts.
+	 * This is deferred to the threaded handler.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (process_interrupt_randomness_pool(fast_pool)) {
 			fast_pool->last = now;
+			fast_pool->count = 0;
 		}
-		return;
 	}
-
-	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
-		return;
-
-	r = &input_pool;
-	if (!spin_trylock(&r->lock))
-		return;
-
-	fast_pool->last = now;
-	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
-	spin_unlock(&r->lock);
-
-	fast_pool->count = 0;
-
-	/* award one bit for the contents of the fast pool */
-	credit_entropy_bits(r, 1);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
index 8a575629ef1b6..d8c74bbf9aae2 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.h
+++ b/drivers/gpu/drm/i915/gt/intel_context.h
@@ -212,7 +212,7 @@ static inline void intel_context_enter(struct intel_context *ce)
 static inline void intel_context_mark_active(struct intel_context *ce)
 {
 	lockdep_assert(lockdep_is_held(&ce->timeline->mutex) ||
-		       test_bit(CONTEXT_IS_PARKED, &ce->flags));
+		       test_bit(CONTEXT_IS_PARKING, &ce->flags));
 	++ce->active_count;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
index 329f470d125f2..30cd81ad8911a 100644
--- a/drivers/gpu/drm/i915/gt/intel_context_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
@@ -118,7 +118,7 @@ struct intel_context {
 #define CONTEXT_LRCA_DIRTY		9
 #define CONTEXT_GUC_INIT		10
 #define CONTEXT_PERMA_PIN		11
-#define CONTEXT_IS_PARKED		12
+#define CONTEXT_IS_PARKING		12
 
 	struct {
 		u64 timeout_us;
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index 456f1f5d0c04e..a8a2ad44b7e39 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -180,7 +180,7 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 	 * engine->wakeref.count, we may see the request completion and retire
 	 * it causing an underflow of the engine->wakeref.
 	 */
-	set_bit(CONTEXT_IS_PARKED, &ce->flags);
+	set_bit(CONTEXT_IS_PARKING, &ce->flags);
 	GEM_BUG_ON(atomic_read(&ce->timeline->active_count) < 0);
 
 	rq = __i915_request_create(ce, GFP_NOWAIT);
@@ -212,7 +212,7 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 
 	result = false;
 out_unlock:
-	clear_bit(CONTEXT_IS_PARKED, &ce->flags);
+	clear_bit(CONTEXT_IS_PARKING, &ce->flags);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index c5898882bb27a..b7fe67405fd32 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -643,7 +643,7 @@ i915_request_timeline(const struct i915_request *rq)
 	/* Valid only while the request is being constructed (or retired). */
 	return rcu_dereference_protected(rq->timeline,
 					 lockdep_is_held(&rcu_access_pointer(rq->timeline)->mutex) ||
-					 test_bit(CONTEXT_IS_PARKED, &rq->context->flags));
+					 test_bit(CONTEXT_IS_PARKING, &rq->context->flags));
 }
 
 static inline struct i915_gem_context *
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 7be17d52eaaea..3a1f007b678a0 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -19,7 +19,6 @@
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 
 #include "hv_trace.h"
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c5e9725fb5ff2..7ae04ccb10438 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -22,7 +22,6 @@
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
-#include <linux/irq.h>
 
 #include <linux/delay.h>
 #include <linux/notifier.h>
@@ -1338,8 +1337,6 @@ static void vmbus_isr(void)
 	void *page_addr = hv_cpu->synic_event_page;
 	struct hv_message *msg;
 	union hv_synic_event_flags *event;
-	struct pt_regs *regs = get_irq_regs();
-	u64 ip = regs ? instruction_pointer(regs) : 0;
 	bool handled = false;
 
 	if (unlikely(page_addr == NULL))
@@ -1384,7 +1381,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
-	add_interrupt_randomness(vmbus_interrupt, 0, ip);
+	add_interrupt_randomness(vmbus_interrupt);
 }
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 5cf06e8287d57..93d270ca0c567 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -68,7 +68,6 @@ struct irq_desc {
 	unsigned int		irqs_unhandled;
 	atomic_t		threads_handled;
 	int			threads_handled_last;
-	u64			random_ip;
 	raw_spinlock_t		lock;
 	struct cpumask		*percpu_enabled;
 	const struct cpumask	*percpu_affinity;
diff --git a/include/linux/random.h b/include/linux/random.h
index 0e41d05278091..a02c285a5ee52 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -35,7 +35,8 @@ static inline void add_latent_entropy(void) {}
 
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
-extern void add_interrupt_randomness(int irq, int irq_flags, __u64 ip) __latent_entropy;
+extern void add_interrupt_randomness(int irq) __latent_entropy;
+extern void process_interrupt_randomness(void);
 
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 81dc1f5e181ac..6ad4e9032d538 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -66,7 +66,7 @@
 #include <linux/seqlock.h>
 
 struct u64_stats_sync {
-#if BITS_PER_LONG==32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	seqcount_t	seq;
 #endif
 };
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f895265d75487..c093246630882 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -575,8 +575,6 @@ EXPORT_SYMBOL_GPL(handle_simple_irq);
  */
 void handle_untracked_irq(struct irq_desc *desc)
 {
-	unsigned int flags = 0;
-
 	raw_spin_lock(&desc->lock);
 
 	if (!irq_may_run(desc))
@@ -593,7 +591,7 @@ void handle_untracked_irq(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock(&desc->lock);
 
-	__handle_irq_event_percpu(desc, &flags);
+	__handle_irq_event_percpu(desc);
 
 	raw_spin_lock(&desc->lock);
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index a86a503b2a11a..9489f93b3db34 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -136,7 +136,7 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
-irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags)
+irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval = IRQ_NONE;
 	unsigned int irq = desc->irq_data.irq;
@@ -174,10 +174,6 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 			}
 
 			__irq_wake_thread(desc, action);
-
-			fallthrough;	/* to add to randomness */
-		case IRQ_HANDLED:
-			*flags |= action->flags;
 			break;
 
 		default:
@@ -192,18 +188,11 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 {
-	struct pt_regs *regs = get_irq_regs();
-	u64 ip = regs ? instruction_pointer(regs) : 0;
-	unsigned int flags = 0;
 	irqreturn_t retval;
 
-	retval = __handle_irq_event_percpu(desc, &flags);
+	retval = __handle_irq_event_percpu(desc);
 
-#ifdef CONFIG_PREEMPT_RT
-	desc->random_ip = ip;
-#else
-	add_interrupt_randomness(desc->irq_data.irq, flags, ip);
-#endif
+	add_interrupt_randomness(desc->irq_data.irq);
 
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, retval);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 54363527feea4..99cbdf55a8bda 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -103,7 +103,7 @@ extern int __irq_get_irqchip_state(struct irq_data *data,
 
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 
-irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags);
+irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 894e4db1fffcc..d641de1f879f4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1281,12 +1281,9 @@ static int irq_thread(void *data)
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			migrate_disable();
-			add_interrupt_randomness(action->irq, 0,
-				 desc->random_ip ^ (unsigned long) action);
-			migrate_enable();
-		}
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			process_interrupt_randomness();
+
 		wake_threads_waitq(desc);
 	}
 
diff --git a/kernel/panic.c b/kernel/panic.c
index d509c0694af95..f4c7c77595bd2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -538,28 +538,9 @@ void oops_enter(void)
 		trigger_all_cpu_backtrace();
 }
 
-/*
- * 64-bit random ID for oopses:
- */
-static u64 oops_id;
-
-static int init_oops_id(void)
-{
-#ifndef CONFIG_PREEMPT_RT
-	if (!oops_id)
-		get_random_bytes(&oops_id, sizeof(oops_id));
-	else
-#endif
-		oops_id++;
-
-	return 0;
-}
-late_initcall(init_oops_id);
-
 static void print_oops_end_marker(void)
 {
-	init_oops_id();
-	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
+	pr_warn("---[ end trace %016llx ]---\n", 0ULL);
 	pr_flush(1000, true);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
diff --git a/net/core/dev.c b/net/core/dev.c
index 6cdb416c6ff4b..0179312d11c43 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3838,12 +3838,12 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	 * separate lock before trying to get qdisc main lock.
 	 * This permits qdisc->running owner to get the lock more
 	 * often and dequeue packets faster.
+	 * On PREEMPT_RT it is possible to preempt the qdisc owner during xmit
+	 * and then other tasks will only enqueue packets. The packets will be
+	 * sent after the qdisc owner is scheduled again. To prevent this
+	 * scenario the task always serialize on the lock.
 	 */
-#ifdef CONFIG_PREEMPT_RT
-	contended = true;
-#else
-	contended = qdisc_is_running(q);
-#endif
+	contended = IS_ENABLED(CONFIG_PREEMPT_RT) || qdisc_is_running(q);
 	if (unlikely(contended))
 		spin_lock(&q->busylock);
 
