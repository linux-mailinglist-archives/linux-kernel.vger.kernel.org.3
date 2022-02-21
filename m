Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC14BE32B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379091AbiBUPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:25:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiBUPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:25:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779F1EEC4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57F30B8121B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E1BC340E9;
        Mon, 21 Feb 2022 15:25:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i5kFHiEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645457104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n6YKeWGkKcn+pgmKzjQ7qIw4/iWtykMXlSfI/M7Xigc=;
        b=i5kFHiEZtcgVN3Wj594UqaIXgTh/ltzrz2QqypGaSO0nBBjWbw5aorhG5BRb7GO3nSv9QY
        3LnPeOgi+weXs2BsmnXq7nqUQJSINhDOz6n6lwINmyRKTLU4LyZftUG2qn6fMUZLaPwyzD
        6eQ0ku3L5aesuOMYga0HxjWcnfhBsQQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 282caffc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 15:25:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     ebiggers@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] random: unify early init crng load accounting
Date:   Mon, 21 Feb 2022 16:24:56 +0100
Message-Id: <20220221152456.2289150-1-Jason@zx2c4.com>
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

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- cp -> input,
- fix comment reference to old function,
- fix brace style.

 drivers/char/random.c | 112 ++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0541066e2e5c..93d01f918720 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -386,7 +386,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	 * For the fast path, we check whether we're ready, unlocked first, and
 	 * then re-check once locked later. In the case where we're really not
 	 * ready, we do fast key erasure with the base_crng directly, because
-	 * this is what crng_{fast,slow}_load mutate during early init.
+	 * this is what crng_pre_init_inject() mutates during early init.
 	 */
 	if (unlikely(!crng_ready())) {
 		bool ready;
@@ -437,72 +437,75 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 }
 
 /*
- * This function is for crng_init == 0 only.
- *
- * crng_fast_load() can be called by code in the interrupt service
- * path.  So we can't afford to dilly-dally. Returns the number of
- * bytes processed from cp.
+ * This function is for crng_init == 0 only. It loads entropy directly
+ * into the crng's key, without going through the input pool. It is,
+ * generally speaking, not very safe, but we use this only at early
+ * boot time when it's better to have something there rather than
+ * nothing.
+ *
+ * There are two paths, a slow one and a fast one. The slow one
+ * hashes the input along with the current key. The fast one simply
+ * xors it in, and should only be used from interrupt context.
+ *
+ * If account is set, then the crng_init_cnt counter is incremented.
+ * This shouldn't be set by functions like add_device_randomness(),
+ * where we can't trust the buffer passed to it is guaranteed to be
+ * unpredictable (so it might not have any entropy at all).
+ *
+ * Returns the number of bytes processed from input, which is bounded
+ * by CRNG_INIT_CNT_THRESH if account is true.
  */
-static size_t crng_fast_load(const void *cp, size_t len)
+static size_t crng_pre_init_inject(const void *input, size_t len,
+				   bool fast, bool account)
 {
 	static int crng_init_cnt = 0;
 	unsigned long flags;
-	const u8 *src = (const u8 *)cp;
-	size_t ret = 0;
 
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return 0;
+	if (fast) {
+		if (!spin_trylock_irqsave(&base_crng.lock, flags))
+			return 0;
+	} else {
+		spin_lock_irqsave(&base_crng.lock, flags);
+	}
+
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
- * This function is for crng_init == 0 only.
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
+		const u8 *src = input;
+		size_t i;
 
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return;
+		for (i = 0; i < len; ++i)
+			base_crng.key[(crng_init_cnt + i) %
+				      sizeof(base_crng.key)] ^= src[i];
+	} else {
+		struct blake2s_state hash;
+
+		blake2s_init(&hash, sizeof(base_crng.key));
+		blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
+		blake2s_update(&hash, input, len);
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
@@ -1018,7 +1021,7 @@ void add_device_randomness(const void *buf, size_t size)
 	unsigned long flags;
 
 	if (!crng_ready() && size)
-		crng_slow_load(buf, size);
+		crng_pre_init_inject(buf, size, false, false);
 
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(buf, size);
@@ -1135,7 +1138,7 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
 	if (unlikely(crng_init == 0)) {
-		size_t ret = crng_fast_load(buffer, count);
+		size_t ret = crng_pre_init_inject(buffer, count, false, true);
 		mix_pool_bytes(buffer, ret);
 		count -= ret;
 		buffer += ret;
@@ -1298,7 +1301,8 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
-		    crng_fast_load(fast_pool->pool32, sizeof(fast_pool->pool32)) > 0) {
+		    crng_pre_init_inject(fast_pool->pool32, sizeof(fast_pool->pool32),
+					 true, true) > 0) {
 			atomic_set(&fast_pool->count, 0);
 			fast_pool->last = now;
 			if (spin_trylock(&input_pool.lock)) {
-- 
2.35.1

