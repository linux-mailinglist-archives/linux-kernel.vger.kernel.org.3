Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBF47E6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349551AbhLWRa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:30:56 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:62453 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349587AbhLWRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:30:52 -0500
X-IronPort-AV: E=Sophos;i="5.88,230,1635174000"; 
   d="scan'208";a="104983882"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 02:30:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4508C40C4A56;
        Fri, 24 Dec 2021 02:30:49 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional() to get the interrupt
Date:   Thu, 23 Dec 2021 17:30:07 +0000
Message-Id: <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Also this patch propagates error code in case devm_request_irq()
fails instead of returing -EINVAL.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/davinci/vpif.c         | 17 ++++++++++++++---
 drivers/media/platform/davinci/vpif_capture.c | 16 +++++++---------
 drivers/media/platform/davinci/vpif_display.c | 13 ++++++-------
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index 5a89d885d0e3..c3c78e1afdda 100644
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
@@ -428,6 +430,7 @@ static int vpif_probe(struct platform_device *pdev)
 	static struct resource *res_irq;
 	struct platform_device *pdev_capture, *pdev_display;
 	struct device_node *endpoint = NULL;
+	int irq;
 
 	vpif_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vpif_base))
@@ -453,12 +456,20 @@ static int vpif_probe(struct platform_device *pdev)
 	 * For DT platforms, manually create platform_devices for
 	 * capture/display drivers.
 	 */
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		pm_runtime_put(&pdev->dev);
+		return irq;
+	}
+	res_irq = devm_kzalloc(&pdev->dev, sizeof(*res_irq), GFP_KERNEL);
 	if (!res_irq) {
-		dev_warn(&pdev->dev, "Missing IRQ resource.\n");
 		pm_runtime_put(&pdev->dev);
-		return -EINVAL;
+		return -ENOMEM;
 	}
+	res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
+	res_irq->start = irq;
+	res_irq->end = irq;
+	res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;
 
 	pdev_capture = devm_kzalloc(&pdev->dev, sizeof(*pdev_capture),
 				    GFP_KERNEL);
diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 8fe55374c5a3..c1a67a221743 100644
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
@@ -1632,15 +1631,14 @@ static __init int vpif_probe(struct platform_device *pdev)
 		goto vpif_free;
 	}
 
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
-		err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
-					IRQF_SHARED, VPIF_DRIVER_NAME,
-					(void *)(&vpif_obj.dev[res_idx]->
-					channel_id));
-		if (err) {
-			err = -EINVAL;
+	while ((err = platform_get_irq_optional(pdev, res_idx)) != -ENXIO) {
+		if (err < 0)
+			goto vpif_unregister;
+		err = devm_request_irq(&pdev->dev, err, vpif_channel_isr,
+				       IRQF_SHARED, VPIF_DRIVER_NAME,
+				       (void *)(&vpif_obj.dev[res_idx]->channel_id));
+		if (err)
 			goto vpif_unregister;
-		}
 		res_idx++;
 	}
 
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index 59f6b782e104..9c552ea3787e 100644
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
@@ -1245,13 +1244,13 @@ static __init int vpif_probe(struct platform_device *pdev)
 		goto vpif_free;
 	}
 
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
-		err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
-					IRQF_SHARED, VPIF_DRIVER_NAME,
-					(void *)(&vpif_obj.dev[res_idx]->
-					channel_id));
+	while ((err = platform_get_irq_optional(pdev, res_idx)) != -ENXIO) {
+		if (err < 0)
+			goto vpif_unregister;
+		err = devm_request_irq(&pdev->dev, err, vpif_channel_isr,
+				       IRQF_SHARED, VPIF_DRIVER_NAME,
+				       (void *)(&vpif_obj.dev[res_idx]->channel_id));
 		if (err) {
-			err = -EINVAL;
 			vpif_err("VPIF IRQ request failed\n");
 			goto vpif_unregister;
 		}
-- 
2.17.1

