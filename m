Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9852038D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiEIR2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiEIR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1327736B;
        Mon,  9 May 2022 10:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4240561573;
        Mon,  9 May 2022 17:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F04C385B1;
        Mon,  9 May 2022 17:24:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P29uYTZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652117076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SW+Pf+scifYK88N8khy9YSj+wlk/zE/8eslg6ri6CSM=;
        b=P29uYTZZS+MTP798m4pse9wYkbgC8oKhrLwtwpuPeYrQGEA7FzyXKUCGTtFI0Wm7kaFMeY
        YyUhPoYGHrcFamJfVMX0VV6WW5NmqMXZvZ2HhKHBFvDUFSDU6BnvUhHoQU4zs/GkUvfQ2S
        TQIdFceKG9XsiEGH24zpICcz4M0gtXI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81c59e08 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 9 May 2022 17:24:36 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: remove ratelimiting for in-kernel unseeded randomness
Date:   Mon,  9 May 2022 19:24:26 +0200
Message-Id: <20220509172426.612649-1-Jason@zx2c4.com>
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

The CONFIG_WARN_ALL_UNSEEDED_RANDOM debug option controls whether the
kernel warns about all unseeded randomness or just the first instance.
There's some complicated rate limiting and comparison to the previous
caller, such that even with CONFIG_WARN_ALL_UNSEEDED_RANDOM enabled,
developers still don't see all the messages or even an accurate count of
how many were missed. This is the result of basically parallel
mechanisms aimed at accomplishing more or less the same thing, added at
different points in random.c history, which sort of compete with the
first-instance-only limiting we have now.

It turns out, however, that nobody cares about the first unseeded
randomness instance of in-kernel users. The same first user has been
there for ages now, and nobody is doing anything about it. It isn't even
clear that anybody _can_ do anything about it. Most places that can do
something about it have switched over to using get_random_bytes_wait()
or wait_for_random_bytes(), which is the right thing to do, but there is
still much code that needs randomness sometimes during init, and as a
geeneral rule, if you're not using one of the _wait functions or the
readiness notifier callback, you're bound to be doing it wrong just
based on that fact alone.

So warning about this same first user that can't easily change is simply
not an effective mechanism for anything at all. Users can't do anything
about it, as the Kconfig text points out -- the problem isn't in
userspace code -- and kernel developers don't or more often can't react
to it.

Instead, show the warning for all instances when CONFIG_WARN_ALL_UNSEEDED_RANDOM
is set, so that developers can debug things need be, or if it isn't set,
don't show a warning at all.

At the same time, CONFIG_WARN_ALL_UNSEEDED_RANDOM now implies setting
random.ratelimit_disable=1 on by default, since if you care about one
you probably care about the other too. And we can clean up usage around
the related urandom_warning ratelimiter as well (whose behavior isn't
changing), so that it properly counts missed messages after the 10
message threshold is reached.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 62 +++++++++++++------------------------------
 lib/Kconfig.debug     |  3 +--
 2 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1598bb40376e..2f8559122dfa 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -88,11 +88,10 @@ static DEFINE_SPINLOCK(random_ready_chain_lock);
 static RAW_NOTIFIER_HEAD(random_ready_chain);
 
 /* Control how we warn userspace. */
-static struct ratelimit_state unseeded_warning =
-	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
 static struct ratelimit_state urandom_warning =
 	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
-static int ratelimit_disable __read_mostly;
+static int ratelimit_disable __read_mostly =
+	IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM);
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
@@ -183,27 +182,15 @@ static void process_random_ready_list(void)
 	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
 }
 
-#define warn_unseeded_randomness(previous) \
-	_warn_unseeded_randomness(__func__, (void *)_RET_IP_, (previous))
+#define warn_unseeded_randomness() \
+	_warn_unseeded_randomness(__func__, (void *)_RET_IP_)
 
-static void _warn_unseeded_randomness(const char *func_name, void *caller, void **previous)
+static void _warn_unseeded_randomness(const char *func_name, void *caller)
 {
-#ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
-	const bool print_once = false;
-#else
-	static bool print_once __read_mostly;
-#endif
-
-	if (print_once || crng_ready() ||
-	    (previous && (caller == READ_ONCE(*previous))))
+	if (!IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) || crng_ready())
 		return;
