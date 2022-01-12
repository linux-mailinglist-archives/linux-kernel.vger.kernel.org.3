Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6946248C699
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiALO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:58:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54390 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354363AbiALO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:58:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9969B81F66;
        Wed, 12 Jan 2022 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EC5C36AE5;
        Wed, 12 Jan 2022 14:58:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lDmQMrtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641999489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6xdXfbjX4p4PFWNqT3e9bw0113nGRXEFRBnzlw2H9c=;
        b=lDmQMrtSZVZLs67HkCMB2Hy664p6YC8OWyX7BuHgA1R78Fijo1y/Yra2U7gPbBXC7EwXQN
        EoLtN/mfOHFZAXWw/HB14BvuiR2nouCnks+0HkpfW9Q6APxvYaf2vEQNVKk8YvbwChRbBS
        x7pincWXHyElFsJWWIsnUwSjfVzoGXA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 069cbd44 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:58:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH v3] lib/crypto: add prompts back to crypto libraries
Date:   Wed, 12 Jan 2022 15:57:58 +0100
Message-Id: <20220112145758.926796-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9oxy-P8hq=85hOGSOena3kxpTAOHoXto7s4tnDUkXvYPg@mail.gmail.com>
References: <CAHmME9oxy-P8hq=85hOGSOena3kxpTAOHoXto7s4tnDUkXvYPg@mail.gmail.com>
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
[Jason: moved menu into submenu of lib/ instead of root menu]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 crypto/Kconfig     |  2 --
 lib/Kconfig        |  2 ++
 lib/crypto/Kconfig | 12 ++++++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

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
index 8620f38e117c..179041b60294 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+menu "Crypto library routines"
+
 config CRYPTO_LIB_AES
 	tristate
 
@@ -40,7 +42,7 @@ config CRYPTO_LIB_CHACHA_GENERIC
 	  of CRYPTO_LIB_CHACHA.
 
 config CRYPTO_LIB_CHACHA
-	tristate
+	tristate "ChaCha library interface"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
@@ -65,7 +67,7 @@ config CRYPTO_LIB_CURVE25519_GENERIC
 	  of CRYPTO_LIB_CURVE25519.
 
 config CRYPTO_LIB_CURVE25519
-	tristate
+	tristate "Curve25519 scalar multiplication library"
 	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
 	help
@@ -100,7 +102,7 @@ config CRYPTO_LIB_POLY1305_GENERIC
 	  of CRYPTO_LIB_POLY1305.
 
 config CRYPTO_LIB_POLY1305
-	tristate
+	tristate "Poly1305 library interface"
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
 	help
@@ -109,7 +111,7 @@ config CRYPTO_LIB_POLY1305
 	  is available and enabled.
 
 config CRYPTO_LIB_CHACHA20POLY1305
-	tristate
+	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_CHACHA
@@ -120,3 +122,5 @@ config CRYPTO_LIB_SHA256
 
 config CRYPTO_LIB_SM4
 	tristate
+
+endmenu
-- 
2.34.1

