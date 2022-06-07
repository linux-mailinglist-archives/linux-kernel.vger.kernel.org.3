Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE4540218
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbiFGPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiFGPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877B5FF8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72BA1B820C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AD9C34114
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:06:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JROZQWXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654614395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fjCvRmPQauzz9VNVCTBL4SHcP+/PlJQGd/xp/FJiu8s=;
        b=JROZQWXhTlAg1alumgxtWS6K0iyZfPj7lC6R2HryTKcQdNoZoMPHwAEc3Z8Qet7pqFUEdC
        RiQM8uWIx1TB3O9C9oaxjs0xjBI8o+EuKZF4K5VKxW1ALVWjb2fBt68aU5sG1R/2s+yShK
        VThDHu02m7Ad292PoRQzznOvI8vbfOg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f228b628 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 15:06:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: mark bootloader randomness code as __init
Date:   Tue,  7 Jun 2022 17:06:30 +0200
Message-Id: <20220607150630.880791-1-Jason@zx2c4.com>
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

add_bootloader_randomness() and the variables it touches are only used
during __init and not after, so mark these as __init. At the same time,
unexport this, since it's only called by other __init code that's
built-in.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 7 +++----
 include/linux/random.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4862d4d3ec49..0d6fb3eaf609 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -725,8 +725,8 @@ static void __cold _credit_init_bits(size_t bits)
  **********************************************************************/
 
 static bool used_arch_random;
-static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
-static bool trust_bootloader __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
+static bool trust_cpu __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static bool trust_bootloader __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
 static int __init parse_trust_cpu(char *arg)
 {
 	return kstrtobool(arg, &trust_cpu);
@@ -865,13 +865,12 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
  * Handle random seed passed by bootloader, and credit it if
  * CONFIG_RANDOM_TRUST_BOOTLOADER is set.
  */
-void __cold add_bootloader_randomness(const void *buf, size_t len)
+void __init add_bootloader_randomness(const void *buf, size_t len)
 {
 	mix_pool_bytes(buf, len);
 	if (trust_bootloader)
 		credit_init_bits(len * 8);
 }
-EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 #if IS_ENABLED(CONFIG_VMGENID)
 static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
diff --git a/include/linux/random.h b/include/linux/random.h
index fae0c84027fd..223b4bd584e7 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -13,7 +13,7 @@
 struct notifier_block;
 
 void add_device_randomness(const void *buf, size_t len);
-void add_bootloader_randomness(const void *buf, size_t len);
+void __init add_bootloader_randomness(const void *buf, size_t len);
 void add_input_randomness(unsigned int type, unsigned int code,
 			  unsigned int value) __latent_entropy;
 void add_interrupt_randomness(int irq) __latent_entropy;
-- 
2.35.1

