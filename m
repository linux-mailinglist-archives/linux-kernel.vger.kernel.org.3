Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C8463EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbhK3UBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:01:41 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37499 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbhK3UBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:01:39 -0500
Received: by mail-ot1-f45.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so31813695otg.4;
        Tue, 30 Nov 2021 11:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJZ1mh//NVDXx5NKs4Y1jNb85MGDNxcVosZcfjxm0gY=;
        b=4GzPqtfl/bsi4X7A+1kOB5BdQL2oMmjAoBQbc16gVYKigovb2tH2hQ1HRoc4TePDHo
         FCmWWOqrDzUUWhozTIe2Ck21bnIkR8JdyfcjXDdUwboJ+rdZWfUAOCcGdTwmtReySXh+
         X1NkJbgqgJ0dgfAOQvdoSGXOjgiMTuU3YewC46OytCKW8JDh9tTCRaroZcZUPeilLVN8
         dSWi2/NH7PwiWJm40RFRRcB7+BqpaNcC2HiazCcWUpB1OBlZhxri5d+XKYmSSXUH9wSU
         BcyvdIgHbSzLgu2f0cMGSq1JQykF6BhiqkHHUb5YbsmhdiS7XySQaFqR3Z9pHO0lmqkF
         eZRQ==
X-Gm-Message-State: AOAM531gY/FWL4x8RTc4vanSGyKH65GgCdhzix/4oNNRs5HD2s7xm2mz
        lGzCHp6C0GEeHGkzfYCnWg==
X-Google-Smtp-Source: ABdhPJzdoD511wcLZBcPCNemI490xqGSjivrFpC1hqQsrtvp82ZEcF/JfeTFc7DwjkYZCYJ7YR36cg==
X-Received: by 2002:a05:6830:44a1:: with SMTP id r33mr1328502otv.162.1638302299148;
        Tue, 30 Nov 2021 11:58:19 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c41sm3339343otu.7.2021.11.30.11.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:58:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpio: xlp: Remove Netlogic XLP variants
