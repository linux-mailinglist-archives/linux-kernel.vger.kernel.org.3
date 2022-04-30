Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0425515D7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbiD3N17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiD3N1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:27:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914616621A;
        Sat, 30 Apr 2022 06:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A24E60C52;
        Sat, 30 Apr 2022 13:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CE8C385AA;
        Sat, 30 Apr 2022 13:24:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lUAOXurZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651325069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kaW5arq1mBSwhLoj5GTx/eYFZ+POhtZHAs7ViChb2vo=;
        b=lUAOXurZ3kr5ipGSa02LXYQ26336qwvdtjCDJPOi+C4F3TNEjb/2Gz0qOFr42O5rnG4oTz
        wTM8CASeSTwG82YP2tbOuNhs4o+0K/vfhSJSoOh40vu/vzm+F/L6xTrgtBIK5cxKdpJY9q
        eazcL0CBf0M+WI10R3VAKGLBhbDizbo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4583b3bd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 13:24:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: use first 128 bits of input as fast init
Date:   Sat, 30 Apr 2022 15:24:20 +0200
Message-Id: <20220430132420.2750896-1-Jason@zx2c4.com>
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

Before, the first 64 bytes of input, regardless of how entropic it was,
would be used to mutate the crng base key directly, and none of those
bytes would be credited as having entropy. Then 256 bits of credited
input would be accumulated, and only then would the rng transition from
the earlier "fast init" phase into being actually initialized.

The thinking was that by mixing and matching fast init and real init, an
attacker who compromised the fast init state, considered easy to do
given how little entropy might be in those first 64 bytes, would then be
able to bruteforce bits from the actual initialization. By keeping these
separate, bruteforcing became impossible.

However, by not crediting potentially creditable bits from those first 64
bytes of input, we delay initialization, and actually make the problem
worse, because it means the user is drawing worse random numbers for a
longer period of time.

Instead, we can take the first 128 bits as fast init, and allow them to
be credited, and then hold off on the next 128 bits until they've
accumulated. This is still a wide enough margin to prevent bruteforcing
the rng state, while still initializing much faster. This also
simplifies the code quite a bit and will make additional improvements
possible down the road.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 57 +++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 02e880a2c51e..0935a140795e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -231,10 +231,7 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
  *
  *********************************************************************/
 
-enum {
-	CRNG_RESEED_INTERVAL = 300 * HZ,
-	CRNG_INIT_CNT_THRESH = 2 * CHACHA_KEY_SIZE
-};
+enum { CRNG_RESEED_INTERVAL = 300 * HZ };
 
 static struct {
 	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
@@ -445,9 +442,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
  * where we can't trust the buffer passed to it is guaranteed to be
  * unpredictable (so it might not have any entropy at all).
  */
-static void crng_pre_init_inject(const void *input, size_t len, bool account)
+static void crng_pre_init_inject(const void *input, size_t len)
 {
-	static int crng_init_cnt = 0;
 	struct blake2s_state hash;
 	unsigned long flags;
 
@@ -463,18 +459,7 @@ static void crng_pre_init_inject(const void *input, size_t len, bool account)
 	blake2s_update(&hash, input, len);
 	blake2s_final(&hash, base_crng.key);
 
-	if (account) {
-		crng_init_cnt += min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
-		if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
-			++base_crng.generation;
-			crng_init = 1;
-		}
-	}
-
 	spin_unlock_irqrestore(&base_crng.lock, flags);
-
-	if (crng_init == 1)
-		pr_notice("fast init done\n");
 }
 
 static void _get_random_bytes(void *buf, size_t nbytes)
@@ -779,7 +764,8 @@ EXPORT_SYMBOL(get_random_bytes_arch);
 
 enum {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
-	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
+	POOL_MIN_BITS = POOL_BITS, /* No point in settling for less. */
+	POOL_INIT_BITS = POOL_MIN_BITS / 2
 };
 
 /* For notifying userspace should write into /dev/random. */
@@ -819,6 +805,7 @@ static void mix_pool_bytes(const void *in, size_t nbytes)
 static void credit_entropy_bits(size_t nbits)
 {
 	unsigned int entropy_count, orig, add;
+	unsigned long flags;
 
 	if (!nbits)
 		return;
@@ -830,6 +817,15 @@ static void credit_entropy_bits(size_t nbits)
 		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
 	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
 
+	if (unlikely(crng_init == 0 && entropy_count >= POOL_INIT_BITS)) {
+		spin_lock_irqsave(&base_crng.lock, flags);
+		if (crng_init == 0) {
+			++base_crng.generation;
+			crng_init = 1;
+		}
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+	}
+
 	if (!crng_ready() && entropy_count >= POOL_MIN_BITS)
 		crng_reseed(false);
 }
@@ -1031,13 +1027,13 @@ void add_device_randomness(const void *buf, size_t size)
 	unsigned long entropy = random_get_entropy();
 	unsigned long flags;
 
-	if (crng_init == 0 && size)
-		crng_pre_init_inject(buf, size, false);
-
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	_mix_pool_bytes(buf, size);
 	spin_unlock_irqrestore(&input_pool.lock, flags);
+
+	if (unlikely(crng_init == 0 && size))
+		crng_pre_init_inject(buf, size);
 }
 EXPORT_SYMBOL(add_device_randomness);
 
@@ -1149,12 +1145,6 @@ void rand_initialize_disk(struct gendisk *disk)
 void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
-	if (unlikely(crng_init == 0 && entropy < POOL_MIN_BITS)) {
-		crng_pre_init_inject(buffer, count, true);
-		mix_pool_bytes(buffer, count);
-		return;
-	}
-
 	/*
 	 * Throttle writing if we're above the trickle threshold.
 	 * We'll be woken up again once below POOL_MIN_BITS, when
@@ -1167,6 +1157,8 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 			CRNG_RESEED_INTERVAL);
 	mix_pool_bytes(buffer, count);
 	credit_entropy_bits(entropy);
+	if (unlikely(crng_init == 0))
+		crng_pre_init_inject(buffer, count);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
@@ -1321,13 +1313,10 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
-	if (unlikely(crng_init == 0)) {
-		crng_pre_init_inject(pool, sizeof(pool), true);
-		mix_pool_bytes(pool, sizeof(pool));
-	} else {
-		mix_pool_bytes(pool, sizeof(pool));
-		credit_entropy_bits(1);
-	}
+	mix_pool_bytes(pool, sizeof(pool));
+	credit_entropy_bits(1);
+	if (unlikely(crng_init == 0))
+		crng_pre_init_inject(pool, sizeof(pool));
 
 	memzero_explicit(pool, sizeof(pool));
 }
-- 
2.35.1

