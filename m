Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503AF47EF06
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352782AbhLXNNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:35 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53177 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352812AbhLXNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:22 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105104967"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB4CD43A180E;
        Fri, 24 Dec 2021 22:13:19 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into pata_platform
Date:   Fri, 24 Dec 2021 13:12:56 +0000
Message-Id: <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the OF pata_of_platform driver into pata_platform.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* Introduced new function pata_platform_get_resources()

v1-->v2
* Dropped check for IRQ0
* Dropped setting the irqflags as suggested by Rob
* Set just the irq start
* Fixed freeing up irq_res when not present in DT
* Dropped PATA_OF_PLATFORM entry
* Split up sorting of headers in separate patch
* Dropped sht from struct pata_platform_priv
---
 drivers/ata/Kconfig            |  10 --
 drivers/ata/Makefile           |   1 -
 drivers/ata/pata_of_platform.c |  96 ----------------
 drivers/ata/pata_platform.c    | 194 +++++++++++++++++++++++----------
 include/linux/ata_platform.h   |   9 --
 5 files changed, 139 insertions(+), 171 deletions(-)
 delete mode 100644 drivers/ata/pata_of_platform.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a7da8ea7b3ed..0132a6a49247 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1120,16 +1120,6 @@ config PATA_PLATFORM
 
 	  If unsure, say N.
 
-config PATA_OF_PLATFORM
-	tristate "OpenFirmware platform device PATA support"
-	depends on PATA_PLATFORM && OF
-	help
-	  This option enables support for generic directly connected ATA
-	  devices commonly found on embedded systems with OpenFirmware
-	  bindings.
-
-	  If unsure, say N.
-
 config PATA_QDI
 	tristate "QDI VLB PATA support"
 	depends on ISA
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b8aebfb14e82..0323b2be1b2f 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -107,7 +107,6 @@ obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
 obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
 obj-$(CONFIG_PATA_PALMLD)	+= pata_palmld.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
-obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
 obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
 obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
