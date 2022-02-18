Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8F4BB8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiBRMNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:13:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiBRMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:13:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D8325B6D1;
        Fri, 18 Feb 2022 04:12:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D6A61EE2;
        Fri, 18 Feb 2022 12:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED4EC340EB;
        Fri, 18 Feb 2022 12:12:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hEdMlxBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645186374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KzYFEmiN4EBDBbb24szISASrsjtNHwj+t1rOcmQjGdI=;
        b=hEdMlxBwYlN/UCnkxWvsu+jZ6mNLrxdzvpOwEga9xJdcZEwfxu5NSiW0wbaNO/ad/fvYFA
        q9kGZ7hjzjIFQRoc1E+WgGohf9d9R1WQjb9pzdJFbtJnxvF2EDmAG1mkxW26anHHCraEYp
        Q4wVwvvuRqrvCXW0Eorn933gE6tT1dg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 39d714fb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 18 Feb 2022 12:12:54 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] random: use max-period linear interrupt extractor
Date:   Fri, 18 Feb 2022 13:10:54 +0100
Message-Id: <20220218121054.45304-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The current fast_mix() function is a piece of classic mailing list
crypto, where it just sort of sprung up without a lot of real analysis
of what precisely it was accomplishing. As an ARX permutation of only
two rounds, there are some easily searchable differential trails in it,
and as a means of preventing malicious interrupts, it completely fails,
since it xors new data into the entire state every time. It can't really
be analyzed as a random permutation, because it clearly isn't, and it
can't be analyzed as an interesting linear algebraic structure either,
because it's also not that. There really is very little one can say
about it in terms of entropy accumulation. It might diffuse bits, some
of the time, maybe, we hope, I guess. But for the most part, it fails to
accomplish anything concrete.

As a reminder, the simple goal of add_interrupt_randomness() is to
simply accumulate entropy until ~64 interrupts have elapsed, and then
dump it into the main input pool, which uses a cryptographic hash.

It would be nice to have something cryptographically strong in the
interrupt handler itself, in case a malicious interrupt compromises a
per-cpu fast pool within the 64 interrupts / 1 second window, and then
inside of that same window somehow can control its return address and
cycle counter, even if that's a bit far fetched. However, with a very
CPU-limited budget, actually doing that remains an active research
project (and perhaps there'll be something useful for Linux to come out
of it). And while the abundance of caution would be nice, this isn't
*currently* the security model, and we don't yet have a fast enough
solution to make it our security model.  Plus there's not exactly a
pressing need to do that. (And for the avoidance of doubt, the actual
cluster of 64 accumulated interrupts still gets dumped into our
cryptographically secure input pool.)

So, for now we are going to stick with the existing interrupt security
model, which assumes that each cluster of 64 interrupt data samples is
mostly non-malicious and not colluding with an infoleaker. With this as
our goal, we can then endeavor to simply accumulate entropy linearly,
discarding the least amount of it, and make sure that accumulation is
sound, unlike the case with the current fast_mix().

It turns out that this security model is also the trade off that other
operating systems have taken. The NT kernel, for example, uses something
very simple to accumulate entropy in interrupts, `s = ror32(s, 5) ^ x`.
Dodis et al. analyzed this in <https://eprint.iacr.org/2021/523>, and
found that rotation by 7 would have been better than 5, but that
otherwise, simple linear constructions like this can be used as an
entropy collector for 2-monotone distributions.

However, when considering this for our four-word accumulation, versus
NT's one-word, we run into potential problems because the words don't
contribute to each other, and some may well be fixed, which means we'd
need something to schedule on top. And more importantly, our
distribution is not 2-monotone like NT's, because in addition to the
cycle counter, we also include in those 4 words a register value, a
return address, and an inverted jiffies. (Whether capturing anything
beyond the cycle counter in the interrupt handler is even adding much of
value is a question for a different time.)

So since we have 4 words, and not all of them are 2-monotone, we instead
look for a proven linear extractor that works for more complex
distributions. It turns out that a max-period linear feedback shift
register fits this bill quite well, easily extending to the larger state
size and to the fact that we're mixing in more than just the cycle
counter. By picking a linear function with no non-trivial invariant
subspace, unlike NT's rotate-xor, we benefit from the analysis of
<https://eprint.iacr.org/2021/1002>.  This paper proves that those types
of linear functions, used in the form `s = f(s) ^ x`, make very good
entropy extractors for the type of complex distributions that we have.

This commit implements one such very fast and high diffusion max-period
linear function in a Feistel-like fashion, which pipelines quite well.
On an i7-11850H, this takes 34 cycles, versus the original's 65 cycles.
(Though, as a note for posterity: if later this is replaced with some
sort of cryptographic hash function, I'll still be keeping 65 cycles as
my target 😋.) This Magma script, <https://א.cc/TiMyEpmr>, proves that
this construction does indeed yield a linear function of order 2^128-1
whose minimal polynomial is primitive, fitting exactly what we need.

