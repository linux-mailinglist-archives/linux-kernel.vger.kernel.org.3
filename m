Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81BC580417
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiGYSg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiGYSgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD21275A;
        Mon, 25 Jul 2022 11:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A2760B08;
        Mon, 25 Jul 2022 18:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB9C341CE;
        Mon, 25 Jul 2022 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658774209;
        bh=vkNtJ9/f5xSG40imfAVI2qOG8SRV9Ew5rhyxBAoAsOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7hDmww8N/IjdWvLVkLO8O5C0dRL0SfI4gFoE0pB+EqeDrRQ4I3BPrJt3wT4egkQ/
         39qoS3FBSffFeapYcLY0CZQHWDYR3t27oq36daKKqZpRfBN3G61ht07ZezPMFMdt91
         +mTYz+BoutSirOhNgtCsukBrvarQdIeBLdr0smkFtcakG95ShBqvKD5x8bIYRF08p0
         i2ux9gLkwt5E7gvbAYkJKiDgk5pL9CvVj21IO+RnGO+1oIhKDumnviBuQwGQ3dQ6gG
         1qsTK6IKcQtl34QdxrKjJFUd3SEiKlaT7GxwebiB/zPGyyFQrtoqvuDiTaRzl2zSA/
         av7yslcxPvIqg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v3 2/3] crypto: lib - move __crypto_xor into utils
Date:   Mon, 25 Jul 2022 11:36:35 -0700
Message-Id: <20220725183636.97326-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220725183636.97326-1-ebiggers@kernel.org>
References: <20220725183636.97326-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
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
moving __crypto_xor into the utils module in lib/crypto/.

Note that CRYPTO_LIB_CHACHA_GENERIC selected XOR_BLOCKS, which is
unrelated and unnecessary.  It was perhaps thought that XOR_BLOCKS was
needed for __crypto_xor, but that's not the case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/algapi.c     | 71 ------------------------------------
 lib/crypto/Kconfig  |  3 +-
 lib/crypto/Makefile |  2 +-
 lib/crypto/memneq.c |  2 --
 lib/crypto/utils.c  | 88 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 76 deletions(-)
 create mode 100644 lib/crypto/utils.c

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
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index b09d9d6546cbc3..7e9683e9f5c636 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -36,7 +36,7 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
-	select XOR_BLOCKS
+	select CRYPTO_LIB_UTILS
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  ChaCha library interface that require the generic code as a
@@ -46,7 +46,6 @@ config CRYPTO_LIB_CHACHA_GENERIC
 
 config CRYPTO_LIB_CHACHA
 	tristate "ChaCha library interface"
-	depends on CRYPTO
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index b956b3bae26aaf..c852f067ab0601 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_LIB_UTILS)			+= libcryptoutils.o
-libcryptoutils-y				:= memneq.o
+libcryptoutils-y				:= memneq.o utils.o
 
 # chacha is used by the /dev/random driver which is always builtin
 obj-y						+= chacha.o
diff --git a/lib/crypto/memneq.c b/lib/crypto/memneq.c
index f2098318428478..d1e8c86fbb0fcf 100644
--- a/lib/crypto/memneq.c
+++ b/lib/crypto/memneq.c
@@ -175,5 +175,3 @@ noinline unsigned long __crypto_memneq(const void *a, const void *b,
 EXPORT_SYMBOL(__crypto_memneq);
 
 #endif /* __HAVE_ARCH_CRYPTO_MEMNEQ */
-
-MODULE_LICENSE("GPL");
diff --git a/lib/crypto/utils.c b/lib/crypto/utils.c
new file mode 100644
index 00000000000000..53230ab1b19576
--- /dev/null
+++ b/lib/crypto/utils.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Crypto library utility functions
+ *
+ * Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <linux/module.h>
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
+
+MODULE_LICENSE("GPL");
-- 
2.37.0

