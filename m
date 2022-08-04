Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7A589AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiHDLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiHDLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:00:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9E2A259;
        Thu,  4 Aug 2022 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659610848; x=1691146848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PRn2+8NO981SRSIu6vbjDCVjq9ckDEOBDzmGJpoT/E=;
  b=cC+HlAxq0PC+EAVjEDgWkAQRJ1HItZTDqm6Xdat4y4XK1coj8V7IQghu
   3dL52WG6SHzEmI1IYzavvg+DRWWvF/k3rEKdRO/jemdfyPSPyAZ2vwIIb
   rvLVshA1bZDDeLiuzZFEtH0wtUXsIsfQLnzImgGVReV7se5Uhklqs0RpB
   6yAmUCGi6SftEd7HgtjaFCKtXGTieL4z5q5WvwxPb74MZnFJuTjXjJH2N
   +U6d+YbpCYWpV8Z/S/6XYb+O88uDnkmw7ZMhEMT9Ix7KU3/erTJBHtFLy
   ISRem5lDOUve1WvpQ7ArbLaZdvzBUU/ZBHV2KilUZABAdBqiy0I6Lt+6v
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="170952594"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 04:00:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 4 Aug 2022 04:00:47 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 04:00:45 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <dragan.cvetic@xilinx.com>,
        <derek.kiernan@xilinx.com>
Subject: [PATCH RFC char-misc-next 4/5] misc: microchip: pci1xxxx: Add gpio irq handler and irq helper functions irq_ack, irq_mask, irq_unmask and irq_set_type of irq_chip.
Date:   Thu, 4 Aug 2022 22:02:18 +0530
Message-ID: <20220804163219.921640-5-kumaravel.thiagarajan@microchip.com>
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

The helper functions irq_set_type, irq_mask, irq_unmask and
irq_ack configure the interrupt type, mask, unmask and
acknowledge the interrupts.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index ff94b0f239c7..c58d27407c4d 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/kthread.h>
+#include <linux/interrupt.h>
 
 #include "mchp_pci1xxxx_gp.h"
 
@@ -20,6 +21,13 @@
 #define PULLUP_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x40)
 #define PULLDOWN_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x50)
 #define OPENDRAIN_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x60)
+#define WAKEMASK_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x70)
+#define MODE_OFFSET(x)			((((x) / 32) * 4) + 0x400 + 0x80)
+#define INTR_LO_TO_HI_EDGE_CONFIG(x)	((((x) / 32) * 4) + 0x400 + 0x90)
+#define INTR_HI_TO_LO_EDGE_CONFIG(x)	((((x) / 32) * 4) + 0x400 + 0xA0)
+#define INTR_LEVEL_CONFIG_OFFSET(x)	((((x) / 32) * 4) + 0x400 + 0xB0)
+#define INTR_LEVEL_MASK_OFFSET(x)	((((x) / 32) * 4) + 0x400 + 0xC0)
+#define INTR_STAT_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0xD0)
 #define DEBOUNCE_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0xE0)
 #define PIO_GLOBAL_CONFIG_OFFSET	(0x400 + 0xF0)
 #define PIO_PCI_CTRL_REG_OFFSET	(0x400 + 0xF4)
@@ -148,9 +156,146 @@ static int pci1xxxx_gpio_set_config(struct gpio_chip *gpio, unsigned int offset,
 	return ret;
 }
 
