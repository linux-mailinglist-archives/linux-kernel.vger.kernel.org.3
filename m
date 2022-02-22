Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F94BF703
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiBVLMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiBVLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:12:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BE69CF5;
        Tue, 22 Feb 2022 03:11:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 48BFB1F43811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645528309;
        bh=cpo6vlQK830VyMFFPzoTFasodql+SY0NouJYyX3BTA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLJB3nEJV0eO8wE9mXnE+E4m0GRq/3YvxR+njd0TO7K6Tj2WEHul5B8WL7boh4WBB
         ytqcPLQjZP4grgF773QiT65nRPn1WKV7o9k7Jy+MjDZaZ30ejVgwza/MmFg8cT88mj
         E2h8GL20dYH3RnEQH1gWFO2OOtttZUlwY4yj4CKZVV2cjwZOZy+URAkQ1SJ+DoUQVQ
         MX1l3WvKJyncBcfBgWan0FuL/QNgInz/RNDzIPlqUHCPXtP6Z7W9oyg5RVDS8BfjTw
         weksthAj6uTWBUJ8HeZJls65N72FgL5fVNmaj865hq1KHSsScXvgq1GrL0eq4dO7NP
         /AgMGhGZnyscQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/5] pinctrl: mediatek: paris: Unify probe function by using OF match data
Date:   Tue, 22 Feb 2022 12:11:40 +0100
Message-Id: <20220222111144.20796-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
References: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
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

All of the SoCs using Paris pinctrl are defining a custom probe
function that is simply calling mtk_paris_pinctrl_probe() passing
a pointer to the SoC specific mtk_pin_soc structure and nothing else.

Simplify the probe mechanism across all pinctrl drivers that are
using pinctrl-paris by passing the specific mtk_pin_soc as match
data and using function mtk_paris_pinctrl_probe as a common probe
function for all of them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt6765.c | 9 ++-------
 drivers/pinctrl/mediatek/pinctrl-mt6779.c | 9 ++-------
 drivers/pinctrl/mediatek/pinctrl-mt6797.c | 9 ++-------
 drivers/pinctrl/mediatek/pinctrl-mt8183.c | 9 ++-------
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 9 ++-------
 drivers/pinctrl/mediatek/pinctrl-mt8195.c | 9 ++-------
 drivers/pinctrl/mediatek/pinctrl-paris.c  | 9 ++++++---
 drivers/pinctrl/mediatek/pinctrl-paris.h  | 3 +--
 8 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6765.c b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
index 2c59d3936256..c57b19fcda03 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6765.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
@@ -1082,21 +1082,16 @@ static const struct mtk_pin_soc mt6765_data = {
 };
 
 static const struct of_device_id mt6765_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt6765-pinctrl", },
+	{ .compatible = "mediatek,mt6765-pinctrl", .data = &mt6765_data },
 	{ }
 };
 
-static int mt6765_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_paris_pinctrl_probe(pdev, &mt6765_data);
-}
-
 static struct platform_driver mt6765_pinctrl_driver = {
 	.driver = {
 		.name = "mt6765-pinctrl",
 		.of_match_table = mt6765_pinctrl_of_match,
 	},
-	.probe = mt6765_pinctrl_probe,
+	.probe = mtk_paris_pinctrl_probe,
 };
 
 static int __init mt6765_pinctrl_init(void)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6779.c b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
index bb0851c73304..4ddf8bda6827 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6779.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
@@ -758,21 +758,16 @@ static const struct mtk_pin_soc mt6779_data = {
 };
 
 static const struct of_device_id mt6779_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt6779-pinctrl", },
+	{ .compatible = "mediatek,mt6779-pinctrl", .data = &mt6779_data },
 	{ }
 };
 
-static int mt6779_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_paris_pinctrl_probe(pdev, &mt6779_data);
-}
-
 static struct platform_driver mt6779_pinctrl_driver = {
 	.driver = {
 		.name = "mt6779-pinctrl",
 		.of_match_table = mt6779_pinctrl_of_match,
 	},
-	.probe = mt6779_pinctrl_probe,
+	.probe = mtk_paris_pinctrl_probe,
 };
 
 static int __init mt6779_pinctrl_init(void)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6797.c b/drivers/pinctrl/mediatek/pinctrl-mt6797.c
index adebe4333ed9..53f240491259 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6797.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6797.c
@@ -58,21 +58,16 @@ static const struct mtk_pin_soc mt6797_data = {
 };
 
 static const struct of_device_id mt6797_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt6797-pinctrl", },
