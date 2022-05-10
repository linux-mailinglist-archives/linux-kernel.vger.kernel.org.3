Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A78521343
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiEJLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiEJLLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:11:38 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4010636B;
        Tue, 10 May 2022 04:07:40 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1noNi6-00BzW8-4S; Tue, 10 May 2022 21:07:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 May 2022 19:07:22 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 10 May 2022 19:07:22 +0800
Subject: [RFC PATCH 7/7] crypto: caam - Explicitly request DMA alignment
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
Message-Id: <E1noNi6-00BzW8-4S@fornost.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses API helpers to explicitly request for DMA alignment
when allocating memory through the Crypto API.  Previously it was
implicitly assumed that all kmalloc memory is aligned for DMA.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/caam/caamalg.c |  101 ++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d3d8bb0a69900..c12c678dcb0fd 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -131,7 +131,7 @@ struct caam_aead_req_ctx {
 
 static int aead_null_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	u32 *desc;
@@ -184,7 +184,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 struct caam_aead_alg, aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	u32 ctx1_iv_off = 0;
@@ -312,7 +312,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 static int aead_setauthsize(struct crypto_aead *authenc,
 				    unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	ctx->authsize = authsize;
 	aead_set_sh_desc(authenc);
@@ -322,7 +322,7 @@ static int aead_setauthsize(struct crypto_aead *authenc,
 
 static int gcm_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -372,7 +372,7 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_gcm_check_authsize(authsize);
@@ -387,7 +387,7 @@ static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 
 static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -440,7 +440,7 @@ static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_rfc4106_check_authsize(authsize);
@@ -455,7 +455,7 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 
 static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -508,7 +508,7 @@ static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 static int rfc4543_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	if (authsize != 16)
 		return -EINVAL;
@@ -521,7 +521,7 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 
 static int chachapoly_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -547,7 +547,7 @@ static int chachapoly_set_sh_desc(struct crypto_aead *aead)
 static int chachapoly_setauthsize(struct crypto_aead *aead,
 				  unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 
 	if (authsize != POLY1305_DIGEST_SIZE)
 		return -EINVAL;
@@ -559,7 +559,7 @@ static int chachapoly_setauthsize(struct crypto_aead *aead,
 static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 			     unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	unsigned int saltlen = CHACHAPOLY_IV_SIZE - ivsize;
 
@@ -575,7 +575,7 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 static int aead_setkey(struct crypto_aead *aead,
 			       const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	struct crypto_authenc_keys keys;
@@ -656,7 +656,7 @@ static int des3_aead_setkey(struct crypto_aead *aead, const u8 *key,
 static int gcm_setkey(struct crypto_aead *aead,
 		      const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int err;
 
@@ -677,7 +677,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 static int rfc4106_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int err;
 
@@ -703,7 +703,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 static int rfc4543_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int err;
 
@@ -729,7 +729,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			   unsigned int keylen, const u32 ctx1_iv_off)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct caam_skcipher_alg *alg =
 		container_of(crypto_skcipher_alg(skcipher), typeof(*alg),
 			     skcipher);
@@ -832,7 +832,7 @@ static int des3_skcipher_setkey(struct crypto_skcipher *skcipher,
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			       unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	u32 *desc;
@@ -970,7 +970,7 @@ static void aead_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 			    void *context)
 {
 	struct aead_request *req = context;
-	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	struct caam_aead_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	struct aead_edesc *edesc;
 	int ecode = 0;
@@ -1003,7 +1003,7 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 {
 	struct skcipher_request *req = context;
 	struct skcipher_edesc *edesc;
-	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
+	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
@@ -1057,7 +1057,7 @@ static void init_aead_job(struct aead_request *req,
 			  bool all_contig, bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	int authsize = ctx->authsize;
 	u32 *desc = edesc->hw_desc;
 	u32 out_options, in_options;
@@ -1118,7 +1118,7 @@ static void init_gcm_job(struct aead_request *req,
 			 bool all_contig, bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc = edesc->hw_desc;
 	bool generic_gcm = (ivsize == GCM_AES_IV_SIZE);
@@ -1185,7 +1185,7 @@ static void init_authenc_job(struct aead_request *req,
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 struct caam_aead_alg, aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(ctx->jrdev->parent);
 	const bool ctr_mode = ((ctx->cdata.algtype & OP_ALG_AAI_MASK) ==
 			       OP_ALG_AAI_CTR_MOD128);
@@ -1234,7 +1234,7 @@ static void init_skcipher_job(struct skcipher_request *req,
 			      const bool encrypt)
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc = edesc->hw_desc;
@@ -1290,9 +1290,9 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					   bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
-	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	struct caam_aead_req_ctx *rctx = aead_request_ctx_dma(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	int src_nents, mapped_src_nents, dst_nents = 0, mapped_dst_nents = 0;
@@ -1429,7 +1429,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 static int aead_enqueue_req(struct device *jrdev, struct aead_request *req)
 {
 	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
-	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	struct caam_aead_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct aead_edesc *edesc = rctx->edesc;
 	u32 *desc = edesc->hw_desc;
 	int ret;
@@ -1457,7 +1457,7 @@ static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 	u32 *desc;
@@ -1491,7 +1491,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 
@@ -1524,8 +1524,8 @@ static int aead_decrypt(struct aead_request *req)
 static int aead_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct aead_request *req = aead_request_cast(areq);
-	struct caam_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
-	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(crypto_aead_reqtfm(req));
+	struct caam_aead_req_ctx *rctx = aead_request_ctx_dma(req);
 	u32 *desc = rctx->edesc->hw_desc;
 	int ret;
 
@@ -1550,7 +1550,7 @@ static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 
@@ -1597,8 +1597,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 						   int desc_bytes)
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
-	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
+	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
@@ -1756,8 +1756,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 static int skcipher_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct skcipher_request *req = skcipher_request_cast(areq);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
-	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(crypto_skcipher_reqtfm(req));
+	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	u32 *desc = rctx->edesc->hw_desc;
 	int ret;
 
@@ -1790,7 +1790,7 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
@@ -1807,7 +1807,8 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 
 	if (ctx->fallback && ((ctrlpriv->era <= 8 && xts_skcipher_ivsize(req)) ||
 			      ctx->xts_key_fallback)) {
-		struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
+		struct caam_skcipher_req_ctx *rctx =
+			skcipher_request_ctx_dma(req);
 
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
@@ -3397,7 +3398,7 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct caam_skcipher_alg *caam_alg =
 		container_of(alg, typeof(*caam_alg), skcipher);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
 	int ret = 0;
 
@@ -3416,10 +3417,12 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 		}
 
 		ctx->fallback = fallback;
-		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx) +
-					    crypto_skcipher_reqsize(fallback));
+		crypto_skcipher_set_reqsize_dma(
+			tfm, sizeof(struct caam_skcipher_req_ctx) +
+			     crypto_skcipher_reqsize(fallback));
 	} else {
-		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx));
+		crypto_skcipher_set_reqsize_dma(
+			tfm, sizeof(struct caam_skcipher_req_ctx));
 	}
 
 	ret = caam_init_common(ctx, &caam_alg->caam, false);
@@ -3434,9 +3437,9 @@ static int caam_aead_init(struct crypto_aead *tfm)
 	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct caam_aead_alg *caam_alg =
 		 container_of(alg, struct caam_aead_alg, aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(tfm);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct caam_aead_req_ctx));
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct caam_aead_req_ctx));
 
 	ctx->enginectx.op.do_one_request = aead_do_one_req;
 
@@ -3454,7 +3457,7 @@ static void caam_exit_common(struct caam_ctx *ctx)
 
 static void caam_cra_exit(struct crypto_skcipher *tfm)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	if (ctx->fallback)
 		crypto_free_skcipher(ctx->fallback);
@@ -3463,7 +3466,7 @@ static void caam_cra_exit(struct crypto_skcipher *tfm)
 
 static void caam_aead_exit(struct crypto_aead *tfm)
 {
-	caam_exit_common(crypto_aead_ctx(tfm));
+	caam_exit_common(crypto_aead_ctx_dma(tfm));
 }
 
 void caam_algapi_exit(void)
@@ -3492,6 +3495,9 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+#ifdef ARCH_DMA_MINALIGN
+	alg->base.cra_alignmask = ARCH_DMA_MINALIGN - 1;
+#endif
 	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY);
 
@@ -3506,6 +3512,9 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+#ifdef ARCH_DMA_MINALIGN
+	alg->base.cra_alignmask = ARCH_DMA_MINALIGN - 1;
+#endif
 	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY;
 
