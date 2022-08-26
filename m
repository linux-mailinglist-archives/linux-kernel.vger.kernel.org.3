Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25D5A245D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbiHZJ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbiHZJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:29:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F676C2E80;
        Fri, 26 Aug 2022 02:29:18 -0700 (PDT)
X-UUID: c623b7bdbe0c489cac9142e5acd9de97-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=I9LfKFQYOC7619kxdiDGaGaLAxjw4xl4u957f2eS5/s=;
        b=bQOI90paQGGKYnwHHxc+L7plhIXhdIutDarryBXLVvJjUkaQXlPvfA4/RQs6zLhxW9/hYJGSKgYFDbEj8Q55nAbn5xxDqcZM2AUi1vAFjwP1K2c8nkQ5zBx0Cl9Jl/2IxUofZx6MRI0jC9WZwEKKidtpJwMnkPMv26FSp1BbFVo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:62fef3d1-ac11-4227-adaf-240a9a1eb1ec,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:6e59aa55-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c623b7bdbe0c489cac9142e5acd9de97-20220826
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 509807665; Fri, 26 Aug 2022 17:29:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 17:29:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 17:29:10 +0800
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
Subject: [V7,3/8] media: mtk-jpegdec: support jpegdec multi-hardware
Date:   Fri, 26 Aug 2022 17:28:59 +0800
Message-ID: <20220826092904.10283-4-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826092904.10283-1-irui.wang@mediatek.com>
References: <20220826092904.10283-1-irui.wang@mediatek.com>
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

support jpegdec multi-hardware includes HW0/HW1/HW2.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/jpeg/Makefile |   5 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  37 ++++
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 171 ++++++++++++++++++
 3 files changed, 211 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/Makefile b/drivers/media/platform/mediatek/jpeg/Makefile
index 69703db4b0a5..26e84852523e 100644
--- a/drivers/media/platform/mediatek/jpeg/Makefile
+++ b/drivers/media/platform/mediatek/jpeg/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) += mtk_jpeg.o \
-	mtk-jpeg-enc-hw.o
+	mtk-jpeg-enc-hw.o \
+	mtk-jpeg-dec-hw.o
 
 mtk_jpeg-y := mtk_jpeg_core.o \
-		 mtk_jpeg_dec_hw.o \
 		 mtk_jpeg_dec_parse.o
 
 mtk-jpeg-enc-hw-y := mtk_jpeg_enc_hw.o
+mtk-jpeg-dec-hw-y := mtk_jpeg_dec_hw.o
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 716a04a1d397..80af31ba8c3a 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -102,6 +102,13 @@ enum mtk_jpegenc_hw_id {
 	MTK_JPEGENC_HW_MAX,
 };
 
+enum mtk_jpegdec_hw_id {
+	MTK_JPEGDEC_HW0,
+	MTK_JPEGDEC_HW1,
+	MTK_JPEGDEC_HW2,
+	MTK_JPEGDEC_HW_MAX,
+};
+
 /**
  * struct mtk_jpegenc_clk - Structure used to store vcodec clock information
  */
@@ -110,6 +117,14 @@ struct mtk_jpegenc_clk {
 	int clk_num;
 };
 
