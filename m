Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7A4B1545
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbiBJScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:32:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbiBJScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:32:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71316CED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:32:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC9AB81DAC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA9EC004E1;
        Thu, 10 Feb 2022 18:31:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Cu91pSpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644517917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UWVAV1ODwq/qwPfa+mEwgC4Wo0pPU/v9Hycyq3ujnNI=;
        b=Cu91pSpJqHdE05LpLJgq6Ztt282RvHKSg/KDfvbPG2pTM4i/XRHc8fy14rEKeiVAPyYUvu
        0DO7Ykv+yIAjmgCj1JUF3aHN9v0YSO2LrlLk/ZWgF50WjXwf9V8aWLZvB+7uK3bDPAWKeB
        xq5e5AQcv+XrWtgSqah5BKpKLTuUgiU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c28f3b94 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 18:31:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: rearrange and redocument
Date:   Thu, 10 Feb 2022 19:31:43 +0100
Message-Id: <20220210183143.194582-1-Jason@zx2c4.com>
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

We previously had massive documentation comments and functions strewn
all about. This attempts to restore sanity by dividing the code into a
few sections:

- Fast key erasure RNG.
- Entropy accumulation and extraction.
- Entropy collection.
- Userspace read/write.
- Sysctl.

The result of this ordering and this grouping is only 4 forward
declarations, indicating that this is probably a sensible grouping.
Also, some documentation that was just hopelessly out of date been
removed. We'll later look into re-adding parts of this to the Linux man
pages project.

This commit should have no functionality changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 1715 +++++++++++++++++++---------------------
 include/linux/random.h |    6 +-
 2 files changed, 812 insertions(+), 909 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ea4a89129865..b27f72e4b284 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2,168 +2,7 @@
 /*
  * Copyright (C) 2017-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
- * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
- * rights reserved.
- */
-
-/*
- * Exported interfaces ---- output
- * ===============================
- *
- * There are four exported interfaces; two for use within the kernel,
- * and two for use from userspace.
- *
- * Exported interfaces ---- userspace output
- * -----------------------------------------
- *
- * The userspace interfaces are two character devices /dev/random and
- * /dev/urandom.  /dev/random is suitable for use when very high
- * quality randomness is desired (for example, for key generation or
- * one-time pads), as it will only return a maximum of the number of
- * bits of randomness (as estimated by the random number generator)
- * contained in the entropy pool.
- *
- * The /dev/urandom device does not have this limit, and will return
- * as many bytes as are requested.  As more and more random bytes are
- * requested without giving time for the entropy pool to recharge,
- * this will result in random numbers that are merely cryptographically
- * strong.  For many applications, however, this is acceptable.
- *
- * Exported interfaces ---- kernel output
- * --------------------------------------
- *
- * The primary kernel interfaces are:
- *
- *	void get_random_bytes(void *buf, size_t nbytes);
- *	u32 get_random_u32()
- *	u64 get_random_u64()
- *	unsigned int get_random_int()
- *	unsigned long get_random_long()
- *
- * These interfaces will return the requested number of random bytes
- * into the given buffer or as a return value. This is equivalent to a
- * read from /dev/urandom. The get_random_{u32,u64,int,long}() family
- * of functions may be higher performance for one-off random integers,
- * because they do a bit of buffering.
- *
- * prandom_u32()
- * -------------
- *
- * For even weaker applications, see the pseudorandom generator
- * prandom_u32(), prandom_max(), and prandom_bytes().  If the random
- * numbers aren't security-critical at all, these are *far* cheaper.
- * Useful for self-tests, random error simulation, randomized backoffs,
- * and any other application where you trust that nobody is trying to
- * maliciously mess with you by guessing the "random" numbers.
- *
- * Exported interfaces ---- input
- * ==============================
- *
- * The current exported interfaces for gathering environmental noise
- * from the devices are:
- *
- *	void add_device_randomness(const void *buf, size_t size);
- *	void add_input_randomness(unsigned int type, unsigned int code,
- *                                unsigned int value);
- *	void add_interrupt_randomness(int irq);
- *	void add_disk_randomness(struct gendisk *disk);
- *	void add_hwgenerator_randomness(const void *buffer, size_t count,
- *					size_t entropy);
- *	void add_bootloader_randomness(const void *buf, size_t size);
- *
- * add_device_randomness() is for adding data to the random pool that
- * is likely to differ between two devices (or possibly even per boot).
- * This would be things like MAC addresses or serial numbers, or the
- * read-out of the RTC. This does *not* add any actual entropy to the
- * pool, but it initializes the pool to different values for devices
- * that might otherwise be identical and have very little entropy
- * available to them (particularly common in the embedded world).
- *
- * add_input_randomness() uses the input layer interrupt timing, as well as
- * the event type information from the hardware.
- *
- * add_interrupt_randomness() uses the interrupt timing as random
- * inputs to the entropy pool. Using the cycle counters and the irq source
- * as inputs, it feeds the randomness roughly once a second.
- *
- * add_disk_randomness() uses what amounts to the seek time of block
- * layer request events, on a per-disk_devt basis, as input to the
- * entropy pool. Note that high-speed solid state drives with very low
- * seek times do not make for good sources of entropy, as their seek
- * times are usually fairly consistent.
- *
- * All of these routines try to estimate how many bits of randomness a
- * particular randomness source.  They do this by keeping track of the
- * first and second order deltas of the event timings.
- *
- * add_hwgenerator_randomness() is for true hardware RNGs, and will credit
- * entropy as specified by the caller. If the entropy pool is full it will
- * block until more entropy is needed.
- *
- * add_bootloader_randomness() is the same as add_hwgenerator_randomness() or
- * add_device_randomness(), depending on whether or not the configuration
- * option CONFIG_RANDOM_TRUST_BOOTLOADER is set.
- *
- * Ensuring unpredictability at system startup
- * ============================================
- *
- * When any operating system starts up, it will go through a sequence
- * of actions that are fairly predictable by an adversary, especially
- * if the start-up does not involve interaction with a human operator.
- * This reduces the actual number of bits of unpredictability in the
- * entropy pool below the value in entropy_count.  In order to
- * counteract this effect, it helps to carry information in the
- * entropy pool across shut-downs and start-ups.  To do this, put the
- * following lines an appropriate script which is run during the boot
- * sequence:
- *
- *	echo "Initializing random number generator..."
- *	random_seed=/var/run/random-seed
- *	# Carry a random seed from start-up to start-up
- *	# Load and then save the whole entropy pool
- *	if [ -f $random_seed ]; then
- *		cat $random_seed >/dev/urandom
- *	else
- *		touch $random_seed
- *	fi
- *	chmod 600 $random_seed
- *	dd if=/dev/urandom of=$random_seed count=1 bs=512
- *
- * and the following lines in an appropriate script which is run as
- * the system is shutdown:
- *
- *	# Carry a random seed from shut-down to start-up
- *	# Save the whole entropy pool
- *	echo "Saving random seed..."
- *	random_seed=/var/run/random-seed
- *	touch $random_seed
- *	chmod 600 $random_seed
- *	dd if=/dev/urandom of=$random_seed count=1 bs=512
- *
- * For example, on most modern systems using the System V init
- * scripts, such code fragments would be found in
- * /etc/rc.d/init.d/random.  On older Linux systems, the correct script
- * location might be in /etc/rcb.d/rc.local or /etc/rc.d/rc.0.
- *
- * Effectively, these commands cause the contents of the entropy pool
- * to be saved at shut-down time and reloaded into the entropy pool at
- * start-up.  (The 'dd' in the addition to the bootup script is to
- * make sure that /etc/random-seed is different for every start-up,
- * even if the system crashes without executing rc.0.)  Even with
- * complete knowledge of the start-up activities, predicting the state
- * of the entropy pool requires knowledge of the previous history of
- * the system.
- *
- * Configuring the /dev/random driver under Linux
- * ==============================================
- *
- * The /dev/random driver under Linux uses minor numbers 8 and 9 of
- * the /dev/mem major number (#1).  So if your system does not have
- * /dev/random and /dev/urandom created already, they can be created
- * by using the commands:
- *
- *	mknod /dev/random c 1 8
- *	mknod /dev/urandom c 1 9
+ * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999. All rights reserved.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -202,236 +41,252 @@
 #include <asm/irq_regs.h>
 #include <asm/io.h>
 
+/*********************************************************************
+ *
+ * Fast key erasure RNG.
+ *
+ * These functions expand entropy from the entropy extractor into
+ * long streams for external consumption using the "fast key erasure"
+ * RNG described at <https://blog.cr.yp.to/20170723-random.html>.
+ *
+ * There is also quite a bit of management associated with determining
+ * whether the RNG has been initialized.
+ *
+ *********************************************************************/
+
 enum {
-	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
-	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
+	CRNG_RESEED_INTERVAL = 300 * HZ,
+	CRNG_INIT_CNT_THRESH = 2 * CHACHA_KEY_SIZE
 };
 
