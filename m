Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6548D5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiAMKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:44:29 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:61794 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231667AbiAMKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:44:28 -0500
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; 
   d="scan'208";a="106939323"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jan 2022 19:44:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C76B640001C2;
        Thu, 13 Jan 2022 19:44:25 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] media: davinci: vpif: Use platform_get_irq_optional() to get the interrupt
Date:   Thu, 13 Jan 2022 10:44:15 +0000
Message-Id: <20220113104416.32352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

While at it, propagate error code in case devm_request_irq() fails
instead of returning -EINVAL.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch is part of series [0], instead of resending the entire series
I am re-sending this alone patch after rebasing on patch series [1].

[0] https://patchwork.linuxtv.org/project/linux-media/list/?series=7073
[1] https://patchwork.linuxtv.org/project/linux-media/list/?series=7000

v3->v4
* Replaced loop with do while.

Cheers,
Prabhakar
---
 drivers/media/platform/davinci/vpif.c         | 18 ++++++++-----
 drivers/media/platform/davinci/vpif_capture.c | 27 +++++++++++--------
 drivers/media/platform/davinci/vpif_display.c | 24 ++++++++++-------
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index 03b4e51bb13a..97ef770266af 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -20,8 +20,10 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
@@ -437,11 +439,12 @@ static void vpif_pdev_release(struct device *dev)
 
 static int vpif_probe(struct platform_device *pdev)
 {
-	static struct resource *res_irq;
+	static struct resource res_irq;
 	struct platform_device *pdev_capture, *pdev_display;
 	struct device_node *endpoint = NULL;
 	struct vpif_data *data;
 	int ret;
+	int irq;
 
 	vpif_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vpif_base))
@@ -471,12 +474,13 @@ static int vpif_probe(struct platform_device *pdev)
 	 * For DT platforms, manually create platform_devices for
 	 * capture/display drivers.
 	 */
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq) {
-		dev_warn(&pdev->dev, "Missing IRQ resource.\n");
-		ret = -EINVAL;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
 		goto err_put_rpm;
 	}
+	res_irq = (struct resource)DEFINE_RES_IRQ_NAMED(irq, of_node_full_name(pdev->dev.of_node));
+	res_irq.flags |= irq_get_trigger_type(irq);
 
 	pdev_capture = kzalloc(sizeof(*pdev_capture), GFP_KERNEL);
 	if (!pdev_capture) {
@@ -486,7 +490,7 @@ static int vpif_probe(struct platform_device *pdev)
 
 	pdev_capture->name = "vpif_capture";
 	pdev_capture->id = -1;
-	pdev_capture->resource = res_irq;
+	pdev_capture->resource = &res_irq;
 	pdev_capture->num_resources = 1;
 	pdev_capture->dev.dma_mask = pdev->dev.dma_mask;
 	pdev_capture->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
@@ -505,7 +509,7 @@ static int vpif_probe(struct platform_device *pdev)
 
 	pdev_display->name = "vpif_display";
 	pdev_display->id = -1;
-	pdev_display->resource = res_irq;
+	pdev_display->resource = &res_irq;
 	pdev_display->num_resources = 1;
 	pdev_display->dev.dma_mask = pdev->dev.dma_mask;
 	pdev_display->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 8fe55374c5a3..bf76c5c83743 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1607,7 +1607,6 @@ static __init int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
 	struct i2c_adapter *i2c_adap;
-	struct resource *res;
 	int subdev_count;
 	int res_idx = 0;
 	int i, err;
@@ -1632,17 +1631,23 @@ static __init int vpif_probe(struct platform_device *pdev)
 		goto vpif_free;
 	}
 
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
-		err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
-					IRQF_SHARED, VPIF_DRIVER_NAME,
-					(void *)(&vpif_obj.dev[res_idx]->
-					channel_id));
-		if (err) {
-			err = -EINVAL;
+	do {
+		int irq;
+
+		err = platform_get_irq_optional(pdev, res_idx);
+		if (err < 0 && err != -ENXIO)
 			goto vpif_unregister;
-		}
-		res_idx++;
-	}
+		if (err > 0)
+			irq = err;
+		else
+			break;
+
+		err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
+				       IRQF_SHARED, VPIF_DRIVER_NAME,
+				       (void *)(&vpif_obj.dev[res_idx]->channel_id));
+		if (err)
+			goto vpif_unregister;
+	} while (++res_idx);
 
 	vpif_obj.config = pdev->dev.platform_data;
 
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index 59f6b782e104..fca148b66471 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -1221,7 +1221,6 @@ static __init int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
 	struct i2c_adapter *i2c_adap;
-	struct resource *res;
 	int subdev_count;
 	int res_idx = 0;
 	int i, err;
@@ -1245,18 +1244,25 @@ static __init int vpif_probe(struct platform_device *pdev)
 		goto vpif_free;
 	}
 
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
-		err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
-					IRQF_SHARED, VPIF_DRIVER_NAME,
-					(void *)(&vpif_obj.dev[res_idx]->
-					channel_id));
+	do {
+		int irq;
+
+		err = platform_get_irq_optional(pdev, res_idx);
+		if (err < 0 && err != -ENXIO)
+			goto vpif_unregister;
+		if (err > 0)
+			irq = err;
+		else
+			break;
+
+		err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
+				       IRQF_SHARED, VPIF_DRIVER_NAME,
+				       (void *)(&vpif_obj.dev[res_idx]->channel_id));
 		if (err) {
-			err = -EINVAL;
 			vpif_err("VPIF IRQ request failed\n");
 			goto vpif_unregister;
 		}
-		res_idx++;
-	}
+	} while (++res_idx);
 
 	vpif_obj.config = pdev->dev.platform_data;
 	subdev_count = vpif_obj.config->subdev_count;
-- 
2.17.1

