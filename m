Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04F4B1768
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbiBJVFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:05:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiBJVFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:05:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740F42634;
        Thu, 10 Feb 2022 13:05:20 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644527116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=O6xK7iu3facsI/Ueqbgt/rxq0zo/SXZ7KKlOA08fHOU=;
        b=YpiLOQFuDIDODmGtHsQtxC4vD16j6xpjxYx/GW/GXfmvAjyPgSERuBETcHIKut0D/tWpje
        fXrxRu3KHS22c0Q08MafgksmFx+Vlf/Iata5I1ZerhFcQWrErlNBoJB9mMI4T9atx+/0Fh
        HmvVQmqxLs+RL9Le6tt0DnVDBqnfOAqYbkA4itccJHJVYRYvxrQVIRZTC+CiZ9gAuYijFk
        FkB2ZfvatN7mSF1gMOty74455aQikTdzusrW9qyQBQd28ryBv4suXyUddt/mIJm/XP1WzP
        fee5aTIdAA7wVUxeS1BOk0ZrOog6Qi+oFgZ5d3TQ0JFkuH6a9HTw02e8nCy6mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644527116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=O6xK7iu3facsI/Ueqbgt/rxq0zo/SXZ7KKlOA08fHOU=;
        b=yo6L5kKCTC8Vxc21WV8V59hzR6Qu2ZFHzStCZbNgFQvkEtzi6bBb2cmd7GpF3mYnyVrqLs
        YWAlihtFhLxS1pAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc3-rt6
Message-ID: <YgV+CykurNN1n9bz@linutronix.de>
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

I'm pleased to announce the v5.17-rc3-rt6 patch set. 

Changes since v5.17-rc3-rt5:

  - Update John's printk series. It supports now direct printing from
    irqwork.

  - Correct atomic access to a variable in printk. Patch by John Ogness.

  - Add a warning if there is a ksoftirqd wakeup from idle.

  - Jason A. Donenfeld patches against the random subsystem were updated
    to v4. There is an additional RT related change on top.

  - The known issue
      netconsole triggers WARN.
    has been removed from the list since it also triggers with
    CONFIG_PREEMPT and v5.17-rc3 (without the PREEMPT_RT patch).

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17-rc3-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17-rc3-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc3-rt6

The RT patch against v5.17-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc3-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc3-rt6.tar.xz

Sebastian

diff --git a/drivers/char/random.c b/drivers/char/random.c
index afcedefb0c1c8..e4bde9c917654 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -404,7 +404,7 @@ struct fast_pool {
 	struct work_struct mix;
 	unsigned long last;
 	u32 pool[4];
-	atomic_t count;
+	unsigned int count;
 	u16 reg_idx;
 };
 #define FAST_POOL_MIX_INFLIGHT (1U << 31)
