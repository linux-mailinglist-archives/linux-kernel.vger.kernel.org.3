Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB44F9529
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiDHMFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiDHME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:04:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E13939B1;
        Fri,  8 Apr 2022 05:02:51 -0700 (PDT)
X-UUID: 98404a5b8de94f128de0a0d9b0fa525e-20220408
X-UUID: 98404a5b8de94f128de0a0d9b0fa525e-20220408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 382135457; Fri, 08 Apr 2022 20:02:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 20:02:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 20:02:43 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
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
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v9, 01/17] media: mediatek: vcodec: Add vdec enable/disable hardware helpers
Date:   Fri, 8 Apr 2022 20:02:24 +0800
Message-ID: <20220408120240.29571-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408120240.29571-1-yunfei.dong@mediatek.com>
References: <20220408120240.29571-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock, power and clock are highly coupled operations. Adds vdec
enable/disable hardware helpers and uses them.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Tzung-Bi Shih<tzungbi@google.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   5 -
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 166 +++++++++++-------
 .../mediatek/vcodec/mtk_vcodec_dec_pm.h       |   6 +-
 .../platform/mediatek/vcodec/vdec_drv_if.c    |  20 +--
 .../platform/mediatek/vcodec/vdec_msg_queue.c |   2 +
 5 files changed, 116 insertions(+), 83 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index df7b25e9cbc8..a84df6596aaa 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -193,9 +193,6 @@ static int fops_vcodec_open(struct file *file)
 	mtk_vcodec_dec_set_default_params(ctx);
 
 	if (v4l2_fh_is_singular(&ctx->fh)) {
-		ret = mtk_vcodec_dec_pw_on(dev, MTK_VDEC_LAT0);
-		if (ret < 0)
-			goto err_load_fw;
 		/*
 		 * Does nothing if firmware was already loaded.
 		 */
@@ -252,8 +249,6 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_m2m_ctx_release(ctx->m2m_ctx);
 	mtk_vcodec_dec_release(ctx);
 
-	if (v4l2_fh_is_singular(&ctx->fh))
-		mtk_vcodec_dec_pw_off(dev, MTK_VDEC_LAT0);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 7e0c2644bf7b..0fb7e5ba635b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -57,74 +57,31 @@ int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_init_dec_clk);
 
-int mtk_vcodec_dec_pw_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+static int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
 {
-	struct mtk_vdec_hw_dev *subdev_dev;
-	struct mtk_vcodec_pm *pm;
 	int ret;
 
-	if (vdec_dev->vdec_pdata->is_subdev_supported) {
-		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
-		if (!subdev_dev) {
-			mtk_v4l2_err("Failed to get hw dev\n");
-			return -EINVAL;
-		}
-		pm = &subdev_dev->pm;
-	} else {
-		pm = &vdec_dev->pm;
-	}
-
 	ret = pm_runtime_resume_and_get(pm->dev);
 	if (ret)
 		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_on);
 
-void mtk_vcodec_dec_pw_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+static void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 {
-	struct mtk_vdec_hw_dev *subdev_dev;
-	struct mtk_vcodec_pm *pm;
 	int ret;
 
-	if (vdec_dev->vdec_pdata->is_subdev_supported) {
-		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
-		if (!subdev_dev) {
-			mtk_v4l2_err("Failed to get hw dev\n");
-			return;
-		}
-		pm = &subdev_dev->pm;
-	} else {
-		pm = &vdec_dev->pm;
-	}
-
 	ret = pm_runtime_put_sync(pm->dev);
 	if (ret)
 		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
 }
-EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_off);
 
