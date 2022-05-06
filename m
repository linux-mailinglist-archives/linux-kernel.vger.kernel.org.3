Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318E251E176
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444607AbiEFV7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444600AbiEFV6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:58:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F096FA2B;
        Fri,  6 May 2022 14:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 388FAB8366B;
        Fri,  6 May 2022 21:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40E1C385AE;
        Fri,  6 May 2022 21:55:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qGymX2Ei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651874107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CONQnGrvBNWtmRRVvjvt2kXQXjMlbIs+TFZyt6Ucsf8=;
        b=qGymX2Eibsn2o4UdhibapvaTTC06Wi+MyevGLHQ1Gm0qPrf4ffHotjJyeKRxdj+NDxKImc
        +sySvsdxdwmvXt3YRGJgWrWJvabwHvdRI8+q7Ad53uG6YTr9YgwlERr6etAyPHt3nB6wAv
        SW5LOEFp+OcNx0HdsIF68CJ/JNPoeS8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 55c62685 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 6 May 2022 21:55:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/3] random: help compiler out with fast_mix() by using simpler arguments
Date:   Fri,  6 May 2022 23:54:54 +0200
Message-Id: <20220506215454.1671-3-Jason@zx2c4.com>
In-Reply-To: <20220506215454.1671-1-Jason@zx2c4.com>
References: <20220506215454.1671-1-Jason@zx2c4.com>
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

Now that fast_mix() has more than one caller, gcc no longer inlines it.
That's fine. But it also doesn't handle the compound literal argument we
pass it very efficiently, nor does it handle the loop as well as it
could. So just expand the code to spell out this function so that it
generates the same code as it did before. Performance-wise, this now
behaves as it did before the last commit. The difference in actual code
size on x86 is 45 bytes, which is less than a cache line.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 44 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 818432638c18..a04ecfcb4f1e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1101,25 +1101,30 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
  * and therefore this has no security on its own. s represents the
  * four-word SipHash state, while v represents a two-word input.
  */
-static void fast_mix(unsigned long s[4], const unsigned long v[2])
+static void fast_mix(unsigned long s[4], unsigned long v1, unsigned long v2)
 {
-	size_t i;
-
-	for (i = 0; i < 2; ++i) {
-		s[3] ^= v[i];
 #ifdef CONFIG_64BIT
-		s[0] += s[1]; s[1] = rol64(s[1], 13); s[1] ^= s[0]; s[0] = rol64(s[0], 32);
-		s[2] += s[3]; s[3] = rol64(s[3], 16); s[3] ^= s[2];
-		s[0] += s[3]; s[3] = rol64(s[3], 21); s[3] ^= s[0];
-		s[2] += s[1]; s[1] = rol64(s[1], 17); s[1] ^= s[2]; s[2] = rol64(s[2], 32);
+#define PERM() do { \
+	s[0] += s[1]; s[1] = rol64(s[1], 13); s[1] ^= s[0]; s[0] = rol64(s[0], 32); \
+	s[2] += s[3]; s[3] = rol64(s[3], 16); s[3] ^= s[2]; \
+	s[0] += s[3]; s[3] = rol64(s[3], 21); s[3] ^= s[0]; \
+	s[2] += s[1]; s[1] = rol64(s[1], 17); s[1] ^= s[2]; s[2] = rol64(s[2], 32); \
+} while (0)
 #else
-		s[0] += s[1]; s[1] = rol32(s[1],  5); s[1] ^= s[0]; s[0] = rol32(s[0], 16);
-		s[2] += s[3]; s[3] = rol32(s[3],  8); s[3] ^= s[2];
-		s[0] += s[3]; s[3] = rol32(s[3],  7); s[3] ^= s[0];
-		s[2] += s[1]; s[1] = rol32(s[1], 13); s[1] ^= s[2]; s[2] = rol32(s[2], 16);
+#define PERM() do { \
+	s[0] += s[1]; s[1] = rol32(s[1],  5); s[1] ^= s[0]; s[0] = rol32(s[0], 16); \
+	s[2] += s[3]; s[3] = rol32(s[3],  8); s[3] ^= s[2]; \
+	s[0] += s[3]; s[3] = rol32(s[3],  7); s[3] ^= s[0]; \
+	s[2] += s[1]; s[1] = rol32(s[1], 13); s[1] ^= s[2]; s[2] = rol32(s[2], 16); \
+} while (0)
 #endif
-		s[0] ^= v[i];
-	}
+
+	s[3] ^= v1;
+	PERM();
+	s[0] ^= v1;
+	s[3] ^= v2;
+	PERM();
+	s[0] ^= v2;
 }
 
 #ifdef CONFIG_SMP
@@ -1187,10 +1192,8 @@ void add_interrupt_randomness(int irq)
 	struct pt_regs *regs = get_irq_regs();
 	unsigned int new_count;
 
-	fast_mix(fast_pool->pool, (unsigned long[2]){
-		entropy,
-		(regs ? instruction_pointer(regs) : _RET_IP_) ^ swab(irq)
-	});
+	fast_mix(fast_pool->pool, entropy,
+		 (regs ? instruction_pointer(regs) : _RET_IP_) ^ swab(irq));
 	new_count = ++fast_pool->count;
 
 	if (new_count & MIX_INFLIGHT)
@@ -1228,8 +1231,7 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned int nu
 	long delta, delta2, delta3;
 
 	if (in_hardirq()) {
-		fast_mix(this_cpu_ptr(&irq_randomness)->pool,
-			 (unsigned long[2]){ entropy, num });
+		fast_mix(this_cpu_ptr(&irq_randomness)->pool, entropy, num);
 		return;
 	}
 
-- 
2.35.1

