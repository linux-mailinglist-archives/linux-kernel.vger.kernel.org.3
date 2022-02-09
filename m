Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38F4AE711
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiBIClm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242725AbiBIBUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:20:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB78C061576;
        Tue,  8 Feb 2022 17:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2770CB81E10;
        Wed,  9 Feb 2022 01:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67227C004E1;
        Wed,  9 Feb 2022 01:20:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nvs/4Sih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644369609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuEv25/6C0Eoa5VVABEnQzsuLlTqcOVn0x+kAs5rGBE=;
        b=nvs/4SihltzqfasuZFH0OcNwaN/ne3mNICFVvCnAG0ozzLEAeajs6U851ccnA2NzrWNrZk
        9ahTRcZ5HW69XvwTH1WFRH+8SogF0gnkxtgisxMc89nq1XEZm8Vf/0oUdSvlS7ESnA2Unz
        Y3/bu9fZVbHwebacxe+OOIPQBw7upug=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6a1ed411 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 01:20:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, linux@dominikbrodowski.net, ebiggers@kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 7/9] random: use simpler fast key erasure flow on per-cpu keys
Date:   Wed,  9 Feb 2022 02:19:17 +0100
Message-Id: <20220209011919.493762-8-Jason@zx2c4.com>
In-Reply-To: <20220209011919.493762-1-Jason@zx2c4.com>
References: <20220209011919.493762-1-Jason@zx2c4.com>
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

Rather than the clunky NUMA full ChaCha state system we had prior, this
commit is closer to the original "fast key erasure RNG" proposal from
<https://blog.cr.yp.to/20170723-random.html>, by simply treating ChaCha
keys on a per-cpu basis.

All entropy is extracted to a base crng key of 32 bytes. This base crng
has a birthdate and a generation counter. When we go to take bytes from
the crng, we first check if the birthdate is too old; if it is, we
reseed per usual. Then we start working on a per-cpu crng.

This per-cpu crng makes sure that it has the same generation counter as
the base crng. If it doesn't, it does fast key erasure with the base
crng key and uses the output as its new per-cpu key, and then updates
its local generation counter. Then, using this per-cpu state, we do
ordinary fast key erasure. Half of this first block is used to overwrite
the per-cpu crng key for the next call -- this is the fast key erasure
RNG idea -- and the other half, along with the ChaCha state, is returned
to the caller. If the caller desires more than this remaining half, it
can generate more ChaCha blocks, unlocked, using the now detached ChaCha
state that was just returned. Crypto-wise, this is more or less what we
were doing before, but this simply makes it more explicit and ensures
that we always have backtrack protection by not playing games with a
shared block counter.

The flow looks like this:

──extract()──► base_crng.key ◄──memcpy()───┐
                   │                       │
                   └──chacha()──────┬─► new_base_key
                                    └─► crngs[n].key ◄──memcpy()───┐
                                              │                    │
                                              └──chacha()───┬─► new_key
                                                            └─► random_bytes
                                                                      │
                                                                      └────►

There are a few hairy details around early init. Just as was done
before, prior to having gathered enough entropy, crng_fast_load() and
crng_slow_load() dump bytes directly into the base crng, and when we go
to take bytes from the crng, in that case, we're doing fast key erasure
with the base crng rather than the fast unlocked per-cpu crngs. This is
fine as that's only the state of affairs during very early boot; once
the crng initializes we never use these paths again.

In the process of all this, the APIs into the crng become a bit simpler:
we have get_random_bytes(buf, len) and get_random_bytes_user(buf, len),
which both do what you'd expect. All of the details of fast key erasure
and per-cpu selection happen only in a very short critical section of
crng_make_state(), which selects the right per-cpu key, does the fast
key erasure, and returns a local state to the caller's stack. So, we no
longer have a need for a separate backtrack function, as this happens
all at once here. The API then allows us to extend backtrack protection
to batched entropy without really having to do much at all.

The result is a bit simpler than before and has fewer foot guns. The
init time state machine also gets a lot simpler as we don't need to wait
for workqueues to come online and do deferred work. And the multi-core
performance should be increased significantly, by virtue of having hardly
any locking on the fast path.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 370 ++++++++++++++++++++++++------------------
 1 file changed, 211 insertions(+), 159 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 20374bce9a07..359fd2501c45 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -67,63 +67,19 @@
  * Exported interfaces ---- kernel output
  * --------------------------------------
  *
