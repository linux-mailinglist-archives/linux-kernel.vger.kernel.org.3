Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA352B737
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiERJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiERJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4F120BE6;
        Wed, 18 May 2022 02:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A9E3617C7;
        Wed, 18 May 2022 09:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41281C385A5;
        Wed, 18 May 2022 09:57:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bEWIXAiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652867826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irO/Q9krw8wB4YwpfTM/2sS+w+cDgzawjgfM0Pt73wM=;
        b=bEWIXAiCC6dK/PscC5XWUlHMiQzawLA0WzJpb8nfplIoo2dpoXRiHblVMYpHCosr3SIB27
        lg8Xl+JOjw1fdNxa6t6hfnyXB5+CJvFe8h3IDLFd9y+t8dDST8sUjnULegcxAv0Jl1Yrq+
        ya9ZtLOp5GS9y3GhywswLuyx+z+H8XI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 25be561b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 18 May 2022 09:57:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2] random: remove mostly unused async readiness notifier
Date:   Wed, 18 May 2022 11:56:58 +0200
Message-Id: <20220518095658.24085-1-Jason@zx2c4.com>
In-Reply-To: <YoTB2OlwQq4J4/2D@zx2c4.com>
References: <YoTB2OlwQq4J4/2D@zx2c4.com>
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

The register_random_ready_notifier() notifier is somewhat complicated,
and was already recently rewritten to use notifier blocks. It is only
used now by one consumer in the kernel, vsprintf.c, for which the async
mechanism is really overly complex for what it actually needs. This
commit removes register_random_ready_notifier() and unregister_random_
ready_notifier(), because it just adds complication with little utility,
and changes vsprintf.c to just check on `!rng_is_initialized() &&
!rng_has_arch_random()`, which will eventually be true. Performance-
wise, that code was already using a static branch, so there's basically
no overhead at all to this change.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Petr Mladek <pmladek@suse.com> # for vsprintf.c
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Use a trylock instead of a spinlock to be NMI safe.

 drivers/char/random.c  | 48 ------------------------------
 include/linux/random.h |  2 --
 lib/vsprintf.c         | 66 ++++++++++++++----------------------------
 3 files changed, 22 insertions(+), 94 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5a0fbcf05e63..11abdc5004ec 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -84,8 +84,6 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
 /* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
-static DEFINE_SPINLOCK(random_ready_chain_lock);
-static RAW_NOTIFIER_HEAD(random_ready_chain);
 
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =
@@ -142,51 +140,6 @@ int wait_for_random_bytes(void)
 }
 EXPORT_SYMBOL(wait_for_random_bytes);
 
-/*
- * Add a callback function that will be invoked when the input
- * pool is initialised.
- *
- * returns: 0 if callback is successfully added
- *	    -EALREADY if pool is already initialised (callback not called)
- */
-int __cold register_random_ready_notifier(struct notifier_block *nb)
-{
-	unsigned long flags;
-	int ret = -EALREADY;
-
-	if (crng_ready())
-		return ret;
-
-	spin_lock_irqsave(&random_ready_chain_lock, flags);
-	if (!crng_ready())
-		ret = raw_notifier_chain_register(&random_ready_chain, nb);
-	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
-	return ret;
-}
-
-/*
- * Delete a previously registered readiness callback function.
- */
-int __cold unregister_random_ready_notifier(struct notifier_block *nb)
-{
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&random_ready_chain_lock, flags);
-	ret = raw_notifier_chain_unregister(&random_ready_chain, nb);
-	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
-	return ret;
-}
-
-static void __cold process_random_ready_list(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&random_ready_chain_lock, flags);
-	raw_notifier_call_chain(&random_ready_chain, 0, NULL);
-	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
-}
-
 #define warn_unseeded_randomness() \
 	if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
 		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
@@ -775,7 +728,6 @@ static void __cold _credit_init_bits(size_t bits)
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		execute_in_process_context(crng_set_ready, &set_ready);
-		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/linux/random.h b/include/linux/random.h
index 6af130c6edb9..d2360b2825b6 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -78,8 +78,6 @@ int __init random_init(const char *command_line);
 bool rng_is_initialized(void);
 bool rng_has_arch_random(void);
 int wait_for_random_bytes(void);
-int register_random_ready_notifier(struct notifier_block *nb);
-int unregister_random_ready_notifier(struct notifier_block *nb);
 
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
  * Returns the result of the call to wait_for_random_bytes. */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 20e9887faaaa..fb77f7bfd126 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -750,60 +750,38 @@ static int __init debug_boot_weak_hash_enable(char *str)
 }
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
-static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
-static siphash_key_t ptr_key __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
 
 static void enable_ptr_key_workfn(struct work_struct *work)
 {
-	get_random_bytes(&ptr_key, sizeof(ptr_key));
-	/* Needs to run from preemptible context */
-	static_branch_disable(&not_filled_random_ptr_key);
+	static_branch_enable(&filled_random_ptr_key);
 }
 
-static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
-
-static int fill_random_ptr_key(struct notifier_block *nb,
-			       unsigned long action, void *data)
-{
-	/* This may be in an interrupt handler. */
-	queue_work(system_unbound_wq, &enable_ptr_key_work);
-	return 0;
-}
-
-static struct notifier_block random_ready = {
-	.notifier_call = fill_random_ptr_key
-};
-
-static int __init initialize_ptr_random(void)
-{
-	int ret;
-
-	/* Don't bother waiting for RNG to be ready if RDRAND is mixed in already. */
-	if (rng_has_arch_random()) {
-		enable_ptr_key_workfn(&enable_ptr_key_work);
-		return 0;
-	}
-
-	ret = register_random_ready_notifier(&random_ready);
-	if (!ret) {
-		return 0;
-	} else if (ret == -EALREADY) {
-		/* This is in preemptible context */
-		enable_ptr_key_workfn(&enable_ptr_key_work);
-		return 0;
-	}
-
-	return ret;
-}
-early_initcall(initialize_ptr_random);
-
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 {
+	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
 
-	if (static_branch_unlikely(&not_filled_random_ptr_key))
-		return -EAGAIN;
+	if (!static_branch_likely(&filled_random_ptr_key)) {
+		static bool filled = false;
+		static DEFINE_SPINLOCK(filling);
+		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
+		unsigned long flags;
+
+		if (!system_unbound_wq ||
+		    (!rng_is_initialized() && !rng_has_arch_random()) ||
+		    !spin_trylock_irqsave(&filling, flags))
+			return -EAGAIN;
+
+		if (!filled) {
+			get_random_bytes(&ptr_key, sizeof(ptr_key));
+			queue_work(system_unbound_wq, &enable_ptr_key_work);
+			filled = true;
+		}
+		spin_unlock_irqrestore(&filling, flags);
+	}
+
 
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
-- 
2.35.1

