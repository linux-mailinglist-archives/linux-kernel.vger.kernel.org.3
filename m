Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE244BA019
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiBQM16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:27:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbiBQM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:27:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90715D385;
        Thu, 17 Feb 2022 04:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90F39B82192;
        Thu, 17 Feb 2022 12:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E0FC340E8;
        Thu, 17 Feb 2022 12:27:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T6lvv2T2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645100856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9J3BiacDFCAMtTBZmhHewWpC8DvQ0FQdMpPMLMP29s0=;
        b=T6lvv2T2zHS/1F7eJXOCVsYMrB9C9ykx05zGtQkW1ic2418b30YQ4Ghafet/oCR8QMPXM6
        USmnXqsXmHYqfYYzE2wjz9N/lobg/KaDV+cjWTW9j3CIpF3bFWOW40tHTH/rlvHUvS8eoB
        yog0fyLQv63c+XpsR0Oyg2BLaxKXZwo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 94517747 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 17 Feb 2022 12:27:36 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     bigeasy@linutronix.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v5] random: clear fast pool, crng, and batches in cpuhp bring up
Date:   Thu, 17 Feb 2022 13:27:29 +0100
Message-Id: <20220217122729.227908-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the irq randomness fast pool, rather than having to use expensive
atomics, which were visibly the most expensive thing in the entire irq
handler, simply take care of the extreme edge case of resetting count to
zero in the cpuhp online handler, just after workqueues have been
reenabled. This simplifies the code a bit and lets us use vanilla
variables rather than atomics, and performance should be improved.

As well, very early on when the CPU comes up, while interrupts are still
disabled, we clear out the per-cpu crng and its batches, so that it
always starts with fresh randomness.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - this v5 finally follows your suggestion about what
operations to do at which phase. The only deviation from your exact
suggestion is that I'm not checking for MIX_INFLIGHT in the online
handler, and instead just unconditionally zero it out. I think that's an
acceptable tradeoff to make for simplicity, and it just means we'll
accumulate even more entropy, which is fine. Hopefully this is an easy
ack and has no more pitfalls! -Jason

 drivers/char/random.c      | 57 ++++++++++++++++++++++++++++----------
 include/linux/cpuhotplug.h |  2 ++
 include/linux/random.h     |  5 ++++
 kernel/cpu.c               | 11 ++++++++
 4 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8d5abeefcc4f..373af789da7a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -697,6 +697,25 @@ u32 get_random_u32(void)
 }
 EXPORT_SYMBOL(get_random_u32);
 
+#ifdef CONFIG_SMP
+/*
+ * This function is called by the cpuhp system, wired up via the large
+ * static array in kernel/cpu.c, with the entry CPUHP_RANDOM_PREPARE.
+ */
+int random_prepare_cpu(unsigned int cpu)
+{
+	/*
+	 * When the cpu comes back online, immediately invalidate both
+	 * the per-cpu crng and all batches, so that we serve fresh
+	 * randomness.
+	 */
+	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
+	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
+	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
+	return 0;
+}
+#endif
+
 /**
  * randomize_page - Generate a random, page aligned address
  * @start:	The smallest acceptable address the caller will take.
@@ -1182,7 +1201,7 @@ struct fast_pool {
 	};
 	struct work_struct mix;
 	unsigned long last;
-	atomic_t count;
+	unsigned int count;
 	u16 reg_idx;
 };
 
@@ -1218,6 +1237,24 @@ static void fast_mix(u32 pool[4])
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
+#ifdef CONFIG_SMP
+/*
+ * This function is called by the cpuhp system, wired up via the large
+ * static array in kernel/cpu.c, with the entry CPUHP_AP_RANDOM_ONLINE.
+ */
+int random_online_cpu(unsigned int cpu)
+{
+	/*
+	 * Set irq randomness count to zero so that new accumulated
+	 * irqs are fresh, and more importantly, so that its worker
+	 * is permitted to schedule again when it comes back online,
+	 * since the MIX_INFLIGHT flag will be cleared.
+	 */
+	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+	return 0;
+}
+#endif
+
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	u32 *ptr = (u32 *)regs;
@@ -1242,15 +1279,6 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	local_irq_disable();
 	if (fast_pool != this_cpu_ptr(&irq_randomness)) {
 		local_irq_enable();
-		/*
-		 * If we are unlucky enough to have been moved to another CPU,
-		 * during CPU hotplug while the CPU was shutdown then we set
-		 * our count to zero atomically so that when the CPU comes
-		 * back online, it can enqueue work again. The _release here
-		 * pairs with the atomic_inc_return_acquire in
-		 * add_interrupt_randomness().
-		 */
-		atomic_set_release(&fast_pool->count, 0);
 		return;
 	}
 
@@ -1259,7 +1287,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * consistent view, before we reenable irqs again.
 	 */
 	memcpy(pool, fast_pool->pool32, sizeof(pool));
-	atomic_set(&fast_pool->count, 0);
+	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
@@ -1295,14 +1323,13 @@ void add_interrupt_randomness(int irq)
 	}
 
 	fast_mix(fast_pool->pool32);
-	/* The _acquire here pairs with the atomic_set_release in mix_interrupt_randomness(). */
-	new_count = (unsigned int)atomic_inc_return_acquire(&fast_pool->count);
+	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
 		    crng_pre_init_inject(fast_pool->pool32, sizeof(fast_pool->pool32),
 					 true, true) > 0) {
-			atomic_set(&fast_pool->count, 0);
+			fast_pool->count = 0;
 			fast_pool->last = now;
 			if (spin_trylock(&input_pool.lock)) {
 				_mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
@@ -1320,7 +1347,7 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(!fast_pool->mix.func))
 		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-	atomic_or(MIX_INFLIGHT, &fast_pool->count);
+	fast_pool->count |= MIX_INFLIGHT;
 	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 411a428ace4d..481e565cc5c4 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -100,6 +100,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
 	CPUHP_AP_DTPM_CPU_DEAD,
+	CPUHP_RANDOM_PREPARE,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -240,6 +241,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
+	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
diff --git a/include/linux/random.h b/include/linux/random.h
index d7354de9351e..6148b8d1ccf3 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -156,4 +156,9 @@ static inline bool __init arch_get_random_long_early(unsigned long *v)
 }
 #endif
 
+#ifdef CONFIG_SMP
+extern int random_prepare_cpu(unsigned int cpu);
+extern int random_online_cpu(unsigned int cpu);
+#endif
+
 #endif /* _LINUX_RANDOM_H */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..238cba15449f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -34,6 +34,7 @@
 #include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
+#include <linux/random.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1659,6 +1660,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= perf_event_init_cpu,
 		.teardown.single	= perf_event_exit_cpu,
 	},
+	[CPUHP_RANDOM_PREPARE] = {
+		.name			= "random:prepare",
+		.startup.single		= random_prepare_cpu,
+		.teardown.single	= NULL,
+	},
 	[CPUHP_WORKQUEUE_PREP] = {
 		.name			= "workqueue:prepare",
 		.startup.single		= workqueue_prepare_cpu,
@@ -1782,6 +1788,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= workqueue_online_cpu,
 		.teardown.single	= workqueue_offline_cpu,
 	},
+	[CPUHP_AP_RANDOM_ONLINE] = {
+		.name			= "random:online",
+		.startup.single		= random_online_cpu,
+		.teardown.single	= NULL,
+	},
 	[CPUHP_AP_RCUTREE_ONLINE] = {
 		.name			= "RCU/tree:online",
 		.startup.single		= rcutree_online_cpu,
-- 
2.35.0

