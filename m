Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915694AFF82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiBIVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:54:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiBIVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:54:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBCFE00E163
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48BF161BE2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427E3C340ED;
        Wed,  9 Feb 2022 21:54:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LyNnd3Xl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644443655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZA5TUMy5EApsU7ipAieW1jHZtE49sKMZF16KJlh4k1g=;
        b=LyNnd3Xl/EwYYpUZB+lMM12SdcyQRd1LomRAffnSYfS1m5gxiFFDcr73QfMzGGs0EjUdtu
        bKJr6rRO9mBzY3i2F1DWbrdNTrXJ6kzYhIfy3YltvEBuSVigkQNGRvtaxXfRV+DsE+iw9R
        jjdUus9/M5TY1sCyH+PGc/Wjs7SHNYc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1f9ecd23 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 21:54:15 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: tie batched entropy generation to base_crng generation
Date:   Wed,  9 Feb 2022 22:54:06 +0100
Message-Id: <20220209215406.18850-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
References: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
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

Now that we have an explicit base_crng generation counter, we don't need
a separate one for batched entropy. Rather, we can just move the
generation forward every time we change crng_init state.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 999f1d164e72..f4d432305869 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -431,8 +431,6 @@ static DEFINE_PER_CPU(struct crng, crngs) = {
 
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 
-static void invalidate_batched_entropy(void);
-
 /*
  * crng_fast_load() can be called by code in the interrupt service
  * path.  So we can't afford to dilly-dally. Returns the number of
@@ -455,7 +453,7 @@ static size_t crng_fast_load(const void *cp, size_t len)
 		src++; crng_init_cnt++; len--; ret++;
 	}
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
-		invalidate_batched_entropy();
+		++base_crng.generation;
 		crng_init = 1;
 	}
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -536,7 +534,6 @@ static void crng_reseed(void)
 	spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
 	if (finalize_init) {
-		invalidate_batched_entropy();
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -1278,7 +1275,7 @@ int __init rand_initialize(void)
 
 	extract_entropy(base_crng.key, sizeof(base_crng.key));
 	if (arch_init && trust_cpu && crng_init < 2) {
-		invalidate_batched_entropy();
+		++base_crng.generation;
 		crng_init = 2;
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
@@ -1628,8 +1625,6 @@ static int __init random_sysctls_init(void)
 device_initcall(random_sysctls_init);
 #endif	/* CONFIG_SYSCTL */
 
-static atomic_t batch_generation = ATOMIC_INIT(0);
-
 struct batched_entropy {
 	union {
 		/* We make this 1.5x a ChaCha block, so that we get the
@@ -1642,8 +1637,8 @@ struct batched_entropy {
 		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
 	};
 	local_lock_t lock;
+	unsigned long generation;
 	unsigned int position;
-	int generation;
 };
 
 /*
@@ -1662,14 +1657,14 @@ u64 get_random_u64(void)
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
-	int next_gen;
+	unsigned long next_gen;
 
 	warn_unseeded_randomness(&previous);
 
 	local_lock_irqsave(&batched_entropy_u64.lock, flags);
 	batch = raw_cpu_ptr(&batched_entropy_u64);
 
-	next_gen = atomic_read(&batch_generation);
+	next_gen = READ_ONCE(base_crng.generation);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
 	    next_gen != batch->generation) {
 		_get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
@@ -1695,14 +1690,14 @@ u32 get_random_u32(void)
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
-	int next_gen;
+	unsigned long next_gen;
 
 	warn_unseeded_randomness(&previous);
 
 	local_lock_irqsave(&batched_entropy_u32.lock, flags);
 	batch = raw_cpu_ptr(&batched_entropy_u32);
 
-	next_gen = atomic_read(&batch_generation);
+	next_gen = READ_ONCE(base_crng.generation);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
 	    next_gen != batch->generation) {
 		_get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
@@ -1718,15 +1713,6 @@ u32 get_random_u32(void)
 }
 EXPORT_SYMBOL(get_random_u32);
 
-/* It's important to invalidate all potential batched entropy that might
- * be stored before the crng is initialized, which we can do lazily by
- * bumping the generation counter.
- */
-static void invalidate_batched_entropy(void)
-{
-	atomic_inc(&batch_generation);
-}
-
 /**
  * randomize_page - Generate a random, page aligned address
  * @start:	The smallest acceptable address the caller will take.
-- 
2.35.0

