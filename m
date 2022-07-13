Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1B5734D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiGMK7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiGMK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:59:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F131F788C;
        Wed, 13 Jul 2022 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657709981; x=1689245981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oSYsOPfZMoigSP2H0A0eZeabJWNryj/ppmrEjwDGK3o=;
  b=e+V/5+I15peaZ8wzhl4xQ5iSZ36uVapwemk5S+9Nu7lh3RfPqZJEGJPq
   s9W9bFFGgO0/JWEvTUGuJgWILiErU09hRCrKkjRPGxAfo8vvq0IHpgmy3
   Rmr9Yyd+VDe9IhH6wbVuF0dERamnwwLosWkeYt6Y7EWEz0epXAGsPFJK0
   ecbkazFESMAE6BN9zIZkD1JSOfFDNhstH4avnFf2dnUL+9e8s/sSfs+2x
   gcU4YM3OiCyQGZiRZeMxzy/DMZHoncxWAZ4PJz15+FzKgnwCMbP9z3Hhw
   hESVNTWHPgagXZYB2J1frHq6JGH2XR1Uj8v6nMLXrI7DjIvLGZHNAzTmy
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="164527558"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 03:59:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 03:59:35 -0700
Received: from dev-powerhorse.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 03:59:33 -0700
From:   <lewis.hanly@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <lewis.hanly@microchip.com>
Subject: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Date:   Wed, 13 Jul 2022 11:59:10 +0100
Message-ID: <20220713105910.931983-2-lewis.hanly@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713105910.931983-1-lewis.hanly@microchip.com>
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lewis Hanly <lewis.hanly@microchip.com>

Add a driver to support the Polarfire SoC gpio controller.

Signed-off-by: Lewis Hanly <lewis.hanly@microchip.com>
---
 drivers/gpio/Kconfig     |   9 +
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-mpfs.c | 379 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 389 insertions(+)
 create mode 100644 drivers/gpio/gpio-mpfs.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b01961999ced..004b377b73f6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -490,6 +490,15 @@ config GPIO_PMIC_EIC_SPRD
 	help
 	  Say yes here to support Spreadtrum PMIC EIC device.
 
+config GPIO_POLARFIRE_SOC
+	bool "Microchip FPGA GPIO support"
+	depends on OF_GPIO
+	select GPIOLIB_IRQCHIP
+	select IRQ_DOMAIN_HIERARCHY
+	select GPIO_GENERIC
+	help
+	  Say yes here to support the GPIO device on Microchip FPGAs.
+
 config GPIO_PXA
 	bool "PXA GPIO support"
 	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 14352f6dfe8e..3b8b6703e593 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_GPIO_PCI_IDIO_16)		+= gpio-pci-idio-16.o
 obj-$(CONFIG_GPIO_PISOSR)		+= gpio-pisosr.o
 obj-$(CONFIG_GPIO_PL061)		+= gpio-pl061.o
 obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
+obj-$(CONFIG_GPIO_POLARFIRE_SOC)	+= gpio-mpfs.o
 obj-$(CONFIG_GPIO_PXA)			+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
 obj-$(CONFIG_GPIO_RC5T583)		+= gpio-rc5t583.o
