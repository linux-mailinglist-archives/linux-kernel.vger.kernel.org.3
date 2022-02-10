Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE94B13FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbiBJRN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:13:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiBJRNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:13:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4196CD1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5033161D6F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B52C004E1;
        Thu, 10 Feb 2022 17:13:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aPePY1Vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644513234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuAUPQO005cLWrVKY/RuEXRhjRLd9z9W/Gas83LmbBM=;
        b=aPePY1Vn1uJikamHYDXKtBoTGxe38Pc8HH16iaEkmnHQev+r4BUB4u8Og4IbXVcWHYBwJF
        jC1bNLOLs+07SLBfNqYh2tnDVXcFul0/LmLt+zNdZk5etHQ1+VZS07GLcKzE7+FLLyerCo
        gJc5SXtKnlLKypE9A5TNQwowiZohsbA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 07341159 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 17:13:53 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] random: deobfuscate irq u32/u64 contributions
Date:   Thu, 10 Feb 2022 18:13:22 +0100
Message-Id: <20220210171322.165122-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rieCnqNp=n2jOp2z+pS8qo59B0ULWBhRjCHM8awRWMPA@mail.gmail.com>
References: <CAHmME9rieCnqNp=n2jOp2z+pS8qo59B0ULWBhRjCHM8awRWMPA@mail.gmail.com>
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

In the irq handler, we fill out 16 bytes differently on 32-bit and
64-bit platforms. Whether or not you like that, it is a matter of fact.
But it might not be a fact you well realized until now, because the code
that loaded the irq info into 4 32-bit words was quite confusing.
Instead, this commit makes everything explicit by having separate
(compile-time) branches for 32-bit and 64-bit machines. In the process,
we now easily see that we were truncating the contribution of
random_get_entropy() in mix_interrupt_randomness() which we rectify by
using the correct integer type.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Expand commit message's description of mix_interrupt_randomness()
  change.

 drivers/char/random.c | 54 ++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 69b2c7f078d8..324574b03120 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -767,9 +767,12 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
 #endif
 
 struct fast_pool {
+	union {
+		u64 pool64[2];
+		u32 pool32[4];
+	};
 	struct work_struct mix;
 	unsigned long last;
-	u32 pool[4];
 	unsigned int count;
 	u16 reg_idx;
 };
@@ -780,10 +783,10 @@ struct fast_pool {
  * collector. It's hardcoded for an 128 bit pool and assumes that any
  * locks that might be needed are taken by the caller.
  */
-static void fast_mix(struct fast_pool *f)
+static void fast_mix(u32 pool[4])
 {
-	u32 a = f->pool[0],	b = f->pool[1];
-	u32 c = f->pool[2],	d = f->pool[3];
+	u32 a = pool[0],	b = pool[1];
+	u32 c = pool[2],	d = pool[3];
 
 	a += b;			c += d;
 	b = rol32(b, 6);	d = rol32(d, 27);
@@ -801,11 +804,10 @@ static void fast_mix(struct fast_pool *f)
 	b = rol32(b, 16);	d = rol32(d, 14);
 	d ^= a;			b ^= c;
 
-	f->pool[0] = a;  f->pool[1] = b;
-	f->pool[2] = c;  f->pool[3] = d;
+	pool[0] = a;  pool[1] = b;
+	pool[2] = c;  pool[3] = d;
 }
 
-
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
@@ -826,15 +828,19 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 static void mix_interrupt_randomness(struct work_struct *work)
 {
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
-	u32 pool[ARRAY_SIZE(fast_pool->pool)];
+	u32 pool[ARRAY_SIZE(fast_pool->pool32)];
 
 	/*
 	 * Since this is the result of a trip through the scheduler, xor in
 	 * a cycle counter. It can't hurt, and might help.
 	 */
-	fast_pool->pool[3] ^= random_get_entropy();
+	if (sizeof(unsigned long) == 8)
+		fast_pool->pool64[1] ^= random_get_entropy();
+	else
+		fast_pool->pool32[3] ^= random_get_entropy();
+
 	/* Copy the pool to the stack so that the mixer always has a consistent view. */
-	memcpy(pool, fast_pool->pool, sizeof(pool));
+	memcpy(pool, fast_pool->pool32, sizeof(pool));
 	/* We take care to zero out the count only after we're done reading the pool. */
 	WRITE_ONCE(fast_pool->count, 0);
 	fast_pool->last = jiffies;
@@ -851,26 +857,26 @@ void add_interrupt_randomness(int irq)
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
 	unsigned int new_count;
-	u32 c_high, j_high;
-	u64 ip;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
-	c_high = (sizeof(cycles) > 4) ? cycles >> 32 : 0;
-	j_high = (sizeof(now) > 4) ? now >> 32 : 0;
-	fast_pool->pool[0] ^= cycles ^ j_high ^ irq;
-	fast_pool->pool[1] ^= now ^ c_high;
-	ip = regs ? instruction_pointer(regs) : _RET_IP_;
-	fast_pool->pool[2] ^= ip;
-	fast_pool->pool[3] ^=
-		(sizeof(ip) > 4) ? ip >> 32 : get_reg(fast_pool, regs);
-
-	fast_mix(fast_pool);
+
+	if (sizeof(unsigned long) == 8) {
+		fast_pool->pool64[0] ^= cycles ^ rol64(now, 32) ^ irq;
+		fast_pool->pool64[1] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+	} else {
+		fast_pool->pool32[0] ^= cycles ^ irq;
+		fast_pool->pool32[1] ^= now;
+		fast_pool->pool32[2] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+		fast_pool->pool32[3] ^= get_reg(fast_pool, regs);
+	}
+
+	fast_mix(fast_pool->pool32);
 	new_count = ++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
-		    crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
+		    crng_fast_load(fast_pool->pool32, sizeof(fast_pool->pool32)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
 
@@ -879,7 +885,7 @@ void add_interrupt_randomness(int irq)
 			 * However, this only happens during boot, and then never
 			 * again, so we live with it.
 			 */
-			mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+			mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
 		}
 		return;
 	}
-- 
2.35.0

