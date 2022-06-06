Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B253EBE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbiFFOhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiFFOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:36:17 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297612B01B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:36:10 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f2e0a41009so19361467fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfTrAEC+8RIPbSv52tbPZfU+fEKDARXIrRMp1LlzURg=;
        b=PdVn8UAKMCpAesFj5BGFLpNp+aIwTXO4mG6N2TEYZLF5GNt3e2WbJFsJXOJhSpcnuG
         IZtlFZzIB8VZAICoqaLu59LLLQVlugx3X+ljocTiKocjhKWTzy47LVeM4N4wm4h2jO7T
         HV9RojTqb2zTHhmEtCv2z9QBcWd175TvygQmWF+hm15mPyDyqXjh6icIvnzK0tHMTajA
         SI7Rn+L6WSMUgZ5JgPu0wu3wMsZ3x/If1D19+1KuzDbelxufvoPa7t+dU+sXY1/2qSLi
         f8V+jGUS6rmxLks9JQQpJw7iMLSWjkZ2HdoeronDKf6egUAziKmcA/ARoozmDu1PpHxz
         XsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfTrAEC+8RIPbSv52tbPZfU+fEKDARXIrRMp1LlzURg=;
        b=Vkxdd8HaDopPrO9RzI2SoU45hLMcSgEQuMHLNenolSXQ55qrOQGvpb5tN8aGbnaGri
         /s/Cbr2xI1+tehkQP98h6s5NV28apKD4dIO6fZXWj6OhNFgIWLKbAgh4mlHFbbERwjBj
         ZV07AkSa777HcBcj6JVw5rp0dNL2dUyju1uNHK1u852oTDrmDGfrb0RNHrSrD9zv7F3+
         L7BGNBz2O9bUyjWpElYVvVTjuEDKXwRCP7oazuAxEA/gi3zDSGYa2aKUGDdfdTRW637h
         stcDi4gY3urawZqf3BFaniBiNSpNE7YcHO9C1EQirNA/N7f2O8UBRaug3qjlxdGxgC/o
         5SwA==
X-Gm-Message-State: AOAM53099Nj3fDqGw7kSJ1/lN+d6St7c0PImkDe9WeQL8v0vstWEAPXb
        W3oppn/HPtomi3jYd/OpPRGMlorSPRygTQ==
X-Google-Smtp-Source: ABdhPJxH6gbXCunuQbHxi/D/1wcisDJtuO5XeNd2Om3ppELl/Dy+KlzcX7HmvliSW/sqzxFIBpFZZA==
X-Received: by 2002:a05:6870:c690:b0:f2:99d5:343e with SMTP id cv16-20020a056870c69000b000f299d5343emr31198250oab.136.1654526169955;
        Mon, 06 Jun 2022 07:36:09 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u13-20020a056871008d00b000f5d4e5b9a0sm6942791oaa.2.2022.06.06.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:36:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/5] gpio: 104-dio-48e: Implement and utilize register structures
Date:   Mon,  6 Jun 2022 10:33:16 -0400
Message-Id: <7d28ff3373d49d29b01765958ec322ce5ed0d4ff.1654525394.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654525394.git.william.gray@linaro.org>
References: <cover.1654525394.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 157 +++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index f118ad9bcd33..e1c5759e0902 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define DIO48E_EXTENT 16
 #define MAX_NUM_DIO48E max_num_isa_dev(DIO48E_EXTENT)
@@ -33,6 +34,40 @@ static unsigned int irq[MAX_NUM_DIO48E];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
+/**
+ * struct i8255_reg - Intel 8255 register structure
+ * @port:	Port A, B, and C
+ * @control:	Control register
+ */
+struct i8255_reg {
+	u8 port[3];
+	u8 control;
+};
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
+	struct i8255_reg ppi[2];
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
  * @chip:	instance of the gpio_chip
