Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32E4AA37E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353392AbiBDWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:48:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiBDWsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:48:05 -0500
Date:   Fri, 4 Feb 2022 23:48:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644014884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TduC7S/wiuMOZ2oyN7rwATTxHgs4FIjqWmX8yGkrw4M=;
        b=wcSdeEn1LtuFL7ufusbBRvit3gxFeEVqwkYlhrVD/kEgCf7Dj9FG5NgYtJd33THu1dQvNm
        UHTarwVTjtXMAEDmQPt1hcaqLWA6MaY3/K8ApJNZ05DTOgRV9G7V8vqUvC7AqYSaX9bmGn
        n7zBlah2lijFoAufvaqh+JNoXv6eHlCsbeFcKpVAIuu8ughYmFYyLqEqskEYKuUmQbWdXB
        WtHebgZBRKLSsqFxZ4gdi/c1Ys0VX47JlW+RoWFRGJ3SDhvooib7MZErToMwhhLkNJoffw
        fFIjk8UVpc1EJfxOpyCRmniW88Q4db2t5buJ3H3xgYe+jPNtAQrfWp3pUE51lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644014884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TduC7S/wiuMOZ2oyN7rwATTxHgs4FIjqWmX8yGkrw4M=;
        b=8nDipWDD8gDnSuz6IcFwJPo37y7EsTh1yhA4RgOmCge2+bWocfG4yIwdzTPlg7aHx3YjPO
        zGkGf9dGhT1a96Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc2-rt4
Message-ID: <Yf2tI/iAPQRIDhy4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.17-rc2-rt4 patch set. 

Changes since v5.17-rc2-rt3:

  - Replace Valentin ARM64 patch regarding arch_faults_on_old_pte() with
    an alternative version done by him.

  - Correct tracing output. Due to a thinko in the preempt-lazy bits, it
    always reported 'p' for preempt-sched which was not true. Now that
    field is either empty (.) or showing the need-sched bit (n).

  - Update the networking patches based on review on the list.

  - Replace the tty/random patches with an alternative approach kindly
    contributed by Jason A. Donenfeld. They appear to work, more testing
    is needed.

  - Update John's printk series.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc2-rt4

The RT patch against v5.17-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc2-rt4.tar.xz

Sebastian

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7c83a6655d1cc..3caf6346ea95f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1001,7 +1001,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  */
 static inline bool arch_faults_on_old_pte(void)
 {
-	WARN_ON(is_migratable());
+	/* The register read below requires a stable CPU to make any sense */
+	cant_migrate();
 
 	return !cpu_has_hw_af();
 }
