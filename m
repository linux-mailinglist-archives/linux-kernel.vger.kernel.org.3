Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45E4AC438
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359372AbiBGPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357409AbiBGPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:39:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BDC0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 222C4B8105D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F592C340F0;
        Mon,  7 Feb 2022 15:39:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nNGQowos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644248385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyjmC91Pfbmgem6ERYnidKlbzVtdd/u4+8Jdeq7ZyAY=;
        b=nNGQowosNSjOM6Kwd8oNamCVT30DCyMA8MbZHiJpufihJDeZXB/4HxhNtkuBv38RD+U7G0
        /qshzObfvCCqrIFlwzo1qg2yNM1YOXHtbw2/4nrIj0W/k6YrGwEWn8Fi7VYSk6bciH3QC8
        dr7e/dWP25Fx6k3YslXTlNA+OEUdrGg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7f5602b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 7 Feb 2022 15:39:45 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 2/2] random: defer fast pool mixing to worker
Date:   Mon,  7 Feb 2022 16:39:14 +0100
Message-Id: <20220207153914.365931-3-Jason@zx2c4.com>
In-Reply-To: <20220207153914.365931-1-Jason@zx2c4.com>
References: <20220207153914.365931-1-Jason@zx2c4.com>
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
handlers. We can fix this by deferring to a work queue the dumping of
the fast pool into the input pool.

We accomplish this with some careful rules on fast_pool->count:

  - When it's incremented to >= 64, we schedule the work.
  - If the top bit is set, we never schedule the work, even if >= 64.
  - The worker is responsible for setting it back to 0 when it's done.

In the worst case, an irq handler is mixing a new irq into the pool at
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
 drivers/char/random.c         | 50 +++++++++++++++++++++--------------
 include/trace/events/random.h |  6 -----
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 395e76c009d6..1bfeb4393e39 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -377,12 +377,6 @@ static void _mix_pool_bytes(const void *in, int nbytes)
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
@@ -394,11 +388,13 @@ static void mix_pool_bytes(const void *in, int nbytes)
 }
 
 struct fast_pool {
-	u32 pool[4];
+	struct work_struct mix;
 	unsigned long last;
+	u32 pool[4];
+	unsigned int count;
 	u16 reg_idx;
-	u8 count;
 };
+#define FAST_POOL_MIX_INFLIGHT (1U << 31)
 
 /*
  * This is a fast mixing routine used by the interrupt randomness
@@ -428,7 +424,6 @@ static void fast_mix(struct fast_pool *f)
 
 	f->pool[0] = a;  f->pool[1] = b;
 	f->pool[2] = c;  f->pool[3] = d;
-	f->count++;
 }
 
 static void process_random_ready_list(void)
@@ -977,12 +972,30 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
+static void mix_interrupt_randomness(struct work_struct *work)
+{
+	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+
+	/*
+	 * Since this is the result of a trip through the scheduler, xor in
+	 * a cycle counter. It can't hurt, and might help.
+	 */
+	fast_pool->pool[3] ^= random_get_entropy();
+
+	mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+	/* We take care to zero out the count only after we're done reading the pool. */
+	WRITE_ONCE(fast_pool->count, 0);
+	fast_pool->last = jiffies;
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
 
@@ -999,9 +1012,10 @@ void add_interrupt_randomness(int irq)
 
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
+	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
-		if ((fast_pool->count >= 64) &&
+		if (new_count >= 64 &&
 		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
@@ -1009,20 +1023,16 @@ void add_interrupt_randomness(int irq)
 		return;
 	}
 
-	if ((fast_pool->count < 64) && !time_after(now, fast_pool->last + HZ))
+	if (new_count & FAST_POOL_MIX_INFLIGHT)
 		return;
 
-	if (!spin_trylock(&input_pool.lock))
+	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
 		return;
 
-	fast_pool->last = now;
-	__mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
-	spin_unlock(&input_pool.lock);
-
-	fast_pool->count = 0;
-
-	/* award one bit for the contents of the fast pool */
-	credit_entropy_bits(1);
+	if (unlikely(!fast_pool->mix.func))
+		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
+	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
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

