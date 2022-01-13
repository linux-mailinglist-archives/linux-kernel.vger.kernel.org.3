Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB648D18D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiAMEN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:13:59 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55628 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232531AbiAMELa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:11:30 -0500
X-UUID: e9d3ba9cf5f240b389d92fb221614668-20220113
X-UUID: e9d3ba9cf5f240b389d92fb221614668-20220113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 825869186; Thu, 13 Jan 2022 12:11:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 12:11:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 12:11:25 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v19, 19/19] media: mtk-vcodec: Remove mtk_vcodec_release_enc_pm
Date:   Thu, 13 Jan 2022 12:10:55 +0800
Message-ID: <20220113041055.25213-20-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113041055.25213-1-yunfei.dong@mediatek.com>
References: <20220113041055.25213-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two lines in mtk_vcodec_release_enc_pm, using
pm_runtime_disable and put_device instead directly.

Move pm_runtime_enable outside mtk_vcodec_release_enc_pm to symmetry with
pm_runtime_disable, after that, rename mtk_vcodec_init_enc_pm to *_clk
since it only has clock operations now.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 9 ++++++---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 9 +--------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h  | 3 +--
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 347f0d87e2ff..507ad1ea2104 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
@@ -257,7 +258,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->fw_handler);
 
 	dev->venc_pdata = of_device_get_match_data(&pdev->dev);
-	ret = mtk_vcodec_init_enc_pm(dev);
+	ret = mtk_vcodec_init_enc_clk(dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get mtk vcodec clock source!");
 		goto err_enc_pm;
@@ -369,7 +370,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 err_enc_alloc:
 	v4l2_device_unregister(&dev->v4l2_dev);
 err_res:
-	mtk_vcodec_release_enc_pm(dev);
+	pm_runtime_disable(dev->pm.dev);
+	put_device(dev->pm.larbvenc);
 err_enc_pm:
 	mtk_vcodec_fw_release(dev->fw_handler);
 	return ret;
@@ -458,7 +460,8 @@ static int mtk_vcodec_enc_remove(struct platform_device *pdev)
 		video_unregister_device(dev->vfd_enc);
 
 	v4l2_device_unregister(&dev->v4l2_dev);
-	mtk_vcodec_release_enc_pm(dev);
+	pm_runtime_disable(dev->pm.dev);
+	put_device(dev->pm.larbvenc);
 	mtk_vcodec_fw_release(dev->fw_handler);
 	return 0;
 }
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 0c8c8f86788c..0825c6ec4eb7 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -13,7 +13,7 @@
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
-int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
+int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
 {
 	struct device_node *node;
 	struct platform_device *pdev;
@@ -86,13 +86,6 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	return ret;
 }
 
-void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *mtkdev)
-{
-	pm_runtime_disable(mtkdev->pm.dev);
-	put_device(mtkdev->pm.larbvenc);
-}
-
-
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
 	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
index b7ecdfd74823..bc455cefc0cd 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
@@ -9,8 +9,7 @@
 
 #include "mtk_vcodec_drv.h"
 
-int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *dev);
-void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *dev);
+int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *dev);
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
-- 
2.25.1

