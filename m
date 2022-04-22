Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D850B84A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447892AbiDVNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447899AbiDVNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6795676A;
        Fri, 22 Apr 2022 06:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0579C6204E;
        Fri, 22 Apr 2022 13:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1947C385A4;
        Fri, 22 Apr 2022 13:20:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nD0Zq1ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650633633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lec7he2H3n7gY2Exf/DL8S+g8i3DmcB+5UB7pKAzxc0=;
        b=nD0Zq1objcVxhE19jF6TYy36Wt8EUAfXsKZUWlzK3kQutyWJ2S2VVx1H31BnONpKptnY31
        JukOcpYoROg/Jbfre0ig3BJFnl7rAM8quXSgDVOkeN5pzobxyDTuDQNnirnbAmCfngNg8L
        95bWmbaIzJNyRy0fx2Xj6Q27B6oZgI0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df490c38 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 13:20:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] random: vary jitter iterations based on cycle counter speed
Date:   Fri, 22 Apr 2022 15:20:27 +0200
Message-Id: <20220422132027.1267060-1-Jason@zx2c4.com>
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

Currently, we do the jitter dance if two consecutive reads to the cycle
counter return different values. If they do, then we consider the cycle
counter to be fast enough that one trip through the scheduler will yield
one "bit" of credited entropy. If those two reads return the same value,
then we assume the cycle counter is too slow to show meaningful
differences.

This methodology is flawed for a variety of reasons, one of which Eric
posted a patch to fix in [1]. The issue that patch solves is that on a
system with a slow counter, you might be [un]lucky and read the counter
_just_ before it changes, so that the second cycle counter you read
differs from the first, even though there's usually quite a large period
of time in between the two. For example:

| real time | cycle counter |
| --------- | ------------- |
| 3         | 5             |
| 4         | 5             |
| 5         | 5             |
| 6         | 5             |
| 7         | 5             | <--- a
| 8         | 6             | <--- b
| 9         | 6             | <--- c

If we read the counter at (a) and compare it to (b), we might be fooled
into thinking that it's a fast counter, when in reality it is not. The
solution in [1] is to also compare counter (b) to counter (c), on the
theory that if the counter is _actually_ slow, and (a)!=(b), then
certainly (b)==(c).

This helps solve this particular issue, in one sense, but in another
sense, it mostly functions to disallow jitter entropy on these systems,
rather than simply taking more samples in that case.

Instead, this patch takes a different approach. Right now we assume that
a difference in one set of consecutive samples means one "bit" of
credited entropy per scheduler trip. We can extend this so that a
difference in two sets of consecutive samples means one "bit" of
credited entropy per /two/ scheduler trips, and three for three, and
four for four. In other words, we can increase the amount of jitter
"work" we require for each "bit", depending on how slow the cycle
counter is.

So this patch takes whole bunch of samples, sees how many of them are
different, and divides to find the amount of work required per "bit",
and also requires that at least some minimum of them are different in
order to attempt any jitter entropy.

Note that this approach is still far from perfect. It's not a real
statistical estimate on how much these samples vary; it's not a
real-time analysis of the relevant input data. That remains a project
for another time. However, it does the same (partly flawed) assumptions
as the code that's there now, so it's probably not worse than the status
quo, and it handles the issue Eric mentioned in [1]. But, again, it's
probably a far cry from whatever a really robust version of this would
be.

[1] https://lore.kernel.org/lkml/20220421233152.58522-1-ebiggers@kernel.org/
    https://lore.kernel.org/lkml/20220421192939.250680-1-ebiggers@kernel.org/

Cc: Eric Biggers <ebiggers@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This is an argument very much centered around the somewhat low bar of
being "not worse than before". If you can think of ways that it doesn't
even manage to clear that, please do pipe up.


 drivers/char/random.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf89c6f27a19..94a2ddb53662 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1354,6 +1354,12 @@ void add_interrupt_randomness(int irq)
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
+struct entropy_timer_state {
+	unsigned long entropy;
+	struct timer_list timer;
+	unsigned int samples, samples_per_bit;
+};
+
 /*
  * Each time the timer fires, we expect that we got an unpredictable
  * jump in the cycle counter. Even if the timer is running on another
@@ -1367,9 +1373,14 @@ EXPORT_SYMBOL_GPL(add_interrupt_randomness);
  *
  * So the re-arming always happens in the entropy loop itself.
  */
-static void entropy_timer(struct timer_list *t)
+static void entropy_timer(struct timer_list *timer)
 {
-	credit_entropy_bits(1);
+	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
+
+	if (++state->samples == state->samples_per_bit) {
+		credit_entropy_bits(1);
+		state->samples = 0;
+	}
 }
 
 /*
@@ -1378,17 +1389,22 @@ static void entropy_timer(struct timer_list *t)
  */
 static void try_to_generate_entropy(void)
 {
-	struct {
-		unsigned long entropy;
-		struct timer_list timer;
-	} stack;
-
-	stack.entropy = random_get_entropy();
+	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = 256 };
+	struct entropy_timer_state stack;
+	unsigned int i, num_different = 0;
+	unsigned long last = random_get_entropy();
 
-	/* Slow counter - or none. Don't even bother */
-	if (stack.entropy == random_get_entropy())
+	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
+		stack.entropy = random_get_entropy();
+		if (stack.entropy != last)
+			++num_different;
+		last = stack.entropy;
+	}
+	stack.samples_per_bit = DIV_ROUND_UP(NUM_TRIAL_SAMPLES, num_different + 1);
+	if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
 		return;
 
+	stack.samples = 0;
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {
 		if (!timer_pending(&stack.timer))
-- 
2.35.1

