Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184CF4B2A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiBKQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:25:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiBKQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:25:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC283AD;
        Fri, 11 Feb 2022 08:25:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E6CDB82AA1;
        Fri, 11 Feb 2022 16:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B8FC340E9;
        Fri, 11 Feb 2022 16:25:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GmxCwiDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644596728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EXC8K8wOgW31q4Pw0Qifm1YesO2QCtqoy6VbXyzlM4=;
        b=GmxCwiDzd0WShH4VhSmVNQBWyXTAbqkfz3pVytLPQZhFduG2PsX0qnQqWwP65gAzNCz4xs
        /QMVxA/mjrWh1xwtkCql34lX9JuJYHeAijhn9vu4uJHzrFQyKvqr5WALTOCNf8/M1oPPF7
        AqrrZPZ5UFmWbMj/BOY5wrhFtqCxwcY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id efc9f969 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 16:25:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v6] random: defer fast pool mixing to worker
Date:   Fri, 11 Feb 2022 17:25:15 +0100
Message-Id: <20220211162515.554867-1-Jason@zx2c4.com>
In-Reply-To: <YgZ6IEbiDgz5X1ON@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
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

On PREEMPT_RT, it's problematic to take spinlocks from hard irq
handlers. We can fix this by deferring to a workqueue the dumping of
the fast pool into the input pool.

We accomplish this with some careful rules on fast_pool->count:

  - When it's incremented to >= 64, we schedule the work.
  - If the top bit is set, we never schedule the work, even if >= 64.
  - The worker is responsible for setting it back to 0 when it's done.

There are two small issues around using workqueues for this purpose that
we work around.

The first issue is that mix_interrupt_randomness() might be migrated to
another CPU during CPU hotplug. This issue is rectified by checking that
it hasn't been migrated (after disabling migration). If it has been
migrated, then we set the count to zero, so that when the CPU comes
online again, it can requeue the work. As part of this, we switch to
using an atomic_t, so that the increment in the irq handler doesn't wipe
out the zeroing if the CPU comes back online while this worker is
running.

The second issue is that, though relatively minor in effect, we probably
want to make sure we get a consistent view of the pool onto the stack,
in case it's interrupted by an irq while reading. To do this, we simply
read count before and after the memcpy and make sure they're the same.
If they're not, we try again. This isn't a seqlock or anything heavy
like that because we're guaranteed to be on the same core as the irq
handler interrupting, which means that interruption either happens in
full or doesn't at all. The likelihood of actually hitting this is very
low, as we're talking about a 2 or 4 word mov.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - this now uses cmpxchg as you suggested, and has comments on
its various atomic uses. I think we should be finally good to go! PTAL.
Thanks again for looking at this hairy patch.

 drivers/char/random.c | 73 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c42c07a7eb56..20b11a4b6559 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1162,9 +1162,10 @@ EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 struct fast_pool {
 	unsigned long pool[16 / sizeof(long)];
+	struct work_struct mix;
 	unsigned long last;
+	atomic_t count;
 	u16 reg_idx;
-	u8 count;
 };
 
 /*
@@ -1214,12 +1215,59 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
+static void mix_interrupt_randomness(struct work_struct *work)
+{
+	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+	unsigned long pool[ARRAY_SIZE(fast_pool->pool)];
+	int count;
+
+	/* Check to see if we're running on the wrong CPU due to hotplug. */
+	migrate_disable();
+	if (fast_pool != this_cpu_ptr(&irq_randomness)) {
+		migrate_enable();
+		/*
+		 * If we are unlucky enough to have been moved to another CPU,
+		 * then we set our count to zero atomically so that when the
+		 * CPU comes back online, it can enqueue work again. The
+		 * _release here pairs with the atomic_inc_return_acquire in
+		 * add_interrupt_randomness().
+		 */
+		atomic_set_release(&fast_pool->count, 0);
+		return;
+	}
+
+	/*
+	 * Copy the pool to the stack so that the mixer always has a
+	 * consistent view. It's extremely unlikely but possible that
+	 * this 2 or 4 word read is interrupted by an irq, but in case
+	 * it is, we double check that count stays the same.
+	 *
+	 * We set the count to 0 so that irqs can immediately begin to
+	 * accumulate again after. Since any possible interruptions
+	 * at this stage are guaranteed to be on the same CPU, we can
+	 * use cmpxchg_relaxed.
+	 */
+	count = atomic_read(&fast_pool->count);
+	do {
+		memcpy(pool, fast_pool->pool, sizeof(pool));
+	} while (atomic_try_cmpxchg_relaxed(&fast_pool->count, &count, 0));
+
+	fast_pool->last = jiffies;
+	migrate_enable();
+
+	mix_pool_bytes(pool, sizeof(pool));
+	credit_entropy_bits(1);
+	memzero_explicit(pool, sizeof(pool));
+}
+
 void add_interrupt_randomness(int irq)
 {
+	enum { MIX_INFLIGHT = 1U << 31 };
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
+	unsigned int new_count;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
@@ -1235,12 +1283,13 @@ void add_interrupt_randomness(int irq)
 	}
 
 	fast_mix((u32 *)fast_pool->pool);
-	++fast_pool->count;
+	/* The _acquire here pairs with the atomic_set_release in mix_interrupt_randomness(). */
+	new_count = (unsigned int)atomic_inc_return_acquire(&fast_pool->count);
 
 	if (unlikely(crng_init == 0)) {
-		if (fast_pool->count >= 64 &&
+		if (new_count >= 64 &&
 		    crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
-			fast_pool->count = 0;
+			atomic_set(&fast_pool->count, 0);
 			fast_pool->last = now;
 
 			/*
@@ -1254,20 +1303,16 @@ void add_interrupt_randomness(int irq)
 		return;
 	}
 
-	if ((fast_pool->count < 64) && !time_after(now, fast_pool->last + HZ))
+	if (new_count & MIX_INFLIGHT)
 		return;
 
-	if (!spin_trylock(&input_pool.lock))
+	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
 		return;
 
-	fast_pool->last = now;
-	_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
-	spin_unlock(&input_pool.lock);
-
-	fast_pool->count = 0;
-
-	/* Award one bit for the contents of the fast pool. */
-	credit_entropy_bits(1);
+	if (unlikely(!fast_pool->mix.func))
+		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+	atomic_or(MIX_INFLIGHT, &fast_pool->count);
+	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
-- 
2.35.0

