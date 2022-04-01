Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAE4EFB47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352209AbiDAUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351981AbiDAUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0685B0F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2139478wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+7KNurryNyAJClOH+iG6roylpIcQjX+XN2mzXKtw2Y=;
        b=AVUH0oDlWjvPJIa3QazfvV/LG9kR2GMXH1677fU+OsNtQ7/wk3NkzZ7wzwAVjhAVtO
         pB9mG7HL0g0oVD6oS8njtnKSjVwN6Mle0MgC48J8xG325O5wDZG7g+QT7qor3rF5loej
         1Al2wIYyvcC5sP871VOVxuNa8ZLL1P+2hymRTWCi+25fvM18qIo8zgK7xKg72NdhYJnO
         wnxmBPsvdFvluXVnAPGB/zHR+sB4IlYzOR35s1q9OauXlsI7CVWG4jFkMxt3hTyfvXU9
         mPp3qki7pXAWWB1ZOwxb5bp1SgSC29XfbrjmGtzrBlCYFHwmfWSPHp74yLEdGcP4SXpo
         DgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+7KNurryNyAJClOH+iG6roylpIcQjX+XN2mzXKtw2Y=;
        b=k02CBvKNAPuOvxCmv5oFkm9aiGtE0x0YPuMI9ogCEXOFW8lN5HLRP3E7iiOaFCu8Px
         Jl4xcIvppXUsst48Bj5aCF0eUqQ6b+7yTGczAvAQiAR3oa3zUdACUKbRUD2q2kmH6uLb
         IPIUNz7EXiakhJqZNHIytWj76UpNHsgQiASKdATb3FRRQ5hXNi+U3K1b2gHkIXWI9MCJ
         mdO0vamqqN3NqHjqCZ8NoShal+VILXNCxfEFGpWf3/iFMik/YAeYvoTVlayYvvCnpHsF
         DSM7jyImqX2VfuU7qob1McfwHmLITMeSDqpmWKKezA2Gls63rKSx/X9SWB27juUnEd7E
         Y0uw==
X-Gm-Message-State: AOAM530ky4Xzu9scrl5kR/THabrgapTR9WhqCzz2zlFXUabb+BWo4DWq
        RMbQsPMdOv0lnuY27FCOkbP2Mw==
X-Google-Smtp-Source: ABdhPJyw4iB/+jvBCbFVjOCg//RWJnZG2wlhgSNKorOE4PB6hd/N9m0vOT+tDGVZOIOdoZBqYr5Xfg==
X-Received: by 2002:a7b:c40f:0:b0:389:f3ad:5166 with SMTP id k15-20020a7bc40f000000b00389f3ad5166mr9949057wmi.63.1648844296777;
        Fri, 01 Apr 2022 13:18:16 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 08/33] crypto: rockchip: better handle cipher key
Date:   Fri,  1 Apr 2022 20:17:39 +0000
Message-Id: <20220401201804.2867154-9-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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
2.35.1

