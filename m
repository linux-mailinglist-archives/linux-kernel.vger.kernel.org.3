Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A04B34ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiBLMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:23:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiBLMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2130526104
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC533B8069C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096F9C340EB;
        Sat, 12 Feb 2022 12:23:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kixXmu13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdC/QVqfmi2fwu0h3ZARyEerNxhIEz48jbZbRvd2iUU=;
        b=kixXmu13PxrZnXxbmxPTipcaX55qSIR3MeXPu4quZ6a58MfM+uFm0pWqu4VeWQb3imM/HM
        FviIsDm13rbIlYzDb1v/qksgxAUlW8PArDEjqpMKN3cVkJJ7k5Ths+EFOZEIpM7dLaW3hM
        FQshNBybRWf13LA4sDmDZcaLfDGrriQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6d161da7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 06/10] random: group entropy extraction functions
Date:   Sat, 12 Feb 2022 13:23:14 +0100
Message-Id: <20220212122318.623435-7-Jason@zx2c4.com>
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

This pulls all of the entropy extraction-focused functions into the
third labeled section.

No functional changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 217 +++++++++++++++++++++---------------------
 1 file changed, 109 insertions(+), 108 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 737d70f1ead5..8d1ed01c5a9f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -883,23 +883,35 @@ size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
+
+/**********************************************************************
+ *
+ * Entropy accumulation and extraction routines.
+ *
+ * Callers may add entropy via:
+ *
+ *     static void mix_pool_bytes(const void *in, size_t nbytes)
+ *
+ * After which, if added entropy should be credited:
+ *
+ *     static void credit_entropy_bits(size_t nbits)
+ *
+ * Finally, extract entropy via these two, with the latter one
+ * setting the entropy count to zero and extracting only if there
+ * is POOL_MIN_BITS entropy credited prior:
+ *
+ *     static void extract_entropy(void *buf, size_t nbytes)
+ *     static bool drain_entropy(void *buf, size_t nbytes)
+ *
+ **********************************************************************/
+
 enum {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
 	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
 };
 