diff --git a/drivers/char/random.c b/drivers/char/random.c
index ce3db45638caa..79c0287920601 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -42,61 +42,6 @@
  */
 
 /*
- * (now, with legal B.S. out of the way.....)
- *
- * This routine gathers environmental noise from device drivers, etc.,
- * and returns good random numbers, suitable for cryptographic use.
- * Besides the obvious cryptographic uses, these numbers are also good
- * for seeding TCP sequence numbers, and other places where it is
- * desirable to have numbers which are not only random, but hard to
- * predict by an attacker.
- *
- * Theory of operation
- * ===================
- *
- * Computers are very predictable devices.  Hence it is extremely hard
- * to produce truly random numbers on a computer --- as opposed to
- * pseudo-random numbers, which can easily generated by using a
- * algorithm.  Unfortunately, it is very easy for attackers to guess
- * the sequence of pseudo-random number generators, and for some
- * applications this is not acceptable.  So instead, we must try to
- * gather "environmental noise" from the computer's environment, which
- * must be hard for outside attackers to observe, and use that to
- * generate random numbers.  In a Unix environment, this is best done
- * from inside the kernel.
- *
- * Sources of randomness from the environment include inter-keyboard
- * timings, inter-interrupt timings from some interrupts, and other
- * events which are both (a) non-deterministic and (b) hard for an
- * outside observer to measure.  Randomness from these sources are
- * added to an "entropy pool", which is mixed using a CRC-like function.
- * This is not cryptographically strong, but it is adequate assuming
- * the randomness is not chosen maliciously, and it is fast enough that
- * the overhead of doing it on every interrupt is very reasonable.
- * As random bytes are mixed into the entropy pool, the routines keep
- * an *estimate* of how many bits of randomness have been stored into
- * the random number generator's internal state.
- *
- * When random bytes are desired, they are obtained by taking the BLAKE2s
- * hash of the contents of the "entropy pool".  The BLAKE2s hash avoids
- * exposing the internal state of the entropy pool.  It is believed to
- * be computationally infeasible to derive any useful information
- * about the input of BLAKE2s from its output.  Even if it is possible to
- * analyze BLAKE2s in some clever way, as long as the amount of data
- * returned from the generator is less than the inherent entropy in
- * the pool, the output data is totally unpredictable.  For this
- * reason, the routine decreases its internal estimate of how many
- * bits of "true randomness" are contained in the entropy pool as it
- * outputs random numbers.
- *
- * If this estimate goes to zero, the routine can still generate
- * random numbers; however, an attacker may (at least in theory) be
- * able to infer the future output of the generator from prior
- * outputs.  This requires successful cryptanalysis of BLAKE2s, which is
- * not believed to be feasible, but there is a remote possibility.
- * Nonetheless, these numbers should be useful for the vast majority
- * of purposes.
- *
  * Exported interfaces ---- output
  * ===============================
  *
@@ -298,23 +243,6 @@
  *
  *	mknod /dev/random c 1 8
  *	mknod /dev/urandom c 1 9
- *
- * Acknowledgements:
- * =================
- *
- * Ideas for constructing this random number generator were derived
- * from Pretty Good Privacy's random number generator, and from private
- * discussions with Phil Karn.  Colin Plumb provided a faster random
- * number generator, which speed up the mixing function of the entropy
- * pool, taken from PGPfone.  Dale Worley has also contributed many
- * useful ideas and suggestions to improve this driver.
- *
- * Any flaws in the design are solely my responsibility, and should
- * not be attributed to the Phil, Colin, or any of authors of PGP.
- *
- * Further background information on this topic may be obtained from
- * RFC 1750, "Randomness Recommendations for Security", by Donald
- * Eastlake, Steve Crocker, and Jeff Schiller.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -358,79 +286,15 @@
 
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
@@ -438,6 +302,12 @@ enum poolinfo {
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
@@ -493,79 +363,31 @@ MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
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
-}
-
-static void __mix_pool_bytes(const void *in, int nbytes)
-{
-	trace_mix_pool_bytes_nolock(nbytes, _RET_IP_);
-	_mix_pool_bytes(in, nbytes);
+	blake2s_update(&input_pool.hash, in, nbytes);
 }
 
 static void mix_pool_bytes(const void *in, int nbytes)
@@ -579,11 +401,13 @@ static void mix_pool_bytes(const void *in, int nbytes)
 }
 
 struct fast_pool {
-	u32 pool[4];
+	struct work_struct mix;
 	unsigned long last;
+	u32 pool[4];
+	atomic_t count;
 	u16 reg_idx;
-	u8 count;
 };
+#define FAST_POOL_MIX_INFLIGHT (1U << 31)
 
 /*
  * This is a fast mixing routine used by the interrupt randomness
@@ -613,7 +437,6 @@ static void fast_mix(struct fast_pool *f)
 
 	f->pool[0] = a;  f->pool[1] = b;
 	f->pool[2] = c;  f->pool[3] = d;
-	f->count++;
 }
 
 static void process_random_ready_list(void)
@@ -954,15 +777,14 @@ static int crng_slow_load(const u8 *cp, size_t len)
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
@@ -1220,63 +1042,37 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
-static bool process_interrupt_randomness_pool(struct fast_pool *fast_pool)
+static void mix_interrupt_randomness(struct work_struct *work)
 {
+	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
+
+	fast_pool->last = jiffies;
+
+	/* Since this is the result of a trip through the scheduler, xor in
+	 * a cycle counter. It can't hurt, and might help.
+	 */
+	fast_pool->pool[3] ^= random_get_entropy();
+
 	if (unlikely(crng_init == 0)) {
-		bool pool_reset = false;
-
-		if ((fast_pool->count >= 64) &&
-		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0)
-			pool_reset = true;
-		return pool_reset;
+		if (crng_fast_load((u8 *)&fast_pool->pool, sizeof(fast_pool->pool)) > 0)
+			atomic_set(&fast_pool->count, 0);
+		else
+			atomic_and(~FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
+		return;
 	}
 
-	if ((fast_pool->count < 64) && !time_after(jiffies, fast_pool->last + HZ))
-		return false;
-
-	if (!spin_trylock(&input_pool.lock))
-		return false;
-
-	__mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
-	spin_unlock(&input_pool.lock);
-
-	/* award one bit for the contents of the fast pool */
+	mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+	atomic_set(&fast_pool->count, 0);
 	credit_entropy_bits(1);
-	return true;
 }
 
