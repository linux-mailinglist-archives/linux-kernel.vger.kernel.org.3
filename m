Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B399E47A33E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhLTBEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:04:51 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:59820 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237091AbhLTBEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:04:48 -0500
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="104020246"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 10:04:47 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 33494416745E;
        Mon, 20 Dec 2021 10:04:45 +0900 (JST)
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
Subject: [PATCH 6/6] usb: musb: dsps: Use platform_get_irq_byname() to get the interrupt
Date:   Mon, 20 Dec 2021 01:04:11 +0000
Message-Id: <20211220010411.12075-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_byname().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/musb/musb_dsps.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index b5935834f9d2..f75cde0f2b43 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -739,12 +740,14 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	}
 	resources[0] = *res;
 
-	res = platform_get_resource_byname(parent, IORESOURCE_IRQ, "mc");
-	if (!res) {
-		dev_err(dev, "failed to get irq.\n");
-		return -EINVAL;
-	}
-	resources[1] = *res;
+	ret = platform_get_irq_byname(parent, "mc");
+	if (ret < 0)
+		return ret;
+
+	resources[1].start = ret;
+	resources[1].end = ret;
+	resources[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(ret);
+	resources[1].name = "mc";
 
 	/* allocate the child platform device */
 	musb = platform_device_alloc("musb-hdrc",
-- 
2.17.1

