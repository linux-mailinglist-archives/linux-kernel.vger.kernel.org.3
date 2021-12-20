Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8492047A340
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhLTBEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:04:54 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:1252 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237029AbhLTBEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:04:39 -0500
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="104485876"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 10:04:38 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B2318416745E;
        Mon, 20 Dec 2021 10:04:35 +0900 (JST)
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
Subject: [PATCH 3/6] usb: dwc3: Drop unneeded calls to platform_get_resource_byname()
Date:   Mon, 20 Dec 2021 01:04:08 +0000
Message-Id: <20211220010411.12075-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded calls to platform_get_resource_byname() from
dwc3_host_init(). dwc3_host_init() already calls dwc3_host_get_irq()
which gets the irq number, just use this to get the IRQ resource data
and fill the xhci_resources[1]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/dwc3/host.c | 45 ++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f29a264635aa..eda871973d6c 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -8,32 +8,55 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include "core.h"
 
+static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
+					int irq, char *name)
+{
+	struct platform_device *pdev = to_platform_device(dwc->dev);
+	struct device_node *np = dev_of_node(&pdev->dev);
+
+	dwc->xhci_resources[1].start = irq;
+	dwc->xhci_resources[1].end = irq;
+	dwc->xhci_resources[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
+	if (!name && np)
+		dwc->xhci_resources[1].name = of_node_full_name(pdev->dev.of_node);
+	else
+		dwc->xhci_resources[1].name = name;
+}
+
 static int dwc3_host_get_irq(struct dwc3 *dwc)
 {
 	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
 	int irq;
 
 	irq = platform_get_irq_byname_optional(dwc3_pdev, "host");
-	if (irq > 0)
+	if (irq > 0) {
+		dwc3_host_fill_xhci_irq_res(dwc, irq, "host");
 		goto out;
+	}
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
 	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
-	if (irq > 0)
+	if (irq > 0) {
+		dwc3_host_fill_xhci_irq_res(dwc, irq, "dwc_usb3");
 		goto out;
+	}
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
 	irq = platform_get_irq(dwc3_pdev, 0);
-	if (irq > 0)
+	if (irq > 0) {
+		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
 		goto out;
+	}
 
 	if (!irq)
 		irq = -EINVAL;
@@ -47,28 +70,12 @@ int dwc3_host_init(struct dwc3 *dwc)
 	struct property_entry	props[4];
 	struct platform_device	*xhci;
 	int			ret, irq;
-	struct resource		*res;
-	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
 	int			prop_idx = 0;
 
 	irq = dwc3_host_get_irq(dwc);
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ, "host");
-	if (!res)
-		res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
-				"dwc_usb3");
-	if (!res)
-		res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ, 0);
-	if (!res)
-		return -ENOMEM;
-
-	dwc->xhci_resources[1].start = irq;
-	dwc->xhci_resources[1].end = irq;
-	dwc->xhci_resources[1].flags = res->flags;
-	dwc->xhci_resources[1].name = res->name;
-
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
 		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
-- 
2.17.1

