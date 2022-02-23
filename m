Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951D24C1B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbiBWSz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiBWSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:55:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0453EF00;
        Wed, 23 Feb 2022 10:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B94C0B8218D;
        Wed, 23 Feb 2022 18:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E10C340E7;
        Wed, 23 Feb 2022 18:55:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QkOuubY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645642521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cwY0EDD6eopPWtPCL3v37+kjOKqJXSVA7WTKzKBMdiU=;
        b=QkOuubY0JZAuCOGq4M7e4/QFDp9EvBWpOOFuim35X9plkeushAGzJT967j8qZV1YLiHotT
        uoDVEZw8YT1I1JdZVYHAlqUfTh+Mz/+fw/vXYuFJqiiGqZRFjOoTRZGmtoSNcKUolk6vGw
        vhaOlpSlh1oP0edkfAuYTOu1rEJaFkc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e60620e8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Feb 2022 18:55:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        bigeasy@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: do crng pre-init loading in worker rather than irq
Date:   Wed, 23 Feb 2022 19:55:11 +0100
Message-Id: <20220223185511.628452-1-Jason@zx2c4.com>
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

Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
is, in part, why we take trylocks instead. But apparently this still
trips up various lock dependency analyzers. That seems like a bug in the
analyzers that should be fixed, rather than having to change things
here.

But maybe there's another reason to change things up: by deferring the
crng pre-init loading to the worker, we can use the cryptographic hash
function rather than xor, which is perhaps a meaningful difference when
considering this data has only been through the relatively weak
fast_mix() function.

The biggest downside of this approach is that the pre-init loading is
now deferred until later, which means things that need random numbers
after interrupts are enabled, but before workqueues are running -- or
before this particular worker manages to run -- are going to get into
trouble. Hopefully in the real world, this window is rather small,
especially since this code won't run until 64 interrupts had occurred.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 62 ++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 536237a0f073..9fb06fc298d3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -443,10 +443,6 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
  * boot time when it's better to have something there rather than
  * nothing.
  *
- * There are two paths, a slow one and a fast one. The slow one
- * hashes the input along with the current key. The fast one simply
- * xors it in, and should only be used from interrupt context.
- *
  * If account is set, then the crng_init_cnt counter is incremented.
  * This shouldn't be set by functions like add_device_randomness(),
  * where we can't trust the buffer passed to it is guaranteed to be
@@ -455,19 +451,15 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
  * Returns the number of bytes processed from input, which is bounded
  * by CRNG_INIT_CNT_THRESH if account is true.
  */
-static size_t crng_pre_init_inject(const void *input, size_t len,
-				   bool fast, bool account)
+static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
 {
 	static int crng_init_cnt = 0;
+	struct blake2s_state hash;
 	unsigned long flags;
 
-	if (fast) {
-		if (!spin_trylock_irqsave(&base_crng.lock, flags))
-			return 0;
-	} else {
-		spin_lock_irqsave(&base_crng.lock, flags);
-	}
+	blake2s_init(&hash, sizeof(base_crng.key));
 
+	spin_lock_irqsave(&base_crng.lock, flags);
 	if (crng_init != 0) {
 		spin_unlock_irqrestore(&base_crng.lock, flags);
 		return 0;
@@ -476,21 +468,9 @@ static size_t crng_pre_init_inject(const void *input, size_t len,
 	if (account)
 		len = min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
 
-	if (fast) {
-		const u8 *src = input;
-		size_t i;
-
-		for (i = 0; i < len; ++i)
-			base_crng.key[(crng_init_cnt + i) %
-				      sizeof(base_crng.key)] ^= src[i];
-	} else {
-		struct blake2s_state hash;
-
-		blake2s_init(&hash, sizeof(base_crng.key));
-		blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
-		blake2s_update(&hash, input, len);
-		blake2s_final(&hash, base_crng.key);
-	}
+	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
+	blake2s_update(&hash, input, len);
+	blake2s_final(&hash, base_crng.key);
 
 	if (account) {
 		crng_init_cnt += len;
@@ -1040,7 +1020,7 @@ void add_device_randomness(const void *buf, size_t size)
 	unsigned long flags;
 
 	if (crng_init == 0 && size)
-		crng_pre_init_inject(buf, size, false, false);
+		crng_pre_init_inject(buf, size, false);
 
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(buf, size);
@@ -1157,7 +1137,7 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
 	if (unlikely(crng_init == 0)) {
-		size_t ret = crng_pre_init_inject(buffer, count, false, true);
+		size_t ret = crng_pre_init_inject(buffer, count, true);
 		mix_pool_bytes(buffer, ret);
 		count -= ret;
 		buffer += ret;
@@ -1298,7 +1278,12 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	local_irq_enable();
 
 	mix_pool_bytes(pool, sizeof(pool));
-	credit_entropy_bits(1);
+
+	if (unlikely(crng_init == 0))
+		crng_pre_init_inject(pool, sizeof(pool), true);
+	else
+		credit_entropy_bits(1);
+
 	memzero_explicit(pool, sizeof(pool));
 }
 
@@ -1331,24 +1316,11 @@ void add_interrupt_randomness(int irq)
 	fast_mix(fast_pool->pool32);
 	new_count = ++fast_pool->count;
 
-	if (unlikely(crng_init == 0)) {
-		if (new_count >= 64 &&
-		    crng_pre_init_inject(fast_pool->pool32, sizeof(fast_pool->pool32),
-					 true, true) > 0) {
-			fast_pool->count = 0;
-			fast_pool->last = now;
-			if (spin_trylock(&input_pool.lock)) {
-				_mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
-				spin_unlock(&input_pool.lock);
-			}
-		}
-		return;
-	}
-
 	if (new_count & MIX_INFLIGHT)
 		return;
 
-	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
+	if (new_count < 64 && (!time_after(now, fast_pool->last + HZ) ||
+			       unlikely(crng_init == 0)))
 		return;
 
 	if (unlikely(!fast_pool->mix.func))
-- 
2.35.1

