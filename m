Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BDD4DC0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiCQIYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiCQIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:24:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A317008F;
        Thu, 17 Mar 2022 01:23:16 -0700 (PDT)
X-UUID: 869f56c1f2e14086a188bec8349ce4b4-20220317
X-UUID: 869f56c1f2e14086a188bec8349ce4b4-20220317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1487373828; Thu, 17 Mar 2022 16:23:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 16:23:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:23:07 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
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
Subject: [PATCH v3, 04/10] media: mtk-vcodec: Enable venc dual core usage
Date:   Thu, 17 Mar 2022 16:22:24 +0800
Message-ID: <20220317082230.23622-5-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317082230.23622-1-irui.wang@mediatek.com>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
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

Adds new property to indicate whether the encoder has multiple cores.

Use of_platform_populate to probe each venc cores, the core device can use
the init_clk/request_irq helper to initialize their own power/clk/irq, and
the main device doesn't need use these helper anymore.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  14 ++
 .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 138 ++++++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_enc_core.h |  36 +++++
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  77 +++++-----
 5 files changed, 235 insertions(+), 34 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.h

diff --git a/drivers/media/platform/mtk-vcodec/Makefile b/drivers/media/platform/mtk-vcodec/Makefile
index 93e7a343b5b0..c472b221bd6b 100644
--- a/drivers/media/platform/mtk-vcodec/Makefile
+++ b/drivers/media/platform/mtk-vcodec/Makefile
@@ -3,7 +3,8 @@
 obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
 				       mtk-vcodec-enc.o \
 				       mtk-vcodec-common.o \
-				       mtk-vcodec-dec-hw.o
+				       mtk-vcodec-dec-hw.o \
+				       mtk-vcodec-enc-core.o
 
 mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
 		vdec/vdec_vp8_if.o \
@@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
 		venc_drv_if.o \
 		venc_vpu_if.o \
 
+mtk-vcodec-enc-core-y := mtk_vcodec_enc_core.o
 
 mtk-vcodec-common-y := mtk_vcodec_intr.o \
 		mtk_vcodec_util.o \
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 3affb2d4a4ec..43e1349d6a54 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -117,6 +117,15 @@ enum mtk_vdec_hw_count {
 	MTK_VDEC_MAX_HW_COUNT,
 };
 
+/*
+ * enum mtk_venc_core_id -- encoder core id
+ */
+enum mtk_venc_core_id {
+	MTK_VENC_CORE0 = 0,
+	MTK_VENC_CORE1,
+	MTK_VENC_CORE_MAX,
+};
+
 /*
  * struct mtk_video_fmt - Structure used to store information about pixelformats
  */
