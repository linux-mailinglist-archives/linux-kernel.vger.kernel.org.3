Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23A580418
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiGYShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiGYSgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:36:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCF1275A;
        Mon, 25 Jul 2022 11:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2785CE13B5;
        Mon, 25 Jul 2022 18:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C24C341C8;
        Mon, 25 Jul 2022 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658774209;
        bh=woYVIEWGYvf6j+v2IaoCj1jL+lqsBN5fv0iS4lSB0KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khGlJfutfJp8pfvEYcDLhlTXTvS5KYRX4sfXCDd2llmGB+Wv1fjUicwQPWac2Je5l
         nN3gOQ2pU8h3pPOw2lgwf1PdGWQgS6R5ngkrF5C6/vlXH2CFP1SzFNdIc62NDnNolc
         rRjmJvK0FbA/1OJpbjVTG4LAQGAlXVfuvmr46l6wzlNqUwBkp5X9RTHKJRNMix4EU7
         AMHHn7t3iwF/jTlfl8iRQtK80/npJmGU3Yk/lz4ysKJxgriWZY3znI7Bv4YP7/64il
         wMfUG8TIAGl09HWxG9RPIxt9z4+y0STSvmvSE90CpeWoeX8JufVm9e8rc1B09LI7CQ
         9Vjwr8YsuJfVg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v3 1/3] crypto: lib - create utils module and move __crypto_memneq into it
Date:   Mon, 25 Jul 2022 11:36:34 -0700
Message-Id: <20220725183636.97326-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220725183636.97326-1-ebiggers@kernel.org>
References: <20220725183636.97326-1-ebiggers@kernel.org>
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
 lib/{ => crypto}/memneq.c | 5 ++++-
 6 files changed, 12 insertions(+), 7 deletions(-)
 rename lib/{ => crypto}/memneq.c (99%)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e72bf3fc298cc5..7a10441998209d 100644
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
similarity index 99%
rename from lib/memneq.c
rename to lib/crypto/memneq.c
index fb11608b1ec1dd..f2098318428478 100644
--- a/lib/memneq.c
+++ b/lib/crypto/memneq.c
@@ -59,8 +59,9 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <crypto/algapi.h>
 #include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <linux/module.h>
 
 #ifndef __HAVE_ARCH_CRYPTO_MEMNEQ
 
@@ -174,3 +175,5 @@ noinline unsigned long __crypto_memneq(const void *a, const void *b,
 EXPORT_SYMBOL(__crypto_memneq);
 
 #endif /* __HAVE_ARCH_CRYPTO_MEMNEQ */
+
+MODULE_LICENSE("GPL");
-- 
2.37.0

