Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9548B774
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiAKTk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:40:27 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10234 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236898AbiAKTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:40:26 -0500
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; 
   d="scan'208";a="106150611"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Jan 2022 04:40:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0B34540FE059;
        Wed, 12 Jan 2022 04:40:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: davinci: vpif: Use platform_get_irq_optional() to get the interrupt
Date:   Tue, 11 Jan 2022 19:40:13 +0000
Message-Id: <20220111194014.5908-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Cheers,
Prabhakar
---
 drivers/media/platform/davinci/vpif.c         | 18 ++++++++------
 drivers/media/platform/davinci/vpif_capture.c | 24 ++++++++++++-------
 drivers/media/platform/davinci/vpif_display.c | 21 ++++++++++------
 3 files changed, 40 insertions(+), 23 deletions(-)

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
index 8fe55374c5a3..aaf8a0ec98ff 100644
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
@@ -1632,15 +1631,22 @@ static __init int vpif_probe(struct platform_device *pdev)
 		goto vpif_free;
 	}
 
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
-		err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
-					IRQF_SHARED, VPIF_DRIVER_NAME,
-					(void *)(&vpif_obj.dev[res_idx]->
-					channel_id));
-		if (err) {
-			err = -EINVAL;
+	while (1) {
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
+		if (err)
 			goto vpif_unregister;
-		}
 		res_idx++;
 	}
 
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index 59f6b782e104..c4a0c4a4448c 100644
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
@@ -1245,13 +1244,21 @@ static __init int vpif_probe(struct platform_device *pdev)
 		goto vpif_free;
 	}
 
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
-		err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
-					IRQF_SHARED, VPIF_DRIVER_NAME,
-					(void *)(&vpif_obj.dev[res_idx]->
-					channel_id));
+	while (1) {
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
-- 
2.17.1

