Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3286F5A2480
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbiHZJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbiHZJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:30:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F813FAA;
        Fri, 26 Aug 2022 02:30:19 -0700 (PDT)
X-UUID: 11825516c2c746a991f0fe87426b58db-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jQviG//taPOjYVgJWgXXZUJc9Pk06DpR2dWCSmhqQUU=;
        b=WpJNwzdwYHrISTh8L9ZQTb8NuiVsCQdR1wjLrFAvemAu3uVKsf5rLb2419p2+jyXeOwa44XfmkKrtiSKzyzeAg0ldNbKxOpZYcQPwhUFANgfb8lIJUELZfGprIdV949qJPGreIzCD5E1iRSLSTFcdl1doMH4B+/0OKabGb2a0A4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:b0d58fc6-c916-4de8-9c93-64e228fb514b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:ed60aa55-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 11825516c2c746a991f0fe87426b58db-20220826
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 309340048; Fri, 26 Aug 2022 17:30:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 17:30:02 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 17:30:01 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V13,3/7] mtk-jpegenc: support jpegenc multi-hardware
Date:   Fri, 26 Aug 2022 17:29:52 +0800
Message-ID: <20220826092956.10340-4-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826092956.10340-1-irui.wang@mediatek.com>
References: <20220826092956.10340-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

support jpeg encode multi-hardware includes HW0 and HW1.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/jpeg/Makefile |  11 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  67 +++----
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  37 ++++
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 163 ++++++++++++++++++
 4 files changed, 245 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/Makefile b/drivers/media/platform/mediatek/jpeg/Makefile
index 76c33aad0f3f..69703db4b0a5 100644
--- a/drivers/media/platform/mediatek/jpeg/Makefile
+++ b/drivers/media/platform/mediatek/jpeg/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-mtk_jpeg-objs := mtk_jpeg_core.o \
+obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) += mtk_jpeg.o \
+	mtk-jpeg-enc-hw.o
+
+mtk_jpeg-y := mtk_jpeg_core.o \
 		 mtk_jpeg_dec_hw.o \
-		 mtk_jpeg_dec_parse.o \
-		 mtk_jpeg_enc_hw.o
-obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) += mtk_jpeg.o
+		 mtk_jpeg_dec_parse.o
+
+mtk-jpeg-enc-hw-y := mtk_jpeg_enc_hw.o
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 724fb7aeb0ee..b073f18dc554 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -680,7 +680,7 @@ static int mtk_jpeg_buf_prepare(struct vb2_buffer *vb)
 {
 	struct mtk_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mtk_jpeg_q_data *q_data = NULL;
-	struct v4l2_plane_pix_format plane_fmt;
+	struct v4l2_plane_pix_format plane_fmt = {};
 	int i;
 
 	q_data = mtk_jpeg_get_q_data(ctx, vb->vb2_queue->type);
@@ -1312,38 +1312,51 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 	spin_lock_init(&jpeg->hw_lock);
 	jpeg->dev = &pdev->dev;
 	jpeg->variant = of_device_get_match_data(jpeg->dev);
-	INIT_DELAYED_WORK(&jpeg->job_timeout_work, mtk_jpeg_job_timeout_work);
 
-	jpeg->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(jpeg->reg_base)) {
-		ret = PTR_ERR(jpeg->reg_base);
-		return ret;
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret) {
+		v4l2_err(&jpeg->v4l2_dev, "Master of platform populate failed.");
+		return -EINVAL;
 	}
 
-	jpeg_irq = platform_get_irq(pdev, 0);
-	if (jpeg_irq < 0)
-		return jpeg_irq;
+	if (list_empty(&pdev->dev.devres_head)) {
+		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
+				  mtk_jpeg_job_timeout_work);
 
-	ret = devm_request_irq(&pdev->dev, jpeg_irq,
-			       jpeg->variant->irq_handler, 0, pdev->name, jpeg);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
-			jpeg_irq, ret);
-		goto err_req_irq;
-	}
+		jpeg->reg_base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(jpeg->reg_base)) {
+			ret = PTR_ERR(jpeg->reg_base);
+			return ret;
+		}
 
