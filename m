Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAF4A6123
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiBAQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:14:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45238 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbiBAQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:14:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70BD961704;
        Tue,  1 Feb 2022 16:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FEAC340EB;
        Tue,  1 Feb 2022 16:14:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iZYIzyVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643732080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bow9uuvNYJkUAuO8yGFI2Stb2coPPn6tOpqzzE/dSXc=;
        b=iZYIzyVEnEKn20GOanSb7JMCrjLnxm9u2xJXjn5vmuQ03/pd5hVZMOdcI0meMjXckWbEAZ
        vii+ufabXzEczB7wlgsx185rJYLM4sH3q9YMbf2oFfmiCGhIQFrb4dluW22xeFRj80YsTM
        mdWnqAjNmxQMYy9KkY8cIq5ZHT1Cm8A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1311b805 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Feb 2022 16:14:39 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: [PATCH] random: use computational hash for entropy extraction
Date:   Tue,  1 Feb 2022 17:13:42 +0100
Message-Id: <20220201161342.154666-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current 4096-bit LFSR used for entropy collection had a few
desirable attributes for the context in which it was created. For
example, the state was huge, which meant that /dev/random would be able
to output quite a bit of accumulated entropy before blocking. It was
also, in its time, quite fast at accumulating entropy byte-by-byte,
which matters given the varying contexts in which mix_pool_bytes() is
called. And its diffusion was relatively high, which meant that changes
would ripple across several words of state rather quickly.

However, it also suffers from a few security vulnerabilities. In
particular, inputs learned by an attacker can be undone, but more over,
if the state of the pool leaks, its contents can be controlled and
entirely zeroed out. I've demonstrated this attack with this SMT2
script, <https://xn--4db.cc/5o9xO8pb>, which Boolector/CaDiCal solves in
a matter of seconds on a single core of my laptop, resulting in little
proof of concept C demonstrators such as <https://xn--4db.cc/jCkvvIaH/c>.

For basically all recent formal models of RNGs, these attacks represent
a significant cryptographic flaw. But how does this manifest
practically? If an attacker has access to the system to such a degree
that he can learn the internal state of the RNG, arguably there are
other lower hanging vulnerabilities -- side-channel, infoleak, or
otherwise -- that might have higher priority. On the other hand, seed
files are frequently used on systems that have a hard time generating
much entropy on their own, and these seed files, being files, often leak
or are duplicated and distributed accidentally, or are even seeded over
the Internet intentionally, where their contents might be recorded or
tampered with. Seen this way, an otherwise quasi-implausible
vulnerability is a bit more practical than initially thought.

Another aspect of the current mix_pool_bytes() function is that, while
its performance was arguably competitive for the time in which it was
created, it's no longer considered so. This patch improves performance
significantly: on a high-end CPU, an i7-11850H, it improves performance
of mix_pool_bytes() by 225%, and on a low-end CPU, a Cortex-A7, it
improves performance by 103%.

This commit replaces the LFSR of mix_pool_bytes() with a straight-
forward cryptographic hash function, BLAKE2s, which is already in use
for pool extraction. Universal hashing with a secret seed was considered
too, something along the lines of <https://eprint.iacr.org/2013/338>,
but the requirement for a secret seed makes for a chicken & egg problem.
Instead we go with a formally proven scheme using a computational hash
function, described in section B.1.8 of <https://eprint.iacr.org/2019/198>.

BLAKE2s outputs 256 bits, which should give us an appropriate amount of
min-entropy accumulation, and a wide enough margin of collision
resistance against active attacks. mix_pool_bytes() becomes a simple
call to blake2s_update(), for accumulation, while the extraction step
becomes a blake2s_final() to generate a seed, with which we can then do
a HKDF-like or BLAKE2X-like expansion, the first part of which we fold
back as an init key for subsequent blake2s_update()s, and the rest we
produce to the caller. This then is provided to our CRNG like usual. In
that expansion step, we make opportunistic use of 32 bytes of RDRAND
output, just as before. We also always reseed the crng with 32 bytes,
unconditionally, or not at all, rather than sometimes with 16 as before,
as we don't win anything by limiting beyond the 16 byte threshold.

