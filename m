Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF964B0E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbiBJNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:13:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9C113F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F71B824B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737A4C004E1;
        Thu, 10 Feb 2022 13:13:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hR3fwfat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644498794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzzyXRQXp1fF2yvhjaLxOErxhAVSjKgIdCU6rMFCToc=;
        b=hR3fwfatTqVS4+eNt/tG8z1aIvnKYVXs5swQt1n88Q2hgTzHZanflrrTR1rGNOy2ukspm6
        X64RtyboJL6M1QvLRnrAnhw2Q48dI2G1sF49v0cNuPFsvuc/Y1jUN+/sVxr3LH7KOp2JA3
        1hNkZbsmTxddm5GgbSmZZY8ILw/j4oM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 71accad9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 13:13:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] random: tie batched entropy generation to base_crng generation
Date:   Thu, 10 Feb 2022 14:13:04 +0100
Message-Id: <20220210131304.97224-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9oo5y08skaOOXg-q0T9pDs580dOotm6Wz0t96AssZr2Pw@mail.gmail.com>
References: <CAHmME9oo5y08skaOOXg-q0T9pDs580dOotm6Wz0t96AssZr2Pw@mail.gmail.com>
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
generation forward every time we change crng_init state or update the
base_crng key.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v2 always increments the generation after extraction, as suggested by
Dominik.

 drivers/char/random.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5beb421ec12b..57d36f13e3a6 100644
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
@@ -530,7 +528,6 @@ static void crng_reseed(void)
 	WRITE_ONCE(base_crng.generation, next_gen);
 	base_crng.birth = jiffies;
 	if (crng_init < 2) {
-		invalidate_batched_entropy();
 		crng_init = 2;
 		finalize_init = true;
 	}
@@ -1277,8 +1274,9 @@ int __init rand_initialize(void)
 	mix_pool_bytes(utsname(), sizeof(*(utsname())));
 
 	extract_entropy(base_crng.key, sizeof(base_crng.key));
+	++base_crng.generation;
+
 	if (arch_init && trust_cpu && crng_init < 2) {
-		invalidate_batched_entropy();
 		crng_init = 2;
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
@@ -1628,8 +1626,6 @@ static int __init random_sysctls_init(void)
 device_initcall(random_sysctls_init);
 #endif	/* CONFIG_SYSCTL */
 
-static atomic_t batch_generation = ATOMIC_INIT(0);
-
 struct batched_entropy {
 	union {
 		/* We make this 1.5x a ChaCha block, so that we get the
@@ -1642,8 +1638,8 @@ struct batched_entropy {
 		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
 	};
 	local_lock_t lock;
+	unsigned long generation;
 	unsigned int position;
-	int generation;
 };
 
 /*
@@ -1662,14 +1658,14 @@ u64 get_random_u64(void)
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
@@ -1695,14 +1691,14 @@ u32 get_random_u32(void)
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
@@ -1718,15 +1714,6 @@ u32 get_random_u32(void)
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

