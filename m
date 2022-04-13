Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED44FFE98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiDMTKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiDMTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:09:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A46E4FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y21so209760wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQ7tISy8K+0cgFIOzo6JwID81BS3DiD07ImA91vTtec=;
        b=FUUOxhXEP1esgDtByH4l7EUzXa21cFOFx7Uz3+GMIupeYmMrcioX5Joj8okVQWcODq
         S1Lb0opc7ZpNj3bsOhcsNoKAFkyjpvXAAcOlrFDyXZ1xh1fV+O34LnQ0hUn/WkqdVC2s
         r1ZKLeVsP6RIhyvMoTq9iUBniUi0qmrsxyOuO4JaUFc0JxjhwYi/02xHfvKoq6/Dykx3
         DO3Mrs2cjXTxrLfefKIhc5eBZ4MW+dDxdqc+vxZeyLJLbHyGsmU4Trok9yAlwkphd04y
         YfE6iQJAPrZjQ3eSjeLKrrUj6RxucRzsw4n3MaC7B+jf9y4vt/MxGdFzh/3zbIjAVFuM
         IPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQ7tISy8K+0cgFIOzo6JwID81BS3DiD07ImA91vTtec=;
        b=uyyffFIZyuUdL3TKl8UVt4oWjPa7NpTXBPlFpn/xcHfDMhNMALlPafXmIt+x8Qzsbq
         VQqP9UuV24dhW4QPprngzjEUU0Iz+w9o8VkqWSVf5lNxErSgSFapj8aQt6xBXae6joNf
         hucvixNBlsw3OHoPxA28QdZl4CcK+dvmL9cHhNM1l4ZFVEAUCiRONQ1yKpb2X7DuuVMc
         hu8jcMoXAu4bdVq9C5txLfWQLvbEFhQWX39I4jj8qChONv2Dl2potp3T369ZCGO14741
         PuecjI0v1qxsLIRJpiF/jXVjR6dw/UM8e0LL9SZh1RmIB7CiCQhHjHUMwX1d3jBpz6jj
         MpNQ==
X-Gm-Message-State: AOAM5316qz1WRyYslnTsMW+JqA4htVUmgEOUXXbF2U9t4EyuD5i0kfhY
        gNBSz6nfEkZ78EJADVdi/x/AyQ==
X-Google-Smtp-Source: ABdhPJzauloLlU0Lh1Zjmm6mRRoCU23zMPX9KP+2f6hmXv73y1j0LPJsbVzu111EklGWW5b484ul2A==
X-Received: by 2002:a1c:f604:0:b0:38c:8ffd:dbb6 with SMTP id w4-20020a1cf604000000b0038c8ffddbb6mr153338wmc.43.1649876846690;
        Wed, 13 Apr 2022 12:07:26 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:26 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 05/33] crypto: rockchip: do not store mode globally
Date:   Wed, 13 Apr 2022 19:06:45 +0000
Message-Id: <20220413190713.1427956-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
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

Storing the mode globally does not work if 2 requests are handled in the
same time.
We should store it in a request context.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h       |  5 +-
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 58 ++++++++++++-------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 656d6795d400..c919d9a43a08 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -245,10 +245,13 @@ struct rk_ahash_rctx {
 struct rk_cipher_ctx {
 	struct rk_crypto_info		*dev;
 	unsigned int			keylen;
-	u32				mode;
 	u8				iv[AES_BLOCK_SIZE];
 };
 
+struct rk_cipher_rctx {
+	u32				mode;
+};
+
 enum alg_type {
 	ALG_TYPE_HASH,
 	ALG_TYPE_CIPHER,
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 8c44a19eab75..bbd0bf52bf07 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -76,9 +76,10 @@ static int rk_aes_ecb_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_AES_ECB_MODE;
+	rctx->mode = RK_CRYPTO_AES_ECB_MODE;
 	return rk_handle_req(dev, req);
 }
 
@@ -86,9 +87,10 @@ static int rk_aes_ecb_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_AES_ECB_MODE | RK_CRYPTO_DEC;
+	rctx->mode = RK_CRYPTO_AES_ECB_MODE | RK_CRYPTO_DEC;
 	return rk_handle_req(dev, req);
 }
 
@@ -96,9 +98,10 @@ static int rk_aes_cbc_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_AES_CBC_MODE;
+	rctx->mode = RK_CRYPTO_AES_CBC_MODE;
 	return rk_handle_req(dev, req);
 }
 
@@ -106,9 +109,10 @@ static int rk_aes_cbc_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_AES_CBC_MODE | RK_CRYPTO_DEC;
+	rctx->mode = RK_CRYPTO_AES_CBC_MODE | RK_CRYPTO_DEC;
 	return rk_handle_req(dev, req);
 }
 
@@ -116,9 +120,10 @@ static int rk_des_ecb_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = 0;
+	rctx->mode = 0;
 	return rk_handle_req(dev, req);
 }
 
