Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A90586CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiHAO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiHAO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:26:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B31F2CB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12798B811FF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCC0C433D7;
        Mon,  1 Aug 2022 14:26:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G8FDo7Im"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659363964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hocz/VGhu1gkjzS427IuURjbxXXZC3G0uQEeod3f4G0=;
        b=G8FDo7ImGCoVqpfQMEBB/7ZLZz5JzW4iqrC9DUiQFmDBzjazJTW3uA4lwWIKsjC7F61vru
        Uy10t6gjaWUn611RrYxfOqb9TW6WYw+ar6CEkHaBDzTuV4EpWBW/3D5zPl/eNNBgyS6C2o
        KoOQLCgUv0Hkzv5W6OBRE5lEKDWG3/0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43a5c06b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 14:26:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] random: use raw spinlocks for use on RT
Date:   Mon,  1 Aug 2022 16:25:31 +0200
Message-Id: <20220801142530.133007-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After handling several bug reports using various creative solutions,
it's becoming clear that random bytes are actually a useful thing to
happen from any ordinary context, including when interruptsare off.
Actually, that's been long recognized, which is why the RNG uses
spinlocks rather than mutexes. But on RT, those spinlocks are getting
converted back into sleeping locks.

This clearly is causing more problems than it might hypothetically
solve. Additionally, the locks in random.c are generally for fixed
durations doing CPU-bound operations -- no waiting for hardware or I/O
or the like. So this shouldn't result in a real harm to latency.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - I won't move forward with this without your Ack, obviously.
What do you think of this general approach? -Jason

 drivers/char/random.c | 44 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d44832e9e709..67fdd71405b3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -180,9 +180,9 @@ static struct {
 	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
 	unsigned long birth;
 	unsigned long generation;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 } base_crng = {
-	.lock = __SPIN_LOCK_UNLOCKED(base_crng.lock)
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(base_crng.lock)
 };
 
 struct crng {
@@ -214,7 +214,7 @@ static void crng_reseed(void)
 	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
 	 * forces new CPUs that come online to always initialize.
 	 */
-	spin_lock_irqsave(&base_crng.lock, flags);
+	raw_spin_lock_irqsave(&base_crng.lock, flags);
 	memcpy(base_crng.key, key, sizeof(base_crng.key));
 	next_gen = base_crng.generation + 1;
 	if (next_gen == ULONG_MAX)
@@ -223,7 +223,7 @@ static void crng_reseed(void)
 	WRITE_ONCE(base_crng.birth, jiffies);
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
-	spin_unlock_irqrestore(&base_crng.lock, flags);
+	raw_spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
 }
 
@@ -303,7 +303,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	if (!crng_ready()) {
 		bool ready;
 
-		spin_lock_irqsave(&base_crng.lock, flags);
+		raw_spin_lock_irqsave(&base_crng.lock, flags);
 		ready = crng_ready();
 		if (!ready) {
 			if (crng_init == CRNG_EMPTY)
@@ -311,7 +311,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 			crng_fast_key_erasure(base_crng.key, chacha_state,
 					      random_data, random_data_len);
 		}
-		spin_unlock_irqrestore(&base_crng.lock, flags);
+		raw_spin_unlock_irqrestore(&base_crng.lock, flags);
 		if (!ready)
 			return;
 	}
