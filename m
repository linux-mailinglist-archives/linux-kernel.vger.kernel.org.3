Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A034FFEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiDMTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiDMTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:11:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B3C716C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c7so4045574wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2uYJa2gxIdaD8fQBCxMjwb6E0s7Z3esdAlzwfZv714=;
        b=7Le5EEHXMfNQFXEeyGRkW58elygFVidUMxoXIfT30Nz78GOeXzyatYmN+eOrDpHNAX
         xgdkwbPIKxs3wTY4Q6ebcogxaPv423JnQIAYgeOp/JhHqbJwaPTdc5BA7sivZk62Shaa
         1vQMuqN1LCUY1eah+aIjh4Wu/UgodCMIvGtv1LilYCr6mjrOlIJc0mZw75iPP0KyizKe
         NUpVthp5G//CaoMRCjUVe8GxC/wx62oHJULKh0W+I40NApZyKsm0Qo6CneCeCAhSH28/
         Y4PfX4w4T7jyL/Avc66CphnlvD1r0+keTM/fqEF5CCRnr9Sn4nhHpJ1MqoB4NtIpkiaC
         o0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2uYJa2gxIdaD8fQBCxMjwb6E0s7Z3esdAlzwfZv714=;
        b=bWQ0DQtJyjXCHGMPdnBoE5xlIiYOucb9l+D18kth4h87KMPfX3r9mMYEnPir4LXJmZ
         p6YIB5fODQFF0VVH4eQu7bpSmFTzgpLIufONSX9siBdPLf8Cj0XLiRtJJBVq7lrNFIwx
         tzA9izlizahZpp3e8ZUQe6AnlogVhn8SCDCvygUCJWFUr2S4+Fhouvn2w2nvlJtvzpeL
         COkPvPc7dqW5PCqpcJyKjZXM68BEXDv7+dFuNLTUDuD/J30nO2qDKOl9iBmQlDMkzmcc
         IfZeREhEpEfB5/1FQtnw2A2/H+vsDSWOlNYlbk9GLWch6HtDvbBROQpHuw21/GiTblMn
         hqzA==
X-Gm-Message-State: AOAM533D9NrQJ2TqgbjW/37HMmcRzFoAWa2o7e+U5dn1syCqHPJyA0EJ
        BoH2IXoH4LC4rYP8ngV4RE/b8Q==
X-Google-Smtp-Source: ABdhPJyMufv5w3Q0Em6zZifrosMN9dLXnPQkZHsdSYsXYz4sWAA9h5U+l/ojpePovhDVwZD60o4YlA==
X-Received: by 2002:a05:6000:170a:b0:205:8a7f:c0c6 with SMTP id n10-20020a056000170a00b002058a7fc0c6mr238586wrc.702.1649876866655;
        Wed, 13 Apr 2022 12:07:46 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 23/33] crypto: rockchip: use the rk_crypto_info given as parameter
Date:   Wed, 13 Apr 2022 19:07:03 +0000
Message-Id: <20220413190713.1427956-24-clabbe@baylibre.com>
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

Instead of using the crypto_info from TFM ctx, use the one given as parameter.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 6a1bea98fded..cf0dfb6029d8 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -254,7 +254,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 			     RK_CRYPTO_TDES_BYTESWAP_KEY |
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
 		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -266,7 +266,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 		else if (ctx->keylen == AES_KEYSIZE_256)
 			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
 		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
 		    RK_CRYPTO_BYTESWAP_BRFIFO;
-- 
2.35.1

