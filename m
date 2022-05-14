Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32BD5270D1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiENLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiENLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6213DF8;
        Sat, 14 May 2022 04:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3098860E2C;
        Sat, 14 May 2022 11:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA457C340EE;
        Sat, 14 May 2022 11:23:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MMe4cOCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652527401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ecVAIwVulA7M2aIRiaO1pV/pAhStFwyDStWEp6VmQPo=;
        b=MMe4cOCYTC/ai7RGvl/ktztnTJfbpJ9iSFoiX6QtEGRGuP18JwPY93vuK7oc5D6HJzrIdT
        ijN1ADlLdTiqil9FZSynu/dB5zGzfLhx/a/FhBhoBVdwkpwL6juRiI84TYXb9k3QcC4TGF
        UKLgQF669r1VdnDK6WnepQ9EKR4T0mQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76eb2981 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 14 May 2022 11:23:21 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] random: remove get_random_bytes_arch() and add rng_has_arch_random()
Date:   Sat, 14 May 2022 13:23:07 +0200
Message-Id: <20220514112307.349599-1-Jason@zx2c4.com>
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

The RNG incorporates RDRAND into its state at boot and every time it
reseeds, so there's no reason for callers to use it directly. The
hashing that the RNG does on it is preferable to using the bytes raw.

The only current use case of it is vsprintf's siphash key for pointer
hashing, which uses it to initialize the pointer secret earlier than
usual if RDRAND is available. In order to replace this narrow use case,
just expose whether RDRAND is available. With that taken care of, there
are no users of get_random_bytes_arch() left, so the function can be
removed.

Later if trust_cpu gets turned on by default (as most distros are
doing), this one use of rng_has_arch_random() can probably go away as
well.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 48 +++++++++++++-----------------------------
 include/linux/random.h |  2 +-
 lib/vsprintf.c         |  7 +++---
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0673250d6489..6d8ccb200c5c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -433,12 +433,9 @@ static void _get_random_bytes(void *buf, size_t len)
 /*
  * This function is the exported kernel interface.  It returns some
  * number of good random numbers, suitable for key generation, seeding
- * TCP sequence numbers, etc.  It does not rely on the hardware random
- * number generator.  For random bytes direct from the hardware RNG
- * (when available), use get_random_bytes_arch(). In order to ensure
- * that the randomness provided by this function is okay, the function
- * wait_for_random_bytes() should be called and return 0 at least once
- * at any point prior.
+ * TCP sequence numbers, etc. In order to ensure that the randomness
+ * by this function is okay, the function wait_for_random_bytes()
+ * should be called and return 0 at least once at any point prior.
  */
 void get_random_bytes(void *buf, size_t len)
 {
@@ -655,33 +652,6 @@ unsigned long randomize_page(unsigned long start, unsigned long range)
 	return start + (get_random_long() % range << PAGE_SHIFT);
 }
 
-/*
- * This function will use the architecture-specific hardware random
- * number generator if it is available. It is not recommended for
- * use. Use get_random_bytes() instead. It returns the number of
- * bytes filled in.
- */
-size_t __must_check get_random_bytes_arch(void *buf, size_t len)
-{
-	size_t left = len;
-	u8 *p = buf;
-
-	while (left) {
-		unsigned long v;
-		size_t block_len = min_t(size_t, left, sizeof(unsigned long));
-
-		if (!arch_get_random_long(&v))
-			break;
-
-		memcpy(p, &v, block_len);
-		p += block_len;
-		left -= block_len;
-	}
-
-	return len - left;
-}
-EXPORT_SYMBOL(get_random_bytes_arch);
-
 
 /**********************************************************************
  *
@@ -919,6 +889,8 @@ static int random_pm_notification(struct notifier_block *nb, unsigned long actio
 
 static struct notifier_block pm_notifier = { .notifier_call = random_pm_notification };
 
+static bool used_arch_random;
+
 /*
  * The first collection of entropy occurs at system boot while interrupts
  * are still turned off. Here we push in latent entropy, RDSEED, a timestamp,
@@ -956,6 +928,7 @@ int __init random_init(const char *command_line)
 		crng_reseed();
 	else if (trust_cpu)
 		credit_init_bits(arch_bytes * 8);
+	used_arch_random = arch_bytes * 8 >= POOL_READY_BITS;
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
 
@@ -964,6 +937,15 @@ int __init random_init(const char *command_line)
 	return 0;
 }
 
+/*
+ * Returns whether arch randomness has been mixed into the
+ * initial state of the RNG.
+ */
+bool rng_has_arch_random(void)
+{
+	return used_arch_random;
+}
+
 /*
  * Add device- or boot-specific data to the input pool to help
  * initialize it.
diff --git a/include/linux/random.h b/include/linux/random.h
index fc82f1dc36f1..6af130c6edb9 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -38,7 +38,6 @@ static inline int unregister_random_vmfork_notifier(struct notifier_block *nb) {
 #endif
 
 void get_random_bytes(void *buf, size_t len);
-size_t __must_check get_random_bytes_arch(void *buf, size_t len);
 u32 get_random_u32(void);
 u64 get_random_u64(void);
 static inline unsigned int get_random_int(void)
@@ -77,6 +76,7 @@ unsigned long randomize_page(unsigned long start, unsigned long range);
 
 int __init random_init(const char *command_line);
 bool rng_is_initialized(void);
+bool rng_has_arch_random(void);
 int wait_for_random_bytes(void);
 int register_random_ready_notifier(struct notifier_block *nb);
 int unregister_random_ready_notifier(struct notifier_block *nb);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40d26a07a133..20e9887faaaa 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -776,12 +776,11 @@ static struct notifier_block random_ready = {
 
 static int __init initialize_ptr_random(void)
 {
-	int key_size = sizeof(ptr_key);
 	int ret;
 
-	/* Use hw RNG if available. */
-	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
-		static_branch_disable(&not_filled_random_ptr_key);
+	/* Don't bother waiting for RNG to be ready if RDRAND is mixed in already. */
+	if (rng_has_arch_random()) {
+		enable_ptr_key_workfn(&enable_ptr_key_work);
 		return 0;
 	}
 
-- 
2.35.1

