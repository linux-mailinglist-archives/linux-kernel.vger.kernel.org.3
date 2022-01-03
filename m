Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EA482FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiACKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:19:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45984 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiACKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:19:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A2B1D1F41DBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641205145;
        bh=NBhQzC7OMqyb+Ilc8knTIcL9ykR6cUFQIBi62GPatTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kg9l0L1xijTRbQcpXp1auJkQF/p+KGv9DH8hFUCnOKkMDzhB/D9jVdYiFne3fc/TZ
         uDKLjMOfpSLdGpgUvcQeC4YmEQvdmzlL2XaFN4PlBOVClWkZiFtOXqQ80qrs/B81Bu
         itSNt17yWQwHB+BsPpTkD6XEq53wi/sPvpq6kQZzzBVqc6Z4UeOP0XJQudt13k1Gkh
         285O+rMvz9Tf34P6fDAYD2Ru79C3FGkpKEf6imp65NyYtdJYKgK9XJ6YokRh+/hH/t
         lOivoEsXVAhF1kmHgBsL0knDvZxt6Caee52XaxWn8ckq6h8QnIwwliyS8Bna8aRrBw
         l5wkfym7S8v1A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/3] pinctrl: mediatek: pinctrl-mtk-common: Simplify with dev_err_probe()
Date:   Mon,  3 Jan 2022 11:18:55 +0100
Message-Id: <20220103101855.17350-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com>
References: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev_err_probe() helper to simplify error handling during probe.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 5f7c421ab6e7..6f8dfa6ae5a0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1013,10 +1013,12 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 	return mtk_eint_do_init(pctl->eint);
 }
 
+/* This is used as a common probe function */
 int mtk_pctrl_init(struct platform_device *pdev,
 		const struct mtk_pinctrl_devdata *data,
 		struct regmap *regmap)
 {
+	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pins;
 	struct mtk_pinctrl *pctl;
 	struct device_node *np = pdev->dev.of_node, *node;
@@ -1030,10 +1032,9 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, pctl);
 
 	prop = of_find_property(np, "pins-are-numbered", NULL);
-	if (!prop) {
-		dev_err(&pdev->dev, "only support pins-are-numbered format\n");
-		return -EINVAL;
-	}
+	if (!prop)
+		return dev_err_probe(dev, -EINVAL,
+				     "only support pins-are-numbered format\n");
 
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
 	if (node) {
@@ -1043,8 +1044,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	} else if (regmap) {
 		pctl->regmap1  = regmap;
 	} else {
-		dev_err(&pdev->dev, "Pinctrl node has not register regmap.\n");
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "Cannot find pinctrl regmap.\n");
 	}
 
 	/* Only 8135 has two base addr, other SoCs have only one. */
@@ -1057,10 +1057,8 @@ int mtk_pctrl_init(struct platform_device *pdev,
 
 	pctl->devdata = data;
 	ret = mtk_pctrl_build_state(pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "build state failed: %d\n", ret);
-		return -EINVAL;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "build state failed\n");
 
 	pins = devm_kcalloc(&pdev->dev, pctl->devdata->npins, sizeof(*pins),
 			    GFP_KERNEL);
@@ -1081,10 +1079,9 @@ int mtk_pctrl_init(struct platform_device *pdev,
 
 	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, &pctl->pctl_desc,
 					       pctl);
-	if (IS_ERR(pctl->pctl_dev)) {
-		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
-		return PTR_ERR(pctl->pctl_dev);
-	}
+	if (IS_ERR(pctl->pctl_dev))
+		return dev_err_probe(dev, PTR_ERR(pctl->pctl_dev),
+				     "Couldn't register pinctrl driver\n");
 
 	pctl->chip = devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL);
 	if (!pctl->chip)
-- 
2.33.1

