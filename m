Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B360849E159
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiA0LnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:43:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43670 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240698AbiA0LnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:43:14 -0500
X-UUID: 5392cfc1e80d4afcb2d179da13656c7e-20220127
X-UUID: 5392cfc1e80d4afcb2d179da13656c7e-20220127
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1820353872; Thu, 27 Jan 2022 19:43:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs10n2.mediatek.inc
 (172.21.101.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Thu, 27 Jan 2022
 19:43:10 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 Jan 2022 19:43:10 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <jitao.shi@mediatek.com>, xinlei lee <xinlei.lee@mediatek.com>
Subject: [v1,3/3] drm/mediatek: Move the getting bridge node function to mtk_dsi_bind
Date:   Thu, 27 Jan 2022 19:42:53 +0800
Message-ID: <1643283773-7081-4-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1643283773-7081-1-git-send-email-xinlei.lee@mediatek.com>
References: <1643283773-7081-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xinlei lee <xinlei.lee@mediatek.com>

The order of probe function for bridge drivers and dsi drivers is uncertain.
To avoid the dsi probe cannot be executed, we place getting bridge node function in
mtk_dsi_bind.

Signed-off-by:Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 62af60d..a390f26 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -991,6 +991,21 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 	int ret;
 	struct drm_device *drm = data;
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
+	struct drm_panel *panel;
+
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
+					  &panel, &dsi->next_bridge);
+	if (ret)
+		return ret;
+
+	if (panel) {
+		dsi->next_bridge = devm_drm_panel_bridge_add(dev, panel);
+		if (IS_ERR(dsi->next_bridge)) {
+			ret = PTR_ERR(dsi->next_bridge);
+			dev_err(dev, "failed to add bridge: %d\n", ret);
+			return ret;
+		}
+	}
 
 	ret = mtk_dsi_encoder_init(drm, dsi);
 	if (ret)
@@ -1016,7 +1031,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 {
 	struct mtk_dsi *dsi;
 	struct device *dev = &pdev->dev;
-	struct drm_panel *panel;
 	struct resource *regs;
 	int irq_num;
 	int ret;
@@ -1033,19 +1047,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
-					  &panel, &dsi->next_bridge);
-	if (ret)
-		goto err_unregister_host;
-
-	if (panel) {
-		dsi->next_bridge = devm_drm_panel_bridge_add(dev, panel);
-		if (IS_ERR(dsi->next_bridge)) {
-			ret = PTR_ERR(dsi->next_bridge);
-			goto err_unregister_host;
-		}
-	}
-
 	dsi->driver_data = of_device_get_match_data(dev);
 
 	dsi->engine_clk = devm_clk_get(dev, "engine");
-- 
2.6.4