-void mtk_vcodec_dec_clock_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 {
-	struct mtk_vdec_hw_dev *subdev_dev;
-	struct mtk_vcodec_pm *pm;
 	struct mtk_vcodec_clk *dec_clk;
 	int ret, i;
 
-	if (vdec_dev->vdec_pdata->is_subdev_supported) {
-		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
-		if (!subdev_dev) {
-			mtk_v4l2_err("Failed to get hw dev\n");
-			return;
-		}
-		pm = &subdev_dev->pm;
-		enable_irq(subdev_dev->dec_irq);
-	} else {
-		pm = &vdec_dev->pm;
-		enable_irq(vdec_dev->dec_irq);
-	}
-
 	dec_clk = &pm->vdec_clk;
 	for (i = 0; i < dec_clk->clk_num; i++) {
 		ret = clk_prepare_enable(dec_clk->clk_info[i].vcodec_clk);
@@ -140,30 +97,119 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
 	for (i -= 1; i >= 0; i--)
 		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
-EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_on);
 
-void mtk_vcodec_dec_clock_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+static void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 {
-	struct mtk_vdec_hw_dev *subdev_dev;
-	struct mtk_vcodec_pm *pm;
 	struct mtk_vcodec_clk *dec_clk;
 	int i;
 
+	dec_clk = &pm->vdec_clk;
+	for (i = dec_clk->clk_num - 1; i >= 0; i--)
+		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
+}
+
+static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+{
+	struct mtk_vdec_hw_dev *subdev_dev;
+
+	if (!test_bit(hw_idx, vdec_dev->subdev_bitmap))
+		return;
+
 	if (vdec_dev->vdec_pdata->is_subdev_supported) {
 		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
-		if (!subdev_dev) {
+		if (subdev_dev)
+			enable_irq(subdev_dev->dec_irq);
+		else
+			mtk_v4l2_err("Failed to get hw dev\n");
+	} else {
+		enable_irq(vdec_dev->dec_irq);
+	}
+}
+
+static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+{
+	struct mtk_vdec_hw_dev *subdev_dev;
+
+	if (!test_bit(hw_idx, vdec_dev->subdev_bitmap))
+		return;
+
+	if (vdec_dev->vdec_pdata->is_subdev_supported) {
+		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
+		if (subdev_dev)
+			disable_irq(subdev_dev->dec_irq);
+		else
 			mtk_v4l2_err("Failed to get hw dev\n");
-			return;
-		}
-		pm = &subdev_dev->pm;
-		disable_irq(subdev_dev->dec_irq);
 	} else {
-		pm = &vdec_dev->pm;
 		disable_irq(vdec_dev->dec_irq);
 	}
+}
 
-	dec_clk = &pm->vdec_clk;
-	for (i = dec_clk->clk_num - 1; i >= 0; i--)
-		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
+static struct mtk_vcodec_pm *mtk_vcodec_dec_get_pm(struct mtk_vcodec_dev *vdec_dev,
+						   int hw_idx)
+{
+	struct mtk_vdec_hw_dev *subdev_dev;
+
+	if (!test_bit(hw_idx, vdec_dev->subdev_bitmap))
+		return NULL;
+
+	if (vdec_dev->vdec_pdata->is_subdev_supported) {
+		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
+		if (subdev_dev)
+			return &subdev_dev->pm;
+
+		mtk_v4l2_err("Failed to get hw dev\n");
+		return NULL;
+	}
+
+	return &vdec_dev->pm;
+}
+
+static void mtk_vcodec_dec_child_dev_on(struct mtk_vcodec_dev *vdec_dev,
+					int hw_idx)
+{
+	struct mtk_vcodec_pm *pm;
+
+	pm = mtk_vcodec_dec_get_pm(vdec_dev, hw_idx);
+	if (pm) {
+		mtk_vcodec_dec_pw_on(pm);
+		mtk_vcodec_dec_clock_on(pm);
+	}
+}
+
+static void mtk_vcodec_dec_child_dev_off(struct mtk_vcodec_dev *vdec_dev,
+					 int hw_idx)
+{
+	struct mtk_vcodec_pm *pm;
+
+	pm = mtk_vcodec_dec_get_pm(vdec_dev, hw_idx);
+	if (pm) {
+		mtk_vcodec_dec_clock_off(pm);
+		mtk_vcodec_dec_pw_off(pm);
+	}
+}
+
+void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
+{
+	mutex_lock(&ctx->dev->dec_mutex[hw_idx]);
+
+	if (IS_VDEC_LAT_ARCH(ctx->dev->vdec_pdata->hw_arch) &&
+	    hw_idx == MTK_VDEC_CORE)
+		mtk_vcodec_dec_child_dev_on(ctx->dev, MTK_VDEC_LAT0);
+	mtk_vcodec_dec_child_dev_on(ctx->dev, hw_idx);
+
+	mtk_vcodec_dec_enable_irq(ctx->dev, hw_idx);
+}
+EXPORT_SYMBOL_GPL(mtk_vcodec_dec_enable_hardware);
+
+void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
+{
+	mtk_vcodec_dec_disable_irq(ctx->dev, hw_idx);
+
+	mtk_vcodec_dec_child_dev_off(ctx->dev, hw_idx);
+	if (IS_VDEC_LAT_ARCH(ctx->dev->vdec_pdata->hw_arch) &&
+	    hw_idx == MTK_VDEC_CORE)
+		mtk_vcodec_dec_child_dev_off(ctx->dev, MTK_VDEC_LAT0);
+
+	mutex_unlock(&ctx->dev->dec_mutex[hw_idx]);
 }
-EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_off);
+EXPORT_SYMBOL_GPL(mtk_vcodec_dec_disable_hardware);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
index 3cc721bbfaf6..dbcf3cabe6f3 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
@@ -11,9 +11,7 @@
 
 int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *pm);
 
