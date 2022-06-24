Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C16559551
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiFXIYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiFXIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:23:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165D56F4AC;
        Fri, 24 Jun 2022 01:23:51 -0700 (PDT)
X-UUID: 0c48e690c08b46e697120d87a3a85c78-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:4a091702-20ab-4f93-819d-c65a1c5c2709,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:4a091702-20ab-4f93-819d-c65a1c5c2709,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:904278d8-850a-491d-a127-60d9309b2b3e,C
        OID:b617216b67d0,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0c48e690c08b46e697120d87a3a85c78-20220624
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 404717126; Fri, 24 Jun 2022 16:23:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 16:23:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jun 2022 16:23:42 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4, 5/8] media: mediatek: vcodec: Add venc power on/off function
Date:   Fri, 24 Jun 2022 16:23:32 +0800
Message-ID: <20220624082335.10165-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624082335.10165-1-irui.wang@mediatek.com>
References: <20220624082335.10165-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 30 +++----
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 84 +++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  2 +
 .../platform/mediatek/vcodec/venc_drv_if.c    |  6 --
 4 files changed, 98 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index c21367038c34..2b4a2acc8d2d 100644
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
@@ -849,7 +849,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
-	int ret, pm_ret;
+	int ret;
 	int i;
 
 	/* Once state turn into MTK_STATE_ABORT, we need stop_streaming
@@ -869,18 +869,12 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
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
 
@@ -893,17 +887,19 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
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
@@ -988,9 +984,7 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	if (ret)
 		mtk_v4l2_err("venc_if_deinit failed=%d", ret);
 
-	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (ret < 0)
-		mtk_v4l2_err("pm_runtime_put fail %d", ret);
+	mtk_vcodec_enc_power_off(ctx);
 
 	ctx->state = MTK_STATE_FREE;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 75de5031d292..a6f30b3a6bc5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -9,6 +9,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
+#include "mtk_vcodec_enc_hw.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
 
@@ -56,6 +57,89 @@ int mtk_vcodec_init_enc_clk(struct platform_device *pdev,
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
+	ret = pm_runtime_put_sync(pm->dev);
+	if (ret)
+		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
+
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		mtk_enc_core_power_off(ctx);
+	}
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

