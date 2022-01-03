Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE788482FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiACKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiACKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:19:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FBDC061761;
        Mon,  3 Jan 2022 02:19:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 126CC1F41D8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641205144;
        bh=mGsQoC3yAKQfojVeguaBxYZrtaLtq1wmqI0wIpEb3gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcphB17zDrBeDVMj1gM6wEFjcxGh4VuFeag/FNaH7oBscazIGHE628ONwKpQeM6to
         ZNSWLmdMeP8455P9S7qadtUxc4nXqSADKOBij0mjIUrrEyJiT/6az+ThZQRTRS+Ear
         ht6ZPsVuTX5oC2MtrzXJsN6lbqOU3hdeacoU7e2Ff6edQDmxKYOWIn3k1N6/GPowcd
         TUIbVdJ6XV3ShSUZSk0LduMILDp800CVegTWbaT0YFyzy12MaWi5WT8LuqdE+m0M/k
         dTGNSHUA7zCKQkVIGPBh36NUQpz0lxTgj/p7b0T/+gCa9fbu3Qy9RW6OQSKYesAXBF
         vliDnPYjG6zKA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/3] pinctrl: mediatek: pinctrl-paris: Simplify with dev_err_probe()
Date:   Mon,  3 Jan 2022 11:18:54 +0100
Message-Id: <20220103101855.17350-2-angelogioacchino.delregno@collabora.com>
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
 drivers/pinctrl/mediatek/pinctrl-paris.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 4c6f6d967b18..70849d393917 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -956,6 +956,7 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
 int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 			    const struct mtk_pin_soc *soc)
 {
+	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pins;
 	struct mtk_pinctrl *hw;
 	int err, i;
@@ -968,11 +969,9 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
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
@@ -997,10 +996,8 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 	spin_lock_init(&hw->lock);
 
 	err = mtk_pctrl_build_state(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "build state failed: %d\n", err);
-		return -EINVAL;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "build state failed\n");
 
 	/* Copy from internal struct mtk_pin_desc to register to the core */
 	pins = devm_kmalloc_array(&pdev->dev, hw->soc->npins, sizeof(*pins),
@@ -1038,10 +1035,8 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 
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

