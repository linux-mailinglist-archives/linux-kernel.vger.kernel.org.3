Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498747A334
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhLTBEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:04:37 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:1252 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237029AbhLTBEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:04:36 -0500
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="104485870"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 10:04:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8FA0E416745E;
        Mon, 20 Dec 2021 10:04:32 +0900 (JST)
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
Subject: [PATCH 2/6] usb: renesas_usbhs: Use platform_get_irq() to get the interrupt
Date:   Mon, 20 Dec 2021 01:04:07 +0000
Message-Id: <20211220010411.12075-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
code use platform_get_irq().

Drop irqflags member from struct usbhs_priv as this driver is used by
two non DT users sh7757lcr and ecovec24 which do not pass
IORESOURCE_IRQ_SHAREABLE as part of their pdata. Along this drop the
IRQF_SHARED flag handling in the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 14 +++++---------
 drivers/usb/renesas_usbhs/common.h |  1 -
 drivers/usb/renesas_usbhs/mod.c    | 14 +-------------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 3af91b2b8f76..96f3939a65e2 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -589,11 +589,11 @@ static int usbhs_probe(struct platform_device *pdev)
 {
 	const struct renesas_usbhs_platform_info *info;
 	struct usbhs_priv *priv;
-	struct resource *irq_res;
 	struct device *dev = &pdev->dev;
 	struct gpio_desc *gpiod;
 	int ret;
 	u32 tmp;
+	int irq;
 
 	/* check device node */
 	if (dev_of_node(dev))
@@ -608,11 +608,9 @@ static int usbhs_probe(struct platform_device *pdev)
 	}
 
 	/* platform data */
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq_res) {
-		dev_err(dev, "Not enough Renesas USB platform resources.\n");
-		return -ENODEV;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	/* usb private data */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -669,9 +667,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	/*
 	 * priv settings
 	 */
-	priv->irq	= irq_res->start;
-	if (irq_res->flags & IORESOURCE_IRQ_SHAREABLE)
-		priv->irqflags = IRQF_SHARED;
+	priv->irq = irq;
 	priv->pdev	= pdev;
 	INIT_DELAYED_WORK(&priv->notify_hotplug_work, usbhsc_notify_hotplug);
 	spin_lock_init(usbhs_priv_to_lock(priv));
diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index eb34d762a63d..3fb5bc94dc0d 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -252,7 +252,6 @@ struct usbhs_priv {
 
 	void __iomem *base;
 	unsigned int irq;
-	unsigned long irqflags;
 
 	const struct renesas_usbhs_platform_callback *pfunc;
 	struct renesas_usbhs_driver_param	dparam;
diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index b98112cefaa4..f2ea3e1412d2 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -142,7 +142,7 @@ int usbhs_mod_probe(struct usbhs_priv *priv)
 
 	/* irq settings */
 	ret = devm_request_irq(dev, priv->irq, usbhs_interrupt,
-			  priv->irqflags, dev_name(dev), priv);
+			       0, dev_name(dev), priv);
 	if (ret) {
 		dev_err(dev, "irq request err\n");
 		goto mod_init_gadget_err;
@@ -219,18 +219,6 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
 	usbhs_unlock(priv, flags);
 	/********************  spin unlock ******************/
 
-	/*
-	 * Check whether the irq enable registers and the irq status are set
-	 * when IRQF_SHARED is set.
-	 */
-	if (priv->irqflags & IRQF_SHARED) {
-		if (!(intenb0 & state->intsts0) &&
-		    !(intenb1 & state->intsts1) &&
-		    !(state->bempsts) &&
-		    !(state->brdysts))
-			return -EIO;
-	}
-
 	return 0;
 }
 
-- 
2.17.1