+static void pci1xxxx_gpio_irq_ack(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, INTR_STAT_OFFSET(gpio), (gpio % 32), true);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void pci1xxxx_gpio_irq_set_mask(struct irq_data *data, bool set)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, INTR_MASK_OFFSET(gpio), (gpio % 32), set);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void pci1xxxx_gpio_irq_mask(struct irq_data *data)
+{
+	pci1xxxx_gpio_irq_set_mask(data, true);
+}
+
+static void pci1xxxx_gpio_irq_unmask(struct irq_data *data)
+{
+	pci1xxxx_gpio_irq_set_mask(data, false);
+}
+
+static int pci1xxxx_gpio_set_type(struct irq_data *data, unsigned int trigger_type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+	unsigned int bitpos = gpio % 32;
+
+	if (trigger_type & IRQ_TYPE_EDGE_FALLING) {
+		pci1xxx_assign_bit(priv->reg_base, INTR_HI_TO_LO_EDGE_CONFIG(gpio),
+				   bitpos, false);
+		pci1xxx_assign_bit(priv->reg_base, MODE_OFFSET(gpio),
+				   bitpos, false);
+		irq_set_handler_locked(data, handle_edge_irq);
+	} else {
+		pci1xxx_assign_bit(priv->reg_base, INTR_HI_TO_LO_EDGE_CONFIG(gpio),
+				   bitpos, true);
+	}
+
+	if (trigger_type & IRQ_TYPE_EDGE_RISING) {
+		pci1xxx_assign_bit(priv->reg_base, INTR_LO_TO_HI_EDGE_CONFIG(gpio),
+				   bitpos, false);
+		pci1xxx_assign_bit(priv->reg_base, MODE_OFFSET(gpio), bitpos,
+				   false);
+		irq_set_handler_locked(data, handle_edge_irq);
+	} else {
+		pci1xxx_assign_bit(priv->reg_base, INTR_LO_TO_HI_EDGE_CONFIG(gpio),
+				   bitpos, true);
+	}
+
+	if (trigger_type & IRQ_TYPE_LEVEL_LOW) {
+		pci1xxx_assign_bit(priv->reg_base, INTR_LEVEL_CONFIG_OFFSET(gpio),
+				   bitpos, true);
+		pci1xxx_assign_bit(priv->reg_base, INTR_LEVEL_MASK_OFFSET(gpio),
+				   bitpos, false);
+		pci1xxx_assign_bit(priv->reg_base, MODE_OFFSET(gpio), bitpos,
+				   true);
+		irq_set_handler_locked(data, handle_edge_irq);
+	}
+
+	if (trigger_type & IRQ_TYPE_LEVEL_HIGH) {
+		pci1xxx_assign_bit(priv->reg_base, INTR_LEVEL_CONFIG_OFFSET(gpio),
+				   bitpos, false);
+		pci1xxx_assign_bit(priv->reg_base, INTR_LEVEL_MASK_OFFSET(gpio),
+				   bitpos, false);
+		pci1xxx_assign_bit(priv->reg_base, MODE_OFFSET(gpio), bitpos,
+				   true);
+		irq_set_handler_locked(data, handle_edge_irq);
+	}
+
+	if ((!(trigger_type & IRQ_TYPE_LEVEL_LOW)) && (!(trigger_type & IRQ_TYPE_LEVEL_HIGH)))
+		pci1xxx_assign_bit(priv->reg_base, INTR_LEVEL_MASK_OFFSET(gpio), bitpos, true);
+
+	return true;
+}
+
+static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
+{
+	struct pci1xxxx_gpio *priv = dev_id;
+	struct gpio_chip *gc =  &priv->gpio;
+	unsigned long int_status = 0;
+	unsigned long flags;
+	u8 pincount;
+	int bit;
+	u8 gpiobank;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET, 16, true);
+	spin_unlock_irqrestore(&priv->lock, flags);
+	for (gpiobank = 0; gpiobank < 3; gpiobank++) {
+		spin_lock_irqsave(&priv->lock, flags);
+		int_status = readl(priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
+		spin_unlock_irqrestore(&priv->lock, flags);
+		if (gpiobank == 2)
+			pincount = 29;
+		else
+			pincount = 32;
+		for_each_set_bit(bit, &int_status, pincount) {
+			unsigned int irq;
+
+			spin_lock_irqsave(&priv->lock, flags);
+			writel(BIT(bit), priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
+			spin_unlock_irqrestore(&priv->lock, flags);
+			irq = irq_find_mapping(gc->irq.domain, (bit + (gpiobank * 32)));
+			generic_handle_irq(irq);
+		}
+	}
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET, 16, false);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip pci1xxxx_gpio_irqchip = {
+	.name = "pci1xxxx_gpio",
+	.irq_ack = pci1xxxx_gpio_irq_ack,
+	.irq_mask = pci1xxxx_gpio_irq_mask,
+	.irq_unmask = pci1xxxx_gpio_irq_unmask,
+	.irq_set_type = pci1xxxx_gpio_set_type,
+};
+
 static int pci1xxxx_gpio_setup(struct pci1xxxx_gpio *priv, int irq)
 {
 	struct gpio_chip *gchip = &priv->gpio;
+	struct gpio_irq_chip *girq;
+	int retval;
 
 	gchip->label = dev_name(&priv->aux_dev->dev);
 	gchip->parent = &priv->aux_dev->dev;
@@ -166,6 +311,20 @@ static int pci1xxxx_gpio_setup(struct pci1xxxx_gpio *priv, int irq)
 	gchip->ngpio =  PCI1XXXX_NR_PINS;
 	gchip->can_sleep = false;
 
+	retval = devm_request_threaded_irq(&priv->aux_dev->dev, irq,
+		NULL, pci1xxxx_gpio_irq_handler,
+		IRQF_ONESHOT, "PCI1xxxxGPIO", priv);
+
+	if (retval)
+		return retval;
+
+	girq = &priv->gpio.irq;
+	girq->chip = &pci1xxxx_gpio_irqchip;
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_bad_irq;
 	return 0;
 }
 
-- 
2.25.1

