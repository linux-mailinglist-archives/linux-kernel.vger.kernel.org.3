Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45347E463
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348776AbhLWOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348774AbhLWOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:11:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9191CC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:11:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2474761E79
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ED5C36AE5;
        Thu, 23 Dec 2021 14:11:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bqPb4GeZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640268708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4DmGTSwziehMGkvR6F0DgNT8cpV9eG8uyGp6gtv+FQ=;
        b=bqPb4GeZBeFdZmQl8bO8ErRvhA0DPMUqOg1N36n20MidxP5gjnB/aqJQNTeV9nBCUIiXLy
        hDt0JzuvFb+i8857MVN1d/Yz0dSgOPw00cYHGklP7nVpKPL34FUqSUkw7iBWXDQOuBEzCF
        869AAB7GRbfs09hyeMxL7e5WXMRiZAk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 776185b1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 23 Dec 2021 14:11:47 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Date:   Thu, 23 Dec 2021 15:11:13 +0100
Message-Id: <20211223141113.1240679-2-Jason@zx2c4.com>
In-Reply-To: <20211223141113.1240679-1-Jason@zx2c4.com>
References: <20211223141113.1240679-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit addresses one of the lower hanging fruits of the RNG: its
usage of SHA1.

BLAKE2s is generally faster, and certainly more secure, than SHA1, which
has [1] been [2] really [3] very [4] broken [5]. Additionally, the
current construction in the RNG doesn't use the full SHA1 function, as
specified, and allows overwriting the IV with RDRAND output in an
undocumented way, even in the case when RDRAND isn't set to "trusted",
which means potential malicious IV choices. And its short length means
that keeping only half of it secret when feeding back into the mixer
gives us only 2^80 bits of forward secrecy. In other words, not only is
the choice of hash function dated, but the use of it isn't really great
either.

This commit aims to fix both of these issues while also keeping the
general structure and semantics as close to the original as possible.
Specifically:

   a) Rather than overwriting the hash IV with RDRAND, we put it into
      BLAKE2's documented "salt" and "personal" fields, which were
      specifically created for this type of usage.
   b) Since this function feeds the full hash result back into the
      entropy collector, we only return from it half the length of the
      hash, just as it was done before. This increases the
      construction's forward secrecy from 2^80 to a much more
      comfortable 2^128.
   c) Rather than using the raw "sha1_transform" function alone, we
      instead use the full proper BLAKE2s function, with finalization.

This also has the advantage of supplying 16 bytes at a time rather than
SHA1's 10 bytes, which, in addition to having a faster compression
function to begin with, means faster extraction in general. On an Intel
i7-11850H, this commit makes initial seeding around 131% faster.

BLAKE2s itself has the nice property of internally being based on the
ChaCha permutation, which the RNG is already using for expansion, so
there shouldn't be any issue with newness, funkiness, or surprising CPU
behavior, since it's based on something already in use.

[1] https://eprint.iacr.org/2005/010.pdf
[2] https://www.iacr.org/archive/crypto2005/36210017/36210017.pdf
[3] https://eprint.iacr.org/2015/967.pdf
[4] https://shattered.io/static/shattered.pdf
[5] https://www.usenix.org/system/files/sec20-leurent.pdf

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v1->v2:
- Moved the blake2s lib/crypto/ build system changes to prior commit,
  since it's a bit more involved than initially thought.

 drivers/char/random.c | 64 ++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 13c968b950c5..e3827d45d2f2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -78,12 +78,12 @@
  * an *estimate* of how many bits of randomness have been stored into
  * the random number generator's internal state.
  *
- * When random bytes are desired, they are obtained by taking the SHA
- * hash of the contents of the "entropy pool".  The SHA hash avoids
+ * When random bytes are desired, they are obtained by taking the BLAKE2s
+ * hash of the contents of the "entropy pool".  The BLAKE2s hash avoids
  * exposing the internal state of the entropy pool.  It is believed to
  * be computationally infeasible to derive any useful information
- * about the input of SHA from its output.  Even if it is possible to
- * analyze SHA in some clever way, as long as the amount of data
+ * about the input of BLAKE2s from its output.  Even if it is possible to
+ * analyze BLAKE2s in some clever way, as long as the amount of data
  * returned from the generator is less than the inherent entropy in
  * the pool, the output data is totally unpredictable.  For this
  * reason, the routine decreases its internal estimate of how many
@@ -93,7 +93,7 @@
  * If this estimate goes to zero, the routine can still generate
  * random numbers; however, an attacker may (at least in theory) be
  * able to infer the future output of the generator from prior
- * outputs.  This requires successful cryptanalysis of SHA, which is
+ * outputs.  This requires successful cryptanalysis of BLAKE2s, which is
  * not believed to be feasible, but there is a remote possibility.
  * Nonetheless, these numbers should be useful for the vast majority
  * of purposes.
