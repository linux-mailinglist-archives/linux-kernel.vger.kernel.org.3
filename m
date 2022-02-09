Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11324AF349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiBINwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiBINwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:52:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD14C0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:52:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8257B821A0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5E4C340E7;
        Wed,  9 Feb 2022 13:52:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Nm0wKJfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644414734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=geYzCosQA2Br4cixK24MztgRHBsbLkEy8N9Z2kG3W08=;
        b=Nm0wKJfCKcNKLgeLt1Q97AEc61ZUfqGyzO/5Zr6pfZ+mXdoVXinu2Y/ZYpOahnA41nAEgL
        GNuU4N+1d6AaVuNqpVnbjpE4SNG9XfptINnOWxpwW2dK+Nv0Elu36s/dMKWeavTSsEH/Nj
        Fg3liJsFPSgRovkeQ/iW+d0Cho74mpc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6dd5c222 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 13:52:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: make more consistent use of integer types
Date:   Wed,  9 Feb 2022 14:52:11 +0100
Message-Id: <20220209135211.557032-1-Jason@zx2c4.com>
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

We've been using a flurry of int, unsigned int, size_t, and ssize_t.
Let's unify all of this to two simple rules:

- When we ingest entropy, we cap it at unsigned int, because our
  entropy_counter is that size too, and because more than that never
  makes sense and isn't really computationally feasible.

- When we output random bytes, we use size_t, because we can in theory
  generate a practically endless stream of random bytes. In practice,
  we should be limited to ssize_t because various existing function
  signatures return that, but this isn't a problem.

In addition, keeping with the convention of other functions in this
file, functions that are dealing with raw bytes now take void *
consistently instead of a mix of that and u8 *, because much of the time
we're actually passing some other structure that is then interpreted as
bytes by the function.

We also take the opportunity to fix the outdated and incorrect comment
in get_random_bytes_arch().

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c     | 75 ++++++++++++++++++---------------------
 include/linux/hw_random.h |  2 +-
 include/linux/random.h    |  6 ++--
 3 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7afc27f2e658..97056666d130 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -69,7 +69,7 @@
  *
  * The primary kernel interfaces are:
  *
- *	void get_random_bytes(void *buf, int nbytes);
+ *	void get_random_bytes(void *buf, size_t nbytes);
  *	u32 get_random_u32()
  *	u64 get_random_u64()
  *	unsigned int get_random_int()
@@ -268,7 +268,7 @@ static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 static void process_random_ready_list(void);
-static void _get_random_bytes(void *buf, int nbytes);
+static void _get_random_bytes(void *buf, size_t nbytes);
 
 static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