deleted file mode 100644
index b9c9b7311112..000000000000
--- a/drivers/ata/pata_of_platform.c
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * OF-platform PATA driver
- *
- * Copyright (c) 2007  MontaVista Software, Inc.
- *                     Anton Vorontsov <avorontsov@ru.mvista.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/libata.h>
-
-#define DRV_NAME "pata_of_platform"
-
-static struct scsi_host_template pata_platform_sht = {
-	ATA_PIO_SHT(DRV_NAME),
-};
-
-static int pata_of_platform_probe(struct platform_device *ofdev)
-{
-	struct device_node *dn = ofdev->dev.of_node;
-	struct resource *io_res;
-	struct resource *ctl_res;
-	struct resource irq_res;
-	unsigned int reg_shift = 0;
-	int pio_mode = 0;
-	int pio_mask;
-	bool use16bit;
-	int irq;
-
-	io_res = platform_get_mem_or_io(ofdev, 0);
-	if (!io_res) {
-		dev_err(&ofdev->dev, "can't get IO address from "
-			"device tree\n");
-		return -EINVAL;
-	}
-
-	ctl_res = platform_get_mem_or_io(ofdev, 1);
-	if (!ctl_res) {
-		dev_err(&ofdev->dev, "can't get CTL address from "
-			"device tree\n");
-		return -EINVAL;
-	}
-
-	irq = platform_get_irq_optional(ofdev, 0);
-	if (irq < 0 && irq != -ENXIO)
-		return irq;
-
-	if (irq > 0) {
-		memset(&irq_res, 0x0, sizeof(struct resource));
-		irq_res.start = irq;
-	}
-
-	of_property_read_u32(dn, "reg-shift", &reg_shift);
-
-	if (!of_property_read_u32(dn, "pio-mode", &pio_mode)) {
-		if (pio_mode > 6) {
-			dev_err(&ofdev->dev, "invalid pio-mode\n");
-			return -EINVAL;
-		}
-	} else {
-		dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
-	}
-
-	use16bit = of_property_read_bool(dn, "ata-generic,use16bit");
-
-	pio_mask = 1 << pio_mode;
-	pio_mask |= (1 << pio_mode) - 1;
-
-	return __pata_platform_probe(&ofdev->dev, io_res, ctl_res, irq > 0 ? &irq_res : NULL,
-				     reg_shift, pio_mask, &pata_platform_sht,
-				     use16bit);
-}
-
-static const struct of_device_id pata_of_platform_match[] = {
-	{ .compatible = "ata-generic", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, pata_of_platform_match);
-
-static struct platform_driver pata_of_platform_driver = {
-	.driver = {
-		.name = DRV_NAME,
-		.of_match_table = pata_of_platform_match,
-	},
-	.probe		= pata_of_platform_probe,
-	.remove		= ata_platform_remove_one,
-};
-
-module_platform_driver(pata_of_platform_driver);
-
-MODULE_DESCRIPTION("OF-platform PATA driver");
-MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index f500f631f72b..4273f1a9abd2 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -25,7 +25,25 @@
 
 static int pio_mask = 1;
 module_param(pio_mask, int, 0);
-MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default");
+MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default (param valid only for non DT users)");
+
+/**
+ * struct pata_platform_priv - Private info
+ * @io_res: Resource representing I/O base
+ * @ctl_res: Resource representing CTL base
+ * @irq_res: Resource representing IRQ and its flags
+ * @ioport_shift: I/O port shift
+ * @pio_mask: PIO mask
+ * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
+ */
+struct pata_platform_priv {
+	struct resource *io_res;
+	struct resource *ctl_res;
+	struct resource *irq_res;
+	unsigned int ioport_shift;
+	int pio_mask;
+	bool use16bit;
+};
 
 /*
  * Provide our own set_mode() as we don't want to change anything that has
@@ -66,15 +84,9 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
 }
 
 /**
- *	__pata_platform_probe		-	attach a platform interface
+ *	pata_platform_host_activate - attach a platform interface
  *	@dev: device
- *	@io_res: Resource representing I/O base
- *	@ctl_res: Resource representing CTL base
- *	@irq_res: Resource representing IRQ and its flags
- *	@ioport_shift: I/O port shift
- *	@__pio_mask: PIO mask
- *	@sht: scsi_host_template to use when registering
- *	@use16bit: Flag to indicate 16-bit IO instead of 32-bit
+ *	@priv: Pointer to struct pata_platform_priv
  *
  *	Register a platform bus IDE interface. Such interfaces are PIO and we
  *	assume do not support IRQ sharing.
@@ -94,10 +106,7 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
  *
  *	If no IRQ resource is present, PIO polling mode is used instead.
  */
-int __pata_platform_probe(struct device *dev, struct resource *io_res,
-			  struct resource *ctl_res, struct resource *irq_res,
-			  unsigned int ioport_shift, int __pio_mask,
-			  struct scsi_host_template *sht, bool use16bit)
+static int pata_platform_host_activate(struct device *dev, struct pata_platform_priv *priv)
 {
 	struct ata_host *host;
 	struct ata_port *ap;
@@ -108,15 +117,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	/*
 	 * Check for MMIO
 	 */
-	mmio = (( io_res->flags == IORESOURCE_MEM) &&
-		(ctl_res->flags == IORESOURCE_MEM));
+	mmio = ((priv->io_res->flags == IORESOURCE_MEM) &&
+		(priv->ctl_res->flags == IORESOURCE_MEM));
 
 	/*
 	 * And the IRQ
 	 */
-	if (irq_res) {
-		irq = irq_res->start;
-		irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
+	if (priv->irq_res && priv->irq_res->start > 0) {
+		irq = priv->irq_res->start;
+		irq_flags = (priv->irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
 	}
 
 	/*
@@ -131,12 +140,12 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	ap->ops->inherits = &ata_sff_port_ops;
 	ap->ops->cable_detect = ata_cable_unknown;
 	ap->ops->set_mode = pata_platform_set_mode;
-	if (use16bit)
+	if (priv->use16bit)
 		ap->ops->sff_data_xfer = ata_sff_data_xfer;
 	else
 		ap->ops->sff_data_xfer = ata_sff_data_xfer32;
 
-	ap->pio_mask = __pio_mask;
+	ap->pio_mask = priv->pio_mask;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
 	/*
@@ -151,15 +160,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	 * Handle the MMIO case
 	 */
 	if (mmio) {
-		ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
-				resource_size(io_res));
-		ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
-				resource_size(ctl_res));
+		ap->ioaddr.cmd_addr = devm_ioremap(dev, priv->io_res->start,
+						   resource_size(priv->io_res));
+		ap->ioaddr.ctl_addr = devm_ioremap(dev, priv->ctl_res->start,
+						   resource_size(priv->ctl_res));
 	} else {
-		ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
-				resource_size(io_res));
-		ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
-				resource_size(ctl_res));
+		ap->ioaddr.cmd_addr = devm_ioport_map(dev, priv->io_res->start,
+						      resource_size(priv->io_res));
+		ap->ioaddr.ctl_addr = devm_ioport_map(dev, priv->ctl_res->start,
+						      resource_size(priv->ctl_res));
 	}
 	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
 		dev_err(dev, "failed to map IO/CTL base\n");
@@ -168,46 +177,34 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 
 	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
 
-	pata_platform_setup_port(&ap->ioaddr, ioport_shift);
+	pata_platform_setup_port(&ap->ioaddr, priv->ioport_shift);
 
 	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
-		      (unsigned long long)io_res->start,
-		      (unsigned long long)ctl_res->start);
+		      (unsigned long long)priv->io_res->start,
+		      (unsigned long long)priv->ctl_res->start);
 
 	/* activate */
 	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