-#ifdef CONFIG_PREEMPT_RT
-void process_interrupt_randomness(void)
-{
-	struct fast_pool *cpu_pool;
-	struct fast_pool fast_pool;
-
-	lockdep_assert_irqs_enabled();
-
-	migrate_disable();
-	cpu_pool = this_cpu_ptr(&irq_randomness);
-
-	local_irq_disable();
-	memcpy(&fast_pool, cpu_pool, sizeof(fast_pool));
-	local_irq_enable();
-
-	if (process_interrupt_randomness_pool(&fast_pool)) {
-		local_irq_disable();
-		cpu_pool->last = jiffies;
-		cpu_pool->count = 0;
-		local_irq_enable();
-	}
-	memzero_explicit(&fast_pool, sizeof(fast_pool));
-	migrate_enable();
-}
-#endif
-
 void add_interrupt_randomness(int irq)
 {
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned long now = jiffies;
 	cycles_t cycles = random_get_entropy();
+	unsigned int new_count;
 	u32 c_high, j_high;
 	u64 ip;
 
@@ -1294,15 +1090,13 @@ void add_interrupt_randomness(int irq)
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	/*
-	 * On PREEMPT_RT the entropy can not be fed into the input_pool because
-	 * it needs to acquire sleeping locks with disabled interrupts.
-	 * This is deferred to the threaded handler.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    process_interrupt_randomness_pool(fast_pool)) {
-		fast_pool->last = now;
-		fast_pool->count = 0;
+	new_count = (unsigned int)atomic_inc_return(&fast_pool->count);
+	if (new_count >= 64 && new_count < FAST_POOL_MIX_INFLIGHT &&
+	    (time_after(now, fast_pool->last + HZ) || unlikely(crng_init == 0))) {
+		if (unlikely(!fast_pool->mix.func))
+			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+		atomic_or(FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
+		schedule_work(&fast_pool->mix);
 	}
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
@@ -1367,74 +1161,48 @@ static size_t account(size_t nbytes, int min)
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
+	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
+	struct {
+		unsigned long rdrand[32 / sizeof(long)];
+		size_t counter;
+	} block;
+	size_t i;
 
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
+	/* seed = HASHPRF(last_key, entropy_input) */
+	blake2s_final(&input_pool.hash, seed);
+
+	/* next_key = HASHPRF(key, RDRAND || 0) */
+	block.counter = 0;
+	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
+	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
+
 	spin_unlock_irqrestore(&input_pool.lock, flags);
-
-	/* Note that EXTRACT_SIZE is half of hash size here, because above
-	 * we've dumped the full length back into mixer. By reducing the
-	 * amount that we emit, we retain a level of forward secrecy.
-	 */
-	memcpy(out, hash, EXTRACT_SIZE);
-	memzero_explicit(hash, sizeof(hash));
-}
-
-static ssize_t _extract_entropy(void *buf, size_t nbytes)
-{
-	ssize_t ret = 0, i;
-	u8 tmp[EXTRACT_SIZE];
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
@@ -1442,13 +1210,18 @@ static ssize_t _extract_entropy(void *buf, size_t nbytes)
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
@@ -1712,7 +1485,7 @@ static void __init init_std_data(void)
 	unsigned long rv;
 
 	mix_pool_bytes(&now, sizeof(now));
-	for (i = POOL_BYTES; i > 0; i -= sizeof(rv)) {
+	for (i = BLAKE2S_BLOCK_SIZE; i > 0; i -= sizeof(rv)) {
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index ed0edf5884ef8..77f5b564382b6 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -86,7 +86,7 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 	skb->protocol = eth_type_trans(skb, dev);
 
 	len = skb->len;
-	if (likely(netif_rx(skb) == NET_RX_SUCCESS))
+	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
 		dev_lstats_add(dev, len);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5b..a809f56c392f0 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -594,9 +594,11 @@ void __handle_sysrq(int key, bool check_mask)
 		 * should not) and is the invoked operation enabled?
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
+			printk_direct_enter();
 			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
+			printk_direct_exit();
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4086f312f814e..c9e883104adb1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3669,6 +3669,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
 int netif_rx(struct sk_buff *skb);
+int __netif_rx(struct sk_buff *skb);
 
 static inline int netif_rx_ni(struct sk_buff *skb)
 {
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6884b43d3e29e..9ce3e5ad58f06 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -170,6 +170,9 @@ extern void __printk_safe_exit(void);
 #define printk_deferred_enter __printk_safe_enter
 #define printk_deferred_exit __printk_safe_exit
 
+extern void printk_direct_enter(void);
+extern void printk_direct_exit(void);
+
 extern bool pr_flush(int timeout_ms, bool reset_on_progress);
 
 /*
@@ -222,6 +225,14 @@ static inline void printk_deferred_exit(void)
 {
 }
 
+static inline void printk_direct_enter(void)
+{
+}
+
+static inline void printk_direct_exit(void)
+{
+}
+
 static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return true;
diff --git a/include/linux/random.h b/include/linux/random.h
index a02c285a5ee52..c45b2693e51fb 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -36,7 +36,6 @@ static inline void add_latent_entropy(void) {}
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
 extern void add_interrupt_randomness(int irq) __latent_entropy;
-extern void process_interrupt_randomness(void);
 
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c33a904b8f722..80070768a69d3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1735,16 +1735,6 @@ static __always_inline bool is_percpu_thread(void)
 #endif
 }
 
-/* Is the current task guaranteed to stay on its current CPU? */
-static inline bool is_migratable(void)
-{
-#ifdef CONFIG_SMP
-	return preemptible() && !current->migration_disabled;
-#else
-	return false;
-#endif
-}
-
 /* Per-process atomic flags. */
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index a2d9aa16a5d7a..01d60208f0064 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -52,12 +52,6 @@ DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes,
 	TP_ARGS(bytes, IP)
 );
 
-DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
-	TP_PROTO(int bytes, unsigned long IP),
-
-	TP_ARGS(bytes, IP)
-);
-
 TRACE_EVENT(credit_entropy_bits,
 	TP_PROTO(int bits, int entropy_count, unsigned long IP),
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 52501e5f76554..bbfbccf69275e 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -127,6 +127,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * complain:
 	 */
 	if (sysctl_hung_task_warnings) {
+		printk_direct_enter();
+
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -142,6 +144,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 		if (sysctl_hung_task_all_cpu_backtrace)
 			hung_task_show_all_bt = true;
+
+		printk_direct_exit();
 	}
 
 	touch_nmi_watchdog();
@@ -204,12 +208,17 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock)
+	if (hung_task_show_lock) {
+		printk_direct_enter();
 		debug_show_all_locks();
+		printk_direct_exit();
+	}
 
 	if (hung_task_show_all_bt) {
 		hung_task_show_all_bt = false;
+		printk_direct_enter();
 		trigger_all_cpu_backtrace();
+		printk_direct_exit();
 	}
 
 	if (hung_task_call_panic)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4d2921423c271..f23ffd30385b1 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1281,9 +1281,6 @@ static int irq_thread(void *data)
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			process_interrupt_randomness();
-
 		wake_threads_waitq(desc);
 	}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cc04e94c320c4..3bef5100312ea 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -399,14 +399,40 @@ static DEFINE_MUTEX(syslog_lock);
  */
 static bool kthreads_started;
 