-/*
- * Static global variables
- */
-static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
-static struct fasync_struct *fasync;
+struct {
+	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
+	unsigned long birth;
+	unsigned long generation;
+	spinlock_t lock;
+} base_crng = {
+	.lock = __SPIN_LOCK_UNLOCKED(base_crng.lock)
+};
 
-static DEFINE_SPINLOCK(random_ready_list_lock);
-static LIST_HEAD(random_ready_list);
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
 
 /*
  * crng_init =  0 --> Uninitialized
  *		1 --> Initialized
  *		2 --> Initialized from input_pool
  *
- * crng_init is protected by primary_crng->lock, and only increases
+ * crng_init is protected by base_crng->lock, and only increases
  * its value (from 0->1->2).
  */
 static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
-static int crng_init_cnt = 0;
-static void process_random_ready_list(void);
-static void _get_random_bytes(void *buf, size_t nbytes);
+/* Various types of waiters for crng_init->2 transition. */
+static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
+static struct fasync_struct *fasync;
+static DEFINE_SPINLOCK(random_ready_list_lock);
+static LIST_HEAD(random_ready_list);
 
+/* Control how we warn userspace. */
 static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
 static struct ratelimit_state urandom_warning =
 	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
-
 static int ratelimit_disable __read_mostly;
-
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
-/**********************************************************************
- *
- * OS independent entropy store.   Here are the functions which handle
- * storing entropy in an entropy pool.
- *
- **********************************************************************/
-
-static struct {
-	struct blake2s_state hash;
-	spinlock_t lock;
-	unsigned int entropy_count;
-} input_pool = {
-	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
-		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
-		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
-	.hash.outlen = BLAKE2S_HASH_SIZE,
-	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
-};
-
+/* Forward declarations of entropy collection/extraction functions used by crng. */
+static void try_to_generate_entropy(void);
+static bool extract_entropy_if_full(void *buf, size_t nbytes);
 static void extract_entropy(void *buf, size_t nbytes);
+static void mix_pool_bytes(const void *buf, size_t nbytes);
 
-static void crng_reseed(void);
-
-/*
- * This function adds bytes into the entropy "pool".  It does not
- * update the entropy estimate.  The caller should call
- * credit_entropy_bits if this is appropriate.
- */
-static void _mix_pool_bytes(const void *in, size_t nbytes)
+static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static int __init parse_trust_cpu(char *arg)
 {
-	blake2s_update(&input_pool.hash, in, nbytes);
+	return kstrtobool(arg, &trust_cpu);
 }
+early_param("random.trust_cpu", parse_trust_cpu);
 
-static void mix_pool_bytes(const void *in, size_t nbytes)
+/*
+ * Note that setup_arch() may call add_device_randomness()
+ * long before we get here. This allows seeding of the pools
+ * with some platform dependent data very early in the boot
+ * process. But it limits our options here. We must use
+ * statically allocated structures that already have all
+ * initializations complete at compile time. We should also
+ * take care not to overwrite the precious per platform data
+ * we were given.
+ */
+int __init rand_initialize(void)
 {
-	unsigned long flags;
+	size_t i;
+	ktime_t now = ktime_get_real();
+	bool arch_init = true;
+	unsigned long rv;
 
-	spin_lock_irqsave(&input_pool.lock, flags);
-	_mix_pool_bytes(in, nbytes);
-	spin_unlock_irqrestore(&input_pool.lock, flags);
-}
+	for (i = BLAKE2S_BLOCK_SIZE; i > 0; i -= sizeof(rv)) {
+		if (!arch_get_random_seed_long_early(&rv) &&
+		    !arch_get_random_long_early(&rv)) {
+			rv = random_get_entropy();
+			arch_init = false;
+		}
+		mix_pool_bytes(&rv, sizeof(rv));
+	}
+	mix_pool_bytes(&now, sizeof(now));
+	mix_pool_bytes(utsname(), sizeof(*(utsname())));
 
