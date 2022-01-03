Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D248343B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiACPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:31:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48324 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiACPbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:31:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B3B5E1F42536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641223861;
        bh=ufpjK9obNzMvAWdLd5nIOYsHY/3E6VwId5SApV+NWmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxrxphPRJeH6xoKd3/7H4lUO1e6wRNNj0KJ/Zlho65Hs5+j/ZlkHzo0vV+XG3mNQm
         tW5ZmzFM83RZPEDnb3H9hRssaNZ+1t2YPEI3LLEBuqtlgFokb4edV6w2+/hJR9PZPj
         gkyvg1MV0ddmx8DS5Q/HlP3BsxkkAAIos7S3Un7ghBMGhw0tFeLgXbp7t+vbz/XUDm
         TFnMXx5v04qo1DWwjFZDoYlOqRcl3ycrCNZx6kCxJdD41bGJoW6oNvRkab1o8aqugl
         d5Qe3H91vrbFrG+J636lwLZ0sgVOWTg52czd/4k0eYrAQ8+R/lBgeGPiAh32clLuZ2
         iULNNllkTd7VQ==
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
Subject: [PATCH 2/4] phy: mediatek: phy-mtk-hdmi: Reorder to remove forward declarations
Date:   Mon,  3 Jan 2022 16:30:53 +0100
Message-Id: <20220103153055.50473-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103153055.50473-1-angelogioacchino.delregno@collabora.com>
References: <20220103153055.50473-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forward declarations for mtk_hdmi_power_{on,off} aren't necessary:
move mtk_hdmi_phy_dev_ops down to remove forward declarations.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 707e90691e6e..b4193cb4e4e3 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -6,15 +6,6 @@
 
 #include "phy-mtk-hdmi.h"
 
-static int mtk_hdmi_phy_power_on(struct phy *phy);
-static int mtk_hdmi_phy_power_off(struct phy *phy);
-
-static const struct phy_ops mtk_hdmi_phy_dev_ops = {
-	.power_on = mtk_hdmi_phy_power_on,
-	.power_off = mtk_hdmi_phy_power_off,
-	.owner = THIS_MODULE,
-};
-
 inline struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw)
 {
 	return container_of(hw, struct mtk_hdmi_phy, pll_hw);
@@ -43,6 +34,12 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static const struct phy_ops mtk_hdmi_phy_dev_ops = {
+	.power_on = mtk_hdmi_phy_power_on,
+	.power_off = mtk_hdmi_phy_power_off,
+	.owner = THIS_MODULE,
+};
+
 static const struct phy_ops *
 mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
 {
-- 
2.33.1