Going for a hash function as an entropy collector is a conservative,
proven approach. The result of all this is a much simpler and much less
bespoke construction than what's there now, which not only plugs a
vulnerability but also improves performance considerably.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 232 ++++++++++--------------------------------
 1 file changed, 55 insertions(+), 177 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b411182df6f6..0e03e9a05eff 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -358,79 +358,15 @@
 
 /* #define ADD_INTERRUPT_BENCH */
 
-/*
- * If the entropy count falls under this number of bits, then we
- * should wake up processes which are selecting or polling on write
- * access to /dev/random.
- */
-static int random_write_wakeup_bits = 28 * (1 << 5);
-
-/*
- * Originally, we used a primitive polynomial of degree .poolwords
- * over GF(2).  The taps for various sizes are defined below.  They
- * were chosen to be evenly spaced except for the last tap, which is 1
- * to get the twisting happening as fast as possible.
- *
- * For the purposes of better mixing, we use the CRC-32 polynomial as
- * well to make a (modified) twisted Generalized Feedback Shift
- * Register.  (See M. Matsumoto & Y. Kurita, 1992.  Twisted GFSR
- * generators.  ACM Transactions on Modeling and Computer Simulation
- * 2(3):179-194.  Also see M. Matsumoto & Y. Kurita, 1994.  Twisted
- * GFSR generators II.  ACM Transactions on Modeling and Computer
- * Simulation 4:254-266)
- *
- * Thanks to Colin Plumb for suggesting this.
- *
- * The mixing operation is much less sensitive than the output hash,
- * where we use BLAKE2s.  All that we want of mixing operation is that
- * it be a good non-cryptographic hash; i.e. it not produce collisions
- * when fed "random" data of the sort we expect to see.  As long as
- * the pool state differs for different inputs, we have preserved the
- * input entropy and done a good job.  The fact that an intelligent
- * attacker can construct inputs that will produce controlled
- * alterations to the pool's state is not important because we don't
- * consider such inputs to contribute any randomness.  The only
- * property we need with respect to them is that the attacker can't
- * increase his/her knowledge of the pool's state.  Since all
- * additions are reversible (knowing the final state and the input,
- * you can reconstruct the initial state), if an attacker has any
- * uncertainty about the initial state, he/she can only shuffle that
- * uncertainty about, but never cause any collisions (which would
- * decrease the uncertainty).
- *
- * Our mixing functions were analyzed by Lacharme, Roeck, Strubel, and
- * Videau in their paper, "The Linux Pseudorandom Number Generator
- * Revisited" (see: http://eprint.iacr.org/2012/251.pdf).  In their
- * paper, they point out that we are not using a true Twisted GFSR,
- * since Matsumoto & Kurita used a trinomial feedback polynomial (that
- * is, with only three taps, instead of the six that we are using).
- * As a result, the resulting polynomial is neither primitive nor
- * irreducible, and hence does not have a maximal period over
- * GF(2**32).  They suggest a slight change to the generator
- * polynomial which improves the resulting TGFSR polynomial to be
- * irreducible, which we have made here.
- */
 enum poolinfo {
-	POOL_WORDS = 128,
-	POOL_WORDMASK = POOL_WORDS - 1,
-	POOL_BYTES = POOL_WORDS * sizeof(u32),
-	POOL_BITS = POOL_BYTES * 8,
+	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
 	POOL_BITSHIFT = ilog2(POOL_BITS),
 
 	/* To allow fractional bits to be tracked, the entropy_count field is
 	 * denominated in units of 1/8th bits. */
 	POOL_ENTROPY_SHIFT = 3,
 #define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
-	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT,
-
-	/* x^128 + x^104 + x^76 + x^51 +x^25 + x + 1 */
-	POOL_TAP1 = 104,
-	POOL_TAP2 = 76,
-	POOL_TAP3 = 51,
-	POOL_TAP4 = 25,
-	POOL_TAP5 = 1,
-
-	EXTRACT_SIZE = BLAKE2S_HASH_SIZE / 2
+	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT
 };
 
 /*
@@ -438,6 +374,12 @@ enum poolinfo {
  */
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 static struct fasync_struct *fasync;
+/*
+ * If the entropy count falls under this number of bits, then we
+ * should wake up processes which are selecting or polling on write
+ * access to /dev/random.
+ */
+static int random_write_wakeup_bits = POOL_BITS * 3 / 4;
 
 static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