-static inline bool kthread_printers_active(void)
+#ifdef CONFIG_PRINTK
+static atomic_t printk_direct = ATOMIC_INIT(0);
+
+/**
+ * printk_direct_enter - cause console printing to occur in the context of
+ * 	printk() callers
+ *
+ * This globally effects all printk() callers.
+ *
+ * Context: Any context.
+ */
+void printk_direct_enter(void)
 {
-	return (kthreads_started &&
-		system_state == SYSTEM_RUNNING &&
-		!oops_in_progress);
+	atomic_inc(&printk_direct);
+}
+
+/**
+ * printk_direct_exit - restore console printing behavior from direct
+ *
+ * Context: Any context.
+ */
+void printk_direct_exit(void)
+{
+	atomic_dec(&printk_direct);
+}
+
+static inline bool allow_direct_printing(void)
+{
+	return (!kthreads_started ||
+		system_state != SYSTEM_RUNNING ||
+		oops_in_progress ||
+		atomic_read(&printk_direct));
 }
 
-#ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -1873,7 +1899,7 @@ static int console_lock_spinning_disable_and_check(void)
 	return 1;
 }
 
-#if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+#if !IS_ENABLED(CONFIG_PREEMPT_RT)
 /**
  * console_trylock_spinning - try to get console_lock by busy waiting
  *
@@ -2270,12 +2296,12 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && !kthread_printers_active()) {
+	if (!in_sched && allow_direct_printing()) {
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore.  The release will print out buffers.
 		 */
