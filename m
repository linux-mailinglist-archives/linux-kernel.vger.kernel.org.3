Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE7521C96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbiEJOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346452AbiEJOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6766229;
        Tue, 10 May 2022 07:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEBE261A73;
        Tue, 10 May 2022 14:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE3DC385A6;
        Tue, 10 May 2022 14:00:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZZ8WWnpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652191239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqtbADjYfXIDp3JN9Tw1RTeVOC7Y13X6tjcpMOtn5RE=;
        b=ZZ8WWnpN+45kcglJ9p7+CKBgZzE+vT5RCqpU9Yi3GPnleohIv6JYjGDgpvkkNGl0q9AStw
        i028p8YaHxMocfCYHJdNqIoCmIFxbDZo56ybQEG2EPV5jBnoU8CItzddEUcHvsI94osfpF
        eQO1z3M7NiyzaUIPSZtSC89FmpmsZqU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e94206b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 10 May 2022 14:00:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Filipe Manana <fdmanana@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] random: do not use input pool from hard IRQs
Date:   Tue, 10 May 2022 16:00:25 +0200
Message-Id: <20220510140025.81168-1-Jason@zx2c4.com>
In-Reply-To: <20220506215454.1671-2-Jason@zx2c4.com>
References: <20220506215454.1671-2-Jason@zx2c4.com>
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

Years ago, a separate fast pool was added for interrupts, so that the
cost associated with taking the input pool spinlocks and mixing into it
would be avoided in places where latency is critical. However, one
oversight was that add_input_randomness() and add_disk_randomness()
still sometimes are called directly from the interrupt handler, rather
than being deferred to a thread. This means that some unlucky interrupts
will be caught doing a blake2s_compress() call and potentially spinning
on input_pool.lock, which can also be taken by unprivileged users by
writing into /dev/urandom.

In order to fix this , add_timer_randomness() now checks whether it is
being called from a hard IRQ and if so, just mixes into the per-cpu IRQ
fast pool using fast_mix(), which is much faster and can be done
lock-free. A nice consequence of this, as well, is that it means hard
IRQ context FPU support is likely no longer useful.

The entropy estimation algorithm used by add_timer_randomness() is also
somewhat different than the one used for add_interrupt_randomness(). The
former looks at deltas of deltas of deltas, while the latter just waits
for 64 interrupts for one bit or for one second since the last bit. In
order to bridge these, and since add_interrupt_randomness() runs after
an add_timer_randomness() that's called from hard IRQ, we add to the
fast pool credit the related amount, and then subtract one to account
for add_interrupt_randomness()'s contribution.

A downside of this, however, is that the num argument is potentially
attacker controlled, which puts a bit more pressure on the fast_mix()
sponge to do more than it's really intended to do. As a mitigating
factor, the first 96 bits of input aren't attacker controlled (a cycle
counter followed by zeros), which means it's essentially two rounds of
siphash rather than one, which is somewhat better. It's also not that
much different from add_interrupt_randomness()'s use of the irq stack
instruction pointer register.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Filipe Manana <fdmanana@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Restore the estimation counting. Later we might remove entropy
  estimation entirely, but that's a larger project, so for now don't
  perturb the current thing.

 drivers/char/random.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c611fff3e9ec..77cbe40b9b92 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1156,6 +1156,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * we don't wind up "losing" some.
 	 */
 	unsigned long pool[2];
+	unsigned int credit;
 
 	/* Check to see if we're running on the wrong CPU due to hotplug. */
 	local_irq_disable();
@@ -1169,12 +1170,13 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * consistent view, before we reenable irqs again.
 	 */
 	memcpy(pool, fast_pool->pool, sizeof(pool));
+	credit = (fast_pool->count & (U16_MAX - 1)) / 64;
 	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
 	mix_pool_bytes(pool, sizeof(pool));
-	credit_init_bits(1);
+	credit_init_bits(max_t(unsigned int, 1, credit));
 
 	memzero_explicit(pool, sizeof(pool));
 }
@@ -1226,10 +1228,19 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned int nu
 	unsigned long entropy = random_get_entropy(), now = jiffies, flags;
 	long delta, delta2, delta3;
 
-	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(&entropy, sizeof(entropy));
-	_mix_pool_bytes(&num, sizeof(num));
-	spin_unlock_irqrestore(&input_pool.lock, flags);
+	/*
+	 * If we're in a hard IRQ, add_interrupt_randomness() will be called
+	 * sometime after, so mix into the fast pool.
+	 */
+	if (in_hardirq()) {
+		fast_mix(this_cpu_ptr(&irq_randomness)->pool,
+			 (unsigned long[2]){ entropy, num });
+	} else {
+		spin_lock_irqsave(&input_pool.lock, flags);
+		_mix_pool_bytes(&entropy, sizeof(entropy));
+		_mix_pool_bytes(&num, sizeof(num));
+		spin_unlock_irqrestore(&input_pool.lock, flags);
+	}
 
 	if (crng_ready())
 		return;
@@ -1264,7 +1275,19 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned int nu
 	 * Round down by 1 bit on general principles,
 	 * and limit entropy estimate to 12 bits.
 	 */
-	credit_init_bits(min_t(unsigned int, fls(delta >> 1), 11));
+	delta = min_t(unsigned int, fls(delta >> 1), 11);
+
+	/*
+	 * As mentioned above, if we're in a hard IRQ, add_interrupt_randomness()
+	 * will run after this, which uses a different crediting scheme of 1 bit
+	 * per every 64 interrupts. In order to let that function do accounting
+	 * close to the one in this function, we credit a full 64/64 bit per bit,
+	 * and then subtract one to account for the extra one added.
+	 */
+	if (in_hardirq())
+		this_cpu_ptr(&irq_randomness)->count += delta * 64 - 1;
+	else
+		credit_init_bits(delta);
 }
 
 void add_input_randomness(unsigned int type, unsigned int code,
-- 
2.35.1

