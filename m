Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510D56CBA4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGIVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGIVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:55:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665F101FF;
        Sat,  9 Jul 2022 14:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60D87B802C7;
        Sat,  9 Jul 2022 21:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3642C3411E;
        Sat,  9 Jul 2022 21:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657403733;
        bh=9008jowds9L7U9KVfn40Q123s75iIQKdMgxUhQn0kvg=;
        h=From:To:Cc:Subject:Date:From;
        b=XjG8VbA4DHSD94ujgSK3w0ZSUaIgYQtgAFRjMC/IVieSzDMhl+rIL4gjl+DZ+7gug
         RCMyqXjHP/3o1XydcrQg4e4iaJGifGqUMES7clUIjPO6DfvYTXsSHo7/xNCfK8I39O
         wJQfCFe6s0s3AaLhP7yVLtiv+hsscb+l+UdYj2SDj7aRJFkyRVYp502CIMogUU6Kj0
         4QGIdkf0fRFowDkMcJxa1baBZvIgua7KSYdBig0W27SaT/71osIHdKDiy5L8E+MIsW
         2twQ63ZgHT0dzPyucy8cAQir2Za6gzr+0NtY2W6JGa40XjkV6OpA0D+iAl9e+sP2gf
         O46lOnn2knrQw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH] crypto: xor - move __crypto_xor into lib/
Date:   Sat,  9 Jul 2022 14:54:53 -0700
Message-Id: <20220709215453.262237-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

CRYPTO_LIB_CHACHA depends on CRYPTO for __crypto_xor, defined in
crypto/algapi.c.  This is a layering violation because the dependencies
should only go in the other direction (crypto/ => lib/crypto/).  Also
the correct dependency would be CRYPTO_ALGAPI, not CRYPTO.  Fix this by
moving __crypto_xor into lib/xor.c, alongside lib/memneq.c where
__crypto_memneq was recently moved.

Note that CRYPTO_LIB_CHACHA_GENERIC selected XOR_BLOCKS, which is
unrelated and unnecessary.  It was perhaps thought that XOR_BLOCKS was
needed for __crypto_xor, but that's not the case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig     |  1 +
 crypto/algapi.c    | 71 --------------------------------------
 lib/Kconfig        |  3 ++
 lib/Makefile       |  1 +
 lib/crypto/Kconfig |  3 +-
 lib/xor.c          | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 73 deletions(-)
 create mode 100644 lib/xor.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 59489a300cd100..9145fdfa8a5bbd 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -40,6 +40,7 @@ config CRYPTO_ALGAPI
 	  This option provides the API for cryptographic algorithms.
 
 config CRYPTO_ALGAPI2
+	select LIB_XOR
 	tristate
 
 config CRYPTO_AEAD
diff --git a/crypto/algapi.c b/crypto/algapi.c
index d1c99288af3e0d..5c69ff8e8fa5c1 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -997,77 +997,6 @@ void crypto_inc(u8 *a, unsigned int size)
 }
 EXPORT_SYMBOL_GPL(crypto_inc);
 