-	WRITE_ONCE(*previous, caller);
-#ifndef CONFIG_WARN_ALL_UNSEEDED_RANDOM
-	print_once = true;
-#endif
-	if (__ratelimit(&unseeded_warning))
-		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n",
-				func_name, caller, crng_init);
+	printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n",
+			func_name, caller, crng_init);
 }
 
 
@@ -455,9 +442,7 @@ static void _get_random_bytes(void *buf, size_t nbytes)
  */
 void get_random_bytes(void *buf, size_t nbytes)
 {
-	static void *previous;
-
-	warn_unseeded_randomness(&previous);
+	warn_unseeded_randomness();
 	_get_random_bytes(buf, nbytes);
 }
 EXPORT_SYMBOL(get_random_bytes);
@@ -553,10 +538,9 @@ u64 get_random_u64(void)
 	u64 ret;
 	unsigned long flags;
 	struct batched_entropy *batch;
-	static void *previous;
 	unsigned long next_gen;
 
-	warn_unseeded_randomness(&previous);
+	warn_unseeded_randomness();
 
 	if  (!crng_ready()) {
 		_get_random_bytes(&ret, sizeof(ret));
@@ -592,10 +576,9 @@ u32 get_random_u32(void)
 	u32 ret;
 	unsigned long flags;
 	struct batched_entropy *batch;
-	static void *previous;
 	unsigned long next_gen;
 
-	warn_unseeded_randomness(&previous);
+	warn_unseeded_randomness();
 
 	if  (!crng_ready()) {
 		_get_random_bytes(&ret, sizeof(ret));
@@ -822,16 +805,9 @@ static void credit_init_bits(size_t nbits)
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
-		if (unseeded_warning.missed) {
-			pr_notice("%d get_random_xx warning(s) missed due to ratelimiting\n",
-				  unseeded_warning.missed);
-			unseeded_warning.missed = 0;
-		}
-		if (urandom_warning.missed) {
+		if (urandom_warning.missed)
 			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
 				  urandom_warning.missed);
-			urandom_warning.missed = 0;
-		}
 	} else if (orig < POOL_EARLY_BITS && new >= POOL_EARLY_BITS) {
 		spin_lock_irqsave(&base_crng.lock, flags);
 		/* Check if crng_init is CRNG_EMPTY, to avoid race with crng_reseed(). */
@@ -975,11 +951,6 @@ int __init rand_initialize(void)
 	else if (arch_init && trust_cpu)
 		credit_init_bits(BLAKE2S_BLOCK_SIZE * 8);
 
-	if (ratelimit_disable) {
-		urandom_warning.interval = 0;
-		unseeded_warning.interval = 0;
-	}
-
 	WARN_ON(register_pm_notifier(&pm_notifier));
 
 	WARN(!random_get_entropy(), "Missing cycle counter and fallback timer; RNG "
@@ -1471,11 +1442,14 @@ static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
 	if (!crng_ready())
 		try_to_generate_entropy();
 
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
+	if (!crng_ready()) {
+		if (!ratelimit_disable && maxwarn <= 0)
+			++urandom_warning.missed;
+		else if (ratelimit_disable || __ratelimit(&urandom_warning)) {
+			--maxwarn;
 			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
 				  current->comm, nbytes);
+		}
 	}
 
 	return get_random_bytes_user(buf, nbytes);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25363ac..7e282970177a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1616,8 +1616,7 @@ config WARN_ALL_UNSEEDED_RANDOM
 	  so architecture maintainers really need to do what they can
 	  to get the CRNG seeded sooner after the system is booted.
 	  However, since users cannot do anything actionable to
-	  address this, by default the kernel will issue only a single
-	  warning for the first use of unseeded randomness.
+	  address this, by default this option is disabled.
 
 	  Say Y here if you want to receive warnings for all uses of
 	  unseeded randomness.  This will be of use primarily for
-- 
2.35.1

