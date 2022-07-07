Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C01056AEEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiGGXQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiGGXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:16:19 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E4675B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:16:18 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2a4c51c45so27231741fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4fvya9qVEYx2ENN6AM5NhnuLR4II7vSeVqvvYlfIvg=;
        b=M2+SG47nS9M/dDCrbAC7nobT3jBS6tjydumDAh1rT0zKXdN6uv7dyilcTaCEEb1IbH
         /a0+YmuQpXVBvIXW3BgjAg1qzqRw2q5Ep0aYp2AqdnFghqYt3MwnSldQPdEpTTmzPkIw
         H4DkJTqbqOfBimIEwRa6u5fM9IwhY8Xb2XANmpk94z6ejHoymSr/1O/wM1Cmb1C+8L1n
         tDFV27gsDh2PNOuKwmLi+rufZjzIG+6n5YBcZo0PgiwCnSh3kBReVBasE0uNvp1cG6Xw
         2tFawMYR69AeAagZnQylt4kh5Q/LHhIm6Xpa3NUTm8d635FMKdqoub79iv7GXxTnWkdO
         tAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4fvya9qVEYx2ENN6AM5NhnuLR4II7vSeVqvvYlfIvg=;
        b=c2A9uVLxJbRUwB83swhavIqQzusd9+G1MKMnuv4IQ7RIssu3V1ZwJknF/vFrzihl+r
         CaP3lrJPFVyzh9oCMXIOzkS64FXNa1biJrjZZ2EIc2tj+9ACLvZ3FJcGGhjd+cAv1o33
         NhP6kUfj05rpCzakK3Lt6cFFpoAp8o6x7bazRuW8ZLIxAuwFSIjiH9lN4P2JDgzHeA7o
         23+W50FZK1ViL2Wgx3PVq67Ln2mVGdazaJiVNwKfdkLjKIKfla71AxvzI5nfP9JtCX5V
         73DcvIN74aPJ4pVneEKtcLKaGbzKmJOXrXQ+XqVEQn3wO2C0XBjehbgaZD4eWEQ9ESjb
         fGyQ==
X-Gm-Message-State: AJIora+hzUV7IJIx7m+1EVdwh67S0tQdsuVHLHZffcLAtdwz/dMJwwMH
        4O1BEcHrIWynW3A/jLVBS8HvD8REd5ifyIjt
X-Google-Smtp-Source: AGRyM1tIF/4SgPIy80RniO9hlz0g67NTLH5CCYBIhdQ8hgfMwqGdLzjyiOXHCXkfVRWRBis63VwlmA==
X-Received: by 2002:a05:6870:b60e:b0:e9:35aa:3cb8 with SMTP id cm14-20020a056870b60e00b000e935aa3cb8mr203724oab.249.1657235777740;
        Thu, 07 Jul 2022 16:16:17 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056830630a00b006190efaf118sm2177606otb.66.2022.07.07.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:16:17 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 3/6] gpio: 104-idi-48: Implement and utilize register structures
Date:   Thu,  7 Jul 2022 14:10:05 -0400
Message-Id: <29278ba7d6b22c295fce8dcfe162553ed719bac7.1657216200.git.william.gray@linaro.org>
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
utilizing named register data structures. The 104-IDI-48 device features
an Intel 8255 compatible GPIO interface, so the i8255 GPIO module is
selected and utilized as well.

Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig           |   1 +
 drivers/gpio/gpio-104-idi-48.c | 123 +++++++++++++--------------------
 2 files changed, 50 insertions(+), 74 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 31546969f66a..0ae818d548bb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -861,6 +861,7 @@ config GPIO_104_IDI_48
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
 	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 9521ece3ebef..7c8ae95237e6 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -6,11 +6,11 @@
  * This driver supports the following ACCES devices: 104-IDI-48A,
  * 104-IDI-48AC, 104-IDI-48B, and 104-IDI-48BC.
  */
-#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/i8255.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define IDI_48_EXTENT 8
 #define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
