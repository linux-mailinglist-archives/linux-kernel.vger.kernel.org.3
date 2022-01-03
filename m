Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678FE482FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiACKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:19:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45956 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiACKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:19:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 76E7F1F41D81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641205143;
        bh=c7Kt7fJqy3XK6npICeqo8aKlK7uv/fvZHkx0HfPLFvI=;
        h=From:To:Cc:Subject:Date:From;
        b=Xe7x8sfNccqTWEMFHcanwwvnmtUGxddKzG7SkdpwV+Cw6dQbCbST09zPX+ELHmGhx
         6JacueS1xPOAQHVDXSazsUZA7D/USuqyE7zeElNx1bPG4nGFwuXEQsxwAGq6+D+gF2
         mUIaDihRZ8DT/d4e7V5uelQha8x5unUiZ78c/DhlwZBlp6zd3JvY5OMaZ8xSmOPWLY
         Y1/byQcSrQzKRKfPoRtHkQvJUK9+uV8w2QZMhw3VgcN71syFdBKSNO5zgDmp1+TIJs
         GYgdMs87g4R/wdAEmFdKTqlugbxzwss7ZarV3UaRHP6V4UWm19ufA0JzMs14JUBVR0
         AJWjzpcgLf5HA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/3] pinctrl: mediatek: pinctrl-moore: Simplify with dev_err_probe()
Date:   Mon,  3 Jan 2022 11:18:53 +0100
Message-Id: <20220103101855.17350-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev_err_probe() helper to simplify error handling during probe.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c | 25 +++++++++---------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index ad3b67163973..8531206159b7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -606,6 +606,7 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 			    const struct mtk_pin_soc *soc)
 {
+	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pins;
 	struct mtk_pinctrl *hw;
 	int err, i;
@@ -617,11 +618,9 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 	hw->soc = soc;
 	hw->dev = &pdev->dev;
 
-	if (!hw->soc->nbase_names) {
-		dev_err(&pdev->dev,
+	if (!hw->soc->nbase_names)
+		return dev_err_probe(dev, -EINVAL,
 			"SoC should be assigned at least one register base\n");
-		return -EINVAL;
-	}
 
 	hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
 				      sizeof(*hw->base), GFP_KERNEL);
@@ -666,17 +665,13 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 
 	/* Setup groups descriptions per SoC types */
 	err = mtk_build_groups(hw);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to build groups\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Failed to build groups\n");
 
 	/* Setup functions descriptions per SoC types */
 	err = mtk_build_functions(hw);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to build functions\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Failed to build functions\n");
 
 	/* For able to make pinctrl_claim_hogs, we must not enable pinctrl
 	 * until all groups and functions are being added one.
@@ -692,10 +687,8 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 
 	/* Build gpiochip should be after pinctrl_enable is done */
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Failed to add gpio_chip\n");
 
 	platform_set_drvdata(pdev, hw);
 
-- 
2.33.1

