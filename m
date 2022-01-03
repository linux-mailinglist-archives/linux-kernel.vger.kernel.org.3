Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A844833CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiACOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiACOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:53:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F400C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:53:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5C51C1F402EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641221610;
        bh=NGTXfOIL5zOU/+5DW6dMjFB25yKQDzqC4jgJ9S1Zrro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdtqLXtIeiz2bblKBoQ2E3SyvVMP2twvL2qA8A3O1dZyzLo8/0iUqofS09YbCdsMe
         aE6qDkSseeN+o07exRW5nAfhZTX/72uLHrWJ5oByd5ifqU/uq2n6lnjuw9FKDXD/Rz
         fNwQ70z0/adq6au3joh05MTFsQttIYXai6o0jkgeyyNwQ7E439eEHwBA5jIV1t9lrf
         FEazEDt3ycMSbu30c/YCDseMiaq2keF5Vk/VVuLuDGI0ZhP/2q8LeVTXM8/Tv0wz7c
         woyePZG+o7U7ZnMml8VcwET6zpLA4a3DxHG/8VgiEwmo5yiaxagFBV/R/0YSp3tXrT
         +xYdAUpstdLHw==
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
Subject: [PATCH 2/3] phy: mediatek: phy-mtk-mipi-dsi: Reorder and stop implicit header inclusion
Date:   Mon,  3 Jan 2022 15:53:23 +0100
Message-Id: <20220103145324.48008-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103145324.48008-1-angelogioacchino.delregno@collabora.com>
References: <20220103145324.48008-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the headers for phy-mtk-mipi-{dsi,dsi-mt8173,dsi-mt8183}.c were
included from phy-mtk-mipi-dsi.h, but this isn't optimal: in order to
increase readability and sensibly reduce build times, the inclusions
should be done per-file, also avoiding to include unused headers and
should not be implicit.

For this reason, move the inclusions to each file and remove unused ones.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c |  4 ++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c |  4 ++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c        |  7 +++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h        | 10 ++--------
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
index 95a0d9a3cca7..59f028da9d3e 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
@@ -4,7 +4,11 @@
  * Author: jitao.shi <jitao.shi@mediatek.com>
  */
 
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/phy/phy.h>
 #include "phy-mtk-mipi-dsi.h"
 
 #define MIPITX_DSI_CON		0x00
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 01b59527669e..6c6b192485ba 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -4,7 +4,11 @@
  * Author: jitao.shi <jitao.shi@mediatek.com>
  */
 
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/phy/phy.h>
 #include "phy-mtk-mipi-dsi.h"
 
 #define MIPITX_LANE_CON		0x000c
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 51b1b1d4ad38..6f7425b0bf5b 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -3,7 +3,14 @@
  * Copyright (c) 2015 MediaTek Inc.
  */
 
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/phy/phy.h>
 #include "phy-mtk-mipi-dsi.h"
 
 inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
index 8d32e9027a15..4eb5fc91e083 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
@@ -7,16 +7,10 @@
 #ifndef _MTK_MIPI_TX_H
 #define _MTK_MIPI_TX_H
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/nvmem-consumer.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/regmap.h>
 #include <linux/phy/phy.h>
-#include <linux/slab.h>
 
 struct mtk_mipitx_data {
 	const u32 mppll_preserve;
-- 
2.33.1

