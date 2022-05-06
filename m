Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7086E51E16F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444614AbiEFV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiEFV6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:58:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46056FA25;
        Fri,  6 May 2022 14:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84753B8366B;
        Fri,  6 May 2022 21:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4CDC385A9;
        Fri,  6 May 2022 21:55:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Pr3GGZvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651874101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l1+Gz1r+S663SM+LnHF0Br7T7zR5BrwJ05uUG5tXH+g=;
        b=Pr3GGZvhztrzf1rkg2zjj/GyWlAMWC6hPCAXHwUg+0dAWVIcTSNjYnZuDiVUQecxhdn3m9
        Lp+uRJj272AJx48vfSsGrv8ws9NYHp+eUaDmsZqf7coNmE1ZbYtOu97Msk63Qq0Sl/ae/m
        kQ36My6lHCkimtmcZPfe2+8SL1Gm6A8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 37c3fc09 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 6 May 2022 21:55:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/3] random: order timer entropy functions below interrupt functions
Date:   Fri,  6 May 2022 23:54:52 +0200
Message-Id: <20220506215454.1671-1-Jason@zx2c4.com>
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

There are no code changes here; this is just a reordering of functions,
so that in subsequent commits, the timer entropy functions can call into
the interrupt ones.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 206 +++++++++++++++++++++---------------------
 1 file changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 893b8f15fcfe..d15f2133e804 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1011,109 +1011,6 @@ void add_device_randomness(const void *buf, size_t size)
 }
 EXPORT_SYMBOL(add_device_randomness);
 
