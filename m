Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8151C521340
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiEJLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbiEJLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:11:25 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2320106365;
        Tue, 10 May 2022 04:07:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1noNhu-00BzV4-4N; Tue, 10 May 2022 21:07:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 May 2022 19:07:10 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 10 May 2022 19:07:10 +0800
Subject: [RFC PATCH 2/7] crypto: api - Add crypto_tfm_ctx_dma
References: <YnpGnsr4k7yVUR54@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1noNhu-00BzV4-4N@fornost.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the helper crypto_tfm_ctx_dma.  It's similar to
crypto_tfm_ctx_aligned but the alignment is hard-coded to the
macro ARCH_DMA_MINALIGN.

This patch also moves crypto_tfm_ctx into algapi.h.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/algapi.h |   28 ++++++++++++++++++++++++++--
 include/linux/crypto.h  |    5 -----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index f50c5d1725da5..cdf12e51c53a0 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -189,10 +189,34 @@ static inline void crypto_xor_cpy(u8 *dst, const u8 *src1, const u8 *src2,
 	}
 }
 
+static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
+{
+	return tfm->__crt_ctx;
+}
+
+static inline void *crypto_tfm_ctx_align(struct crypto_tfm *tfm,
+					 unsigned int align)
+{
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+
+	return PTR_ALIGN(crypto_tfm_ctx(tfm), align);
+}
+
 static inline void *crypto_tfm_ctx_aligned(struct crypto_tfm *tfm)
 {
-	return PTR_ALIGN(crypto_tfm_ctx(tfm),
-			 crypto_tfm_alg_alignmask(tfm) + 1);
+	return crypto_tfm_ctx_align(tfm, crypto_tfm_alg_alignmask(tfm) + 1);
+}
+
+static inline void *crypto_tfm_ctx_dma(struct crypto_tfm *tfm)
+{
+	unsigned int align = 1;
+
+#ifdef ARCH_DMA_MINALIGN
+	align = ARCH_DMA_MINALIGN;
+#endif
+
+	return crypto_tfm_ctx_align(tfm, align);
 }
 
 static inline struct crypto_instance *crypto_tfm_alg_instance(
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846b..5d1e961f810ec 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -714,11 +714,6 @@ static inline void crypto_tfm_clear_flags(struct crypto_tfm *tfm, u32 flags)
 	tfm->crt_flags &= ~flags;
 }
 
-static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
-{
-	return tfm->__crt_ctx;
-}
-
 static inline unsigned int crypto_tfm_ctx_alignment(void)
 {
 	struct crypto_tfm *tfm;