-static void process_random_ready_list(void)
-{
-	unsigned long flags;
-	struct random_ready_callback *rdy, *tmp;
+	extract_entropy(base_crng.key, sizeof(base_crng.key));
+	++base_crng.generation;
 
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	list_for_each_entry_safe(rdy, tmp, &random_ready_list, list) {
-		struct module *owner = rdy->owner;
+	if (arch_init && trust_cpu && crng_init < 2) {
+		crng_init = 2;
+		pr_notice("crng init done (trusting CPU's manufacturer)\n");
+	}
 
-		list_del_init(&rdy->list);
-		rdy->func(rdy);
-		module_put(owner);
+	if (ratelimit_disable) {
+		urandom_warning.interval = 0;
+		unseeded_warning.interval = 0;
 	}
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
+	return 0;
 }
 
-static void credit_entropy_bits(size_t nbits)
+/*
+ * Returns whether or not the urandom pool has been seeded and thus guaranteed
+ * to supply cryptographically secure random numbers. This applies to: the
+ * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
+ * ,u64,int,long} family of functions.
+ *
+ * Returns: true if the urandom pool has been seeded.
+ *          false if the urandom pool has not been seeded.
+ */
+bool rng_is_initialized(void)
 {
-	unsigned int entropy_count, orig, add;
-
-	if (!nbits)
-		return;
+	return crng_ready();
+}
+EXPORT_SYMBOL(rng_is_initialized);
 
-	add = min_t(size_t, nbits, POOL_BITS);
+/*
+ * Wait for the urandom pool to be seeded and thus guaranteed to supply
+ * cryptographically secure random numbers. This applies to: the /dev/urandom
+ * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
+ * family of functions. Using any of these functions without first calling
+ * this function forfeits the guarantee of security.
+ *
+ * Returns: 0 if the urandom pool has been seeded.
+ *          -ERESTARTSYS if the function was interrupted by a signal.
+ */
+int wait_for_random_bytes(void)
+{
+	if (likely(crng_ready()))
+		return 0;
 
 	do {
-		orig = READ_ONCE(input_pool.entropy_count);
-		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
-	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
+		int ret;
+		ret = wait_event_interruptible_timeout(crng_init_wait, crng_ready(), HZ);
+		if (ret)
+			return ret > 0 ? 0 : ret;
 
-	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
-		crng_reseed();
+		try_to_generate_entropy();
+	} while (!crng_ready());
+
+	return 0;
 }
+EXPORT_SYMBOL(wait_for_random_bytes);
 
-/*********************************************************************
- *
- * CRNG using CHACHA20
+/*
+ * Add a callback function that will be invoked when the nonblocking
+ * pool is initialised.
  *
- *********************************************************************/
+ * returns: 0 if callback is successfully added
+ *	    -EALREADY if pool is already initialised (callback not called)
+ *	    -ENOENT if module for callback is not alive
+ */
+int add_random_ready_callback(struct random_ready_callback *rdy)
+{
+	struct module *owner;
+	unsigned long flags;
+	int err = -EALREADY;
 
-enum {
-	CRNG_RESEED_INTERVAL = 300 * HZ,
-	CRNG_INIT_CNT_THRESH = 2 * CHACHA_KEY_SIZE
-};
+	if (crng_ready())
+		return err;
 
-struct {
-	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
-	unsigned long birth;
-	unsigned long generation;
-	spinlock_t lock;
-} base_crng = {
-	.lock = __SPIN_LOCK_UNLOCKED(base_crng.lock)
-};
+	owner = rdy->owner;
+	if (!try_module_get(owner))
+		return -ENOENT;
 
-struct crng {
-	u8 key[CHACHA_KEY_SIZE];
-	unsigned long generation;
-	local_lock_t lock;
-};
+	spin_lock_irqsave(&random_ready_list_lock, flags);
+	if (crng_ready())
+		goto out;
 
-static DEFINE_PER_CPU(struct crng, crngs) = {
-	.generation = ULONG_MAX,
-	.lock = INIT_LOCAL_LOCK(crngs.lock),
-};
+	owner = NULL;
 
-static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
+	list_add(&rdy->list, &random_ready_list);
+	err = 0;
+
+out:
+	spin_unlock_irqrestore(&random_ready_list_lock, flags);
+
+	module_put(owner);
+
+	return err;
+}
+EXPORT_SYMBOL(add_random_ready_callback);
 
 /*
- * crng_fast_load() can be called by code in the interrupt service
- * path.  So we can't afford to dilly-dally. Returns the number of
- * bytes processed from cp.
+ * Delete a previously registered readiness callback function.
  */
-static size_t crng_fast_load(const void *cp, size_t len)
+void del_random_ready_callback(struct random_ready_callback *rdy)
 {
 	unsigned long flags;
-	u8 *src = (u8 *)cp;
-	size_t ret = 0;
+	struct module *owner = NULL;
 
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return 0;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return 0;
-	}
-	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
-		base_crng.key[crng_init_cnt % sizeof(base_crng.key)] ^= *src;
-		src++; crng_init_cnt++; len--; ret++;
-	}
-	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
-		++base_crng.generation;
-		crng_init = 1;
+	spin_lock_irqsave(&random_ready_list_lock, flags);
+	if (!list_empty(&rdy->list)) {
+		list_del_init(&rdy->list);
+		owner = rdy->owner;
 	}
-	spin_unlock_irqrestore(&base_crng.lock, flags);
-	if (crng_init == 1)
-		pr_notice("fast init done\n");
-	return ret;
+	spin_unlock_irqrestore(&random_ready_list_lock, flags);
+
+	module_put(owner);
 }
+EXPORT_SYMBOL(del_random_ready_callback);
 