- * The primary kernel interface is
+ * The primary kernel interfaces are:
  *
  *	void get_random_bytes(void *buf, int nbytes);
- *
- * This interface will return the requested number of random bytes,
- * and place it in the requested buffer.  This is equivalent to a
- * read from /dev/urandom.
- *
- * For less critical applications, there are the functions:
- *
  *	u32 get_random_u32()
  *	u64 get_random_u64()
  *	unsigned int get_random_int()
  *	unsigned long get_random_long()
  *
- * These are produced by a cryptographic RNG seeded from get_random_bytes,
- * and so do not deplete the entropy pool as much.  These are recommended
- * for most in-kernel operations *if the result is going to be stored in
- * the kernel*.
- *
- * Specifically, the get_random_int() family do not attempt to do
- * "anti-backtracking".  If you capture the state of the kernel (e.g.
- * by snapshotting the VM), you can figure out previous get_random_int()
- * return values.  But if the value is stored in the kernel anyway,
- * this is not a problem.
- *
- * It *is* safe to expose get_random_int() output to attackers (e.g. as
- * network cookies); given outputs 1..n, it's not feasible to predict
- * outputs 0 or n+1.  The only concern is an attacker who breaks into
- * the kernel later; the get_random_int() engine is not reseeded as
- * often as the get_random_bytes() one.
- *
- * get_random_bytes() is needed for keys that need to stay secret after
- * they are erased from the kernel.  For example, any key that will
- * be wrapped and stored encrypted.  And session encryption keys: we'd
- * like to know that after the session is closed and the keys erased,
- * the plaintext is unrecoverable to someone who recorded the ciphertext.
- *
- * But for network ports/cookies, stack canaries, PRNG seeds, address
- * space layout randomization, session *authentication* keys, or other
- * applications where the sensitive data is stored in the kernel in
- * plaintext for as long as it's sensitive, the get_random_int() family
- * is just fine.
- *
- * Consider ASLR.  We want to keep the address space secret from an
- * outside attacker while the process is running, but once the address
- * space is torn down, it's of no use to an attacker any more.  And it's
- * stored in kernel data structures as long as it's alive, so worrying
- * about an attacker's ability to extrapolate it from the get_random_int()
- * CRNG is silly.
- *
- * Even some cryptographic keys are safe to generate with get_random_int().
- * In particular, keys for SipHash are generally fine.  Here, knowledge
- * of the key authorizes you to do something to a kernel object (inject
- * packets to a network connection, or flood a hash table), and the
- * key is stored with the object being protected.  Once it goes away,
- * we no longer care if anyone knows the key.
+ * These interfaces will return the requested number of random bytes
+ * into the given buffer or as a return value. This is equivalent to a
+ * read from /dev/urandom. The get_random_{u32,u64,int,long}() family
+ * of functions may be higher performance for one-off random integers,
+ * because they do a bit of buffering.
  *
  * prandom_u32()
  * -------------
@@ -300,20 +256,6 @@ static struct fasync_struct *fasync;
 static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
 
-struct crng_state {
-	u32 state[16];
-	unsigned long init_time;
-	spinlock_t lock;
-};
-
-static struct crng_state primary_crng = {
-	.lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
-	.state[0] = CHACHA_CONSTANT_EXPA,
-	.state[1] = CHACHA_CONSTANT_ND_3,
-	.state[2] = CHACHA_CONSTANT_2_BY,
-	.state[3] = CHACHA_CONSTANT_TE_K,
-};
-
 /*
  * crng_init =  0 --> Uninitialized
  *		1 --> Initialized
@@ -325,9 +267,6 @@ static struct crng_state primary_crng = {
 static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
-#define CRNG_INIT_CNT_THRESH (2 * CHACHA_KEY_SIZE)
-static void extract_crng(u8 out[CHACHA_BLOCK_SIZE]);
-static void crng_backtrack_protect(u8 tmp[CHACHA_BLOCK_SIZE], int used);
 static void process_random_ready_list(void);
 static void _get_random_bytes(void *buf, int nbytes);
 
@@ -465,7 +404,28 @@ static void credit_entropy_bits(int nbits)
  *
  *********************************************************************/
 
