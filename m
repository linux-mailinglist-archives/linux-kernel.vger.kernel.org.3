Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD0350EA20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbiDYU0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245279AbiDYUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:25:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA641299E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e24so2604976wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2uYJa2gxIdaD8fQBCxMjwb6E0s7Z3esdAlzwfZv714=;
        b=stsFLy+KyOnT4KHOXtZxRdSYL2fSyBm3x6cA+JZYRHkNhRTyz8ucwn+s7Eh207juoR
         N0KkARPD0vTa456iXV+8QfbMrirJ+62MqkePK8zps+f55qwDmSDTS6TU0fKDPjTfB2S0
         Prn0eQPV7VUJOPsYIXhZ18klUgNTJcsERWUitSCNEgaEZeF8zkQRNuKXqAqOfDX4q8GD
         3VxuVcV+grX73stEfCGS0rJDmeL9PGPPlpBIlGzg4/Ne+nQUef/AtZzf8lXyDI8ybqWP
         iiMzWkvEA2zSpF2caeLLxlE8S7oZSvoZUY4tCMi0Fju4clnN6pL6p2pb2fhQ6UjqSyHd
         opDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2uYJa2gxIdaD8fQBCxMjwb6E0s7Z3esdAlzwfZv714=;
        b=l+4S3nMODJufAaWLgjBKvbT186UgoQAAfwIwtuWW1kBTfzfA2DBJyhmUIGRjGhS5QK
         E/43/IWMa2mEHKD0sb6VwsUfUlVkFNith9QqIilK3siytlf8wPkiIClNn4BSDGmPncTW
         mGP6SRzjMbOgg4SK4samakiaNyyJVH/PeFzm/LnwUjhv+2t2nCJ+eJCn6nXpvt0OwmBB
         0kVxioELJ/F7jleFuUAkIODz1HTglWYHUT1hb+cz30bmg0cxFluTQVSW8v46o7ONidw2
         p8VlYDb8/lJe9UVg5eZBCne1RVXi9lUw4VA0zZ8fltY1XY3Xu2wND61qA1PRtgM38wHY
         tpdw==
X-Gm-Message-State: AOAM5338jAkS3ekVONAaTBbkV2fIddtSxvZFe2Gz9M1rzgxZN5IpvsJA
        rP6oRwrZctVESm5iHUl/rUitwQ==
X-Google-Smtp-Source: ABdhPJyNQGAAcf86MjoKCDR2ng3p/kvOBGPAsnv1tbS/EgJYReKbwS+MiWO21XGDWnrPB5oganTm2Q==
X-Received: by 2002:a5d:47cf:0:b0:20a:a5f0:eab9 with SMTP id o15-20020a5d47cf000000b0020aa5f0eab9mr14943772wrc.369.1650918109751;
        Mon, 25 Apr 2022 13:21:49 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:49 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 23/33] crypto: rockchip: use the rk_crypto_info given as parameter
Date:   Mon, 25 Apr 2022 20:21:09 +0000
Message-Id: <20220425202119.3566743-24-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

