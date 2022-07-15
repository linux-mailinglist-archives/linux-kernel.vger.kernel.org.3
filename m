Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4147B578C41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiGRU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiGRU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:57:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC2326F6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:56:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id o16-20020a9d4110000000b0061cac66bd6dso1766483ote.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAI7bZNVOd+8D2vU7qNqox3N5coYfVI5Ydgq3BWeIGw=;
        b=Tg/BeWGAQptGtCuceNodPfghsat5H+rWTWzV0SAKXuysM2TAUiVEcg+VpOjz5AJ2gu
         9Ai60pg7RrMN7iL9PJcInrjtO7e5yB3plSYLCph/g11+R9/e5UfVsHKpG5IFWphAoTyT
         oA0X76zqgPxqbGWOseHiARPjR77vJz01Fg5zq+NsYX7wwWKZcNDJ1028+MS8Zs99JAId
         3NkV1W/5b3kTbn4YdPttHUFioRmqLmJaMeYIOTLMx6+LN9wLHvHlnF+KPZzlmzNPy7D4
         dBcayoO2o8qKisGCLJE22lUuNbtXO5PcwdeH45VWo1wn71rx/QhYQb7zp0Mn7JKkDZCN
         ApiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAI7bZNVOd+8D2vU7qNqox3N5coYfVI5Ydgq3BWeIGw=;
        b=d49vaHjKNnph1WxN5EIW4nEbGg9mljtFlhyWwQHpj7nar3zLjtYrLAUupE+vOmbfUh
         gMdPJH8Gd5Hsw9SFdPEEmIU1zKgWIbBsr7iCS5oUxQyBP7wSITTE5Wsyvqb9qkD4GwjC
         ZVuSOHxpqBgJisQE+93Wf6JOprWMr1fAbijH8b+NrG/LeDyQJJ7/5q+6V3jyrhsMwyOf
         2LTgXdQQetr1hpjG0izxW3u11QfQwzehvkmOkiWjiXNe97nQaq9lFOllNviaehII2Y00
         m3tIdwAlLTGxZuH0wnMHV0x8IWRLUMWtC73x6r8qerLtNhPB4p+tI2EfrWMsCzgbUcsr
         4QnA==
X-Gm-Message-State: AJIora8SzWTtdCSV+sLAgNo9J2XunxHIF4PYHhat6UQrlKjI4B3jj5nl
        cnSsxBjj74Cc46OIC8NNeQvwjw==
X-Google-Smtp-Source: AGRyM1sa4OY7zIRja7Ho1sfzwMTOiFo5IMFSiwDhiD/ga1j2xqP/ZacBHcZurrMWC5L3sq0Ix4o8Kg==
X-Received: by 2002:a9d:32a:0:b0:61c:7b4b:d854 with SMTP id 39-20020a9d032a000000b0061c7b4bd854mr9340701otv.362.1658177818616;
        Mon, 18 Jul 2022 13:56:58 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ab2c8000000b0035eb4e5a6cbsm5252065ooo.33.2022.07.18.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:56:58 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v3 4/6] gpio: 104-dio-48e: Implement and utilize register structures
Date:   Fri, 15 Jul 2022 14:52:26 -0400
Message-Id: <20b1465664f93172e2143c5ce5890d4532d0f9b5.1657907849.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657907849.git.william.gray@linaro.org>
References: <cover.1657907849.git.william.gray@linaro.org>
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
utilizing named register data structures. The 104-DIO-48E device
features an Intel 8255 compatible GPIO interface, so the i8255 GPIO
module is selected and utilized as well.

Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3:
 - Include "gpio-i8255.h" instead of <linux/gpio/i8255.h>
 - Import I8255 symbol namespace
 - Define DIO48E_NUM_PPI as the number of PPI (2)
 - Utilize i8255_state struct; replaces 'control_state' with 'ppi_state'
 - Call i8255_state_init() to initialize 'ppi_state'

 drivers/gpio/Kconfig            |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 248 ++++++++++----------------------
 2 files changed, 75 insertions(+), 174 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 4074a41008a8..1d4529c39dc6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -844,6 +844,7 @@ config GPIO_104_DIO_48E
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
 	  104-DIO-24E). The base port addresses for the devices may be
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index f118ad9bcd33..a6f54430c5b6 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -6,7 +6,7 @@
  * This driver supports the following ACCES devices: 104-DIO-48E and
  * 104-DIO-24E.
  */
-#include <linux/bitmap.h>
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -20,6 +20,11 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "gpio-i8255.h"
+
+MODULE_IMPORT_NS(I8255);
 
 #define DIO48E_EXTENT 16
 #define MAX_NUM_DIO48E max_num_isa_dev(DIO48E_EXTENT)
