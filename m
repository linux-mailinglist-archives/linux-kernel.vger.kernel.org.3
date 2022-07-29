Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1479584A67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiG2Dw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiG2Dvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:51:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B77CB6E;
        Thu, 28 Jul 2022 20:51:45 -0700 (PDT)
X-UUID: 27213a77e9e84cb3997e1a20685682c8-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:6cd7f9b2-5747-4c66-87eb-4017e6d10d4c,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:0dc4ae24-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 27213a77e9e84cb3997e1a20685682c8-20220729
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2036281254; Fri, 29 Jul 2022 11:51:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 11:51:37 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 11:51:36 +0800
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
Subject: [PATCH v5, 5/8] media: mediatek: vcodec: Add venc power on/off function
Date:   Fri, 29 Jul 2022 11:51:26 +0800
Message-ID: <20220729035129.3634-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729035129.3634-1-irui.wang@mediatek.com>
References: <20220729035129.3634-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when enable multi-core encoding, all available encoder cores' power need
to be on/off, add new functions for encoder cores' power management.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 31 +++----
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 83 +++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  2 +
 .../platform/mediatek/vcodec/venc_drv_if.c    |  6 --
 4 files changed, 97 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 25e816863597..ad20f729ef6f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -8,10 +8,10 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
-#include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
+#include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
 #include "venc_drv_if.h"
@@ -877,8 +877,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
-	int ret, pm_ret;
-	int i;
+	int ret, i;
 
 	/* Once state turn into MTK_STATE_ABORT, we need stop_streaming
 	  * to clear it
@@ -897,18 +896,12 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 			return 0;
 	}
 
-	ret = pm_runtime_resume_and_get(&ctx->dev->plat_dev->dev);
-	if (ret < 0) {
-		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
-		goto err_start_stream;
-	}
-
 	mtk_venc_set_param(ctx, &param);
 	ret = venc_if_set_param(ctx, VENC_SET_PARAM_ENC, &param);
 	if (ret) {
 		mtk_v4l2_err("venc_if_set_param failed=%d", ret);
 		ctx->state = MTK_STATE_ABORT;
-		goto err_set_param;
+		goto err_start_stream;
 	}
 	ctx->param_change = MTK_ENCODE_PARAM_NONE;
 
@@ -921,17 +914,19 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 		if (ret) {
 			mtk_v4l2_err("venc_if_set_param failed=%d", ret);
 			ctx->state = MTK_STATE_ABORT;
-			goto err_set_param;
+			goto err_start_stream;
 		}
 		ctx->state = MTK_STATE_HEADER;
 	}
 
-	return 0;
+	ret = mtk_vcodec_enc_power_on(ctx);
+	if (ret) {
+		mtk_v4l2_err("mtk_vcodec_enc_power_on failed=%d", ret);
+		ctx->state = MTK_STATE_ABORT;
+		goto err_start_stream;
+	}
 
-err_set_param:
-	pm_ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (pm_ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", pm_ret);
+	return 0;
 
 err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
@@ -1016,9 +1011,7 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	if (ret)
 		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
 
-	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+	mtk_vcodec_enc_power_off(ctx);
 
 	ctx->state = MTK_STATE_FREE;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 75de5031d292..213c3f50e9eb 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -9,6 +9,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
+#include "mtk_vcodec_enc_hw.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
@@ -56,6 +57,88 @@ int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_init_enc_clk);
 
+static int mtk_enc_core_power_on(struct mtk_vcodec_ctx *ctx)
+{
+	struct mtk_venc_hw_dev *sub_core;
+	int ret, i;
+
+	/* multi-core encoding need power on all available cores */
+	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
+		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
+		if (!sub_core)
+			continue;
+
+		ret = pm_runtime_resume_and_get(&sub_core->plat_dev->dev);
+		if (ret) {
+			mtk_v4l2_err("power on sub_core[%d] fail %d", i, ret);
+			goto pm_on_fail;
+		}
+	}
+	return ret;
+
+pm_on_fail:
+	for (i -= 1; i >= 0; i--) {
+		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
+		pm_runtime_put_sync(&sub_core->plat_dev->dev);
+	}
+	return ret;
+}
+
+int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx)
+{
+	struct mtk_vcodec_pm *pm = &ctx->dev->pm;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pm->dev);
+	if (ret) {
+		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
+		return ret;
+	}
+
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		ret = mtk_enc_core_power_on(ctx);
+		if (ret) {
+			mtk_v4l2_err("mtk_enc_core_power_on fail %d", ret);
+			goto core_error;
+		}
+	}
+	return ret;
+
+core_error:
+	pm_runtime_put_sync(pm->dev);
+	return ret;
+}
+
+static void mtk_enc_core_power_off(struct mtk_vcodec_ctx *ctx)
+{
+	struct mtk_venc_hw_dev *sub_core;
+	int ret, i;
+
+	/* multi-core encoding need power off all available cores */
+	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
+		sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[i];
+		if (!sub_core)
+			continue;
+
+		ret = pm_runtime_put_sync(&sub_core->plat_dev->dev);
+		if (ret)
+			mtk_v4l2_err("power off sub_core[%d] fail %d", i, ret);
+	}
+}
+
+void mtk_vcodec_enc_power_off(struct mtk_vcodec_ctx *ctx)
+{
+	struct mtk_vcodec_pm *pm = &ctx->dev->pm;
+	int ret;
+
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
+		mtk_enc_core_power_off(ctx);
+
+	ret = pm_runtime_put_sync(pm->dev);
+	if (ret)
+		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
+}
+
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
 	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
index 361dec5be47f..9065dec4ed4f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
@@ -12,6 +12,8 @@
 int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
 			    struct mtk_vcodec_pm *pm);
 
+int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_enc_power_off(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
index ce0bce811615..65a27e39ef5b 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
@@ -32,9 +32,7 @@ int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 	}
 
 	mtk_venc_lock(ctx);
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->init(ctx);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 	mtk_venc_unlock(ctx);
 
 	return ret;
@@ -46,9 +44,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
 	int ret = 0;
 
 	mtk_venc_lock(ctx);
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->set_param(ctx->drv_handle, type, in);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 	mtk_venc_unlock(ctx);
 
 	return ret;
@@ -89,9 +85,7 @@ int venc_if_deinit(struct mtk_vcodec_ctx *ctx)
 		return 0;
 
 	mtk_venc_lock(ctx);
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->deinit(ctx->drv_handle);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 	mtk_venc_unlock(ctx);
 
 	ctx->drv_handle = NULL;
-- 
2.18.0