+	{ .compatible = "mediatek,mt6797-pinctrl", .data = &mt6797_data },
 	{ }
 };
 
-static int mt6797_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_paris_pinctrl_probe(pdev, &mt6797_data);
-}
-
 static struct platform_driver mt6797_pinctrl_driver = {
 	.driver = {
 		.name = "mt6797-pinctrl",
 		.of_match_table = mt6797_pinctrl_of_match,
 	},
-	.probe = mt6797_pinctrl_probe,
+	.probe = mtk_paris_pinctrl_probe,
 };
 
 static int __init mt6797_pinctrl_init(void)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 60318339b618..fecb1e64fff4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -567,22 +567,17 @@ static const struct mtk_pin_soc mt8183_data = {
 };
 
 static const struct of_device_id mt8183_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt8183-pinctrl", },
+	{ .compatible = "mediatek,mt8183-pinctrl", .data = &mt8183_data },
 	{ }
 };
 
-static int mt8183_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_paris_pinctrl_probe(pdev, &mt8183_data);
-}
-
 static struct platform_driver mt8183_pinctrl_driver = {
 	.driver = {
 		.name = "mt8183-pinctrl",
 		.of_match_table = mt8183_pinctrl_of_match,
 		.pm = &mtk_paris_pinctrl_pm_ops,
 	},
-	.probe = mt8183_pinctrl_probe,
+	.probe = mtk_paris_pinctrl_probe,
 };
 
 static int __init mt8183_pinctrl_init(void)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 0c16b2c756bf..acccde9262ba 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1381,22 +1381,17 @@ static const struct mtk_pin_soc mt8192_data = {
 };
 
 static const struct of_device_id mt8192_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt8192-pinctrl", },
+	{ .compatible = "mediatek,mt8192-pinctrl", .data = &mt8192_data },
 	{ }
 };
 
-static int mt8192_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_paris_pinctrl_probe(pdev, &mt8192_data);
-}
-
 static struct platform_driver mt8192_pinctrl_driver = {
 	.driver = {
 		.name = "mt8192-pinctrl",
 		.of_match_table = mt8192_pinctrl_of_match,
 		.pm = &mtk_paris_pinctrl_pm_ops,
 	},
-	.probe = mt8192_pinctrl_probe,
+	.probe = mtk_paris_pinctrl_probe,
 };
 
 static int __init mt8192_pinctrl_init(void)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8195.c b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
index 275b7ba4386d..563693d3d4c2 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8195.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
@@ -959,22 +959,17 @@ static const struct mtk_pin_soc mt8195_data = {
 };
 
 static const struct of_device_id mt8195_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt8195-pinctrl", },
+	{ .compatible = "mediatek,mt8195-pinctrl", .data = &mt8195_data },
 	{ }
 };
 
-static int mt8195_pinctrl_probe(struct platform_device *pdev)
-{
-	return mtk_paris_pinctrl_probe(pdev, &mt8195_data);
-}
-
 static struct platform_driver mt8195_pinctrl_driver = {
 	.driver = {
 		.name = "mt8195-pinctrl",
 		.of_match_table = mt8195_pinctrl_of_match,
 		.pm = &mtk_paris_pinctrl_pm_ops,
 	},
-	.probe = mt8195_pinctrl_probe,
+	.probe = mtk_paris_pinctrl_probe,
 };
 
 static int __init mt8195_pinctrl_init(void)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 784eb152b637..6d9e4d625517 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -1036,8 +1036,7 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
 	return 0;
 }
 
-int mtk_paris_pinctrl_probe(struct platform_device *pdev,
-			    const struct mtk_pin_soc *soc)
+int mtk_paris_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pins;
@@ -1049,7 +1048,11 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, hw);
-	hw->soc = soc;
+
+	hw->soc = device_get_match_data(dev);
+	if (!hw->soc)
+		return -ENOENT;
+
 	hw->dev = &pdev->dev;
 
 	if (!hw->soc->nbase_names)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.h b/drivers/pinctrl/mediatek/pinctrl-paris.h
index afb7650fd25b..8762ac599329 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.h
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.h
@@ -57,8 +57,7 @@
 		id##_funcs,				\
 	}
 
-int mtk_paris_pinctrl_probe(struct platform_device *pdev,
-			    const struct mtk_pin_soc *soc);
+int mtk_paris_pinctrl_probe(struct platform_device *pdev);
 
 ssize_t mtk_pctrl_show_one_pin(struct mtk_pinctrl *hw,
 	unsigned int gpio, char *buf, unsigned int bufLen);
-- 
2.33.1

