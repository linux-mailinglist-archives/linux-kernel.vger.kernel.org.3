Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AED5A97A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiIAM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiIAM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:57:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE5087688
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id az27so22257038wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LTH5XZUoNfw5j5g91Ov715oBhaysSZASayzIPMZPNtU=;
        b=VYxGYEc6y8usYO+JZP4QiOgrlAGRG1wLu624U1JUq4TxEmK1mbvCkzUiuKEXm22xal
         3H9qP5Da0oEc3yXxL3PIie1urXWExvZQWjGbsUnGVuQH5OJLJFNPHj2xAlsUqZSMqKcb
         gitBQXGi9lPoVR438U+lKSxjtEzbkwxYUrul5CsmLyZN8Vti2mWjqCY+cpTuJGv2rU6m
         is3XTP2TZ8tmH88lnBilKEgZ8zy323Y6duRYXAM8uUJdxuaRDSqZXUPDQw8A2uktrxSF
         QAoFZQPurp8fgI/hWuGmyrWlnVSplO03GTQUvhDiqUP/W88mk4jD+jQE7DhKfA4UGY6+
         CUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LTH5XZUoNfw5j5g91Ov715oBhaysSZASayzIPMZPNtU=;
        b=LtYhy9xYKpTeGV0c+OjDxnb3FARq8f1YfO36CiVHbY7q6ngcmmIExYWEJ93TjKnBNi
         /QXvchAIJvvhg8UJxH/Zz4ojJ57SpjcODoBhnJgFkj3sIskcYqnHGSGW4GIqChICP2yD
         PlGmiBMjciWRf5RQH9gPgrz4q+211Vsjy4aCcPfEIY7IzlnKHbyJRg1Zh9fpqAJQ/FRJ
         423J/L77k8VQglYxL2U182AP/RBIkPv3XF9UJKD2uCCAQ/k+DBjNhiS0dQWgybvgPC3m
         5hamiiqSxmWcUthTY3/snq5wEbfanIO7uDJlmivvUt+ONRUczhEqVahhLvHwFhg9L2gp
         IPFA==
X-Gm-Message-State: ACgBeo0NjZGcv8xWod95P5gO0fScDfKRJJ0mLxvAPdAWAcS63Z5iPoNP
        J7C6ebbn4aNJzr8Ka1YbqKdMDg==
X-Google-Smtp-Source: AA6agR4mV5NDTCwgX/NSmjzhziV9s7rwYzU4FAVxYvSMWarz5wSaDTCmBz5mHC5Ia9l4DI5pwguT/w==
X-Received: by 2002:a5d:4c51:0:b0:226:d2fb:85d7 with SMTP id n17-20020a5d4c51000000b00226d2fb85d7mr13699878wrt.210.1662037045073;
        Thu, 01 Sep 2022 05:57:25 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v9 08/33] crypto: rockchip: better handle cipher key
Date:   Thu,  1 Sep 2022 12:56:45 +0000
Message-Id: <20220901125710.3733083-9-clabbe@baylibre.com>
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

The key should not be set in hardware too much in advance, this will
fail it 2 TFM with different keys generate alternative requests.
The key should be stored and used just before doing cipher operations.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h          |  1 +
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 8b1e15d8ddc6..540b81a14b9b 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -245,6 +245,7 @@ struct rk_ahash_rctx {
 struct rk_cipher_ctx {
 	struct rk_crypto_info		*dev;
 	unsigned int			keylen;
+	u8				key[AES_MAX_KEY_SIZE];
 	u8				iv[AES_BLOCK_SIZE];
 	struct crypto_skcipher *fallback_tfm;
 };
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index eac5bba66e25..1ef94f8db2c5 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -95,7 +95,7 @@ static int rk_aes_setkey(struct crypto_skcipher *cipher,
 	    keylen != AES_KEYSIZE_256)
 		return -EINVAL;
 	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, key, keylen);
+	memcpy(ctx->key, key, keylen);
 
 	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
@@ -111,7 +111,7 @@ static int rk_des_setkey(struct crypto_skcipher *cipher,
 		return err;
 
 	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
+	memcpy(ctx->key, key, keylen);
 
 	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
@@ -127,7 +127,8 @@ static int rk_tdes_setkey(struct crypto_skcipher *cipher,
 		return err;
 
 	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
+	memcpy(ctx->key, key, keylen);
+
 	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
 }
 
@@ -283,6 +284,7 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev)
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
 		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
 		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, req->iv, ivsize);
+		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -295,6 +297,7 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev)
 			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
 		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
 		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, req->iv, ivsize);
+		memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
 		    RK_CRYPTO_BYTESWAP_BRFIFO;
@@ -484,6 +487,7 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 {
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
+	memzero_explicit(ctx->key, ctx->keylen);
 	free_page((unsigned long)ctx->dev->addr_vir);
 	crypto_free_skcipher(ctx->fallback_tfm);
 }
-- 
2.35.1

