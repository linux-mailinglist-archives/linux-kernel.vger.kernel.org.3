Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9644B101D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbiBJOTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:19:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbiBJOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:19:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CCF9;
        Thu, 10 Feb 2022 06:19:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 242C31F46564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644502776;
        bh=zG0bldBWB2nx02kMBfqhQzYNwC5linFfUnYedSv8FaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxqmqOSsefZzZGq90wPl9wLr3zJokFwvL2I/V0TceAKt8PC/ES67xF49aiJkz601R
         KdsdTFSIgvy6ufY85glDTHDa6F25wtIlx5oqJOFDzcWur7TKVx+woUmNINkdPxXu+X
         /xiBehiki0o7MELMOcdMpuwToodQDsedC5PrAPvBcXSuXNyXr9kGkKO07yg0Rxn3cb
         ccCPwYADesGDSgYFrxMjMw8d0uEiJdWrdklIYWznosOM57JLI72QMuRizay9vOlFbc
         l7oUrMY/syUO0RHkuAFEDShzuwSNW4sVBmLdhZ2QcqwxndKcWN+WCZL3nrqcKU696x
         7ZQG2Xx3pGbow==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/5] pinctrl: mediatek: paris: Unify probe function by using OF match data
Date:   Thu, 10 Feb 2022 15:19:27 +0100
Message-Id: <20220210141931.291712-2-angelogioacchino.delregno@collabora.com>
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

All of the SoCs using Paris pinctrl are defining a custom probe
function that is simply calling mtk_paris_pinctrl_probe() passing
a pointer to the SoC specific mtk_pin_soc structure and nothing else.

Simplify the probe mechanism across all pinctrl drivers that are
using pinctrl-paris by passing the specific mtk_pin_soc as match
data and using function mtk_paris_pinctrl_probe as a common probe
function for all of them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

