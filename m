Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56194F9C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiDHRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiDHRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:55:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C0E6F;
        Fri,  8 Apr 2022 10:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE254B82C8F;
        Fri,  8 Apr 2022 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB564C385A3;
        Fri,  8 Apr 2022 17:53:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wm8m1w8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649440409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5zTBxxqGHBh1YMYwKpsz6sj1OtWasH7QBHDbsBR2tQI=;
        b=Wm8m1w8ZuQw2ZAuuVODA7It85g7bEKhVeUcxEeFGPXglBrYWyog48wvnUojKl7o24N9Xfg
        dHn8gOp2kqJrIGxpqB0HzRTc9Av+P8lswqWsL8EESNEk14upHnQ8RCYkrXOVdq3wIO4TGG
        9A0dBymn7bOtUV89ep8riIP5a4Omq1s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7dd1ebb5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Apr 2022 17:53:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: make random_get_entropy() return an unsigned long
Date:   Fri,  8 Apr 2022 19:53:17 +0200
Message-Id: <20220408175317.140778-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementations were returning type `unsigned long`, while others
that fell back to get_cycles() were implicitly returning a `cycles_t` or
an untyped constant int literal. That makes for weird and confusing
code, and basically all code in the kernel already handled it like it
was an `unsigned long`. I recently tried to handle it as the largest
type it could be, a `cycles_t`, but doing so doesn't really help with
much. Instead let's just make random_get_entropy() return an unsigned
long all the time. This also matches the commonly used
`arch_get_random_long()` function, so now RDRAND and RDTSC return the
same sized integer, which means one can fallback to the other more
gracefully.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 20 +++++++-------------
 include/linux/timex.h |  2 +-
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index df43c5060f00..6b01b2be9dd4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1018,7 +1018,7 @@ int __init rand_initialize(void)
  */
 void add_device_randomness(const void *buf, size_t size)
 {
-	cycles_t cycles = random_get_entropy();
+	unsigned long cycles = random_get_entropy();
 	unsigned long flags, now = jiffies;
 
 	if (crng_init == 0 && size)
@@ -1049,8 +1049,7 @@ struct timer_rand_state {
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
 {
-	cycles_t cycles = random_get_entropy();
-	unsigned long flags, now = jiffies;
+	unsigned long cycles = random_get_entropy(), now = jiffies, flags;
 	long delta, delta2, delta3;
 
 	spin_lock_irqsave(&input_pool.lock, flags);
@@ -1339,8 +1338,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 void add_interrupt_randomness(int irq)
 {
 	enum { MIX_INFLIGHT = 1U << 31 };
-	cycles_t cycles = random_get_entropy();
-	unsigned long now = jiffies;
+	unsigned long cycles = random_get_entropy(), now = jiffies;
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned int new_count;
@@ -1353,16 +1351,12 @@ void add_interrupt_randomness(int irq)
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
 
-	if (sizeof(cycles) == 8)
+	if (sizeof(unsigned long) == 8) {
 		irq_data.u64[0] = cycles ^ rol64(now, 32) ^ irq;
-	else {
+		irq_data.u64[1] = regs ? instruction_pointer(regs) : _RET_IP_;
+	} else {
 		irq_data.u32[0] = cycles ^ irq;
 		irq_data.u32[1] = now;
-	}
-
-	if (sizeof(unsigned long) == 8)
-		irq_data.u64[1] = regs ? instruction_pointer(regs) : _RET_IP_;
-	else {
 		irq_data.u32[2] = regs ? instruction_pointer(regs) : _RET_IP_;
 		irq_data.u32[3] = get_reg(fast_pool, regs);
 	}
@@ -1409,7 +1403,7 @@ static void entropy_timer(struct timer_list *t)
 static void try_to_generate_entropy(void)
 {
 	struct {
-		cycles_t cycles;
+		unsigned long cycles;
 		struct timer_list timer;
 	} stack;
 
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 059b18eb1f1f..5745c90c8800 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -75,7 +75,7 @@
  * By default we use get_cycles() for this purpose, but individual
  * architectures may override this in their asm/timex.h header file.
  */
-#define random_get_entropy()	get_cycles()
+#define random_get_entropy()	((unsigned long)get_cycles())
 #endif
 
 /*
-- 
2.35.1