diff --git a/drivers/gpio/gpio-mpfs.c b/drivers/gpio/gpio-mpfs.c
new file mode 100644
index 000000000000..1b342f307d85
--- /dev/null
+++ b/drivers/gpio/gpio-mpfs.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Microchip PolarFire SoC (MPFS) GPIO controller driver
+ *
+ * Copyright (c) 2018-2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Lewis Hanly <lewis.hanly@microchip.com>
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define NUM_GPIO			32
+#define BYTE_BOUNDARY			0x04
+#define MPFS_GPIO_EN_INT		3
+#define MPFS_GPIO_EN_OUT_BUF		BIT(2)
+#define MPFS_GPIO_EN_IN			BIT(1)
+#define MPFS_GPIO_EN_OUT		BIT(0)
+
+#define MPFS_GPIO_TYPE_INT_EDGE_BOTH	0x80
+#define MPFS_GPIO_TYPE_INT_EDGE_NEG	0x60
+#define MPFS_GPIO_TYPE_INT_EDGE_POS	0x40
+#define MPFS_GPIO_TYPE_INT_LEVEL_LOW	0x20
+#define MPFS_GPIO_TYPE_INT_LEVEL_HIGH	0x00
+#define MPFS_GPIO_TYPE_INT_MASK		GENMASK(7, 5)
+#define MPFS_IRQ_REG			0x80
+#define MPFS_INP_REG			0x84
+#define MPFS_OUTP_REG			0x88
+
+struct mpfs_gpio_chip {
+	void __iomem	*base;
+	struct clk	*clk;
+	raw_spinlock_t	lock;
+	struct gpio_chip gc;
+	unsigned int	irq_number[NUM_GPIO];
+};
+
+static void mpfs_gpio_assign_bit(void __iomem *addr, unsigned int bit_offset, bool value)
+{
+	unsigned long reg = readl(addr);
+
+	__assign_bit(bit_offset, &reg, value);
+	writel(reg, addr);
+}
+
+static int mpfs_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio_index)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	u32 gpio_cfg;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
+
+	gpio_cfg = readl(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+	gpio_cfg |= MPFS_GPIO_EN_IN;
+	gpio_cfg &= ~(MPFS_GPIO_EN_OUT | MPFS_GPIO_EN_OUT_BUF);
+	writel(gpio_cfg, mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+
+	raw_spin_unlock_irqrestore(&mpfs_gpio->lock, flags);
+
+	return 0;
+}
+
+static int mpfs_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio_index, int value)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	u32 gpio_cfg;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
+
+	gpio_cfg = readl(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+	gpio_cfg |= MPFS_GPIO_EN_OUT | MPFS_GPIO_EN_OUT_BUF;
+	gpio_cfg &= ~MPFS_GPIO_EN_IN;
+	writel(gpio_cfg, mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+
+	mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_OUTP_REG, gpio_index, value);
+
+	raw_spin_unlock_irqrestore(&mpfs_gpio->lock, flags);
+
+	return 0;
+}
+
+static int mpfs_gpio_get_direction(struct gpio_chip *gc,
+				   unsigned int gpio_index)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	u32 gpio_cfg;
+
+	gpio_cfg = readl(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+
+	if (gpio_cfg & MPFS_GPIO_EN_IN)
+		return 1;
+
+	return 0;
+}
+
+static int mpfs_gpio_get(struct gpio_chip *gc,
+			 unsigned int gpio_index)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+
+	return !!(readl(mpfs_gpio->base + MPFS_INP_REG) & BIT(gpio_index));
+}
+
+static void mpfs_gpio_set(struct gpio_chip *gc, unsigned int gpio_index, int value)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
+
+	mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_OUTP_REG,
+			     gpio_index, value);
+
+	raw_spin_unlock_irqrestore(&mpfs_gpio->lock, flags);
+}
+
+static int mpfs_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	int gpio_index = irqd_to_hwirq(data);
+	u32 interrupt_type;
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	u32 gpio_cfg;
+	unsigned long flags;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+		interrupt_type = MPFS_GPIO_TYPE_INT_EDGE_BOTH;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		interrupt_type = MPFS_GPIO_TYPE_INT_EDGE_NEG;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		interrupt_type = MPFS_GPIO_TYPE_INT_EDGE_POS;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		interrupt_type = MPFS_GPIO_TYPE_INT_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		interrupt_type = MPFS_GPIO_TYPE_INT_LEVEL_LOW;
+		break;
+	}
+
+	raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
+
+	gpio_cfg = readl(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+	gpio_cfg &= ~MPFS_GPIO_TYPE_INT_MASK;
+	gpio_cfg |= interrupt_type;
+	writel(gpio_cfg, mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));
+
+	raw_spin_unlock_irqrestore(&mpfs_gpio->lock, flags);
+
+	return 0;
+}
+
+static void mpfs_gpio_irq_enable(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+	int gpio_index = hwirq % NUM_GPIO;
+
+	gpiochip_enable_irq(gc, hwirq);
+	irq_chip_enable_parent(data);
+
+	mpfs_gpio_direction_input(gc, gpio_index);
+	mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_IRQ_REG, gpio_index, 1);
+	mpfs_gpio_assign_bit(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY),
+			     MPFS_GPIO_EN_INT, 1);
+}
+
+static void mpfs_gpio_irq_disable(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+	int gpio_index = hwirq % NUM_GPIO;
+
+	mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_IRQ_REG, gpio_index, 1);
+	mpfs_gpio_assign_bit(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY),
+			     MPFS_GPIO_EN_INT, 0);
+
+	irq_chip_disable_parent(data);
+	gpiochip_disable_irq(gc, hwirq);
+}
+
+static void mpfs_gpio_irq_eoi(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	int offset = irqd_to_hwirq(data) % NUM_GPIO;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
+	/* Clear pending interrupt */
+	mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_IRQ_REG, offset, 1);
+	raw_spin_unlock_irqrestore(&mpfs_gpio->lock, flags);
+
+	irq_chip_eoi_parent(data);
+}
+
+static int mpfs_gpio_irq_set_affinity(struct irq_data *data,
+				      const struct cpumask *dest,
+				      bool force)
+{
+	if (data->parent_data)
+		return irq_chip_set_affinity_parent(data, dest, force);
+
+	return -EINVAL;
+}
+
+static const struct irq_chip mpfs_gpio_irqchip = {
+	.name		= "mpfs",
+	.irq_set_type	= mpfs_gpio_irq_set_type,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_enable	= mpfs_gpio_irq_enable,
+	.irq_disable	= mpfs_gpio_irq_disable,
+	.irq_eoi	= mpfs_gpio_irq_eoi,
+	.irq_set_affinity = mpfs_gpio_irq_set_affinity,
+	.flags		= IRQCHIP_IMMUTABLE,
+	 GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int mpfs_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
+					   unsigned int child,
+					   unsigned int child_type,
+					   unsigned int *parent,
+					   unsigned int *parent_type)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);
+	struct irq_data *d = irq_get_irq_data(mpfs_gpio->irq_number[child]);
+	*parent_type = IRQ_TYPE_NONE;
+	*parent = irqd_to_hwirq(d);
+
+	return 0;
+}
+
+static int mpfs_gpio_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *irq_parent;
+	struct gpio_irq_chip *girq;
+	struct irq_domain *parent;
+	struct mpfs_gpio_chip *mpfs_gpio;
+	int i, ret, ngpio;
+
+	mpfs_gpio = devm_kzalloc(dev, sizeof(*mpfs_gpio), GFP_KERNEL);
+	if (!mpfs_gpio)
+		return -ENOMEM;
+
+	mpfs_gpio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mpfs_gpio->base))
+		return PTR_ERR(mpfs_gpio->base);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "devm_clk_get failed\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	mpfs_gpio->clk = clk;
+
+	ngpio = of_irq_count(node);
+	if (ngpio > NUM_GPIO) {
+		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
+			NUM_GPIO);
+		ret = -ENXIO;
+		goto cleanup_clock;
+	}
+
+	irq_parent = of_irq_find_parent(node);
+	if (!irq_parent) {
+		dev_err(dev, "no IRQ parent node\n");
+		ret = -ENODEV;
+		goto cleanup_clock;
+	}
+	parent = irq_find_host(irq_parent);
+	if (!parent) {
+		dev_err(dev, "no IRQ parent domain\n");
+		ret = -ENODEV;
+		goto cleanup_clock;
+	}
+
+	/* Get the interrupt numbers.
+	 * Clear/Disable All interrupts before enabling parent interrupts.
+	 */
+	for (i = 0; i < ngpio; i++) {
+		mpfs_gpio->irq_number[i] = platform_get_irq(pdev, i);
+		mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_IRQ_REG, i, 1);
+		mpfs_gpio_assign_bit(mpfs_gpio->base + (i * BYTE_BOUNDARY),
+				     MPFS_GPIO_EN_INT, 0);
+	}
+
+	raw_spin_lock_init(&mpfs_gpio->lock);
+
+	mpfs_gpio->gc.direction_input = mpfs_gpio_direction_input;
+	mpfs_gpio->gc.direction_output = mpfs_gpio_direction_output;
+	mpfs_gpio->gc.get_direction = mpfs_gpio_get_direction;
+	mpfs_gpio->gc.get = mpfs_gpio_get;
+	mpfs_gpio->gc.set = mpfs_gpio_set;
+	mpfs_gpio->gc.base = -1;
+	mpfs_gpio->gc.ngpio = ngpio;
+	mpfs_gpio->gc.label = dev_name(dev);
+	mpfs_gpio->gc.parent = dev;
+	mpfs_gpio->gc.owner = THIS_MODULE;
+
+	/* Get a pointer to the gpio_irq_chip */
+	girq = &mpfs_gpio->gc.irq;
+	gpio_irq_chip_set_chip(girq, &mpfs_gpio_irqchip);
+	girq->fwnode = of_node_to_fwnode(node);
+	girq->parent_domain = parent;
+	girq->child_to_parent_hwirq = mpfs_gpio_child_to_parent_hwirq;
+	girq->handler = handle_bad_irq;
+	girq->default_type = IRQ_TYPE_NONE;
+
+	ret = gpiochip_add_data(&mpfs_gpio->gc, mpfs_gpio);
+	if (ret)
+		goto cleanup_clock;
+
+	platform_set_drvdata(pdev, mpfs_gpio);
+	dev_info(dev, "Microchip MPFS GPIO registered, ngpio=%d\n", ngpio);
+
+	return 0;
+
+cleanup_clock:
+	clk_disable_unprepare(mpfs_gpio->clk);
+	return ret;
+}
+
+static int mpfs_gpio_remove(struct platform_device *pdev)
+{
+	struct mpfs_gpio_chip *mpfs_gpio = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&mpfs_gpio->gc);
+	clk_disable_unprepare(mpfs_gpio->clk);
+
+	return 0;
+}
+
+static const struct of_device_id mpfs_gpio_match[] = {
+	{ .compatible = "microchip,mpfs-gpio", },
+	{ /* end of list */ },
+};
+
+static struct platform_driver mpfs_gpio_driver = {
+	.probe = mpfs_gpio_probe,
+	.driver = {
+		.name = "microchip,mpfs-gpio",
+		.of_match_table = of_match_ptr(mpfs_gpio_match),
+	},
+	.remove = mpfs_gpio_remove,
+};
+builtin_platform_driver(mpfs_gpio_driver)
-- 
2.25.1