-#if (IS_ENABLED(CONFIG_PREEMPT_RT))
+#if IS_ENABLED(CONFIG_PREEMPT_RT)
 		/*
 		 * Use the non-spinning trylock since PREEMPT_RT does not
 		 * support console lock handovers.
@@ -2429,6 +2455,7 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 static bool suppress_message_printing(int level) { return false; }
 static void printk_delay(int level) {}
 static void start_printk_kthread(struct console *con) {}
+static bool allow_direct_printing(void) { return true; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2909,7 +2936,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
-#if (IS_ENABLED(CONFIG_PREEMPT_RT))
+#if IS_ENABLED(CONFIG_PREEMPT_RT)
 	/* PREEMPT_RT does not support console lock handovers. */
 	allow_handover = false;
 #else
@@ -2976,8 +3003,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 	do {
 		/* Let the kthread printers do the work if they can. */
-		if (kthread_printers_active())
-			return false;
+		if (!allow_direct_printing())
+			break;
 
 		any_progress = false;
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 21bebf7c9030b..5da13ae5becba 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -587,6 +587,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	printk_direct_enter();
 	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
@@ -621,6 +622,7 @@ static void print_cpu_stall(unsigned long gps)
 	 */
 	set_tsk_need_resched(current);
 	set_preempt_need_resched();
+	printk_direct_exit();
 }
 
 static void check_cpu_stall(struct rcu_data *rdp)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6bcc5d6a6572b..0f219ce610fce 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -447,9 +447,11 @@ static int __orderly_reboot(void)
 	ret = run_cmd(reboot_cmd);
 
 	if (ret) {
+		printk_direct_enter();
 		pr_warn("Failed to start orderly reboot: forcing the issue\n");
 		emergency_sync();
 		kernel_restart(NULL);
+		printk_direct_exit();
 	}
 
 	return ret;
@@ -462,6 +464,7 @@ static int __orderly_poweroff(bool force)
 	ret = run_cmd(poweroff_cmd);
 
 	if (ret && force) {
+		printk_direct_enter();
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
 
 		/*
@@ -471,6 +474,7 @@ static int __orderly_poweroff(bool force)
 		 */
 		emergency_sync();
 		kernel_power_off();
+		printk_direct_exit();
 	}
 
 	return ret;
@@ -528,6 +532,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
  */
 static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 {
+	printk_direct_enter();
+
 	/*
 	 * We have reached here after the emergency shutdown waiting period has
 	 * expired. This means orderly_poweroff has not been able to shut off
@@ -544,6 +550,8 @@ static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 	 */
 	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n");
 	emergency_restart();
+
+	printk_direct_exit();
 }
 
 static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
@@ -582,11 +590,13 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
+	printk_direct_enter();
+
 	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
 
 	/* Shutdown should be initiated only once. */
 	if (!atomic_dec_and_test(&allow_proceed))
