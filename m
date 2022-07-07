Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D156AEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiGGXQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiGGXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:16:21 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45854675AC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:16:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bffc214ffso16548030fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjvbHRrPgO0OHIXtBUt12TCrI5NuVCxsdmni+NXCTQg=;
        b=Y6jpyAv/t4HTC3nx1cZP6WPJj4R+BpV6GFSDJ5wViTsdK3HvLvOcl0bC6+5aSMx+l1
         GZ916o+WylbiUPzLB/EkPowUZiglFn+GAjEQ9NTkat9ltt6nKnwKjmPWkPnFfAXM2SvS
         5O7pIWZBe0ceDhlPi/iGgzdYbC6nxu1G4RGeXHcze7xX+qnxnpTWNPMSWqLMR2kLMt5S
         yDFQr2t6LelfY4NJynIohZvtYPd00KU8dp/QZfbxYa/ly7dZJ7qS8Y5Iqlyr2180cOie
         nF28ib8M0vW1dvh8N3LfsqlL2lVkqxc82b9D7C/98yGDOkgjd98f55bAwqBmAFQ+vS55
         nWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjvbHRrPgO0OHIXtBUt12TCrI5NuVCxsdmni+NXCTQg=;
        b=leViLvOAITkKcAcRv6qmlxMuMHp97EPW474x8G3K7u5aCwb+o89LbEH0T95WXD+MD+
         VLcBMtIpTFiEpeDGA3dq9wlJZMQopYD29+m0MYETmaYs5vImaZobRUYpGMbBBj6VpLlf
         GzPKPjAQWEMiEleK9LM/xHHXsWLi2La6Ut72qcDYw1nghryiBhUHVqDfpNR3M3jvWGhR
         VNkxmLmut00cjPOlqkxogx/RYboqPYTYjRcOvrthpZ++zh1TziUk06EXokbwtnLcWWDK
         xVAXhWtOsRt/GFtvM66CrkhKWauTueN+KRRKqbeRGcZpRYpT6rPiS03sxp8eGpKK7Wc9
         BOiw==
X-Gm-Message-State: AJIora8cdNnM1CTy5z/M8eb9n+tY8yjePC7WHLD3Faq5Pckpk5tmJ0qe
        +5RjIn8OLTORBATucnxVdPXYuQ==
X-Google-Smtp-Source: AGRyM1ueSZlZFeXOHSgxDgr/CJ73K1HQll+ixQ78PpQi54/X3X844iEGwpkWreEUhfPkn2ajqodqww==
X-Received: by 2002:a05:6870:2403:b0:10b:f512:a5b4 with SMTP id n3-20020a056870240300b0010bf512a5b4mr226064oap.164.1657235778541;
        Thu, 07 Jul 2022 16:16:18 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056830630a00b006190efaf118sm2177606otb.66.2022.07.07.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:16:18 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 4/6] gpio: gpio-mm: Implement and utilize register structures
Date:   Thu,  7 Jul 2022 14:10:06 -0400
Message-Id: <4073fb96bdc35024cb661699800c4cb5e8cf0e5f.1657216200.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657216200.git.william.gray@linaro.org>
References: <cover.1657216200.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures. The GPIO-MM device features an
Intel 8255 compatible GPIO interface, so the i8255 GPIO module is
selected and utilized as well.

Tested-by: Fred Eckert <Frede@cmslaser.com>
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-gpio-mm.c | 177 ++++++++----------------------------
 2 files changed, 38 insertions(+), 140 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0ae818d548bb..20b118b3dd8a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -882,6 +882,7 @@ config GPIO_GPIO_MM
 	tristate "Diamond Systems GPIO-MM GPIO support"
 	depends on PC104
 	select ISA_BUS_API
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the Diamond Systems GPIO-MM and GPIO-MM-12.
 
diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 097a06463d01..4bbf4e03f436 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -6,11 +6,12 @@
  * This driver supports the following Diamond Systems devices: GPIO-MM and
  * GPIO-MM-12.
  */
-#include <linux/bitmap.h>
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/i8255.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/isa.h>
@@ -18,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define GPIOMM_EXTENT 8
 #define MAX_NUM_GPIOMM max_num_isa_dev(GPIOMM_EXTENT)
@@ -29,30 +31,24 @@ MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
 
 /**
  * struct gpiomm_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @io_state:	bit I/O state (whether bit is set to input or output)
- * @out_state:	output bits state
- * @control:	Control registers state
- * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
+ * @chip:		instance of the gpio_chip
+ * @control_state:	Control registers state
+ * @lock:		synchronization lock to prevent I/O race conditions
+ * @ppi:		Programmable Peripheral Interface groups
  */
 struct gpiomm_gpio {
 	struct gpio_chip chip;
-	unsigned char io_state[6];
-	unsigned char out_state[6];
-	unsigned char control[2];
+	u8 control_state[2];
 	spinlock_t lock;
-	void __iomem *base;
+	struct i8255 __iomem *ppi;
 };
 
 static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
 	unsigned int offset)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
 
-	if (gpiommgpio->io_state[port] & mask)
+	if (i8255_get_direction(gpiommgpio->control_state, offset))
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
@@ -62,33 +58,12 @@ static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
 	unsigned int offset)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
 	unsigned long flags;
-	unsigned int control;
 
 	spin_lock_irqsave(&gpiommgpio->lock, flags);
 