-/*
- * crng_slow_load() is called by add_device_randomness, which has two
- * attributes.  (1) We can't trust the buffer passed to it is
- * guaranteed to be unpredictable (so it might not have any entropy at
- * all), and (2) it doesn't have the performance constraints of
- * crng_fast_load().
- *
- * So, we simply hash the contents in with the current key. Finally,
- * we do *not* advance crng_init_cnt since buffer we may get may be
- * something like a fixed DMI table (for example), which might very
- * well be unique to the machine, but is otherwise unvarying.
- */
-static void crng_slow_load(const void *cp, size_t len)
+static void process_random_ready_list(void)
 {
 	unsigned long flags;
-	struct blake2s_state hash;
+	struct random_ready_callback *rdy, *tmp;
 
-	blake2s_init(&hash, sizeof(base_crng.key));
+	spin_lock_irqsave(&random_ready_list_lock, flags);
+	list_for_each_entry_safe(rdy, tmp, &random_ready_list, list) {
+		struct module *owner = rdy->owner;
 
-	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return;
-	if (crng_init != 0) {
-		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return;
+		list_del_init(&rdy->list);
+		rdy->func(rdy);
+		module_put(owner);
 	}
-
-	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
-	blake2s_update(&hash, cp, len);
-	blake2s_final(&hash, base_crng.key);
-
-	spin_unlock_irqrestore(&base_crng.lock, flags);
+	spin_unlock_irqrestore(&random_ready_list_lock, flags);
 }
 
 static void crng_reseed(void)
 {
 	unsigned long flags;
-	int entropy_count;
 	unsigned long next_gen;
 	u8 key[CHACHA_KEY_SIZE];
 	bool finalize_init = false;
 
-	/* First we make sure we have POOL_MIN_BITS of entropy in the pool,
-	 * and then we drain all of it. Only then can we extract a new key.
-	 */
-	do {
-		entropy_count = READ_ONCE(input_pool.entropy_count);
-		if (entropy_count < POOL_MIN_BITS)
-			return;
-	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
-	extract_entropy(key, sizeof(key));
-	wake_up_interruptible(&random_write_wait);
-	kill_fasync(&fasync, SIGIO, POLL_OUT);
+	/* Only reseed if we can, to prevent brute forcing a small amount of new bits. */
+	if (!extract_entropy_if_full(key, sizeof(key)))
+		return;
 
 	/* We copy the new key into the base_crng, overwriting the old one,
 	 * and update the generation counter. We avoid hitting ULONG_MAX,
@@ -470,13 +325,11 @@ static void crng_reseed(void)
 }
 
 /*
- * The general form here is based on a "fast key erasure RNG" from
- * <https://blog.cr.yp.to/20170723-random.html>. It generates a ChaCha
- * block using the provided key, and then immediately overwites that
- * key with half the block. It returns the resultant ChaCha state to the
- * user, along with the second half of the block containing 32 bytes of
- * random data that may be used; random_data_len may not be greater than
- * 32.
+ * This generates a ChaCha block using the provided key, and then
+ * immediately overwites that key with half the block. It returns
+ * the resultant ChaCha state to the user, along with the second
+ * half of the block containing 32 bytes of random data that may
+ * be used; random_data_len may not be greater than 32.
  */
 static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 				  u32 chacha_state[CHACHA_STATE_WORDS],
@@ -559,6 +412,150 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	local_unlock_irqrestore(&crngs.lock, flags);
 }
 
+/*
+ * This function is for crng_init < 2 only.
+ *
+ * crng_fast_load() can be called by code in the interrupt service
+ * path.  So we can't afford to dilly-dally. Returns the number of
+ * bytes processed from cp.
+ */
+static size_t crng_fast_load(const void *cp, size_t len)
+{
+	static int crng_init_cnt = 0;
+	unsigned long flags;
+	u8 *src = (u8 *)cp;
+	size_t ret = 0;
+
+	if (!spin_trylock_irqsave(&base_crng.lock, flags))
+		return 0;
+	if (crng_init != 0) {
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+		return 0;
+	}
+	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
+		base_crng.key[crng_init_cnt % sizeof(base_crng.key)] ^= *src;
+		src++; crng_init_cnt++; len--; ret++;
+	}
+	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
+		++base_crng.generation;
+		crng_init = 1;
+	}
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+	if (crng_init == 1)
+		pr_notice("fast init done\n");
+	return ret;
+}
+
+/*
+ * This function is for crng_init < 2 only.
+ *
+ * crng_slow_load() is called by add_device_randomness, which has two
+ * attributes.  (1) We can't trust the buffer passed to it is
+ * guaranteed to be unpredictable (so it might not have any entropy at
+ * all), and (2) it doesn't have the performance constraints of
+ * crng_fast_load().
+ *
+ * So, we simply hash the contents in with the current key. Finally,
+ * we do *not* advance crng_init_cnt since buffer we may get may be
+ * something like a fixed DMI table (for example), which might very
+ * well be unique to the machine, but is otherwise unvarying.
+ */
+static void crng_slow_load(const void *cp, size_t len)
+{
+	unsigned long flags;
+	struct blake2s_state hash;
+
+	blake2s_init(&hash, sizeof(base_crng.key));
+
+	if (!spin_trylock_irqsave(&base_crng.lock, flags))
+		return;
+	if (crng_init != 0) {
+		spin_unlock_irqrestore(&base_crng.lock, flags);
+		return;
+	}
+
+	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
+	blake2s_update(&hash, cp, len);
+	blake2s_final(&hash, base_crng.key);
+
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+}
+
+#define warn_unseeded_randomness(previous) \
+	_warn_unseeded_randomness(__func__, (void *)_RET_IP_, (previous))
+
+static void _warn_unseeded_randomness(const char *func_name, void *caller, void **previous)
+{
+#ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
+	const bool print_once = false;
+#else
+	static bool print_once __read_mostly;
+#endif
+
+	if (print_once || crng_ready() ||
+	    (previous && (caller == READ_ONCE(*previous))))
+		return;
+	WRITE_ONCE(*previous, caller);
+#ifndef CONFIG_WARN_ALL_UNSEEDED_RANDOM
+	print_once = true;
+#endif
+	if (__ratelimit(&unseeded_warning))
+		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n",
+				func_name, caller, crng_init);
+}
+
+/*
+ * This function is the exported kernel interface.  It returns some
+ * number of good random numbers, suitable for key generation, seeding
+ * TCP sequence numbers, etc.  It does not rely on the hardware random
+ * number generator.  For random bytes direct from the hardware RNG
+ * (when available), use get_random_bytes_arch(). In order to ensure
+ * that the randomness provided by this function is okay, the function
+ * wait_for_random_bytes() should be called and return 0 at least once
+ * at any point prior.
+ */
+static void _get_random_bytes(void *buf, size_t nbytes)
+{
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	u8 tmp[CHACHA_BLOCK_SIZE];
+	size_t len;
+
+	if (!nbytes)
+		return;
+
+	len = min_t(size_t, 32, nbytes);
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
+		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
+		chacha20_block(chacha_state, buf);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+		nbytes -= len;
+		buf += len;
+	}
+
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+}
+
+void get_random_bytes(void *buf, size_t nbytes)
+{
+	static void *previous;
+
+	warn_unseeded_randomness(&previous);
+	_get_random_bytes(buf, nbytes);
+}
+EXPORT_SYMBOL(get_random_bytes);
+
 static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 {
 	bool large_request = (nbytes > 256);
@@ -609,11 +606,345 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 	return ret;
 }
 
