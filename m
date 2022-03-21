Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54314E313F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353033AbiCUUKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352954AbiCUUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E9C104297
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:07:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so22253024wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ci0efpCMY9zTNuOVgDKNG91fdIJJ0F69qN8X/Q/Dc4g=;
        b=fUlJScinxALBEKGsxDRADRumA9/X76r4caxuw7MfkLlPHpxvicP7Z1x2y7CJtV7tAk
         08HcMfjN3qx8ha5ErVUA1JEOtg/wO8FK8wwK7RdaKWzmaeCVBqZHmJCoQcpldbXU5v+Y
         HPD7qSmBVrpx95StbfZPDTznrB7TN11f5XqoJF/C8HaOmV2OJvOoOlVCuDLVaewm2NSq
         BXj62hwdSLYjxudkNPULA9U1JzjvuIrXv0tDOv/I6hz33ncEfU0anwuJC9Sl8qW7k6+B
         Cx5w97iId9pK6D3w1E+GFB/A+75c/k2IA7NHnwUkj3O1lRgO8wCG8JdSXQ0KwvMHMn3d
         UVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ci0efpCMY9zTNuOVgDKNG91fdIJJ0F69qN8X/Q/Dc4g=;
        b=wm3dTVMwzYJk2SwPkErdPYfo18a8VP9yzWyIcRWMNiVZ9tWs8Bp+xyTU1uooWQsdbF
         AM0jZQLldW7M9qdS5ZVsWY+zmgJkX1Bdy1raflV6boWCbGebBOM26jSXFzBTq1Ii/P7z
         uOf0bObTspN3jFMlUl5/ZuLbsAXSl/ek+ofR+hUP4Vg8YchNIfpF43D780VBt6MEHmF9
         tQHc2rqoH3NmgR0eLk4lhS2s4WhJfxXN+bPbVc5pgk+uHrvFQLeITW/GOUaVA9A5MH+d
         yFQedwIF6N2LrprRfuzG13I+CNvPxkU7/HUfHQpfhESQD5fBlFzBsjxHiAaI7XCMqz+Q
         l3Lw==
X-Gm-Message-State: AOAM532e6IbSea2XGl/n0O7dLzn2RhhJD0N/bBxruJ3lp9pJG124aIbG
        bQFC+dqXfKVt2vAKx826TKRCbA==
X-Google-Smtp-Source: ABdhPJxyLt+c6FqsDmNtE9T6VneF9gd/vdSmff2ATUPTkqRPvltvlqbagxJ930el3cMP7k+jGTV9wg==
X-Received: by 2002:a5d:6d8b:0:b0:203:f9b4:be1d with SMTP id l11-20020a5d6d8b000000b00203f9b4be1dmr13153556wrs.298.1647893275492;
        Mon, 21 Mar 2022 13:07:55 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:07:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 08/26] crypto: rockchip: better handle cipher key
Date:   Mon, 21 Mar 2022 20:07:21 +0000
Message-Id: <20220321200739.3572792-9-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321200739.3572792-1-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
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

The key should not be set in hardware too much in advance, this will
fail it 2 TFM with different keys generate alternative requests.
The key should be stored and used just before doing cipher operations.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h          |  1 +
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 8b1e15d8ddc6..826508e4a0c3 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -245,6 +245,7 @@ struct rk_ahash_rctx {
 struct rk_cipher_ctx {
 	struct rk_crypto_info		*dev;
 	unsigned int			keylen;
+	u32 key[AES_MAX_KEY_SIZE / 4];
 	u8				iv[AES_BLOCK_SIZE];
 	struct crypto_skcipher *fallback_tfm;
 };
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index c6b601086c04..5a9ba7c0206d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -103,7 +103,7 @@ static int rk_aes_setkey(struct crypto_skcipher *cipher,
 	    keylen != AES_KEYSIZE_256)
 		return -EINVAL;
 	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, key, keylen);
+	memcpy(ctx->key, key, keylen);
 
 	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
@@ -119,7 +119,7 @@ static int rk_des_setkey(struct crypto_skcipher *cipher,
 		return err;
 
 	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
+	memcpy(ctx->key, key, keylen);
 
 	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
@@ -135,7 +135,8 @@ static int rk_tdes_setkey(struct crypto_skcipher *cipher,
 		return err;
 
 	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
+	memcpy(ctx->key, key, keylen);
+
 	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
 
@@ -291,6 +292,7 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev)
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
 		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
 		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, req->iv, ivsize);
+		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -303,6 +305,7 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev)
 			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
 		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
 		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, req->iv, ivsize);
+		memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
 		    RK_CRYPTO_BYTESWAP_BRFIFO;
@@ -492,6 +495,7 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 {
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
+	memzero_explicit(ctx->key, ctx->keylen);
 	free_page((unsigned long)ctx->dev->addr_vir);
 	crypto_free_skcipher(ctx->fallback_tfm);
 }
-- 
2.34.1