-int mtk_vcodec_dec_pw_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
-void mtk_vcodec_dec_pw_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
-void mtk_vcodec_dec_clock_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
-void mtk_vcodec_dec_clock_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
+void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx);
+void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx);
 
 #endif /* _MTK_VCODEC_DEC_PM_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
index 05a5b240e906..c93dd0ea3537 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
@@ -38,11 +38,9 @@ int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 		return -EINVAL;
 	}
 
-	mtk_vdec_lock(ctx);
-	mtk_vcodec_dec_clock_on(ctx->dev, ctx->hw_id);
+	mtk_vcodec_dec_enable_hardware(ctx, ctx->hw_id);
 	ret = ctx->dec_if->init(ctx);
-	mtk_vcodec_dec_clock_off(ctx->dev, ctx->hw_id);
-	mtk_vdec_unlock(ctx);
+	mtk_vcodec_dec_disable_hardware(ctx, ctx->hw_id);
 
 	return ret;
 }
@@ -70,15 +68,11 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
 	if (!ctx->drv_handle)
 		return -EIO;
 
-	mtk_vdec_lock(ctx);
-
+	mtk_vcodec_dec_enable_hardware(ctx, ctx->hw_id);
 	mtk_vcodec_set_curr_ctx(ctx->dev, ctx, ctx->hw_id);
-	mtk_vcodec_dec_clock_on(ctx->dev, ctx->hw_id);
 	ret = ctx->dec_if->decode(ctx->drv_handle, bs, fb, res_chg);
-	mtk_vcodec_dec_clock_off(ctx->dev, ctx->hw_id);
 	mtk_vcodec_set_curr_ctx(ctx->dev, NULL, ctx->hw_id);
-
-	mtk_vdec_unlock(ctx);
+	mtk_vcodec_dec_disable_hardware(ctx, ctx->hw_id);
 
 	return ret;
 }
@@ -103,11 +97,9 @@ void vdec_if_deinit(struct mtk_vcodec_ctx *ctx)
 	if (!ctx->drv_handle)
 		return;
 
-	mtk_vdec_lock(ctx);
-	mtk_vcodec_dec_clock_on(ctx->dev, ctx->hw_id);
+	mtk_vcodec_dec_enable_hardware(ctx, ctx->hw_id);
 	ctx->dec_if->deinit(ctx->drv_handle);
-	mtk_vcodec_dec_clock_off(ctx->dev, ctx->hw_id);
-	mtk_vdec_unlock(ctx);
+	mtk_vcodec_dec_disable_hardware(ctx, ctx->hw_id);
 
 	ctx->drv_handle = NULL;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 4b062a8128b4..ae500980ad45 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -212,11 +212,13 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 		return;
 
 	ctx = lat_buf->ctx;
+	mtk_vcodec_dec_enable_hardware(ctx, MTK_VDEC_CORE);
 	mtk_vcodec_set_curr_ctx(dev, ctx, MTK_VDEC_CORE);
 
 	lat_buf->core_decode(lat_buf);
 
 	mtk_vcodec_set_curr_ctx(dev, NULL, MTK_VDEC_CORE);
+	mtk_vcodec_dec_disable_hardware(ctx, MTK_VDEC_CORE);
 	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 
 	if (!list_empty(&ctx->msg_queue.lat_ctx.ready_queue)) {
-- 
2.18.0

