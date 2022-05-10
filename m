Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4152133F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiEJLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiEJLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:11:27 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4410636B;
        Tue, 10 May 2022 04:07:29 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1noNhw-00BzVF-JA; Tue, 10 May 2022 21:07:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 May 2022 19:07:12 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 10 May 2022 19:07:12 +0800
Subject: [RFC PATCH 3/7] crypto: aead - Add ctx helpers with DMA alignment
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
Message-Id: <E1noNhw-00BzVF-JA@fornost.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helpers to access the aead context structure and
request context structure with an added alignment for DMA access.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/internal/aead.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/crypto/internal/aead.h b/include/crypto/internal/aead.h
index 27b7b0224ea6f..be225f3f7fdbf 100644
--- a/include/crypto/internal/aead.h
+++ b/include/crypto/internal/aead.h
@@ -39,6 +39,11 @@ static inline void *crypto_aead_ctx(struct crypto_aead *tfm)
 	return crypto_tfm_ctx(&tfm->base);
 }
 
+static inline void *crypto_aead_ctx_dma(struct crypto_aead *tfm)
+{
+	return crypto_tfm_ctx_dma(&tfm->base);
+}
+
 static inline struct crypto_instance *aead_crypto_instance(
 	struct aead_instance *inst)
 {
@@ -65,6 +70,20 @@ static inline void *aead_request_ctx(struct aead_request *req)
 	return req->__ctx;
 }
 
+static inline void *aead_request_ctx_dma(struct aead_request *req)
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
+	return PTR_ALIGN(aead_request_ctx(req), align);
+}
+
 static inline void aead_request_complete(struct aead_request *req, int err)
 {
 	req->base.complete(&req->base, err);
@@ -108,6 +127,15 @@ static inline void crypto_aead_set_reqsize(struct crypto_aead *aead,
 	aead->reqsize = reqsize;
 }
 
+static inline void crypto_aead_set_reqsize_dma(struct crypto_aead *aead,
+					       unsigned int reqsize)
+{
+#ifdef ARCH_DMA_MINALIGN
+	reqsize += ARCH_DMA_MINALIGN & ~(crypto_tfm_ctx_alignment() - 1);
+#endif
+	aead->reqsize = reqsize;
+}
+
 static inline void aead_init_queue(struct aead_queue *queue,
 				   unsigned int max_qlen)
 {
