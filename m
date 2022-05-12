Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC29524D60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353935AbiELMsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353943AbiELMss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183E24D60A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D873361F8C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE96AC385B8;
        Thu, 12 May 2022 12:48:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DaXEsJsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652359723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fw6XqJOjx/gL+0IgPDG0uG9L5ijZCTo506iJQ00IxOk=;
        b=DaXEsJsEk+k02LLyni6k07+hHVt0HDDe67XEqRCf2JlnQQ7MHneRyxB46iU8nQ9t+URkSR
        AICihYfqgDujJYeTaNheDY/E0Bh+KISJw9ka94D6dAqTya8Px0YN4VKtRys+oqvcaF3Vrk
        Zwa4qKqstugQxRgxaK5HjAj9WG+SBAk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d102ee5a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 12:48:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: handle latent entropy and command line from random_init()
Date:   Thu, 12 May 2022 14:48:39 +0200
Message-Id: <20220512124839.20755-1-Jason@zx2c4.com>
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

Currently, start_kernel() adds latent entropy and the command line to
the entropy bool *after* the RNG has been initialized, deferring when
it's actually used by things like stack canaries until the next time
the pool is seeded. This surely is not intended.

Rather than splitting up which entropy gets added where and when between
start_kernel() and random_init(), just do everything in random_init(),
which should eliminate these kinds of bugs in the future.

While we're at it, rename the awkwardly titled "rand_initialize()" to
the more standard "random_init()" nomenclature.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 17 ++++++++++-------
 include/linux/random.h | 17 ++++++++---------
 init/main.c            |  8 ++------
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d4bc9beaed2c..bd80d74a7f8c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -926,12 +926,13 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
 
 /*
  * The first collection of entropy occurs at system boot while interrupts
- * are still turned off. Here we push in RDSEED, a timestamp, and utsname().
- * Depending on the above configuration knob, RDSEED may be considered
- * sufficient for initialization. Note that much earlier setup may already
- * have pushed entropy into the input pool by the time we get here.
+ * are still turned off. Here we push in latent entropy, RDSEED, a timestamp,
+ * utsname(), and the command line. Depending on the above configuration knob,
+ * RDSEED may be considered sufficient for initialization. Note that much
+ * earlier setup may already have pushed entropy into the input pool by the
+ * time we get here.
  */
-int __init rand_initialize(void)
+int __init random_init(const char *command_line)
 {
 	size_t i;
 	ktime_t now = ktime_get_real();
@@ -953,6 +954,8 @@ int __init rand_initialize(void)
 	}
 	_mix_pool_bytes(&now, sizeof(now));
 	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
+	_mix_pool_bytes(command_line, strlen(command_line));
+	add_latent_entropy();
 
 	if (crng_ready()) {
 		/*
@@ -1703,8 +1706,8 @@ static struct ctl_table random_table[] = {
 };
 
 /*
- * rand_initialize() is called before sysctl_init(),
- * so we cannot call register_sysctl_init() in rand_initialize()
+ * random_init() is called before sysctl_init(),
+ * so we cannot call register_sysctl_init() in random_init()
  */
 static int __init random_sysctls_init(void)
 {
diff --git a/include/linux/random.h b/include/linux/random.h
index f673fbb838b3..6eabea6697d0 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -14,22 +14,21 @@ struct notifier_block;
 
 extern void add_device_randomness(const void *, size_t);
 extern void add_bootloader_randomness(const void *, size_t);
+extern void add_input_randomness(unsigned int type, unsigned int code,
+				 unsigned int value) __latent_entropy;
+extern void add_interrupt_randomness(int irq) __latent_entropy;
+extern void add_hwgenerator_randomness(const void *buffer, size_t count,
+				       size_t entropy);
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
 {
-	add_device_randomness((const void *)&latent_entropy,
-			      sizeof(latent_entropy));
+	add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
 }
 #else
-static inline void add_latent_entropy(void) {}
+static inline void add_latent_entropy(void) { }
 #endif
 
-extern void add_input_randomness(unsigned int type, unsigned int code,
-				 unsigned int value) __latent_entropy;
-extern void add_interrupt_randomness(int irq) __latent_entropy;
-extern void add_hwgenerator_randomness(const void *buffer, size_t count,
-				       size_t entropy);
 #if IS_ENABLED(CONFIG_VMGENID)
 extern void add_vmfork_randomness(const void *unique_vm_id, size_t size);
 extern int register_random_vmfork_notifier(struct notifier_block *nb);
@@ -41,7 +40,7 @@ static inline int unregister_random_vmfork_notifier(struct notifier_block *nb) {
 
 extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);
-extern int __init rand_initialize(void);
+extern int __init random_init(const char *command_line);
 extern bool rng_is_initialized(void);
 extern int register_random_ready_notifier(struct notifier_block *nb);
 extern int unregister_random_ready_notifier(struct notifier_block *nb);
diff --git a/init/main.c b/init/main.c
index 92783732a36f..4aec8a69301c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1042,13 +1042,9 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
 	 * - timekeeping_init() for ktime entropy used in rand_initialize()
 	 * - time_init() for making random_get_entropy() work on some platforms
-	 * - rand_initialize() to get any arch-specific entropy like RDRAND
-	 * - add_latent_entropy() to get any latent entropy
-	 * - adding command line entropy
+	 * - random_init() to initialize the RNG from from early entropy sources
 	 */
-	rand_initialize();
-	add_latent_entropy();
-	add_device_randomness(command_line, strlen(command_line));
+	random_init(command_line);
 	boot_init_stack_canary();
 
 	perf_event_init();
-- 
2.35.1

