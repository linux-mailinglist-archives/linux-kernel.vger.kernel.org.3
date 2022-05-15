Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ABC5277CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiEONTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 09:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiEONTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4FB65C9;
        Sun, 15 May 2022 06:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B373D60F89;
        Sun, 15 May 2022 13:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9173CC385B8;
        Sun, 15 May 2022 13:19:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G4Rc0/0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652620776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8rR4xd9Ubnr/ECJUaHhJBRv+ty1S2MKH65pLDrdQFM=;
        b=G4Rc0/0lJ/n6BtHsR42XvXNTGNDmHRWlxJhYAvZXlMKq/cjK6G6lPdXzE5tlBnT1aaAORj
        JC+slIErf48B1zhhJ69uVhPk2trpIIVi+minseAr6v2MNu5LdVm+re1DocyJV2w2RpLLfu
        yYa8pC4gRPUbknIRe0eZnZK9Y0pwjBs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 99ec4408 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 15 May 2022 13:19:36 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] random: remove mostly unused async readiness notifier
Date:   Sun, 15 May 2022 15:19:27 +0200
Message-Id: <20220515131927.474097-1-Jason@zx2c4.com>
In-Reply-To: <YoD7hn4yBHE0RYUa@zx2c4.com>
References: <YoD7hn4yBHE0RYUa@zx2c4.com>
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
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 48 --------------------------------
 include/linux/random.h |  2 --
 lib/vsprintf.c         | 63 ++++++++++++++----------------------------
 3 files changed, 20 insertions(+), 93 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 909c23f66fd8..f601856b7b66 100644
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
@@ -706,7 +659,6 @@ static void __cold _credit_init_bits(size_t bits)
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		execute_in_process_context(crng_set_ready, &set_ready);
-		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/linux/random.h b/include/linux/random.h
index 07d93c2a3b5f..fae0c84027fd 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -76,8 +76,6 @@ int __init random_init(const char *command_line);
 bool rng_is_initialized(void);
 bool rng_has_arch_random(void);
 int wait_for_random_bytes(void);
-int register_random_ready_notifier(struct notifier_block *nb);
-int unregister_random_ready_notifier(struct notifier_block *nb);
 
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
  * Returns the result of the call to wait_for_random_bytes. */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 20e9887faaaa..ec67d36abfdb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -750,60 +750,37 @@ static int __init debug_boot_weak_hash_enable(char *str)
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
+/* Maps a pointer to a 32 bit unique identifier. */
+static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 {
-	/* This may be in an interrupt handler. */
-	queue_work(system_unbound_wq, &enable_ptr_key_work);
-	return 0;
-}
-
-static struct notifier_block random_ready = {
-	.notifier_call = fill_random_ptr_key
-};
+	static siphash_key_t ptr_key __read_mostly;
+	unsigned long hashval;
 
-static int __init initialize_ptr_random(void)
-{
-	int ret;
+	if (!static_branch_likely(&filled_random_ptr_key)) {
+		static bool filled = false;
+		static DEFINE_SPINLOCK(filling);
+		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
+		unsigned long flags;
 
-	/* Don't bother waiting for RNG to be ready if RDRAND is mixed in already. */
-	if (rng_has_arch_random()) {
-		enable_ptr_key_workfn(&enable_ptr_key_work);
-		return 0;
-	}
+		if (!rng_is_initialized() && !rng_has_arch_random())
+			return -EAGAIN;
 
-	ret = register_random_ready_notifier(&random_ready);
-	if (!ret) {
-		return 0;
-	} else if (ret == -EALREADY) {
-		/* This is in preemptible context */
-		enable_ptr_key_workfn(&enable_ptr_key_work);
-		return 0;
+		spin_lock_irqsave(&filling, flags);
+		if (!filled) {
+			get_random_bytes(&ptr_key, sizeof(ptr_key));
+			queue_work(system_unbound_wq, &enable_ptr_key_work);
+			filled = true;
+		}
+		spin_unlock_irqrestore(&filling, flags);
 	}
 
-	return ret;
-}
-early_initcall(initialize_ptr_random);
-
-/* Maps a pointer to a 32 bit unique identifier. */
-static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
-{
-	unsigned long hashval;
-
-	if (static_branch_unlikely(&not_filled_random_ptr_key))
-		return -EAGAIN;
 
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
-- 
2.35.1

