Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5A4B544F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355691AbiBNPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:14:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355687AbiBNPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:14:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137DBF72
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:14:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 849CECE1824
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DEFC340E9;
        Mon, 14 Feb 2022 15:14:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c0M/4K9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644851673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gN3Ld44FkBNuVIqEE8RkmPb796ki5gFVkrZuvPA7hjY=;
        b=c0M/4K9KPa69mOD29yatKckxWVrQqv/ubo0UxlaUytRDKwB+hvHh1/Y1YWajd5fiMaxSXl
        UDi2yUIjegvQOGaKk4vKR8olgoqFpKeQVcWMyQpxhxUOCIslf4YGql67vnsSucEIecQ7Fr
        5bm+aDJ+FPgmgAKW+M9YmmLyHbZvMrs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ed6d592 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 15:14:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux@dominikbrodowski.net, sultan@kerneltoast.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v3 1/2] random: set fast pool count to zero in cpuhp prepare
Date:   Mon, 14 Feb 2022 16:14:14 +0100
Message-Id: <20220214151415.1108141-2-Jason@zx2c4.com>
In-Reply-To: <20220214151415.1108141-1-Jason@zx2c4.com>
References: <20220214151415.1108141-1-Jason@zx2c4.com>
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

Rather than having to use expensive atomics, which were visibly the most
expensive thing in the entire irq handler, simply take care of the
extreme edge case of resetting count to 0 in the cpuhp prepare handler,
before irqs have started. This simplifies the code a bit and lets us use
vanilla variables rather than atomics, and performance should be
improved.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c      | 37 ++++++++++++++++++++++---------------
 include/linux/cpuhotplug.h |  1 +
 include/linux/random.h     |  2 ++
 kernel/cpu.c               |  6 ++++++
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf6e8627b74e..2e25e3aa6506 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1179,7 +1179,7 @@ struct fast_pool {
 	unsigned long pool[16 / sizeof(long)];
 	struct work_struct mix;
 	unsigned long last;
-	atomic_t count;
+	unsigned int count;
 	u16 reg_idx;
 };
 
@@ -1215,6 +1215,23 @@ static void fast_mix(u32 pool[4])
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
+int random_prepare_cpu(unsigned int cpu)
+{
+	/*
+	 * We want to reset a few things when a CPU comes online, in case
+	 * it was previously offlined and therefore has stale information.
+	 */
+
+	/*
+	 * Set irq randomness count to zero so that new accumulated
+	 * irqs are fresh, and more importantly, so that its worker
+	 * is permitted to schedule again when it comes back online,
+	 * since the MIX_INFLIGHT flag will be cleared.
+	 */
+	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+	return 0;
+}
+
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	u32 *ptr = (u32 *)regs;
@@ -1239,15 +1256,6 @@ static void mix_interrupt_randomness(struct work_struct *work)
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
 
@@ -1256,7 +1264,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * consistent view, before we reenable irqs again.
 	 */
 	memcpy(pool, fast_pool->pool, sizeof(pool));
-	atomic_set(&fast_pool->count, 0);
+	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
@@ -1288,14 +1296,13 @@ void add_interrupt_randomness(int irq)
 	}
 
 	fast_mix((u32 *)fast_pool->pool);
-	/* The _acquire here pairs with the atomic_set_release in mix_interrupt_randomness(). */
-	new_count = (unsigned int)atomic_inc_return_acquire(&fast_pool->count);
+	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
 		    crng_pre_init_inject(fast_pool->pool, sizeof(fast_pool->pool),
 					 true, true) > 0) {
-			atomic_set(&fast_pool->count, 0);
+			fast_pool->count = 0;
 			fast_pool->last = now;
 			if (spin_trylock(&input_pool.lock)) {
 				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
@@ -1313,7 +1320,7 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(!fast_pool->mix.func))
 		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-	atomic_or(MIX_INFLIGHT, &fast_pool->count);
+	fast_pool->count |= MIX_INFLIGHT;
 	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 411a428ace4d..38294af566e4 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -127,6 +127,7 @@ enum cpuhp_state {
 	CPUHP_MM_ZSWP_POOL_PREPARE,
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
+	CPUHP_RANDOM_PREPARE,
 	CPUHP_TIMERS_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
diff --git a/include/linux/random.h b/include/linux/random.h
index d7354de9351e..6b0b8e8b9062 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -35,6 +35,8 @@ extern void add_interrupt_randomness(int irq) __latent_entropy;
 extern void add_hwgenerator_randomness(const void *buffer, size_t count,
 				       size_t entropy);
 
+extern int random_prepare_cpu(unsigned int cpu);
+
 extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);
 extern int __init rand_initialize(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..8da392a6dc80 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -34,6 +34,7 @@
 #include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
+#include <linux/random.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1689,6 +1690,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= rcutree_prepare_cpu,
 		.teardown.single	= rcutree_dead_cpu,
 	},
+	[CPUHP_RANDOM_PREPARE] = {
+		.name			= "random:prepare",
+		.startup.single		= random_prepare_cpu,
+		.teardown.single	= NULL,
+	},
 	/*
 	 * On the tear-down path, timers_dead_cpu() must be invoked
 	 * before blk_mq_queue_reinit_notify() from notify_dead(),
-- 
2.35.0

