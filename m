Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0E4BDBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378891AbiBUPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:14:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiBUPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:14:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FE21817
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847D861050
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EC6C340E9;
        Mon, 21 Feb 2022 15:14:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TRWH/JTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645456449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYkab++RQAgY2Oxu5GMeiLtAuitDVSBWd0tHvPRhEb4=;
        b=TRWH/JTr1JVx8O94ZEl7DWa71mRdhcp+hTIqV8PFPuxQd3QdahEbn7r4GUKAyHg2saErcj
        XLcE/FoRYcbvFB0rIobHYKTfQV+UZiFAyvxW5XgjMDRdDs/4yxVGVZ/n8NNgy/yq8iZVfH
        ahmBEnKxBNMkqfdxS4BsKaD8C8iLLos=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 09c47107 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 15:14:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     ebiggers@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v3] random: group initialization wait functions
Date:   Mon, 21 Feb 2022 16:14:05 +0100
Message-Id: <20220221151405.2287328-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9r5+9JLN8KjDwmuc1+p1O7THPmzW3sz0jMKKf9k6gCDtQ@mail.gmail.com>
References: <CAHmME9r5+9JLN8KjDwmuc1+p1O7THPmzW3sz0jMKKf9k6gCDtQ@mail.gmail.com>
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

This pulls all of the readiness waiting-focused functions into the first
labeled section.

No functional changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v3 removes the duplicate declarations for _get_random_bytes() and fasync.

 drivers/char/random.c | 333 ++++++++++++++++++++++--------------------
 1 file changed, 172 insertions(+), 161 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ad112f928182..dd2da0b12350 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -201,44 +201,197 @@
 #include <asm/irq_regs.h>
 #include <asm/io.h>
 
-enum {
-	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
-	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
-};
-
-/*
- * Static global variables
- */
-static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
-static struct fasync_struct *fasync;
-
-static DEFINE_SPINLOCK(random_ready_list_lock);
-static LIST_HEAD(random_ready_list);
+/*********************************************************************
+ *
+ * Initialization and readiness waiting.
+ *
+ * Much of the RNG infrastructure is devoted to various dependencies
+ * being able to wait until the RNG has collected enough entropy and
+ * is ready for safe consumption.
+ *
+ *********************************************************************/
 
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
 
+/*
+ * Returns whether or not the input pool has been seeded and thus guaranteed
+ * to supply cryptographically secure random numbers. This applies to: the
+ * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
+ * ,u64,int,long} family of functions.
+ *
+ * Returns: true if the input pool has been seeded.
+ *          false if the input pool has not been seeded.
+ */
+bool rng_is_initialized(void)
+{
+	return crng_ready();
+}
+EXPORT_SYMBOL(rng_is_initialized);
+
+/* Used by wait_for_random_bytes(), and considered an entropy collector, below. */
+static void try_to_generate_entropy(void);
+
+/*
+ * Wait for the input pool to be seeded and thus guaranteed to supply
+ * cryptographically secure random numbers. This applies to: the /dev/urandom
+ * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
+ * family of functions. Using any of these functions without first calling
+ * this function forfeits the guarantee of security.
+ *
+ * Returns: 0 if the input pool has been seeded.
+ *          -ERESTARTSYS if the function was interrupted by a signal.
+ */
+int wait_for_random_bytes(void)
+{
+	if (likely(crng_ready()))
+		return 0;
+
+	do {
+		int ret;
+		ret = wait_event_interruptible_timeout(crng_init_wait, crng_ready(), HZ);
+		if (ret)
+			return ret > 0 ? 0 : ret;
+
+		try_to_generate_entropy();
+	} while (!crng_ready());
+
+	return 0;
+}
+EXPORT_SYMBOL(wait_for_random_bytes);
+
+/*
+ * Add a callback function that will be invoked when the input
+ * pool is initialised.
+ *
+ * returns: 0 if callback is successfully added
+ *	    -EALREADY if pool is already initialised (callback not called)
+ *	    -ENOENT if module for callback is not alive
+ */
+int add_random_ready_callback(struct random_ready_callback *rdy)
+{
+	struct module *owner;
+	unsigned long flags;
+	int err = -EALREADY;
+
+	if (crng_ready())
+		return err;
+
+	owner = rdy->owner;
+	if (!try_module_get(owner))
+		return -ENOENT;
+
+	spin_lock_irqsave(&random_ready_list_lock, flags);
+	if (crng_ready())
+		goto out;
+
+	owner = NULL;
+
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
+
+/*
+ * Delete a previously registered readiness callback function.
+ */
+void del_random_ready_callback(struct random_ready_callback *rdy)
+{
+	unsigned long flags;
+	struct module *owner = NULL;
+
+	spin_lock_irqsave(&random_ready_list_lock, flags);
+	if (!list_empty(&rdy->list)) {
+		list_del_init(&rdy->list);
+		owner = rdy->owner;
+	}
+	spin_unlock_irqrestore(&random_ready_list_lock, flags);
+
+	module_put(owner);
+}
+EXPORT_SYMBOL(del_random_ready_callback);
+
+static void process_random_ready_list(void)
+{
+	unsigned long flags;
+	struct random_ready_callback *rdy, *tmp;
+
+	spin_lock_irqsave(&random_ready_list_lock, flags);
+	list_for_each_entry_safe(rdy, tmp, &random_ready_list, list) {
+		struct module *owner = rdy->owner;
+
+		list_del_init(&rdy->list);
+		rdy->func(rdy);
+		module_put(owner);
+	}
+	spin_unlock_irqrestore(&random_ready_list_lock, flags);
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
+
+enum {
+	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
+	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
+};
+
+/*
+ * Static global variables
+ */
+static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+
+static int crng_init_cnt = 0;
+
 /**********************************************************************
  *
  * OS independent entropy store.   Here are the functions which handle
@@ -322,22 +475,6 @@ static void fast_mix(u32 pool[4])
 	pool[2] = c;  pool[3] = d;
 }
 
-static void process_random_ready_list(void)
-{
-	unsigned long flags;
-	struct random_ready_callback *rdy, *tmp;
-
-	spin_lock_irqsave(&random_ready_list_lock, flags);
-	list_for_each_entry_safe(rdy, tmp, &random_ready_list, list) {
-		struct module *owner = rdy->owner;
-
-		list_del_init(&rdy->list);
-		rdy->func(rdy);
-		module_put(owner);
-	}
-	spin_unlock_irqrestore(&random_ready_list_lock, flags);
-}
-
 static void credit_entropy_bits(size_t nbits)
 {
 	unsigned int entropy_count, orig, add;
@@ -387,8 +524,6 @@ static DEFINE_PER_CPU(struct crng, crngs) = {
 	.lock = INIT_LOCAL_LOCK(crngs.lock),
 };
 
-static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
-
 /*
  * crng_fast_load() can be called by code in the interrupt service
  * path.  So we can't afford to dilly-dally. Returns the number of
@@ -909,29 +1044,6 @@ static bool drain_entropy(void *buf, size_t nbytes)
 	return true;
 }
 
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
 /*
  * This function is the exported kernel interface.  It returns some
  * number of good random numbers, suitable for key generation, seeding
@@ -1032,107 +1144,6 @@ static void try_to_generate_entropy(void)
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
- *
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
- *
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
 /*
  * This function will use the architecture-specific hardware random
  * number generator if it is available. It is not recommended for
-- 
2.35.1

