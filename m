Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B89521337
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiEJLLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiEJLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:11:33 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E9106365;
        Tue, 10 May 2022 04:07:36 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1noNi1-00BzVg-AK; Tue, 10 May 2022 21:07:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 May 2022 19:07:17 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 10 May 2022 19:07:17 +0800
Subject: [RFC PATCH 5/7] crypto: skcipher - Add ctx helpers with DMA alignment
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
Message-Id: <E1noNi1-00BzVg-AK@fornost.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helpers to access the skcipher context structure and
request context structure with an added alignment for DMA access.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/internal/skcipher.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index a2339f80a6159..719822e42dc46 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -122,6 +122,15 @@ static inline void crypto_skcipher_set_reqsize(
 	skcipher->reqsize = reqsize;
 }
 
+static inline void crypto_skcipher_set_reqsize_dma(
+	struct crypto_skcipher *skcipher, unsigned int reqsize)
+{
+#ifdef ARCH_DMA_MINALIGN
+	reqsize += ARCH_DMA_MINALIGN & ~(crypto_tfm_ctx_alignment() - 1);
+#endif
+	skcipher->reqsize = reqsize;
+}
+
 int crypto_register_skcipher(struct skcipher_alg *alg);
 void crypto_unregister_skcipher(struct skcipher_alg *alg);
 int crypto_register_skciphers(struct skcipher_alg *algs, int count);
@@ -151,11 +160,30 @@ static inline void *crypto_skcipher_ctx(struct crypto_skcipher *tfm)
 	return crypto_tfm_ctx(&tfm->base);
 }
 
+static inline void *crypto_skcipher_ctx_dma(struct crypto_skcipher *tfm)
+{
+	return crypto_tfm_ctx_dma(&tfm->base);
+}
+
 static inline void *skcipher_request_ctx(struct skcipher_request *req)
 {
 	return req->__ctx;
 }
 
+static inline void *skcipher_request_ctx_dma(struct skcipher_request *req)
+{
+	unsigned int align = 1;
+
+#ifdef ARCH_DMA_MINALIGN
+	align = ARCH_DMA_MINALIGN;
+#endif
+
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+
+	return PTR_ALIGN(skcipher_request_ctx(req), align);
+}
+
 static inline u32 skcipher_request_flags(struct skcipher_request *req)
 {
 	return req->base.flags;
