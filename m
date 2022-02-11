Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C94B2B57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351920AbiBKRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:07:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349563AbiBKRHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82141A1;
        Fri, 11 Feb 2022 09:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78AFCB82B0E;
        Fri, 11 Feb 2022 17:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B764C340E9;
        Fri, 11 Feb 2022 17:07:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AXorID3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644599264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpXzgarNdJ23uBBIht05tW/OI4PnzIC+kLi4noUJ2Pw=;
        b=AXorID3vG/TzNwYO8lIBU764x+UKP7ldvzbR7aOHYtSJo+A8TjUTkLl3UUuh4GBxkz7fHk
        mapijzwAdCW1rqcclo9Sb3Uuh+XaIaexED1wIUulvHK/iGRvvoTTDO9Nxmvu/I+EC35SuS
        ywMRD0nc0mftENqaUcj60G2pmt7wP6k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8346177c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 17:07:44 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v7] random: defer fast pool mixing to worker
Date:   Fri, 11 Feb 2022 18:07:32 +0100
Message-Id: <20220211170732.571775-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
References: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
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
it hasn't been migrated (after disabling irqs). If it has been migrated,
then we set the count to zero, so that when the CPU comes online again,
it can requeue the work. As part of this, we switch to using an
atomic_t, so that the increment in the irq handler doesn't wipe out the
zeroing if the CPU comes back online while this worker is running.

The second issue is that, though relatively minor in effect, we probably
want to make sure we get a consistent view of the pool onto the stack,
in case it's interrupted by an irq while reading. To do this, we don't
reenable irqs until after the copy. There are only 18 instructions
between the cli and sti, so this is a pretty tiny window.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - as requested, we now disable irqs for a very short 18
instructions rather than fishing into migrate_disable() and upsetting
PeterZ. Might this be the lucky patch? -Jason

 drivers/char/random.c | 63 +++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1dbf21c02b40..b921127ea693 100644
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
@@ -1214,12 +1215,49 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
+static void mix_interrupt_randomness(struct work_struct *work)
+{
+	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+	unsigned long pool[ARRAY_SIZE(fast_pool->pool)];
+
+	/* Check to see if we're running on the wrong CPU due to hotplug. */
+	local_irq_disable();
+	if (fast_pool != this_cpu_ptr(&irq_randomness)) {
+		local_irq_enable();
+		/*
+		 * If we are unlucky enough to have been moved to another CPU,
+		 * during CPU hotplug while the CPU was shutdown then we set
+		 * our count to zero atomically so that when the CPU comes
+		 * back online, it can enqueue work again. The _release here
+		 * pairs with the atomic_inc_return_acquire in
+		 * add_interrupt_randomness().
+		 */
+		atomic_set_release(&fast_pool->count, 0);
+		return;
+	}
+
+	/*
+	 * Copy the pool to the stack so that the mixer always has a
+	 * consistent view, before we reenable irqs again.
+	 */
+	memcpy(pool, fast_pool->pool, sizeof(pool));
+	atomic_set(&fast_pool->count, 0);
+	fast_pool->last = jiffies;
+	local_irq_enable();
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
@@ -1235,12 +1273,13 @@ void add_interrupt_randomness(int irq)
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
@@ -1254,20 +1293,16 @@ void add_interrupt_randomness(int irq)
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

