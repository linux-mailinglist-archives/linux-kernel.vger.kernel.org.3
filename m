Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C944C46D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiBYNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiBYNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:44:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F5E210D5E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:44:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A654B830AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3ECC340E7;
        Fri, 25 Feb 2022 13:44:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Yzws2aYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645796653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsScRqnnurDnFxh/Bgops4Bq7VfyvIqkC4t8ZFb7a3Y=;
        b=Yzws2aYkKInfGraSU/kyYKuE4mE7Ma4lHDgSHyvKd9VJw8r3y1cYecfRA+QOhTMb4c5vQO
        NImdPw77C6XykHhroTueFINvPDCwRnxfnDfBM8WuznJqfL4EkOLThwXNxVcGQR8i/Ippsi
        NzpKPbTeFFyteionfhyDXiZQ4fvGZn8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9c2e937 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 13:44:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v3] random: unify cycles_t and jiffies usage and types
Date:   Fri, 25 Feb 2022 14:44:08 +0100
Message-Id: <20220225134408.933305-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qsj-Ge0LAXwFjtaMpY6W-G_fB7fTdXQ3rKRGpVpHnDnw@mail.gmail.com>
References: <CAHmME9qsj-Ge0LAXwFjtaMpY6W-G_fB7fTdXQ3rKRGpVpHnDnw@mail.gmail.com>
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

random_get_entropy() returns a cycles_t, not an unsigned long, which is
sometimes 64 bits on various 32-bit platforms, including x86.
Conversely, jiffies is always unsigned long. This commit fixes things to
use cycles_t for fields that use random_get_entropy(), named "cycles",
and unsigned long for fields that use jiffies, named "now". It's also
good to mix in a cycles_t and a jiffies in the same way for both
add_device_randomness and add_timer_randomness, rather than using xor in
one case. Finally, we unify the order of these volatile reads, always
reading the more precise cycles counter, and then jiffies, so that the
cycle counter is as close to the event as possible.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1aeaad4e3c9c..d9321b9bd3e3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1005,12 +1005,6 @@ int __init rand_initialize(void)
 	return 0;
 }
 
-/* There is one of these per entropy source */
-struct timer_rand_state {
-	cycles_t last_time;
-	long last_delta, last_delta2;
-};
-
 /*
  * Add device- or boot-specific data to the input pool to help
  * initialize it.
@@ -1021,19 +1015,26 @@ struct timer_rand_state {
  */
 void add_device_randomness(const void *buf, size_t size)
 {
-	unsigned long time = random_get_entropy() ^ jiffies;
-	unsigned long flags;
+	cycles_t cycles = random_get_entropy();
+	unsigned long flags, now = jiffies;
 
 	if (crng_init == 0 && size)
 		crng_pre_init_inject(buf, size, false);
 
 	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(&cycles, sizeof(cycles));
+	_mix_pool_bytes(&now, sizeof(now));
 	_mix_pool_bytes(buf, size);
-	_mix_pool_bytes(&time, sizeof(time));
 	spin_unlock_irqrestore(&input_pool.lock, flags);
 }
 EXPORT_SYMBOL(add_device_randomness);
 
+/* There is one of these per entropy source */
+struct timer_rand_state {
+	unsigned long last_time;
+	long last_delta, last_delta2;
+};
+
 /*
  * This function adds entropy to the entropy "pool" by using timing
  * delays.  It uses the timer_rand_state structure to make an estimate
@@ -1042,29 +1043,26 @@ EXPORT_SYMBOL(add_device_randomness);
  * The number "num" is also added to the pool - it should somehow describe
  * the type of event which just happened.  This is currently 0-255 for
  * keyboard scan codes, and 256 upwards for interrupts.
- *
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
 {
-	struct {
-		long jiffies;
-		unsigned int cycles;
-		unsigned int num;
-	} sample;
+	cycles_t cycles = random_get_entropy();
+	unsigned long flags, now = jiffies;
 	long delta, delta2, delta3;
 
-	sample.jiffies = jiffies;
-	sample.cycles = random_get_entropy();
-	sample.num = num;
-	mix_pool_bytes(&sample, sizeof(sample));
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(&cycles, sizeof(cycles));
+	_mix_pool_bytes(&now, sizeof(now));
+	_mix_pool_bytes(&num, sizeof(num));
+	spin_unlock_irqrestore(&input_pool.lock, flags);
 
 	/*
 	 * Calculate number of bits of randomness we probably added.
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
-	delta = sample.jiffies - READ_ONCE(state->last_time);
-	WRITE_ONCE(state->last_time, sample.jiffies);
+	delta = now - READ_ONCE(state->last_time);
+	WRITE_ONCE(state->last_time, now);
 
 	delta2 = delta - READ_ONCE(state->last_delta);
 	WRITE_ONCE(state->last_delta, delta);
@@ -1311,10 +1309,10 @@ static void mix_interrupt_randomness(struct work_struct *work)
 void add_interrupt_randomness(int irq)
 {
 	enum { MIX_INFLIGHT = 1U << 31 };
+	cycles_t cycles = random_get_entropy();
+	unsigned long now = jiffies;
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
-	unsigned long now = jiffies;
-	cycles_t cycles = random_get_entropy();
 	unsigned int new_count;
 
 	if (cycles == 0)
@@ -1376,28 +1374,28 @@ static void entropy_timer(struct timer_list *t)
 static void try_to_generate_entropy(void)
 {
 	struct {
-		unsigned long now;
+		cycles_t cycles;
 		struct timer_list timer;
 	} stack;
 
-	stack.now = random_get_entropy();
+	stack.cycles = random_get_entropy();
 
 	/* Slow counter - or none. Don't even bother */
-	if (stack.now == random_get_entropy())
+	if (stack.cycles == random_get_entropy())
 		return;
 
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready()) {
 		if (!timer_pending(&stack.timer))
 			mod_timer(&stack.timer, jiffies + 1);
-		mix_pool_bytes(&stack.now, sizeof(stack.now));
+		mix_pool_bytes(&stack.cycles, sizeof(stack.cycles));
 		schedule();
-		stack.now = random_get_entropy();
+		stack.cycles = random_get_entropy();
 	}
 
 	del_timer_sync(&stack.timer);
 	destroy_timer_on_stack(&stack.timer);
-	mix_pool_bytes(&stack.now, sizeof(stack.now));
+	mix_pool_bytes(&stack.cycles, sizeof(stack.cycles));
 }
 
 
-- 
2.35.1

