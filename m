Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B810A568289
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiGFJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiGFJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:05:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0524BCA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk26so5988425wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGbdJwhNtYNfg6qIard96SGzNtmQLkXSB3qcyDfr1D0=;
        b=gm0KhrhBhAvk1tfsnOGMz6wra9Y+oeNBjeba+VWedHQ1UHOgbxpAe4LFPDlUaxPqrs
         8rY3aJf6geSq7/4QDfQac2ydBq8/0UOd9Dg1hB9jTv8DqsQLhGproaiZbYW+8TGZ/KTg
         /kUyJsmfSig9d3Pw1cRz7WFr7bDZJ62YOonLu3BpwE7VrewVppQo4QTEaBl8Ee80XnvP
         edD55QxtgY54jNehTdtmI3YMApuaxf5olBUlh6AJ4xfrveDlwFDYRXejtm89MgLaIj+Z
         TpZmTqBzHpU2xbi5l56oBPcj/KhHrMO8hreMhRkxEV7Sx7/JUZC08F4UCHZWeuvUBr5h
         EbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGbdJwhNtYNfg6qIard96SGzNtmQLkXSB3qcyDfr1D0=;
        b=nV9iUmnEfhw2AwWoOa3i8wH4/Chwfx4h2kNMNY56mrcxwq+xbRx6yDEHfRgQPtgxji
         Jm5LbNZ5OUWmlmM05DvAEzoXt93YFOVPruv4SO/0S0JKiUvMgT9JDP6BN14IkxtCLzMj
         BG3pVZWMkcT9TetB9CX5CuUrWg+SjYo9vpDa6wfJDIaax6mXsbSNdJdJHkAu2qbze0ln
         oOZE86HC1fTPZGiD1xyXsGKBZtmCeH2rFtUp4NIdpLkWAsq879M414azHSAHrb406ScD
         owmFroJUteh4uQ5bVOGLc+8yQoCS+YvSGxiK/iTJyE414RMY982HaWTyJHVfEVUv09/h
         WPVg==
X-Gm-Message-State: AJIora/DO2DxUyDgCAIDWtVY4ayKtU00qE06riNM8HUKmyYNxM1btpb3
        xyIuRKU1eBE2HyBcaEVHtW01qQ==
X-Google-Smtp-Source: AGRyM1sp1cGtTs7HtYrnntFH8WN9VXQNVfvKy2ZfLC7LeqIDohbIK8azWU+UPDvtgEh1Mr//Z+4FxQ==
X-Received: by 2002:adf:db12:0:b0:21b:970b:e882 with SMTP id s18-20020adfdb12000000b0021b970be882mr37315917wri.6.1657098289008;
        Wed, 06 Jul 2022 02:04:49 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 15/33] crypto: rockchip: use clk_bulk to simplify clock management
Date:   Wed,  6 Jul 2022 09:03:54 +0000
Message-Id: <20220706090412.806101-16-clabbe@baylibre.com>
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

rk3328 does not have the same clock names than rk3288, instead of using a complex
clock management, let's use clk_bulk to simplify their handling.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 66 ++++---------------------
 drivers/crypto/rockchip/rk3288_crypto.h |  6 +--
 2 files changed, 11 insertions(+), 61 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 399829ef92e0..a635029ac71d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -22,47 +22,16 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 {
 	int err;
 
-	err = clk_prepare_enable(dev->sclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock sclk\n",
-			__func__, __LINE__);
-		goto err_return;
-	}
-	err = clk_prepare_enable(dev->aclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock aclk\n",
-			__func__, __LINE__);
-		goto err_aclk;
-	}
-	err = clk_prepare_enable(dev->hclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock hclk\n",
-			__func__, __LINE__);
-		goto err_hclk;
-	}
-	err = clk_prepare_enable(dev->dmaclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock dmaclk\n",
-			__func__, __LINE__);
-		goto err_dmaclk;
-	}
-	return err;
-err_dmaclk:
-	clk_disable_unprepare(dev->hclk);
-err_hclk:
-	clk_disable_unprepare(dev->aclk);
-err_aclk:
-	clk_disable_unprepare(dev->sclk);
-err_return:
+	err = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
+	if (err)
+		dev_err(dev->dev, "Could not enable clock clks\n");
+
 	return err;
 }
 
 static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
 {
-	clk_disable_unprepare(dev->dmaclk);
-	clk_disable_unprepare(dev->hclk);
-	clk_disable_unprepare(dev->aclk);
-	clk_disable_unprepare(dev->sclk);
+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 }
 
 /*
@@ -266,27 +235,10 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->aclk = devm_clk_get(&pdev->dev, "aclk");
-	if (IS_ERR(crypto_info->aclk)) {
-		err = PTR_ERR(crypto_info->aclk);
-		goto err_crypto;
-	}
-
-	crypto_info->hclk = devm_clk_get(&pdev->dev, "hclk");
-	if (IS_ERR(crypto_info->hclk)) {
-		err = PTR_ERR(crypto_info->hclk);
-		goto err_crypto;
-	}
-
-	crypto_info->sclk = devm_clk_get(&pdev->dev, "sclk");
-	if (IS_ERR(crypto_info->sclk)) {
-		err = PTR_ERR(crypto_info->sclk);
-		goto err_crypto;
-	}
-
-	crypto_info->dmaclk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(crypto_info->dmaclk)) {
-		err = PTR_ERR(crypto_info->dmaclk);
+	crypto_info->num_clks = devm_clk_bulk_get_all(&pdev->dev,
+						      &crypto_info->clks);
+	if (crypto_info->num_clks < 3) {
+		err = -EINVAL;
 		goto err_crypto;
 	}
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index ddbb9246ce16..28bf09fe1c1d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -190,10 +190,8 @@
 
 struct rk_crypto_info {
 	struct device			*dev;
-	struct clk			*aclk;
-	struct clk			*hclk;
-	struct clk			*sclk;
-	struct clk			*dmaclk;
+	struct clk_bulk_data		*clks;
+	int num_clks;
 	struct reset_control		*rst;
 	void __iomem			*reg;
 	int				irq;
-- 
2.35.1

