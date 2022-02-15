Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36104B6B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiBOLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:48:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiBOLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:48:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D777710F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:48:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8AB6157B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59FC340EB;
        Tue, 15 Feb 2022 11:48:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G4jSwocK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644925700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQTMRXJB9KfjEetgEwOx1Rgeuw93qd9A1BZQuEZHg9I=;
        b=G4jSwocKDUp8ByfkQXrCIZoXLqH+z0LVz9kkt63NuBcTLOHtvnexiXjKg31WUaNHMgcDwy
        r69p99id2DBagDkxjEbWa4yltyDwJT7ZoC3oZjID+jJG8F+hfVIJ6QnzBroMdEYPjOQ197
        XLWBxJhF8PYzAvAIdEANDdzhOWpnrPk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bb65e87b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 15 Feb 2022 11:48:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v3] random: deobfuscate irq u32/u64 contributions
Date:   Tue, 15 Feb 2022 12:48:12 +0100
Message-Id: <20220215114812.96750-1-Jason@zx2c4.com>
In-Reply-To: <YgX6r9hsRIbv06hq@owl.dominikbrodowski.net>
References: <YgX6r9hsRIbv06hq@owl.dominikbrodowski.net>
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
64-bit platforms, and for 32-bit vs 64-bit cycle counters, which doesn't
always correspond with the bitness of the platform. Whether or not you
like this strangeness, it is a matter of fact.  But it might not be a
fact you well realized until now, because the code that loaded the irq
info into 4 32-bit words was quite confusing.  Instead, this commit
makes everything explicit by having separate (compile-time) branches for
32-bit and 64-bit types.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v2->v3:
- cycles_t is sometimes an `unsigned long long`, even on 32-bit x86, so
  separate that contribution from the other one.
- rebased on the latest.

 drivers/char/random.c | 49 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9714d9f05a84..6a2c7db94417 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -283,7 +283,10 @@ static void mix_pool_bytes(const void *in, size_t nbytes)
 }
 
 struct fast_pool {
-	u32 pool[4];
+	union {
+		u32 pool32[4];
+		u64 pool64[2];
+	};
 	unsigned long last;
 	u16 reg_idx;
 	u8 count;
@@ -294,10 +297,10 @@ struct fast_pool {
  * collector.  It's hardcoded for an 128 bit pool and assumes that any
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
@@ -315,9 +318,8 @@ static void fast_mix(struct fast_pool *f)
 	b = rol32(b, 16);	d = rol32(d, 14);
 	d ^= a;			b ^= c;
 
-	f->pool[0] = a;  f->pool[1] = b;
-	f->pool[2] = c;  f->pool[3] = d;
-	f->count++;
+	pool[0] = a;  pool[1] = b;
+	pool[2] = c;  pool[3] = d;
 }
 
 static void process_random_ready_list(void)
@@ -778,29 +780,34 @@ void add_interrupt_randomness(int irq)
 	struct pt_regs *regs = get_irq_regs();
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
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
 
-	fast_mix(fast_pool);
+	if (sizeof(cycles) == 8)
+		fast_pool->pool64[0] ^= cycles ^ rol64(now, 32) ^ irq;
+	else {
+		fast_pool->pool32[0] ^= cycles ^ irq;
+		fast_pool->pool32[1] ^= now;
+	}
+
+	if (sizeof(unsigned long) == 8)
+		fast_pool->pool64[1] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+	else {
+		fast_pool->pool32[2] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+		fast_pool->pool32[3] ^= get_reg(fast_pool, regs);
+	}
+
+	fast_mix(fast_pool->pool32);
+	++fast_pool->count;
 
 	if (unlikely(crng_init == 0)) {
 		if (fast_pool->count >= 64 &&
-		    crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
+		    crng_fast_load(fast_pool->pool32, sizeof(fast_pool->pool32)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
 			if (spin_trylock(&input_pool.lock)) {
-				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+				_mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
 				spin_unlock(&input_pool.lock);
 			}
 		}
@@ -814,7 +821,7 @@ void add_interrupt_randomness(int irq)
 		return;
 
 	fast_pool->last = now;
-	_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+	_mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
 	spin_unlock(&input_pool.lock);
 
 	fast_pool->count = 0;
-- 
2.35.0

