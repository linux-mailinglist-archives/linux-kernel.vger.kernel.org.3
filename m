Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BD5069D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiDSLXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350858AbiDSLVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22162E09A;
        Tue, 19 Apr 2022 04:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D306612D0;
        Tue, 19 Apr 2022 11:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3650C385A7;
        Tue, 19 Apr 2022 11:18:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I3X+jpvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650367105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hu1lHLanvuWgDiYPkgc7jxugEFdHG8nWUyE1TlHRrEs=;
        b=I3X+jpvJ/H/1MHx6fukdrBoqeo4pX/TzwYyIFJT9mcQxoK+KP3JqAiCLrSpR13OisSgbvX
        +xbn/MENCQhI3XnaZWgLA8SdLVGAveNF5SRI0U4L1ltNa5L3Ug/hOc6rNjgqKvNbh486yW
        HdkefqJykYAuCUzzGF0vdTQBjaDxgw4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0fd8e3d6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Apr 2022 11:18:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v5 11/11] random: insist on random_get_entropy() existing in order to simplify
Date:   Tue, 19 Apr 2022 13:16:50 +0200
Message-Id: <20220419111650.1582274-12-Jason@zx2c4.com>
In-Reply-To: <20220419111650.1582274-1-Jason@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
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

All platforms are now guaranteed to provide some value for
random_get_entropy(). In case some bug leads to this not being so, we
print a warning, because that indicates that something is really very
wrong (and likely other things are impacted too). This should never be
hit, but it's a good and cheap way of finding out if something ever is
problematic.

Since we now have viable fallback code for random_get_entropy() on all
platforms, which is, in the worst case, not worse than jiffies, we can
count on getting the best possible value out of it. That means there's
no longer a use for using jiffies as entropy input. It also means we no
longer have a reason for doing the round-robin register flow in the IRQ
handler, which was always of fairly dubious value.

Instead we can greatly simplify the IRQ handler inputs and also unify
the construction between 64-bits and 32-bits. We now collect the cycle
counter and the return address, since those are the two things that
matter. Because the return address and the irq number are likely
related, to the extent we mix in the irq number, we can just xor it into
the top unchanging bytes of the return address, rather than the bottom
changing bytes of the cycle counter as before. Then, we can do a fixed 2
rounds of SipHash/HSipHash. Finally, we use the same construction of
hashing only half of the [H]SipHash state on 32-bit and 64-bit. We're
not actually discarding any entropy, since that entropy is carried
through until the next time. And more importantly, it lets us do the
same sponge-like construction everywhere.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 89 ++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4c9adb4f3d5d..bf89c6f27a19 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1012,6 +1012,9 @@ int __init rand_initialize(void)
 		urandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
 	}
+
+	WARN(!random_get_entropy(), "Missing cycle counter and fallback timer; RNG "
+				    "entropy collection will consequently suffer.");
 	return 0;
 }
 
@@ -1025,15 +1028,14 @@ int __init rand_initialize(void)
  */
 void add_device_randomness(const void *buf, size_t size)
 {
-	unsigned long cycles = random_get_entropy();
-	unsigned long flags, now = jiffies;
+	unsigned long entropy = random_get_entropy();
+	unsigned long flags;
 
 	if (crng_init == 0 && size)
 		crng_pre_init_inject(buf, size, false);
 
 	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(&cycles, sizeof(cycles));
-	_mix_pool_bytes(&now, sizeof(now));
+	_mix_pool_bytes(&entropy, sizeof(entropy));
 	_mix_pool_bytes(buf, size);
 	spin_unlock_irqrestore(&input_pool.lock, flags);
 }
