Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34372542B40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiFHJTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiFHJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D3A0074
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D2BACE250D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376EBC34116;
        Wed,  8 Jun 2022 08:35:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d9lj/wYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654677304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ofgusW27VggH4uiJl3Gg2L/giOeLs4fXxTL2Qus/Oc=;
        b=d9lj/wYkzfhdGk0IKLmgHw++MxYOZUPluy+BCcMf0a0TIFcpGg7d9he7f8qgXfQT663zAb
        3v2lVGXgVaCKiUJbX4hhClEYfnxb7FUEc/kyHk0BdKPSz67hDNMlgFoCZp4snnY0jcyZvj
        RBsflOgK+DdM/DxkHtXx9y5Ve4vEiBw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ea47ab3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 8 Jun 2022 08:35:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] random: remove rng_has_arch_random()
Date:   Wed,  8 Jun 2022 10:34:59 +0200
Message-Id: <20220608083459.1179854-1-Jason@zx2c4.com>
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

With arch randomness being used by every distro and enabled in
defconfigs, the distinction between rng_has_arch_random() and
rng_is_initialized() is now rather small. In fact, the places where they
differ are now places where paranoid users and system builders really
don't want arch randomness to be used, in which case we should respect
that choice, or places where arch randomness is known to be broken, in
which case that choice is all the more important. So this commit just
removes the function and its one user.

Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 13 -------------
 include/linux/random.h |  1 -
 lib/vsprintf.c         |  3 +--
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0b78b9c4acf5..655e327d425e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -725,7 +725,6 @@ static void __cold _credit_init_bits(size_t bits)
  *
  **********************************************************************/
 
-static bool used_arch_random;
 static bool trust_cpu __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
 static bool trust_bootloader __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
 static int __init parse_trust_cpu(char *arg)
@@ -811,7 +810,6 @@ int __init random_init(const char *command_line)
 		crng_reseed();
 	else if (trust_cpu)
 		_credit_init_bits(arch_bits);
-	used_arch_random = arch_bits >= POOL_READY_BITS;
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
 
@@ -820,17 +818,6 @@ int __init random_init(const char *command_line)
 	return 0;
 }
 
-/*
- * Returns whether arch randomness has been mixed into the initial
- * state of the RNG, regardless of whether or not that randomness
- * was credited. Knowing this is only good for a very limited set
- * of uses, such as early init printk pointer obfuscation.
- */
-bool rng_has_arch_random(void)
-{
-	return used_arch_random;
-}
-
 /*
  * Add device- or boot-specific data to the input pool to help
  * initialize it.
diff --git a/include/linux/random.h b/include/linux/random.h
index 223b4bd584e7..20e389a14e5c 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -74,7 +74,6 @@ static inline unsigned long get_random_canary(void)
 
 int __init random_init(const char *command_line);
 bool rng_is_initialized(void);
-bool rng_has_arch_random(void);
 int wait_for_random_bytes(void);
 
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index fb77f7bfd126..3c1853a9d1c0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -769,8 +769,7 @@ static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
 		unsigned long flags;
 
-		if (!system_unbound_wq ||
-		    (!rng_is_initialized() && !rng_has_arch_random()) ||
+		if (!system_unbound_wq || !rng_is_initialized() ||
 		    !spin_trylock_irqsave(&filling, flags))
 			return -EAGAIN;
 
-- 
2.35.1

