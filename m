Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900E478126
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhLQAMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:12:45 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:58635 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229525AbhLQAMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:12:44 -0500
X-IronPort-AV: E=Sophos;i="5.88,212,1635174000"; 
   d="scan'208";a="103763134"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Dec 2021 09:12:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 68950414D0B8;
        Fri, 17 Dec 2021 09:12:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to populate IRQ resource
Date:   Fri, 17 Dec 2021 00:12:38 +0000
Message-Id: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use of_irq_to_resource().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi,

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/ata/pata_of_platform.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 35aa158fc976..557f349eb533 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/libata.h>
@@ -25,11 +26,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	struct device_node *dn = ofdev->dev.of_node;
 	struct resource io_res;
 	struct resource ctl_res;
-	struct resource *irq_res;
+	struct resource irq_res;
 	unsigned int reg_shift = 0;
 	int pio_mode = 0;
 	int pio_mask;
 	bool use16bit;
+	int irq;
 
 	ret = of_address_to_resource(dn, 0, &io_res);
 	if (ret) {
@@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 		return -EINVAL;
 	}
 
-	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
+	irq = of_irq_to_resource(dn, 0, &irq_res);
+	if (irq <= 0 && irq != -ENXIO)
+		return irq ? irq : -ENXIO;
 
 	of_property_read_u32(dn, "reg-shift", &reg_shift);
 
@@ -63,7 +67,8 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	pio_mask = 1 << pio_mode;
 	pio_mask |= (1 << pio_mode) - 1;
 
-	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
+	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res,
+				     irq > 0 ? &irq_res : NULL,
 				     reg_shift, pio_mask, &pata_platform_sht,
 				     use16bit);
 }
-- 
2.17.1