@@ -1056,12 +1058,11 @@ struct timer_rand_state {
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
 {
-	unsigned long cycles = random_get_entropy(), now = jiffies, flags;
+	unsigned long entropy = random_get_entropy(), now = jiffies, flags;
 	long delta, delta2, delta3;
 
 	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(&cycles, sizeof(cycles));
-	_mix_pool_bytes(&now, sizeof(now));
+	_mix_pool_bytes(&entropy, sizeof(entropy));
 	_mix_pool_bytes(&num, sizeof(num));
 	spin_unlock_irqrestore(&input_pool.lock, flags);
 
@@ -1223,7 +1224,6 @@ struct fast_pool {
 	unsigned long pool[4];
 	unsigned long last;
 	unsigned int count;
-	u16 reg_idx;
 };
 
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
@@ -1241,13 +1241,13 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
  * This is [Half]SipHash-1-x, starting from an empty key. Because
  * the key is fixed, it assumes that its inputs are non-malicious,
  * and therefore this has no security on its own. s represents the
- * 128 or 256-bit SipHash state, while v represents a 128-bit input.
+ * four-word SipHash state, while v represents a two-word input.
  */
-static void fast_mix(unsigned long s[4], const unsigned long *v)
+static void fast_mix(unsigned long s[4], const unsigned long v[2])
 {
 	size_t i;
 
-	for (i = 0; i < 16 / sizeof(long); ++i) {
+	for (i = 0; i < 2; ++i) {
 		s[3] ^= v[i];
 #ifdef CONFIG_64BIT
 		s[0] += s[1]; s[1] = rol64(s[1], 13); s[1] ^= s[0]; s[0] = rol64(s[0], 32);
@@ -1287,33 +1287,17 @@ int random_online_cpu(unsigned int cpu)
 }
 #endif
 
-static unsigned long get_reg(struct fast_pool *f, struct pt_regs *regs)
-{
-	unsigned long *ptr = (unsigned long *)regs;
-	unsigned int idx;
-
-	if (regs == NULL)
-		return 0;
-	idx = READ_ONCE(f->reg_idx);
-	if (idx >= sizeof(struct pt_regs) / sizeof(unsigned long))
-		idx = 0;
-	ptr += idx++;
-	WRITE_ONCE(f->reg_idx, idx);
-	return *ptr;
-}
-
 static void mix_interrupt_randomness(struct work_struct *work)
 {
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
 	/*
-	 * The size of the copied stack pool is explicitly 16 bytes so that we
-	 * tax mix_pool_byte()'s compression function the same amount on all
-	 * platforms. This means on 64-bit we copy half the pool into this,
-	 * while on 32-bit we copy all of it. The entropy is supposed to be
-	 * sufficiently dispersed between bits that in the sponge-like
-	 * half case, on average we don't wind up "losing" some.
+	 * The size of the copied stack pool is explicitly 2 longs so that we
+	 * only ever ingest half of the siphash output each time, retaining
+	 * the other half as the next "key" that carries over. The entropy is
+	 * supposed to be sufficiently dispersed between bits so on average
+	 * we don't wind up "losing" some.
 	 */
-	u8 pool[16];
+	unsigned long pool[2];
 
 	/* Check to see if we're running on the wrong CPU due to hotplug. */
 	local_irq_disable();
@@ -1345,36 +1329,21 @@ static void mix_interrupt_randomness(struct work_struct *work)
 void add_interrupt_randomness(int irq)
 {
 	enum { MIX_INFLIGHT = 1U << 31 };
-	unsigned long cycles = random_get_entropy(), now = jiffies;
+	unsigned long cycles = random_get_entropy();
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned int new_count;
-	union {
-		u32 u32[4];
-		u64 u64[2];
-		unsigned long longs[16 / sizeof(long)];
-	} irq_data;
-
-	if (cycles == 0)
-		cycles = get_reg(fast_pool, regs);
-
-	if (sizeof(unsigned long) == 8) {
-		irq_data.u64[0] = cycles ^ rol64(now, 32) ^ irq;
-		irq_data.u64[1] = regs ? instruction_pointer(regs) : _RET_IP_;
-	} else {
-		irq_data.u32[0] = cycles ^ irq;
-		irq_data.u32[1] = now;
-		irq_data.u32[2] = regs ? instruction_pointer(regs) : _RET_IP_;
-		irq_data.u32[3] = get_reg(fast_pool, regs);
-	}
 
-	fast_mix(fast_pool->pool, irq_data.longs);
+	fast_mix(fast_pool->pool, (unsigned long[2]){
+		(regs ? instruction_pointer(regs) : _RET_IP_) ^ swab(irq),
+		cycles
+	});
 	new_count = ++fast_pool->count;
 
 	if (new_count & MIX_INFLIGHT)
 		return;
 
-	if (new_count < 64 && (!time_after(now, fast_pool->last + HZ) ||
+	if (new_count < 64 && (!time_is_before_jiffies(fast_pool->last + HZ) ||
 			       unlikely(crng_init == 0)))
 		return;
 
@@ -1410,28 +1379,28 @@ static void entropy_timer(struct timer_list *t)
 static void try_to_generate_entropy(void)
 {
 	struct {
-		unsigned long cycles;
+		unsigned long entropy;
 		struct timer_list timer;
 	} stack;
 
-	stack.cycles = random_get_entropy();
+	stack.entropy = random_get_entropy();
 
 	/* Slow counter - or none. Don't even bother */
-	if (stack.cycles == random_get_entropy())
+	if (stack.entropy == random_get_entropy())
 		return;
 
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {
 		if (!timer_pending(&stack.timer))
 			mod_timer(&stack.timer, jiffies + 1);
-		mix_pool_bytes(&stack.cycles, sizeof(stack.cycles));
+		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 		schedule();
-		stack.cycles = random_get_entropy();
+		stack.entropy = random_get_entropy();
 	}
 
 	del_timer_sync(&stack.timer);
 	destroy_timer_on_stack(&stack.timer);
-	mix_pool_bytes(&stack.cycles, sizeof(stack.cycles));
+	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 }
 
 
-- 
2.35.1