@@ -290,7 +290,7 @@ MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 static struct {
 	struct blake2s_state hash;
 	spinlock_t lock;
-	int entropy_count;
+	unsigned int entropy_count;
 } input_pool = {
 	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
 		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
@@ -308,12 +308,12 @@ static void crng_reseed(void);
  * update the entropy estimate.  The caller should call
  * credit_entropy_bits if this is appropriate.
  */
-static void _mix_pool_bytes(const void *in, int nbytes)
+static void _mix_pool_bytes(const void *in, unsigned int nbytes)
 {
 	blake2s_update(&input_pool.hash, in, nbytes);
 }
 
-static void mix_pool_bytes(const void *in, int nbytes)
+static void mix_pool_bytes(const void *in, unsigned int nbytes)
 {
 	unsigned long flags;
 
@@ -378,18 +378,18 @@ static void process_random_ready_list(void)
 	spin_unlock_irqrestore(&random_ready_list_lock, flags);
 }
 
-static void credit_entropy_bits(int nbits)
+static void credit_entropy_bits(unsigned int nbits)
 {
-	int entropy_count, orig;
+	unsigned int entropy_count, orig;
 
-	if (nbits <= 0)
+	if (!nbits)
 		return;
 
-	nbits = min(nbits, POOL_BITS);
+	nbits = min_t(unsigned int, nbits, POOL_BITS);
 
 	do {
 		orig = READ_ONCE(input_pool.entropy_count);
-		entropy_count = min(POOL_BITS, orig + nbits);
+		entropy_count = min_t(unsigned int, POOL_BITS, orig + nbits);
 	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
 
 	trace_credit_entropy_bits(nbits, entropy_count, _RET_IP_);
@@ -436,10 +436,10 @@ static void invalidate_batched_entropy(void);
  * path.  So we can't afford to dilly-dally. Returns the number of
  * bytes processed from cp.
  */
-static size_t crng_fast_load(const u8 *cp, size_t len)
+static size_t crng_fast_load(const void *cp, unsigned int len)
 {
 	unsigned long flags;
-	u8 *p;
+	u8 *src = (u8 *)cp;
 	size_t ret = 0;
 
 	if (!spin_trylock_irqsave(&base_crng.lock, flags))
@@ -448,10 +448,9 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 		spin_unlock_irqrestore(&base_crng.lock, flags);
 		return 0;
 	}
-	p = base_crng.key;
 	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
-		p[crng_init_cnt % sizeof(base_crng.key)] ^= *cp;
-		cp++; crng_init_cnt++; len--; ret++;
+		base_crng.key[crng_init_cnt % sizeof(base_crng.key)] ^= *src;
+		src++; crng_init_cnt++; len--; ret++;
 	}
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
@@ -475,7 +474,7 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
  * something like a fixed DMI table (for example), which might very
  * well be unique to the machine, but is otherwise unvarying.
  */
-static void crng_slow_load(const u8 *cp, size_t len)
+static void crng_slow_load(const void *cp, unsigned int len)
 {
 	unsigned long flags;
 	struct blake2s_state hash;
@@ -739,7 +738,7 @@ static struct timer_rand_state input_timer_state = INIT_TIMER_RAND_STATE;
  * keyboard scan codes, and 256 upwards for interrupts.
  *
  */
-static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
+static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
 {
 	struct {
 		long jiffies;
@@ -783,7 +782,7 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 	 * Round down by 1 bit on general principles,
 	 * and limit entropy estimate to 12 bits.
 	 */
-	credit_entropy_bits(min_t(int, fls(delta >> 1), 11));
+	credit_entropy_bits(min_t(unsigned int, fls(delta >> 1), 11));
 }
 
 void add_input_randomness(unsigned int type, unsigned int code,
@@ -888,7 +887,7 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
-		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
+		    crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
 
@@ -1014,7 +1013,7 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
  * wait_for_random_bytes() should be called and return 0 at least once
  * at any point prior.
  */
-static void _get_random_bytes(void *buf, int nbytes)
+static void _get_random_bytes(void *buf, size_t nbytes)
 {
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	u8 tmp[CHACHA_BLOCK_SIZE];
@@ -1049,7 +1048,7 @@ static void _get_random_bytes(void *buf, int nbytes)
 	memzero_explicit(chacha_state, sizeof(chacha_state));
 }
 
-void get_random_bytes(void *buf, int nbytes)
+void get_random_bytes(void *buf, size_t nbytes)
 {
 	static void *previous;
 
@@ -1210,25 +1209,19 @@ EXPORT_SYMBOL(del_random_ready_callback);
 
 /*
  * This function will use the architecture-specific hardware random
- * number generator if it is available.  The arch-specific hw RNG will
- * almost certainly be faster than what we can do in software, but it
- * is impossible to verify that it is implemented securely (as
- * opposed, to, say, the AES encryption of a sequence number using a
- * key known by the NSA).  So it's useful if we need the speed, but
- * only if we're willing to trust the hardware manufacturer not to
- * have put in a back door.
- *
- * Return number of bytes filled in.
+ * number generator if it is available. It is not recommended for
+ * use. Use get_random_bytes() instead. It returns the number of
+ * bytes filled in.
  */
-int __must_check get_random_bytes_arch(void *buf, int nbytes)
+size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
 {
-	int left = nbytes;
+	size_t left = nbytes;
 	u8 *p = buf;
 
 	trace_get_random_bytes_arch(left, _RET_IP_);
 	while (left) {
 		unsigned long v;
-		int chunk = min_t(int, left, sizeof(unsigned long));
+		size_t chunk = min_t(size_t, left, sizeof(unsigned long));
 
 		if (!arch_get_random_long(&v))
 			break;
@@ -1261,7 +1254,7 @@ early_param("random.trust_cpu", parse_trust_cpu);
  */
 int __init rand_initialize(void)
 {
-	int i;
+	size_t i;
 	ktime_t now = ktime_get_real();
 	bool arch_init = true;
 	unsigned long rv;
@@ -1358,7 +1351,7 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-static int write_pool(const char __user *buffer, size_t count)
+static int write_pool(const void __user *buffer, size_t count)
 {
 	size_t bytes;
 	u8 buf[BLAKE2S_BLOCK_SIZE];
@@ -1380,7 +1373,7 @@ static int write_pool(const char __user *buffer, size_t count)
 static ssize_t random_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	size_t ret;
+	int ret;
 
 	ret = write_pool(buffer, count);
 	if (ret)
@@ -1419,7 +1412,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(size, p++))
 			return -EFAULT;
-		retval = write_pool((const char __user *)p, size);
+		retval = write_pool((const void __user *)p, size);
 		if (retval < 0)
 			return retval;
 		credit_entropy_bits(ent_count);
@@ -1476,8 +1469,6 @@ const struct file_operations urandom_fops = {
 SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 		flags)
 {
-	int ret;
-
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
@@ -1492,6 +1483,8 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 		count = INT_MAX;
 
 	if (!(flags & GRND_INSECURE) && !crng_ready()) {
+		int ret;
+
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_for_random_bytes();
@@ -1760,8 +1753,8 @@ unsigned long randomize_page(unsigned long start, unsigned long range)
  * Those devices may produce endless random bits and will be throttled
  * when our pool is full.
  */
-void add_hwgenerator_randomness(const char *buffer, size_t count,
-				size_t entropy)
+void add_hwgenerator_randomness(const void *buffer, unsigned int count,
+				unsigned int entropy)
 {
 	if (unlikely(crng_init == 0)) {
 		size_t ret = crng_fast_load(buffer, count);
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index 8e6dd908da21..7740828c08de 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -61,6 +61,6 @@ extern int devm_hwrng_register(struct device *dev, struct hwrng *rng);
 extern void hwrng_unregister(struct hwrng *rng);
 extern void devm_hwrng_unregister(struct device *dve, struct hwrng *rng);
 /** Feed random bits into the pool. */
-extern void add_hwgenerator_randomness(const char *buffer, size_t count, size_t entropy);
+extern void add_hwgenerator_randomness(const void *buffer, unsigned int count, unsigned int entropy);
 
 #endif /* LINUX_HWRANDOM_H_ */
diff --git a/include/linux/random.h b/include/linux/random.h
index c45b2693e51f..708af1fcf83e 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -37,13 +37,13 @@ extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
 extern void add_interrupt_randomness(int irq) __latent_entropy;
 
-extern void get_random_bytes(void *buf, int nbytes);
+extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);
 extern int __init rand_initialize(void);
 extern bool rng_is_initialized(void);
 extern int add_random_ready_callback(struct random_ready_callback *rdy);
 extern void del_random_ready_callback(struct random_ready_callback *rdy);
-extern int __must_check get_random_bytes_arch(void *buf, int nbytes);
+extern size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes);
 
 #ifndef MODULE
 extern const struct file_operations random_fops, urandom_fops;
@@ -87,7 +87,7 @@ static inline unsigned long get_random_canary(void)
 
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
  * Returns the result of the call to wait_for_random_bytes. */
-static inline int get_random_bytes_wait(void *buf, int nbytes)
+static inline int get_random_bytes_wait(void *buf, size_t nbytes)
 {
 	int ret = wait_for_random_bytes();
 	get_random_bytes(buf, nbytes);
-- 
2.35.0

