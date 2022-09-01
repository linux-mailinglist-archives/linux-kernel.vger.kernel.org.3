Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9015A978D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiIAM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiIAM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:57:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9019017
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so1393038wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oouPZY4jXMX4kuosliYv2WbNP1uk5Gy/Lp8NUrzXszo=;
        b=5HED6IbPPQ9KJMRdKDcGlvdarOdZ+jykCy45JZF5ereGwneTHxRwXJwCQ05b55eKzg
         OK4bU5aYudXmyjgFiZuCEFgSTeLPtaOJdJCNFCrI5oKX5p8kbgQ2TXCTMCAIQA0kEm4X
         cQQ/TdiGf1LVtn0aWCQjsnOBrIqeYh+sEsG5uQRsRtPAo9JictCSsmzkherG9LIMaX9K
         XM5gfnolDyZgv7G2A25YL9dm8714JLMSZTffzc7mqc5tGdJJ9b93REzKWaGZLfzNfnyA
         2f8Q2mSgDZbXqgDnaylY3fODcyQyZey/vQRThzR/JqVJ6WkBVzyveFQMMV6sj9yWUgIc
         msIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oouPZY4jXMX4kuosliYv2WbNP1uk5Gy/Lp8NUrzXszo=;
        b=ZTIpRMNq2QQvx6rwDPxZwbgsKqqqkUijt3C4zMFETJtF+JH9bent6UOZXzvCCpnr85
         1Qs1bqdVRYV3fKV2eX2eozf+fd9EdL8yzdEH+HSmpu8EeJ2OY+8uEQypuXJ3nVeMWB8p
         kKH0LZXM3XJoToJMfGum8SKaW7hhazHbo0xzTNuRgsMkduj/r43VjyyKCwW5O7Q6+z1x
         cw6qz+yyfYk/ogaV51VMnV3dJIvlMXYr3qRF+BrP1+jp5fBgcQrMGC9g914XgPt47NYI
         whn7MzP63LO1xesR8GTPN74EBjrIIXIVHti05aQ/KyQqgASy1ddRC+JYnP517d77mzFb
         s0Mg==
X-Gm-Message-State: ACgBeo1AnGxFlPrz5aUvhsoDiz4eNCm7IyogcLsfU2wsWL5BrB8BQr52
        3JhJCjOWRb/d9SGxyjd+LSQTjA==
X-Google-Smtp-Source: AA6agR73ObkDuM3ZG0tEplg9Y9To1QGzN9Rh6K/W60HEtnzuTVMCPN98lnlCxD9uw/R9+LZvtmgZgQ==
X-Received: by 2002:a1c:4b01:0:b0:3a5:94e8:948e with SMTP id y1-20020a1c4b01000000b003a594e8948emr5114851wma.197.1662037042007;
        Thu, 01 Sep 2022 05:57:22 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:21 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v9 05/33] crypto: rockchip: do not store mode globally
Date:   Thu,  1 Sep 2022 12:56:42 +0000
Message-Id: <20220901125710.3733083-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901125710.3733083-1-clabbe@baylibre.com>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
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
Reviewed-by: John Keeping <john@metanate.com>
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

