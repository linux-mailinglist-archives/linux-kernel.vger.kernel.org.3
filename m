Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F84B101C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiBJOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:19:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiBJOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:19:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8ACF9;
        Thu, 10 Feb 2022 06:19:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7D17A1F4656E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644502778;
        bh=n8CGqf0yuDMBl0AcIjnWSW/xsE0lZFScDerKAcE+A7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gad6W7Ew1fVLAM3hq6/Ky7hnUp7hlPAFKvhC25rQNx3rOZUAY3j9pTP4bAq8vkihc
         fd3QS/eFV7iN2TSBXUPZVpXE7A3tcre6pC+zJdpLufIfz+yYpGJWOY41gKo1kBZUj2
         3vIejAXc8ezkRiHuBUGgB6tGPHyGhCndqy/o65ytldcjeOh0zfu6qV0XRDJnjvv2wz
         TvQdzpT77/r9eKGhscKxM056jpFEyxdhcpdSOiD/WRYMRCmHUm+m7ixCRlrO5N34Aa
         u7SprP+fRMPfXafBTYAFfz/07XPSP44kkWMOw4fLEPlglzHg1T36M1rX6Hap0UboOw
         eAzCIWuN8MXRw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/5] pinctrl: mediatek: common-v1: Use common probe function
Date:   Thu, 10 Feb 2022 15:19:29 +0100
Message-Id: <20220210141931.291712-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the mediatek pinctrl drivers are calling mtk_pctrl_init() and
passing only a pointer to struct mtk_pinctrl_devdata, as the regmap
handle it passed from device-tree, with the exception of mt6397.

For all of the drivers that don't require passing a struct regmap
pointer from a parent device, simplify the probe mechanism by assigning
the required structure as match data and use mtk_pctrl_common_probe()
as their probe function.

While at it, also collapse the of_device_id entries to a single line,
as they all fit in max 83 columns, which is acceptable.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt2701.c | 11 +++--------
 drivers/pinctrl/mediatek/pinctrl-mt2712.c | 11 ++---------
 drivers/pinctrl/mediatek/pinctrl-mt8127.c |  9 ++-------
 drivers/pinctrl/mediatek/pinctrl-mt8135.c | 11 ++---------
 drivers/pinctrl/mediatek/pinctrl-mt8167.c | 11 ++---------
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 11 ++---------
 drivers/pinctrl/mediatek/pinctrl-mt8516.c | 11 ++---------
 7 files changed, 15 insertions(+), 60 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index 37228dd5103e..2f8821207395 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -534,20 +534,15 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 	},
 };
 
-static int mt2701_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt2701_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt2701_pctrl_match[] = {
-	{ .compatible = "mediatek,mt2701-pinctrl", },
-	{ .compatible = "mediatek,mt7623-pinctrl", },
+	{ .compatible = "mediatek,mt2701-pinctrl", .data = &mt2701_pinctrl_data },
+	{ .compatible = "mediatek,mt7623-pinctrl", .data = &mt2701_pinctrl_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt2701_pctrl_match);
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mt2701_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt2701-pinctrl",
 		.of_match_table = mt2701_pctrl_match,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index ba35fc6cc138..03aa14445034 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -587,21 +587,14 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 	},
 };
 
-static int mt2712_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt2712_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt2712_pctrl_match[] = {
-	{
-		.compatible = "mediatek,mt2712-pinctrl",
-	},
+	{ .compatible = "mediatek,mt2712-pinctrl", .data = &mt2712_pinctrl_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mt2712_pctrl_match);
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mt2712_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt2712-pinctrl",
 		.of_match_table = mt2712_pctrl_match,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index eaf5c76b14c7..76cb525374f2 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -303,18 +303,13 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 	},
 };
 
-static int mt8127_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt8127_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt8127_pctrl_match[] = {
-	{ .compatible = "mediatek,mt8127-pinctrl", },
+	{ .compatible = "mediatek,mt8127-pinctrl", .data = &mt8127_pinctrl_data },
 	{ }
 };
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mt8127_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt8127-pinctrl",
 		.of_match_table = mt8127_pctrl_match,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index b8f4080aab45..4c20b79dec67 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -316,20 +316,13 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 	},
 };
 
-static int mt8135_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt8135_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt8135_pctrl_match[] = {
-	{
-		.compatible = "mediatek,mt8135-pinctrl",
-	},
+	{ .compatible = "mediatek,mt8135-pinctrl", .data = &mt8135_pinctrl_data },
 	{ }
 };
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mt8135_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt8135-pinctrl",
 		.of_match_table = mt8135_pctrl_match,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8167.c b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
index ba12ef795e52..08aabf408c9c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8167.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
@@ -335,22 +335,15 @@ static const struct mtk_pinctrl_devdata mt8167_pinctrl_data = {
 	},
 };
 
-static int mt8167_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt8167_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt8167_pctrl_match[] = {
-	{
-		.compatible = "mediatek,mt8167-pinctrl",
-	},
+	{ .compatible = "mediatek,mt8167-pinctrl", .data = &mt8167_pinctrl_data },
 	{}
 };
 
 MODULE_DEVICE_TABLE(of, mt8167_pctrl_match);
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mt8167_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt8167-pinctrl",
 		.of_match_table = mt8167_pctrl_match,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 79b1fee5a1eb..6863a8150a2b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -469,20 +469,13 @@ static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 	},
 };
 
-static int mtk_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt8365_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt8365_pctrl_match[] = {
-	{
-		.compatible = "mediatek,mt8365-pinctrl",
-	},
+	{ .compatible = "mediatek,mt8365-pinctrl", .data = &mt8365_pinctrl_data },
 	{}
 };
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mtk_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt8365-pinctrl",
 		.of_match_table = mt8365_pctrl_match,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 219fb4bc341f..99c1a04c7fd8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -335,22 +335,15 @@ static const struct mtk_pinctrl_devdata mt8516_pinctrl_data = {
 	},
 };
 
-static int mt8516_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_pctrl_init(pdev, &mt8516_pinctrl_data, NULL);
-}
-
 static const struct of_device_id mt8516_pctrl_match[] = {
-	{
-		.compatible = "mediatek,mt8516-pinctrl",
-	},
+	{ .compatible = "mediatek,mt8516-pinctrl", .data = &mt8516_pinctrl_data },
 	{}
 };
 
 MODULE_DEVICE_TABLE(of, mt8516_pctrl_match);
 
 static struct platform_driver mtk_pinctrl_driver = {
-	.probe = mt8516_pinctrl_probe,
+	.probe = mtk_pctrl_common_probe,
 	.driver = {
 		.name = "mediatek-mt8516-pinctrl",
 		.of_match_table = mt8516_pctrl_match,
-- 
2.33.1

