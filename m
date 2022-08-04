Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FB589AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiHDLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:00:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D613D05;
        Thu,  4 Aug 2022 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659610837; x=1691146837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Qla3DMFBdLbSsXeveYGQ+ThO/vsVb1s94dshrAQ42o=;
  b=HsPWLEYhLHbjOOgPl+BLRQU0thtFpT8fYTRPyJzOkwNhod9oc7UUdf8x
   19XQl4+u3usvI6xrq3RLwfnksbRBcdd/AijFn0y39mNasbxWk4EF3j/Cy
   CzFKOISi8NPycTfIIBDsw++g1fXu+BhqIXnqzP3oBGMRhjai5wM92ZU8m
   Zwk9f7Xgw7xAH2atSDemZYEVc/gLhXE/skMPgwZzCClLQwPnP1QWjRe3K
   xg97oXwm0IeCiLml0i4Nm8kPBNdXCn+0r6U/JV8h3MBuvUT693+GFnzPi
   /viDrgFSPkQcjH1HQQeAPW0txg7sMAo0RzsZfIy3Am+l7qludiO44g2Gg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="107557249"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 04:00:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 04:00:33 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 04:00:30 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <dragan.cvetic@xilinx.com>,
        <derek.kiernan@xilinx.com>
Subject: [PATCH RFC char-misc-next 1/5] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
Date:   Thu, 4 Aug 2022 22:02:15 +0530
Message-ID: <20220804163219.921640-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
References: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. PIO function is one of the functions in the
multi-function endpoint. PIO function combines a GPIO controller and also
an interface to program pci1xxxx's OTP & EEPROM. This auxiliary bus driver
is loaded for the PIO function and separate child devices are enumerated
for GPIO controller and OTP/EEPROM interface.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 MAINTAINERS                                   |   8 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   3 +-
 drivers/misc/mchp_pci1xxxx/Kconfig            |  10 ++
 drivers/misc/mchp_pci1xxxx/Makefile           |   1 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 167 ++++++++++++++++++
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h |  28 +++
 7 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mchp_pci1xxxx/Kconfig
 create mode 100644 drivers/misc/mchp_pci1xxxx/Makefile
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 285ffe0df5cf..ba491e4fc35f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13244,6 +13244,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 F:	drivers/mtd/nand/raw/atmel/*
 
+MICROCHIP PCI1XXXX GP DRIVER
+M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
+M:	UNGLinuxDriver@microchip.com
+L:	linux-gpio@vger.kernel.org
+S:	Supported
+F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
+
 MICROCHIP OTPC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 94e9fb4cdd76..358ad56f6524 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,4 +513,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
+source "drivers/misc/mchp_pci1xxxx/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2be8542616dd..ac9b3e757ba1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,4 +60,5 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
-obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
\ No newline at end of file
+obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
+obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig b/drivers/misc/mchp_pci1xxxx/Kconfig
new file mode 100644
index 000000000000..387a88addfb0
--- /dev/null
+++ b/drivers/misc/mchp_pci1xxxx/Kconfig
@@ -0,0 +1,10 @@
+config GP_PCI1XXXX
+       tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
+       select GPIOLIB_IRQCHIP
+       help
+         PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
+         multiple functions and one of the functions is a GPIO controller
+         which also has registers to interface with the OTP and EEPROM.
+         Select yes, no or module here to include or exclude the driver
+         for the GPIO function.
+
diff --git a/drivers/misc/mchp_pci1xxxx/Makefile b/drivers/misc/mchp_pci1xxxx/Makefile
new file mode 100644
index 000000000000..23927ab251c4
--- /dev/null
+++ b/drivers/misc/mchp_pci1xxxx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
new file mode 100644
index 000000000000..577f0fb456de
--- /dev/null
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2022 Microchip Technology Inc.
+
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/idr.h>
+#include "mchp_pci1xxxx_gp.h"
+
+struct aux_bus_device {
+	struct auxiliary_device_wrapper *aux_device_wrapper[2];
+};
+
+DEFINE_IDA(gp_client_ida);
+static const char aux_dev_otp_e2p_name[15] = "gp_otp_e2p";
+static const char aux_dev_gpio_name[15] = "gp_gpio";
+
+static void gp_auxiliary_device_release(struct device *dev)
+{
+	struct auxiliary_device_wrapper *aux_device_wrapper =
+		(struct auxiliary_device_wrapper *)container_of(dev,
+				struct auxiliary_device_wrapper, aux_dev.dev);
+
+	ida_free(&gp_client_ida, aux_device_wrapper->aux_dev.id);
+	kfree(aux_device_wrapper);
+}
+
+static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct aux_bus_device *aux_bus;
+	int retval;
+
+	retval = pcim_enable_device(pdev);
+	if (retval)
+		return retval;
+
+	aux_bus = kzalloc(sizeof(*aux_bus), GFP_KERNEL);
+	if (!aux_bus)
+		return -ENOMEM;
+
+	aux_bus->aux_device_wrapper[0] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[0]),
+						 GFP_KERNEL);
+	if (!aux_bus->aux_device_wrapper[0])
+		return -ENOMEM;
+
+	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
+	if (retval < 0)
+		goto err_ida_alloc_0;
+
+	aux_bus->aux_device_wrapper[0]->aux_dev.name = aux_dev_otp_e2p_name;
+	aux_bus->aux_device_wrapper[0]->aux_dev.dev.parent = &pdev->dev;
+	aux_bus->aux_device_wrapper[0]->aux_dev.dev.release = gp_auxiliary_device_release;
+	aux_bus->aux_device_wrapper[0]->aux_dev.id = retval;
+
+	aux_bus->aux_device_wrapper[0]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
+	aux_bus->aux_device_wrapper[0]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
+
+	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[0]->aux_dev);
+	if (retval < 0)
+		goto err_aux_dev_init_0;
+
+	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[0]->aux_dev);
+	if (retval)
+		goto err_aux_dev_add_0;
+
+	aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
+						 GFP_KERNEL);
+	if (!aux_bus->aux_device_wrapper[1])
+		return -ENOMEM;
+
+	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
+	if (retval < 0)
+		goto err_ida_alloc_1;
+
+
+	aux_bus->aux_device_wrapper[1]->aux_dev.name = aux_dev_gpio_name;
+	aux_bus->aux_device_wrapper[1]->aux_dev.dev.parent = &pdev->dev;
+	aux_bus->aux_device_wrapper[1]->aux_dev.dev.release = gp_auxiliary_device_release;
+	aux_bus->aux_device_wrapper[1]->aux_dev.id = retval;
+
+	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
+	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
+
+	retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+
+	if (retval < 0)
+		return retval;
+
+	pdev->irq = pci_irq_vector(pdev, 0);
+	if (pdev->irq < 0)
+		return retval;
+
+	aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num = pdev->irq;
+
+	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[1]->aux_dev);
+	if (retval < 0)
+		goto err_aux_dev_init_1;
+
+	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[1]->aux_dev);
+	if (retval)
+		goto err_aux_dev_add_1;
+
+	pci_set_drvdata(pdev, aux_bus);
+	pci_set_master(pdev);
+
+	return 0;
+
+err_aux_dev_add_1:
+	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
+
+err_aux_dev_init_1:
+	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
+
+err_ida_alloc_1:
+	kfree(aux_bus->aux_device_wrapper[1]);
+
+err_aux_dev_add_0:
+	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
+
+err_aux_dev_init_0:
+	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
+
+err_ida_alloc_0:
+	kfree(aux_bus->aux_device_wrapper[0]);
+
+	return retval;
+}
+
+static void gp_aux_bus_remove(struct pci_dev *pdev)
+{
+	struct aux_bus_device *aux_bus = pci_get_drvdata(pdev);
+
+	auxiliary_device_delete(&aux_bus->aux_device_wrapper[0]->aux_dev);
+	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
+	auxiliary_device_delete(&aux_bus->aux_device_wrapper[1]->aux_dev);
+	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
+	kfree(aux_bus);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id pci1xxxx_tbl[] = {
+	{ PCI_DEVICE(0x1055, 0xA005) },
+	{ PCI_DEVICE(0x1055, 0xA015) },
+	{ PCI_DEVICE(0x1055, 0xA025) },
+	{ PCI_DEVICE(0x1055, 0xA035) },
+	{ PCI_DEVICE(0x1055, 0xA045) },
+	{ PCI_DEVICE(0x1055, 0xA055) },
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, pci1xxxx_tbl);
+
+static struct pci_driver pci1xxxx_gp_driver = {
+	.name = "PCI1xxxxGP",
+	.id_table = pci1xxxx_tbl,
+	.probe = gp_aux_bus_probe,
+	.remove = gp_aux_bus_remove,
+};
+
+module_pci_driver(pci1xxxx_gp_driver);
+
+MODULE_DESCRIPTION("Microchip Technology Inc. PCI1xxxx GP expander");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
new file mode 100644
index 000000000000..ee6ba118a12c
--- /dev/null
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2022 Microchip Technology Inc. */
+
+#ifndef _GPIO_PCI1XXXX_H
+#define _GPIO_PCI1XXXX_H
+
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/kthread.h>
+#include <linux/types.h>
+#include <linux/auxiliary_bus.h>
+
+/* Perform operations like variable length write, read and write with read back for OTP / EEPROM
+ * Perform bit mode write in OTP
+ */
+
+struct gp_aux_data_type {
+	int irq_num;
+	resource_size_t region_start;
+	resource_size_t region_length;
+};
+
+struct auxiliary_device_wrapper {
+	struct auxiliary_device aux_dev;
+	struct gp_aux_data_type gp_aux_data;
+};
+
+#endif
-- 
2.25.1