-#define CRNG_RESEED_INTERVAL (300 * HZ)
+enum {
+	CRNG_RESEED_INTERVAL = 300 * HZ,
+	CRNG_INIT_CNT_THRESH = 2 * CHACHA_KEY_SIZE
+};
+
+struct {
+	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
+	unsigned long birth;
+	unsigned long generation;
+	spinlock_t lock;
+} base_crng;
+
+struct crng {
+	u8 key[CHACHA_KEY_SIZE];
+	unsigned long generation;
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct crng, crngs) = {
+	.generation = ULONG_MAX,
+	.lock = INIT_LOCAL_LOCK(crngs.lock),
+};
 
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 
@@ -482,22 +442,22 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 	u8 *p;
 	size_t ret = 0;
 
-	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
+	if (!spin_trylock_irqsave(&base_crng.lock, flags))
 		return 0;
 	if (crng_init != 0) {
-		spin_unlock_irqrestore(&primary_crng.lock, flags);
+		spin_unlock_irqrestore(&base_crng.lock, flags);
 		return 0;
 	}
-	p = (u8 *)&primary_crng.state[4];
+	p = base_crng.key;
 	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
-		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
+		p[crng_init_cnt % sizeof(base_crng.key)] ^= *cp;
 		cp++; crng_init_cnt++; len--; ret++;
 	}
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	spin_unlock_irqrestore(&base_crng.lock, flags);
 	if (crng_init == 1)
 		pr_notice("fast init done\n");
 	return ret;
@@ -522,14 +482,14 @@ static int crng_slow_load(const u8 *cp, size_t len)
 	unsigned long flags;
 	static u8 lfsr = 1;
 	u8 tmp;
-	unsigned int i, max = CHACHA_KEY_SIZE;
+	unsigned int i, max = sizeof(base_crng.key);
 	const u8 *src_buf = cp;
-	u8 *dest_buf = (u8 *)&primary_crng.state[4];
+	u8 *dest_buf = base_crng.key;
 
-	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
+	if (!spin_trylock_irqsave(&base_crng.lock, flags))
 		return 0;
 	if (crng_init != 0) {
-		spin_unlock_irqrestore(&primary_crng.lock, flags);
+		spin_unlock_irqrestore(&base_crng.lock, flags);
 		return 0;
 	}
 	if (len > max)
@@ -540,38 +500,48 @@ static int crng_slow_load(const u8 *cp, size_t len)
 		lfsr >>= 1;
 		if (tmp & 1)
 			lfsr ^= 0xE1;