-/* There is one of these per entropy source */
-struct timer_rand_state {
-	unsigned long last_time;
-	long last_delta, last_delta2;
-};
-
-/*
- * This function adds entropy to the entropy "pool" by using timing
- * delays.  It uses the timer_rand_state structure to make an estimate
- * of how many bits of entropy this call has added to the pool.
- *
- * The number "num" is also added to the pool - it should somehow describe
- * the type of event which just happened.  This is currently 0-255 for
- * keyboard scan codes, and 256 upwards for interrupts.
- */
-static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
-{
-	unsigned long entropy = random_get_entropy(), now = jiffies, flags;
-	long delta, delta2, delta3;
-
-	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(&entropy, sizeof(entropy));
-	_mix_pool_bytes(&num, sizeof(num));
-	spin_unlock_irqrestore(&input_pool.lock, flags);
-
-	if (crng_ready())
-		return;
-
-	/*
-	 * Calculate number of bits of randomness we probably added.
-	 * We take into account the first, second and third-order deltas
-	 * in order to make our estimate.
-	 */
-	delta = now - READ_ONCE(state->last_time);
-	WRITE_ONCE(state->last_time, now);
-
-	delta2 = delta - READ_ONCE(state->last_delta);
-	WRITE_ONCE(state->last_delta, delta);
-
-	delta3 = delta2 - READ_ONCE(state->last_delta2);
-	WRITE_ONCE(state->last_delta2, delta2);
-
-	if (delta < 0)
-		delta = -delta;
-	if (delta2 < 0)
-		delta2 = -delta2;
-	if (delta3 < 0)
-		delta3 = -delta3;
-	if (delta > delta2)
-		delta = delta2;
-	if (delta > delta3)
-		delta = delta3;
-
-	/*
-	 * delta is now minimum absolute delta.
-	 * Round down by 1 bit on general principles,
-	 * and limit entropy estimate to 12 bits.
-	 */
-	credit_init_bits(min_t(unsigned int, fls(delta >> 1), 11));
-}
-
-void add_input_randomness(unsigned int type, unsigned int code,
-			  unsigned int value)
-{
-	static unsigned char last_value;
-	static struct timer_rand_state input_timer_state = { INITIAL_JIFFIES };
-
-	/* Ignore autorepeat and the like. */
-	if (value == last_value)
-		return;
-
-	last_value = value;
-	add_timer_randomness(&input_timer_state,
-			     (type << 4) ^ code ^ (code >> 4) ^ value);
-}
-EXPORT_SYMBOL_GPL(add_input_randomness);
-
-#ifdef CONFIG_BLOCK
-void add_disk_randomness(struct gendisk *disk)
-{
-	if (!disk || !disk->random)
-		return;
-	/* First major is 1, so we get >= 0x200 here. */
-	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
-}
-EXPORT_SYMBOL_GPL(add_disk_randomness);
-
-void rand_initialize_disk(struct gendisk *disk)
-{
-	struct timer_rand_state *state;
-
-	/*
-	 * If kzalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
-	if (state) {
-		state->last_time = INITIAL_JIFFIES;
-		disk->random = state;
-	}
-}
-#endif
-
 /*
  * Interface for in-kernel drivers of true hardware RNGs.
  * Those devices may produce endless random bits and will be throttled
@@ -1310,6 +1207,109 @@ void add_interrupt_randomness(int irq)
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
+/* There is one of these per entropy source */
+struct timer_rand_state {
+	unsigned long last_time;
+	long last_delta, last_delta2;
+};
+
+/*
+ * This function adds entropy to the entropy "pool" by using timing
+ * delays.  It uses the timer_rand_state structure to make an estimate
+ * of how many bits of entropy this call has added to the pool.
+ *
+ * The number "num" is also added to the pool - it should somehow describe
+ * the type of event which just happened.  This is currently 0-255 for
+ * keyboard scan codes, and 256 upwards for interrupts.
+ */
+static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
+{
+	unsigned long entropy = random_get_entropy(), now = jiffies, flags;
+	long delta, delta2, delta3;
+
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(&entropy, sizeof(entropy));
+	_mix_pool_bytes(&num, sizeof(num));
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+
+	if (crng_ready())
+		return;
+
+	/*
+	 * Calculate number of bits of randomness we probably added.
+	 * We take into account the first, second and third-order deltas
+	 * in order to make our estimate.
+	 */
+	delta = now - READ_ONCE(state->last_time);
+	WRITE_ONCE(state->last_time, now);
+
+	delta2 = delta - READ_ONCE(state->last_delta);
+	WRITE_ONCE(state->last_delta, delta);
+
+	delta3 = delta2 - READ_ONCE(state->last_delta2);
+	WRITE_ONCE(state->last_delta2, delta2);
+
+	if (delta < 0)
+		delta = -delta;
+	if (delta2 < 0)
+		delta2 = -delta2;
+	if (delta3 < 0)
+		delta3 = -delta3;
+	if (delta > delta2)
+		delta = delta2;
+	if (delta > delta3)
+		delta = delta3;
+
+	/*
+	 * delta is now minimum absolute delta.
+	 * Round down by 1 bit on general principles,
+	 * and limit entropy estimate to 12 bits.
+	 */
+	credit_init_bits(min_t(unsigned int, fls(delta >> 1), 11));
+}
+
+void add_input_randomness(unsigned int type, unsigned int code,
+			  unsigned int value)
+{
+	static unsigned char last_value;
+	static struct timer_rand_state input_timer_state = { INITIAL_JIFFIES };
+
+	/* Ignore autorepeat and the like. */
+	if (value == last_value)
+		return;
+
+	last_value = value;
+	add_timer_randomness(&input_timer_state,
+			     (type << 4) ^ code ^ (code >> 4) ^ value);
+}
+EXPORT_SYMBOL_GPL(add_input_randomness);
+
+#ifdef CONFIG_BLOCK
+void add_disk_randomness(struct gendisk *disk)
+{
+	if (!disk || !disk->random)
+		return;
+	/* First major is 1, so we get >= 0x200 here. */
+	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
+}
+EXPORT_SYMBOL_GPL(add_disk_randomness);
+
+void rand_initialize_disk(struct gendisk *disk)
+{
+	struct timer_rand_state *state;
+
+	/*
+	 * If kzalloc returns null, we just won't use that entropy
+	 * source.
+	 */
+	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	if (state) {
+		state->last_time = INITIAL_JIFFIES;
+		disk->random = state;
+	}
+}
+#endif
+
 struct entropy_timer_state {
 	unsigned long entropy;
 	struct timer_list timer;
-- 
2.35.1