Date:   Tue, 30 Nov 2021 13:58:17 -0600
Message-Id: <20211130195817.2911086-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Netlogic XLP was removed in commit 95b8a5e0111a ("MIPS: Remove NETLOGIC
support"). With those gone, the single platform left to support is
Cavium ThunderX2. Remove all the Netlogic variants and DT support.

For simplicity, the existing kconfig name is retained.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix !OF and ACPI build errors

 drivers/gpio/Kconfig    |  10 ++-
 drivers/gpio/gpio-xlp.c | 147 +++-------------------------------------
 2 files changed, 15 insertions(+), 142 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 072ed610f9c6..e05f226b3d5d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -730,14 +730,12 @@ config GPIO_XILINX
 	  Say yes here to support the Xilinx FPGA GPIO device.
 
 config GPIO_XLP
-	tristate "Netlogic XLP GPIO support"
-	depends on OF_GPIO && (CPU_XLP || ARCH_THUNDER2 || COMPILE_TEST)
+	tristate "Cavium ThunderX2 GPIO support"
+	depends on ARCH_THUNDER2 || COMPILE_TEST
 	select GPIOLIB_IRQCHIP
 	help
-	  This driver provides support for GPIO interface on Netlogic XLP MIPS64
-	  SoCs. Currently supported XLP variants are XLP8XX, XLP3XX, XLP2XX,
-	  XLP9XX and XLP5XX. The same GPIO controller block is also present in
-	  Cavium's ThunderX2 CN99XX SoCs.
+	  This driver provides support for GPIO interface on Cavium's ThunderX2
+	  CN99XX SoCs (Originally from Netlogic XLP).
 
 	  If unsure, say N.
 
diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index 0d94d3aef752..0199f545335f 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -6,7 +6,6 @@
 
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -26,16 +25,6 @@
  *
  * where addr is base address of the that feature register and gpio is the pin.
  */
-#define GPIO_OUTPUT_EN		0x00
-#define GPIO_PADDRV		0x08
-#define GPIO_INT_EN00		0x18
-#define GPIO_INT_EN10		0x20
-#define GPIO_INT_EN20		0x28
-#define GPIO_INT_EN30		0x30
-#define GPIO_INT_POL		0x38
-#define GPIO_INT_TYPE		0x40
-#define GPIO_INT_STAT		0x48
-
 #define GPIO_9XX_BYTESWAP	0X00
 #define GPIO_9XX_CTRL		0X04
 #define GPIO_9XX_OUTPUT_EN	0x14
@@ -52,14 +41,6 @@
 #define GPIO_9XX_INT_TYPE	0x114
 #define GPIO_9XX_INT_STAT	0x124
 
-#define GPIO_3XX_INT_EN00	0x18
-#define GPIO_3XX_INT_EN10	0x20
-#define GPIO_3XX_INT_EN20	0x28
-#define GPIO_3XX_INT_EN30	0x30
-#define GPIO_3XX_INT_POL	0x78
-#define GPIO_3XX_INT_TYPE	0x80
-#define GPIO_3XX_INT_STAT	0x88
-
 /* Interrupt type register mask */
 #define XLP_GPIO_IRQ_TYPE_LVL	0x0
 #define XLP_GPIO_IRQ_TYPE_EDGE	0x1
@@ -72,16 +53,6 @@
 #define XLP_GPIO_IRQ_BASE	768
 #define XLP_MAX_NR_GPIO		96
 
-/* XLP variants supported by this driver */
-enum {
-	XLP_GPIO_VARIANT_XLP832 = 1,
-	XLP_GPIO_VARIANT_XLP316,
-	XLP_GPIO_VARIANT_XLP208,
-	XLP_GPIO_VARIANT_XLP980,
-	XLP_GPIO_VARIANT_XLP532,
-	GPIO_VARIANT_VULCAN
-};
-
 struct xlp_gpio_priv {
 	struct gpio_chip chip;
 	DECLARE_BITMAP(gpio_enabled_mask, XLP_MAX_NR_GPIO);
@@ -257,44 +228,13 @@ static void xlp_gpio_set(struct gpio_chip *gc, unsigned gpio, int state)
 	xlp_gpio_set_reg(priv->gpio_paddrv, gpio, state);
 }
 
-static const struct of_device_id xlp_gpio_of_ids[] = {
-	{
-		.compatible = "netlogic,xlp832-gpio",
-		.data	    = (void *)XLP_GPIO_VARIANT_XLP832,
-	},
-	{
-		.compatible = "netlogic,xlp316-gpio",
-		.data	    = (void *)XLP_GPIO_VARIANT_XLP316,
-	},
-	{
-		.compatible = "netlogic,xlp208-gpio",
-		.data	    = (void *)XLP_GPIO_VARIANT_XLP208,
-	},
-	{
-		.compatible = "netlogic,xlp980-gpio",
-		.data	    = (void *)XLP_GPIO_VARIANT_XLP980,
-	},
-	{
-		.compatible = "netlogic,xlp532-gpio",
-		.data	    = (void *)XLP_GPIO_VARIANT_XLP532,
-	},
-	{
-		.compatible = "brcm,vulcan-gpio",
-		.data	    = (void *)GPIO_VARIANT_VULCAN,
-	},
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, xlp_gpio_of_ids);
-
 static int xlp_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
 	struct xlp_gpio_priv *priv;
 	void __iomem *gpio_base;
-	int irq_base, irq, err;
-	int ngpio;
-	u32 soc_type;
+	int irq, err;
 
 	priv = devm_kzalloc(&pdev->dev,	sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -308,62 +248,12 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	if (pdev->dev.of_node) {
-		soc_type = (uintptr_t)of_device_get_match_data(&pdev->dev);
-	} else {
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
-						&pdev->dev);
-		if (!acpi_id || !acpi_id->driver_data) {
-			dev_err(&pdev->dev, "Unable to match ACPI ID\n");
-			return -ENODEV;
-		}
-		soc_type = (uintptr_t) acpi_id->driver_data;
-	}
-
-	switch (soc_type) {
-	case XLP_GPIO_VARIANT_XLP832:
-		priv->gpio_out_en = gpio_base + GPIO_OUTPUT_EN;
-		priv->gpio_paddrv = gpio_base + GPIO_PADDRV;
-		priv->gpio_intr_stat = gpio_base + GPIO_INT_STAT;
-		priv->gpio_intr_type = gpio_base + GPIO_INT_TYPE;
-		priv->gpio_intr_pol = gpio_base + GPIO_INT_POL;
-		priv->gpio_intr_en = gpio_base + GPIO_INT_EN00;
-		ngpio = 41;
-		break;
-	case XLP_GPIO_VARIANT_XLP208:
-	case XLP_GPIO_VARIANT_XLP316:
-		priv->gpio_out_en = gpio_base + GPIO_OUTPUT_EN;
-		priv->gpio_paddrv = gpio_base + GPIO_PADDRV;
-		priv->gpio_intr_stat = gpio_base + GPIO_3XX_INT_STAT;
-		priv->gpio_intr_type = gpio_base + GPIO_3XX_INT_TYPE;
-		priv->gpio_intr_pol = gpio_base + GPIO_3XX_INT_POL;
-		priv->gpio_intr_en = gpio_base + GPIO_3XX_INT_EN00;
-
-		ngpio = (soc_type == XLP_GPIO_VARIANT_XLP208) ? 42 : 57;
-		break;
-	case XLP_GPIO_VARIANT_XLP980:
-	case XLP_GPIO_VARIANT_XLP532:
-	case GPIO_VARIANT_VULCAN:
-		priv->gpio_out_en = gpio_base + GPIO_9XX_OUTPUT_EN;
-		priv->gpio_paddrv = gpio_base + GPIO_9XX_PADDRV;
-		priv->gpio_intr_stat = gpio_base + GPIO_9XX_INT_STAT;
-		priv->gpio_intr_type = gpio_base + GPIO_9XX_INT_TYPE;
-		priv->gpio_intr_pol = gpio_base + GPIO_9XX_INT_POL;
-		priv->gpio_intr_en = gpio_base + GPIO_9XX_INT_EN00;
-
-		if (soc_type == XLP_GPIO_VARIANT_XLP980)
-			ngpio = 66;
-		else if (soc_type == XLP_GPIO_VARIANT_XLP532)
-			ngpio = 67;
-		else
-			ngpio = 70;
-		break;
-	default:
-		dev_err(&pdev->dev, "Unknown Processor type!\n");
-		return -ENODEV;
-	}
+	priv->gpio_out_en = gpio_base + GPIO_9XX_OUTPUT_EN;
+	priv->gpio_paddrv = gpio_base + GPIO_9XX_PADDRV;
+	priv->gpio_intr_stat = gpio_base + GPIO_9XX_INT_STAT;
+	priv->gpio_intr_type = gpio_base + GPIO_9XX_INT_TYPE;
+	priv->gpio_intr_pol = gpio_base + GPIO_9XX_INT_POL;
+	priv->gpio_intr_en = gpio_base + GPIO_9XX_INT_EN00;
 
 	bitmap_zero(priv->gpio_enabled_mask, XLP_MAX_NR_GPIO);
 
@@ -373,8 +263,7 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 	gc->label = dev_name(&pdev->dev);
 	gc->base = 0;
 	gc->parent = &pdev->dev;
-	gc->ngpio = ngpio;
-	gc->of_node = pdev->dev.of_node;
+	gc->ngpio = 70;
 	gc->direction_output = xlp_gpio_dir_output;
 	gc->direction_input = xlp_gpio_dir_input;
 	gc->set = xlp_gpio_set;
@@ -382,19 +271,6 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->lock);
 
