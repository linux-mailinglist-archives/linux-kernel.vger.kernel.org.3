Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C862576C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiGPGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiGPGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73F24946;
        Fri, 15 Jul 2022 23:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D3D60AE2;
        Sat, 16 Jul 2022 06:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B1C341C8;
        Sat, 16 Jul 2022 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657953022;
        bh=DqaxUjI45R0hybjBltoAUPS4GYNm3M6mVTgq2uVzsOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtLHp1tAEmh5Hw8hdbdcOap+kQRCNT3shd3V4K5Sf08P1wi7SVf9Y7aly0oiu+mTZ
         y/OzW01/0q2IguTyunWSlUw4ciHaBotkntSZfboWs2h8vWTqmnCRKz0DlvrSBuCiPy
         McT69MgyeRasL3dNrp09fWjySBVTHg5m4rxFyDjWoIl37iwrA6ozeOoM0ED8bQPmag
         7eiw1nlE62t4kMpMuIUq50Mo7xmgA90UsSbau6yScgi+rOxeA/obpiC2rbKQO7Lzdl
         KSpPe+RmaXrtzc1lSakS1a7RITOrp/pWdnbX+IqHBoipkAknkOBv02QEFPJf32pG1F
         oVGAYzbLLSgqQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v2 3/3] crypto: lib - move crypto_simd_disabled_for_test into utils
Date:   Fri, 15 Jul 2022 23:29:20 -0700
Message-Id: <20220716062920.210381-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220716062920.210381-1-ebiggers@kernel.org>
References: <20220716062920.210381-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Move the definition of crypto_simd_disabled_for_test into
lib/crypto/utils.c so that it can be accessed by library code.

This is needed when code that is shared between a traditional crypto API
implementation and a library implementation is built-in, but
CRYPTO_ALGAPI=m.  The x86 blake2s previously was an example of this
(https://lore.kernel.org/linux-crypto/20220517033630.1182-1-gaochao49@huawei.com/T/#u).
Although that case was resolved by removing the blake2s shash support,
this problem could easily come back in the future, so let's address it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/algapi.c    | 6 ------
 lib/crypto/utils.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 5c69ff8e8fa5c1..9377dae75b3def 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -6,7 +6,6 @@
  */
 
 #include <crypto/algapi.h>
-#include <crypto/internal/simd.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fips.h>
@@ -22,11 +21,6 @@
 
 static LIST_HEAD(crypto_template_list);
 
-#ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
-DEFINE_PER_CPU(bool, crypto_simd_disabled_for_test);
-EXPORT_PER_CPU_SYMBOL_GPL(crypto_simd_disabled_for_test);
-#endif
-
 static inline void crypto_check_module_sig(struct module *mod)
 {
 	if (fips_enabled && mod && !module_sig_ok(mod))
diff --git a/lib/crypto/utils.c b/lib/crypto/utils.c
index f20bdb2ae88771..e7d99f150d4e61 100644
--- a/lib/crypto/utils.c
+++ b/lib/crypto/utils.c
@@ -6,8 +6,14 @@
  */
 
 #include <crypto/algapi.h>
+#include <crypto/internal/simd.h>
 #include <asm/unaligned.h>
 
+#ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
+DEFINE_PER_CPU(bool, crypto_simd_disabled_for_test);
+EXPORT_PER_CPU_SYMBOL_GPL(crypto_simd_disabled_for_test);
+#endif
+
 /*
  * XOR @len bytes from @src1 and @src2 together, writing the result to @dst
  * (which may alias one of the sources).  Don't call this directly; call
-- 
2.37.0