-		tmp = dest_buf[i % CHACHA_KEY_SIZE];
-		dest_buf[i % CHACHA_KEY_SIZE] ^= src_buf[i % len] ^ lfsr;
+		tmp = dest_buf[i % sizeof(base_crng.key)];
+		dest_buf[i % sizeof(base_crng.key)] ^= src_buf[i % len] ^ lfsr;
 		lfsr += (tmp << 3) | (tmp >> 5);
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	spin_unlock_irqrestore(&base_crng.lock, flags);
 	return 1;
 }
 
 static void crng_reseed(void)
 {
 	unsigned long flags;
-	int i, entropy_count;
-	union {
-		u8 block[CHACHA_BLOCK_SIZE];
-		u32 key[8];
-	} buf;
+	int entropy_count;
+	unsigned long next_gen;
+	u8 key[CHACHA_KEY_SIZE];
 
+	/* First we make sure we have POOL_MIN_BITS of entropy in the pool,
+	 * and then we drain all of it. Only then can we extract a new key.
+	 */
 	do {
 		entropy_count = READ_ONCE(input_pool.entropy_count);
 		if (entropy_count < POOL_MIN_BITS)
 			return;
 	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
-	extract_entropy(buf.key, sizeof(buf.key));
+	extract_entropy(key, sizeof(key));
 	wake_up_interruptible(&random_write_wait);
 	kill_fasync(&fasync, SIGIO, POLL_OUT);
 
-	spin_lock_irqsave(&primary_crng.lock, flags);
-	for (i = 0; i < 8; i++)
-		primary_crng.state[i + 4] ^= buf.key[i];
-	memzero_explicit(&buf, sizeof(buf));
-	WRITE_ONCE(primary_crng.init_time, jiffies);
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	/* We copy the new key into the base_crng, overwriting the old one,
+	 * and update the generation counter. We avoid hitting ULONG_MAX,
+	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
+	 * forces new CPUs that come online to always initialize.
+	 */
+	spin_lock_irqsave(&base_crng.lock, flags);
+	memcpy(base_crng.key, key, sizeof(base_crng.key));
+	next_gen = base_crng.generation + 1;
+	if (next_gen == ULONG_MAX)
+		++next_gen;
+	WRITE_ONCE(base_crng.generation, next_gen);
+	base_crng.birth = jiffies;
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+	memzero_explicit(key, sizeof(key));
+
 	if (crng_init < 2) {
 		invalidate_batched_entropy();
 		crng_init = 2;
@@ -592,50 +562,110 @@ static void crng_reseed(void)
 	}
 }
 
-static void extract_crng(u8 out[CHACHA_BLOCK_SIZE])
+/*
+ * The general form here is based on a "fast key erasure RNG" from
+ * <https://blog.cr.yp.to/20170723-random.html>. It generates a ChaCha
+ * block using the provided key, and then immediately overwites that
+ * key with half the block. It returns the resultant ChaCha state to the
+ * user, along with the second half of the block containing 32 bytes of
+ * random data that may be used; random_data_len may not be greater than
+ * 32.
+ */
+static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
+				  u32 chacha_state[CHACHA_STATE_WORDS],
+				  u8 *random_data, size_t random_data_len)
 {
-	unsigned long flags, init_time;
+	u8 first_block[CHACHA_BLOCK_SIZE];
 
-	if (crng_ready()) {
-		init_time = READ_ONCE(primary_crng.init_time);
-		if (time_after(jiffies, init_time + CRNG_RESEED_INTERVAL))
-			crng_reseed();
-	}
-	spin_lock_irqsave(&primary_crng.lock, flags);
-	chacha20_block(&primary_crng.state[0], out);
-	if (primary_crng.state[12] == 0)
-		primary_crng.state[13]++;
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	chacha_init_consts(chacha_state);
+	memcpy(&chacha_state[4], key, CHACHA_KEY_SIZE);
+	memset(&chacha_state[12], 0, sizeof(u32) * 4);
+	chacha20_block(chacha_state, first_block);
+
+	memcpy(key, first_block, CHACHA_KEY_SIZE);
+	memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
+	memzero_explicit(first_block, sizeof(first_block));
 }
 
 /*
- * Use the leftover bytes from the CRNG block output (if there is
- * enough) to mutate the CRNG key to provide backtracking protection.
+ * This function returns a ChaCha state that you may use for generating
+ * random data. It also returns up to 32 bytes on its own of random data
+ * that may be used; random_data_len may not be greater than 32.
  */