-void __crypto_xor(u8 *dst, const u8 *src1, const u8 *src2, unsigned int len)
-{
-	int relalign = 0;
-
-	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
-		int size = sizeof(unsigned long);
-		int d = (((unsigned long)dst ^ (unsigned long)src1) |
-			 ((unsigned long)dst ^ (unsigned long)src2)) &
-			(size - 1);
-
-		relalign = d ? 1 << __ffs(d) : size;
-
-		/*
-		 * If we care about alignment, process as many bytes as
-		 * needed to advance dst and src to values whose alignments
-		 * equal their relative alignment. This will allow us to
-		 * process the remainder of the input using optimal strides.
-		 */
-		while (((unsigned long)dst & (relalign - 1)) && len > 0) {
-			*dst++ = *src1++ ^ *src2++;
-			len--;
-		}
-	}
-
-	while (IS_ENABLED(CONFIG_64BIT) && len >= 8 && !(relalign & 7)) {
-		if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
-			u64 l = get_unaligned((u64 *)src1) ^
-				get_unaligned((u64 *)src2);
-			put_unaligned(l, (u64 *)dst);
-		} else {
-			*(u64 *)dst = *(u64 *)src1 ^ *(u64 *)src2;
-		}
-		dst += 8;
-		src1 += 8;
-		src2 += 8;
-		len -= 8;
-	}
-
-	while (len >= 4 && !(relalign & 3)) {
-		if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
-			u32 l = get_unaligned((u32 *)src1) ^
-				get_unaligned((u32 *)src2);
-			put_unaligned(l, (u32 *)dst);
-		} else {
-			*(u32 *)dst = *(u32 *)src1 ^ *(u32 *)src2;
-		}
-		dst += 4;
-		src1 += 4;
-		src2 += 4;
-		len -= 4;
-	}
-
-	while (len >= 2 && !(relalign & 1)) {
-		if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
-			u16 l = get_unaligned((u16 *)src1) ^
-				get_unaligned((u16 *)src2);
-			put_unaligned(l, (u16 *)dst);
-		} else {
-			*(u16 *)dst = *(u16 *)src1 ^ *(u16 *)src2;
-		}
-		dst += 2;
-		src1 += 2;
-		src2 += 2;
-		len -= 2;
-	}
-
-	while (len--)
-		*dst++ = *src1++ ^ *src2++;
-}
-EXPORT_SYMBOL_GPL(__crypto_xor);
-
 unsigned int crypto_alg_extsize(struct crypto_alg *alg)
 {
 	return alg->cra_ctxsize +
diff --git a/lib/Kconfig b/lib/Kconfig
index eaaad4d85bf24b..4d2b09487442ea 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -123,6 +123,9 @@ source "lib/crypto/Kconfig"
 config LIB_MEMNEQ
 	bool
 
+config LIB_XOR
+	bool
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc67..ceeb3f913f1b57 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -252,6 +252,7 @@ obj-$(CONFIG_SIGNATURE) += digsig.o
 
 lib-$(CONFIG_CLZ_TAB) += clz_tab.o
 lib-$(CONFIG_LIB_MEMNEQ) += memneq.o
+lib-$(CONFIG_LIB_XOR) += xor.o
 
 obj-$(CONFIG_GENERIC_STRNCPY_FROM_USER) += strncpy_from_user.o
 obj-$(CONFIG_GENERIC_STRNLEN_USER) += strnlen_user.o
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 2082af43d51fbe..8432e0e2a9ee0d 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -33,7 +33,7 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
-	select XOR_BLOCKS
+	select LIB_XOR
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  ChaCha library interface that require the generic code as a
@@ -43,7 +43,6 @@ config CRYPTO_LIB_CHACHA_GENERIC
 
 config CRYPTO_LIB_CHACHA
 	tristate "ChaCha library interface"
-	depends on CRYPTO
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
diff --git a/lib/xor.c b/lib/xor.c
new file mode 100644
index 00000000000000..5f8f7765a48d5f
--- /dev/null
+++ b/lib/xor.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The __crypto_xor library function
+ *
+ * Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
+ */
+
+#include <crypto/algapi.h>
+#include <asm/unaligned.h>
+
+/*
+ * XOR @len bytes from @src1 and @src2 together, writing the result to @dst
+ * (which may alias one of the sources).  Don't call this directly; call
+ * crypto_xor() or crypto_xor_cpy() instead.
+ */
+void __crypto_xor(u8 *dst, const u8 *src1, const u8 *src2, unsigned int len)
+{
+	int relalign = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+		int size = sizeof(unsigned long);
+		int d = (((unsigned long)dst ^ (unsigned long)src1) |
+			 ((unsigned long)dst ^ (unsigned long)src2)) &
+			(size - 1);
+
+		relalign = d ? 1 << __ffs(d) : size;
+
+		/*
+		 * If we care about alignment, process as many bytes as
+		 * needed to advance dst and src to values whose alignments
+		 * equal their relative alignment. This will allow us to
+		 * process the remainder of the input using optimal strides.
+		 */
+		while (((unsigned long)dst & (relalign - 1)) && len > 0) {
+			*dst++ = *src1++ ^ *src2++;
+			len--;
+		}
+	}
+
+	while (IS_ENABLED(CONFIG_64BIT) && len >= 8 && !(relalign & 7)) {
+		if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+			u64 l = get_unaligned((u64 *)src1) ^
+				get_unaligned((u64 *)src2);
+			put_unaligned(l, (u64 *)dst);
+		} else {
+			*(u64 *)dst = *(u64 *)src1 ^ *(u64 *)src2;
+		}
+		dst += 8;
+		src1 += 8;
+		src2 += 8;
+		len -= 8;
+	}
+
+	while (len >= 4 && !(relalign & 3)) {
+		if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+			u32 l = get_unaligned((u32 *)src1) ^
+				get_unaligned((u32 *)src2);
+			put_unaligned(l, (u32 *)dst);
+		} else {
+			*(u32 *)dst = *(u32 *)src1 ^ *(u32 *)src2;
+		}
+		dst += 4;
+		src1 += 4;
+		src2 += 4;
+		len -= 4;
+	}
+
+	while (len >= 2 && !(relalign & 1)) {
+		if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+			u16 l = get_unaligned((u16 *)src1) ^
+				get_unaligned((u16 *)src2);
+			put_unaligned(l, (u16 *)dst);
+		} else {
+			*(u16 *)dst = *(u16 *)src1 ^ *(u16 *)src2;
+		}
+		dst += 2;
+		src1 += 2;
+		src2 += 2;
+		len -= 2;
+	}
+
+	while (len--)
+		*dst++ = *src1++ ^ *src2++;
+}
+EXPORT_SYMBOL_GPL(__crypto_xor);

base-commit: 79e6e2f3f3ff345947075341781e900e4f70db81
-- 
2.37.0