@@ -33,34 +38,54 @@ static unsigned int irq[MAX_NUM_DIO48E];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
+#define DIO48E_NUM_PPI 2
+
+/**
+ * struct dio48e_reg - device register structure
+ * @ppi:		Programmable Peripheral Interface groups
+ * @enable_buffer:	Enable/Disable Buffer groups
+ * @unused1:		Unused
+ * @enable_interrupt:	Write: Enable Interrupt
+ *			Read: Disable Interrupt
+ * @unused2:		Unused
+ * @enable_counter:	Write: Enable Counter/Timer Addressing
+ *			Read: Disable Counter/Timer Addressing
+ * @unused3:		Unused
+ * @clear_interrupt:	Clear Interrupt
+ */
+struct dio48e_reg {
+	struct i8255 ppi[DIO48E_NUM_PPI];
+	u8 enable_buffer[DIO48E_NUM_PPI];
+	u8 unused1;
+	u8 enable_interrupt;
+	u8 unused2;
+	u8 enable_counter;
+	u8 unused3;
+	u8 clear_interrupt;
+};
+
 /**
  * struct dio48e_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @io_state:	bit I/O state (whether bit is set to input or output)
- * @out_state:	output bits state
- * @control:	Control registers state
- * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
- * @irq_mask:	I/O bits affected by interrupts
+ * @chip:		instance of the gpio_chip
+ * @ppi_state:		PPI device states
+ * @lock:		synchronization lock to prevent I/O race conditions
+ * @reg:		I/O address offset for the device registers
+ * @irq_mask:		I/O bits affected by interrupts
  */
 struct dio48e_gpio {
 	struct gpio_chip chip;
-	unsigned char io_state[6];
-	unsigned char out_state[6];
-	unsigned char control[2];
+	struct i8255_state ppi_state[DIO48E_NUM_PPI];
 	raw_spinlock_t lock;
-	void __iomem *base;
+	struct dio48e_reg __iomem *reg;
 	unsigned char irq_mask;
 };
 
 static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
 
-	if (dio48egpio->io_state[port] & mask)
-		return  GPIO_LINE_DIRECTION_IN;
+	if (i8255_get_direction(dio48egpio->ppi_state, offset))
+		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
 }
@@ -68,38 +93,9 @@ static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset
 static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
-	unsigned long flags;
-	unsigned int control;
-
-	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
-	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
-		/* Port C can be configured by nibble */
-		if (offset % 8 > 3) {
-			dio48egpio->io_state[io_port] |= 0xF0;
-			dio48egpio->control[control_port] |= BIT(3);
-		} else {
-			dio48egpio->io_state[io_port] |= 0x0F;
-			dio48egpio->control[control_port] |= BIT(0);
-		}
-	} else {
-		dio48egpio->io_state[io_port] |= 0xFF;
-		if (io_port == 0 || io_port == 3)
-			dio48egpio->control[control_port] |= BIT(4);
-		else
-			dio48egpio->control[control_port] |= BIT(1);
-	}
-
-	control = BIT(7) | dio48egpio->control[control_port];
-	iowrite8(control, control_addr);
-	control &= ~BIT(7);
-	iowrite8(control, control_addr);
-
-	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
+	i8255_direction_input(dio48egpio->reg->ppi, dio48egpio->ppi_state,
+			      offset);
 
 	return 0;
 }
@@ -108,48 +104,9 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 					int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	const unsigned int mask = BIT(offset % 8);
-	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
-	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
-	unsigned long flags;
-	unsigned int control;
-
-	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
-
-	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
-		/* Port C can be configured by nibble */
-		if (offset % 8 > 3) {
-			dio48egpio->io_state[io_port] &= 0x0F;
-			dio48egpio->control[control_port] &= ~BIT(3);
-		} else {
-			dio48egpio->io_state[io_port] &= 0xF0;
-			dio48egpio->control[control_port] &= ~BIT(0);
-		}
-	} else {
-		dio48egpio->io_state[io_port] &= 0x00;
-		if (io_port == 0 || io_port == 3)
-			dio48egpio->control[control_port] &= ~BIT(4);
-		else
-			dio48egpio->control[control_port] &= ~BIT(1);
-	}
-
-	if (value)
-		dio48egpio->out_state[io_port] |= mask;
-	else
-		dio48egpio->out_state[io_port] &= ~mask;
 
-	control = BIT(7) | dio48egpio->control[control_port];
-	iowrite8(control, control_addr);
-
-	iowrite8(dio48egpio->out_state[io_port], dio48egpio->base + out_port);
-
-	control &= ~BIT(7);
-	iowrite8(control, control_addr);
-
-	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
+	i8255_direction_output(dio48egpio->reg->ppi, dio48egpio->ppi_state,
+			       offset, value);
 
 	return 0;
 }