+/**
+ * struct mtk_jpegdec_clk - Structure used to store vcodec clock information
+ */
+struct mtk_jpegdec_clk {
+	struct clk_bulk_data *clks;
+	int clk_num;
+};
+
 /**
  * struct mtk_jpegenc_comp_dev - JPEG COREX abstraction
  * @dev:		JPEG device
@@ -138,6 +153,24 @@ struct mtk_jpegenc_comp_dev {
 	spinlock_t hw_lock;
 };
 
+/**
+ * struct mtk_jpegdec_comp_dev - JPEG COREX abstraction
+ * @dev:			JPEG device
+ * @plat_dev:			platform device data
+ * @reg_base:			JPEG registers mapping
+ * @master_dev:			mtk_jpeg_dev device
+ * @jdec_clk:			mtk_jpegdec_clk
+ * @jpegdec_irq:		jpeg decode irq num
+ */
+struct mtk_jpegdec_comp_dev {
+	struct device *dev;
+	struct platform_device *plat_dev;
+	void __iomem *reg_base;
+	struct mtk_jpeg_dev *master_dev;
+	struct mtk_jpegdec_clk jdec_clk;
+	int jpegdec_irq;
+};
+
 /**
  * struct mtk_jpeg_dev - JPEG IP abstraction
  * @lock:		the mutex protecting this structure
@@ -170,6 +203,10 @@ struct mtk_jpeg_dev {
 	bool is_jpgenc_multihw;
 	wait_queue_head_t enc_hw_wq;
 	atomic_t enchw_rdy;
+
+	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
+	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
+	bool is_jpgdec_multihw;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index d2f25f43e852..bc48054d847f 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -5,9 +5,24 @@
  *         Rick Chang <rick.chang@mediatek.com>
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
+#include <media/videobuf2-v4l2.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-event.h>
 
 #include "mtk_jpeg_core.h"
 #include "mtk_jpeg_dec_hw.h"
@@ -24,6 +39,16 @@ enum mtk_jpeg_color {
 	MTK_JPEG_COLOR_400		= 0x00110000
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id mtk_jpegdec_hw_ids[] = {
+	{
+		.compatible = "mediatek,mt8195-jpgdec-hw",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_jpegdec_hw_ids);
+#endif
+
 static inline int mtk_jpeg_verify_align(u32 val, int align, u32 reg)
 {
 	if (val & (align - 1)) {
@@ -414,3 +439,149 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 	mtk_jpeg_dec_set_pause_mcu_idx(base, config->total_mcu);
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
+
+static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
+{
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	struct mtk_jpeg_src_buf *jpeg_src_buf;
+	enum vb2_buffer_state buf_state;
+	struct mtk_jpeg_ctx *ctx;
+	u32 dec_irq_ret;
+	u32 irq_status;
+	int i;
+
+	struct mtk_jpegdec_comp_dev *jpeg = priv;
+	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
+
+	irq_status = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
+	dec_irq_ret = mtk_jpeg_dec_enum_result(irq_status);
+	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
+		mtk_jpeg_dec_reset(jpeg->reg_base);
+	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE)
+		return IRQ_NONE;
+
+	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
+	if (!ctx) {
+		dev_err(jpeg->dev, "Context is NULL\n");
+		return IRQ_HANDLED;
+	}
+
+	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+	jpeg_src_buf =
+		container_of(src_buf, struct mtk_jpeg_src_buf, b);
+
+	for (i = 0; i < dst_buf->vb2_buf.num_planes; i++)
+		vb2_set_plane_payload(&dst_buf->vb2_buf, i,
+				      jpeg_src_buf->dec_param.comp_size[i]);
+
+	buf_state = VB2_BUF_STATE_DONE;
+
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	pm_runtime_put(ctx->jpeg->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_jpegdec_hw_init_irq(struct mtk_jpegdec_comp_dev *dev)
+{
+	struct platform_device *pdev = dev->plat_dev;
+	int ret;
+
+	dev->jpegdec_irq = platform_get_irq(pdev, 0);
+	if (dev->jpegdec_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq resource");
+		return dev->jpegdec_irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev,
+			       dev->jpegdec_irq,
+			       mtk_jpegdec_hw_irq_handler,
+			       0,
+			       pdev->name, dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to devm_request_irq %d (%d)",
+			dev->jpegdec_irq, ret);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
+{
+	struct mtk_jpegdec_clk *jpegdec_clk;
+	struct mtk_jpeg_dev *master_dev;
+	struct mtk_jpegdec_comp_dev *dev;
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
+	if (!master_dev->is_jpgdec_multihw) {
+		master_dev->is_jpgdec_multihw = true;
+		for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
+			master_dev->dec_hw_dev[i] = NULL;
+	}
+
+	jpegdec_clk = &dev->jdec_clk;
+
+	jpegdec_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
+						     &jpegdec_clk->clks);
+	if (jpegdec_clk->clk_num < 0)
+		return dev_err_probe(&pdev->dev,
+				      jpegdec_clk->clk_num,
+				      "Failed to get jpegdec clock count.\n");
+
+	dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dev->reg_base))
+		return PTR_ERR(dev->reg_base);
+
+	ret = mtk_jpegdec_hw_init_irq(dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register JPEGDEC irq handler.\n");
+
+	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++) {
+		if (master_dev->dec_hw_dev[i])
+			continue;
+
+		master_dev->dec_hw_dev[i] = dev;
+		master_dev->reg_decbase[i] = dev->reg_base;
+		dev->master_dev = master_dev;
+	}
+
+	platform_set_drvdata(pdev, dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+struct platform_driver mtk_jpegdec_hw_driver = {
+	.probe = mtk_jpegdec_hw_probe,
+	.driver = {
+		.name = "mtk-jpegdec-hw",
+		.of_match_table = of_match_ptr(mtk_jpegdec_hw_ids),
+	},
+};
+
+module_platform_driver(mtk_jpegdec_hw_driver);
+
+MODULE_DESCRIPTION("MediaTek JPEG decode HW driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0

