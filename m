Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039151EF95
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353849AbiEHTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiEHTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24334DF9F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so7165263wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p55H6E0886aSJalxirRbnL3xLKJ1MG4FEZeIU1Ksblw=;
        b=2vJGbwuHq3z17pFeF/VweArXe7B3FzgT63BrhhCU6Jnmucs+m+SFIHOlWHAOo6kXcC
         Bl860cTlfd86nDGpqACGyWTcvFk6k2W4hZKpTKYLpvxkHIw/U4TzdZ0l9ZuXkR/9SUcr
         BT92+XYetcE1Drm4DNakqx5HfcTGbiwXStMUa3Ij2/+w25OLnRKc6mbNFKSF+B5EE+bc
         MLXPlvDhiVBj7G5Wx1kVdpFZ9eonLlLU2NmHS8FNxzP1FanNKuB/oAezsbNnGU/pZ8O1
         9YklNCzavnJxqHjwqDMGyy2d4eCkRFCF8DLZZ7zdIYJztaaM0o2Vh7pj/s1hsOsCstsm
         2B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p55H6E0886aSJalxirRbnL3xLKJ1MG4FEZeIU1Ksblw=;
        b=65TAwGzrTDpWP8n8Uu4Pkl3zaB5K1x3xp6t0LspLyjKSgvDZJMEXBIRaHItFxY6c5L
         ZukQcZanRYaWxdk2UfAi0FuVnH6JxCtLGRWcE+W1O0R9TXBDJZfQswsbXf1P8xdroZwV
         SG8XmmvFMgQCU45vmxcVkKWxAgEZKS5h9gsdC0d3BQu1Wg008j5UNdTmJD3Gv9k8Y5DA
         WLHD0Qg7/crogrYlw0Lqnl+n02LDTHrmMv1NdYuy/89oRrIXQOIqanvvHyTTwPoGYnDY
         sVuqZ/hehXJ2FCkVyz7qqbfxuqbfd+F422u+ZBmCJvosddOfrvYq+d1dUmjwu19yNSfL
         fSIQ==
X-Gm-Message-State: AOAM533G6XiURPnXhCKQeZlZ4atv4T6jeh2OFribBvORdZ6iz1cpuStB
        09/UP29Su3oAbWRHNA/6qanDsw==
X-Google-Smtp-Source: ABdhPJzzvgLkbGuhcyCd2x6HCV/pNl87JDJxeHc5Ht5BG2t3OnC5JvSp21Q14n4whAdNk8PpHa/DCw==
X-Received: by 2002:a05:600c:3658:b0:394:725:be12 with SMTP id y24-20020a05600c365800b003940725be12mr12875186wmq.192.1652036419689;
        Sun, 08 May 2022 12:00:19 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 14/33] crypto: rockchip: handle reset also in PM
Date:   Sun,  8 May 2022 18:59:38 +0000
Message-Id: <20220508185957.3629088-15-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

reset could be handled by PM functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index d9258b9e71b3..a11a92e1f3fd 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -73,6 +73,8 @@ static int rk_crypto_pm_suspend(struct device *dev)
 {
 	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
 
+	reset_control_assert(rkdev->rst);
+
 	rk_crypto_disable_clk(rkdev);
 	return 0;
 }
@@ -81,6 +83,8 @@ static int rk_crypto_pm_resume(struct device *dev)
 {
 	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
 
+	reset_control_deassert(rkdev->rst);
+
 	return rk_crypto_enable_clk(rkdev);
 }
 
@@ -222,13 +226,6 @@ static void rk_crypto_unregister(void)
 	}
 }
 
-static void rk_crypto_action(void *data)
-{
-	struct rk_crypto_info *crypto_info = data;
-
-	reset_control_assert(crypto_info->rst);
-}
-
 static const struct of_device_id crypto_of_id_table[] = {
 	{ .compatible = "rockchip,rk3288-crypto" },
 	{}
@@ -254,14 +251,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	reset_control_assert(crypto_info->rst);
-	usleep_range(10, 20);
-	reset_control_deassert(crypto_info->rst);
-
-	err = devm_add_action_or_reset(dev, rk_crypto_action, crypto_info);
-	if (err)
-		goto err_crypto;
-
 	crypto_info->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(crypto_info->reg)) {
 		err = PTR_ERR(crypto_info->reg);
-- 
2.35.1

