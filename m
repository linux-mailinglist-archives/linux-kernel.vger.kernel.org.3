Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38E48FDE9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiAPQgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiAPQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:36:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2279C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 08:36:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D5E8B80D88
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E62EC36AFF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:35:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="To7Aixyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642350956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+HdaBq4tsaBvEP4iHajN0qn2kI26zUamyMMcBr5nvI=;
        b=To7Aixyf3mlDy2hyEiUTy8Ujvyp1gOwCGD++/ULWJbyZARat1XTI/+li98T2M9JfTx4sla
        oeQUGvuhZytP6KZCISKCFev0d+obhhcozYPid7NJzjSHM82Kgw+y+sHl6LZJPT8tUwfhvw
        z1xZl8QnawfxCUFBEGaGPuDsQZqFQw0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a5a70e2d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 16 Jan 2022 16:35:56 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/4] random: access input_pool_data directly rather than through pointer
Date:   Sun, 16 Jan 2022 17:35:46 +0100
Message-Id: <20220116163547.154991-3-Jason@zx2c4.com>
In-Reply-To: <20220116163547.154991-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220116163547.154991-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of another abstraction we no longer need. It would be nice
if we could instead make pool an array rather than a pointer, but the
latent entropy plugin won't be able to do its magic in that case. So
instead we put all accesses to the input pool's actual data through the
input_pool_data array directly.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7343bff086c5..274056155e50 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -496,17 +496,12 @@ MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 static u32 input_pool_data[POOL_WORDS] __latent_entropy;
 
 static struct {
-	/* read-only data: */
-	u32 *pool;
-
-	/* read-write data: */
 	spinlock_t lock;
 	u16 add_ptr;
 	u16 input_rotate;
 	int entropy_count;
 } input_pool = {
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
-	.pool = input_pool_data
 };
 
 static ssize_t extract_entropy(void *buf, size_t nbytes, int min);
@@ -544,15 +539,15 @@ static void _mix_pool_bytes(const void *in, int nbytes)
 		i = (i - 1) & POOL_WORDMASK;
 
 		/* XOR in the various taps */
-		w ^= input_pool.pool[i];
-		w ^= input_pool.pool[(i + POOL_TAP1) & POOL_WORDMASK];
-		w ^= input_pool.pool[(i + POOL_TAP2) & POOL_WORDMASK];
-		w ^= input_pool.pool[(i + POOL_TAP3) & POOL_WORDMASK];
-		w ^= input_pool.pool[(i + POOL_TAP4) & POOL_WORDMASK];
-		w ^= input_pool.pool[(i + POOL_TAP5) & POOL_WORDMASK];
+		w ^= input_pool_data[i];
+		w ^= input_pool_data[(i + POOL_TAP1) & POOL_WORDMASK];
+		w ^= input_pool_data[(i + POOL_TAP2) & POOL_WORDMASK];
+		w ^= input_pool_data[(i + POOL_TAP3) & POOL_WORDMASK];
+		w ^= input_pool_data[(i + POOL_TAP4) & POOL_WORDMASK];
+		w ^= input_pool_data[(i + POOL_TAP5) & POOL_WORDMASK];
 
 		/* Mix the result back in with a twist */
-		input_pool.pool[i] = (w >> 3) ^ twist_table[w & 7];
+		input_pool_data[i] = (w >> 3) ^ twist_table[w & 7];
 
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.
@@ -1369,7 +1364,7 @@ static void extract_buf(u8 *out)
 
 	/* Generate a hash across the pool */
 	spin_lock_irqsave(&input_pool.lock, flags);
-	blake2s_update(&state, (const u8 *)input_pool.pool, POOL_BYTES);
+	blake2s_update(&state, (const u8 *)input_pool_data, POOL_BYTES);
 	blake2s_final(&state, hash); /* final zeros out state */
 
 	/*
-- 
2.34.1

