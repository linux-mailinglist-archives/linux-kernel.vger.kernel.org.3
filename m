Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344F95682BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiGFJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiGFJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:04:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E48220E8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so11170722wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ME8Y4kRTkIs//WGHXoSnEtu/nBMpdqDM8UB8oWi8MOY=;
        b=UdRN60DQUVaZIRf8L2zvMiUKDe/LvTFpB/KOxFMLKCW/gdP6TRQbojcMSbN9UFrDmf
         6wScDi4yZ/uTnD3oyPyTPclKoMWIoAsY+wFzcoQ3OYqVrLS4siENLAg2sVHaMdu/vvTb
         MKzu7n7g5DWTvCrHdz5zCEBSwFMtDY/4sru099AfRrks3KtMuLDXhEA3x0tFSKquPaP7
         Giu5HfCzCfk49A4XQUtEc4Ls+FyyoYJKo48fZVZchfng/gH2m8yhZlCh4zbLUb7qR7fz
         Mpo/3m1iZ4h+Cv6K9QsLl2KsmBth769Co+BI2SEHk529xFQB9F6Kn5kEPG3YgwBo6a3q
         kHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ME8Y4kRTkIs//WGHXoSnEtu/nBMpdqDM8UB8oWi8MOY=;
        b=OCKIas/VLcQskfMnxGfU8tZ74f6xqAsOm8M3QK/CzkRYdukR3+rQhqaOPEm/nL6wPO
         /mzfyTFz365cJ662V2PAPr4xWdseh3Fv+xo7gUUMlLGvbVkQP70oqBSM6I09rvRUQ+QB
         NLmHHcwnBsv9YiwYEBKH/X+A8CaaOXlC6Iu3TCAeBKpxmXlHV26zhtoKbzYuegbKJzwY
         CdUTBNeIJck2axndAvm6TD9FLlq54HT5DaekJn3AiO5N1xjAwszDeC5pA/Gvk3DUgZl+
         Npgjp3A3snyDAXksRNA4J9y4uUjEnf/pK+0OpwdS/Fqg/eEpXTVZerWH78+NLivI65L1
         kLpQ==
X-Gm-Message-State: AJIora9ZhJgdrdgTzgbRKL6Vx7APU2hPxmVA67OLppbkocwv0A6tKKzl
        aEOO+7VrEO/PHyk+2AN0tiXROw==
X-Google-Smtp-Source: AGRyM1s9DaSBt6vuHk4EgmNeMLDT2eSsveDx7wd120eJUB9Y5vufORk/vGm7z7AawTId3YsmeddpYg==
X-Received: by 2002:a05:600c:4183:b0:3a0:4694:a862 with SMTP id p3-20020a05600c418300b003a04694a862mr44324738wmh.150.1657098279242;
        Wed, 06 Jul 2022 02:04:39 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 06/33] crypto: rockchip: add fallback for cipher
Date:   Wed,  6 Jul 2022 09:03:45 +0000
Message-Id: <20220706090412.806101-7-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig                        |  4 +
 drivers/crypto/rockchip/rk3288_crypto.h       |  2 +
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 97 ++++++++++++++++---
 3 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index ee99c02c84e8..c293f801806c 100644
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

