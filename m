Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADC4B3DD6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbiBMVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:54:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiBMVyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:54:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFF54189
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25DD460B06
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEC7C004E1;
        Sun, 13 Feb 2022 21:53:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="R10mpCEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644789234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EqLXX1TKLd5f/UChHQTHP8RqpCLvkQ85FgRZBcHOhd4=;
        b=R10mpCEQlputUDQXuRd9bcjql8aSPjlD3d9gQW0hrDeDvPug/7k2qGkYap87QknB8AdKRK
        ufBm0KWzvAWeT5GDWqmbLTYvPImUTgQyjCPVDh0w25dl/sz7Sog+iOdV+eeKmCQUbBr3CW
        s5G7jku6LUjuIgQEKa9BZeRUPr9P/7g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 234a8ef0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Feb 2022 21:53:54 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: set fast pool count to zero in cpuhp teardown
Date:   Sun, 13 Feb 2022 22:53:43 +0100
Message-Id: <20220213215343.11652-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
extreme edge case of resetting count to 0 in the cpuhp teardown handler.
This simplifies the code a bit and lets us use vanilla variables rather
than atomics, and performance should be improved.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - this was *way* simpler than I had anticipated, and I wish it
were done this way originally. If this looks good to you and you ack it,
I'll wind up merging this commit into the previous one in my branch,
since the intermediate atomic_t stage isn't really that interesting
any more, now that I've seen the light. Please take a look and let me
know what you think. -Jason

 drivers/char/random.c      | 33 ++++++++++++++++++---------------
 include/linux/cpuhotplug.h |  1 +
 include/linux/random.h     |  2 ++
 kernel/cpu.c               |  6 ++++++
 4 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 805a924b1f5f..e177d806db1d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1180,7 +1180,7 @@ struct fast_pool {
 	unsigned long pool[16 / sizeof(long)];
 	struct work_struct mix;
 	unsigned long last;
-	atomic_t count;
+	unsigned int count;
 	u16 reg_idx;
 };
 
@@ -1216,6 +1216,19 @@ static void fast_mix(u32 pool[4])
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
+int random_offline_cpu(unsigned int cpu)
+{
+	/*
+	 * Set the count to zero when offlining the CPU for two
+	 * reasons: 1) so that all new accumulated irqs are fresh
+	 * when it comes back online, and 2) so that its worker is
+	 * permitted to schedule again when it comes back online,
+	 * since the MIX_INFLIGHT flag will be cleared.
+	 */
+	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
+	return 0;
+}
+
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	u32 *ptr = (u32 *)regs;
@@ -1240,15 +1253,6 @@ static void mix_interrupt_randomness(struct work_struct *work)
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
 
@@ -1257,7 +1261,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * consistent view, before we reenable irqs again.
 	 */
 	memcpy(pool, fast_pool->pool, sizeof(pool));
-	atomic_set(&fast_pool->count, 0);
+	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
@@ -1289,14 +1293,13 @@ void add_interrupt_randomness(int irq)
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
@@ -1314,7 +1317,7 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(!fast_pool->mix.func))
 		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-	atomic_or(MIX_INFLIGHT, &fast_pool->count);
+	fast_pool->count |= MIX_INFLIGHT;
 	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 411a428ace4d..199dedacd32e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -239,6 +239,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
 	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
+	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
diff --git a/include/linux/random.h b/include/linux/random.h
index d7354de9351e..8dd5721e3512 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -35,6 +35,8 @@ extern void add_interrupt_randomness(int irq) __latent_entropy;
 extern void add_hwgenerator_randomness(const void *buffer, size_t count,
 				       size_t entropy);
 
+extern int random_offline_cpu(unsigned int cpu);
+
 extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);
 extern int __init rand_initialize(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..e03f7880c163 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -34,6 +34,7 @@
 #include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
+#include <linux/random.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1777,6 +1778,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= lockup_detector_online_cpu,
 		.teardown.single	= lockup_detector_offline_cpu,
 	},
+	[CPUHP_AP_RANDOM_ONLINE] = {
+		.name			= "random:online",
+		.startup.single		= NULL,
+		.teardown.single	= random_offline_cpu,
+	},
 	[CPUHP_AP_WORKQUEUE_ONLINE] = {
 		.name			= "workqueue:online",
 		.startup.single		= workqueue_online_cpu,
-- 
2.35.0