-	/* XLP(MIPS) has fixed range for GPIO IRQs, Vulcan(ARM64) does not */
-	if (soc_type != GPIO_VARIANT_VULCAN) {
-		irq_base = devm_irq_alloc_descs(&pdev->dev, -1,
-						XLP_GPIO_IRQ_BASE,
-						gc->ngpio, 0);
-		if (irq_base < 0) {
-			dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
-			return irq_base;
-		}
-	} else {
-		irq_base = 0;
-	}
-
 	girq = &gc->irq;
 	girq->chip = &xlp_gpio_irq_chip;
 	girq->parent_handler = xlp_gpio_generic_handler;
@@ -405,7 +281,7 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 	if (!girq->parents)
 		return -ENOMEM;
 	girq->parents[0] = irq;
-	girq->first = irq_base;
+	girq->first = 0;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
 
@@ -420,8 +296,8 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xlp_gpio_acpi_match[] = {
-	{ "BRCM9006", GPIO_VARIANT_VULCAN },
-	{ "CAV9006",  GPIO_VARIANT_VULCAN },
+	{ "BRCM9006" },
+	{ "CAV9006" },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, xlp_gpio_acpi_match);
@@ -430,7 +306,6 @@ MODULE_DEVICE_TABLE(acpi, xlp_gpio_acpi_match);
 static struct platform_driver xlp_gpio_driver = {
 	.driver		= {
 		.name	= "xlp-gpio",
-		.of_match_table = xlp_gpio_of_ids,
 		.acpi_match_table = ACPI_PTR(xlp_gpio_acpi_match),
 	},
 	.probe		= xlp_gpio_probe,
-- 
2.32.0