-/*
- * Static global variables
- */
+/* For notifying userspace should write into /dev/random. */
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
-static struct fasync_struct *fasync;
-
-/**********************************************************************
- *
- * OS independent entropy store.   Here are the functions which handle
- * storing entropy in an entropy pool.
- *
- **********************************************************************/
 
 static struct {
 	struct blake2s_state hash;
@@ -913,28 +925,106 @@ static struct {
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
 };
 
-static void extract_entropy(void *buf, size_t nbytes);
-static bool drain_entropy(void *buf, size_t nbytes);
-
-static void crng_reseed(void);
+static void _mix_pool_bytes(const void *in, size_t nbytes)
+{
+	blake2s_update(&input_pool.hash, in, nbytes);
+}
 
 /*
  * This function adds bytes into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_bits if this is appropriate.
  */
-static void _mix_pool_bytes(const void *in, size_t nbytes)
+static void mix_pool_bytes(const void *in, size_t nbytes)
 {
-	blake2s_update(&input_pool.hash, in, nbytes);
+	unsigned long flags;
+
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(in, nbytes);
+	spin_unlock_irqrestore(&input_pool.lock, flags);
 }
 
-static void mix_pool_bytes(const void *in, size_t nbytes)
+static void credit_entropy_bits(size_t nbits)
+{
+	unsigned int entropy_count, orig, add;
+
+	if (!nbits)
+		return;
+
+	add = min_t(size_t, nbits, POOL_BITS);
+
+	do {
+		orig = READ_ONCE(input_pool.entropy_count);
+		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
+	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
+
+	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
+		crng_reseed();
+}
+
+/*
+ * This is an HKDF-like construction for using the hashed collected entropy
+ * as a PRF key, that's then expanded block-by-block.
+ */
+static void extract_entropy(void *buf, size_t nbytes)
 {
 	unsigned long flags;
+	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
+	struct {
+		unsigned long rdseed[32 / sizeof(long)];
+		size_t counter;
+	} block;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
+		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
+		    !arch_get_random_long(&block.rdseed[i]))
+			block.rdseed[i] = random_get_entropy();
+	}
 
 	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(in, nbytes);
+
+	/* seed = HASHPRF(last_key, entropy_input) */
+	blake2s_final(&input_pool.hash, seed);
+
+	/* next_key = HASHPRF(seed, RDSEED || 0) */
+	block.counter = 0;
+	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
+	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
+
 	spin_unlock_irqrestore(&input_pool.lock, flags);
+	memzero_explicit(next_key, sizeof(next_key));
+
+	while (nbytes) {
+		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
+		/* output = HASHPRF(seed, RDSEED || ++counter) */
+		++block.counter;
+		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
+		nbytes -= i;
+		buf += i;
+	}
+
+	memzero_explicit(seed, sizeof(seed));
+	memzero_explicit(&block, sizeof(block));
+}
+
+/*
+ * First we make sure we have POOL_MIN_BITS of entropy in the pool,
+ * and then we drain all of it. Only then can we extract a new key
+ * with extract_entropy().
+ */
+static bool drain_entropy(void *buf, size_t nbytes)
+{
+	unsigned int entropy_count;
+	do {
+		entropy_count = READ_ONCE(input_pool.entropy_count);
+		if (entropy_count < POOL_MIN_BITS)
+			return false;
+	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
+	extract_entropy(buf, nbytes);
+	wake_up_interruptible(&random_write_wait);
+	kill_fasync(&fasync, SIGIO, POLL_OUT);
+	return true;
 }
 
 struct fast_pool {
@@ -974,24 +1064,6 @@ static void fast_mix(u32 pool[4])
 	pool[2] = c;  pool[3] = d;
 }
 
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
  * Entropy input management
@@ -1187,77 +1259,6 @@ void add_disk_randomness(struct gendisk *disk)
 EXPORT_SYMBOL_GPL(add_disk_randomness);
 #endif
 
-/*********************************************************************
- *
- * Entropy extraction routines
- *
- *********************************************************************/
-
-/*
- * This is an HKDF-like construction for using the hashed collected entropy
- * as a PRF key, that's then expanded block-by-block.
- */
-static void extract_entropy(void *buf, size_t nbytes)
-{
-	unsigned long flags;
-	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
-	struct {
-		unsigned long rdseed[32 / sizeof(long)];
-		size_t counter;
-	} block;
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
-		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
-		    !arch_get_random_long(&block.rdseed[i]))
-			block.rdseed[i] = random_get_entropy();
-	}
-
-	spin_lock_irqsave(&input_pool.lock, flags);
-
-	/* seed = HASHPRF(last_key, entropy_input) */
-	blake2s_final(&input_pool.hash, seed);
-
-	/* next_key = HASHPRF(seed, RDSEED || 0) */
-	block.counter = 0;
-	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
-	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
-
-	spin_unlock_irqrestore(&input_pool.lock, flags);
-	memzero_explicit(next_key, sizeof(next_key));
-
-	while (nbytes) {
-		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
-		/* output = HASHPRF(seed, RDSEED || ++counter) */
-		++block.counter;
-		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
-		nbytes -= i;
-		buf += i;
-	}
-
-	memzero_explicit(seed, sizeof(seed));
-	memzero_explicit(&block, sizeof(block));
-}
-
-/*
- * First we make sure we have POOL_MIN_BITS of entropy in the pool,
- * and then we drain all of it. Only then can we extract a new key
- * with extract_entropy().
- */
-static bool drain_entropy(void *buf, size_t nbytes)
-{
-	unsigned int entropy_count;
-	do {
-		entropy_count = READ_ONCE(input_pool.entropy_count);
-		if (entropy_count < POOL_MIN_BITS)
-			return false;
-	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
-	extract_entropy(buf, nbytes);
-	wake_up_interruptible(&random_write_wait);
-	kill_fasync(&fasync, SIGIO, POLL_OUT);
-	return true;
-}
-
 /*
  * Each time the timer fires, we expect that we got an unpredictable
  * jump in the cycle counter. Even if the timer is running on another
-- 
2.35.0

