Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB494B79EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiBOVXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiBOVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:23:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A42DAAFD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:23:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61750B81C26
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6321DC340EB;
        Tue, 15 Feb 2022 21:23:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CTEYBH8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644960184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nS+oXcZ2pN2lYjrkN1g4qSCJevoLs3pQQOe/+hYsyoY=;
        b=CTEYBH8x4bXf5K2MNWmw3jehA2slD8U3HWhanzb8wmKnMmHiv93xtyHkIGhouPrjhA7Y+6
        K3YYYxoA+dCu/9rtVQC7G76ygVqn3C+URjcuS3ldpzF433g9K1CfRK4b4DOon7P65T8LBd
        h4cVQvwRLz8fhRhDT2VJr8LHcSljm80=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8f126ed (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 15 Feb 2022 21:23:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux@dominikbrodowski.net, sultan@kerneltoast.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v4 1/2] random: set fast pool count to zero in cpuhp prepare
Date:   Tue, 15 Feb 2022 22:22:54 +0100
Message-Id: <20220215212255.273253-2-Jason@zx2c4.com>
In-Reply-To: <20220215212255.273253-1-Jason@zx2c4.com>
References: <20220215212255.273253-1-Jason@zx2c4.com>
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
 drivers/char/random.c      | 39 +++++++++++++++++++++++---------------
 include/linux/cpuhotplug.h |  1 +
 include/linux/random.h     |  4 ++++
 kernel/cpu.c               |  6 ++++++
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ee21f301ff16..a3cc147406b0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1182,7 +1182,7 @@ struct fast_pool {
 	};
 	struct work_struct mix;
 	unsigned long last;
-	atomic_t count;
+	unsigned int count;
 	u16 reg_idx;
 };
 
@@ -1218,6 +1218,25 @@ static void fast_mix(u32 pool[4])
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
+#ifdef CONFIG_SMP
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
+#endif
+
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	u32 *ptr = (u32 *)regs;
@@ -1242,15 +1261,6 @@ static void mix_interrupt_randomness(struct work_struct *work)
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
 
@@ -1259,7 +1269,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * consistent view, before we reenable irqs again.
 	 */
 	memcpy(pool, fast_pool->pool32, sizeof(pool));
-	atomic_set(&fast_pool->count, 0);
+	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
@@ -1295,14 +1305,13 @@ void add_interrupt_randomness(int irq)
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
@@ -1320,7 +1329,7 @@ void add_interrupt_randomness(int irq)
 
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
index d7354de9351e..41da6628e838 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -35,6 +35,10 @@ extern void add_interrupt_randomness(int irq) __latent_entropy;
 extern void add_hwgenerator_randomness(const void *buffer, size_t count,
 				       size_t entropy);
 
+#ifdef CONFIG_SMP
+extern int random_prepare_cpu(unsigned int cpu);
+#endif
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