-/*********************************************************************
- *
- * Entropy input management
- *
- *********************************************************************/
+struct batched_entropy {
+	union {
+		/* We make this 1.5x a ChaCha block, so that we get the
+		 * remaining 32 bytes from fast key erasure, plus one full
+		 * block from the detached ChaCha state. We can increase
+		 * the size of this later if needed so long as we keep the
+		 * formula of (integer_blocks + 0.5) * CHACHA_BLOCK_SIZE.
+		 */
+		u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
+		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
+	};
+	local_lock_t lock;
+	unsigned long generation;
+	unsigned int position;
+};
+
+/*
+ * Get a random word for internal kernel use only. The quality of the random
+ * number is good as /dev/urandom. In order to ensure that the randomness
+ * provided by this function is okay, the function wait_for_random_bytes()
+ * should be called and return 0 at least once at any point prior.
+ */
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
+};
+
+u64 get_random_u64(void)
+{
+	u64 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+	static void *previous;
+	unsigned long next_gen;
+
+	warn_unseeded_randomness(&previous);
+
+	local_lock_irqsave(&batched_entropy_u64.lock, flags);
+	batch = raw_cpu_ptr(&batched_entropy_u64);
+
+	next_gen = READ_ONCE(base_crng.generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
+	    next_gen != batch->generation) {
+		_get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
+		batch->position = 0;
+		batch->generation = next_gen;
+	}
+
+	ret = batch->entropy_u64[batch->position];
+	batch->entropy_u64[batch->position] = 0;
+	++batch->position;
+	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u64);
+
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock)
+};
+
+u32 get_random_u32(void)
+{
+	u32 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+	static void *previous;
+	unsigned long next_gen;
+
+	warn_unseeded_randomness(&previous);
+
+	local_lock_irqsave(&batched_entropy_u32.lock, flags);
+	batch = raw_cpu_ptr(&batched_entropy_u32);
+
+	next_gen = READ_ONCE(base_crng.generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
+	    next_gen != batch->generation) {
+		_get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
+		batch->position = 0;
+		batch->generation = next_gen;
+	}
+
+	ret = batch->entropy_u32[batch->position];
+	batch->entropy_u32[batch->position] = 0;
+	++batch->position;
+	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u32);
+
+/**
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -= PAGE_ALIGN(start) - start;
+		start = PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range = ULONG_MAX - start;
+
+	range >>= PAGE_SHIFT;
+
+	if (range == 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
+
+/*
+ * This function will use the architecture-specific hardware random
+ * number generator if it is available. It is not recommended for
+ * use. Use get_random_bytes() instead. It returns the number of
+ * bytes filled in.
+ */
+size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
+{
+	size_t left = nbytes;
+	u8 *p = buf;
+
+	while (left) {
+		unsigned long v;
+		size_t chunk = min_t(size_t, left, sizeof(unsigned long));
+
+		if (!arch_get_random_long(&v))
+			break;
+
+		memcpy(p, &v, chunk);
+		p += chunk;
+		left -= chunk;
+	}
+
+	return nbytes - left;
+}
+EXPORT_SYMBOL(get_random_bytes_arch);
+
+/**********************************************************************
+ *
+ * Entropy accumulation and extraction routines.
+ *
+ * Callers may add entropy via:
+ *
+ *     static void mix_pool_bytes(const void *in, size_t nbytes)
+ *
+ * If added entropy should be calculated, call:
+ *
+ *     static void credit_entropy_bits(size_t nbits)
+ *
+ * Finally, extract entropy via:
+ *
+ *     static void extract_entropy(void *buf, size_t nbytes)
+ *     static bool extract_entropy_if_full(void *buf, size_t nbytes)
+ *
+ **********************************************************************/
+
+enum {
+	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
+	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
+};
+
+/* For notifying userspace should write into /dev/random. */
+static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+
+static struct {
+	struct blake2s_state hash;
+	spinlock_t lock;
+	unsigned int entropy_count;
+} input_pool = {
+	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
+		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
+		    BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
+	.hash.outlen = BLAKE2S_HASH_SIZE,
+	.lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
+};
+
+static void _mix_pool_bytes(const void *in, size_t nbytes)
+{
+	blake2s_update(&input_pool.hash, in, nbytes);
+}
+
+/*
+ * This function adds bytes into the entropy "pool".  It does not
+ * update the entropy estimate.  The caller should call
+ * credit_entropy_bits if this is appropriate.
+ */
+static void mix_pool_bytes(const void *in, size_t nbytes)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(in, nbytes);
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+}
+
+static void credit_entropy_bits(size_t nbits)
+{
+	unsigned int entropy_count, orig, add;
+
+	if (!nbits)
+		return;
+
+	add = min_t(size_t, nbits, POOL_BITS);
+
+	do {
+		orig = READ_ONCE(input_pool.entropy_count);
+		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
+	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
+
+	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
+		crng_reseed();
+}
+
+/*
+ * This is an HKDF-like construction for using the hashed collected entropy
+ * as a PRF key, that's then expanded block-by-block.
+ */
+static void extract_entropy(void *buf, size_t nbytes)
+{
+	unsigned long flags;
+	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
+	struct {
+		unsigned long rdseed[32 / sizeof(long)];
+		size_t counter;
+	} block;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
+		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
+		    !arch_get_random_long(&block.rdseed[i]))
+			block.rdseed[i] = random_get_entropy();
+	}
+
+	spin_lock_irqsave(&input_pool.lock, flags);
+
+	/* seed = HASHPRF(last_key, entropy_input) */
+	blake2s_final(&input_pool.hash, seed);
+
+	/* next_key = HASHPRF(seed, RDSEED || 0) */
+	block.counter = 0;
+	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
+	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
+
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+	memzero_explicit(next_key, sizeof(next_key));
+
+	while (nbytes) {
+		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
+		/* output = HASHPRF(seed, RDSEED || ++counter) */
+		++block.counter;
+		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
+		nbytes -= i;
+		buf += i;
+	}
+
+	memzero_explicit(seed, sizeof(seed));
+	memzero_explicit(&block, sizeof(block));
+}
+
+/*
+ * First we make sure we have POOL_MIN_BITS of entropy in the pool,
+ * and then we drain all of it. Only then can we extract a new key
+ * with extract_entropy().
+ */
+static bool extract_entropy_if_full(void *buf, size_t nbytes)
+{
+	unsigned int entropy_count;
+	do {
+		entropy_count = READ_ONCE(input_pool.entropy_count);
+		if (entropy_count < POOL_MIN_BITS)
+			return false;
+	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
+	extract_entropy(buf, nbytes);
+	wake_up_interruptible(&random_write_wait);
+	kill_fasync(&fasync, SIGIO, POLL_OUT);
+	return true;
+}
+
+/**********************************************************************
+ *
+ * Entropy collection routines.
+ *
+ * The following exported functions are used for pushing entropy into
+ * the above entropy accumulation routines:
+ *
+ *	void add_device_randomness(const void *buf, size_t size);
+ *	void add_input_randomness(unsigned int type, unsigned int code,
+ *                                unsigned int value);
+ *	void add_interrupt_randomness(int irq);
+ *	void add_disk_randomness(struct gendisk *disk);
+ *	void add_hwgenerator_randomness(const void *buffer, size_t count,
+ *					size_t entropy);
+ *	void add_bootloader_randomness(const void *buf, size_t size);
+ *
+ * add_device_randomness() is for adding data to the random pool that
+ * is likely to differ between two devices (or possibly even per boot).
+ * This would be things like MAC addresses or serial numbers, or the
+ * read-out of the RTC. This does *not* add any actual entropy to the
+ * pool, but it initializes the pool to different values for devices
+ * that might otherwise be identical and have very little entropy
+ * available to them (particularly common in the embedded world).
+ *
+ * add_input_randomness() uses the input layer interrupt timing, as well
+ * as the event type information from the hardware.
+ *
+ * add_disk_randomness() uses what amounts to the seek time of block
+ * layer request events, on a per-disk_devt basis, as input to the
+ * entropy pool. Note that high-speed solid state drives with very low
+ * seek times do not make for good sources of entropy, as their seek
+ * times are usually fairly consistent.
+ *
+ * These three routines try to estimate how many bits of randomness a
+ * particular randomness source.  They do this by keeping track of the
+ * first and second order deltas of the event timings.
+ *
+ * add_interrupt_randomness() uses the interrupt timing as random
+ * inputs to the entropy pool. Using the cycle counters and the irq source
+ * as inputs, it feeds the randomness roughly once a second, crediting
+ * 1 bit of entropy.
+ *
+ * add_hwgenerator_randomness() is for true hardware RNGs, and will credit
+ * entropy as specified by the caller. If the entropy pool is full it will
+ * block until more entropy is needed.
+ *
+ * add_bootloader_randomness() is the same as add_hwgenerator_randomness() or
+ * add_device_randomness(), depending on whether or not the configuration
+ * option CONFIG_RANDOM_TRUST_BOOTLOADER is set.
+ *
+ **********************************************************************/
 
 /* There is one of these per entropy source */
 struct timer_rand_state {
@@ -621,8 +952,6 @@ struct timer_rand_state {
 	long last_delta, last_delta2;
 };
 
-#define INIT_TIMER_RAND_STATE { INITIAL_JIFFIES, };
-
 /*
  * Add device- or boot-specific data to the input pool to help
  * initialize it.
@@ -646,8 +975,6 @@ void add_device_randomness(const void *buf, size_t size)
 }
 EXPORT_SYMBOL(add_device_randomness);
 
-static struct timer_rand_state input_timer_state = INIT_TIMER_RAND_STATE;
-
 /*
  * This function adds entropy to the entropy "pool" by using timing
  * delays.  It uses the timer_rand_state structure to make an estimate
@@ -709,6 +1036,7 @@ void add_input_randomness(unsigned int type, unsigned int code,
 			  unsigned int value)
 {
 	static unsigned char last_value;
+	static struct timer_rand_state input_timer_state = { INITIAL_JIFFIES };
 
 	/* ignore autorepeat and the like */
 	if (value == last_value)
@@ -729,8 +1057,67 @@ void add_disk_randomness(struct gendisk *disk)
 	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
 }
 EXPORT_SYMBOL_GPL(add_disk_randomness);
+
+void rand_initialize_disk(struct gendisk *disk)
+{
+	struct timer_rand_state *state;
+
+	/*
+	 * If kzalloc returns null, we just won't use that entropy
+	 * source.
+	 */
+	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	if (state) {
+		state->last_time = INITIAL_JIFFIES;
+		disk->random = state;
+	}
+}
 #endif
 
+/* Interface for in-kernel drivers of true hardware RNGs.
+ * Those devices may produce endless random bits and will be throttled
+ * when our pool is full.
+ */
+void add_hwgenerator_randomness(const void *buffer, size_t count,
+				size_t entropy)
+{
+	if (unlikely(crng_init == 0)) {
+		size_t ret = crng_fast_load(buffer, count);
+		mix_pool_bytes(buffer, ret);
+		count -= ret;
+		buffer += ret;
+		if (!count || crng_init == 0)
+			return;
+	}
+
+	/* Throttle writing if we're above the trickle threshold.
+	 * We'll be woken up again once below POOL_MIN_BITS, when
+	 * the calling thread is about to terminate, or once
+	 * CRNG_RESEED_INTERVAL has elapsed.
+	 */
+	wait_event_interruptible_timeout(random_write_wait,
+			!system_wq || kthread_should_stop() ||
+			input_pool.entropy_count < POOL_MIN_BITS,
+			CRNG_RESEED_INTERVAL);
+	mix_pool_bytes(buffer, count);
+	credit_entropy_bits(entropy);
+}
+EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+
+/* Handle random seed passed by bootloader.
+ * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
+ * it would be regarded as device data.
+ * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
+ */
+void add_bootloader_randomness(const void *buf, size_t size)
+{
+	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
+		add_hwgenerator_randomness(buf, size, size * 8);
+	else
+		add_device_randomness(buf, size);
+}
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+
 struct fast_pool {
 	union {
 		u64 pool64[2];
@@ -826,174 +1213,47 @@ void add_interrupt_randomness(int irq)
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
 
-	if (sizeof(unsigned long) == 8) {
-		fast_pool->pool64[0] ^= cycles ^ rol64(now, 32) ^ irq;
-		fast_pool->pool64[1] ^= regs ? instruction_pointer(regs) : _RET_IP_;
-	} else {
-		fast_pool->pool32[0] ^= cycles ^ irq;
-		fast_pool->pool32[1] ^= now;
-		fast_pool->pool32[2] ^= regs ? instruction_pointer(regs) : _RET_IP_;
-		fast_pool->pool32[3] ^= get_reg(fast_pool, regs);
-	}
-
-	fast_mix(fast_pool->pool32);
-	new_count = ++fast_pool->count;
-
-	if (unlikely(crng_init == 0)) {
-		if (new_count >= 64 &&
-		    crng_fast_load(fast_pool->pool32, sizeof(fast_pool->pool32)) > 0) {
-			fast_pool->count = 0;
-			fast_pool->last = now;
-
-			/* Technically this call means that we're using a spinlock_t
-			 * in the IRQ handler, which isn't terrific for PREEMPT_RT.
-			 * However, this only happens during boot, and then never
-			 * again, so we live with it.
-			 */
-			mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
-		}
-		return;
-	}
-
-	if (new_count & FAST_POOL_MIX_INFLIGHT)
-		return;
-
-	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
-		return;
-
-	if (unlikely(!fast_pool->mix.func))
-		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
-	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
-}
-EXPORT_SYMBOL_GPL(add_interrupt_randomness);
-
-/*********************************************************************
- *
- * Entropy extraction routines
- *
- *********************************************************************/
-
-/*
- * This is an HKDF-like construction for using the hashed collected entropy
- * as a PRF key, that's then expanded block-by-block.
- */
-static void extract_entropy(void *buf, size_t nbytes)
-{
-	unsigned long flags;
-	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
-	struct {
-		unsigned long rdseed[32 / sizeof(long)];
-		size_t counter;
-	} block;
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
-		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
-		    !arch_get_random_long(&block.rdseed[i]))
-			block.rdseed[i] = random_get_entropy();
-	}
-
-	spin_lock_irqsave(&input_pool.lock, flags);
-
-	/* seed = HASHPRF(last_key, entropy_input) */
-	blake2s_final(&input_pool.hash, seed);
-
-	/* next_key = HASHPRF(seed, RDSEED || 0) */
-	block.counter = 0;
-	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
-	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
-
-	spin_unlock_irqrestore(&input_pool.lock, flags);
-	memzero_explicit(next_key, sizeof(next_key));
-
-	while (nbytes) {
-		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
-		/* output = HASHPRF(seed, RDSEED || ++counter) */
-		++block.counter;
-		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
-		nbytes -= i;
-		buf += i;
-	}
-
-	memzero_explicit(seed, sizeof(seed));
-	memzero_explicit(&block, sizeof(block));
-}
-
-#define warn_unseeded_randomness(previous) \
-	_warn_unseeded_randomness(__func__, (void *)_RET_IP_, (previous))
-
-static void _warn_unseeded_randomness(const char *func_name, void *caller, void **previous)
-{
-#ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
-	const bool print_once = false;
-#else
-	static bool print_once __read_mostly;
-#endif
-
-	if (print_once || crng_ready() ||
-	    (previous && (caller == READ_ONCE(*previous))))
-		return;
-	WRITE_ONCE(*previous, caller);
-#ifndef CONFIG_WARN_ALL_UNSEEDED_RANDOM
-	print_once = true;
-#endif
-	if (__ratelimit(&unseeded_warning))
-		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n",
-				func_name, caller, crng_init);
-}
-
-/*
- * This function is the exported kernel interface.  It returns some
- * number of good random numbers, suitable for key generation, seeding
- * TCP sequence numbers, etc.  It does not rely on the hardware random
- * number generator.  For random bytes direct from the hardware RNG
- * (when available), use get_random_bytes_arch(). In order to ensure
- * that the randomness provided by this function is okay, the function
- * wait_for_random_bytes() should be called and return 0 at least once
- * at any point prior.
- */
-static void _get_random_bytes(void *buf, size_t nbytes)
-{
-	u32 chacha_state[CHACHA_STATE_WORDS];
-	u8 tmp[CHACHA_BLOCK_SIZE];
-	size_t len;
+	if (sizeof(unsigned long) == 8) {
+		fast_pool->pool64[0] ^= cycles ^ rol64(now, 32) ^ irq;
+		fast_pool->pool64[1] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+	} else {
+		fast_pool->pool32[0] ^= cycles ^ irq;
+		fast_pool->pool32[1] ^= now;
+		fast_pool->pool32[2] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+		fast_pool->pool32[3] ^= get_reg(fast_pool, regs);
+	}
 
-	if (!nbytes)
-		return;
+	fast_mix(fast_pool->pool32);
+	new_count = ++fast_pool->count;
 
-	len = min_t(size_t, 32, nbytes);
-	crng_make_state(chacha_state, buf, len);
-	nbytes -= len;
-	buf += len;
+	if (unlikely(crng_init == 0)) {
+		if (new_count >= 64 &&
+		    crng_fast_load(fast_pool->pool32, sizeof(fast_pool->pool32)) > 0) {
+			fast_pool->count = 0;
+			fast_pool->last = now;
 
-	while (nbytes) {
-		if (nbytes < CHACHA_BLOCK_SIZE) {
-			chacha20_block(chacha_state, tmp);
-			memcpy(buf, tmp, nbytes);
-			memzero_explicit(tmp, sizeof(tmp));
-			break;
+			/* Technically this call means that we're using a spinlock_t
+			 * in the IRQ handler, which isn't terrific for PREEMPT_RT.
+			 * However, this only happens during boot, and then never
+			 * again, so we live with it.
+			 */
+			mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
 		}
-
-		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
-		chacha20_block(chacha_state, buf);
-		if (unlikely(chacha_state[12] == 0))
-			++chacha_state[13];
-		nbytes -= len;
-		buf += len;
+		return;
 	}
 
-	memzero_explicit(chacha_state, sizeof(chacha_state));
-}
+	if (new_count & FAST_POOL_MIX_INFLIGHT)
+		return;
 
-void get_random_bytes(void *buf, size_t nbytes)
-{
-	static void *previous;
+	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
+		return;
 
-	warn_unseeded_randomness(&previous);
-	_get_random_bytes(buf, nbytes);
+	if (unlikely(!fast_pool->mix.func))
+		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
+	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
-EXPORT_SYMBOL(get_random_bytes);
+EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
 /*
  * Each time the timer fires, we expect that we got an unpredictable
@@ -1044,225 +1304,38 @@ static void try_to_generate_entropy(void)
 	mix_pool_bytes(&stack.now, sizeof(stack.now));
 }
 
-/*
- * Wait for the urandom pool to be seeded and thus guaranteed to supply
- * cryptographically secure random numbers. This applies to: the /dev/urandom
- * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
- * family of functions. Using any of these functions without first calling
- * this function forfeits the guarantee of security.
- *
- * Returns: 0 if the urandom pool has been seeded.
- *          -ERESTARTSYS if the function was interrupted by a signal.
- */
-int wait_for_random_bytes(void)
-{
-	if (likely(crng_ready()))
-		return 0;
-
-	do {
-		int ret;
-		ret = wait_event_interruptible_timeout(crng_init_wait, crng_ready(), HZ);
-		if (ret)
-			return ret > 0 ? 0 : ret;
-
-		try_to_generate_entropy();
-	} while (!crng_ready());
-
-	return 0;
-}
-EXPORT_SYMBOL(wait_for_random_bytes);
-
-/*
- * Returns whether or not the urandom pool has been seeded and thus guaranteed
- * to supply cryptographically secure random numbers. This applies to: the
- * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
- * ,u64,int,long} family of functions.
+/**********************************************************************
  *
- * Returns: true if the urandom pool has been seeded.
- *          false if the urandom pool has not been seeded.
- */
-bool rng_is_initialized(void)
-{
-	return crng_ready();
-}
-EXPORT_SYMBOL(rng_is_initialized);
-
-/*
- * Add a callback function that will be invoked when the nonblocking
- * pool is initialised.
+ * Userspace reader/writer interfaces.
  *
- * returns: 0 if callback is successfully added
- *	    -EALREADY if pool is already initialised (callback not called)
- *	    -ENOENT if module for callback is not alive
- */
-int add_random_ready_callback(struct random_ready_callback *rdy)
-{
-	struct module *owner;
-	unsigned long flags;
-	int err = -EALREADY;
-
-	if (crng_ready())
-		return err;
-
-	owner = rdy->owner;
-	if (!try_module_get(owner))
-		return -ENOENT;
-
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	if (crng_ready())
-		goto out;
-
-	owner = NULL;
-
-	list_add(&rdy->list, &random_ready_list);
-	err = 0;
-
-out:
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
-
-	module_put(owner);
-
-	return err;
-}
-EXPORT_SYMBOL(add_random_ready_callback);
-
-/*
- * Delete a previously registered readiness callback function.
- */
-void del_random_ready_callback(struct random_ready_callback *rdy)
-{
-	unsigned long flags;
-	struct module *owner = NULL;
-
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	if (!list_empty(&rdy->list)) {
-		list_del_init(&rdy->list);
-		owner = rdy->owner;
-	}
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
-
-	module_put(owner);
-}
-EXPORT_SYMBOL(del_random_ready_callback);
-
-/*
- * This function will use the architecture-specific hardware random
- * number generator if it is available. It is not recommended for
- * use. Use get_random_bytes() instead. It returns the number of
- * bytes filled in.
- */
-size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
-{
-	size_t left = nbytes;
-	u8 *p = buf;
-
-	while (left) {
-		unsigned long v;
-		size_t chunk = min_t(size_t, left, sizeof(unsigned long));
-
-		if (!arch_get_random_long(&v))
-			break;
-
-		memcpy(p, &v, chunk);
-		p += chunk;
-		left -= chunk;
-	}
-
-	return nbytes - left;
-}
-EXPORT_SYMBOL(get_random_bytes_arch);
-
-static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
-static int __init parse_trust_cpu(char *arg)
-{
-	return kstrtobool(arg, &trust_cpu);
-}
-early_param("random.trust_cpu", parse_trust_cpu);
-
-/*
- * Note that setup_arch() may call add_device_randomness()
- * long before we get here. This allows seeding of the pools
- * with some platform dependent data very early in the boot
- * process. But it limits our options here. We must use
- * statically allocated structures that already have all
- * initializations complete at compile time. We should also
- * take care not to overwrite the precious per platform data
- * we were given.
- */
-int __init rand_initialize(void)
-{
-	size_t i;
-	ktime_t now = ktime_get_real();
-	bool arch_init = true;
-	unsigned long rv;
-
-	for (i = BLAKE2S_BLOCK_SIZE; i > 0; i -= sizeof(rv)) {
-		if (!arch_get_random_seed_long_early(&rv) &&
-		    !arch_get_random_long_early(&rv)) {
-			rv = random_get_entropy();
-			arch_init = false;
-		}
-		mix_pool_bytes(&rv, sizeof(rv));
-	}
-	mix_pool_bytes(&now, sizeof(now));
-	mix_pool_bytes(utsname(), sizeof(*(utsname())));
-
-	extract_entropy(base_crng.key, sizeof(base_crng.key));
-	++base_crng.generation;
-
-	if (arch_init && trust_cpu && crng_init < 2) {
-		crng_init = 2;
-		pr_notice("crng init done (trusting CPU's manufacturer)\n");
-	}
-
-	if (ratelimit_disable) {
-		urandom_warning.interval = 0;
-		unseeded_warning.interval = 0;
-	}
-	return 0;
-}
-
-#ifdef CONFIG_BLOCK
-void rand_initialize_disk(struct gendisk *disk)
-{
-	struct timer_rand_state *state;
-
-	/*
-	 * If kzalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
-	if (state) {
-		state->last_time = INITIAL_JIFFIES;
-		disk->random = state;
-	}
-}
-#endif
+ **********************************************************************/
 
-static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
-			    loff_t *ppos)
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
+		flags)
 {
-	static int maxwarn = 10;
+	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
+		return -EINVAL;
 
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
-			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
-				  current->comm, nbytes);
-	}
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
+		return -EINVAL;
 
-	return get_random_bytes_user(buf, nbytes);
-}
+	if (count > INT_MAX)
+		count = INT_MAX;
 
