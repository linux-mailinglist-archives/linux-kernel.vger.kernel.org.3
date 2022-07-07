Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA756AEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiGGXQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiGGXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:16:19 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E7675B6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:16:17 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10c0d96953fso13644974fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/Pb3b9iq5ouKUw5SoagUHZIMdxbCTv5dMFA6mF6+0s=;
        b=GPRkQvDtbh0Q+qFT4lJstnsZrpZVfE7Fug7R22wnT2Nz547tj5WWrJLS7ea1pRJ5vm
         7yzJYStQkqTSlKFtxForRQo7LH1osjKk9tVgx16UIronBOfQrsWfreHSDqOWrtBZIcBT
         QDbc6FVqR9ml4zMHd+kSUgx4fExxTOheNit6ey1bakaCufYZgD5HRJ6QNf+nRLgClH6B
         B3POWwUKSZhvnZY+d8FsD4CiSo8lGuydDFaOU8cLpIDb69W5Vv9rkxpAkT0amJlS+fGs
         J+hG0l5BwJXnf94KqMdHaWM8PLfDAPDp3fAqtnwzrjob7fhxiBn7tK+VlPjYFo5Tb9fH
         8ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/Pb3b9iq5ouKUw5SoagUHZIMdxbCTv5dMFA6mF6+0s=;
        b=sdQepSXjN5LT/DsfAPyhHmW1aKcz1QoLHbF0EYxkevH1KyVAVeeslLvFhguSpcgQIF
         jIgAqHp3FabKXc2j7A1iJ+sSf9xSrCgnPlzBymBBUoiSnCPAE/vaD0K1ZnzCRvQMcW60
         CizmzdqUwSh/ieUxHtvm/qiBBZMAskXobaMUwAY+ppzqHDrv97lHrHJ4nJYrB3YUmmeo
         SOwJ9ERDOMwUprm9ALe0NsuIN5+krkcD073NL7bvLeOtMSiy7Zi6VjNumpE/dU3FZGkc
         stqoItKUyGiB0n/V1x36Ii8G5dF0PGhk7fQMkvlCoIZPyLjq6k/Me1ylDC6Rs5Fto/hB
         8ojQ==
X-Gm-Message-State: AJIora/Azbo2mcOnXWIPCGBRbrPpQxYn8Wi2InJWtF5/J9b2CFIuvDuY
        4DI/JpDuFhl/x8w9S5sxdnkOlBDz+yLpgglb
X-Google-Smtp-Source: AGRyM1t1VZdbybprqCVI6BeITv+UBQgl8xz2bMmhnEZtvNnH8M7e7zgTTxP1X+Gd0z/s0csYaj8XJw==
X-Received: by 2002:a05:6870:f603:b0:101:a202:42b2 with SMTP id ek3-20020a056870f60300b00101a20242b2mr4239960oab.221.1657235776878;
        Thu, 07 Jul 2022 16:16:16 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056830630a00b006190efaf118sm2177606otb.66.2022.07.07.16.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:16:16 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 2/6] gpio: 104-dio-48e: Implement and utilize register structures
Date:   Thu,  7 Jul 2022 14:10:04 -0400
Message-Id: <719ac333791525d3304e195478b0900c374daa4a.1657216200.git.william.gray@linaro.org>
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
utilizing named register data structures. The 104-DIO-48E device
features an Intel 8255 compatible GPIO interface, so the i8255 GPIO
module is selected and utilized as well.

Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |   1 +
 drivers/gpio/gpio-104-dio-48e.c | 224 ++++++++++----------------------
 2 files changed, 69 insertions(+), 156 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5cbe93330213..31546969f66a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -837,6 +837,7 @@ config GPIO_104_DIO_48E
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
 	  104-DIO-24E). The base port addresses for the devices may be
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index f118ad9bcd33..dab1fb44f295 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -6,11 +6,12 @@
  * This driver supports the following ACCES devices: 104-DIO-48E and
  * 104-DIO-24E.
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
 #include <linux/interrupt.h>
@@ -20,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define DIO48E_EXTENT 16
 #define MAX_NUM_DIO48E max_num_isa_dev(DIO48E_EXTENT)
