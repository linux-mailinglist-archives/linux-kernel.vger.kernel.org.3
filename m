Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637BD47EEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352767AbhLXNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:16 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:58378 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352742AbhLXNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:11 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104620428"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B47B243A180E;
        Fri, 24 Dec 2021 22:13:09 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 03/10] ata: pata_of_platform: Use platform_get_irq_optional() to get the interrupt
Date:   Fri, 24 Dec 2021 13:12:52 +0000
Message-Id: <20211224131300.18198-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* New patch
---
 drivers/ata/pata_of_platform.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 35aa158fc976..2e2ec7d77726 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -25,11 +25,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
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
@@ -45,7 +46,14 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 		return -EINVAL;
 	}
 
-	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
+	irq = platform_get_irq_optional(ofdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+
+	if (irq > 0) {
+		memset(&irq_res, 0x0, sizeof(struct resource));
+		irq_res.start = irq;
+	}
 
 	of_property_read_u32(dn, "reg-shift", &reg_shift);
 
@@ -63,7 +71,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	pio_mask = 1 << pio_mode;
 	pio_mask |= (1 << pio_mode) - 1;
 
-	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
+	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq > 0 ? &irq_res : NULL,
 				     reg_shift, pio_mask, &pata_platform_sht,
 				     use16bit);
 }
-- 
2.17.1