-	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
-		/* Port C can be configured by nibble */
-		if (offset % 8 > 3) {
-			gpiommgpio->io_state[io_port] |= 0xF0;
-			gpiommgpio->control[control_port] |= BIT(3);
-		} else {
-			gpiommgpio->io_state[io_port] |= 0x0F;
-			gpiommgpio->control[control_port] |= BIT(0);
-		}
-	} else {
-		gpiommgpio->io_state[io_port] |= 0xFF;
-		if (io_port == 0 || io_port == 3)
-			gpiommgpio->control[control_port] |= BIT(4);
-		else
-			gpiommgpio->control[control_port] |= BIT(1);
-	}
-
-	control = BIT(7) | gpiommgpio->control[control_port];
-	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
+	i8255_direction_input(gpiommgpio->ppi, gpiommgpio->control_state,
+			      offset);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -99,42 +74,12 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 	unsigned int offset, int value)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
 	unsigned long flags;
-	unsigned int control;
 
 	spin_lock_irqsave(&gpiommgpio->lock, flags);
 
-	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
-		/* Port C can be configured by nibble */
-		if (offset % 8 > 3) {
-			gpiommgpio->io_state[io_port] &= 0x0F;
-			gpiommgpio->control[control_port] &= ~BIT(3);
-		} else {
-			gpiommgpio->io_state[io_port] &= 0xF0;
-			gpiommgpio->control[control_port] &= ~BIT(0);
-		}
-	} else {
-		gpiommgpio->io_state[io_port] &= 0x00;
-		if (io_port == 0 || io_port == 3)
-			gpiommgpio->control[control_port] &= ~BIT(4);
-		else
-			gpiommgpio->control[control_port] &= ~BIT(1);
-	}
-
-	if (value)
-		gpiommgpio->out_state[io_port] |= mask;
-	else
-		gpiommgpio->out_state[io_port] &= ~mask;
-
-	control = BIT(7) | gpiommgpio->control[control_port];
-	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
-
-	iowrite8(gpiommgpio->out_state[io_port], gpiommgpio->base + out_port);
+	i8255_direction_output(gpiommgpio->ppi, gpiommgpio->control_state,
+			       offset, value);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -144,47 +89,16 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int in_port = (port > 2) ? port + 1 : port;
-	unsigned long flags;
-	unsigned int port_state;
-
-	spin_lock_irqsave(&gpiommgpio->lock, flags);
-
-	/* ensure that GPIO is set for input */
-	if (!(gpiommgpio->io_state[port] & mask)) {
-		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-		return -EINVAL;
-	}
-
-	port_state = ioread8(gpiommgpio->base + in_port);
-
-	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
-	return !!(port_state & mask);
+	return i8255_get(gpiommgpio->ppi, offset);
 }
 
-static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *port_addr;
-	unsigned long port_state;
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = gpiommgpio->base + ports[offset / 8];
-		port_state = ioread8(port_addr) & gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
+	i8255_get_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
 
 	return 0;
 }
@@ -193,19 +107,11 @@ static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (port > 2) ? port + 1 : port;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpiommgpio->lock, flags);
 
-	if (value)
-		gpiommgpio->out_state[port] |= mask;
-	else
-		gpiommgpio->out_state[port] &= ~mask;
-
-	iowrite8(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+	i8255_set(gpiommgpio->ppi, offset, value);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 }
@@ -214,28 +120,13 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	size_t index;
-	void __iomem *port_addr;
-	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-		port_addr = gpiommgpio->base + ports[index];
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		spin_lock_irqsave(&gpiommgpio->lock, flags);
+	spin_lock_irqsave(&gpiommgpio->lock, flags);
 
-		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[index] &= ~gpio_mask;
-		gpiommgpio->out_state[index] |= bitmask;
-		iowrite8(gpiommgpio->out_state[index], port_addr);
+	i8255_set_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
 
-		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-	}
+	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 }
 
 #define GPIOMM_NGPIO 48
@@ -250,6 +141,20 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
 	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
 };
 
+static void gpiomm_init_dio(struct i8255 __iomem *const ppi)
+{
+	const unsigned long ngpio = 24;
+	const unsigned long mask = GENMASK(ngpio - 1, 0);
+	const unsigned long bits = 0;
+	unsigned long i;
+
+	/* Initialize all GPIO to output 0 */
+	for (i = 0; i < 2; i++) {
+		i8255_mode0_output(&ppi[i]);
+		i8255_set_multiple(&ppi[i], &mask, &bits, ngpio);
+	}
+}
+
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
 	struct gpiomm_gpio *gpiommgpio;
@@ -266,8 +171,8 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	gpiommgpio->base = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
-	if (!gpiommgpio->base)
+	gpiommgpio->ppi = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!gpiommgpio->ppi)
 		return -ENOMEM;
 
 	gpiommgpio->chip.label = name;
@@ -292,15 +197,7 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return err;
 	}
 
-	/* initialize all GPIO as output */
-	iowrite8(0x80, gpiommgpio->base + 3);
-	iowrite8(0x00, gpiommgpio->base);
-	iowrite8(0x00, gpiommgpio->base + 1);
-	iowrite8(0x00, gpiommgpio->base + 2);
-	iowrite8(0x80, gpiommgpio->base + 7);
-	iowrite8(0x00, gpiommgpio->base + 4);
-	iowrite8(0x00, gpiommgpio->base + 5);
-	iowrite8(0x00, gpiommgpio->base + 6);
+	gpiomm_init_dio(gpiommgpio->ppi);
 
 	return 0;
 }
-- 
2.36.1

