Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1202348FE13
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiAPQ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:58:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39886 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiAPQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:58:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56168B80D91;
        Sun, 16 Jan 2022 16:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04CC36AE7;
        Sun, 16 Jan 2022 16:58:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E8hnfPm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642352326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LTQ7KGSpvvf2nHzefrXTHTtHeNlE7E15K8R89MR4QY=;
        b=E8hnfPm5vMTeWX0zptSlwz7jL7zI/Xhg8Ba+Kgih8MtPCu3nu09QOmLjEDKakaiRcUuyfP
        9OLUcW/gqB3gbm+PIuNaHXPwbhJ+qivICxZ8zBc60BYsQq1lnb2EGLPrzEjroltS/beb9M
        OM+gSffulvaeHqodf0U0GQoNua8wQ0k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b816847a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 16 Jan 2022 16:58:46 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH v4] lib/crypto: add prompts back to crypto libraries
Date:   Sun, 16 Jan 2022 17:58:41 +0100
Message-Id: <20220116165841.254196-1-Jason@zx2c4.com>
In-Reply-To: <20220112145758.926796-1-Jason@zx2c4.com>
References: <20220112145758.926796-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Justin M. Forbes" <jforbes@fedoraproject.org>

Commit 6048fdcc5f269 ("lib/crypto: blake2s: include as built-in") took
away a number of prompt texts from other crypto libraries. This makes
values flip from built-in to module when oldconfig runs, and causes
problems when these crypto libs need to be built in for thingslike
BIG_KEYS.

Fixes: 6048fdcc5f269 ("lib/crypto: blake2s: include as built-in")
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
[Jason: - moved menu into submenu of lib/ instead of root menu
        - fixed chacha sub-dependencies for CONFIG_CRYPTO]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 crypto/Kconfig     |  2 --
 lib/Kconfig        |  2 ++
 lib/crypto/Kconfig | 17 ++++++++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 55718de56137..a346b6f74bb3 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1924,5 +1924,3 @@ source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
 
 endif	# if CRYPTO
-
-source "lib/crypto/Kconfig"
diff --git a/lib/Kconfig b/lib/Kconfig
index 5e7165e6a346..9534698ce890 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -122,6 +122,8 @@ config INDIRECT_IOMEM_FALLBACK
 	  mmio accesses when the IO memory address is not a registered
 	  emulated region.
 
+source "lib/crypto/Kconfig"
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 8620f38e117c..e8e525650cf2 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+menu "Crypto library routines"
+
 config CRYPTO_LIB_AES
 	tristate
 
@@ -31,7 +33,7 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
-	select CRYPTO_ALGAPI
+	select XOR_BLOCKS
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  ChaCha library interface that require the generic code as a
@@ -40,7 +42,8 @@ config CRYPTO_LIB_CHACHA_GENERIC
 	  of CRYPTO_LIB_CHACHA.
 
 config CRYPTO_LIB_CHACHA
-	tristate
+	tristate "ChaCha library interface"
+	depends on CRYPTO
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
@@ -65,7 +68,7 @@ config CRYPTO_LIB_CURVE25519_GENERIC
 	  of CRYPTO_LIB_CURVE25519.
 
 config CRYPTO_LIB_CURVE25519
-	tristate
+	tristate "Curve25519 scalar multiplication library"
 	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
 	help
@@ -100,7 +103,7 @@ config CRYPTO_LIB_POLY1305_GENERIC
 	  of CRYPTO_LIB_POLY1305.
 
 config CRYPTO_LIB_POLY1305
-	tristate
+	tristate "Poly1305 library interface"
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
 	help
@@ -109,14 +112,18 @@ config CRYPTO_LIB_POLY1305
 	  is available and enabled.
 
 config CRYPTO_LIB_CHACHA20POLY1305
-	tristate
+	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
+	depends on CRYPTO
 	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_POLY1305
+	select CRYPTO_ALGAPI
 
 config CRYPTO_LIB_SHA256
 	tristate
 
 config CRYPTO_LIB_SM4
 	tristate
+
+endmenu
-- 
2.34.1