@@ -33,34 +35,52 @@ static unsigned int irq[MAX_NUM_DIO48E];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
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
+	struct i8255 ppi[2];
+	u8 enable_buffer[2];
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
+ * @control_state:	Control registers state
+ * @lock:		synchronization lock to prevent I/O race conditions
+ * @reg:		I/O address offset for the device registers
+ * @irq_mask:		I/O bits affected by interrupts
  */
 struct dio48e_gpio {
 	struct gpio_chip chip;
-	unsigned char io_state[6];
-	unsigned char out_state[6];
-	unsigned char control[2];
+	u8 control_state[2];
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
+	if (i8255_get_direction(dio48egpio->control_state, offset))
+		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
 }
@@ -68,36 +88,12 @@ static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset
 static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
 	unsigned long flags;
-	unsigned int control;
 
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
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
+	i8255_direction_input(dio48egpio->reg->ppi, dio48egpio->control_state,
+			      offset);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 
@@ -108,46 +104,12 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 					int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	const unsigned int mask = BIT(offset % 8);
-	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
-	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
 	unsigned long flags;
-	unsigned int control;
 
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
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
-
-	control = BIT(7) | dio48egpio->control[control_port];
-	iowrite8(control, control_addr);
-
-	iowrite8(dio48egpio->out_state[io_port], dio48egpio->base + out_port);
-
-	control &= ~BIT(7);
-	iowrite8(control, control_addr);
+	i8255_direction_output(dio48egpio->reg->ppi, dio48egpio->control_state,
+			       offset, value);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 
@@ -157,47 +119,16 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
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
-
-	/* ensure that GPIO is set for input */
-	if (!(dio48egpio->io_state[port] & mask)) {
-		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-		return -EINVAL;
-	}
 
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
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = dio48egpio->base + ports[offset / 8];
-		port_state = ioread8(port_addr) & gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
+	i8255_get_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
 
 	return 0;
 }
@@ -205,19 +136,11 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	const unsigned int port = offset / 8;
-	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (port > 2) ? port + 1 : port;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
-	if (value)
-		dio48egpio->out_state[port] |= mask;
-	else
-		dio48egpio->out_state[port] &= ~mask;
-
-	iowrite8(dio48egpio->out_state[port], dio48egpio->base + out_port);
+	i8255_set(dio48egpio->reg->ppi, offset, value);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -226,28 +149,13 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	size_t index;
-	void __iomem *port_addr;
-	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-		port_addr = dio48egpio->base + ports[index];
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		raw_spin_lock_irqsave(&dio48egpio->lock, flags);
+	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
-		/* update output state data and set device gpio register */
-		dio48egpio->out_state[index] &= ~gpio_mask;
-		dio48egpio->out_state[index] |= bitmask;
-		iowrite8(dio48egpio->out_state[index], port_addr);
+	i8255_set_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
 
-		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-	}
+	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
 
 static void dio48e_irq_ack(struct irq_data *data)
@@ -274,7 +182,7 @@ static void dio48e_irq_mask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask)
 		/* disable interrupts */
-		ioread8(dio48egpio->base + 0xB);
+		ioread8(&dio48egpio->reg->enable_interrupt);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -294,8 +202,8 @@ static void dio48e_irq_unmask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask) {
 		/* enable interrupts */
-		iowrite8(0x00, dio48egpio->base + 0xF);
-		iowrite8(0x00, dio48egpio->base + 0xB);
+		iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
+		iowrite8(0x00, &dio48egpio->reg->enable_interrupt);
 	}
 
 	if (offset == 19)
@@ -341,7 +249,7 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&dio48egpio->lock);
 
-	iowrite8(0x00, dio48egpio->base + 0xF);
+	iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
 
 	raw_spin_unlock(&dio48egpio->lock);
 
@@ -373,11 +281,25 @@ static int dio48e_irq_init_hw(struct gpio_chip *gc)
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	ioread8(dio48egpio->base + 0xB);
+	ioread8(&dio48egpio->reg->enable_interrupt);
 
 	return 0;
 }
 
+static void dio48e_init_ppi(struct i8255 __iomem *const ppi)
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
 static int dio48e_probe(struct device *dev, unsigned int id)
 {
 	struct dio48e_gpio *dio48egpio;
@@ -395,8 +317,8 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	dio48egpio->base = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
-	if (!dio48egpio->base)
+	dio48egpio->reg = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!dio48egpio->reg)
 		return -ENOMEM;
 
 	dio48egpio->chip.label = name;
@@ -425,17 +347,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 
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
+	dio48e_init_ppi(dio48egpio->reg->ppi);
 
 	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
 	if (err) {
-- 
2.36.1

