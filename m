Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02B4C78EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiB1TsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiB1Trq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:47:46 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599392023BD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:46:01 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id b5so17153603wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mq94Dr5+JVccORut3g3YoAFCHNwJha9oYdYCZSmtj94=;
        b=15smI5CSaP0Zrj3xaQZQf+DZcj7sJcUvEGVixTMllyC0+17NwDBnX1yDzL0G8A3RMz
         JxsYzQMVj83p6RnrNOkbvb1mjyRd/XReb0l1vHOE5+LZmTKTJ2jlIW/Eq/FBAUPaNrGV
         mC7ruGFt3FlrzSQW2vtji5cxIXmmbmopkMkPNVUnPxXjP8B3x3nfJxwOhE3qJ8xi60bN
         eLPKMfiawx26wTTR9MtlgCfNWudyjLUyx4JOjYFV9nDwtra5p12oxQQPbYHxtN239YSQ
         ysS6bDXjFTwQMjyB/YkEeL3kPYon8daCYnwHohQWnU6ibA6TKJ4aDvoL9UUulW1H5vNG
         APTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mq94Dr5+JVccORut3g3YoAFCHNwJha9oYdYCZSmtj94=;
        b=YPpOZ2uMWxiwNQiwjvvWSmUd9z4Yhv9TshZWiJQe6dA6xUfKQpzTCfjrQHYHwnEvLi
         00V6VEJfczMtLc2vKJ+6QpQgeKgbxwNDmDy1Cu4hEwQ2WUqhHBjKyDaQ7Yrb+eevL77p
         Vqu9Lg0X7/D6OMupYtEhiwHAOE715g4zvkkOdVvYvcThP/VZI19Ozycw0mRtFkSezAgJ
         bYmwIWKWn88L+rXoZHFX03Lf+a8W8nZPy2U9DAjOj2yuvWjKGf4wNTOnBcEqn/Rg+cP1
         nqOu+jYi0R6mvPHrAHEfE30oiy5cDHWM9sHtimUNCQ0Xr8Lt52nqj9zOfgG1lkFjuEXD
         2M9Q==
X-Gm-Message-State: AOAM530h77LXrnlxFzLvDVv6dJnSqlRvSE3wC4ynzwfVcHabO7xsXXKU
        Pr98XfNQewadlECt2hMHpbOzFg==
X-Google-Smtp-Source: ABdhPJwZg11V8F1Kup6pt6wHNQPpNk/myS5kvvKb0nY3uqpqJek1arz6rT4spkUayXGNIeeF0wq6oQ==
X-Received: by 2002:a05:6000:c8:b0:1ef:7e4a:e3a1 with SMTP id q8-20020a05600000c800b001ef7e4ae3a1mr10429876wrx.452.1646077251620;
        Mon, 28 Feb 2022 11:40:51 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:51 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 11/16] crypto: rockhip: do not handle dma clock
Date:   Mon, 28 Feb 2022 19:40:32 +0000
Message-Id: <20220228194037.1600509-12-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA clock is handled by the DMA controller, so the crypto does not
have to touch it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 16 +---------------
 drivers/crypto/rockchip/rk3288_crypto.h |  1 -
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 94ef1283789f..645855d2651b 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -40,15 +40,8 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 			__func__, __LINE__);
 		goto err_hclk;
 	}
-	err = clk_prepare_enable(dev->dmaclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock dmaclk\n",
-			__func__, __LINE__);
-		goto err_dmaclk;
-	}
+
 	return err;
-err_dmaclk:
-	clk_disable_unprepare(dev->hclk);
 err_hclk:
 	clk_disable_unprepare(dev->aclk);
 err_aclk:
@@ -59,7 +52,6 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 
 static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
 {
-	clk_disable_unprepare(dev->dmaclk);
 	clk_disable_unprepare(dev->hclk);
 	clk_disable_unprepare(dev->aclk);
 	clk_disable_unprepare(dev->sclk);
@@ -199,12 +191,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->dmaclk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(crypto_info->dmaclk)) {
-		err = PTR_ERR(crypto_info->dmaclk);
-		goto err_crypto;
-	}
-
 	crypto_info->irq = platform_get_irq(pdev, 0);
 	if (crypto_info->irq < 0) {
 		dev_err(&pdev->dev, "control Interrupt is not available.\n");
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index c741e97057dc..963fbfc4d14e 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -191,7 +191,6 @@ struct rk_crypto_info {
 	struct clk			*aclk;
 	struct clk			*hclk;
 	struct clk			*sclk;
-	struct clk			*dmaclk;
 	struct reset_control		*rst;
 	void __iomem			*reg;
 	int				irq;
-- 
2.34.1

