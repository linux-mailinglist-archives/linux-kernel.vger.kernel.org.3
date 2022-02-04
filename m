Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B824A9BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359736AbiBDPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359731AbiBDPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:32:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9ACC061741
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:32:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE75161688
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79424C004E1;
        Fri,  4 Feb 2022 15:32:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c8DEDv/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643988725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4cPcffSF6RP1khXi4E+pelLLWROPRXcva65S7FBORc=;
        b=c8DEDv/sFdr47/Um25GwHRrLpjJXTwmiomNzGfgYaiEDzEuXHwSjTbUoZ2ynYdSLPFKxf2
        HA0jULW5rakaOKEK/oMN/iqYEYgPco608gDfu42xjbkICVjLGDo07WGbZ/MSLRbxus0mvU
        0BVxYLCWs/XZW/JHgryK0b18StAMrFU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4d75e435 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 15:32:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH RFC v1] random: do not take spinlocks in irq handler
Date:   Fri,  4 Feb 2022 16:31:49 +0100
Message-Id: <20220204153149.51428-1-Jason@zx2c4.com>
In-Reply-To: <YfgPWatDzkn2ozhm@linutronix.de>
References: <YfgPWatDzkn2ozhm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT, it's problematic to take spinlocks from hard IRQ
handlers. We can fix this by deferring to a work queue the dumping of
the fast pool into the input pool.

We accomplish this by making `u8 count` an `atomic_t count`, with the
following rules:

  - When it's incremented to >= 64, we schedule the work.
  - If the top bit is set, we never schedule the work, even if >= 64.
  - The worker is responsible for setting it back to 0 when it's done.
  - If we need to retry the worker later, we clear the top bit.

In the worst case, an IRQ handler is mixing a new IRQ into the pool at
the same time as the worker is dumping it into the input pool. In this
case, we only ever set the count back to 0 _after_ we're done, so that
subsequent cycles will require a full 64 to dump it in again. In other
words, the result of this race is only ever adding a little bit more
information than normal, but never less, and never crediting any more
for this partial additional information.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - what do you think of this as a deferred scheme to get rid of
that locking? Any downsides of using workqueues like this?

 drivers/char/random.c         | 67 +++++++++++++++++++----------------
 include/trace/events/random.h |  6 ----
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 455615ac169a..a74897fcb269 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -383,12 +383,6 @@ static void _mix_pool_bytes(const void *in, int nbytes)
 	blake2s_update(&input_pool.hash, in, nbytes);
 }
 
-static void __mix_pool_bytes(const void *in, int nbytes)
-{
-	trace_mix_pool_bytes_nolock(nbytes, _RET_IP_);
-	_mix_pool_bytes(in, nbytes);
-}
-
 static void mix_pool_bytes(const void *in, int nbytes)
 {
 	unsigned long flags;
@@ -400,11 +394,13 @@ static void mix_pool_bytes(const void *in, int nbytes)
 }
 
 struct fast_pool {
-	u32 pool[4];
+	struct work_struct mix;
 	unsigned long last;
+	u32 pool[4];
+	atomic_t count;
 	u16 reg_idx;
-	u8 count;
 };
+#define FAST_POOL_MIX_INFLIGHT (1U << 31)
 
 /*
  * This is a fast mixing routine used by the interrupt randomness
@@ -434,7 +430,6 @@ static void fast_mix(struct fast_pool *f)
 
 	f->pool[0] = a;  f->pool[1] = b;
 	f->pool[2] = c;  f->pool[3] = d;
-	f->count++;
 }
 
 static void process_random_ready_list(void)
@@ -985,12 +980,37 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
+static void mix_interrupt_randomness(struct work_struct *work)
+{
+	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+
+	fast_pool->last = jiffies;
+
+	/* Since this is the result of a trip through the scheduler, xor in
+	 * a cycle counter. It can't hurt, and might help.
+	 */
+	fast_pool->pool[3] ^= random_get_entropy();
+
+	if (unlikely(crng_init == 0)) {
+		if (crng_fast_load((u8 *)&fast_pool->pool, sizeof(fast_pool->pool)) > 0)
+			atomic_set(&fast_pool->count, 0);
+		else
+			atomic_and(~FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
+		return;
+	}
+
+	mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+	atomic_set(&fast_pool->count, 0);
+	credit_entropy_bits(1);
+}
+
 void add_interrupt_randomness(int irq)
 {
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
+	unsigned int new_count;
 	u32 c_high, j_high;
 	u64 ip;
 
@@ -1008,29 +1028,14 @@ void add_interrupt_randomness(int irq)
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	if (unlikely(crng_init == 0)) {
-		if ((fast_pool->count >= 64) &&
-		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
-			fast_pool->count = 0;
-			fast_pool->last = now;
-		}
-		return;
+	new_count = (unsigned int)atomic_inc_return(&fast_pool->count);
+	if (new_count >= 64 && new_count < FAST_POOL_MIX_INFLIGHT &&
+	    (time_after(now, fast_pool->last + HZ) || unlikely(crng_init == 0))) {
+		if (unlikely(!fast_pool->mix.func))
+			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+		atomic_or(FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
+		schedule_work(&fast_pool->mix);
 	}
-
-	if ((fast_pool->count < 64) && !time_after(now, fast_pool->last + HZ))
-		return;
-
-	if (!spin_trylock(&input_pool.lock))
-		return;
-
-	fast_pool->last = now;
-	__mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
-	spin_unlock(&input_pool.lock);
-
-	fast_pool->count = 0;
-
-	/* award one bit for the contents of the fast pool */
-	credit_entropy_bits(1);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index ad149aeaf42c..833f42afc70f 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -52,12 +52,6 @@ DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes,
 	TP_ARGS(bytes, IP)
 );
 
-DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
-	TP_PROTO(int bytes, unsigned long IP),
-
-	TP_ARGS(bytes, IP)
-);
-
 TRACE_EVENT(credit_entropy_bits,
 	TP_PROTO(int bits, int entropy_count, unsigned long IP),
 
-- 
2.35.0