@@ -476,6 +485,8 @@ struct mtk_vcodec_enc_pdata {
  * @subdev_dev: subdev hardware device
  * @subdev_prob_done: check whether all used hw device is prob done
  * @subdev_bitmap: used to record hardware is ready or not
+ * @venc_multi_core: indicates whether the encoder has multiple cores or not
+ * @enc_core_dev: used to store venc core device
  */
 struct mtk_vcodec_dev {
 	struct v4l2_device v4l2_dev;
@@ -521,6 +532,9 @@ struct mtk_vcodec_dev {
 	void *subdev_dev[MTK_VDEC_HW_MAX];
 	int (*subdev_prob_done)(struct mtk_vcodec_dev *vdec_dev);
 	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
+
+	bool venc_multi_core;
+	void *enc_core_dev[MTK_VENC_CORE_MAX];
 };
 
 static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
new file mode 100644
index 000000000000..9d3ea5a8afe4
--- /dev/null
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc.h"
+#include "mtk_vcodec_enc_core.h"
+#include "mtk_vcodec_intr.h"
+
+static const struct of_device_id mtk_venc_core_ids[] = {
+	{
+		.compatible = "mediatek,mtk-venc-core",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_venc_core_ids);
+
+static void clean_irq_status(unsigned int irq_status, void __iomem *addr)
+{
+	if (irq_status & MTK_VENC_IRQ_STATUS_PAUSE)
+		writel(MTK_VENC_IRQ_STATUS_PAUSE, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_SWITCH)
+		writel(MTK_VENC_IRQ_STATUS_SWITCH, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_DRAM)
+		writel(MTK_VENC_IRQ_STATUS_DRAM, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_SPS)
+		writel(MTK_VENC_IRQ_STATUS_SPS, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_PPS)
+		writel(MTK_VENC_IRQ_STATUS_PPS, addr);
+
+	if (irq_status & MTK_VENC_IRQ_STATUS_FRM)
+		writel(MTK_VENC_IRQ_STATUS_FRM, addr);
+}
+
+static irqreturn_t mtk_enc_core_irq_handler(int irq, void *priv)
+{
+	struct mtk_venc_core_dev *core = priv;
+	struct mtk_vcodec_ctx *ctx;
+	unsigned long flags;
+	void __iomem *addr;
+
+	spin_lock_irqsave(&core->main_dev->irqlock, flags);
+	ctx = core->curr_ctx;
+	spin_unlock_irqrestore(&core->main_dev->irqlock, flags);
+	if (!ctx)
+		return IRQ_HANDLED;
+
+	mtk_v4l2_debug(1, "id=%d core :%d", ctx->id, core->core_id);
+
+	addr = core->reg_base + MTK_VENC_IRQ_ACK_OFFSET;
+	ctx->irq_status = readl(core->reg_base + MTK_VENC_IRQ_STATUS_OFFSET);
+	clean_irq_status(ctx->irq_status, addr);
+
+	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	return IRQ_HANDLED;
+}
+
+static int mtk_venc_core_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_venc_core_dev *core;
+	struct mtk_vcodec_dev *main_dev;
+	int ret;
+
+	if (!dev->parent)
+		return dev_err_probe(dev, -ENODEV,
+				     "No parent for venc core device\n");
+
+	main_dev = dev_get_drvdata(dev->parent);
+	if (!main_dev)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get parent driver data\n");
+
+	core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to get alloc core data\n");
+
+	core->plat_dev = pdev;
+
+	platform_set_drvdata(pdev, core);
+
+	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(core->reg_base))
+		return dev_err_probe(dev, PTR_ERR(core->reg_base),
+				     "Failed to get reg base\n");
+
+	core->enc_irq = platform_get_irq(pdev, 0);
+	if (core->enc_irq < 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get irq resource\n");
+
+	ret = devm_request_irq(dev, core->enc_irq,
+			       mtk_enc_core_irq_handler, 0,
+			       pdev->name, core);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to install core->enc_irq %d\n",
+				     core->enc_irq);
+
+	of_property_read_u32(dev->of_node, "mediatek,core-id",
+			     &core->core_id);
+
+	if (core->core_id < 0 || core->core_id >= MTK_VENC_CORE_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid core id %d\n", core->core_id);
+
+	main_dev->enc_core_dev[core->core_id] = core;
+	core->main_dev = main_dev;
+
+	dev_dbg(dev, "Venc core :%d probe done\n", core->core_id);
+
+	return 0;
+}
+
+static struct platform_driver mtk_venc_core_driver = {
+	.probe  = mtk_venc_core_probe,
+	.driver = {
+		.name	 = "mtk-venc-core",
+		.of_match_table = mtk_venc_core_ids,
+	},
+};
+module_platform_driver(mtk_venc_core_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek video encoder core driver");
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.h
new file mode 100644
index 000000000000..9c0f661509df
--- /dev/null
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef _MTK_VCODEC_ENC_CORE_H_
+#define _MTK_VCODEC_ENC_CORE_H_
+
+#include <linux/platform_device.h>
+#include "mtk_vcodec_drv.h"
+
+/**
+ * struct mtk_venc_core_dev - driver data
+ * @plat_dev: platform_device
+ * @main_dev: main device
+ * @pm: power management data
+ * @curr_ctx: the context that is waiting for venc hardware
+ * @reg_base: mapped address of venc registers
+ * @irq_status: venc core irq status
+ * @enc_irq: venc device irq
+ * @core id: for venc core id: core#0, core#1...
+ */
+struct mtk_venc_core_dev {
+	struct platform_device *plat_dev;
+	struct mtk_vcodec_dev *main_dev;
+
+	struct mtk_vcodec_pm pm;
+	struct mtk_vcodec_ctx *curr_ctx;
+
+	void __iomem *reg_base;
+	unsigned int irq_status;
+	int enc_irq;
+	int core_id;
+};
+
+#endif /* _MTK_VCODEC_ENC_CORE_H_ */
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index f12f887e4bdc..d540d52191d9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -230,10 +230,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dev *dev;
 	struct video_device *vfd_enc;
-	struct resource *res;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
-	int ret;
+	int ret, core_type;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -259,39 +258,48 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->fw_handler);
 
 	dev->venc_pdata = of_device_get_match_data(&pdev->dev);
-	ret = mtk_vcodec_init_enc_clk(dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get mtk vcodec clock source!");
-		goto err_enc_pm;
+	core_type = dev->venc_pdata->core_type;
+
+	if (of_property_read_bool(pdev->dev.of_node,
+				  "mediatek,venc-multi-core")) {
+		dev->venc_multi_core = true;
+		ret = of_platform_populate(pdev->dev.of_node,
+					   NULL, NULL, &pdev->dev);
+		if (ret) {
+			mtk_v4l2_err("Venc main device populate failed");
+			goto err_enc_pm;
+		}
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	if (!dev->venc_multi_core) {
+		ret = mtk_vcodec_init_enc_clk(dev);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to get mtk vcodec clock source!");
+			goto err_enc_pm;
+		}
 
-	dev->reg_base[dev->venc_pdata->core_type] =
-		devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(dev->reg_base[dev->venc_pdata->core_type])) {
-		ret = PTR_ERR(dev->reg_base[dev->venc_pdata->core_type]);
-		goto err_res;
-	}
+		pm_runtime_enable(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get irq resource");
-		ret = -ENOENT;
-		goto err_res;
-	}
+		dev->reg_base[core_type] =
+			devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(dev->reg_base[core_type])) {
+			ret = PTR_ERR(dev->reg_base[core_type]);
+			goto err_res;
+		}
 
-	dev->enc_irq = platform_get_irq(pdev, 0);
-	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
-			       mtk_vcodec_enc_irq_handler,
-			       0, pdev->name, dev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to install dev->enc_irq %d (%d) core_type (%d)",
-			dev->enc_irq, ret, dev->venc_pdata->core_type);
-		ret = -EINVAL;
-		goto err_res;
+		dev->enc_irq = platform_get_irq(pdev, 0);
+		irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
+		ret = devm_request_irq(&pdev->dev, dev->enc_irq,
+				       mtk_vcodec_enc_irq_handler,
+				       0, pdev->name, dev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to install irq %d (%d) core_type (%d)",
+				dev->enc_irq, ret, core_type);
+			ret = -EINVAL;
+			goto err_res;
+		}
 	}
 
 	mutex_init(&dev->enc_mutex);
@@ -358,7 +366,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	}
 
 	mtk_v4l2_debug(0, "encoder %d registered as /dev/video%d",
-		       dev->venc_pdata->core_type, vfd_enc->num);
+		       core_type, vfd_enc->num);
 
 	return 0;
 
@@ -371,7 +379,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 err_enc_alloc:
 	v4l2_device_unregister(&dev->v4l2_dev);
 err_res:
-	pm_runtime_disable(dev->pm.dev);
+	if (!dev->venc_multi_core)
+		pm_runtime_disable(dev->pm.dev);
 err_enc_pm:
 	mtk_vcodec_fw_release(dev->fw_handler);
 	return ret;
@@ -455,7 +464,9 @@ static int mtk_vcodec_enc_remove(struct platform_device *pdev)
 		video_unregister_device(dev->vfd_enc);
 
 	v4l2_device_unregister(&dev->v4l2_dev);
-	pm_runtime_disable(dev->pm.dev);
+	if (!dev->venc_multi_core)
+		pm_runtime_disable(dev->pm.dev);
+
 	mtk_vcodec_fw_release(dev->fw_handler);
 	return 0;
 }
-- 
2.18.0

