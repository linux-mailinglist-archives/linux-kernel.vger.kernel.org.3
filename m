Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366C949083A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiAQMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:06:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239612AbiAQMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:40 -0500
X-UUID: fefabd2c47f744a3b580c55ea3398224-20220117
X-UUID: fefabd2c47f744a3b580c55ea3398224-20220117
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 886296169; Mon, 17 Jan 2022 20:06:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 20:06:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:06:34 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2, 05/10] media: mtk-vcodec: mtk-vcodec: Rewrite venc power manage interface
Date:   Mon, 17 Jan 2022 20:06:10 +0800
Message-ID: <20220117120615.21687-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117120615.21687-1-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The args "struct mtk_vcodec_dev *" doesn't appropriate for init_clk
functions because of sub-devices. For main device, it has no "pm/clk"
properties in dtsi, sub-devices will init their own "pm/clk" instead.
So rewrite the pm interface with args "platform_device *" and
"mtk_vcodec_pm*".

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c | 9 +++++++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c  | 2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 9 ++-------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h   | 4 ++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
index d84914f615a5..3835b9f458bf 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
@@ -13,6 +13,7 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_core.h"
+#include "mtk_vcodec_enc_pm.h"
 
 static const struct of_device_id mtk_venc_core_ids[] = {
 	{
@@ -95,6 +96,13 @@ static int mtk_venc_core_probe(struct platform_device *pdev)
 
 	core->plat_dev = pdev;
 
+	ret = mtk_vcodec_init_enc_clk(core->plat_dev, &core->pm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get venc core clock source!");
+		return ret;
+	}
+	pm_runtime_enable(&pdev->dev);
+
 	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->reg_base)) {
 		dev_err(&pdev->dev, "Failed to get reg base");
@@ -137,6 +145,7 @@ static int mtk_venc_core_probe(struct platform_device *pdev)
 	return 0;
 
 err:
+	pm_runtime_disable(core->pm.dev);
 	return ret;
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 9d48c604bc54..a601d534d26b 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -262,7 +262,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	core_type = dev->venc_pdata->core_type;
 
 	if (dev->venc_pdata->core_mode == VENC_SINGLE_CORE_MODE) {
-		ret = mtk_vcodec_init_enc_clk(dev);
+		ret = mtk_vcodec_init_enc_clk(dev->plat_dev, &dev->pm);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
 				"Failed to get mtk vcodec clock source!");
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 7eba1a990ed7..c8a7042d7830 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -13,19 +13,15 @@
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
-int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
+int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
+			    struct mtk_vcodec_pm *pm)
 {
 	struct device_node *node;
-	struct platform_device *pdev;
-	struct mtk_vcodec_pm *pm;
 	struct mtk_vcodec_clk *enc_clk;
 	struct mtk_vcodec_clk_info *clk_info;
 	int ret = 0, i = 0;
 	struct device *dev;
 
-	pdev = mtkdev->plat_dev;
-	pm = &mtkdev->pm;
-	memset(pm, 0, sizeof(struct mtk_vcodec_pm));
 	pm->dev = &pdev->dev;
 	dev = &pdev->dev;
 	enc_clk = &pm->venc_clk;
@@ -42,7 +38,6 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 		return -ENODEV;
 	}
 	pm->larbvenc = &pdev->dev;
-	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
 	enc_clk->clk_num = of_property_count_strings(pdev->dev.of_node,
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
index bc455cefc0cd..97a394c68f4e 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
@@ -9,8 +9,8 @@
 
 #include "mtk_vcodec_drv.h"
 
-int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *dev);
-
+int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
+			    struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
 
-- 
2.18.0