@@ -40,7 +75,7 @@ MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
  * @out_state:	output bits state
  * @control:	Control registers state
  * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  * @irq_mask:	I/O bits affected by interrupts
  */
 struct dio48e_gpio {
@@ -49,7 +84,7 @@ struct dio48e_gpio {
 	unsigned char out_state[6];
 	unsigned char control[2];
 	raw_spinlock_t lock;
-	void __iomem *base;
+	struct dio48e_reg __iomem *reg;
 	unsigned char irq_mask;
 };
 
@@ -69,32 +104,33 @@ static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offs
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
-	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
+	const unsigned long group = io_port / 3;
+	const unsigned long port = io_port - (group * 3);
+	u8 __iomem *const control_addr = &dio48egpio->reg->ppi[group].control;
 	unsigned long flags;
 	unsigned int control;
 
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
 	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
+	if (port == 2) {
 		/* Port C can be configured by nibble */
 		if (offset % 8 > 3) {
 			dio48egpio->io_state[io_port] |= 0xF0;
-			dio48egpio->control[control_port] |= BIT(3);
+			dio48egpio->control[group] |= BIT(3);
 		} else {
 			dio48egpio->io_state[io_port] |= 0x0F;
-			dio48egpio->control[control_port] |= BIT(0);
+			dio48egpio->control[group] |= BIT(0);
 		}
 	} else {
 		dio48egpio->io_state[io_port] |= 0xFF;
-		if (io_port == 0 || io_port == 3)
-			dio48egpio->control[control_port] |= BIT(4);
+		if (port == 0)
+			dio48egpio->control[group] |= BIT(4);
 		else
-			dio48egpio->control[control_port] |= BIT(1);
+			dio48egpio->control[group] |= BIT(1);
 	}
 
-	control = BIT(7) | dio48egpio->control[control_port];
+	control = BIT(7) | dio48egpio->control[group];
 	iowrite8(control, control_addr);
 	control &= ~BIT(7);
 	iowrite8(control, control_addr);
@@ -109,31 +145,33 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
+	const unsigned long group = io_port / 3;
+	const unsigned long port = io_port - (group * 3);
 	const unsigned int mask = BIT(offset % 8);
-	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
-	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
+	struct i8255_reg __iomem *const ppi = dio48egpio->reg->ppi + group;
+	u8 __iomem *const control_addr = &ppi->control;
+	u8 __iomem *const port_addr = ppi->port + port;
 	unsigned long flags;
 	unsigned int control;
 
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
 	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
+	if (port == 2) {
 		/* Port C can be configured by nibble */
 		if (offset % 8 > 3) {
 			dio48egpio->io_state[io_port] &= 0x0F;
-			dio48egpio->control[control_port] &= ~BIT(3);
+			dio48egpio->control[group] &= ~BIT(3);
 		} else {
 			dio48egpio->io_state[io_port] &= 0xF0;
-			dio48egpio->control[control_port] &= ~BIT(0);
+			dio48egpio->control[group] &= ~BIT(0);
 		}
 	} else {
 		dio48egpio->io_state[io_port] &= 0x00;
-		if (io_port == 0 || io_port == 3)
-			dio48egpio->control[control_port] &= ~BIT(4);
+		if (port == 0)
+			dio48egpio->control[group] &= ~BIT(4);
 		else
-			dio48egpio->control[control_port] &= ~BIT(1);
+			dio48egpio->control[group] &= ~BIT(1);
 	}
 
 	if (value)
@@ -141,10 +179,10 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 	else
 		dio48egpio->out_state[io_port] &= ~mask;
 
-	control = BIT(7) | dio48egpio->control[control_port];
+	control = BIT(7) | dio48egpio->control[group];
 	iowrite8(control, control_addr);
 
-	iowrite8(dio48egpio->out_state[io_port], dio48egpio->base + out_port);
+	iowrite8(dio48egpio->out_state[io_port], port_addr);
 
 	control &= ~BIT(7);
 	iowrite8(control, control_addr);
@@ -159,7 +197,8 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	const unsigned int port = offset / 8;
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int in_port = (port > 2) ? port + 1 : port;
+	const unsigned long group = port / 3;
+	const unsigned long in_port = port - (group * 3);
 	unsigned long flags;
 	unsigned int port_state;
 
@@ -171,29 +210,33 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return -EINVAL;
 	}
 
