Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C46576C33
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGPGbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiGPGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:30:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3626544;
        Fri, 15 Jul 2022 23:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EDF6B80E7B;
        Sat, 16 Jul 2022 06:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A91C34115;
        Sat, 16 Jul 2022 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657953022;
        bh=MtlQhpJTNBl8ffhTMBGZWHNFb/UYlLAA0kb5Zw8hg5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKgq0Z9DEyyvvsXR+WHCALALVe3yCYlpbjI92+wcymgW3BpyQ6kGEs5r08y97wuWD
         71WHRMUMUirfre8QcOdY082fWMICGAU03Op3dW07TCsR4yjAnZSIJ7tibQdXKynupJ
         IfaX5cQ8dpT6w2ijcvY06QgId76RNzAVIlnCDn2wcK4qNEuHdA96VTyl7vwN76rQAg
         mnszGJk1RcLsSHiAQmumpTmGRTBinsVIgbf7q7KDNj0/5U5duN8cTijX6SJHqsKoft
         DtDj5bEAKytZvRAgRd9WNlePupTSJG8IE/YrwtzpR3zsutOThBPsaSC5SqG7cs8mUh
         g1pxZnqo4nhew==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v2 1/3] crypto: lib - create utils module and move __crypto_memneq into it
Date:   Fri, 15 Jul 2022 23:29:18 -0700
Message-Id: <20220716062920.210381-2-ebiggers@kernel.org>
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

As requested at
https://lore.kernel.org/r/YtEgzHuuMts0YBCz@gondor.apana.org.au, move
__crypto_memneq into lib/crypto/ and put it under a new tristate.  The
tristate is CRYPTO_LIB_UTILS, and it builds a module libcryptoutils.  As
more crypto library utilities are being added, this creates a single
place for them to go without cluttering up the main lib directory.

The module's main file will be lib/crypto/utils.c.  However, leave
memneq.c as its own file because of its nonstandard license.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig            | 2 +-
 lib/Kconfig               | 3 ---
 lib/Makefile              | 1 -
 lib/crypto/Kconfig        | 5 ++++-
 lib/crypto/Makefile       | 3 +++
 lib/{ => crypto}/memneq.c | 0
 6 files changed, 8 insertions(+), 6 deletions(-)
 rename lib/{ => crypto}/memneq.c (100%)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 75c71d9a5ffb7e..dc7c33f4ee6d55 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -15,7 +15,7 @@ source "crypto/async_tx/Kconfig"
 #
 menuconfig CRYPTO
 	tristate "Cryptographic API"
-	select LIB_MEMNEQ
+	select CRYPTO_LIB_UTILS
 	help
 	  This option provides the core Cryptographic API.
 
diff --git a/lib/Kconfig b/lib/Kconfig
index eaaad4d85bf24b..6a843639814fbf 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -120,9 +120,6 @@ config INDIRECT_IOMEM_FALLBACK
 
 source "lib/crypto/Kconfig"
 
-config LIB_MEMNEQ
-	bool
-
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 67482f5ec0e899..0557be76c2565f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -251,7 +251,6 @@ obj-$(CONFIG_DIMLIB) += dim/
 obj-$(CONFIG_SIGNATURE) += digsig.o
 
 lib-$(CONFIG_CLZ_TAB) += clz_tab.o
-lib-$(CONFIG_LIB_MEMNEQ) += memneq.o
 
 obj-$(CONFIG_GENERIC_STRNCPY_FROM_USER) += strncpy_from_user.o
 obj-$(CONFIG_GENERIC_STRNLEN_USER) += strnlen_user.o
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 9ff549f63540fa..b09d9d6546cbc3 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -2,6 +2,9 @@
 
 menu "Crypto library routines"
 
+config CRYPTO_LIB_UTILS
+	tristate
+
 config CRYPTO_LIB_AES
 	tristate
 
@@ -71,7 +74,7 @@ config CRYPTO_LIB_CURVE25519
 	tristate "Curve25519 scalar multiplication library"
 	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
-	select LIB_MEMNEQ
+	select CRYPTO_LIB_UTILS
 	help
 	  Enable the Curve25519 library interface. This interface may be
 	  fulfilled by either the generic implementation or an arch-specific
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 919cbb2c220d61..b956b3bae26aaf 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_CRYPTO_LIB_UTILS)			+= libcryptoutils.o
+libcryptoutils-y				:= memneq.o
+
 # chacha is used by the /dev/random driver which is always builtin
 obj-y						+= chacha.o
 obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)		+= libchacha.o
diff --git a/lib/memneq.c b/lib/crypto/memneq.c
similarity index 100%
rename from lib/memneq.c
rename to lib/crypto/memneq.c
-- 
2.37.0