-		return;
+		goto out;
 
 	/*
 	 * Queue a backup emergency shutdown in the event of
@@ -594,6 +604,8 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
 	orderly_poweroff(true);
+out:
+	printk_direct_exit();
 }
 EXPORT_SYMBOL_GPL(hw_protection_shutdown);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d27a05055f392..747d1ca5215e4 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -463,17 +463,19 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 
 	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+#ifndef CONFIG_PREEMPT_LAZY
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
-#ifndef CONFIG_PREEMPT_LAZY
+#endif
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
-#endif
+#ifndef CONFIG_PREEMPT_LAZY
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
+#endif
 	default:
 		need_resched = '.';
 		break;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 99afb88d2e85a..583a53b3928c5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -424,6 +424,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
 
+		printk_direct_enter();
+
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -442,6 +444,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
+
+		printk_direct_exit();
 	}
 
 	return HRTIMER_RESTART;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582ca..56cfbae94c423 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -135,6 +135,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (__this_cpu_read(hard_watchdog_warn) == true)
 			return;
 
+		printk_direct_enter();
+
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
 			 this_cpu);
 		print_modules();
@@ -155,6 +157,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
+		printk_direct_exit();
+
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;
 	}
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a7..e3b4eeb1dcb45 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,9 +102,11 @@ asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
+	printk_direct_enter();
 	printk_cpu_sync_get_irqsave(flags);
 	__dump_stack(log_lvl);
 	printk_cpu_sync_put_irqrestore(flags);
+	printk_direct_exit();
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index d01aec6ae15c8..dabeb35bc8dc7 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -99,6 +99,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		 * Allow nested NMI backtraces while serializing
 		 * against other CPUs.
 		 */
+		printk_direct_enter();
 		printk_cpu_sync_get_irqsave(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
@@ -111,6 +112,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 				dump_stack();
 		}
 		printk_cpu_sync_put_irqrestore(flags);
+		printk_direct_exit();
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
diff --git a/net/core/dev.c b/net/core/dev.c
index 4f3c139e9363f..7ac37cbc42df4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4478,11 +4478,11 @@ static void rps_trigger_softirq(void *data)
  * If yes, queue it to our IPI list and return 1
  * If no, return 0
  */
-static int rps_ipi_queued(struct softnet_data *sd)
+static int napi_schedule_rps(struct softnet_data *sd)
 {
-#ifdef CONFIG_RPS
 	struct softnet_data *mysd = this_cpu_ptr(&softnet_data);
 
+#ifdef CONFIG_RPS
 	if (sd != mysd) {
 		sd->rps_ipi_next = mysd->rps_ipi_list;
 		mysd->rps_ipi_list = sd;
@@ -4491,6 +4491,7 @@ static int rps_ipi_queued(struct softnet_data *sd)
 		return 1;
 	}
 #endif /* CONFIG_RPS */
+	__napi_schedule_irqoff(&mysd->backlog);
 	return 0;
 }
 
@@ -4562,18 +4563,9 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 
 		/* Schedule NAPI for backlog device
 		 * We can use non atomic operation since we own the queue lock
-		 * PREEMPT_RT needs to disable interrupts here for
-		 * synchronisation needed in napi_schedule.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_disable();
-
-		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state)) {
-			if (!rps_ipi_queued(sd))
-				____napi_schedule(sd, &sd->backlog);
-		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_enable();
+		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
+			napi_schedule_rps(sd);
 		goto enqueue;
 	}
 
@@ -4839,6 +4831,16 @@ static int netif_rx_internal(struct sk_buff *skb)
 	return ret;
 }
 
+int __netif_rx(struct sk_buff *skb)
+{
+	int ret;
+
+	trace_netif_rx_entry(skb);
+	ret = netif_rx_internal(skb);
+	trace_netif_rx_exit(ret);
+	return ret;
+}
+
 /**
  *	netif_rx	-	post buffer to the network code
  *	@skb: buffer to post
@@ -4847,24 +4849,21 @@ static int netif_rx_internal(struct sk_buff *skb)
  *	the upper (protocol) levels to process.  It always succeeds. The buffer
  *	may be dropped during processing for congestion control or by the
  *	protocol layers.
+ *	This interface is considered legacy. Modern NIC driver should use NAPI
+ *	and GRO.
  *
  *	return values:
  *	NET_RX_SUCCESS	(no congestion)
  *	NET_RX_DROP     (packet was dropped)
  *
  */
-
 int netif_rx(struct sk_buff *skb)
 {
 	int ret;
 
 	local_bh_disable();
-	trace_netif_rx_entry(skb);
-
-	ret = netif_rx_internal(skb);
-	trace_netif_rx_exit(ret);
+	ret = __netif_rx(skb);
 	local_bh_enable();
-
 	return ret;
 }
 EXPORT_SYMBOL(netif_rx);
