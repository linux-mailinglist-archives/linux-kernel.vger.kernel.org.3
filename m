Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B74EFB69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352518AbiDAUXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352225AbiDAUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:21:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA327545F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f6-20020a1c3806000000b0038e4a0fc5easo2142216wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKC9BF4dXA1G634QoNLIKuQnuaNkW3/UOb3sMC/u5kY=;
        b=tICJ0RLoEBdT1RLJeSR2Qdmj0wSFyJNAkSICQ0VllNB5Pumz6HvKWt/nlnUoOOyI+u
         LSJQBev6GcooY+39S0jfbxZSikrx7RdpcDJgOVxNl11DyqCKdq4XUOkbLUdnEoxBQN/L
         wkugfBBvIyLoyiGAOpxI4IfbyPRECIXlF84FEOrImvkENev2lCMLDatubNZk020hsPi4
         t3JClCEV0/rYD5t6GK9X4VPEgEurgUNxuPBsrrtAnXW1ioFCJ7+jgkSelGySQxjUDX1r
         06jm3Tc3YbSxVMbKejWmGO8LctlXaN+jkTqwhQn1K3kg2Bdlxy6M0vJVdnoJ6uuUBUAf
         m+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKC9BF4dXA1G634QoNLIKuQnuaNkW3/UOb3sMC/u5kY=;
        b=KbV6dmMvcIW61Eq/GHChPXW6yWdbrgF5q8il48dy+RHgKTnbssPGs7+VXUYKSb9hAN
         Sr/4oLNtWWDrolCsGhkgVAMvqhsrCed83nDDzZK5QFElT71hv0r85/ljNQLLTYHnGk+K
         4RZwqJ1Uj5NFqmDS5azBAiQklAIVPveK9L5C5+lV9wtZ77gmp/TYC7wB1cWu2Db4jIws
         1HyPoo+aGA2H/NGnrU581qOWbrCfLOUXpERJzSYciM00NbbjPGPY+1QR0JCTOiJfNEY4
         JlYSojhBM9pqlgwn/q87oKl5q+8DCnKdcMHibfLMEsEPBS3Nmi4WL3WlXOaAESrfzJPe
         LUbQ==
X-Gm-Message-State: AOAM532uynyLLihYwdL/fSlbVwjM4iYXE43ifNFLOOQrDv4qvrsXQRz7
        O5XggDd6SBcrDeTpwLQBtFOuaA==
X-Google-Smtp-Source: ABdhPJzBjRPNRhqYPjIRRftpKO82O6trPepqmMbG4DH3r7zywq41QfkZv3g3CDZwixcv1zGNRXgMGQ==
X-Received: by 2002:a05:600c:21a:b0:38b:d06e:e0f7 with SMTP id 26-20020a05600c021a00b0038bd06ee0f7mr9809753wmi.105.1648844307626;
        Fri, 01 Apr 2022 13:18:27 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:27 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 23/33] crypto: rockchip: use the rk_crypto_info given as parameter
Date:   Fri,  1 Apr 2022 20:17:54 +0000
Message-Id: <20220401201804.2867154-24-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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
index 9e2935716840..9784b25e64ce 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -264,7 +264,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 			     RK_CRYPTO_TDES_BYTESWAP_KEY |
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
 		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -276,7 +276,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
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