@@ -347,7 +347,7 @@
 #include <linux/completion.h>
 #include <linux/uuid.h>
 #include <crypto/chacha.h>
-#include <crypto/sha1.h>
+#include <crypto/blake2s.h>
 
 #include <asm/processor.h>
 #include <linux/uaccess.h>
@@ -367,10 +367,7 @@
 #define INPUT_POOL_WORDS	(1 << (INPUT_POOL_SHIFT-5))
 #define OUTPUT_POOL_SHIFT	10
 #define OUTPUT_POOL_WORDS	(1 << (OUTPUT_POOL_SHIFT-5))
-#define EXTRACT_SIZE		10
-
-
-#define LONGS(x) (((x) + sizeof(unsigned long) - 1)/sizeof(unsigned long))
+#define EXTRACT_SIZE		(BLAKE2S_HASH_SIZE / 2)
 
 /*
  * To allow fractional bits to be tracked, the entropy_count field is
@@ -406,7 +403,7 @@ static int random_write_wakeup_bits = 28 * OUTPUT_POOL_WORDS;
  * Thanks to Colin Plumb for suggesting this.
  *
  * The mixing operation is much less sensitive than the output hash,
- * where we use SHA-1.  All that we want of mixing operation is that
+ * where we use BLAKE2s.  All that we want of mixing operation is that
  * it be a good non-cryptographic hash; i.e. it not produce collisions
  * when fed "random" data of the sort we expect to see.  As long as
  * the pool state differs for different inputs, we have preserved the
@@ -1384,54 +1381,47 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
  */
 static void extract_buf(struct entropy_store *r, __u8 *out)
 {
-	int i;
-	union {
-		__u32 w[5];
-		unsigned long l[LONGS(20)];
-	} hash;
-	__u32 workspace[SHA1_WORKSPACE_WORDS];
+	struct blake2s_state state __aligned(__alignof__(unsigned long));
+	u8 hash[BLAKE2S_HASH_SIZE];
+	unsigned long *salt;
 	unsigned long flags;
 
+	blake2s_init(&state, sizeof(hash));
+
 	/*
 	 * If we have an architectural hardware random number
-	 * generator, use it for SHA's initial vector
+	 * generator, use it for BLAKE2's salt & personal fields.
 	 */
-	sha1_init(hash.w);
-	for (i = 0; i < LONGS(20); i++) {
+	for (salt = (unsigned long *)&state.h[4];
+	     salt < (unsigned long *)&state.h[8]; ++salt) {
 		unsigned long v;
 		if (!arch_get_random_long(&v))
 			break;
-		hash.l[i] = v;
+		*salt ^= v;
 	}
 
-	/* Generate a hash across the pool, 16 words (512 bits) at a time */
+	/* Generate a hash across the pool */
 	spin_lock_irqsave(&r->lock, flags);
-	for (i = 0; i < r->poolinfo->poolwords; i += 16)
-		sha1_transform(hash.w, (__u8 *)(r->pool + i), workspace);
+	blake2s_update(&state, (const u8 *)r->pool,
+		       r->poolinfo->poolwords * sizeof(*r->pool));
+	blake2s_final(&state, hash); /* final zeros out state */
 
 	/*
 	 * We mix the hash back into the pool to prevent backtracking
 	 * attacks (where the attacker knows the state of the pool
 	 * plus the current outputs, and attempts to find previous
-	 * ouputs), unless the hash function can be inverted. By
-	 * mixing at least a SHA1 worth of hash data back, we make
+	 * outputs), unless the hash function can be inverted. By
+	 * mixing at least a hash worth of hash data back, we make
 	 * brute-forcing the feedback as hard as brute-forcing the
 	 * hash.
 	 */
-	__mix_pool_bytes(r, hash.w, sizeof(hash.w));
+	__mix_pool_bytes(r, hash, sizeof(hash));
 	spin_unlock_irqrestore(&r->lock, flags);
 
-	memzero_explicit(workspace, sizeof(workspace));
-
-	/*
-	 * In case the hash function has some recognizable output
-	 * pattern, we fold it in half. Thus, we always feed back
-	 * twice as much data as we output.
+	/* Note that EXTRACT_SIZE is half of hash size here, because above
+	 * we've dumped the full length back into mixer. By reducing the
+	 * amount that we emit, we retain a level of forward secrecy.
 	 */
-	hash.w[0] ^= hash.w[3];
-	hash.w[1] ^= hash.w[4];
-	hash.w[2] ^= rol32(hash.w[2], 16);
-
 	memcpy(out, &hash, EXTRACT_SIZE);
 	memzero_explicit(&hash, sizeof(hash));
 }
-- 
2.34.1