@@ -33,13 +34,28 @@ static unsigned int irq[MAX_NUM_IDI_48];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
+/**
+ * struct idi_48_reg - device register structure
+ * @port0:	Port 0 Inputs
+ * @unused:	Unused
+ * @port1:	Port 1 Inputs
+ * @irq:	Read: IRQ Status Register/IRQ Clear
+ *		Write: IRQ Enable/Disable
+ */
+struct idi_48_reg {
+	u8 port0[3];
+	u8 unused;
+	u8 port1[3];
+	u8 irq;
+};
+
 /**
  * struct idi_48_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @ack_lock:	synchronization lock to prevent IRQ handler race conditions
  * @irq_mask:	input bits affected by interrupts
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  * @cos_enb:	Change-Of-State IRQ enable boundaries mask
  */
 struct idi_48_gpio {
@@ -47,7 +63,7 @@ struct idi_48_gpio {
 	raw_spinlock_t lock;
 	spinlock_t ack_lock;
 	unsigned char irq_mask[6];
-	void __iomem *base;
+	struct idi_48_reg __iomem *reg;
 	unsigned char cos_enb;
 };
 
@@ -64,42 +80,18 @@ static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 static int idi_48_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	unsigned i;
-	static const unsigned int register_offset[6] = { 0, 1, 2, 4, 5, 6 };
-	void __iomem *port_addr;
-	unsigned mask;
-
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			port_addr = idi48gpio->base + register_offset[i / 8];
-			mask = BIT(offset - i);
+	const void __iomem *const ppi = idi48gpio->reg;
 
-			return !!(ioread8(port_addr) & mask);
-		}
-
-	/* The following line should never execute since offset < 48 */
-	return 0;
+	return i8255_get(ppi, offset);
 }
 
 static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	void __iomem *port_addr;
-	unsigned long port_state;
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
+	const void __iomem *const ppi = idi48gpio->reg;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = idi48gpio->base + ports[offset / 8];
-		port_state = ioread8(port_addr) & gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
+	i8255_get_multiple(ppi, mask, bits, chip->ngpio);
 
 	return 0;
 }
@@ -113,30 +105,21 @@ static void idi_48_irq_mask(struct irq_data *data)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	const unsigned offset = irqd_to_hwirq(data);
-	unsigned i;
-	unsigned mask;
-	unsigned boundary;
+	const unsigned long boundary = offset / 8;
+	const unsigned long mask = BIT(offset % 8);
 	unsigned long flags;
 
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			mask = BIT(offset - i);
-			boundary = i / 8;
-
-			idi48gpio->irq_mask[boundary] &= ~mask;
-
-			if (!idi48gpio->irq_mask[boundary]) {
-				idi48gpio->cos_enb &= ~BIT(boundary);
-
-				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	idi48gpio->irq_mask[boundary] &= ~mask;
 
-				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
+	/* Exit early if there are still input lines with IRQ unmasked */
+	if (idi48gpio->irq_mask[boundary])
+		return;
 
-				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
-			}
+	idi48gpio->cos_enb &= ~BIT(boundary);
 
-			return;
-		}
+	raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
+	raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
 }
 
 static void idi_48_irq_unmask(struct irq_data *data)
@@ -144,32 +127,24 @@ static void idi_48_irq_unmask(struct irq_data *data)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	const unsigned offset = irqd_to_hwirq(data);
-	unsigned i;
-	unsigned mask;
-	unsigned boundary;
+	const unsigned long boundary = offset / 8;
+	const unsigned long mask = BIT(offset % 8);
 	unsigned prev_irq_mask;
 	unsigned long flags;
 
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			mask = BIT(offset - i);
-			boundary = i / 8;
-			prev_irq_mask = idi48gpio->irq_mask[boundary];
-
-			idi48gpio->irq_mask[boundary] |= mask;
+	prev_irq_mask = idi48gpio->irq_mask[boundary];
 
-			if (!prev_irq_mask) {
-				idi48gpio->cos_enb |= BIT(boundary);
+	idi48gpio->irq_mask[boundary] |= mask;
 
-				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	/* Exit early if IRQ was already unmasked for this boundary */
+	if (prev_irq_mask)
+		return;
 
-				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
+	idi48gpio->cos_enb |= BIT(boundary);
 
-				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
-			}
-
-			return;
-		}
+	raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
+	raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
 }
 
 static int idi_48_irq_set_type(struct irq_data *data, unsigned flow_type)
@@ -204,7 +179,7 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&idi48gpio->lock);
 
-	cos_status = ioread8(idi48gpio->base + 7);
+	cos_status = ioread8(&idi48gpio->reg->irq);
 
 	raw_spin_unlock(&idi48gpio->lock);
 
@@ -250,8 +225,8 @@ static int idi_48_irq_init_hw(struct gpio_chip *gc)
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	iowrite8(0, idi48gpio->base + 7);
-	ioread8(idi48gpio->base + 7);
+	iowrite8(0, &idi48gpio->reg->irq);
+	ioread8(&idi48gpio->reg->irq);
 
 	return 0;
 }
@@ -273,8 +248,8 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idi48gpio->base = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
-	if (!idi48gpio->base)
+	idi48gpio->reg = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!idi48gpio->reg)
 		return -ENOMEM;
 
 	idi48gpio->chip.label = name;
-- 
2.36.1