-	ret = devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
-				jpeg->variant->clks);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to init clk, err %d\n", ret);
-		goto err_clk_init;
+		jpeg_irq = platform_get_irq(pdev, 0);
+		if (jpeg_irq < 0)
+			return jpeg_irq;
+
+		ret = devm_request_irq(&pdev->dev,
+				       jpeg_irq,
+				       jpeg->variant->irq_handler,
+				       0,
+				       pdev->name, jpeg);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
+				jpeg_irq, ret);
+			return ret;
+		}
+
+		ret = devm_clk_bulk_get(jpeg->dev,
+					jpeg->variant->num_clks,
+					jpeg->variant->clks);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to init clk\n");
+			return ret;
+		}
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register v4l2 device\n");
-		ret = -EINVAL;
-		goto err_dev_register;
+		return -EINVAL;
 	}
 
 	jpeg->m2m_dev = v4l2_m2m_init(jpeg->variant->m2m_ops);
@@ -1401,12 +1414,6 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 err_m2m_init:
 	v4l2_device_unregister(&jpeg->v4l2_dev);
 
-err_dev_register:
-
-err_clk_init:
-
-err_req_irq:
-
 	return ret;
 }
 
@@ -1497,6 +1504,7 @@ static const struct mtk_jpeg_variant mtk_jpeg_drvdata = {
 	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
 };
 