I mention "high diffusion" above, because that apparently was the single
discernible design goal of the original fast_mix(), even though that
didn't wind up helping anything with it. Nonetheless, we take care to
choose a function with pretty high diffusion, even higher than the
original fast_mix(). In other words, we probably don't regress at all
from a perspective of diffusion, even if it's not really the goal here
anyway.

In sum, the security model of this is unchanged from before, yet its
implementation now matches that model much more rigorously. And the
performance is better, which perhaps matters in interrupt context. I
would like to emphasize, again, that the purpose of this commit is to
improve the existing design, by making it analyzable, without changing
anything fundamental to the existing design. There may well be value
down the road in changing up the existing design, using something
cryptographic, or simply using a ring buffer of samples rather than
having a fast_mix() at all , or changing which and how much data we
collect each interrupt, or a variety of other ideas. This commit does
not invalidate the potential for those in the future.

As a final note, the previous fast_mix() was contributed on the mailing
list by an anonymous author, which violates the kernel project's "real
name" policy and has ruffled the feathers of legally-minded people.
Replacing this function should clear up those concerns.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 69 +++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index caa276cfbc76..4dc751ad3854 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1195,44 +1195,33 @@ void add_bootloader_randomness(const void *buf, size_t size)
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 struct fast_pool {
-	union {
-		u32 pool32[4];
-		u64 pool64[2];
-	};
 	struct work_struct mix;
 	unsigned long last;
 	unsigned int count;
+	u32 pool[4];
 	u16 reg_idx;
 };
 
 /*
- * This is a fast mixing routine used by the interrupt randomness
- * collector. It's hardcoded for an 128 bit pool and assumes that any
- * locks that might be needed are taken by the caller.
+ * This is a max-period LFSR, mixing 128 bits into the 128-bit pool.
+ * It assumes that its inputs are non-malicious. It is designed to
+ * be much faster than computing a cryptographic hash function, yet
+ * still accumulate entropy, though it has no security on its own.
  */
-static void fast_mix(u32 pool[4])
+static void fast_mix(u32 h[4], const u32 v[4])
 {
-	u32 a = pool[0],	b = pool[1];
-	u32 c = pool[2],	d = pool[3];
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
+	size_t i;
 
-	pool[0] = a;  pool[1] = b;
-	pool[2] = c;  pool[3] = d;
+	for (i = 0; i < 4; ++i) {
+		u32 w = h[0] ^ h[1] ^ v[i] ^ h[3];
+		w ^= w << 17;
+		w ^= w >> 6;
+		w ^= w >> 9;
+		h[0] = h[1];
+		h[1] = h[2];
+		h[2] = h[3];
+		h[3] = w;
+	}
 }
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
@@ -1291,7 +1280,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * Copy the pool to the stack so that the mixer always has a
 	 * consistent view, before we reenable irqs again.
 	 */
-	memcpy(pool, fast_pool->pool32, sizeof(pool));
+	memcpy(pool, fast_pool->pool, sizeof(pool));
 	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
@@ -1309,35 +1298,39 @@ void add_interrupt_randomness(int irq)
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
 	unsigned int new_count;
+	union {
+		u32 u32[4];
+		u64 u64[2];
+	} irq_data;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
 
 	if (sizeof(cycles) == 8)
-		fast_pool->pool64[0] ^= cycles ^ rol64(now, 32) ^ irq;
+		irq_data.u64[0] = cycles ^ rol64(now, 32) ^ irq;
 	else {
-		fast_pool->pool32[0] ^= cycles ^ irq;
-		fast_pool->pool32[1] ^= now;
+		irq_data.u32[0] = cycles ^ irq;
+		irq_data.u32[1] = now;
 	}
 
 	if (sizeof(unsigned long) == 8)
-		fast_pool->pool64[1] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+		irq_data.u64[1] = regs ? instruction_pointer(regs) : _RET_IP_;
 	else {
-		fast_pool->pool32[2] ^= regs ? instruction_pointer(regs) : _RET_IP_;
-		fast_pool->pool32[3] ^= get_reg(fast_pool, regs);
+		irq_data.u32[2] = regs ? instruction_pointer(regs) : _RET_IP_;
+		irq_data.u32[3] = get_reg(fast_pool, regs);
 	}
 
-	fast_mix(fast_pool->pool32);
+	fast_mix(fast_pool->pool, irq_data.u32);
 	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
-		    crng_pre_init_inject(fast_pool->pool32, sizeof(fast_pool->pool32),
+		    crng_pre_init_inject(fast_pool->pool, sizeof(fast_pool->pool),
 					 true, true) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
 			if (spin_trylock(&input_pool.lock)) {
-				_mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
+				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
 				spin_unlock(&input_pool.lock);
 			}
 		}
-- 
2.35.0