@@ -157,47 +114,16 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int in_port = (port > 2) ? port + 1 : port;
-	unsigned long flags;
-	unsigned int port_state;
-
-	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
-	/* ensure that GPIO is set for input */
-	if (!(dio48egpio->io_state[port] & mask)) {
-		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-		return -EINVAL;
-	}
-
-	port_state = ioread8(dio48egpio->base + in_port);
-
-	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-
-	return !!(port_state & mask);
+	return i8255_get(dio48egpio->reg->ppi, offset);
 }
 
-static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-
 static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *port_addr;
-	unsigned long port_state;
 
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = dio48egpio->base + ports[offset / 8];
-		port_state = ioread8(port_addr) & gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
+	i8255_get_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
 
 	return 0;
 }
@@ -205,49 +131,17 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (port > 2) ? port + 1 : port;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
-
-	if (value)
-		dio48egpio->out_state[port] |= mask;
-	else
-		dio48egpio->out_state[port] &= ~mask;
-
-	iowrite8(dio48egpio->out_state[port], dio48egpio->base + out_port);
-
-	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
+	i8255_set(dio48egpio->reg->ppi, dio48egpio->ppi_state, offset, value);
 }
 
 static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	size_t index;
-	void __iomem *port_addr;
-	unsigned long bitmask;
-	unsigned long flags;
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-		port_addr = dio48egpio->base + ports[index];
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
-		/* update output state data and set device gpio register */
-		dio48egpio->out_state[index] &= ~gpio_mask;
-		dio48egpio->out_state[index] |= bitmask;
-		iowrite8(dio48egpio->out_state[index], port_addr);
-
-		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-	}
+	i8255_set_multiple(dio48egpio->reg->ppi, dio48egpio->ppi_state, mask,
+			   bits, chip->ngpio);
 }
 
 static void dio48e_irq_ack(struct irq_data *data)
@@ -274,7 +168,7 @@ static void dio48e_irq_mask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask)
 		/* disable interrupts */
-		ioread8(dio48egpio->base + 0xB);
+		ioread8(&dio48egpio->reg->enable_interrupt);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -294,8 +188,8 @@ static void dio48e_irq_unmask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask) {
 		/* enable interrupts */
-		iowrite8(0x00, dio48egpio->base + 0xF);
-		iowrite8(0x00, dio48egpio->base + 0xB);
+		iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
+		iowrite8(0x00, &dio48egpio->reg->enable_interrupt);
 	}
 
 	if (offset == 19)
@@ -341,7 +235,7 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&dio48egpio->lock);
 
-	iowrite8(0x00, dio48egpio->base + 0xF);
+	iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
 
 	raw_spin_unlock(&dio48egpio->lock);
 
@@ -373,11 +267,26 @@ static int dio48e_irq_init_hw(struct gpio_chip *gc)
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	ioread8(dio48egpio->base + 0xB);
+	ioread8(&dio48egpio->reg->enable_interrupt);
 
 	return 0;
 }
 
+static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
+			    struct i8255_state *const ppi_state)
+{
+	const unsigned long ngpio = 24;
+	const unsigned long mask = GENMASK(ngpio - 1, 0);
+	const unsigned long bits = 0;
+	unsigned long i;
+
+	/* Initialize all GPIO to output 0 */
+	for (i = 0; i < DIO48E_NUM_PPI; i++) {
+		i8255_mode0_output(&ppi[i]);
+		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
+	}
+}
+
 static int dio48e_probe(struct device *dev, unsigned int id)
 {
 	struct dio48e_gpio *dio48egpio;
@@ -395,8 +304,8 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	dio48egpio->base = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
-	if (!dio48egpio->base)
+	dio48egpio->reg = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!dio48egpio->reg)
 		return -ENOMEM;
 
 	dio48egpio->chip.label = name;
@@ -425,17 +334,8 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 
 	raw_spin_lock_init(&dio48egpio->lock);
 
-	/* initialize all GPIO as output */
-	iowrite8(0x80, dio48egpio->base + 3);
-	iowrite8(0x00, dio48egpio->base);
-	iowrite8(0x00, dio48egpio->base + 1);
-	iowrite8(0x00, dio48egpio->base + 2);
-	iowrite8(0x00, dio48egpio->base + 3);
-	iowrite8(0x80, dio48egpio->base + 7);
-	iowrite8(0x00, dio48egpio->base + 4);
-	iowrite8(0x00, dio48egpio->base + 5);
-	iowrite8(0x00, dio48egpio->base + 6);
-	iowrite8(0x00, dio48egpio->base + 7);
+	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
+	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
 
 	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
 	if (err) {
-- 
2.36.1

