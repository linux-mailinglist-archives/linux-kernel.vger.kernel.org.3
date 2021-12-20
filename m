Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547AC47A337
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhLTBEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:04:44 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:59820 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237030AbhLTBEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:04:42 -0500
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="104020226"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 10:04:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D1C50416745E;
        Mon, 20 Dec 2021 10:04:38 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/6] usb: isp1760: Use platform_get_irq() to get the interrupt
Date:   Mon, 20 Dec 2021 01:04:09 +0000
Message-Id: <20211220010411.12075-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq(). Also use irq_get_trigger_type to get the
IRQ trigger flags.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/isp1760/isp1760-if.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-if.c b/drivers/usb/isp1760/isp1760-if.c
index 7cc349c0b2ad..65ba5aca2a4f 100644
--- a/drivers/usb/isp1760/isp1760-if.c
+++ b/drivers/usb/isp1760/isp1760-if.c
@@ -13,6 +13,7 @@
 
 #include <linux/usb.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -191,17 +192,15 @@ static int isp1760_plat_probe(struct platform_device *pdev)
 	unsigned long irqflags;
 	unsigned int devflags = 0;
 	struct resource *mem_res;
-	struct resource *irq_res;
+	int irq;
 	int ret;
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq_res) {
-		pr_warn("isp1760: IRQ resource not available\n");
-		return -ENODEV;
-	}
-	irqflags = irq_res->flags & IRQF_TRIGGER_MASK;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	irqflags = irq_get_trigger_type(irq);
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		struct device_node *dp = pdev->dev.of_node;
@@ -239,8 +238,7 @@ static int isp1760_plat_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = isp1760_register(mem_res, irq_res->start, irqflags, &pdev->dev,
-			       devflags);
+	ret = isp1760_register(mem_res, irq, irqflags, &pdev->dev, devflags);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

