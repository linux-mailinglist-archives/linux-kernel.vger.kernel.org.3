Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FEA584C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiG2G5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiG2G5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:57:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0181F2F1;
        Thu, 28 Jul 2022 23:56:58 -0700 (PDT)
X-UUID: 5fb28d0d7eed481ab6000dd7551fe555-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:ad1e86ad-b217-4203-82e2-eb867f1f3fd9,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:15fdaad0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 5fb28d0d7eed481ab6000dd7551fe555-20220729
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 938338144; Fri, 29 Jul 2022 14:56:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Fri, 29 Jul 2022 06:56:15 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 11:51:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 11:51:34 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <nicolas.dufresne@collabora.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5, 3/8] media: mediatek: vcodec: Refactor venc power manage function
Date:   Fri, 29 Jul 2022 11:51:24 +0800
Message-ID: <20220729035129.3634-4-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729035129.3634-1-irui.wang@mediatek.com>
References: <20220729035129.3634-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The args "struct mtk_vcodec_dev *" doesn't appropriate for init_clk
functions because of sub-devices, sub-devices will init their own
"pm/clk" instead, so refactor the pm function with args
"platform_device *" and "mtk_vcodec_pm*".

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  | 2 +-
 .../media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c   | 8 ++++++++
 .../media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c   | 9 +++------
 .../media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h   | 3 ++-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 9cb6ce1fa101..2e997b32a541 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -257,7 +257,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->fw_handler);
 
 	dev->venc_pdata = of_device_get_match_data(&pdev->dev);
-	ret = mtk_vcodec_init_enc_clk(dev);
+	ret = mtk_vcodec_init_enc_clk(dev->plat_dev, &dev->pm);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get mtk vcodec clock source!");
 		goto err_enc_pm;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
index cc4938f027e0..1ed4279925b7 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
@@ -13,6 +13,7 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_hw.h"
+#include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
 
 static const struct of_device_id mtk_venc_hw_ids[] = {
@@ -115,6 +116,13 @@ static int mtk_venc_hw_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, (ret ? ret : -EINVAL),
 				     "Cannot parse hardware id");
 
+	ret = mtk_vcodec_init_enc_clk(sub_core->plat_dev, &sub_core->pm);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to get venc core clock source!");
+
+	pm_runtime_enable(&pdev->dev);
+
 	main_dev->enc_hw_dev[sub_core->hw_id] = sub_core;
 	sub_core->main_dev = main_dev;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 7055954eb2af..75de5031d292 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -12,17 +12,13 @@
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
-int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
+int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
+			    struct mtk_vcodec_pm *pm)
 {
-	struct platform_device *pdev;
-	struct mtk_vcodec_pm *pm;
 	struct mtk_vcodec_clk *enc_clk;
 	struct mtk_vcodec_clk_info *clk_info;
 	int ret, i;
 
-	pdev = mtkdev->plat_dev;
-	pm = &mtkdev->pm;
-	memset(pm, 0, sizeof(struct mtk_vcodec_pm));
 	pm->dev = &pdev->dev;
 	enc_clk = &pm->venc_clk;
 
@@ -58,6 +54,7 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_init_enc_clk);
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
index bc455cefc0cd..361dec5be47f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
@@ -9,7 +9,8 @@
 
 #include "mtk_vcodec_drv.h"
 
-int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *dev);
+int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
+			    struct mtk_vcodec_pm *pm);
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
-- 
2.18.0