@@ -333,11 +333,11 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	 * for our per-cpu crng. This brings us up to date with base_crng.
 	 */
 	if (unlikely(crng->generation != READ_ONCE(base_crng.generation))) {
-		spin_lock(&base_crng.lock);
+		raw_spin_lock(&base_crng.lock);
 		crng_fast_key_erasure(base_crng.key, chacha_state,
 				      crng->key, sizeof(crng->key));
 		crng->generation = base_crng.generation;
-		spin_unlock(&base_crng.lock);
+		raw_spin_unlock(&base_crng.lock);
 	}
 
 	/*
@@ -555,14 +555,14 @@ enum {
 
 static struct {
 	struct blake2s_state hash;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int init_bits;
 } input_pool = {
 	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
 		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
 		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
 	.hash.outlen = BLAKE2S_HASH_SIZE,
-	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(input_pool.lock),
 };
 
 static void _mix_pool_bytes(const void *buf, size_t len)
@@ -579,9 +579,9 @@ static void mix_pool_bytes(const void *buf, size_t len)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&input_pool.lock, flags);
+	raw_spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(buf, len);
-	spin_unlock_irqrestore(&input_pool.lock, flags);
+	raw_spin_unlock_irqrestore(&input_pool.lock, flags);
 }
 
 /*
@@ -612,7 +612,7 @@ static void extract_entropy(void *buf, size_t len)
 		block.rdseed[i++] = random_get_entropy();
 	}
 
-	spin_lock_irqsave(&input_pool.lock, flags);
+	raw_spin_lock_irqsave(&input_pool.lock, flags);
 
 	/* seed = HASHPRF(last_key, entropy_input) */
 	blake2s_final(&input_pool.hash, seed);
@@ -622,7 +622,7 @@ static void extract_entropy(void *buf, size_t len)
 	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
 	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
 
-	spin_unlock_irqrestore(&input_pool.lock, flags);
+	raw_spin_unlock_irqrestore(&input_pool.lock, flags);
 	memzero_explicit(next_key, sizeof(next_key));
 
 	while (len) {
@@ -667,13 +667,13 @@ static void __cold _credit_init_bits(size_t bits)
 			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
 				  urandom_warning.missed);
 	} else if (orig < POOL_EARLY_BITS && new >= POOL_EARLY_BITS) {
-		spin_lock_irqsave(&base_crng.lock, flags);
+		raw_spin_lock_irqsave(&base_crng.lock, flags);
 		/* Check if crng_init is CRNG_EMPTY, to avoid race with crng_reseed(). */
 		if (crng_init == CRNG_EMPTY) {
 			extract_entropy(base_crng.key, sizeof(base_crng.key));
 			crng_init = CRNG_EARLY;
 		}
-		spin_unlock_irqrestore(&base_crng.lock, flags);
+		raw_spin_unlock_irqrestore(&base_crng.lock, flags);
 	}
 }
 
@@ -756,11 +756,11 @@ static int random_pm_notification(struct notifier_block *nb, unsigned long actio
 	 */
 	ktime_t stamps[] = { ktime_get(), ktime_get_boottime(), ktime_get_real() };
 
-	spin_lock_irqsave(&input_pool.lock, flags);
+	raw_spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(&action, sizeof(action));
 	_mix_pool_bytes(stamps, sizeof(stamps));
 	_mix_pool_bytes(&entropy, sizeof(entropy));
-	spin_unlock_irqrestore(&input_pool.lock, flags);
+	raw_spin_unlock_irqrestore(&input_pool.lock, flags);
 
 	if (crng_ready() && (action == PM_RESTORE_PREPARE ||
 	    (action == PM_POST_SUSPEND &&
@@ -848,10 +848,10 @@ void add_device_randomness(const void *buf, size_t len)
 	unsigned long entropy = random_get_entropy();
 	unsigned long flags;
 
-	spin_lock_irqsave(&input_pool.lock, flags);
+	raw_spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	_mix_pool_bytes(buf, len);
-	spin_unlock_irqrestore(&input_pool.lock, flags);
+	raw_spin_unlock_irqrestore(&input_pool.lock, flags);
 }
 EXPORT_SYMBOL(add_device_randomness);
 
@@ -1062,10 +1062,10 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned int nu
 	if (in_hardirq()) {
 		fast_mix(this_cpu_ptr(&irq_randomness)->pool, entropy, num);
 	} else {
-		spin_lock_irqsave(&input_pool.lock, flags);
+		raw_spin_lock_irqsave(&input_pool.lock, flags);
 		_mix_pool_bytes(&entropy, sizeof(entropy));
 		_mix_pool_bytes(&num, sizeof(num));
-		spin_unlock_irqrestore(&input_pool.lock, flags);
+		raw_spin_unlock_irqrestore(&input_pool.lock, flags);
 	}
 
 	if (crng_ready())
-- 
2.35.1

