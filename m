Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFCA53AF35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiFAU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiFAU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:57:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3E217603;
        Wed,  1 Jun 2022 13:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F931B81C87;
        Wed,  1 Jun 2022 20:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA62C34119;
        Wed,  1 Jun 2022 20:57:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W1hGuE+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654117047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JHmJzQ6KWsGuyagW7BSdOmTThtw2XY0PLg0NtkYD4to=;
        b=W1hGuE+ZEiX+I+VOckbOPx01nOpIsJC8xb6ufXiukgi50fSqw+kcApWuA7APMd6+J7ipqP
        Ydzp+RjAaJF48I2koNRAmp5tzOiVHZsB+yvMxWP3c266F80jYw37VHbH0VpcC8UwqvksWS
        3HojZvTvf4weY3ZvHfTBupqE3Kz2+og=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 908c7efb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 1 Jun 2022 20:57:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        PaX Team <pageexec@freemail.hu>,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH] random: always mix cycle counter in add_latent_entropy()
Date:   Wed,  1 Jun 2022 22:56:24 +0200
Message-Id: <20220601205624.92387-1-Jason@zx2c4.com>
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

add_latent_entropy() is called every time a process forks, in
kernel_clone(). This in turn calls add_device_randomness() using the
latent entropy global state. add_device_randomness() does two things:

   2) Mixes into the input pool the latent entropy argument passed; and
   1) Mixes in a cycle counter, a sort of measurement of when the event
      took place, the high precision bits of which are presumably
      difficult to predict.

(2) is impossible without CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y. But (1) is
always possible. However, currently CONFIG_GCC_PLUGIN_LATENT_ENTROPY=n
disables both (1) and (2), instead of just (2).

This commit causes the CONFIG_GCC_PLUGIN_LATENT_ENTROPY=n case to still
do (1) by passing NULL (len 0) to add_device_randomness() when add_latent_
entropy() is called.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: PaX Team <pageexec@freemail.hu>
Cc: Emese Revfy <re.emese@gmail.com>
Fixes: 38addce8b600 ("gcc-plugins: Add latent_entropy plugin")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/random.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index fae0c84027fd..5880da3f5b5b 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -19,14 +19,14 @@ void add_input_randomness(unsigned int type, unsigned int code,
 void add_interrupt_randomness(int irq) __latent_entropy;
 void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy);
 
-#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
 {
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 	add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
-}
 #else
-static inline void add_latent_entropy(void) { }
+	add_device_randomness(NULL, 0);
 #endif
+}
 
 #if IS_ENABLED(CONFIG_VMGENID)
 void add_vmfork_randomness(const void *unique_vm_id, size_t len);
-- 
2.35.1

