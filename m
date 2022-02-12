Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9834B34F5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiBLMXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:23:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBLMXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE226AD9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEC860D36
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA20C340E7;
        Sat, 12 Feb 2022 12:23:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oKd1FVBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEFWmMdmSM2u3OlUR5r5iPCfmz7oLX+27KlnpVqivWw=;
        b=oKd1FVBq9PBGYmZNZ5KHHp6fuFVk3FiPb0f8MFhKMId7RHAYyA8beMQ7hLbT79BHT5+iWk
        oDawdgivNBSyFv+2HuCi2blTJNLM/aH+5gakH8mHzJUiIOR574NbMUYKpB8Oe8oagoc8Lk
        D67vI5p8Ft9WbClvXta8C8Jew2aVGm4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 85851cdf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 05/10] random: group crng functions
Date:   Sat, 12 Feb 2022 13:23:13 +0100
Message-Id: <20220212122318.623435-6-Jason@zx2c4.com>
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
References: <20220212122318.623435-1-Jason@zx2c4.com>
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

This pulls all of the crng-focused functions into the second labeled
section.

No functional changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 865 +++++++++++++++++++++---------------------
 1 file changed, 442 insertions(+), 423 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 499ad32e3060..737d70f1ead5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -380,121 +380,13 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
 }
 
 
-enum {
-	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
-	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
-};
-
-/*
- * Static global variables
- */
-static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
-static struct fasync_struct *fasync;
-
-static int crng_init_cnt = 0;
-static void _get_random_bytes(void *buf, size_t nbytes);
-
-/**********************************************************************
- *
- * OS independent entropy store.   Here are the functions which handle
- * storing entropy in an entropy pool.
- *
- **********************************************************************/
-
-static struct {
-	struct blake2s_state hash;
-	spinlock_t lock;
-	unsigned int entropy_count;
-} input_pool = {
-	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
-		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
-		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
-	.hash.outlen = BLAKE2S_HASH_SIZE,
-	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
-};
-
-static void extract_entropy(void *buf, size_t nbytes);
-static bool drain_entropy(void *buf, size_t nbytes);
-
-static void crng_reseed(void);
-
-/*
- * This function adds bytes into the entropy "pool".  It does not
- * update the entropy estimate.  The caller should call
- * credit_entropy_bits if this is appropriate.
- */
-static void _mix_pool_bytes(const void *in, size_t nbytes)
-{
-	blake2s_update(&input_pool.hash, in, nbytes);
-}
-
-static void mix_pool_bytes(const void *in, size_t nbytes)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(in, nbytes);
-	spin_unlock_irqrestore(&input_pool.lock, flags);
-}
-
-struct fast_pool {
-	unsigned long pool[16 / sizeof(long)];
-	unsigned long last;
-	u16 reg_idx;
-	u8 count;
-};
-
-/*
- * This is a fast mixing routine used by the interrupt randomness
- * collector.  It's hardcoded for an 128 bit pool and assumes that any
- * locks that might be needed are taken by the caller.
- */
-static void fast_mix(u32 pool[4])
-{
-	u32 a = pool[0],	b = pool[1];
-	u32 c = pool[2],	d = pool[3];
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	pool[0] = a;  pool[1] = b;
-	pool[2] = c;  pool[3] = d;
-}
-
-static void credit_entropy_bits(size_t nbits)
-{
-	unsigned int entropy_count, orig, add;
-
-	if (!nbits)
-		return;
-
-	add = min_t(size_t, nbits, POOL_BITS);
-
-	do {
-		orig = READ_ONCE(input_pool.entropy_count);
-		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
-	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
-
-	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
-		crng_reseed();
-}
-
 /*********************************************************************
  *
- * CRNG using CHACHA20
+ * Fast key erasure RNG, the "crng".
+ *
+ * These functions expand entropy from the entropy extractor into
+ * long streams for external consumption using the "fast key erasure"
+ * RNG described at <https://blog.cr.yp.to/20170723-random.html>.
  *
  *********************************************************************/
 
@@ -523,70 +415,14 @@ static DEFINE_PER_CPU(struct crng, crngs) = {
 	.lock = INIT_LOCAL_LOCK(crngs.lock),
 };
 
-/*
- * crng_fast_load() can be called by code in the interrupt service
- * path.  So we can't afford to dilly-dally. Returns the number of
- * bytes processed from cp.
- */
-static size_t crng_fast_load(const void *cp, size_t len)
-{
-	unsigned long flags;
-	u8 *src = (u8 *)cp;
-	size_t ret = 0;
-
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return 0;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return 0;
-	}
-	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
-		base_crng.key[crng_init_cnt % sizeof(base_crng.key)] ^= *src;
-		src++; crng_init_cnt++; len--; ret++;
-	}
-	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
-		++base_crng.generation;
-		crng_init = 1;
-	}
-	spin_unlock_irqrestore(&base_crng.lock, flags);
-	if (crng_init == 1)
-		pr_notice("fast init done\n");
-	return ret;
-}
+/* Used by crng_reseed() to extract a new seed from the input pool. */
+static bool drain_entropy(void *buf, size_t nbytes);
 
 /*
- * crng_slow_load() is called by add_device_randomness, which has two
- * attributes.  (1) We can't trust the buffer passed to it is
- * guaranteed to be unpredictable (so it might not have any entropy at
- * all), and (2) it doesn't have the performance constraints of
- * crng_fast_load().
- *
- * So, we simply hash the contents in with the current key. Finally,
- * we do *not* advance crng_init_cnt since buffer we may get may be
- * something like a fixed DMI table (for example), which might very
- * well be unique to the machine, but is otherwise unvarying.
+ * This extracts a new crng key from the input pool, but only if there is a
+ * sufficient amount of entropy available, in order to mitigate bruteforcing
+ * of newly added bits.
  */
