Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8457A2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiGSPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbiGSPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:14:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8F545D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso5792261otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7OijwyGP0BradGngSYjF3yMqE6shEfRTU0u1M722s4=;
        b=YCueJbkeSoo+JYND3F71lGHPb+di95NhpqSWx+LBsHvaaQkFhrGyHZ61ZvKmNyN5pX
         WppaWTaZy1QPDS7PCgJ0wdakXK400ALRkWMvjbHx8K1kXVbjtbhtEF7oYS8Dd0Xqowib
         D0nSd0LVzejqQhm3jN7cBZqVjEBRaevB1xtoyj7bpnq5p2GWTeJQdDXJjYZr+MpZ5sc0
         84YtMOYez+mNxLyX0xygKxVNiMZrWy4aVDBu+y+WfOoo38ZZldZjt+zbkECej0EzMQ8J
         7GfQNE6V4A0+iXzNh9DjOVg1phuL8RJVK7D0v4SN3r//jO84ql4c/h0oOHwTQf2nO8aV
         HnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7OijwyGP0BradGngSYjF3yMqE6shEfRTU0u1M722s4=;
        b=47kGO8Yi8JUKX4NptA4xahzg6F8EZVh+GyiHC7O442BGRvghK5bv25vJfimoI48Xzd
         1oaOHHlcA0mB+h1JH/1GrutWAamTn1RS+rHs6ednhwezSrm2z9Fo5sGGICwN07NOQ+Ll
         ZPI/u982/TD5NC+Rtoq6G7eeOnnvaLNixni44eEpU0ObJBL88TAuvQts0YaP0qoibvwP
         HUPdIA+j4t0D6DgNbO6Tg4j3AAbSv5earRTD3vtPG7qFkwBqwow3DY/xKtLWZMsKSqF4
         fZaf465AtyRzJsuYyKNQCLz22Ft8Wawq/mAJR61+SMslTxjcig28YEFPoluZhmzIK58l
         7CmQ==
X-Gm-Message-State: AJIora8C32U3ilv7yRasrgIkeZf7ZV+P9W2j4v/vKVV67KILLMCtx6nz
        X3hWcsDq5wFWBOytqWT0bXVoNr9NueaTcQ==
X-Google-Smtp-Source: AGRyM1uOD+55T3fUPfYQ5AMJd+CPKWWnIlRXTWFOZ1n4T0XUevwrtKibd9mq6OIuzo09W9kjpKTBag==
X-Received: by 2002:a05:6830:20c2:b0:61c:81ee:4482 with SMTP id z2-20020a05683020c200b0061c81ee4482mr9287578otq.24.1658243681802;
        Tue, 19 Jul 2022 08:14:41 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l24-20020a056830155800b0061c8bca21d8sm2334308otp.2.2022.07.19.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:14:41 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>
Subject: [PATCH v4 6/6] gpio: gpio-mm: Implement and utilize register structures
Date:   Tue, 19 Jul 2022 09:47:08 -0400
Message-Id: <cdac96433689cda2f6ae815bb5d2749fbf880d2c.1658236877.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658236876.git.william.gray@linaro.org>
References: <cover.1658236876.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4:
 - Remove superfluous <linux/bitops.h> and <linux/bits.h> includes

 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-gpio-mm.c | 202 +++++++-----------------------------
 2 files changed, 40 insertions(+), 163 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 23112f10d905..e1bf941cfe3d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -891,6 +891,7 @@ config GPIO_GPIO_MM
 	tristate "Diamond Systems GPIO-MM GPIO support"
 	depends on PC104
 	select ISA_BUS_API
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the Diamond Systems GPIO-MM and GPIO-MM-12.
 
diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 097a06463d01..2689671b6b01 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -6,8 +6,6 @@
  * This driver supports the following Diamond Systems devices: GPIO-MM and
  * GPIO-MM-12.
  */
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -17,7 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/spinlock.h>
+
+#include "gpio-i8255.h"
+
+MODULE_IMPORT_NS(I8255);
 
 #define GPIOMM_EXTENT 8
 #define MAX_NUM_GPIOMM max_num_isa_dev(GPIOMM_EXTENT)
@@ -27,32 +28,26 @@ static unsigned int num_gpiomm;
 module_param_hw_array(base, uint, ioport, &num_gpiomm, 0);
 MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
 
