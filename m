Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABDB4FFE95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiDMTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiDMTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:09:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD16E4E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4579718wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBtkTtzZx99G/0qB6r+axIZfB65vvPlvwuFVXfvR0eo=;
        b=cKw4fYlBrtzooAI/YFWKP7Pnx4KMAnJ3/e9e0lLvca9KAMoLDx2DyUeWz5vMIfoq08
         p2CbtG0DJOkTgZDP6YPrHAsXZFPPDnlML35Jqugp8WiBNyH+O2rDmXDirrAyeUaMDVUL
         uXvGHDKhTlDnXMi9bsJW4HZWCDcGmbBmtWgptEGr5c/5J0NpJL4x/FGhiFCr59/nHQ0m
         N7cFwccHFHA/uEbOS+NNR5gqhgD2uB1LfP7ZG4Qcg/449lSGfM7yNleEp9MtjFLfpBUL
         agopXBJjsSfNDk7nHgt8sKM/nZc/g8+0ApOOiD+89cdK7i3hck8LHEuK0K2XKn1zGhbF
         DjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBtkTtzZx99G/0qB6r+axIZfB65vvPlvwuFVXfvR0eo=;
        b=NeTtB0BsEYILHdy4bKspd+vOqn05KesAnuZVN+GZHFApub803fA9mBd5iTFdd2oc3V
         xESagt4YImF/p8U/vusug57eahXTbitIpG+MBA9SnNn/25DbNIEuJ4mO/pZBKhts5qNz
         voChwDX9oyZKVIjkLy0WhCyczjqAIQIhOdJipfc3UIZ7vlKGtxrK2Ss8PStI0OVYPgJu
         1/gsTeH30oqAho7ktB+DcCCFDJKu6sd3sNzQLvzth8qknCrhe+Oi58cZgtx3sS3R3eWC
         4oKnAOYtvx/K9cja26Ig6i3G/4kNSj+ffs9oGxAOknqLGFD7Ez1y1y0tpE0R23QV+VHR
         H+jw==
X-Gm-Message-State: AOAM532rxpddnAFdklghZG+zrR+Evq9flwuMtWzyfl4+rELQAAcvLFeU
        wS4kLIvey08HnvVAeUtOQ9r/CQ==
X-Google-Smtp-Source: ABdhPJypHQzgFLGFnptm5kGCssvedrPS9dz00PDFttc0oHnoSv876T0x27u0xbKaTrTil2IlmEwcuQ==
X-Received: by 2002:a05:600c:210b:b0:38e:c62a:398b with SMTP id u11-20020a05600c210b00b0038ec62a398bmr168431wml.118.1649876847722;
        Wed, 13 Apr 2022 12:07:27 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:27 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 06/33] crypto: rockchip: add fallback for cipher
Date:   Wed, 13 Apr 2022 19:06:46 +0000
Message-Id: <20220413190713.1427956-7-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware does not handle 0 size length request, let's add a
fallback.
Furthermore fallback will be used for all unaligned case the hardware
cannot handle.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig                        |  4 +
 drivers/crypto/rockchip/rk3288_crypto.h       |  2 +
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 97 ++++++++++++++++---
 3 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 7b2d138bc83e..84ab14afcbd9 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -784,6 +784,10 @@ config CRYPTO_DEV_IMGTEC_HASH
 config CRYPTO_DEV_ROCKCHIP
 	tristate "Rockchip's Cryptographic Engine driver"
 	depends on OF && ARCH_ROCKCHIP