-				 irq_flags, sht);
+				 irq_flags, &pata_platform_sht);
 }
-EXPORT_SYMBOL_GPL(__pata_platform_probe);
 
-static int pata_platform_probe(struct platform_device *pdev)
+static int pata_platform_get_resources(struct platform_device *pdev,
+				       struct pata_platform_priv *priv)
 {
-	struct resource *io_res;
-	struct resource *ctl_res;
-	struct resource irq_res;
-	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
 	int irq;
 
-	/*
-	 * Simple resource validation ..
-	 */
-	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
-		dev_err(&pdev->dev, "invalid number of resources\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Get the I/O base first
 	 */
-	io_res = platform_get_mem_or_io(pdev, 0);
-	if (!io_res)
+	priv->io_res = platform_get_mem_or_io(pdev, 0);
+	if (!priv->io_res)
 		return -EINVAL;
 
 	/*
 	 * Then the CTL base
 	 */
-	ctl_res = platform_get_mem_or_io(pdev, 1);
-	if (!ctl_res)
+	priv->ctl_res = platform_get_mem_or_io(pdev, 1);
+	if (!priv->ctl_res)
 		return -EINVAL;
 
 	/*
@@ -216,21 +213,108 @@ static int pata_platform_probe(struct platform_device *pdev)
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0 && irq != -ENXIO)
 		return irq;
+
 	if (irq > 0) {
-		memset(&irq_res, 0x0, sizeof(struct resource));
-		irq_res.start = irq;
+		struct resource *irq_res;
+
+		irq_res = devm_kzalloc(&pdev->dev, sizeof(*irq_res), GFP_KERNEL);
+		if (!irq_res)
+			return -ENOMEM;
+
+		irq_res->start = irq;
+		priv->irq_res = irq_res;
 	}
 
-	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq > 0 ? &irq_res : NULL,
-				     pp_info ? pp_info->ioport_shift : 0,
-				     pio_mask, &pata_platform_sht, false);
+	return 0;
 }
 
+static int pata_of_platform_get_pdata(struct platform_device *ofdev,
+				      struct pata_platform_priv *priv)
+{
+	struct device_node *dn = ofdev->dev.of_node;
+	int pio_mode = 0;
+	int ret;
+
+	ret = pata_platform_get_resources(ofdev, priv);
+	if (ret)
+		return ret;
+
+	of_property_read_u32(dn, "reg-shift", &priv->ioport_shift);
+
+	ret = of_property_read_u32(dn, "pio-mode", &pio_mode);
+	if (!ret) {
+		if (pio_mode > 6) {
+			dev_err(&ofdev->dev, "invalid pio-mode\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
+	}
+
+	priv->use16bit = of_property_read_bool(dn, "ata-generic,use16bit");
+
+	priv->pio_mask = 1 << pio_mode;
+	priv->pio_mask |= (1 << pio_mode) - 1;
+
+	return 0;
+}
+
+static int pata_platform_get_pdata(struct platform_device *pdev,
+				   struct pata_platform_priv *priv)
+{
+	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	/*
+	 * Simple resource validation ..
+	 */
+	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	ret = pata_platform_get_resources(pdev, priv);
+	if (ret)
+		return ret;
+
+	priv->ioport_shift = pp_info ? pp_info->ioport_shift : 0;
+	priv->pio_mask = pio_mask;
+	priv->use16bit = false;
+
+	return 0;
+}
+
+static int pata_platform_probe(struct platform_device *pdev)
+{
+	struct pata_platform_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (!dev_of_node(&pdev->dev))
+		ret = pata_platform_get_pdata(pdev, priv);
+	else
+		ret = pata_of_platform_get_pdata(pdev, priv);
+	if (ret)
+		return ret;
+
+	return pata_platform_host_activate(&pdev->dev, priv);
+}
+
+static const struct of_device_id pata_of_platform_match[] = {
+	{ .compatible = "ata-generic", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pata_of_platform_match);
+
 static struct platform_driver pata_platform_driver = {
 	.probe		= pata_platform_probe,
 	.remove		= ata_platform_remove_one,
 	.driver = {
 		.name		= DRV_NAME,
+		.of_match_table = pata_of_platform_match,
 	},
 };
 
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
index 9cafec92282d..91b8529e6712 100644
--- a/include/linux/ata_platform.h
+++ b/include/linux/ata_platform.h
@@ -13,15 +13,6 @@ struct pata_platform_info {
 
 struct scsi_host_template;
 
-extern int __pata_platform_probe(struct device *dev,
-				 struct resource *io_res,
-				 struct resource *ctl_res,
-				 struct resource *irq_res,
-				 unsigned int ioport_shift,
-				 int __pio_mask,
-				 struct scsi_host_template *sht,
-				 bool use16bit);
-
 /*
  * Marvell SATA private data
  */
-- 
2.17.1

