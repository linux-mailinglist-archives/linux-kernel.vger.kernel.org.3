Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B726456829F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiGFJHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGFJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:06:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BBB24F39
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:05:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so8911141wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KerGvUzdejWLAwshDyy9ppWCWrJnFuYbHleK5z5lUU=;
        b=cOcyzI19J2bwcidkSWv6IYChVJ99SgUBngiNcjkB1r7bHy8FEb/EHmXmVgJy+39WrI
         5blmGvmfl/D2NUpaj/q6rfywpUvhhuYaegNRmMdTMEAW83+GcS/q+MqGBx1YpCQOBsNg
         qBuyuXLVhgf4djHOFJbgV2qsK4Rr46EOxdkXQ2MT5ZQCGfTQHhafDZXyOSHxPEScxAyi
         AHAWtXQTG4qcg6cG1349R17HfqlHyjtUo/gpO2yxSxyWvKDfKJAGLqnjcxNgQoeTQYLC
         gjv9XDsUSccvRe6OCe8NqKOiYZLID5sJXebE6y85t7ZjV/f+m8Ytib19LC1BoziJ20nl
         NXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KerGvUzdejWLAwshDyy9ppWCWrJnFuYbHleK5z5lUU=;
        b=3+rj5AYcEN15jygGuQYSJ7YWAh53JDg7q2AGEaQrh2enfofl9BCnc4ffi0Q6aR0Aqa
         xcaufC3DGolnPeV9iRdzJQI3jG2UvdofOenMCcdLgvpmLboombNumaUktdvaPWORRsIA
         Tqb+b4KA0zXMMeGxuuKQblsGH0A+RRvXT6FOTwNYdZ3GlXEz4XFgjNkn/IU0KGM/ghlx
         AaUpgKB5HyT3hQ/CwgwN414ihdLlZTDpHKPpq7ymbontkduup7d9FbqzssBTLhxvc0mh
         UhNcDVqiQGlkInkPp4mT5VPe6bUOW0kMkIPYrlCD5gF0H96onJL7shdZ5t8YcvatjLsg
         4Gkw==
X-Gm-Message-State: AJIora/v+SJA+O1Q3DGYXBuxSI54UT0Y9UYLGvsmIgutBFgefhyByLqG
        oupD1XOLWVbUES3e+ILVgMyTTA==
X-Google-Smtp-Source: AGRyM1tm3jF1Mm9yTBvcrOrrcNwguVUNZ62czBNqaQaZTtes5qap/g64RlerawH0KAvGyiXDXVAxDQ==
X-Received: by 2002:a1c:720f:0:b0:3a0:2ac9:5231 with SMTP id n15-20020a1c720f000000b003a02ac95231mr41272448wmc.39.1657098296950;
        Wed, 06 Jul 2022 02:04:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:56 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 23/33] crypto: rockchip: use the rk_crypto_info given as parameter
Date:   Wed,  6 Jul 2022 09:04:02 +0000
Message-Id: <20220706090412.806101-24-clabbe@baylibre.com>
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

Instead of using the crypto_info from TFM ctx, use the one given as parameter.

Reviewed-by: John Keeping <john@metanate.com>
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

