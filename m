Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6271748DADE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiAMPoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiAMPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA28C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAFA60C71
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBD9C36AEC;
        Thu, 13 Jan 2022 15:44:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="V8xfeqWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642088668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+Y+VofW4somiowD/MhrUzN6Fgp27oVwCZgJYtz3/VQ=;
        b=V8xfeqWSTNC1/qZHZMhtG1vT382JTA/h4JRcRBDvbFESr/0hbRlwo+jUhmwO5UCEA8wh0w
        vrY7fD1yeZrDqTGscqSGs0NUtC2NZHpiqQLwhldPaYX9uXFp447KqNWdD+AIeLw+xebFNd
        NA9xanhCXyCYyn3bMp31EELHp9ZrUT4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ea91f6cc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 13 Jan 2022 15:44:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/7] random: cleanup poolinfo abstraction
Date:   Thu, 13 Jan 2022 16:44:07 +0100
Message-Id: <20220113154413.29513-2-Jason@zx2c4.com>
In-Reply-To: <20220113154413.29513-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we're only using one polynomial, we can cleanup its
representation into constants, instead of passing around pointers
dynamically to select different polynomials. This improves the codegen
and makes the code a bit more straightforward.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 85 ++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 227fb7802738..c8f05b7551dc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -430,14 +430,20 @@ static int random_write_wakeup_bits = 28 * OUTPUT_POOL_WORDS;
  * polynomial which improves the resulting TGFSR polynomial to be
  * irreducible, which we have made here.
  */