@@ -493,73 +435,31 @@ MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
  *
  **********************************************************************/
 
-static u32 input_pool_data[POOL_WORDS] __latent_entropy;
-
 static struct {
+	struct blake2s_state hash;
 	spinlock_t lock;
-	u16 add_ptr;
-	u16 input_rotate;
 	int entropy_count;
 } input_pool = {
+	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
+		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
+		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
+	.hash.outlen = BLAKE2S_HASH_SIZE,
 	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
 };
 
-static ssize_t extract_entropy(void *buf, size_t nbytes, int min);
-static ssize_t _extract_entropy(void *buf, size_t nbytes);
+static bool extract_entropy(void *buf, size_t nbytes, int min);
+static void _extract_entropy(void *buf, size_t nbytes);
 
 static void crng_reseed(struct crng_state *crng, bool use_input_pool);
 
-static const u32 twist_table[8] = {
-	0x00000000, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
-	0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
-
 /*
  * This function adds bytes into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_bits if this is appropriate.
- *
- * The pool is stirred with a primitive polynomial of the appropriate
- * degree, and then twisted.  We twist by three bits at a time because
- * it's cheap to do so and helps slightly in the expected case where
- * the entropy is concentrated in the low-order bits.
  */
 static void _mix_pool_bytes(const void *in, int nbytes)
 {
-	unsigned long i;
-	int input_rotate;
-	const u8 *bytes = in;
-	u32 w;
-
-	input_rotate = input_pool.input_rotate;
-	i = input_pool.add_ptr;
-
-	/* mix one byte at a time to simplify size handling and churn faster */
-	while (nbytes--) {
-		w = rol32(*bytes++, input_rotate);
-		i = (i - 1) & POOL_WORDMASK;
-
-		/* XOR in the various taps */
-		w ^= input_pool_data[i];
-		w ^= input_pool_data[(i + POOL_TAP1) & POOL_WORDMASK];
-		w ^= input_pool_data[(i + POOL_TAP2) & POOL_WORDMASK];
-		w ^= input_pool_data[(i + POOL_TAP3) & POOL_WORDMASK];
-		w ^= input_pool_data[(i + POOL_TAP4) & POOL_WORDMASK];
-		w ^= input_pool_data[(i + POOL_TAP5) & POOL_WORDMASK];
-
-		/* Mix the result back in with a twist */
-		input_pool_data[i] = (w >> 3) ^ twist_table[w & 7];
-
-		/*
-		 * Normally, we add 7 bits of rotation to the pool.
-		 * At the beginning of the pool, add an extra 7 bits
-		 * rotation, so that successive passes spread the
-		 * input bits across the pool evenly.
-		 */
-		input_rotate = (input_rotate + (i ? 7 : 14)) & 31;
-	}
-
-	input_pool.input_rotate = input_rotate;
-	input_pool.add_ptr = i;
+	blake2s_update(&input_pool.hash, in, nbytes);
 }
 
 static void __mix_pool_bytes(const void *in, int nbytes)
@@ -954,15 +854,14 @@ static int crng_slow_load(const u8 *cp, size_t len)
 static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 {
 	unsigned long flags;
-	int i, num;
+	int i;
 	union {
 		u8 block[CHACHA_BLOCK_SIZE];
 		u32 key[8];
 	} buf;
 
 	if (use_input_pool) {
-		num = extract_entropy(&buf, 32, 16);
-		if (num == 0)
+		if (!extract_entropy(&buf, 32, 16))
 			return;
 	} else {
 		_extract_crng(&primary_crng, buf.block);
@@ -1329,74 +1228,48 @@ static size_t account(size_t nbytes, int min)
 }
 
 /*
- * This function does the actual extraction for extract_entropy.
- *
- * Note: we assume that .poolwords is a multiple of 16 words.
+ * This is an HKDF-like construction for using the hashed collected entropy
+ * as a PRF key, that's then expanded block-by-block.
  */
-static void extract_buf(u8 *out)
+static void _extract_entropy(void *buf, size_t nbytes)
 {
-	struct blake2s_state state __aligned(__alignof__(unsigned long));
-	u8 hash[BLAKE2S_HASH_SIZE];
-	unsigned long *salt;
 	unsigned long flags;
-
-	blake2s_init(&state, sizeof(hash));
-
-	/*
-	 * If we have an architectural hardware random number
-	 * generator, use it for BLAKE2's salt & personal fields.
-	 */
-	for (salt = (unsigned long *)&state.h[4];
-	     salt < (unsigned long *)&state.h[8]; ++salt) {
-		unsigned long v;
-		if (!arch_get_random_long(&v))
-			break;
-		*salt ^= v;
+	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
+	struct {
+		unsigned long rdrand[32 / sizeof(long)];
+		size_t counter;
+	} block;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(block.rdrand); ++i) {
+		if (!arch_get_random_long(&block.rdrand[i]))
+			block.rdrand[i] = random_get_entropy();
 	}
 
-	/* Generate a hash across the pool */
 	spin_lock_irqsave(&input_pool.lock, flags);
-	blake2s_update(&state, (const u8 *)input_pool_data, POOL_BYTES);
-	blake2s_final(&state, hash); /* final zeros out state */
 
-	/*
-	 * We mix the hash back into the pool to prevent backtracking
-	 * attacks (where the attacker knows the state of the pool
-	 * plus the current outputs, and attempts to find previous
-	 * outputs), unless the hash function can be inverted. By
-	 * mixing at least a hash worth of hash data back, we make
-	 * brute-forcing the feedback as hard as brute-forcing the
-	 * hash.
-	 */
-	__mix_pool_bytes(hash, sizeof(hash));
-	spin_unlock_irqrestore(&input_pool.lock, flags);
+	/* seed = HASHPRF(last_key, entropy_input) */
+	blake2s_final(&input_pool.hash, seed);
 
-	/* Note that EXTRACT_SIZE is half of hash size here, because above
-	 * we've dumped the full length back into mixer. By reducing the
-	 * amount that we emit, we retain a level of forward secrecy.
-	 */
-	memcpy(out, hash, EXTRACT_SIZE);
-	memzero_explicit(hash, sizeof(hash));
-}
+	/* next_key = HASHPRF(key, RDRAND || 0) */
+	block.counter = 0;
+	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
+	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
 
-static ssize_t _extract_entropy(void *buf, size_t nbytes)
-{
-	ssize_t ret = 0, i;
-	u8 tmp[EXTRACT_SIZE];
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+	memzero_explicit(next_key, sizeof(next_key));
 
 	while (nbytes) {
-		extract_buf(tmp);
-		i = min_t(int, nbytes, EXTRACT_SIZE);
-		memcpy(buf, tmp, i);
+		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
+		/* output = HASHPRF(key, RDRAND || ++counter) */
+		++block.counter;
+		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
 		nbytes -= i;
 		buf += i;
-		ret += i;
 	}
 
-	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
-
-	return ret;
+	memzero_explicit(seed, sizeof(seed));
+	memzero_explicit(&block, sizeof(block));
 }
 
 /*
@@ -1404,13 +1277,18 @@ static ssize_t _extract_entropy(void *buf, size_t nbytes)
  * returns it in a buffer.
  *
  * The min parameter specifies the minimum amount we can pull before
- * failing to avoid races that defeat catastrophic reseeding.
+ * failing to avoid races that defeat catastrophic reseeding. If we
+ * have less than min entropy available, we return false and buf is
+ * not filled.
  */
-static ssize_t extract_entropy(void *buf, size_t nbytes, int min)
+static bool extract_entropy(void *buf, size_t nbytes, int min)
 {
 	trace_extract_entropy(nbytes, POOL_ENTROPY_BITS(), _RET_IP_);
-	nbytes = account(nbytes, min);
-	return _extract_entropy(buf, nbytes);
+	if (account(nbytes, min)) {
+		_extract_entropy(buf, nbytes);
+		return true;
+	}
+	return false;
 }
 
 #define warn_unseeded_randomness(previous) \
@@ -1674,7 +1552,7 @@ static void __init init_std_data(void)
 	unsigned long rv;
 
 	mix_pool_bytes(&now, sizeof(now));
-	for (i = POOL_BYTES; i > 0; i -= sizeof(rv)) {
+	for (i = BLAKE2S_BLOCK_SIZE; i > 0; i -= sizeof(rv)) {
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
-- 
2.35.0

