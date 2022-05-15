Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEEB527798
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiEOMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiEOMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:52:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F87435854
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D175B80CE5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 12:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A63C385B8;
        Sun, 15 May 2022 12:52:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZiMLpABp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652619123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YaXUzN8cIV7XbtzawW082K/tICSDvFVRFypohP8tyl8=;
        b=ZiMLpABpinYKIHxJSdsU70/14JOXTUjyVc/WDMhB79jsLJYO5L6R2YBMonxevSGEoN2CH+
        Dh52aThrmZgr6Z7X5ZnlfgJ5NueForeSijagjQcvI8c92qOlcFFmArHDC3hyV5ba9cG9Zr
        GVDNMEOP3XPIzafB20HKSwpdy5SW4jU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 38e2dcf6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 15 May 2022 12:52:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: unify batched entropy implementations
Date:   Sun, 15 May 2022 14:51:59 +0200
Message-Id: <20220515125159.444709-1-Jason@zx2c4.com>
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

There are currently two separate batched entropy implementations, for
u32 and u64, with nearly identical code, with the goal of avoiding
unaligned memory accesses and letting the buffers be used more
efficiently. Having to maintain these two functions independently is a
bit of a hassle though, considering that they always need to be kept in
sync.

This commit factors them out into a type-generic macro, so that the
expansion produces the same code as before, such that diffing the
assembly shows no differences. This will also make it easier in the
future to add u16 and u8 batches.

This was initially tested using an always_inline function and letting
gcc constant fold the type size in, but the code gen was less efficient,
and in general it was more verbose and harder to follow. So this patch
goes with the boring macro solution, similar to what's already done for
the _wait functions in random.h.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 147 ++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 92 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38b4ed7cd5e2..909c23f66fd8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -507,99 +507,62 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
  * provided by this function is okay, the function wait_for_random_bytes()
  * should be called and return 0 at least once at any point prior.
  */
-struct batched_entropy {
-	union {
-		/*
-		 * We make this 1.5x a ChaCha block, so that we get the
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
-
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock),
-	.position = UINT_MAX
-};
-
-u64 get_random_u64(void)
-{
-	u64 ret;
-	unsigned long flags;
-	struct batched_entropy *batch;
-	unsigned long next_gen;
-
-	warn_unseeded_randomness();
-
-	if  (!crng_ready()) {
-		_get_random_bytes(&ret, sizeof(ret));
-		return ret;
-	}
-
-	local_lock_irqsave(&batched_entropy_u64.lock, flags);
-	batch = raw_cpu_ptr(&batched_entropy_u64);
-
-	next_gen = READ_ONCE(base_crng.generation);
-	if (batch->position >= ARRAY_SIZE(batch->entropy_u64) ||
-	    next_gen != batch->generation) {
-		_get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
-		batch->position = 0;
-		batch->generation = next_gen;
-	}
 
-	ret = batch->entropy_u64[batch->position];
-	batch->entropy_u64[batch->position] = 0;
-	++batch->position;
-	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(get_random_u64);
-
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock),
-	.position = UINT_MAX
-};
-
-u32 get_random_u32(void)
-{
-	u32 ret;
-	unsigned long flags;
-	struct batched_entropy *batch;
-	unsigned long next_gen;
-
-	warn_unseeded_randomness();
-
-	if  (!crng_ready()) {
-		_get_random_bytes(&ret, sizeof(ret));
-		return ret;
-	}
-
-	local_lock_irqsave(&batched_entropy_u32.lock, flags);
-	batch = raw_cpu_ptr(&batched_entropy_u32);
-
-	next_gen = READ_ONCE(base_crng.generation);
-	if (batch->position >= ARRAY_SIZE(batch->entropy_u32) ||
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
+#define DEFINE_BATCHED_ENTROPY(type)						\
+struct batch_ ##type {								\
+	/*									\
+	 * We make this 1.5x a ChaCha block, so that we get the			\
+	 * remaining 32 bytes from fast key erasure, plus one full		\
+	 * block from the detached ChaCha state. We can increase		\
+	 * the size of this later if needed so long as we keep the		\
+	 * formula of (integer_blocks + 0.5) * CHACHA_BLOCK_SIZE.		\
+	 */									\
+	type entropy[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
+	local_lock_t lock;							\
+	unsigned long generation;						\
+	unsigned int position;							\
+};										\
+										\
+static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
+	.lock = INIT_LOCAL_LOCK(batched_entropy_ ##type.lock),			\
+	.position = UINT_MAX							\
+};										\
+										\
+type get_random_ ##type(void)							\
+{										\
+	type ret;								\
+	unsigned long flags;							\
+	struct batch_ ##type *batch;						\
+	unsigned long next_gen;							\
+										\
+	warn_unseeded_randomness();						\
+										\
+	if  (!crng_ready()) {							\
+		_get_random_bytes(&ret, sizeof(ret));				\
+		return ret;							\
+	}									\
+										\
+	local_lock_irqsave(&batched_entropy_ ##type.lock, flags);		\
+	batch = raw_cpu_ptr(&batched_entropy_##type);				\
+										\
+	next_gen = READ_ONCE(base_crng.generation);				\
+	if (batch->position >= ARRAY_SIZE(batch->entropy) ||			\
+	    next_gen != batch->generation) {					\
+		_get_random_bytes(batch->entropy, sizeof(batch->entropy));	\
+		batch->position = 0;						\
+		batch->generation = next_gen;					\
+	}									\
+										\
+	ret = batch->entropy[batch->position];					\
+	batch->entropy[batch->position] = 0;					\
+	++batch->position;							\
+	local_unlock_irqrestore(&batched_entropy_ ##type.lock, flags);		\
+	return ret;								\
+}										\
+EXPORT_SYMBOL(get_random_ ##type);
+
+DEFINE_BATCHED_ENTROPY(u64)
+DEFINE_BATCHED_ENTROPY(u32)
 
 #ifdef CONFIG_SMP
 /*
-- 
2.35.1