-static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
-			   loff_t *ppos)
-{
-	int ret;
+	if (!(flags & GRND_INSECURE) && !crng_ready()) {
+		int ret;
 
-	ret = wait_for_random_bytes();
-	if (ret != 0)
-		return ret;
-	return get_random_bytes_user(buf, nbytes);
+		if (flags & GRND_NONBLOCK)
+			return -EAGAIN;
+		ret = wait_for_random_bytes();
+		if (unlikely(ret))
+			return ret;
+	}
+	return get_random_bytes_user(buf, count);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1314,6 +1387,32 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 	return (ssize_t)count;
 }
 
+static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
+			    loff_t *ppos)
+{
+	static int maxwarn = 10;
+
+	if (!crng_ready() && maxwarn > 0) {
+		maxwarn--;
+		if (__ratelimit(&urandom_warning))
+			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
+				  current->comm, nbytes);
+	}
+
+	return get_random_bytes_user(buf, nbytes);
+}
+
+static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
+			   loff_t *ppos)
+{
+	int ret;
+
+	ret = wait_for_random_bytes();
+	if (ret != 0)
+		return ret;
+	return get_random_bytes_user(buf, nbytes);
+}
+
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	int size, ent_count;
@@ -1398,37 +1497,9 @@ const struct file_operations urandom_fops = {
 	.llseek = noop_llseek,
 };
 
-SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
-		flags)
-{
-	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
-		return -EINVAL;
-
-	/*
-	 * Requesting insecure and blocking randomness at the same time makes
-	 * no sense.
-	 */
-	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
-		return -EINVAL;
-
-	if (count > INT_MAX)
-		count = INT_MAX;
-
-	if (!(flags & GRND_INSECURE) && !crng_ready()) {
-		int ret;
-
-		if (flags & GRND_NONBLOCK)
-			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
-	}
-	return get_random_bytes_user(buf, count);
-}
-
 /********************************************************************
  *
- * Sysctl interface
+ * Sysctl interface, mostly filled with legacy knobs.
  *
  ********************************************************************/
 
@@ -1436,8 +1507,8 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 
 #include <linux/sysctl.h>
 
-static int random_min_urandom_seed = 60;
-static int random_write_wakeup_bits = POOL_MIN_BITS;
+static int sysctl_random_min_urandom_seed = 60;
+static int sysctl_random_write_wakeup_bits = POOL_MIN_BITS;
 static int sysctl_poolsize = POOL_BITS;
 static char sysctl_bootid[16];
 
@@ -1494,14 +1565,14 @@ static struct ctl_table random_table[] = {
 	},
 	{
 		.procname	= "write_wakeup_threshold",
-		.data		= &random_write_wakeup_bits,
+		.data		= &sysctl_random_write_wakeup_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "urandom_min_reseed_secs",
-		.data		= &random_min_urandom_seed,
+		.data		= &sysctl_random_min_urandom_seed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
@@ -1532,168 +1603,4 @@ static int __init random_sysctls_init(void)
 	return 0;
 }
 device_initcall(random_sysctls_init);