-static void crng_backtrack_protect(u8 tmp[CHACHA_BLOCK_SIZE], int used)
+static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
+			    u8 *random_data, size_t random_data_len)
 {
 	unsigned long flags;
-	u32 *s, *d;
-	int i;
+	struct crng *crng;
 
-	used = round_up(used, sizeof(u32));
-	if (used + CHACHA_KEY_SIZE > CHACHA_BLOCK_SIZE) {
-		extract_crng(tmp);
-		used = 0;
+	/* For the fast path, we check whether we're ready, unlocked first, and
+	 * then re-check once locked later. In the case where we're really not
+	 * ready, we do fast key erasure with the base_crng directly, because
+	 * this is what crng_{fast,slow}_load mutate during early init.
+	 */
+	if (unlikely(!crng_ready())) {
+		bool ready;
+
+		spin_lock_irqsave(&base_crng.lock, flags);
+		ready = crng_ready();
+		if (!ready)
+			crng_fast_key_erasure(base_crng.key, chacha_state,
+					      random_data, random_data_len);
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+		if (!ready)
+			return;
 	}
-	spin_lock_irqsave(&primary_crng.lock, flags);
-	s = (u32 *)&tmp[used];
-	d = &primary_crng.state[4];
-	for (i = 0; i < 8; i++)
-		*d++ ^= *s++;
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+
+	/* If the base_crng is more than 5 minutes old, we reseed, which
+	 * in turn bumps the generation counter that we check below.
+	 */
+	if (unlikely(time_after(jiffies, READ_ONCE(base_crng.birth) + CRNG_RESEED_INTERVAL)))
+		crng_reseed();
+
+	local_lock_irqsave(&crngs.lock, flags);
+	crng = raw_cpu_ptr(&crngs);
+
+	/* If our per-cpu crng is older than the base_crng, then it means
+	 * somebody reseeded the base_crng. In that case, we do fast key
+	 * erasure on the base_crng, and use its output as the new key
+	 * for our per-cpu crng. This brings us up to date with base_crng.
+	 */
+	if (unlikely(crng->generation != READ_ONCE(base_crng.generation))) {
+		spin_lock(&base_crng.lock);
+		crng_fast_key_erasure(base_crng.key, chacha_state,
+				      crng->key, sizeof(crng->key));
+		crng->generation = base_crng.generation;
+		spin_unlock(&base_crng.lock);
+	}
+
+	/* Finally, when we've made it this far, our per-cpu crng has an up
+	 * to date key, and we can do fast key erasure with it to produce
+	 * some random data and a ChaCha state for the caller. All other
+	 * branches of this function are "unlikely", so most of the time we
+	 * should wind up here immediately.
+	 */
+	crng_fast_key_erasure(crng->key, chacha_state, random_data, random_data_len);
+	local_unlock_irqrestore(&crngs.lock, flags);
 }
 
-static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
+static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 {
-	ssize_t ret = 0, i = CHACHA_BLOCK_SIZE;
-	u8 tmp[CHACHA_BLOCK_SIZE] __aligned(4);
-	int large_request = (nbytes > 256);
+	bool large_request = (nbytes > 256);
+	ssize_t ret = 0, len;
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	u8 output[CHACHA_BLOCK_SIZE];
+
+	if (!nbytes)
+		return 0;
+
+	len = min_t(ssize_t, 32, nbytes);
+	crng_make_state(chacha_state, output, len);
+
+	if (copy_to_user(buf, output, len))
+		return -EFAULT;
+	nbytes -= len;
+	buf += len;
+	ret += len;
 
 	while (nbytes) {
 		if (large_request && need_resched()) {
@@ -647,22 +677,23 @@ static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
 			schedule();
 		}
 
-		extract_crng(tmp);
-		i = min_t(int, nbytes, CHACHA_BLOCK_SIZE);
-		if (copy_to_user(buf, tmp, i)) {
+		chacha20_block(chacha_state, output);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+
+		len = min_t(ssize_t, nbytes, CHACHA_BLOCK_SIZE);
+		if (copy_to_user(buf, output, len)) {
 			ret = -EFAULT;
 			break;
 		}
 
-		nbytes -= i;
-		buf += i;
-		ret += i;
+		nbytes -= len;
+		buf += len;
+		ret += len;
 	}
-	crng_backtrack_protect(tmp, i);
-
-	/* Wipe data just written to memory */
-	memzero_explicit(tmp, sizeof(tmp));
 
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+	memzero_explicit(output, sizeof(output));
 	return ret;
 }
 
@@ -989,23 +1020,37 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
  */
 static void _get_random_bytes(void *buf, int nbytes)
 {
-	u8 tmp[CHACHA_BLOCK_SIZE] __aligned(4);
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	u8 tmp[CHACHA_BLOCK_SIZE];
+	ssize_t len;
 
 	trace_get_random_bytes(nbytes, _RET_IP_);
 
-	while (nbytes >= CHACHA_BLOCK_SIZE) {
-		extract_crng(buf);
-		buf += CHACHA_BLOCK_SIZE;
-		nbytes -= CHACHA_BLOCK_SIZE;
+	if (!nbytes)
+		return;
+
+	len = min_t(ssize_t, 32, nbytes);
+	crng_make_state(chacha_state, buf, len);
+	nbytes -= len;
+	buf += len;
+
+	while (nbytes) {
+		if (nbytes < CHACHA_BLOCK_SIZE) {
+			chacha20_block(chacha_state, tmp);
+			memcpy(buf, tmp, nbytes);
+			memzero_explicit(tmp, sizeof(tmp));
+			break;
+		}
+
+		len = min_t(ssize_t, nbytes, CHACHA_BLOCK_SIZE);
+		chacha20_block(chacha_state, buf);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+		nbytes -= len;
+		buf += len;
 	}
 
-	if (nbytes > 0) {
-		extract_crng(tmp);
-		memcpy(buf, tmp, nbytes);
-		crng_backtrack_protect(tmp, nbytes);
-	} else
-		crng_backtrack_protect(tmp, CHACHA_BLOCK_SIZE);
-	memzero_explicit(tmp, sizeof(tmp));
+	memzero_explicit(chacha_state, sizeof(chacha_state));
 }
 
 void get_random_bytes(void *buf, int nbytes)
@@ -1236,13 +1281,12 @@ int __init rand_initialize(void)
 		mix_pool_bytes(&rv, sizeof(rv));
 	}
 
-	extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
+	extract_entropy(base_crng.key, sizeof(base_crng.key));
 	if (arch_init && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		crng_init = 2;
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
-	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
@@ -1274,7 +1318,7 @@ static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
 	int ret;
 
 	nbytes = min_t(size_t, nbytes, INT_MAX >> 6);
-	ret = extract_crng_user(buf, nbytes);
+	ret = get_random_bytes_user(buf, nbytes);
 	trace_urandom_read(8 * nbytes, 0, input_pool.entropy_count);
 	return ret;
 }
@@ -1590,8 +1634,14 @@ static atomic_t batch_generation = ATOMIC_INIT(0);
 
 struct batched_entropy {
 	union {
-		u64 entropy_u64[CHACHA_BLOCK_SIZE / sizeof(u64)];
-		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
+		/* We make this 1.5x a ChaCha block, so that we get the
+		 * remaining 32 bytes from fast key erasure, plus one full
+		 * block from the detached ChaCha state. We can increase
+		 * the size of this later if needed so long as we keep the
+		 * formula of (integer_blocks + 0.5) * CHACHA_BLOCK_SIZE.
+		 */
+		u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
+		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
 	};
 	local_lock_t lock;
 	unsigned int position;
@@ -1600,11 +1650,9 @@ struct batched_entropy {
 
 /*
  * Get a random word for internal kernel use only. The quality of the random
- * number is good as /dev/urandom, but there is no backtrack protection, with
- * the goal of being quite fast and not depleting entropy. In order to ensure
- * that the randomness provided by this function is okay, the function
- * wait_for_random_bytes() should be called and return 0 at least once at any
- * point prior.
+ * number is good as /dev/urandom. In order to ensure that the randomness
+ * provided by this function is okay, the function wait_for_random_bytes()
+ * should be called and return 0 at least once at any point prior.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
 	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
@@ -1626,12 +1674,14 @@ u64 get_random_u64(void)
 	next_gen = atomic_read(&batch_generation);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
 	    next_gen != batch->generation) {
-		extract_crng((u8 *)batch->entropy_u64);
+		get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
 		batch->position = 0;
 		batch->generation = next_gen;
 	}
 
-	ret = batch->entropy_u64[batch->position++];
+	ret = batch->entropy_u64[batch->position];
+	batch->entropy_u64[batch->position] = 0;
+	++batch->position;
 	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
 	return ret;
 }
@@ -1657,12 +1707,14 @@ u32 get_random_u32(void)
 	next_gen = atomic_read(&batch_generation);
 	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
 	    next_gen != batch->generation) {
-		extract_crng((u8 *)batch->entropy_u32);
+		get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
 		batch->position = 0;
 		batch->generation = next_gen;
 	}
 
-	ret = batch->entropy_u32[batch->position++];
+	ret = batch->entropy_u32[batch->position];
+	batch->entropy_u32[batch->position] = 0;
+	++batch->position;
 	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
 	return ret;
 }
-- 
2.35.0