-static const struct poolinfo {
-	int poolbitshift, poolwords, poolbytes, poolfracbits;
-#define S(x) ilog2(x)+5, (x), (x)*4, (x) << (ENTROPY_SHIFT+5)
-	int tap1, tap2, tap3, tap4, tap5;
-} poolinfo_table[] = {
-	/* was: x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 */
+enum poolinfo {
+	POOL_WORDS = 128,
+	POOL_WORDMASK = POOL_WORDS - 1,
+	POOL_BYTES = POOL_WORDS * sizeof(u32),
+	POOL_BITS = POOL_BYTES * 8,
+	POOL_BITSHIFT = ilog2(POOL_WORDS) + 5,
+	POOL_FRACBITS = POOL_WORDS << (ENTROPY_SHIFT + 5),
+
 	/* x^128 + x^104 + x^76 + x^51 +x^25 + x + 1 */
-	{ S(128),	104,	76,	51,	25,	1 },
+	POOL_TAP1 = 104,
+	POOL_TAP2 = 76,
+	POOL_TAP3 = 51,
+	POOL_TAP4 = 25,
+	POOL_TAP5 = 1
 };
 
 /*
@@ -503,7 +509,6 @@ MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 struct entropy_store;
 struct entropy_store {
 	/* read-only data: */
-	const struct poolinfo *poolinfo;
 	__u32 *pool;
 	const char *name;
 
@@ -525,7 +530,6 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r);
 static __u32 input_pool_data[INPUT_POOL_WORDS] __latent_entropy;
 
 static struct entropy_store input_pool = {
-	.poolinfo = &poolinfo_table[0],
 	.name = "input",
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
 	.pool = input_pool_data
@@ -548,33 +552,26 @@ static __u32 const twist_table[8] = {
 static void _mix_pool_bytes(struct entropy_store *r, const void *in,
 			    int nbytes)
 {
-	unsigned long i, tap1, tap2, tap3, tap4, tap5;
+	unsigned long i;
 	int input_rotate;
-	int wordmask = r->poolinfo->poolwords - 1;
 	const unsigned char *bytes = in;
 	__u32 w;
 
-	tap1 = r->poolinfo->tap1;
-	tap2 = r->poolinfo->tap2;
-	tap3 = r->poolinfo->tap3;
-	tap4 = r->poolinfo->tap4;
-	tap5 = r->poolinfo->tap5;
-
 	input_rotate = r->input_rotate;
 	i = r->add_ptr;
 
 	/* mix one byte at a time to simplify size handling and churn faster */
 	while (nbytes--) {
 		w = rol32(*bytes++, input_rotate);
-		i = (i - 1) & wordmask;
+		i = (i - 1) & POOL_WORDMASK;
 
 		/* XOR in the various taps */
 		w ^= r->pool[i];
-		w ^= r->pool[(i + tap1) & wordmask];
-		w ^= r->pool[(i + tap2) & wordmask];
-		w ^= r->pool[(i + tap3) & wordmask];
-		w ^= r->pool[(i + tap4) & wordmask];
-		w ^= r->pool[(i + tap5) & wordmask];
+		w ^= r->pool[(i + POOL_TAP1) & POOL_WORDMASK];
+		w ^= r->pool[(i + POOL_TAP2) & POOL_WORDMASK];
+		w ^= r->pool[(i + POOL_TAP3) & POOL_WORDMASK];
+		w ^= r->pool[(i + POOL_TAP4) & POOL_WORDMASK];
+		w ^= r->pool[(i + POOL_TAP5) & POOL_WORDMASK];
 
 		/* Mix the result back in with a twist */
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
@@ -672,7 +669,6 @@ static void process_random_ready_list(void)
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
 	int entropy_count, orig;
-	const int pool_size = r->poolinfo->poolfracbits;
 	int nfrac = nbits << ENTROPY_SHIFT;
 
 	if (!nbits)
@@ -690,41 +686,41 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		 * ideal case of pure Shannon entropy, new contributions
 		 * approach the full value asymptotically:
 		 *
-		 * entropy <- entropy + (pool_size - entropy) *
-		 *	(1 - exp(-add_entropy/pool_size))
+		 * entropy <- entropy + (POOL_FRACBITS - entropy) *
+		 *	(1 - exp(-add_entropy/POOL_FRACBITS))
 		 *
-		 * For add_entropy <= pool_size/2 then
-		 * (1 - exp(-add_entropy/pool_size)) >=
-		 *    (add_entropy/pool_size)*0.7869...
+		 * For add_entropy <= POOL_FRACBITS/2 then
+		 * (1 - exp(-add_entropy/POOL_FRACBITS)) >=
+		 *    (add_entropy/POOL_FRACBITS)*0.7869...
 		 * so we can approximate the exponential with
-		 * 3/4*add_entropy/pool_size and still be on the
-		 * safe side by adding at most pool_size/2 at a time.
+		 * 3/4*add_entropy/POOL_FRACBITS and still be on the
+		 * safe side by adding at most POOL_FRACBITS/2 at a time.
 		 *
-		 * The use of pool_size-2 in the while statement is to
+		 * The use of POOL_FRACBITS-2 in the while statement is to
 		 * prevent rounding artifacts from making the loop
-		 * arbitrarily long; this limits the loop to log2(pool_size)*2
+		 * arbitrarily long; this limits the loop to log2(POOL_FRACBITS)*2
 		 * turns no matter how large nbits is.
 		 */
 		int pnfrac = nfrac;
-		const int s = r->poolinfo->poolbitshift + ENTROPY_SHIFT + 2;
+		const int s = POOL_BITSHIFT + ENTROPY_SHIFT + 2;
 		/* The +2 corresponds to the /4 in the denominator */
 
 		do {
-			unsigned int anfrac = min(pnfrac, pool_size/2);
+			unsigned int anfrac = min(pnfrac, POOL_FRACBITS/2);
 			unsigned int add =
-				((pool_size - entropy_count)*anfrac*3) >> s;
+				((POOL_FRACBITS - entropy_count)*anfrac*3) >> s;
 
 			entropy_count += add;
 			pnfrac -= anfrac;
-		} while (unlikely(entropy_count < pool_size-2 && pnfrac));
+		} while (unlikely(entropy_count < POOL_FRACBITS-2 && pnfrac));
 	}
 
 	if (WARN_ON(entropy_count < 0)) {
 		pr_warn("negative entropy/overflow: pool %s count %d\n",
 			r->name, entropy_count);
 		entropy_count = 0;
-	} else if (entropy_count > pool_size)
-		entropy_count = pool_size;
+	} else if (entropy_count > POOL_FRACBITS)
+		entropy_count = POOL_FRACBITS;
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
@@ -741,13 +737,11 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 
 static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
 {
-	const int nbits_max = r->poolinfo->poolwords * 32;
-
 	if (nbits < 0)
 		return -EINVAL;
 
 	/* Cap the value to avoid overflows */
-	nbits = min(nbits,  nbits_max);
+	nbits = min(nbits,  POOL_BITS);
 
 	credit_entropy_bits(r, nbits);
 	return 0;
@@ -1343,7 +1337,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 	int entropy_count, orig, have_bytes;
 	size_t ibytes, nfrac;
 
-	BUG_ON(r->entropy_count > r->poolinfo->poolfracbits);
+	BUG_ON(r->entropy_count > POOL_FRACBITS);
 
 	/* Can we pull enough? */
 retry:
@@ -1409,8 +1403,7 @@ static void extract_buf(struct entropy_store *r, __u8 *out)
 
 	/* Generate a hash across the pool */
 	spin_lock_irqsave(&r->lock, flags);
-	blake2s_update(&state, (const u8 *)r->pool,
-		       r->poolinfo->poolwords * sizeof(*r->pool));
+	blake2s_update(&state, (const u8 *)r->pool, POOL_BYTES);
 	blake2s_final(&state, hash); /* final zeros out state */
 
 	/*
@@ -1766,7 +1759,7 @@ static void __init init_std_data(struct entropy_store *r)
 	unsigned long rv;
 
 	mix_pool_bytes(r, &now, sizeof(now));
-	for (i = r->poolinfo->poolbytes; i > 0; i -= sizeof(rv)) {
+	for (i = POOL_BYTES; i > 0; i -= sizeof(rv)) {
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
-- 
2.34.1

