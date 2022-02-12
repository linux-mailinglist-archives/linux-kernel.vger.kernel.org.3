Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC664B3882
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiBLXKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:10:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiBLXKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:10:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77783CFDC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 15:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4109D60EB5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF5CC340E7;
        Sat, 12 Feb 2022 23:10:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P7afH2mX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644707434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrMcdd3SjoJ+OLazLWVd7fj2S+exV5Lv4BE4VyJBDPQ=;
        b=P7afH2mXlsd6PF1RsgGFUKcseNZwjpUKzG0hK+MMa4wP8m18UbwH1wwwFJKeZOxIR5Iz0D
        jR60iBS+pPOOqMgQwWraWmhK4U5sIsrkO93ODz9BAyPcAAF8d2lWP9vpEMmiN/VfZYtCkr
        2R82ho36w7FgOIMzUa99vOM/vP1LKDA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f9e13a61 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 23:10:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/3] random: unify early init crng load accounting
Date:   Sun, 13 Feb 2022 00:10:20 +0100
Message-Id: <20220212231022.679926-2-Jason@zx2c4.com>
In-Reply-To: <20220212231022.679926-1-Jason@zx2c4.com>
References: <20220212231022.679926-1-Jason@zx2c4.com>
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

crng_fast_load() and crng_slow_load() have different semantics:

- crng_fast_load() xors and accounts with crng_init_cnt.
- crng_slow_load() hashes and doesn't account.

However add_hwgenerator_randomness() can afford to hash (it's called
from a kthread), and it should account. Additionally, ones that can
afford to hash don't need to take a trylock but can take a normal lock.
So, we combine these into one function, crng_pre_init_inject(), which
allows us to control these in a uniform way. This will make it simpler
later to simplify this all down when the time comes for that.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 107 ++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8088348190e6..a128bb947bd4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -423,72 +423,74 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 }
 
 /*
- * This function is for crng_init < 2 only.
+ * This function is for crng_init < 2 only. It loads entropy directly
+ * into the crng's key, without going through the input pool. It is,
+ * generally speaking, not very safe, but we use this only at early
+ * boot time when it's better to have something there rather than
+ * nothing.
  *
- * crng_fast_load() can be called by code in the interrupt service
- * path.  So we can't afford to dilly-dally. Returns the number of
- * bytes processed from cp.
+ * There are two paths, a slow one and a fast one. The slow one
+ * hashes the input along with the current key. The fast one simply
+ * xors it in, and should only be used from interrupt context.
+ *
+ * If account is set, then the crng_init_cnt counter is incremented.
+ * This shouldn't be set by functions like add_device_randomness(),
+ * where we can't trust the buffer passed to it is guaranteed to be
+ * unpredictable (so it might not have any entropy at all).
+ *
+ * Returns the number of bytes processed from cp, which is bounded by
+ * CRNG_INIT_CNT_THRESH if account is true.
  */
-static size_t crng_fast_load(const void *cp, size_t len)
+static size_t crng_pre_init_inject(const void *cp, size_t len,
+				   bool fast, bool account)
 {
 	static int crng_init_cnt = 0;
 	unsigned long flags;
-	u8 *src = (u8 *)cp;
-	size_t ret = 0;
+	const u8 *src = cp;
+
+	if (fast) {
+		if (!spin_trylock_irqsave(&base_crng.lock, flags))
+			return 0;
+	} else
+		spin_lock_irqsave(&base_crng.lock, flags);
 
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return 0;
 	if (crng_init != 0) {
 		spin_unlock_irqrestore(&base_crng.lock, flags);
 		return 0;
 	}
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
 
-/*
- * This function is for crng_init < 2 only.
- *
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
- */
-static void crng_slow_load(const void *cp, size_t len)
-{
-	unsigned long flags;
-	struct blake2s_state hash;
+	if (account)
+		len = min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
 
-	blake2s_init(&hash, sizeof(base_crng.key));
+	if (fast) {
+		size_t i;
 
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return;
+		for (i = 0; i < len; ++i)
+			base_crng.key[(crng_init_cnt + i) %
+				      sizeof(base_crng.key)] ^= *src++;
+	} else {
+		struct blake2s_state hash;
+
+		blake2s_init(&hash, sizeof(base_crng.key));
+		blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
+		blake2s_update(&hash, cp, len);
+		blake2s_final(&hash, base_crng.key);
 	}
 
-	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
-	blake2s_update(&hash, cp, len);
-	blake2s_final(&hash, base_crng.key);
+	if (account) {
+		crng_init_cnt += len;
+		if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
+			++base_crng.generation;
+			crng_init = 1;
+		}
+	}
 
 	spin_unlock_irqrestore(&base_crng.lock, flags);
+
+	if (crng_init == 1)
+		pr_notice("fast init done\n");
+
+	return len;
 }
 
 static void _get_random_bytes(void *buf, size_t nbytes)
@@ -1006,7 +1008,7 @@ void add_device_randomness(const void *buf, size_t size)
 	unsigned long flags;
 
 	if (!crng_ready() && size)
-		crng_slow_load(buf, size);
+		crng_pre_init_inject(buf, size, false, false);
 
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(buf, size);
@@ -1123,7 +1125,7 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
 	if (unlikely(crng_init == 0)) {
-		size_t ret = crng_fast_load(buffer, count);
+		size_t ret = crng_pre_init_inject(buffer, count, false, true);
 		mix_pool_bytes(buffer, ret);
 		count -= ret;
 		buffer += ret;
@@ -1279,7 +1281,8 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
-		    crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
+		    crng_pre_init_inject(fast_pool->pool, sizeof(fast_pool->pool),
+					 true, true) > 0) {
 			atomic_set(&fast_pool->count, 0);
 			fast_pool->last = now;
 
-- 
2.35.0