@@ -126,9 +131,10 @@ static int rk_des_ecb_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_DEC;
+	rctx->mode = RK_CRYPTO_DEC;
 	return rk_handle_req(dev, req);
 }
 
@@ -136,9 +142,10 @@ static int rk_des_cbc_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC;
+	rctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC;
 	return rk_handle_req(dev, req);
 }
 
@@ -146,9 +153,10 @@ static int rk_des_cbc_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC | RK_CRYPTO_DEC;
+	rctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC | RK_CRYPTO_DEC;
 	return rk_handle_req(dev, req);
 }
 
@@ -156,9 +164,10 @@ static int rk_des3_ede_ecb_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_TDES_SELECT;
+	rctx->mode = RK_CRYPTO_TDES_SELECT;
 	return rk_handle_req(dev, req);
 }
 
@@ -166,9 +175,10 @@ static int rk_des3_ede_ecb_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_DEC;
+	rctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_DEC;
 	return rk_handle_req(dev, req);
 }
 
@@ -176,9 +186,10 @@ static int rk_des3_ede_cbc_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC;
+	rctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC;
 	return rk_handle_req(dev, req);
 }
 
@@ -186,9 +197,10 @@ static int rk_des3_ede_cbc_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *dev = ctx->dev;
 
-	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC |
+	rctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC |
 		    RK_CRYPTO_DEC;
 	return rk_handle_req(dev, req);
 }
@@ -199,6 +211,7 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev)
 		skcipher_request_cast(dev->async_req);
 	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
 	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
 	u32 ivsize, block, conf_reg = 0;
 
@@ -206,22 +219,22 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev)
 	ivsize = crypto_skcipher_ivsize(cipher);
 
 	if (block == DES_BLOCK_SIZE) {
-		ctx->mode |= RK_CRYPTO_TDES_FIFO_MODE |
+		rctx->mode |= RK_CRYPTO_TDES_FIFO_MODE |
 			     RK_CRYPTO_TDES_BYTESWAP_KEY |
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
-		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, ctx->mode);
+		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
 		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, req->iv, ivsize);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
-		ctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
+		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
 			     RK_CRYPTO_AES_KEY_CHANGE |
 			     RK_CRYPTO_AES_BYTESWAP_KEY |
 			     RK_CRYPTO_AES_BYTESWAP_IV;
 		if (ctx->keylen == AES_KEYSIZE_192)
-			ctx->mode |= RK_CRYPTO_AES_192BIT_key;
+			rctx->mode |= RK_CRYPTO_AES_192BIT_key;
 		else if (ctx->keylen == AES_KEYSIZE_256)
-			ctx->mode |= RK_CRYPTO_AES_256BIT_key;
-		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, ctx->mode);
+			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
+		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
 		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, req->iv, ivsize);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
@@ -246,6 +259,7 @@ static int rk_set_data_start(struct rk_crypto_info *dev)
 	struct skcipher_request *req =
 		skcipher_request_cast(dev->async_req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	u32 ivsize = crypto_skcipher_ivsize(tfm);
 	u8 *src_last_blk = page_address(sg_page(dev->sg_src)) +
@@ -254,7 +268,7 @@ static int rk_set_data_start(struct rk_crypto_info *dev)
 	/* Store the iv that need to be updated in chain mode.
 	 * And update the IV buffer to contain the next IV for decryption mode.
 	 */
-	if (ctx->mode & RK_CRYPTO_DEC) {
+	if (rctx->mode & RK_CRYPTO_DEC) {
 		memcpy(ctx->iv, src_last_blk, ivsize);
 		sg_pcopy_to_buffer(dev->first, dev->src_nents, req->iv,
 				   ivsize, dev->total - ivsize);
@@ -294,11 +308,12 @@ static void rk_iv_copyback(struct rk_crypto_info *dev)
 	struct skcipher_request *req =
 		skcipher_request_cast(dev->async_req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	u32 ivsize = crypto_skcipher_ivsize(tfm);
 
 	/* Update the IV buffer to contain the next IV for encryption mode. */
-	if (!(ctx->mode & RK_CRYPTO_DEC)) {
+	if (!(rctx->mode & RK_CRYPTO_DEC)) {
 		if (dev->aligned) {
 			memcpy(req->iv, sg_virt(dev->sg_dst) +
 				dev->sg_dst->length - ivsize, ivsize);
@@ -314,11 +329,12 @@ static void rk_update_iv(struct rk_crypto_info *dev)
 	struct skcipher_request *req =
 		skcipher_request_cast(dev->async_req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	u32 ivsize = crypto_skcipher_ivsize(tfm);
 	u8 *new_iv = NULL;
 
-	if (ctx->mode & RK_CRYPTO_DEC) {
+	if (rctx->mode & RK_CRYPTO_DEC) {
 		new_iv = ctx->iv;
 	} else {
 		new_iv = page_address(sg_page(dev->sg_dst)) +
-- 
2.35.1

