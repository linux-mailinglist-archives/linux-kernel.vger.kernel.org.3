Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96C4E930E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiC1LNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiC1LNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:13:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3FD26AE7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:11:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 422DC1F434D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648465879;
        bh=419/BL+mLF16KS+JYf0o8RqyMhR63jMhw3wqLehWCM4=;
        h=From:To:Cc:Subject:Date:From;
        b=G8hXakp8phXhjZ9JqEyaLDuoT4TMR3hosQo+KbGJ0YBXDN63JcDNKHSoxgkqy/Yn4
         N8hScWtIJk63aIlBBXwFuAJ16hblfIri4OmoPNW5GtEYRlRg+TR4QB1BvGf5yiNK7j
         2y+Mv/tS8Ldp41/Y1ZQbYsd2OrVBOZR8u7+hEiCbGb59UPonMN2ms1f7psqvESfjYP
         aMqFIIe/OMVKeXnyw/XxnhYHsIItR+45paYxaDhu/Aa/yKnPdmVVHctIizjJhJeEZe
         21Kv3+dFYWCi1UtNWlOvkSQo/ivHfQQm0cM4t293Kc5VZiJTgdgbBJabYsvFxcCSE0
         KaoR8FmpQuepA==
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
Subject: [PATCH] phy: mediatek: phy-mtk-mipi-dsi: Simplify with dev_err_probe()
Date:   Mon, 28 Mar 2022 13:11:15 +0200
Message-Id: <20220328111115.210821-1-angelogioacchino.delregno@collabora.com>
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
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 67b005d5b9e3..815895e54172 100644
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
-- 
2.35.1

