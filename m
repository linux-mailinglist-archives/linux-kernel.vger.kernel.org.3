Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19C5495798
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiAUBGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:06:19 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:19483 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235588AbiAUBGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:06:15 -0500
X-IronPort-AV: E=Sophos;i="5.88,303,1635174000"; 
   d="scan'208";a="107750920"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Jan 2022 10:06:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 19404417762A;
        Fri, 21 Jan 2022 10:06:08 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v2 3/4] media: platform: Add CRU driver for RZ/G2L SoC
Date:   Fri, 21 Jan 2022 01:05:42 +0000
Message-Id: <20220121010543.31385-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.

Based on a patch in the BSP by Hien Huynh
<hien.huynh.px@renesas.com>

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Dropped group
* Dropped CSI subdev and implemented as new driver
* Dropped "mc_" from function names
* Moved the driver to renesas folder
---
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   2 +
 .../media/platform/renesas/rzg2l-cru/Kconfig  |  15 +
 .../media/platform/renesas/rzg2l-cru/Makefile |   4 +
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 432 +++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 155 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-dma.c    | 722 ++++++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-v4l2.c   | 360 +++++++++
 8 files changed, 1691 insertions(+)
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index cf4adc64c953..4251c5686c2a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -169,6 +169,7 @@ source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/rcar-vin/Kconfig"
+source "drivers/media/platform/renesas/rzg2l-cru/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index a148553babfc..021d30a2c66c 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -66,6 +66,8 @@ obj-$(CONFIG_VIDEO_XILINX)		+= xilinx/
 obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
 obj-$(CONFIG_VIDEO_RCAR_VIN)		+= rcar-vin/
 
+obj-$(CONFIG_VIDEO_RZG2L_CRU)		+= renesas/rzg2l-cru/
+
 obj-$(CONFIG_VIDEO_ATMEL_ISC)		+= atmel/
 obj-$(CONFIG_VIDEO_ATMEL_ISI)		+= atmel/
 obj-$(CONFIG_VIDEO_ATMEL_XISC)		+= atmel/
diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
new file mode 100644
index 000000000000..310baa4d4c14
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config VIDEO_RZG2L_CRU
+	tristate "RZ/G2L Camera Receiving Unit (CRU) Driver"
+	depends on VIDEO_V4L2 && OF
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  Support for Renesas RZ/G2L Camera Receiving Unit (CRU) driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzg2l-cru.
diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
new file mode 100644
index 000000000000..8c307075f131
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+rzg2l-cru-objs = rzg2l-core.o rzg2l-dma.o rzg2l-v4l2.o
+
+obj-$(CONFIG_VIDEO_RZG2L_CRU) += rzg2l-cru.o
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
new file mode 100644
index 000000000000..881bedaaff8f
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Renesas RZ/G2L CRU
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ * Based on Renesas R-Car VIN
+ * Copyright (C) 2011-2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
+ * Copyright (C) 2008 Magnus Damm
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#include <media/v4l2-async.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mc.h>
+
+#include "rzg2l-cru.h"
+
+#define v4l2_dev_to_cru(d)	container_of(d, struct rzg2l_cru_dev, v4l2_dev)
+
+static int rzg2l_cru_csi2_link_notify(struct media_link *link, u32 flags,
+				      unsigned int notification)
+{
+	struct media_entity *entity;
+	struct rzg2l_cru_dev *cru;
+	struct video_device *vdev;
+	struct media_pad *csi_pad;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	ret = v4l2_pipeline_link_notify(link, flags, notification);
+	if (ret)
+		return ret;
+
+	/* Only care about link enablement for CRU nodes. */
+	if (!(flags & MEDIA_LNK_FL_ENABLED) ||
+	    !is_media_entity_v4l2_video_device(link->sink->entity))
+		return 0;
+
+	cru = container_of(link->graph_obj.mdev, struct rzg2l_cru_dev, mdev);
+	/*
+	 * Don't allow link changes if any entity in the graph is
+	 * streaming, modifying the CHSEL register fields can disrupt
+	 * running streams.
+	 */
+	media_device_for_each_entity(entity, &cru->mdev)
+		if (entity->pads->stream_count)
+			return -EBUSY;
+
+	mutex_lock(&cru->mdev_lock);
+	vdev = media_entity_to_video_device(link->sink->entity);
+
+	csi_pad = media_entity_remote_pad(&cru->vdev.entity.pads[0]);
+	if (csi_pad) {
+		ret = -EMLINK;
+		goto out;
+	}
+
+	sd = media_entity_to_v4l2_subdev(link->source->entity);
+	if (cru->csi.subdev == sd) {
+		cru->csi.channel = link->source->index - 1;
+		cru->is_csi = true;
+	} else {
+		ret = -ENODEV;
+	}
+
+out:
+	mutex_unlock(&cru->mdev_lock);
+
+	return ret;
+}
+
+static const struct media_device_ops rzg2l_cru_media_ops = {
+	.link_notify = rzg2l_cru_csi2_link_notify,
+};
+
+static void rzg2l_cru_put(struct rzg2l_cru_dev *cru)
+{
+	mutex_lock(&cru->mdev_lock);
+	cru->v4l2_dev.mdev = NULL;
+	mutex_unlock(&cru->mdev_lock);
+}
+
+/* -----------------------------------------------------------------------------
+ * Group async notifier
+ */
+
+static int rzg2l_cru_group_notify_complete(struct v4l2_async_notifier *notifier)
+{
+	struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
+	unsigned int i;
+	int ret;
+
+	ret = media_device_register(&cru->mdev);
+	if (ret)
+		return ret;
+
+	ret = v4l2_device_register_subdev_nodes(&cru->v4l2_dev);
+	if (ret) {
+		dev_err(cru->dev, "Failed to register subdev nodes\n");
+		return ret;
+	}
+
+	if (!video_is_registered(&cru->vdev)) {
+		ret = rzg2l_cru_v4l2_register(cru);
+		if (ret)
+			return ret;
+	}
+
+	/* Create all media device links between CRU and CSI-2's. */
+	for (i = 1; i <= CSI2_VCHANNEL; i++) {
+		struct media_entity *source, *sink;
+
+		source = &cru->csi.subdev->entity;
+		sink = &cru->vdev.entity;
+
+		ret = media_create_pad_link(source, i, sink, 0, 0);
+		if (ret) {
+			dev_err(cru->dev, "Error adding link from %s to %s\n",
+				source->name, sink->name);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void rzg2l_cru_group_notify_unbind(struct v4l2_async_notifier *notifier,
+					  struct v4l2_subdev *subdev,
+					  struct v4l2_async_subdev *asd)
+{
+	struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
+
+	rzg2l_cru_v4l2_unregister(cru);
+
+	mutex_lock(&cru->mdev_lock);
+
+	if (cru->csi.asd == asd) {
+		cru->csi.subdev = NULL;
+		dev_dbg(cru->dev, "Unbind CSI-2 %s\n", subdev->name);
+	}
+
+	mutex_unlock(&cru->mdev_lock);
+
+	media_device_unregister(&cru->mdev);
+}
+
+static int rzg2l_cru_group_notify_bound(struct v4l2_async_notifier *notifier,
+					struct v4l2_subdev *subdev,
+					struct v4l2_async_subdev *asd)
+{
+	struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
+	unsigned int i;
+
+	mutex_lock(&cru->mdev_lock);
+
+	if (cru->csi.asd == asd) {
+		cru->csi.subdev = subdev;
+		dev_dbg(cru->dev, "Bound CSI-2 %s to slot %u\n", subdev->name, i);
+	}
+
+	mutex_unlock(&cru->mdev_lock);
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations rzg2l_cru_async_ops = {
+	.bound = rzg2l_cru_group_notify_bound,
+	.unbind = rzg2l_cru_group_notify_unbind,
+	.complete = rzg2l_cru_group_notify_complete,
+};
+
+static int rvin_mc_parse_of(struct rzg2l_cru_dev *cru, unsigned int id)
+{
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY,
+	};
+	struct fwnode_handle *ep, *fwnode;
+	struct v4l2_async_subdev *asd;
+	int ret;
+
+	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(cru->dev), 1, id, 0);
+	if (!ep)
+		return 0;
+
+	fwnode = fwnode_graph_get_remote_endpoint(ep);
+	ret = v4l2_fwnode_endpoint_parse(ep, &vep);
+	fwnode_handle_put(ep);
+	if (ret) {
+		dev_err(cru->dev, "Failed to parse %pOF\n", to_of_node(fwnode));
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!of_device_is_available(to_of_node(fwnode))) {
+		dev_dbg(cru->dev, "OF device %pOF disabled, ignoring\n",
+			to_of_node(fwnode));
+		ret = -ENOTCONN;
+		goto out;
+	}
+
+	asd = v4l2_async_nf_add_fwnode(&cru->notifier, fwnode,
+				       struct v4l2_async_subdev);
+	if (IS_ERR(asd)) {
+		ret = PTR_ERR(asd);
+		goto out;
+	}
+
+	cru->csi.asd = asd;
+
+	dev_dbg(cru->dev, "Added OF device %pOF to slot %u\n",
+		to_of_node(fwnode), vep.base.id);
+out:
+	fwnode_handle_put(fwnode);
+
+	return ret;
+}
+
+static int rzg2l_cru_mc_parse_of_graph(struct rzg2l_cru_dev *cru)
+{
+	int ret;
+
+	v4l2_async_nf_init(&cru->notifier);
+
+	ret = rvin_mc_parse_of(cru, 0);
+	if (ret)
+		return ret;
+
+	cru->notifier.ops = &rzg2l_cru_async_ops;
+
+	if (list_empty(&cru->notifier.asd_list))
+		return 0;
+
+	ret = v4l2_async_nf_register(&cru->v4l2_dev, &cru->notifier);
+	if (ret < 0) {
+		dev_err(cru->dev, "Notifier registration failed\n");
+		v4l2_async_nf_cleanup(&cru->notifier);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rzg2l_cru_csi2_init(struct rzg2l_cru_dev *cru)
+{
+	struct media_device *mdev = NULL;
+	const struct of_device_id *match;
+	int ret;
+
+	cru->pad.flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_pads_init(&cru->vdev.entity, 1, &cru->pad);
+	if (ret)
+		return ret;
+
+	mutex_init(&cru->mdev_lock);
+	mdev = &cru->mdev;
+	mdev->dev = cru->dev;
+	mdev->ops = &rzg2l_cru_media_ops;
+
+	match = of_match_node(cru->dev->driver->of_match_table,
+			      cru->dev->of_node);
+
+	strscpy(mdev->driver_name, KBUILD_MODNAME, sizeof(mdev->driver_name));
+	strscpy(mdev->model, match->compatible, sizeof(mdev->model));
+	snprintf(mdev->bus_info, sizeof(mdev->bus_info), "platform:%s",
+		 dev_name(mdev->dev));
+
+	cru->v4l2_dev.mdev = &cru->mdev;
+
+	media_device_init(mdev);
+
+	ret = rzg2l_cru_mc_parse_of_graph(cru);
+	if (ret)
+		rzg2l_cru_put(cru);
+
+	return 0;
+}
+
+static int rzg2l_cru_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct rzg2l_cru_dev *cru = container_of(ctrl->handler,
+						 struct rzg2l_cru_dev,
+						 ctrl_handler);
+	int ret = 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
+		if (cru->state == RZG2L_CRU_DMA_STOPPED ||
+		    cru->state == RZG2L_CRU_DMA_STOPPING)
+			cru->num_buf = ctrl->val;
+		else
+			ret = -EBUSY;
+
+		break;
+	}
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops rzg2l_cru_ctrl_ops = {
+	.s_ctrl = rzg2l_cru_s_ctrl,
+};
+
+static int rzg2l_cru_probe(struct platform_device *pdev)
+{
+	struct rzg2l_cru_dev *cru;
+	struct v4l2_ctrl *ctrl;
+	int irq, ret;
+
+	cru = devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
+	if (!cru)
+		return -ENOMEM;
+
+	cru->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cru->base))
+		return PTR_ERR(cru->base);
+
+	cru->presetn = devm_reset_control_get(&pdev->dev, "presetn");
+	if (IS_ERR(cru->presetn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cru->presetn),
+				     "failed to get cpg presetn\n");
+
+	cru->aresetn = devm_reset_control_get(&pdev->dev, "aresetn");
+	if (IS_ERR(cru->aresetn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cru->aresetn),
+				     "failed to get cpg aresetn\n");
+
+	cru->dev = &pdev->dev;
+	cru->info = of_device_get_match_data(&pdev->dev);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = rzg2l_cru_dma_register(cru, irq);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, cru);
+
+	ret = rzg2l_cru_csi2_init(cru);
+	if (ret)
+		goto error_dma_unregister;
+
+	v4l2_ctrl_handler_init(&cru->ctrl_handler, 1);
+	ctrl = v4l2_ctrl_new_std(&cru->ctrl_handler, &rzg2l_cru_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,
+				 1, HW_BUFFER_MAX, 1, HW_BUFFER_DEFAULT);
+	if (cru->ctrl_handler.error) {
+		dev_err(&pdev->dev, "%s: control initialization error %d\n",
+			__func__, cru->ctrl_handler.error);
+		ret = cru->ctrl_handler.error;
+		goto free_ctrl;
+	}
+
+	ctrl->flags &= ~V4L2_CTRL_FLAG_READ_ONLY;
+	cru->v4l2_dev.ctrl_handler = &cru->ctrl_handler;
+
+	cru->num_buf = HW_BUFFER_DEFAULT;
+
+	pm_suspend_ignore_children(&pdev->dev, true);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+free_ctrl:
+	v4l2_ctrl_handler_free(&cru->ctrl_handler);
+error_dma_unregister:
+	rzg2l_cru_dma_unregister(cru);
+
+	return ret;
+}
+
+static const struct rzg2l_cru_info rzg2l_cru_info_generic = {
+	.max_width = 2800,
+	.max_height = 4096,
+};
+
+static const struct of_device_id rzg2l_cru_of_id_table[] = {
+	{
+		.compatible = "renesas,rzg2l-cru",
+		.data = &rzg2l_cru_info_generic,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_cru_of_id_table);
+
+static int rzg2l_cru_remove(struct platform_device *pdev)
+{
+	struct rzg2l_cru_dev *cru = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	rzg2l_cru_v4l2_unregister(cru);
+
+	v4l2_async_nf_unregister(&cru->notifier);
+	v4l2_async_nf_cleanup(&cru->notifier);
+
+	media_device_cleanup(&cru->mdev);
+	mutex_destroy(&cru->mdev_lock);
+	cru->v4l2_dev.mdev = NULL;
+
+	v4l2_ctrl_handler_free(&cru->ctrl_handler);
+	cru->vdev.ctrl_handler = NULL;
+
+	rzg2l_cru_dma_unregister(cru);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_cru_driver = {
+	.driver = {
+		.name = "rzg2l-cru",
+		.of_match_table = rzg2l_cru_of_id_table,
+	},
+	.probe = rzg2l_cru_probe,
+	.remove = rzg2l_cru_remove,
+};
+
+module_platform_driver(rzg2l_cru_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G2L CRU driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
new file mode 100644
index 000000000000..91a28279846e
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Driver for Renesas RZ/G2L CRU
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __RZG2L_CRU__
+#define __RZG2L_CRU__
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+#include <media/v4l2-async.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+
+/* Number of HW buffers */
+#define HW_BUFFER_MAX		8
+#define HW_BUFFER_DEFAULT	3
+
+/* Address alignment mask for HW buffers */
+#define HW_BUFFER_MASK		0x1ff
+
+/* Maximum number of CSI2 virtual channels */
+#define CSI2_VCHANNEL		4
+
+/**
+ * enum rzg2l_cru_dma_state - DMA states
+ * @RZG2L_CRU_DMA_STOPPED:   No operation in progress
+ * @RZG2L_CRU_DMA_STARTING:  Capture starting up
+ * @RZG2L_CRU_DMA_RUNNING:   Operation in progress have buffers
+ * @RZG2L_CRU_DMA_STOPPING:  Stopping operation
+ */
+enum rzg2l_cru_dma_state {
+	RZG2L_CRU_DMA_STOPPED = 0,
+	RZG2L_CRU_DMA_STARTING,
+	RZG2L_CRU_DMA_RUNNING,
+	RZG2L_CRU_DMA_STOPPING,
+};
+
+/**
+ * struct rzg2l_cru_info - Information about the particular CRU implementation
+ * @max_width:	max input width the CRU supports
+ * @max_height:	max input height the CRU supports
+ */
+struct rzg2l_cru_info {
+	unsigned int max_width;
+	unsigned int max_height;
+};
+
+struct rzg2l_cru_csi {
+	struct v4l2_async_subdev *asd;
+	struct v4l2_subdev *subdev;
+	u32 channel;
+};
+
+/**
+ * struct rzg2l_cru_dev - Renesas CRU device structure
+ * @dev:		(OF) device
+ * @base:		device I/O register space remapped to virtual memory
+ * @info:		info about CRU instance
+ *
+ * @presetn:		CRU_PRESETN reset line
+ * @aresetn:		CRU_ARESETN reset line
+ *
+ * @vdev:		V4L2 video device associated with CRU
+ * @v4l2_dev:		V4L2 device
+ * @ctrl_handler:	V4L2 control handler
+ * @num_buf:		Holds the current number of buffers enabled
+ * @notifier:		V4L2 asynchronous subdevs notifier
+ *
+ * @csi:		CSI info
+ * @mdev:		media device
+ * @mdev_lock:		protects the count, notifier and csi members
+ * @pad:		media pad for the video device entity
+ *
+ * @lock:		protects @queue
+ * @queue:		vb2 buffers queue
+ * @scratch:		cpu address for scratch buffer
+ * @scratch_phys:	physical address of the scratch buffer
+ *
+ * @qlock:		protects @queue_buf, @buf_list, @sequence
+ *			@state
+ * @queue_buf:		Keeps track of buffers given to HW slot
+ * @buf_list:		list of queued buffers
+ * @sequence:		V4L2 buffers sequence number
+ * @state:		keeps track of operation state
+ *
+ * @is_csi:		flag to mark the CRU as using a CSI-2 subdevice
+ *
+ * @input_is_yuv:	flag to mark the input format of CRU
+ * @output_is_yuv:	flag to mark the output format of CRU
+ *
+ * @mbus_code:		media bus format code
+ * @format:		active V4L2 pixel format
+ *
+ * @compose:		active composing
+ * @source:		active size of the video source
+ * @std:		active video standard of the video source
+ */
+struct rzg2l_cru_dev {
+	struct device *dev;
+	void __iomem *base;
+	const struct rzg2l_cru_info *info;
+
+	struct reset_control *presetn;
+	struct reset_control *aresetn;
+
+	struct video_device vdev;
+	struct v4l2_device v4l2_dev;
+	struct v4l2_ctrl_handler ctrl_handler;
+	u8 num_buf;
+
+	struct v4l2_async_notifier notifier;
+
+	struct rzg2l_cru_csi csi;
+	struct media_device mdev;
+	struct mutex mdev_lock;
+	struct media_pad pad;
+
+	struct mutex lock;
+	struct vb2_queue queue;
+	void *scratch;
+	dma_addr_t scratch_phys;
+
+	spinlock_t qlock;
+	struct vb2_v4l2_buffer *queue_buf[HW_BUFFER_MAX];
+	struct list_head buf_list;
+	unsigned int sequence;
+	enum rzg2l_cru_dma_state state;
+
+	bool is_csi;
+
+	bool input_is_yuv;
+	bool output_is_yuv;
+
+	u32 mbus_code;
+	struct v4l2_pix_format format;
+
+	struct v4l2_rect compose;
+};
+
+int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru, int irq);
+void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru);
+
+int rzg2l_cru_v4l2_register(struct rzg2l_cru_dev *cru);
+void rzg2l_cru_v4l2_unregister(struct rzg2l_cru_dev *cru);
+
+const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format);
+
+#endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
new file mode 100644
index 000000000000..0fcf4baccca9
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Renesas RZ/G2L CRU
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ * Based on Renesas R-Car VIN
+ * Copyright (C) 2011-2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
+ * Copyright (C) 2008 Magnus Damm
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+
+#include <media/videobuf2-dma-contig.h>
+
+#include "rzg2l-cru.h"
+
+/* HW CRU Registers Definition */
+/* CRU Control Register */
+#define CRUnCTRL			0x0
+#define CRUnCTRL_VINSEL(x)		((x) << 0)
+
+/* CRU Interrupt Enable Register */
+#define CRUnIE				0x4
+#define CRUnIE_SFE			BIT(16)
+#define CRUnIE_EFE			BIT(17)
+
+/* CRU Interrupt Status Register */
+#define CRUnINTS			0x8
+#define CRUnINTS_SFS			BIT(16)
+
+/* CRU Reset Register */
+#define CRUnRST				0xc
+#define CRUnRST_VRESETN			BIT(0)
+
+/* Memory Bank Base Address (Lower) Register for CRU Image Data */
+#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
+
+/* Memory Bank Base Address (Higher) Register for CRU Image Data */
+#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
+
+/* Memory Bank Enable Register for CRU Image Data */
+#define AMnMBVALID			0x148
+#define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
+
+/* Memory Bank Status Register for CRU Image Data */
+#define AMnMBS				0x14c
+#define AMnMBS_MBSTS			0x7
+
+/* AXI Master FIFO Pointer Register for CRU Image Data */
+#define AMnFIFOPNTR			0x168
+#define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
+#define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
+
+/* AXI Master Transfer Stop Register for CRU Image Data */
+#define AMnAXISTP			0x174
+#define AMnAXISTP_AXI_STOP		BIT(0)
+
+/* AXI Master Transfer Stop Status Register for CRU Image Data */
+#define AMnAXISTPACK			0x178
+#define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
+
+/* CRU Image Processing Enable Register */
+#define ICnEN				0x200
+#define ICnEN_ICEN			BIT(0)
+
+/* CRU Image Processing Main Control Register */
+#define ICnMC				0x208
+#define ICnMC_CSCTHR			BIT(5)
+#define ICnMC_INF_YUV8_422		(0x1e << 16)
+#define ICnMC_INF_USER			(0x30 << 16)
+#define ICnMC_VCSEL(x)			((x) << 22)
+#define ICnMC_INF_MASK			GENMASK(21, 16)
+
+/* CRU Module Status Register */
+#define ICnMS				0x254
+#define ICnMS_IA			BIT(2)
+
+/* CRU Data Output Mode Register */
+#define ICnDMR				0x26c
+#define ICnDMR_YCMODE_UYVY		(1 << 4)
+
+#define RZG2L_TIMEOUT_MS		100
+#define RZG2L_RETRIES			10
+
+struct rzg2l_cru_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head list;
+};
+
+#define to_buf_list(vb2_buffer) (&container_of(vb2_buffer, \
+						struct rzg2l_cru_buffer, \
+						vb)->list)
+
+static void rzg2l_cru_write(struct rzg2l_cru_dev *cru, u32 offset, u32 value)
+{
+	iowrite32(value, cru->base + offset);
+}
+
+static u32 rzg2l_cru_read(struct rzg2l_cru_dev *cru, u32 offset)
+{
+	return ioread32(cru->base + offset);
+}
+
+/* Need to hold qlock before calling */
+static void return_unused_buffers(struct rzg2l_cru_dev *cru,
+				  enum vb2_buffer_state state)
+{
+	struct rzg2l_cru_buffer *buf, *node;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&cru->qlock, flags);
+	for (i = 0; i < cru->num_buf; i++) {
+		if (cru->queue_buf[i]) {
+			vb2_buffer_done(&cru->queue_buf[i]->vb2_buf,
+					state);
+			cru->queue_buf[i] = NULL;
+		}
+	}
+
+	list_for_each_entry_safe(buf, node, &cru->buf_list, list) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->list);
+	}
+	spin_unlock_irqrestore(&cru->qlock, flags);
+}
+
+static int rzg2l_cru_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
+				 unsigned int *nplanes, unsigned int sizes[],
+				 struct device *alloc_devs[])
+{
+	struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
+
+	/* Make sure the image size is large enough. */
+	if (*nplanes)
+		return sizes[0] < cru->format.sizeimage ? -EINVAL : 0;
+
+	*nplanes = 1;
+	sizes[0] = cru->format.sizeimage;
+
+	return 0;
+};
+
+static int rzg2l_cru_buffer_prepare(struct vb2_buffer *vb)
+{
+	struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long size = cru->format.sizeimage;
+
+	if (vb2_plane_size(vb, 0) < size) {
+		dev_err(cru->dev, "buffer too small (%lu < %lu)\n",
+			vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb, 0, size);
+
+	return 0;
+}
+
+static void rzg2l_cru_buffer_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cru->qlock, flags);
+
+	list_add_tail(to_buf_list(vbuf), &cru->buf_list);
+
+	spin_unlock_irqrestore(&cru->qlock, flags);
+}
+
+static int rzg2l_cru_mc_validate_format(struct rzg2l_cru_dev *cru,
+					struct v4l2_subdev *sd,
+					struct media_pad *pad)
+{
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+
+	fmt.pad = pad->index;
+	fmt.stream = 0;
+	if (v4l2_subdev_call(sd, pad, get_fmt, v4l2_subdev_get_active_state(sd), &fmt))
+		return -EPIPE;
+
+	if (cru->is_csi) {
+		switch (fmt.format.code) {
+		case MEDIA_BUS_FMT_UYVY8_2X8:
+			break;
+		default:
+			return -EPIPE;
+		}
+	}
+	cru->mbus_code = fmt.format.code;
+
+	switch (fmt.format.field) {
+	case V4L2_FIELD_TOP:
+	case V4L2_FIELD_BOTTOM:
+	case V4L2_FIELD_NONE:
+	case V4L2_FIELD_INTERLACED_TB:
+	case V4L2_FIELD_INTERLACED_BT:
+	case V4L2_FIELD_INTERLACED:
+	case V4L2_FIELD_SEQ_TB:
+	case V4L2_FIELD_SEQ_BT:
+		break;
+	default:
+		return -EPIPE;
+	}
+
+	if (fmt.format.width != cru->format.width ||
+	    fmt.format.height != cru->format.height ||
+	    fmt.format.code != cru->mbus_code)
+		return -EPIPE;
+
+	return 0;
+}
+
+static void rzg2l_cru_set_slot_addr(struct rzg2l_cru_dev *cru,
+				    int slot, dma_addr_t addr)
+{
+	const struct v4l2_format_info *fmt;
+	int offsetx, offsety;
+	dma_addr_t offset;
+
+	fmt = rzg2l_cru_format_from_pixel(cru->format.pixelformat);
+
+	/*
+	 * There is no HW support for composition do the best we can
+	 * by modifying the buffer offset
+	 */
+	offsetx = cru->compose.left * fmt->bpp[0];
+	offsety = cru->compose.top * cru->format.bytesperline;
+	offset = addr + offsetx + offsety;
+
+	/*
+	 * The address needs to be 512 bytes aligned. Driver should never accept
+	 * settings that do not satisfy this in the first place...
+	 */
+	if (WARN_ON((offsetx | offsety | offset) & HW_BUFFER_MASK))
+		return;
+
+	/* Currently, we just use the buffer in 32 bits address */
+	rzg2l_cru_write(cru, AMnMBxADDRL(slot), offset);
+	rzg2l_cru_write(cru, AMnMBxADDRH(slot), 0);
+}
+
+/*
+ * Moves a buffer from the queue to the HW slot. If no buffer is
+ * available use the scratch buffer. The scratch buffer is never
+ * returned to userspace, its only function is to enable the capture
+ * loop to keep running.
+ */
+static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev *cru, int slot)
+{
+	struct vb2_v4l2_buffer *vbuf;
+	struct rzg2l_cru_buffer *buf;
+	dma_addr_t phys_addr;
+
+	/* A already populated slot shall never be overwritten. */
+	if (WARN_ON(cru->queue_buf[slot]))
+		return;
+
+	dev_dbg(cru->dev, "Filling HW slot: %d\n", slot);
+
+	if (list_empty(&cru->buf_list)) {
+		cru->queue_buf[slot] = NULL;
+		phys_addr = cru->scratch_phys;
+	} else {
+		/* Keep track of buffer we give to HW */
+		buf = list_entry(cru->buf_list.next,
+				 struct rzg2l_cru_buffer, list);
+		vbuf = &buf->vb;
+		list_del_init(to_buf_list(vbuf));
+		cru->queue_buf[slot] = vbuf;
+
+		/* Setup DMA */
+		phys_addr = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
+	}
+
+	rzg2l_cru_set_slot_addr(cru, slot, phys_addr);
+}
+
+static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
+{
+	unsigned int slot;
+
+	/*
+	 * Set image data memory banks.
+	 * Currently, we will use maximum address.
+	 */
+	rzg2l_cru_write(cru, AMnMBVALID, AMnMBVALID_MBVALID(cru->num_buf - 1));
+
+	for (slot = 0; slot < cru->num_buf; slot++)
+		rzg2l_cru_fill_hw_slot(cru, slot);
+}
+
+static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru)
+{
+	u32 icnmc;
+
+	switch (cru->mbus_code) {
+	case MEDIA_BUS_FMT_UYVY8_2X8:
+		icnmc = ICnMC_INF_YUV8_422;
+		cru->input_is_yuv = true;
+		break;
+	default:
+		cru->input_is_yuv = false;
+		icnmc = ICnMC_INF_USER;
+		break;
+	}
+
+	icnmc |= (rzg2l_cru_read(cru, ICnMC) & ~ICnMC_INF_MASK);
+
+	/* Set virtual channel CSI2 */
+	icnmc |= ICnMC_VCSEL(cru->csi.channel);
+
+	rzg2l_cru_write(cru, ICnMC, icnmc);
+}
+
+static int rzg2l_cru_initialize_image_conv(struct rzg2l_cru_dev *cru)
+{
+	u32 icndmr;
+
+	if (cru->is_csi)
+		rzg2l_cru_csi2_setup(cru);
+
+	/* Output format */
+	switch (cru->format.pixelformat) {
+	case V4L2_PIX_FMT_UYVY:
+		icndmr = ICnDMR_YCMODE_UYVY;
+		cru->output_is_yuv = true;
+		break;
+	default:
+		dev_err(cru->dev, "Invalid pixelformat (0x%x)\n",
+			cru->format.pixelformat);
+		return -EINVAL;
+	}
+
+	/* If input and output use same colorspace, do bypass mode */
+	if (cru->output_is_yuv == cru->input_is_yuv)
+		rzg2l_cru_write(cru, ICnMC,
+				rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
+	else
+		rzg2l_cru_write(cru, ICnMC,
+				rzg2l_cru_read(cru, ICnMC) & (~ICnMC_CSCTHR));
+
+	/* Set output data format */
+	rzg2l_cru_write(cru, ICnDMR, icndmr);
+
+	return 0;
+}
+
+static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
+{
+	struct media_pipeline *pipe;
+	struct v4l2_subdev *sd;
+	struct media_pad *pad;
+	unsigned long flags;
+	int ret;
+
+	pad = media_entity_remote_pad(&cru->pad);
+	if (!pad)
+		return -EPIPE;
+
+	sd = media_entity_to_v4l2_subdev(pad->entity);
+
+	if (!on) {
+		media_pipeline_stop(cru->vdev.entity.pads);
+		return v4l2_subdev_call(sd, video, s_stream, 0);
+	}
+
+	ret = rzg2l_cru_mc_validate_format(cru, sd, pad);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&cru->qlock, flags);
+
+	/* Select a video input */
+	if (cru->is_csi)
+		rzg2l_cru_write(cru, CRUnCTRL, CRUnCTRL_VINSEL(0));
+
+	/* Cancel the software reset for image processing block */
+	rzg2l_cru_write(cru, CRUnRST, CRUnRST_VRESETN);
+
+	/* Disable and clear the interrupt before using */
+	rzg2l_cru_write(cru, CRUnIE, 0);
+	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
+
+	/* Initialize the AXI master */
+	rzg2l_cru_initialize_axi(cru);
+
+	/* Initialize image convert */
+	ret = rzg2l_cru_initialize_image_conv(cru);
+	if (ret) {
+		spin_unlock_irqrestore(&cru->qlock, flags);
+		return ret;
+	}
+
+	/* Enable interrupt */
+	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
+
+	/* Enable image processing reception */
+	rzg2l_cru_write(cru, ICnEN, ICnEN_ICEN);
+
+	spin_unlock_irqrestore(&cru->qlock, flags);
+
+	pipe = sd->entity.pads->pipe ? sd->entity.pads->pipe : &cru->vdev.pipe;
+	ret = media_pipeline_start(cru->vdev.entity.pads, pipe);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_call(sd, video, s_stream, 1);
+	if (ret == -ENOIOCTLCMD)
+		ret = 0;
+	if (ret)
+		media_pipeline_stop(cru->vdev.entity.pads);
+
+	return ret;
+}
+
+static void rzg2l_cru_stop_streaming(struct rzg2l_cru_dev *cru)
+{
+	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
+	unsigned int retries = 0;
+	unsigned long flags;
+	u32 icnms;
+
+	cru->state = RZG2L_CRU_DMA_STOPPING;
+
+	rzg2l_cru_set_stream(cru, 0);
+
+	spin_lock_irqsave(&cru->qlock, flags);
+
+	/* Enable IRQ to detect frame start reception */
+	rzg2l_cru_write(cru, CRUnINTS,
+			(~rzg2l_cru_read(cru, CRUnINTS)) | CRUnINTS_SFS);
+	rzg2l_cru_write(cru, CRUnIE, CRUnIE_SFE);
+
+	/* Wait for streaming to stop */
+	while (retries++ < RZG2L_RETRIES) {
+		spin_unlock_irqrestore(&cru->qlock, flags);
+		msleep(RZG2L_TIMEOUT_MS);
+		spin_lock_irqsave(&cru->qlock, flags);
+	}
+
+	icnms = rzg2l_cru_read(cru, ICnMS) & ICnMS_IA;
+	if (icnms)
+		dev_err(cru->dev, "Failed stop HW, something is seriously broken\n");
+
+	cru->state = RZG2L_CRU_DMA_STOPPED;
+
+	/* Stop the operation of image conversion */
+	rzg2l_cru_write(cru, ICnEN, 0);
+
+	/* Disable and clear the interrupt */
+	rzg2l_cru_write(cru, CRUnIE, 0);
+	rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
+
+	/* Wait until the FIFO becomes empty */
+	for (retries = 5; retries > 0; retries--) {
+		amnfifopntr = rzg2l_cru_read(cru, AMnFIFOPNTR);
+
+		amnfifopntr_w = amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
+		amnfifopntr_r_y =
+			(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
+		if (amnfifopntr_w == amnfifopntr_r_y)
+			break;
+
+		usleep_range(10, 20);
+	}
+
+	/* Notify that FIFO is not empty here */
+	if (!retries)
+		dev_err(cru->dev, "Failed to empty FIFO\n");
+
+	/* Stop AXI bus */
+	rzg2l_cru_write(cru, AMnAXISTP, AMnAXISTP_AXI_STOP);
+
+	/* Wait until the AXI bus stop */
+	for (retries = 5; retries > 0; retries--) {
+		if (rzg2l_cru_read(cru, AMnAXISTPACK) &
+			AMnAXISTPACK_AXI_STOP_ACK)
+			break;
+
+		usleep_range(10, 20);
+	};
+
+	/* Notify that AXI bus can not stop here */
+	if (!retries)
+		dev_err(cru->dev, "Failed to stop AXI bus\n");
+
+	/* Cancel the AXI bus stop request */
+	rzg2l_cru_write(cru, AMnAXISTP, 0);
+
+	/* Resets the image processing module */
+	rzg2l_cru_write(cru, CRUnRST, 0);
+
+	spin_unlock_irqrestore(&cru->qlock, flags);
+
+	/* Set reset state */
+	reset_control_assert(cru->aresetn);
+}
+
+static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int count)
+{
+	struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
+	int ret;
+
+	/* Release reset state */
+	ret = reset_control_deassert(cru->aresetn);
+	if (ret) {
+		dev_err(cru->dev, "failed to deassert aresetn\n");
+		return ret;
+	}
+
+	/* Allocate scratch buffer. */
+	cru->scratch = dma_alloc_coherent(cru->dev, cru->format.sizeimage,
+					  &cru->scratch_phys, GFP_KERNEL);
+	if (!cru->scratch) {
+		return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
+		dev_err(cru->dev, "Failed to allocate scratch buffer\n");
+		return -ENOMEM;
+	}
+
+	cru->sequence = 0;
+
+	ret = rzg2l_cru_set_stream(cru, 1);
+	if (ret) {
+		return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
+		goto out;
+	}
+
+	cru->state = RZG2L_CRU_DMA_STARTING;
+
+	dev_dbg(cru->dev, "Starting to capture\n");
+
+out:
+	if (ret)
+		dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
+				  cru->scratch_phys);
+
+	return ret;
+}
+
+static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq)
+{
+	struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
+
+	rzg2l_cru_stop_streaming(cru);
+
+	/* Free scratch buffer */
+	dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
+			  cru->scratch_phys);
+
+	return_unused_buffers(cru, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops rzg2l_cru_qops = {
+	.queue_setup		= rzg2l_cru_queue_setup,
+	.buf_prepare		= rzg2l_cru_buffer_prepare,
+	.buf_queue		= rzg2l_cru_buffer_queue,
+	.start_streaming	= rzg2l_cru_start_streaming_vq,
+	.stop_streaming		= rzg2l_cru_stop_streaming_vq,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+};
+
+static irqreturn_t rzg2l_cru_irq(int irq, void *data)
+{
+	struct rzg2l_cru_dev *cru = data;
+	unsigned int handled = 0;
+	unsigned long flags;
+	u32 irq_status;
+	u32 amnmbs;
+	int slot;
+
+	spin_lock_irqsave(&cru->qlock, flags);
+
+	irq_status = rzg2l_cru_read(cru, CRUnINTS);
+	if (!irq_status)
+		goto done;
+
+	handled = 1;
+
+	rzg2l_cru_write(cru, CRUnINTS, rzg2l_cru_read(cru, CRUnINTS));
+
+	/* Nothing to do if capture status is 'RZG2L_CRU_DMA_STOPPED' */
+	if (cru->state == RZG2L_CRU_DMA_STOPPED) {
+		dev_dbg(cru->dev, "IRQ while state stopped\n");
+		goto done;
+	}
+
+	/* Increase stop retries if capture status is 'RZG2L_CRU_DMA_STOPPING' */
+	if (cru->state == RZG2L_CRU_DMA_STOPPING) {
+		if (irq_status & CRUnINTS_SFS)
+			dev_dbg(cru->dev, "IRQ while state stopping\n");
+		goto done;
+	}
+
+	/* Prepare for capture and update state */
+	amnmbs = rzg2l_cru_read(cru, AMnMBS);
+	slot = amnmbs & AMnMBS_MBSTS;
+
+	/*
+	 * AMnMBS.MBSTS indicates the destination of Memory Bank (MB).
+	 * Recalculate to get the current transfer complete MB.
+	 */
+	if (slot == 0)
+		slot = cru->num_buf - 1;
+	else
+		slot--;
+
+	/*
+	 * To hand buffers back in a known order to userspace start
+	 * to capture first from slot 0.
+	 */
+	if (cru->state == RZG2L_CRU_DMA_STARTING) {
+		if (slot != 0) {
+			dev_dbg(cru->dev, "Starting sync slot: %d\n", slot);
+			goto done;
+		}
+
+		dev_dbg(cru->dev, "Capture start synced!\n");
+		cru->state = RZG2L_CRU_DMA_RUNNING;
+	}
+
+	/* Capture frame */
+	if (cru->queue_buf[slot]) {
+		cru->queue_buf[slot]->field = cru->format.field;
+		cru->queue_buf[slot]->sequence = cru->sequence;
+		cru->queue_buf[slot]->vb2_buf.timestamp = ktime_get_ns();
+		vb2_buffer_done(&cru->queue_buf[slot]->vb2_buf,
+				VB2_BUF_STATE_DONE);
+		cru->queue_buf[slot] = NULL;
+	} else {
+		/* Scratch buffer was used, dropping frame. */
+		dev_dbg(cru->dev, "Dropping frame %u\n", cru->sequence);
+	}
+
+	cru->sequence++;
+
+	/* Prepare for next frame */
+	rzg2l_cru_fill_hw_slot(cru, slot);
+
+done:
+	spin_unlock_irqrestore(&cru->qlock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru)
+{
+	mutex_destroy(&cru->lock);
+
+	v4l2_device_unregister(&cru->v4l2_dev);
+	reset_control_assert(cru->presetn);
+}
+
+int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru, int irq)
+{
+	struct vb2_queue *q = &cru->queue;
+	unsigned int i;
+	int ret;
+
+	ret = reset_control_deassert(cru->presetn);
+	if (ret) {
+		dev_err(cru->dev, "failed to deassert presetn\n");
+		return ret;
+	}
+
+	/* Initialize the top-level structure */
+	ret = v4l2_device_register(cru->dev, &cru->v4l2_dev);
+	if (ret)
+		return ret;
+
+	mutex_init(&cru->lock);
+	INIT_LIST_HEAD(&cru->buf_list);
+
+	spin_lock_init(&cru->qlock);
+
+	cru->state = RZG2L_CRU_DMA_STOPPED;
+
+	for (i = 0; i < HW_BUFFER_MAX; i++)
+		cru->queue_buf[i] = NULL;
+
+	/* buffer queue */
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->io_modes = VB2_MMAP | VB2_READ | VB2_DMABUF;
+	q->lock = &cru->lock;
+	q->drv_priv = cru;
+	q->buf_struct_size = sizeof(struct rzg2l_cru_buffer);
+	q->ops = &rzg2l_cru_qops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->min_buffers_needed = 4;
+	q->dev = cru->dev;
+
+	ret = vb2_queue_init(q);
+	if (ret < 0) {
+		dev_err(cru->dev, "failed to initialize VB2 queue\n");
+		goto error;
+	}
+
+	/* IRQ */
+	ret = devm_request_irq(cru->dev, irq, rzg2l_cru_irq, IRQF_SHARED,
+			       KBUILD_MODNAME, cru);
+	if (ret) {
+		dev_err(cru->dev, "failed to request irq\n");
+		goto error;
+	}
+
+	return 0;
+
+error:
+	rzg2l_cru_dma_unregister(cru);
+	return ret;
+}
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
new file mode 100644
index 000000000000..b1b1bfda7eb1
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Renesas RZ/G2L CRU
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ * Based on Renesas R-Car VIN
+ * Copyright (C) 2016 Renesas Electronics Corp.
+ * Copyright (C) 2011-2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
+ * Copyright (C) 2008 Magnus Damm
+ */
+
+#include <linux/pm_runtime.h>
+
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/v4l2-rect.h>
+
+#include "rzg2l-cru.h"
+
+#define RZG2L_CRU_DEFAULT_FORMAT	V4L2_PIX_FMT_UYVY
+#define RZG2L_CRU_DEFAULT_WIDTH		800
+#define RZG2L_CRU_DEFAULT_HEIGHT	600
+#define RZG2L_CRU_DEFAULT_FIELD		V4L2_FIELD_NONE
+#define RZG2L_CRU_DEFAULT_COLORSPACE	V4L2_COLORSPACE_SRGB
+
+/* -----------------------------------------------------------------------------
+ * Format Conversions
+ */
+
+static const struct v4l2_format_info rzg2l_cru_formats[] = {
+	{
+		.format = V4L2_PIX_FMT_UYVY,
+		.bpp[0] = 2,
+	},
+};
+
+const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rzg2l_cru_formats); i++)
+		if (rzg2l_cru_formats[i].format == format)
+			return rzg2l_cru_formats + i;
+
+	return NULL;
+}
+
+static u32 rzg2l_cru_format_bytesperline(struct v4l2_pix_format *pix)
+{
+	const struct v4l2_format_info *fmt;
+
+	fmt = rzg2l_cru_format_from_pixel(pix->pixelformat);
+
+	if (WARN_ON(!fmt))
+		return -EINVAL;
+
+	return pix->width * fmt->bpp[0];
+}
+
+static u32 rzg2l_cru_format_sizeimage(struct v4l2_pix_format *pix)
+{
+	return pix->bytesperline * pix->height;
+}
+
+static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
+				   struct v4l2_pix_format *pix)
+{
+	if (!rzg2l_cru_format_from_pixel(pix->pixelformat))
+		pix->pixelformat = RZG2L_CRU_DEFAULT_FORMAT;
+
+	switch (pix->field) {
+	case V4L2_FIELD_TOP:
+	case V4L2_FIELD_BOTTOM:
+	case V4L2_FIELD_NONE:
+	case V4L2_FIELD_INTERLACED_TB:
+	case V4L2_FIELD_INTERLACED_BT:
+	case V4L2_FIELD_INTERLACED:
+		break;
+	default:
+		pix->field = RZG2L_CRU_DEFAULT_FIELD;
+		break;
+	}
+
+	/* Limit to CRU capabilities */
+	v4l_bound_align_image(&pix->width, 320, cru->info->max_width, 1,
+			      &pix->height, 240, cru->info->max_height, 2, 0);
+
+	pix->bytesperline = rzg2l_cru_format_bytesperline(pix);
+	pix->sizeimage = rzg2l_cru_format_sizeimage(pix);
+
+	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
+		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
+}
+
+static void rzg2l_cru_try_format(struct rzg2l_cru_dev *cru,
+				 struct v4l2_pix_format *pix)
+{
+	/*
+	 * The V4L2 specification clearly documents the colorspace fields
+	 * as being set by drivers for capture devices. Using the values
+	 * supplied by userspace thus wouldn't comply with the API. Until
+	 * the API is updated force fixed values.
+	 */
+	pix->colorspace = RZG2L_CRU_DEFAULT_COLORSPACE;
+	pix->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix->colorspace);
+	pix->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colorspace);
+	pix->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true, pix->colorspace,
+							  pix->ycbcr_enc);
+
+	rzg2l_cru_format_align(cru, pix);
+}
+
+static int rzg2l_cru_querycap(struct file *file, void *priv,
+			      struct v4l2_capability *cap)
+{
+	struct rzg2l_cru_dev *cru = video_drvdata(file);
+
+	strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
+	strscpy(cap->card, "RZG2L_CRU", sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
+		 dev_name(cru->dev));
+	return 0;
+}
+
+static int rzg2l_cru_try_fmt_vid_cap(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct rzg2l_cru_dev *cru = video_drvdata(file);
+
+	rzg2l_cru_try_format(cru, &f->fmt.pix);
+
+	return 0;
+}
+
+static int rzg2l_cru_s_fmt_vid_cap(struct file *file, void *priv,
+				   struct v4l2_format *f)
+{
+	struct rzg2l_cru_dev *cru = video_drvdata(file);
+
+	if (vb2_is_busy(&cru->queue))
+		return -EBUSY;
+
+	rzg2l_cru_try_format(cru, &f->fmt.pix);
+
+	cru->format = f->fmt.pix;
+
+	cru->compose.top = 0;
+	cru->compose.left = 0;
+	cru->compose.width = cru->format.width;
+	cru->compose.height = cru->format.height;
+
+	return 0;
+}
+
+static int rzg2l_cru_g_fmt_vid_cap(struct file *file, void *priv,
+				   struct v4l2_format *f)
+{
+	struct rzg2l_cru_dev *cru = video_drvdata(file);
+
+	f->fmt.pix = cru->format;
+
+	return 0;
+}
+
+static int rzg2l_cru_enum_fmt_vid_cap(struct file *file, void *priv,
+				      struct v4l2_fmtdesc *f)
+{
+	if (f->index >= ARRAY_SIZE(rzg2l_cru_formats))
+		return -EINVAL;
+
+	f->pixelformat = rzg2l_cru_formats[f->index].format;
+
+	return 0;
+}
+
+static int rzg2l_cru_subscribe_event(struct v4l2_fh *fh,
+				     const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_event_subscribe(fh, sub, 4, NULL);
+	}
+	return v4l2_ctrl_subscribe_event(fh, sub);
+}
+
+static const struct v4l2_ioctl_ops rzg2l_cru_ioctl_ops = {
+	.vidioc_querycap		= rzg2l_cru_querycap,
+	.vidioc_try_fmt_vid_cap		= rzg2l_cru_try_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap		= rzg2l_cru_g_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap		= rzg2l_cru_s_fmt_vid_cap,
+	.vidioc_enum_fmt_vid_cap	= rzg2l_cru_enum_fmt_vid_cap,
+
+	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_querybuf		= vb2_ioctl_querybuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
+	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
+	.vidioc_streamon		= vb2_ioctl_streamon,
+	.vidioc_streamoff		= vb2_ioctl_streamoff,
+
+	.vidioc_log_status		= v4l2_ctrl_log_status,
+	.vidioc_subscribe_event		= rzg2l_cru_subscribe_event,
+	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
+};
+
+/* -----------------------------------------------------------------------------
+ * Media controller file operations
+ */
+
+static int rzg2l_cru_open(struct file *file)
+{
+	struct rzg2l_cru_dev *cru = video_drvdata(file);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(cru->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = mutex_lock_interruptible(&cru->lock);
+	if (ret)
+		goto err_pm;
+
+	file->private_data = cru;
+	ret = v4l2_fh_open(file);
+	if (ret)
+		goto err_unlock;
+
+	ret = v4l2_pipeline_pm_get(&cru->vdev.entity);
+	if (ret < 0)
+		goto err_open;
+
+	ret = v4l2_ctrl_handler_setup(&cru->ctrl_handler);
+	if (ret)
+		goto err_power;
+
+	mutex_unlock(&cru->lock);
+
+	return 0;
+err_power:
+	v4l2_pipeline_pm_put(&cru->vdev.entity);
+err_open:
+	v4l2_fh_release(file);
+err_unlock:
+	mutex_unlock(&cru->lock);
+err_pm:
+	pm_runtime_put(cru->dev);
+
+	return ret;
+}
+
+static int rzg2l_cru_release(struct file *file)
+{
+	struct rzg2l_cru_dev *cru = video_drvdata(file);
+	int ret;
+
+	mutex_lock(&cru->lock);
+
+	/* the release helper will cleanup any on-going streaming. */
+	ret = _vb2_fop_release(file, NULL);
+
+	v4l2_pipeline_pm_put(&cru->vdev.entity);
+	pm_runtime_put(cru->dev);
+
+	mutex_unlock(&cru->lock);
+
+	return ret;
+}
+
+static const struct v4l2_file_operations rzg2l_cru_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= video_ioctl2,
+	.open		= rzg2l_cru_open,
+	.release	= rzg2l_cru_release,
+	.poll		= vb2_fop_poll,
+	.mmap		= vb2_fop_mmap,
+	.read		= vb2_fop_read,
+};
+
+void rzg2l_cru_v4l2_unregister(struct rzg2l_cru_dev *cru)
+{
+	if (!video_is_registered(&cru->vdev))
+		return;
+
+	v4l2_info(&cru->v4l2_dev, "Removed %s\n",
+		  video_device_node_name(&cru->vdev));
+
+	/* Checks internally if vdev have been init or not */
+	video_unregister_device(&cru->vdev);
+}
+
+static void rzg2l_cru_notify(struct v4l2_subdev *sd,
+			     unsigned int notification, void *arg)
+{
+	struct rzg2l_cru_dev *cru =
+		container_of(sd->v4l2_dev, struct rzg2l_cru_dev, v4l2_dev);
+	struct v4l2_subdev *remote;
+	struct media_pad *pad;
+
+	pad = media_entity_remote_pad(&cru->pad);
+	if (!pad)
+		return;
+
+	remote = media_entity_to_v4l2_subdev(pad->entity);
+	if (remote != sd)
+		return;
+
+	switch (notification) {
+	case V4L2_DEVICE_NOTIFY_EVENT:
+		v4l2_event_queue(&cru->vdev, arg);
+		break;
+	}
+}
+
+int rzg2l_cru_v4l2_register(struct rzg2l_cru_dev *cru)
+{
+	struct video_device *vdev = &cru->vdev;
+	int ret;
+
+	cru->v4l2_dev.notify = rzg2l_cru_notify;
+
+	/* video node */
+	vdev->v4l2_dev = &cru->v4l2_dev;
+	vdev->queue = &cru->queue;
+	snprintf(vdev->name, sizeof(vdev->name), "CRU output");
+	vdev->release = video_device_release_empty;
+	vdev->lock = &cru->lock;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
+			    V4L2_CAP_READWRITE;
+
+	/* Set a default format */
+	cru->format.pixelformat	= RZG2L_CRU_DEFAULT_FORMAT;
+	cru->format.width = RZG2L_CRU_DEFAULT_WIDTH;
+	cru->format.height = RZG2L_CRU_DEFAULT_HEIGHT;
+	cru->format.field = RZG2L_CRU_DEFAULT_FIELD;
+	cru->format.colorspace = RZG2L_CRU_DEFAULT_COLORSPACE;
+
+	vdev->device_caps |= V4L2_CAP_IO_MC;
+	vdev->fops = &rzg2l_cru_fops;
+	vdev->ioctl_ops = &rzg2l_cru_ioctl_ops;
+
+	rzg2l_cru_format_align(cru, &cru->format);
+
+	ret = video_register_device(&cru->vdev, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		dev_err(cru->dev, "Failed to register video device\n");
+		return ret;
+	}
+
+	video_set_drvdata(&cru->vdev, cru);
+
+	v4l2_info(&cru->v4l2_dev, "Device registered as %s\n",
+		  video_device_node_name(&cru->vdev));
+
+	return ret;
+}
-- 
2.17.1

