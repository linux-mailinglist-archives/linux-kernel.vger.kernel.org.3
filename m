Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7404B1261
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiBJQJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:09:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbiBJQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:09:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C67EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:09:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEA161D0C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA9CC004E1;
        Thu, 10 Feb 2022 16:09:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c/wcIGWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644509380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qE60YeWa/s+S2GHC5gb4WBfkI+YE+RQRZu/hdGfvy2s=;
        b=c/wcIGWb+OoIYMt/QY1g/YqgnpxfJzWTe+Up7z9rk6DTaC7vjk0d+LDDHjAgCwG5tmMQEC
        ElnDJigftQTzI/tbSHuSZVd7haSqyN4pXD3Vb5ctneXLpoBlGyw+XuB/ff2TYdsN3MImhn
        FfhSxQjnfbLB5cdO4QB84LKzn7QfaCM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f2e38b22 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 16:09:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] random: deobfuscate irq u32/u64 contributions
Date:   Thu, 10 Feb 2022 17:09:25 +0100
Message-Id: <20220210160925.156697-3-Jason@zx2c4.com>
In-Reply-To: <20220210160925.156697-1-Jason@zx2c4.com>
References: <20220210160925.156697-1-Jason@zx2c4.com>
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
it exposed a shortcoming in in mix_interrupt_randomness() which we
rectify.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 54 ++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 923a8f861437..1eb3c059025b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -731,9 +731,12 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
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
@@ -744,10 +747,10 @@ struct fast_pool {
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
@@ -765,11 +768,10 @@ static void fast_mix(struct fast_pool *f)
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
@@ -790,15 +792,19 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
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
@@ -815,26 +821,26 @@ void add_interrupt_randomness(int irq)
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
 
@@ -843,7 +849,7 @@ void add_interrupt_randomness(int irq)
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