-static void crng_slow_load(const void *cp, size_t len)
-{
-	unsigned long flags;
-	struct blake2s_state hash;
-
-	blake2s_init(&hash, sizeof(base_crng.key));
-
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return;
-	}
-
-	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
-	blake2s_update(&hash, cp, len);
-	blake2s_final(&hash, base_crng.key);
-
-	spin_unlock_irqrestore(&base_crng.lock, flags);
-}
-
 static void crng_reseed(void)
 {
 	unsigned long flags;
@@ -598,7 +434,8 @@ static void crng_reseed(void)
 	if (!drain_entropy(key, sizeof(key)))
 		return;
 
-	/* We copy the new key into the base_crng, overwriting the old one,
+	/*
+	 * We copy the new key into the base_crng, overwriting the old one,
 	 * and update the generation counter. We avoid hitting ULONG_MAX,
 	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
 	 * forces new CPUs that come online to always initialize.
@@ -635,13 +472,11 @@ static void crng_reseed(void)
 }
 
 /*
- * The general form here is based on a "fast key erasure RNG" from
- * <https://blog.cr.yp.to/20170723-random.html>. It generates a ChaCha
- * block using the provided key, and then immediately overwites that
- * key with half the block. It returns the resultant ChaCha state to the
- * user, along with the second half of the block containing 32 bytes of
- * random data that may be used; random_data_len may not be greater than
- * 32.
+ * This generates a ChaCha block using the provided key, and then
+ * immediately overwites that key with half the block. It returns
+ * the resultant ChaCha state to the user, along with the second
+ * half of the block containing 32 bytes of random data that may
+ * be used; random_data_len may not be greater than 32.
  */
 static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 				  u32 chacha_state[CHACHA_STATE_WORDS],
@@ -674,7 +509,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 
 	BUG_ON(random_data_len > 32);
 
-	/* For the fast path, we check whether we're ready, unlocked first, and
+	/*
+	 * For the fast path, we check whether we're ready, unlocked first, and
 	 * then re-check once locked later. In the case where we're really not
 	 * ready, we do fast key erasure with the base_crng directly, because
 	 * this is what crng_{fast,slow}_load mutate during early init.
@@ -692,7 +528,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 			return;
 	}
 
-	/* If the base_crng is more than 5 minutes old, we reseed, which
+	/*
+	 * If the base_crng is more than 5 minutes old, we reseed, which
 	 * in turn bumps the generation counter that we check below.
 	 */
 	if (unlikely(time_after(jiffies, READ_ONCE(base_crng.birth) + CRNG_RESEED_INTERVAL)))
@@ -701,7 +538,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	local_lock_irqsave(&crngs.lock, flags);
 	crng = raw_cpu_ptr(&crngs);
 
-	/* If our per-cpu crng is older than the base_crng, then it means
+	/*
+	 * If our per-cpu crng is older than the base_crng, then it means
 	 * somebody reseeded the base_crng. In that case, we do fast key
 	 * erasure on the base_crng, and use its output as the new key
 	 * for our per-cpu crng. This brings us up to date with base_crng.
@@ -714,7 +552,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 		spin_unlock(&base_crng.lock);
 	}
 
-	/* Finally, when we've made it this far, our per-cpu crng has an up
+	/*
+	 * Finally, when we've made it this far, our per-cpu crng has an up
 	 * to date key, and we can do fast key erasure with it to produce
 	 * some random data and a ChaCha state for the caller. All other
 	 * branches of this function are "unlikely", so most of the time we
@@ -724,54 +563,433 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	local_unlock_irqrestore(&crngs.lock, flags);
 }
 
-static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
+/*
+ * This function is for crng_init < 2 only.
+ *
+ * crng_fast_load() can be called by code in the interrupt service
+ * path.  So we can't afford to dilly-dally. Returns the number of
+ * bytes processed from cp.
+ */
+static size_t crng_fast_load(const void *cp, size_t len)
+{
+	static int crng_init_cnt = 0;
+	unsigned long flags;
+	u8 *src = (u8 *)cp;
+	size_t ret = 0;
+
+	if (!spin_trylock_irqsave(&base_crng.lock, flags))
+		return 0;
+	if (crng_init != 0) {
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+		return 0;
+	}
+	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
+		base_crng.key[crng_init_cnt % sizeof(base_crng.key)] ^= *src;
+		src++; crng_init_cnt++; len--; ret++;
+	}
+	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
+		++base_crng.generation;
+		crng_init = 1;
+	}
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+	if (crng_init == 1)
+		pr_notice("fast init done\n");
+	return ret;
+}
+
+/*
+ * This function is for crng_init < 2 only.
+ *
+ * crng_slow_load() is called by add_device_randomness, which has two
+ * attributes.  (1) We can't trust the buffer passed to it is
+ * guaranteed to be unpredictable (so it might not have any entropy at
+ * all), and (2) it doesn't have the performance constraints of
+ * crng_fast_load().
+ *
+ * So, we simply hash the contents in with the current key. Finally,
+ * we do *not* advance crng_init_cnt since buffer we may get may be
+ * something like a fixed DMI table (for example), which might very
+ * well be unique to the machine, but is otherwise unvarying.
+ */
+static void crng_slow_load(const void *cp, size_t len)
+{
+	unsigned long flags;
+	struct blake2s_state hash;
+
+	blake2s_init(&hash, sizeof(base_crng.key));
+
+	if (!spin_trylock_irqsave(&base_crng.lock, flags))
+		return;
+	if (crng_init != 0) {
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+		return;
+	}
+
+	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
+	blake2s_update(&hash, cp, len);
+	blake2s_final(&hash, base_crng.key);
+
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+}
+
+static void _get_random_bytes(void *buf, size_t nbytes)
 {
-	bool large_request = (nbytes > 256);
-	ssize_t ret = 0;
-	size_t len;
 	u32 chacha_state[CHACHA_STATE_WORDS];
-	u8 output[CHACHA_BLOCK_SIZE];
+	u8 tmp[CHACHA_BLOCK_SIZE];
+	size_t len;
+
+	if (!nbytes)
+		return;
+
+	len = min_t(size_t, 32, nbytes);
+	crng_make_state(chacha_state, buf, len);
+	nbytes -= len;
+	buf += len;
+
+	while (nbytes) {
+		if (nbytes < CHACHA_BLOCK_SIZE) {
+			chacha20_block(chacha_state, tmp);
+			memcpy(buf, tmp, nbytes);
+			memzero_explicit(tmp, sizeof(tmp));
+			break;
+		}
+
+		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
+		chacha20_block(chacha_state, buf);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+		nbytes -= len;
+		buf += len;
+	}
+
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+}
+
+/*
+ * This function is the exported kernel interface.  It returns some
+ * number of good random numbers, suitable for key generation, seeding
+ * TCP sequence numbers, etc.  It does not rely on the hardware random
+ * number generator.  For random bytes direct from the hardware RNG
+ * (when available), use get_random_bytes_arch(). In order to ensure
+ * that the randomness provided by this function is okay, the function
+ * wait_for_random_bytes() should be called and return 0 at least once
+ * at any point prior.
+ */
+void get_random_bytes(void *buf, size_t nbytes)
+{
+	static void *previous;
+
+	warn_unseeded_randomness(&previous);
+	_get_random_bytes(buf, nbytes);
+}
+EXPORT_SYMBOL(get_random_bytes);
+
+static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
+{
+	bool large_request = (nbytes > 256);
+	ssize_t ret = 0;
+	size_t len;
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	u8 output[CHACHA_BLOCK_SIZE];
+
+	if (!nbytes)
+		return 0;
+
+	len = min_t(size_t, 32, nbytes);
+	crng_make_state(chacha_state, output, len);
+
+	if (copy_to_user(buf, output, len))
+		return -EFAULT;
+	nbytes -= len;
+	buf += len;
+	ret += len;
+
+	while (nbytes) {
+		if (large_request && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		chacha20_block(chacha_state, output);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+
+		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
+		if (copy_to_user(buf, output, len)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		nbytes -= len;
+		buf += len;
+		ret += len;
+	}
+
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+	memzero_explicit(output, sizeof(output));
+	return ret;
+}
+
+/*
+ * Batched entropy returns random integers. The quality of the random
+ * number is good as /dev/urandom. In order to ensure that the randomness
+ * provided by this function is okay, the function wait_for_random_bytes()
+ * should be called and return 0 at least once at any point prior.
+ */
+struct batched_entropy {
+	union {
+		/*
+		 * We make this 1.5x a ChaCha block, so that we get the
+		 * remaining 32 bytes from fast key erasure, plus one full
+		 * block from the detached ChaCha state. We can increase
+		 * the size of this later if needed so long as we keep the
+		 * formula of (integer_blocks + 0.5) * CHACHA_BLOCK_SIZE.
+		 */
+		u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
+		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
+	};
+	local_lock_t lock;
+	unsigned long generation;
+	unsigned int position;
+};
+
+
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
+};
+
+u64 get_random_u64(void)
+{
+	u64 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+	static void *previous;
+	unsigned long next_gen;
+
+	warn_unseeded_randomness(&previous);
+
+	local_lock_irqsave(&batched_entropy_u64.lock, flags);
+	batch = raw_cpu_ptr(&batched_entropy_u64);
+
+	next_gen = READ_ONCE(base_crng.generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
+	    next_gen != batch->generation) {
+		_get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
+		batch->position = 0;
+		batch->generation = next_gen;
+	}
+
+	ret = batch->entropy_u64[batch->position];
+	batch->entropy_u64[batch->position] = 0;
+	++batch->position;
+	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u64);
+
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock)
+};
+
+u32 get_random_u32(void)
+{
+	u32 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+	static void *previous;
+	unsigned long next_gen;
+
+	warn_unseeded_randomness(&previous);
+
+	local_lock_irqsave(&batched_entropy_u32.lock, flags);
+	batch = raw_cpu_ptr(&batched_entropy_u32);
+
+	next_gen = READ_ONCE(base_crng.generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
+	    next_gen != batch->generation) {
+		_get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
+		batch->position = 0;
+		batch->generation = next_gen;
+	}
+
+	ret = batch->entropy_u32[batch->position];
+	batch->entropy_u32[batch->position] = 0;
+	++batch->position;
+	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u32);
+
+/**
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -= PAGE_ALIGN(start) - start;
+		start = PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range = ULONG_MAX - start;
+
+	range >>= PAGE_SHIFT;
+
+	if (range == 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
+
+/*
+ * This function will use the architecture-specific hardware random
+ * number generator if it is available. It is not recommended for
+ * use. Use get_random_bytes() instead. It returns the number of
+ * bytes filled in.
+ */
+size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
+{
+	size_t left = nbytes;
+	u8 *p = buf;
+
+	while (left) {
+		unsigned long v;
+		size_t chunk = min_t(size_t, left, sizeof(unsigned long));
+
+		if (!arch_get_random_long(&v))
+			break;
+
+		memcpy(p, &v, chunk);
+		p += chunk;
+		left -= chunk;
+	}
+
+	return nbytes - left;
+}
+EXPORT_SYMBOL(get_random_bytes_arch);
+
+enum {
+	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
+	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
+};
+
+/*
+ * Static global variables
+ */
+static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+static struct fasync_struct *fasync;
+
+/**********************************************************************
+ *
+ * OS independent entropy store.   Here are the functions which handle
+ * storing entropy in an entropy pool.
+ *
+ **********************************************************************/
+
+static struct {
+	struct blake2s_state hash;
+	spinlock_t lock;
+	unsigned int entropy_count;
+} input_pool = {
+	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
+		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
+		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
+	.hash.outlen = BLAKE2S_HASH_SIZE,
+	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
+};
+
+static void extract_entropy(void *buf, size_t nbytes);
+static bool drain_entropy(void *buf, size_t nbytes);
+
+static void crng_reseed(void);
+
+/*
+ * This function adds bytes into the entropy "pool".  It does not
+ * update the entropy estimate.  The caller should call
+ * credit_entropy_bits if this is appropriate.
+ */
+static void _mix_pool_bytes(const void *in, size_t nbytes)
+{
+	blake2s_update(&input_pool.hash, in, nbytes);
+}
+
+static void mix_pool_bytes(const void *in, size_t nbytes)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(in, nbytes);
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+}
+
+struct fast_pool {
+	unsigned long pool[16 / sizeof(long)];
+	unsigned long last;
+	u16 reg_idx;
+	u8 count;
+};
+
+/*
+ * This is a fast mixing routine used by the interrupt randomness
+ * collector.  It's hardcoded for an 128 bit pool and assumes that any
+ * locks that might be needed are taken by the caller.
+ */
+static void fast_mix(u32 pool[4])
+{
+	u32 a = pool[0],	b = pool[1];
+	u32 c = pool[2],	d = pool[3];
+
+	a += b;			c += d;
+	b = rol32(b, 6);	d = rol32(d, 27);
+	d ^= a;			b ^= c;
 
-	if (!nbytes)
-		return 0;
+	a += b;			c += d;
+	b = rol32(b, 16);	d = rol32(d, 14);
+	d ^= a;			b ^= c;
 
-	len = min_t(size_t, 32, nbytes);
-	crng_make_state(chacha_state, output, len);
+	a += b;			c += d;
+	b = rol32(b, 6);	d = rol32(d, 27);
+	d ^= a;			b ^= c;
 
-	if (copy_to_user(buf, output, len))
-		return -EFAULT;
-	nbytes -= len;
-	buf += len;
-	ret += len;
+	a += b;			c += d;
+	b = rol32(b, 16);	d = rol32(d, 14);
+	d ^= a;			b ^= c;
 
-	while (nbytes) {
-		if (large_request && need_resched()) {
-			if (signal_pending(current)) {
-				if (ret == 0)
-					ret = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
+	pool[0] = a;  pool[1] = b;
+	pool[2] = c;  pool[3] = d;
+}
 
-		chacha20_block(chacha_state, output);
-		if (unlikely(chacha_state[12] == 0))
-			++chacha_state[13];
+static void credit_entropy_bits(size_t nbits)
+{
+	unsigned int entropy_count, orig, add;
 
-		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
-		if (copy_to_user(buf, output, len)) {
-			ret = -EFAULT;
-			break;
-		}
+	if (!nbits)
+		return;
 
-		nbytes -= len;
-		buf += len;
-		ret += len;
-	}
+	add = min_t(size_t, nbits, POOL_BITS);
 
-	memzero_explicit(chacha_state, sizeof(chacha_state));
-	memzero_explicit(output, sizeof(output));
-	return ret;
+	do {
+		orig = READ_ONCE(input_pool.entropy_count);
+		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
+	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
+
+	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
+		crng_reseed();
 }
 
 /*********************************************************************
@@ -1040,58 +1258,6 @@ static bool drain_entropy(void *buf, size_t nbytes)
 	return true;
 }
 
-/*
- * This function is the exported kernel interface.  It returns some
- * number of good random numbers, suitable for key generation, seeding
- * TCP sequence numbers, etc.  It does not rely on the hardware random
- * number generator.  For random bytes direct from the hardware RNG
- * (when available), use get_random_bytes_arch(). In order to ensure
- * that the randomness provided by this function is okay, the function
- * wait_for_random_bytes() should be called and return 0 at least once
- * at any point prior.
- */
-static void _get_random_bytes(void *buf, size_t nbytes)
-{
-	u32 chacha_state[CHACHA_STATE_WORDS];
-	u8 tmp[CHACHA_BLOCK_SIZE];
-	size_t len;
-
-	if (!nbytes)
-		return;
-
-	len = min_t(size_t, 32, nbytes);
-	crng_make_state(chacha_state, buf, len);
-	nbytes -= len;
-	buf += len;
-
-	while (nbytes) {
-		if (nbytes < CHACHA_BLOCK_SIZE) {
-			chacha20_block(chacha_state, tmp);
-			memcpy(buf, tmp, nbytes);
-			memzero_explicit(tmp, sizeof(tmp));
-			break;
-		}
-
-		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
-		chacha20_block(chacha_state, buf);
-		if (unlikely(chacha_state[12] == 0))
-			++chacha_state[13];
-		nbytes -= len;
-		buf += len;
-	}
-
-	memzero_explicit(chacha_state, sizeof(chacha_state));
-}
-
-void get_random_bytes(void *buf, size_t nbytes)
-{
-	static void *previous;
-
-	warn_unseeded_randomness(&previous);
-	_get_random_bytes(buf, nbytes);
-}
-EXPORT_SYMBOL(get_random_bytes);
-
 /*
  * Each time the timer fires, we expect that we got an unpredictable
  * jump in the cycle counter. Even if the timer is running on another
@@ -1141,33 +1307,6 @@ static void try_to_generate_entropy(void)
 	mix_pool_bytes(&stack.now, sizeof(stack.now));
 }
 
-/*
- * This function will use the architecture-specific hardware random
- * number generator if it is available. It is not recommended for
- * use. Use get_random_bytes() instead. It returns the number of
- * bytes filled in.
- */
-size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
-{
-	size_t left = nbytes;
-	u8 *p = buf;
-
-	while (left) {
-		unsigned long v;
-		size_t chunk = min_t(size_t, left, sizeof(unsigned long));
-
-		if (!arch_get_random_long(&v))
-			break;
-
-		memcpy(p, &v, chunk);
-		p += chunk;
-		left -= chunk;
-	}
-
-	return nbytes - left;
-}
-EXPORT_SYMBOL(get_random_bytes_arch);
-
 static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
 static int __init parse_trust_cpu(char *arg)
 {
@@ -1530,126 +1669,6 @@ static int __init random_sysctls_init(void)
 device_initcall(random_sysctls_init);
 #endif	/* CONFIG_SYSCTL */
 
-struct batched_entropy {
-	union {
-		/* We make this 1.5x a ChaCha block, so that we get the
-		 * remaining 32 bytes from fast key erasure, plus one full
-		 * block from the detached ChaCha state. We can increase
-		 * the size of this later if needed so long as we keep the
-		 * formula of (integer_blocks + 0.5) * CHACHA_BLOCK_SIZE.
-		 */
-		u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
-		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
-	};
-	local_lock_t lock;
-	unsigned long generation;
-	unsigned int position;
-};
-
-/*
- * Get a random word for internal kernel use only. The quality of the random
- * number is good as /dev/urandom. In order to ensure that the randomness
- * provided by this function is okay, the function wait_for_random_bytes()
- * should be called and return 0 at least once at any point prior.
- */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
-};
-
-u64 get_random_u64(void)
-{
-	u64 ret;
-	unsigned long flags;
-	struct batched_entropy *batch;
-	static void *previous;
-	unsigned long next_gen;
-
-	warn_unseeded_randomness(&previous);
-
-	local_lock_irqsave(&batched_entropy_u64.lock, flags);
-	batch = raw_cpu_ptr(&batched_entropy_u64);
-
-	next_gen = READ_ONCE(base_crng.generation);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
-	    next_gen != batch->generation) {
-		_get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
-		batch->position = 0;
-		batch->generation = next_gen;
-	}
-
-	ret = batch->entropy_u64[batch->position];
-	batch->entropy_u64[batch->position] = 0;
-	++batch->position;
-	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(get_random_u64);
-
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock)
-};
-
-u32 get_random_u32(void)
-{
-	u32 ret;
-	unsigned long flags;
-	struct batched_entropy *batch;
-	static void *previous;
-	unsigned long next_gen;
-
-	warn_unseeded_randomness(&previous);
-
-	local_lock_irqsave(&batched_entropy_u32.lock, flags);
-	batch = raw_cpu_ptr(&batched_entropy_u32);
-
-	next_gen = READ_ONCE(base_crng.generation);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
-	    next_gen != batch->generation) {
-		_get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
-		batch->position = 0;
-		batch->generation = next_gen;
-	}
-
-	ret = batch->entropy_u32[batch->position];
-	batch->entropy_u32[batch->position] = 0;
-	++batch->position;
-	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(get_random_u32);
-
-/**
- * randomize_page - Generate a random, page aligned address
- * @start:	The smallest acceptable address the caller will take.
- * @range:	The size of the area, starting at @start, within which the
- *		random address must fall.
- *
- * If @start + @range would overflow, @range is capped.
- *
- * NOTE: Historical use of randomize_range, which this replaces, presumed that
- * @start was already page aligned.  We now align it regardless.
- *
- * Return: A page aligned address within [start, start + range).  On error,
- * @start is returned.
- */
-unsigned long randomize_page(unsigned long start, unsigned long range)
-{
-	if (!PAGE_ALIGNED(start)) {
-		range -= PAGE_ALIGN(start) - start;
-		start = PAGE_ALIGN(start);
-	}
-
-	if (start > ULONG_MAX - range)
-		range = ULONG_MAX - start;
-
-	range >>= PAGE_SHIFT;
-
-	if (range == 0)
-		return start;
-
-	return start + (get_random_long() % range << PAGE_SHIFT);
-}
-
 /* Interface for in-kernel drivers of true hardware RNGs.
  * Those devices may produce endless random bits and will be throttled
  * when our pool is full.
-- 
2.35.0