+#if defined(CONFIG_OF)
 static const struct of_device_id mtk_jpeg_match[] = {
 	{
 		.compatible = "mediatek,mt8173-jpgdec",
@@ -1514,6 +1522,7 @@ static const struct of_device_id mtk_jpeg_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, mtk_jpeg_match);
+#endif
 
 static struct platform_driver mtk_jpeg_driver = {
 	.probe = mtk_jpeg_probe,
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 3e4811a41ba2..4aaddf0301d1 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -9,6 +9,7 @@
 #ifndef _MTK_JPEG_CORE_H
 #define _MTK_JPEG_CORE_H
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -74,6 +75,38 @@ struct mtk_jpeg_variant {
 	u32 cap_q_default_fourcc;
 };
 
+enum mtk_jpegenc_hw_id {
+	MTK_JPEGENC_HW0,
+	MTK_JPEGENC_HW1,
+	MTK_JPEGENC_HW_MAX,
+};
+
+/**
+ * struct mtk_jpegenc_clk - Structure used to store vcodec clock information
+ */
+struct mtk_jpegenc_clk {
+	struct clk_bulk_data *clks;
+	int clk_num;
+};
+
+/**
+ * struct mtk_jpegenc_comp_dev - JPEG COREX abstraction
+ * @dev:		JPEG device
+ * @plat_dev:		platform device data
+ * @reg_base:		JPEG registers mapping
+ * @master_dev:		mtk_jpeg_dev device
+ * @pm:			mtk_jpegenc_pm
+ * @jpegenc_irq:	jpeg encode irq num
+ */
+struct mtk_jpegenc_comp_dev {
+	struct device *dev;
+	struct platform_device *plat_dev;
+	void __iomem *reg_base;
+	struct mtk_jpeg_dev *master_dev;
+	struct mtk_jpegenc_clk venc_clk;
+	int jpegenc_irq;
+};
+
 /**
  * struct mtk_jpeg_dev - JPEG IP abstraction
  * @lock:		the mutex protecting this structure
@@ -100,6 +133,10 @@ struct mtk_jpeg_dev {
 	void __iomem		*reg_base;
 	struct delayed_work job_timeout_work;
 	const struct mtk_jpeg_variant *variant;
+
+	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
+	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
+	bool is_jpgenc_multihw;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index a2b6e1f85c2d..749851590a75 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -5,11 +5,27 @@
  *
  */
 
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <media/media-device.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-event.h>
 
+#include "mtk_jpeg_core.h"
 #include "mtk_jpeg_enc_hw.h"
 
 static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] = {
@@ -30,6 +46,16 @@ static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] = {
 	{.quality_param = 97, .hardware_value = JPEG_ENC_QUALITY_Q97},
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id mtk_jpegenc_drv_ids[] = {
+	{
+		.compatible = "mediatek,mt8195-jpgenc-hw",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_jpegenc_drv_ids);
+#endif
+
 void mtk_jpeg_enc_reset(void __iomem *base)
 {
 	writel(0, base + JPEG_ENC_RSTB);
@@ -159,3 +185,140 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_params);
 
+static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
+{
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	enum vb2_buffer_state buf_state;
+	struct mtk_jpeg_ctx *ctx;
+	u32 result_size;
+	u32 irq_status;
+
+	struct mtk_jpegenc_comp_dev *jpeg = priv;
+	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
+
+	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
+		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
+	if (irq_status)
+		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
+	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
+		return IRQ_NONE;
+
+	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
+	if (!ctx) {
+		v4l2_err(&master_jpeg->v4l2_dev, "Context is NULL\n");
+		return IRQ_HANDLED;
+	}
+
+	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
+	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
+	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
+	buf_state = VB2_BUF_STATE_DONE;
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	pm_runtime_put(ctx->jpeg->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_jpegenc_hw_init_irq(struct mtk_jpegenc_comp_dev *dev)
+{
+	struct platform_device *pdev = dev->plat_dev;
+	int ret;
+
+	dev->jpegenc_irq = platform_get_irq(pdev, 0);
+	if (dev->jpegenc_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq resource");
+		return dev->jpegenc_irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev,
+			       dev->jpegenc_irq,
+			       mtk_jpegenc_hw_irq_handler,
+			       0,
+			       pdev->name, dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to devm_request_irq %d (%d)",
+			dev->jpegenc_irq, ret);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
+{
+	struct mtk_jpegenc_clk *jpegenc_clk;
+	struct mtk_jpeg_dev *master_dev;
+	struct mtk_jpegenc_comp_dev *dev;
+	int ret, i;
+
+	struct device *decs = &pdev->dev;
+
+	if (!decs->parent)
+		return -EPROBE_DEFER;
+
+	master_dev = dev_get_drvdata(decs->parent);
+	if (!master_dev)
+		return -EPROBE_DEFER;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->plat_dev = pdev;
+	dev->dev = &pdev->dev;
+
+	if (!master_dev->is_jpgenc_multihw) {
+		master_dev->is_jpgenc_multihw = true;
+		for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
+			master_dev->enc_hw_dev[i] = NULL;
+	}
+
+	jpegenc_clk = &dev->venc_clk;
+
+	jpegenc_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
+						     &jpegenc_clk->clks);
+	if (jpegenc_clk->clk_num < 0)
+		return dev_err_probe(&pdev->dev, jpegenc_clk->clk_num,
+				     "Failed to get jpegenc clock count\n");
+
+	dev->reg_base =
+		devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dev->reg_base))
+		return PTR_ERR(dev->reg_base);
+
+	ret = mtk_jpegenc_hw_init_irq(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++) {
+		if (master_dev->enc_hw_dev[i])
+			continue;
+
+		master_dev->enc_hw_dev[i] = dev;
+		master_dev->reg_encbase[i] = dev->reg_base;
+		dev->master_dev = master_dev;
+	}
+
+	platform_set_drvdata(pdev, dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+struct platform_driver mtk_jpegenc_hw_driver = {
+	.probe = mtk_jpegenc_hw_probe,
+	.driver = {
+		.name = "mtk-jpegenc-hw",
+		.of_match_table = of_match_ptr(mtk_jpegenc_drv_ids),
+	},
+};
+
+module_platform_driver(mtk_jpegenc_hw_driver);
+
+MODULE_DESCRIPTION("MediaTek JPEG encode HW driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0