+#define GPIOMM_NUM_PPI 2
+
 /**
  * struct gpiomm_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @io_state:	bit I/O state (whether bit is set to input or output)
- * @out_state:	output bits state
- * @control:	Control registers state
- * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
+ * @chip:		instance of the gpio_chip
+ * @ppi_state:		Programmable Peripheral Interface group states
+ * @ppi:		Programmable Peripheral Interface groups
  */
 struct gpiomm_gpio {
 	struct gpio_chip chip;
-	unsigned char io_state[6];
-	unsigned char out_state[6];
-	unsigned char control[2];
-	spinlock_t lock;
-	void __iomem *base;
+	struct i8255_state ppi_state[GPIOMM_NUM_PPI];
+	struct i8255 __iomem *ppi;
 };
 
 static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
 	unsigned int offset)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
 
-	if (gpiommgpio->io_state[port] & mask)
+	if (i8255_get_direction(gpiommgpio->ppi_state, offset))
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
@@ -62,35 +57,8 @@ static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
 	unsigned int offset)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	unsigned long flags;
-	unsigned int control;
-
-	spin_lock_irqsave(&gpiommgpio->lock, flags);
-
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
 
-	control = BIT(7) | gpiommgpio->control[control_port];
-	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
-
-	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
+	i8255_direction_input(gpiommgpio->ppi, gpiommgpio->ppi_state, offset);
 
 	return 0;
 }
@@ -99,44 +67,9 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 	unsigned int offset, int value)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
-	unsigned long flags;
-	unsigned int control;
-
-	spin_lock_irqsave(&gpiommgpio->lock, flags);
-
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
 
-	iowrite8(gpiommgpio->out_state[io_port], gpiommgpio->base + out_port);
-
-	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
+	i8255_direction_output(gpiommgpio->ppi, gpiommgpio->ppi_state, offset,
+			       value);
 
 	return 0;
 }
@@ -144,47 +77,16 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
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
@@ -193,49 +95,17 @@ static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (port > 2) ? port + 1 : port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gpiommgpio->lock, flags);
-
-	if (value)
-		gpiommgpio->out_state[port] |= mask;
-	else
-		gpiommgpio->out_state[port] &= ~mask;
-
-	iowrite8(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
 
-	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
+	i8255_set(gpiommgpio->ppi, gpiommgpio->ppi_state, offset, value);
 }
 
 static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	size_t index;
-	void __iomem *port_addr;
-	unsigned long bitmask;
-	unsigned long flags;
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-		port_addr = gpiommgpio->base + ports[index];
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
-		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[index] &= ~gpio_mask;
-		gpiommgpio->out_state[index] |= bitmask;
-		iowrite8(gpiommgpio->out_state[index], port_addr);
-
-		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-	}
+	i8255_set_multiple(gpiommgpio->ppi, gpiommgpio->ppi_state, mask, bits,
+			   chip->ngpio);
 }
 
 #define GPIOMM_NGPIO 48
@@ -250,6 +120,21 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
 	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
 };
 
+static void gpiomm_init_dio(struct i8255 __iomem *const ppi,
+			    struct i8255_state *const ppi_state)
+{
+	const unsigned long ngpio = 24;
+	const unsigned long mask = GENMASK(ngpio - 1, 0);
+	const unsigned long bits = 0;
+	unsigned long i;
+
+	/* Initialize all GPIO to output 0 */
+	for (i = 0; i < GPIOMM_NUM_PPI; i++) {
+		i8255_mode0_output(&ppi[i]);
+		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
+	}
+}
+
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
 	struct gpiomm_gpio *gpiommgpio;
@@ -266,8 +151,8 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	gpiommgpio->base = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
-	if (!gpiommgpio->base)
+	gpiommgpio->ppi = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!gpiommgpio->ppi)
 		return -ENOMEM;
 
 	gpiommgpio->chip.label = name;
@@ -284,7 +169,8 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	gpiommgpio->chip.set = gpiomm_gpio_set;
 	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
 
-	spin_lock_init(&gpiommgpio->lock);
+	i8255_state_init(gpiommgpio->ppi_state, GPIOMM_NUM_PPI);
+	gpiomm_init_dio(gpiommgpio->ppi, gpiommgpio->ppi_state);
 
 	err = devm_gpiochip_add_data(dev, &gpiommgpio->chip, gpiommgpio);
 	if (err) {
@@ -292,16 +178,6 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
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
-
 	return 0;
 }
 
-- 
2.36.1

