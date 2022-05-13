Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA0525FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379500AbiEMKex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353075AbiEMKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D81A8E36
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EB44B82D85
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2242C34113;
        Fri, 13 May 2022 10:34:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SHfLWqFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652438084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MW1/Zwe/AEDOb/zVT6YrkuMz2dXGbAPfGolHwvfXlk0=;
        b=SHfLWqFO1wSLwNWvDJdrvhd6WPqG78Yl/7eBh7VZby4PiOBNArzWHh2I+X4gnSB72a+FFx
        91zeEh4v+zl+9M9TsMXLN0+oic+zjX7W34VNYVJSFoJHeEVGwJM6oMYzRr8ybPwr0Wajh0
        WNm4iPS11Ub/4k13CQXBtog0PFx4l/Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27a31e01 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:34:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux@dominikbrodowski.net, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/2] random: remove extern from functions in header
Date:   Fri, 13 May 2022 12:34:33 +0200
Message-Id: <20220513103434.287137-1-Jason@zx2c4.com>
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

Accoriding to the kernel style guide, having `extern` on functions in
headers is old school and deprecated, and doesn't add anything. So remove
them from random.h, and tidy up the file a little bit too.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/random.h | 77 +++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index b52963955a99..97f879ea78a5 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -12,13 +12,12 @@
 
 struct notifier_block;
 
-extern void add_device_randomness(const void *, size_t);
-extern void add_bootloader_randomness(const void *, size_t);
-extern void add_input_randomness(unsigned int type, unsigned int code,
-				 unsigned int value) __latent_entropy;
-extern void add_interrupt_randomness(int irq) __latent_entropy;
-extern void add_hwgenerator_randomness(const void *buffer, size_t count,
-				       size_t entropy);
+void add_device_randomness(const void *, size_t);
+void add_bootloader_randomness(const void *, size_t);
+void add_input_randomness(unsigned int type, unsigned int code,
+			  unsigned int value) __latent_entropy;
+void add_interrupt_randomness(int irq) __latent_entropy;
+void add_hwgenerator_randomness(const void *buffer, size_t count, size_t entropy);
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
@@ -26,30 +25,20 @@ static inline void add_latent_entropy(void)
 	add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
 }
 #else
-static inline void add_latent_entropy(void) {}
+static inline void add_latent_entropy(void) { }
 #endif
 
 #if IS_ENABLED(CONFIG_VMGENID)
-extern void add_vmfork_randomness(const void *unique_vm_id, size_t size);
-extern int register_random_vmfork_notifier(struct notifier_block *nb);
-extern int unregister_random_vmfork_notifier(struct notifier_block *nb);
+void add_vmfork_randomness(const void *unique_vm_id, size_t size);
+int register_random_vmfork_notifier(struct notifier_block *nb);
+int unregister_random_vmfork_notifier(struct notifier_block *nb);
 #else
 static inline int register_random_vmfork_notifier(struct notifier_block *nb) { return 0; }
 static inline int unregister_random_vmfork_notifier(struct notifier_block *nb) { return 0; }
 #endif
 
-extern void get_random_bytes(void *buf, size_t nbytes);
-extern int wait_for_random_bytes(void);
-extern int __init random_init(const char *command_line);
-extern bool rng_is_initialized(void);
-extern int register_random_ready_notifier(struct notifier_block *nb);
-extern int unregister_random_ready_notifier(struct notifier_block *nb);
-extern size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes);
-
-#ifndef MODULE
-extern const struct file_operations random_fops, urandom_fops;
-#endif
-
+void get_random_bytes(void *buf, size_t nbytes);
+size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes);
 u32 get_random_u32(void);
 u64 get_random_u64(void);
 static inline unsigned int get_random_int(void)
@@ -81,11 +70,17 @@ static inline unsigned long get_random_long(void)
 
 static inline unsigned long get_random_canary(void)
 {
-	unsigned long val = get_random_long();
-
-	return val & CANARY_MASK;
+	return get_random_long() & CANARY_MASK;
 }
 
+unsigned long randomize_page(unsigned long start, unsigned long range);
+
+int __init random_init(const char *command_line);
+bool rng_is_initialized(void);
+int wait_for_random_bytes(void);
+int register_random_ready_notifier(struct notifier_block *nb);
+int unregister_random_ready_notifier(struct notifier_block *nb);
+
 /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
  * Returns the result of the call to wait_for_random_bytes. */
 static inline int get_random_bytes_wait(void *buf, size_t nbytes)
@@ -109,8 +104,6 @@ declare_get_random_var_wait(int)
 declare_get_random_var_wait(long)
 #undef declare_get_random_var
 
-unsigned long randomize_page(unsigned long start, unsigned long range);
-
 /*
  * This is designed to be standalone for just prandom
  * users, but for now we include it from <linux/random.h>
@@ -121,22 +114,10 @@ unsigned long randomize_page(unsigned long start, unsigned long range);
 #ifdef CONFIG_ARCH_RANDOM
 # include <asm/archrandom.h>
 #else
-static inline bool __must_check arch_get_random_long(unsigned long *v)
-{
-	return false;
-}
-static inline bool __must_check arch_get_random_int(unsigned int *v)
-{
-	return false;
-}
-static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
-{
-	return false;
-}
-static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
-{
-	return false;
-}
+static inline bool __must_check arch_get_random_long(unsigned long *v) { return false; }
+static inline bool __must_check arch_get_random_int(unsigned int *v) { return false; }
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v) { return false; }
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v) { return false; }
 #endif
 
 /*
@@ -160,8 +141,12 @@ static inline bool __init arch_get_random_long_early(unsigned long *v)
 #endif
 
 #ifdef CONFIG_SMP
-extern int random_prepare_cpu(unsigned int cpu);
-extern int random_online_cpu(unsigned int cpu);
+int random_prepare_cpu(unsigned int cpu);
+int random_online_cpu(unsigned int cpu);
+#endif
+
+#ifndef MODULE
+extern const struct file_operations random_fops, urandom_fops;
 #endif
 
 #endif /* _LINUX_RANDOM_H */
-- 
2.35.1