-#endif	/* CONFIG_SYSCTL */
-
-struct batched_entropy {
-	union {
-		/* We make this 1.5x a ChaCha block, so that we get the
-		 * remaining 32 bytes from fast key erasure, plus one full
-		 * block from the detached ChaCha state. We can increase
-		 * the size of this later if needed so long as we keep the
-		 * formula of (integer_blocks + 0.5) * CHACHA_BLOCK_SIZE.
-		 */
-		u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
-		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
-	};
-	local_lock_t lock;
-	unsigned long generation;
-	unsigned int position;
-};
-
-/*
- * Get a random word for internal kernel use only. The quality of the random
- * number is good as /dev/urandom. In order to ensure that the randomness
- * provided by this function is okay, the function wait_for_random_bytes()
- * should be called and return 0 at least once at any point prior.
- */
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
-};
-
-u64 get_random_u64(void)
-{
-	u64 ret;
-	unsigned long flags;
-	struct batched_entropy *batch;
-	static void *previous;
-	unsigned long next_gen;
-
-	warn_unseeded_randomness(&previous);
-
-	local_lock_irqsave(&batched_entropy_u64.lock, flags);
-	batch = raw_cpu_ptr(&batched_entropy_u64);
-
-	next_gen = READ_ONCE(base_crng.generation);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
-	    next_gen != batch->generation) {
-		_get_random_bytes(batch->entropy_u64, sizeof(batch->entropy_u64));
-		batch->position = 0;
-		batch->generation = next_gen;
-	}
-
-	ret = batch->entropy_u64[batch->position];
-	batch->entropy_u64[batch->position] = 0;
-	++batch->position;
-	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(get_random_u64);
-
-static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock)
-};
-
-u32 get_random_u32(void)
-{
-	u32 ret;
-	unsigned long flags;
-	struct batched_entropy *batch;
-	static void *previous;
-	unsigned long next_gen;
-
-	warn_unseeded_randomness(&previous);
-
-	local_lock_irqsave(&batched_entropy_u32.lock, flags);
-	batch = raw_cpu_ptr(&batched_entropy_u32);
-
-	next_gen = READ_ONCE(base_crng.generation);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
-	    next_gen != batch->generation) {
-		_get_random_bytes(batch->entropy_u32, sizeof(batch->entropy_u32));
-		batch->position = 0;
-		batch->generation = next_gen;
-	}
-
-	ret = batch->entropy_u32[batch->position];
-	batch->entropy_u32[batch->position] = 0;
-	++batch->position;
-	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(get_random_u32);
-
-/**
- * randomize_page - Generate a random, page aligned address
- * @start:	The smallest acceptable address the caller will take.
- * @range:	The size of the area, starting at @start, within which the
- *		random address must fall.
- *
- * If @start + @range would overflow, @range is capped.
- *
- * NOTE: Historical use of randomize_range, which this replaces, presumed that
- * @start was already page aligned.  We now align it regardless.
- *
- * Return: A page aligned address within [start, start + range).  On error,
- * @start is returned.
- */
-unsigned long randomize_page(unsigned long start, unsigned long range)
-{
-	if (!PAGE_ALIGNED(start)) {
-		range -= PAGE_ALIGN(start) - start;
-		start = PAGE_ALIGN(start);
-	}
-
-	if (start > ULONG_MAX - range)
-		range = ULONG_MAX - start;
-
-	range >>= PAGE_SHIFT;
-
-	if (range == 0)
-		return start;
-
-	return start + (get_random_long() % range << PAGE_SHIFT);
-}
-
-/* Interface for in-kernel drivers of true hardware RNGs.
- * Those devices may produce endless random bits and will be throttled
- * when our pool is full.
- */
-void add_hwgenerator_randomness(const void *buffer, size_t count,
-				size_t entropy)
-{
-	if (unlikely(crng_init == 0)) {
-		size_t ret = crng_fast_load(buffer, count);
-		mix_pool_bytes(buffer, ret);
-		count -= ret;
-		buffer += ret;
-		if (!count || crng_init == 0)
-			return;
-	}
-
-	/* Throttle writing if we're above the trickle threshold.
-	 * We'll be woken up again once below POOL_MIN_BITS, when
-	 * the calling thread is about to terminate, or once
-	 * CRNG_RESEED_INTERVAL has elapsed.
-	 */
-	wait_event_interruptible_timeout(random_write_wait,
-			!system_wq || kthread_should_stop() ||
-			input_pool.entropy_count < POOL_MIN_BITS,
-			CRNG_RESEED_INTERVAL);
-	mix_pool_bytes(buffer, count);
-	credit_entropy_bits(entropy);
-}
-EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
-
-/* Handle random seed passed by bootloader.
- * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
- * it would be regarded as device data.
- * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
- */
-void add_bootloader_randomness(const void *buf, size_t size)
-{
-	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
-		add_hwgenerator_randomness(buf, size, size * 8);
-	else
-		add_device_randomness(buf, size);
-}
-EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+#endif
diff --git a/include/linux/random.h b/include/linux/random.h
index e92efb39779c..37e1e8c43d7e 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -1,9 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * include/linux/random.h
- *
- * Include file for the random number generator.
- */
+
 #ifndef _LINUX_RANDOM_H
 #define _LINUX_RANDOM_H
 
-- 
2.35.0

