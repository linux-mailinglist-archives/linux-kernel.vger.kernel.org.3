Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5C48343C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiACPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiACPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:31:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BBCC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:31:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8249F1F4254C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641223862;
        bh=sEDq2d+5/abLrttz8U18JMOJJuSHWVdlfX/N3MRUvHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQ1z/nL8jFTbNjKYRB+PMQyIzYsFu8sg0pylMTuCTroCVbNbcK8gxDvbw3InCv3Eo
         APnlC7ub0pkwb6wX2AeUIbRQ62kF+tJ5KgGt7vk7Iy3736YtYuXAx77SH5Qz7sLyS3
         kTQpo+2Z1D9+0f1IHN7S8bsHtGS8CVEMlQqUpTi6ol54LYyMraQbMLQbuqFvs3XlWz
         h2w8qP3AuUSe5CCDPg5SMKKfpgftvNQIximMZiuS7EKyHe49z6RCSGDrSg01FwDG0q
         9n9ZLhC31266uN1touKYVJfUA2OUlxFOJtMMIJg4eujsjfVs2bpChzdaFlbgbT/MKG
         kzSzetjsZVD3g==
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
Subject: [PATCH 3/4] phy: mediatek: phy-mtk-hdmi: Reorder and stop implicit header inclusion
Date:   Mon,  3 Jan 2022 16:30:54 +0100
Message-Id: <20220103153055.50473-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103153055.50473-1-angelogioacchino.delregno@collabora.com>
References: <20220103153055.50473-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the headers for phy-mtk-{hdmi,hdmi-mt2701,hdmi-mt8183}.c were
included from phy-mtk-mipi-dsi.h, but this isn't optimal: in order to
increase readability and sensibly reduce build times, the inclusions
should be done per-file, also avoiding to include unused headers and
should not be implicit.

For this reason, move the inclusions to each file and remove unused ones.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c |  5 +++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c |  5 +++++
 drivers/phy/mediatek/phy-mtk-hdmi.c        |  8 ++++++++
 drivers/phy/mediatek/phy-mtk-hdmi.h        | 10 +---------
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
index 09e0dd7499d8..270c5f538483 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
@@ -4,6 +4,11 @@
  * Author: Chunhui Dai <chunhui.dai@mediatek.com>
  */
 
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
 #include "phy-mtk-hdmi.h"
 
 #define HDMI_CON0	0x00
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
index e317bf4a9db9..87ba9a3687b7 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
@@ -4,6 +4,11 @@
  * Author: Jie Qiu <jie.qiu@mediatek.com>
  */
 
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
 #include "phy-mtk-hdmi.h"
 
 #define HDMI_CON0		0x00
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index b4193cb4e4e3..e037fa89696c 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -4,6 +4,14 @@
  * Author: Jie Qiu <jie.qiu@mediatek.com>
  */
 
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/phy/phy.h>
 #include "phy-mtk-hdmi.h"
 
 inline struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw)
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
index a0571271d730..ef81e44a235d 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
@@ -6,17 +6,9 @@
 
 #ifndef _MTK_HDMI_PHY_H
 #define _MTK_HDMI_PHY_H
-#include <linux/clk.h>
+
 #include <linux/clk-provider.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/mfd/syscon.h>
-#include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/phy/phy.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/types.h>
 
 struct mtk_hdmi_phy;
 
-- 
2.33.1

