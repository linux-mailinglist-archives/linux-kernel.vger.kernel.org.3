Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36694E9A25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiC1OyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbiC1OyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:54:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330E5DE56
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:52:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CF2831F40887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648479142;
        bh=XMWA9qgWgkC/u71lI6wm/PuAiM5oal1tM//wU28I3+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=KpxYfx5mPacmgWtvt0niX7ZGuHbYIYeRj0xTOMgZP7XUOchwKhPwRxny07to7LuBj
         OJ9HizD4Ma3B8gwDFN+9W6uFPYL7qjVnfWl+BvvWvZ71uxSlsB1qTCFTtP7oNLmHt0
         VO60a4vdL+8Tzth/2i8qMPikMX4EvoI1wuoIsKaU+uGJ5GZ6SpZp01QjQAg07TETb5
         +2xfAt/nS2ciDJbTItTh6LFd1P+xmEahKdg5pFrj6iwE8nodPW0W/QA8WEJroO8oHn
         NyOHs7sVRdDzrysFgIdJhWpuwT5RolACCr4aozGJN2gMfrtIntI3EHQ8WngSSSThs3
         aVDTi9XfD5/GA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, chunfeng.yun@mediatek.com, kishon@ti.com,
        vkoul@kernel.org, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] phy: mediatek: phy-mtk-mipi-dsi: Simplify with dev_err_probe()
Date:   Mon, 28 Mar 2022 16:52:17 +0200
Message-Id: <20220328145217.228457-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Use the dev_err_probe() helper to simplify error handling during probe.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

v2: Sorry, v1 was only partial as I have accidentally sent the
    wrong patch file. Fixed for v2.

 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 29 +++++++++----------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 67b005d5b9e3..28506932bd91 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -154,11 +154,9 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 		return PTR_ERR(mipi_tx->regs);
 
 	ref_clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ref_clk)) {
-		ret = PTR_ERR(ref_clk);
-		dev_err(dev, "Failed to get reference clock: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(ref_clk))
+		return dev_err_probe(dev, PTR_ERR(ref_clk),
+				     "Failed to get reference clock\n");
 
 	ret = of_property_read_u32(dev->of_node, "drive-strength-microamp",
 				   &mipi_tx->mipitx_drive);
@@ -178,27 +176,20 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 
 	ret = of_property_read_string(dev->of_node, "clock-output-names",
 				      &clk_init.name);
-	if (ret < 0) {
-		dev_err(dev, "Failed to read clock-output-names: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read clock-output-names\n");
 
 	clk_init.ops = mipi_tx->driver_data->mipi_tx_clk_ops;
 
 	mipi_tx->pll_hw.init = &clk_init;
 	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
-	if (IS_ERR(mipi_tx->pll)) {
-		ret = PTR_ERR(mipi_tx->pll);
-		dev_err(dev, "Failed to register PLL: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mipi_tx->pll))
+		return dev_err_probe(dev, PTR_ERR(mipi_tx->pll), "Failed to register PLL\n");
 
 	phy = devm_phy_create(dev, NULL, &mtk_mipi_tx_ops);
-	if (IS_ERR(phy)) {
-		ret = PTR_ERR(phy);
-		dev_err(dev, "Failed to create MIPI D-PHY: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "Failed to create MIPI D-PHY\n");
+
 	phy_set_drvdata(phy, mipi_tx);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.35.1