@@ -1045,25 +1045,33 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 static void mix_interrupt_randomness(struct work_struct *work)
 {
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+	u8 pool[sizeof(fast_pool->pool)];
 
-	fast_pool->last = jiffies;
+	if (unlikely(crng_init == 0)) {
+		size_t ret;
 
-	/* Since this is the result of a trip through the scheduler, xor in
+		ret = crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool));
+		if (ret) {
+			WRITE_ONCE(fast_pool->count, 0);
+			fast_pool->last = jiffies;
+			return;
+		}
+	}
+
+	/*
+	 * Since this is the result of a trip through the scheduler, xor in
 	 * a cycle counter. It can't hurt, and might help.
 	 */
 	fast_pool->pool[3] ^= random_get_entropy();
+	/* Copy the pool to the stack so that the mixer always has a consistent view. */
+	memcpy(pool, fast_pool->pool, sizeof(pool));
+	/* We take care to zero out the count only after we're done reading the pool. */
+	WRITE_ONCE(fast_pool->count, 0);
+	fast_pool->last = jiffies;
 
-	if (unlikely(crng_init == 0)) {
-		if (crng_fast_load((u8 *)&fast_pool->pool, sizeof(fast_pool->pool)) > 0)
-			atomic_set(&fast_pool->count, 0);
-		else
-			atomic_and(~FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
-		return;
-	}
-
-	mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
-	atomic_set(&fast_pool->count, 0);
+	mix_pool_bytes(pool, sizeof(pool));
 	credit_entropy_bits(1);
+	memzero_explicit(pool, sizeof(pool));
 }
 
 void add_interrupt_randomness(int irq)
@@ -1089,15 +1097,33 @@ void add_interrupt_randomness(int irq)
 
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
+	new_count = ++fast_pool->count;
 
-	new_count = (unsigned int)atomic_inc_return(&fast_pool->count);
-	if (new_count >= 64 && new_count < FAST_POOL_MIX_INFLIGHT &&
-	    (time_after(now, fast_pool->last + HZ) || unlikely(crng_init == 0))) {
+	if (unlikely(crng_init == 0)) {
+		if (new_count & FAST_POOL_MIX_INFLIGHT)
+			return;
+
+		if (new_count < 64)
+			return;
+
+		fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
 		if (unlikely(!fast_pool->mix.func))
 			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-		atomic_or(FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
-		schedule_work(&fast_pool->mix);
+		queue_work_on(raw_smp_processor_id(), system_highpri_wq,
+			      &fast_pool->mix);
+		return;
 	}
+
+	if (new_count & FAST_POOL_MIX_INFLIGHT)
+		return;
+
+	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
+		return;
+
+	if (unlikely(!fast_pool->mix.func))
+		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
+	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
@@ -1881,13 +1907,16 @@ static int __init random_sysctls_init(void)
 device_initcall(random_sysctls_init);
 #endif	/* CONFIG_SYSCTL */
 
+static atomic_t batch_generation = ATOMIC_INIT(0);
+
 struct batched_entropy {
 	union {
 		u64 entropy_u64[CHACHA_BLOCK_SIZE / sizeof(u64)];
 		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
 	};
+	local_lock_t lock;
 	unsigned int position;
-	spinlock_t batch_lock;
+	int generation;
 };
 
 /*
@@ -1899,7 +1928,7 @@ struct batched_entropy {
  * point prior.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.batch_lock = __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
 };
 
 u64 get_random_u64(void)
@@ -1908,67 +1937,65 @@ u64 get_random_u64(void)
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
+	int next_gen;
 
 	warn_unseeded_randomness(&previous);
 
+	local_lock_irqsave(&batched_entropy_u64.lock, flags);
 	batch = raw_cpu_ptr(&batched_entropy_u64);
-	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
+
+	next_gen = atomic_read(&batch_generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
+	    next_gen != batch->generation) {
 		extract_crng((u8 *)batch->entropy_u64);
 		batch->position = 0;
+		batch->generation = next_gen;
 	}
+
 	ret = batch->entropy_u64[batch->position++];
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
 
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.batch_lock = __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock)
 };
+
 u32 get_random_u32(void)
 {
 	u32 ret;
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
+	int next_gen;
 
 	warn_unseeded_randomness(&previous);
 
+	local_lock_irqsave(&batched_entropy_u32.lock, flags);
 	batch = raw_cpu_ptr(&batched_entropy_u32);
-	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
+
+	next_gen = atomic_read(&batch_generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
+	    next_gen != batch->generation) {
 		extract_crng((u8 *)batch->entropy_u32);
 		batch->position = 0;
+		batch->generation = next_gen;
 	}
+
 	ret = batch->entropy_u32[batch->position++];
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
 
 /* It's important to invalidate all potential batched entropy that might
  * be stored before the crng is initialized, which we can do lazily by
- * simply resetting the counter to zero so that it's re-extracted on the
- * next usage. */
+ * bumping the generation counter.
+ */
 static void invalidate_batched_entropy(void)
 {
-	int cpu;
-	unsigned long flags;
-
-	for_each_possible_cpu(cpu) {
-		struct batched_entropy *batched_entropy;
-
-		batched_entropy = per_cpu_ptr(&batched_entropy_u32, cpu);
-		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
-		batched_entropy->position = 0;
-		spin_unlock(&batched_entropy->batch_lock);
-
-		batched_entropy = per_cpu_ptr(&batched_entropy_u64, cpu);
-		spin_lock(&batched_entropy->batch_lock);
-		batched_entropy->position = 0;
-		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
-	}
+	atomic_inc(&batch_generation);
 }
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3bef5100312ea..ea55bda735dce 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -404,7 +404,7 @@ static atomic_t printk_direct = ATOMIC_INIT(0);
 
 /**
  * printk_direct_enter - cause console printing to occur in the context of
- * 	printk() callers
+ *                       printk() callers
  *
  * This globally effects all printk() callers.
  *
@@ -2451,7 +2451,9 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_driver(struct console *con, const char *text, size_t len,
-				char *dropped_text, bool atomic_printing) {}
+				char *dropped_text, bool atomic_printing)
+{
+}
 static bool suppress_message_printing(int level) { return false; }
 static void printk_delay(int level) {}
 static void start_printk_kthread(struct console *con) {}
@@ -2878,7 +2880,7 @@ static void write_console_seq(struct console *con, u64 val, bool atomic_printing
  * CONSOLE_EXT_LOG_MAX. Otherwise @ext_text must be NULL.
  *
  * If dropped messages should be printed, @dropped_text is a buffer of size
- * DROPPED_TEXT_MAX. Otherise @dropped_text must be NULL.
+ * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
  *
  * @atomic_printing specifies if atomic printing should be used.
  *
@@ -3873,6 +3875,7 @@ static void start_printk_kthread(struct console *con)
  */
 #define PRINTK_PENDING_WAKEUP	0x01
 #define PRINTK_PENDING_OUTPUT	0x02
+#define PRINTK_DIRECT_OUTPUT	0x04
 
 static DEFINE_PER_CPU(int, printk_pending);
 
@@ -3881,9 +3884,15 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = __this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
+		if (pending & PRINTK_DIRECT_OUTPUT)
+			printk_direct_enter();
+
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
+
+		if (pending & PRINTK_DIRECT_OUTPUT)
+			printk_direct_exit();
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -3908,11 +3917,16 @@ void wake_up_klogd(void)
 
 void defer_console_output(void)
 {
+	int val = PRINTK_PENDING_OUTPUT;
+
 	if (!printk_percpu_data_ready())
 		return;
 
+	if (atomic_read(&printk_direct))
+		val |= PRINTK_DIRECT_OUTPUT;
+
 	preempt_disable();
-	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	this_cpu_or(printk_pending, val);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
 }
diff --git a/kernel/smp.c b/kernel/smp.c
index 250311c2009fe..40deb5c7ef6e2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -690,21 +690,26 @@ void flush_smp_call_function_from_idle(void)
 
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
-
 	local_irq_save(flags);
-	flush_smp_call_function_queue(true);
-
-	if (local_softirq_pending()) {
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		flush_smp_call_function_queue(true);
+		if (local_softirq_pending())
 			do_softirq();
-		} else {
+	} else {
+		unsigned int pending_prev;
+		unsigned int pending_post;
+
+		pending_prev = local_softirq_pending();
+		flush_smp_call_function_queue(true);
+		pending_post = local_softirq_pending();
+
+		if (WARN_ON_ONCE(!pending_prev && pending_post)) {
 			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
 
 			if (ksoftirqd && !task_is_running(ksoftirqd))
 				wake_up_process(ksoftirqd);
 		}
 	}
-
 	local_irq_restore(flags);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