-	port_state = ioread8(dio48egpio->base + in_port);
+	port_state = ioread8(dio48egpio->reg->ppi[group].port + in_port);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 
 	return !!(port_state & mask);
 }
 
-static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-
 static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	unsigned long offset;
 	unsigned long gpio_mask;
-	void __iomem *port_addr;
+	unsigned long port;
+	unsigned long group;
+	unsigned long in_port;
+	u8 __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = dio48egpio->base + ports[offset / 8];
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		port = offset / 8;
+		group = port / 3;
+		in_port = port - (group * 3);
+		port_addr = dio48egpio->reg->ppi[group].port + in_port;
 		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
@@ -207,7 +250,8 @@ static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int val
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	const unsigned int port = offset / 8;
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (port > 2) ? port + 1 : port;
+	const unsigned long group = port / 3;
+	const unsigned long out_port = port - (group * 3);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&dio48egpio->lock, flags);
@@ -217,7 +261,8 @@ static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int val
 	else
 		dio48egpio->out_state[port] &= ~mask;
 
-	iowrite8(dio48egpio->out_state[port], dio48egpio->base + out_port);
+	iowrite8(dio48egpio->out_state[port],
+		 dio48egpio->reg->ppi[group].port + out_port);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -229,13 +274,17 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	size_t index;
-	void __iomem *port_addr;
+	size_t group;
+	size_t out_port;
+	u8 __iomem *port_addr;
 	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
 		index = offset / 8;
-		port_addr = dio48egpio->base + ports[index];
+		group = index / 3;
+		out_port = index - (group * 3);
+		port_addr = dio48egpio->reg->ppi[group].port + out_port;
 
 		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
@@ -274,7 +323,7 @@ static void dio48e_irq_mask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask)
 		/* disable interrupts */
-		ioread8(dio48egpio->base + 0xB);
+		ioread8(&dio48egpio->reg->enable_interrupt);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -294,8 +343,8 @@ static void dio48e_irq_unmask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask) {
 		/* enable interrupts */
-		iowrite8(0x00, dio48egpio->base + 0xF);
-		iowrite8(0x00, dio48egpio->base + 0xB);
+		iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
+		iowrite8(0x00, &dio48egpio->reg->enable_interrupt);
 	}
 
 	if (offset == 19)
@@ -341,7 +390,7 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&dio48egpio->lock);
 
-	iowrite8(0x00, dio48egpio->base + 0xF);
+	iowrite8(0x00, &dio48egpio->reg->clear_interrupt);
 
 	raw_spin_unlock(&dio48egpio->lock);
 
@@ -373,11 +422,25 @@ static int dio48e_irq_init_hw(struct gpio_chip *gc)
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	ioread8(dio48egpio->base + 0xB);
+	ioread8(&dio48egpio->reg->enable_interrupt);
 
 	return 0;
 }
 
+static void dio48e_init_ppi(struct i8255_reg __iomem *const ppi)
+{
+	/* Activate Mode Set; set Mode 0 output mode for Port A, B, and C */
+	iowrite8(0x80, &ppi->control);
+
+	/* Initialize all GPIO to 0 */
+	iowrite8(0x00, &ppi->port[0]);
+	iowrite8(0x00, &ppi->port[1]);
+	iowrite8(0x00, &ppi->port[2]);
+
+	/* Deactivate Mode Set */
+	iowrite8(0x00, &ppi->control);
+}
+
 static int dio48e_probe(struct device *dev, unsigned int id)
 {
 	struct dio48e_gpio *dio48egpio;
@@ -395,8 +458,8 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	dio48egpio->base = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
-	if (!dio48egpio->base)
+	dio48egpio->reg = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!dio48egpio->reg)
 		return -ENOMEM;
 
 	dio48egpio->chip.label = name;
@@ -426,16 +489,8 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	raw_spin_lock_init(&dio48egpio->lock);
 
 	/* initialize all GPIO as output */
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
+	dio48e_init_ppi(&dio48egpio->reg->ppi[0]);
+	dio48e_init_ppi(&dio48egpio->reg->ppi[1]);
 
 	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
 	if (err) {
-- 
2.36.1