+	depends on PM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_DES
 	select CRYPTO_AES
 	select CRYPTO_LIB_DES
 	select CRYPTO_MD5
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index c919d9a43a08..8b1e15d8ddc6 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -246,10 +246,12 @@ struct rk_cipher_ctx {
 	struct rk_crypto_info		*dev;
 	unsigned int			keylen;
 	u8				iv[AES_BLOCK_SIZE];
+	struct crypto_skcipher *fallback_tfm;
 };
 
 struct rk_cipher_rctx {
 	u32				mode;
+	struct skcipher_request fallback_req;   // keep at the end
 };
 
 enum alg_type {
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index bbd0bf52bf07..eac5bba66e25 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -13,6 +13,63 @@
 
 #define RK_CRYPTO_DEC			BIT(0)
 
+static int rk_cipher_need_fallback(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	unsigned int bs = crypto_skcipher_blocksize(tfm);
+	struct scatterlist *sgs, *sgd;
+	unsigned int stodo, dtodo, len;
+
+	if (!req->cryptlen)
+		return true;
+
+	len = req->cryptlen;
+	sgs = req->src;
+	sgd = req->dst;
+	while (sgs && sgd) {
+		if (!IS_ALIGNED(sgs->offset, sizeof(u32))) {
+			return true;
+		}
+		if (!IS_ALIGNED(sgd->offset, sizeof(u32))) {
+			return true;
+		}
+		stodo = min(len, sgs->length);
+		if (stodo % bs) {
+			return true;
+		}
+		dtodo = min(len, sgd->length);
+		if (dtodo % bs) {
+			return true;
+		}
+		if (stodo != dtodo) {
+			return true;
+		}
+		len -= stodo;
+		sgs = sg_next(sgs);
+		sgd = sg_next(sgd);
+	}
+	return false;
+}
+
+static int rk_cipher_fallback(struct skcipher_request *areq)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct rk_cipher_ctx *op = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(areq);
+	int err;
+
+	skcipher_request_set_tfm(&rctx->fallback_req, op->fallback_tfm);
+	skcipher_request_set_callback(&rctx->fallback_req, areq->base.flags,
+				      areq->base.complete, areq->base.data);
+	skcipher_request_set_crypt(&rctx->fallback_req, areq->src, areq->dst,
+				   areq->cryptlen, areq->iv);
+	if (rctx->mode & RK_CRYPTO_DEC)
+		err = crypto_skcipher_decrypt(&rctx->fallback_req);
+	else
+		err = crypto_skcipher_encrypt(&rctx->fallback_req);
+	return err;
+}
+
 static void rk_crypto_complete(struct crypto_async_request *base, int err)
 {
 	if (base->complete)
@@ -22,10 +79,10 @@ static void rk_crypto_complete(struct crypto_async_request *base, int err)
 static int rk_handle_req(struct rk_crypto_info *dev,
 			 struct skcipher_request *req)
 {
-	if (!IS_ALIGNED(req->cryptlen, dev->align_size))
-		return -EINVAL;
-	else
-		return dev->enqueue(dev, &req->base);
+	if (rk_cipher_need_fallback(req))
+		return rk_cipher_fallback(req);
+
+	return dev->enqueue(dev, &req->base);
 }
 
 static int rk_aes_setkey(struct crypto_skcipher *cipher,
@@ -39,7 +96,8 @@ static int rk_aes_setkey(struct crypto_skcipher *cipher,
 		return -EINVAL;
 	ctx->keylen = keylen;
 	memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, key, keylen);
-	return 0;
+
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
 
 static int rk_des_setkey(struct crypto_skcipher *cipher,
@@ -54,7 +112,8 @@ static int rk_des_setkey(struct crypto_skcipher *cipher,
 
 	ctx->keylen = keylen;
 	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
-	return 0;
+
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
 
 static int rk_tdes_setkey(struct crypto_skcipher *cipher,
@@ -69,7 +128,7 @@ static int rk_tdes_setkey(struct crypto_skcipher *cipher,
 
 	ctx->keylen = keylen;
 	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
-	return 0;
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
 
 static int rk_aes_ecb_encrypt(struct skcipher_request *req)
@@ -394,6 +453,7 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
 {
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	const char *name = crypto_tfm_alg_name(&tfm->base);
 	struct rk_crypto_tmp *algt;
 
 	algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
@@ -407,6 +467,16 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
 	if (!ctx->dev->addr_vir)
 		return -ENOMEM;
 
+	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->fallback_tfm)) {
+		dev_err(ctx->dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
+			name, PTR_ERR(ctx->fallback_tfm));
+		return PTR_ERR(ctx->fallback_tfm);
+	}
+
+	tfm->reqsize = sizeof(struct rk_cipher_rctx) +
+		crypto_skcipher_reqsize(ctx->fallback_tfm);
+
 	return 0;
 }
 
@@ -415,6 +485,7 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	free_page((unsigned long)ctx->dev->addr_vir);
+	crypto_free_skcipher(ctx->fallback_tfm);
 }
 
 struct rk_crypto_tmp rk_ecb_aes_alg = {
@@ -423,7 +494,7 @@ struct rk_crypto_tmp rk_ecb_aes_alg = {
 		.base.cra_name		= "ecb(aes)",
 		.base.cra_driver_name	= "ecb-aes-rk",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
 		.base.cra_alignmask	= 0x0f,
@@ -445,7 +516,7 @@ struct rk_crypto_tmp rk_cbc_aes_alg = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "cbc-aes-rk",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
 		.base.cra_alignmask	= 0x0f,
@@ -468,7 +539,7 @@ struct rk_crypto_tmp rk_ecb_des_alg = {
 		.base.cra_name		= "ecb(des)",
 		.base.cra_driver_name	= "ecb-des-rk",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
 		.base.cra_alignmask	= 0x07,
@@ -490,7 +561,7 @@ struct rk_crypto_tmp rk_cbc_des_alg = {
 		.base.cra_name		= "cbc(des)",
 		.base.cra_driver_name	= "cbc-des-rk",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
 		.base.cra_alignmask	= 0x07,
@@ -513,7 +584,7 @@ struct rk_crypto_tmp rk_ecb_des3_ede_alg = {
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "ecb-des3-ede-rk",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
 		.base.cra_alignmask	= 0x07,
@@ -535,7 +606,7 @@ struct rk_crypto_tmp rk_cbc_des3_ede_alg = {
 		.base.cra_name		= "cbc(des3_ede)",
 		.base.cra_driver_name	= "cbc-des3-ede-rk",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
 		.base.cra_alignmask	= 0x07,
-- 
2.35.1

