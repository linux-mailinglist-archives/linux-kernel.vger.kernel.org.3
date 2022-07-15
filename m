Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E973A578C40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiGRU5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiGRU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:57:03 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63C32B82
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:57:00 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l9-20020a056830268900b006054381dd35so10234029otu.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BguhXpMM+bZOyQ8uv1giPWb1tgh33TeNy2eh10Br27A=;
        b=An8lC8KfY06PYa1RYp4mbjKfj0VonTQ6ApbL99AYyiYT7Vnx1YQyEW0za0mQMgLrMm
         AeRpEfc/qW2KV2Z2rwl0Ba1URVJywnNZxUMhdNJ7bEPNu7ODEnzl4FaSGdBDKNo+I/84
         cvhK2fttexFfQRZB7BYtY501FMmhYpq0ayFqHuLXgYvHjfhFHF3c/zOtBJ29nGds674H
         9onUBYD20iVc84ljkocmYdk2ks+gO8SCVc+0zlttHT6gUZzm+oyOAexB8NsepmXZaTMe
         MaSIK65qoZ5NztCKlnXjCH/ltXfTea9c4/IhGuWJog6L4f84CfZGtq1IGrwadzxJxr6P
         hkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BguhXpMM+bZOyQ8uv1giPWb1tgh33TeNy2eh10Br27A=;
        b=iy1F1xrE1cCNB8Q11ZMidY/kLQ3gyvXL+527eTb1WO8OEDvSLV/KzM52A9/nDqbr+e
         gujAiDWH58F0ZN1rkHCzy2S/pD4BO+lnxkt8TLvY0Eo32RC8x4mQr1ZTkn7/otPSwr0V
         ZWrpTyIZ1ZkVmz8EsZSqS6mcQG7ewOo2MuqAHFDAQ4OJn+UDSEhS5kcWhaTabujPZCzH
         xtFAfliBIC1P47cLHeOgHBY3keUum9LvNcltNhxE8ALVP1+bd+4PB0Dz5yDYwwK2ZyrV
         uthrPW/dPXR1mK1G0ZvD5nTyUfFooZQ6V4iGOUW7NbwppLCxWZB4PhAJEUauQWitYG3A
         hTJA==
X-Gm-Message-State: AJIora8oWiJlOnDCtsQuNKzdBd3HQejJxWBoejq43U/XWuAcCzoLPGph
        r1tsrbrjeaetbCjEFPwSBEbLlg==
X-Google-Smtp-Source: AGRyM1v2qj1xxNiiv3R+F6Gxia9t/N/x49Yw5ZzYzY/xYyGBpQ75JZuuJ/VfwKJUhUPqPwrOe5f17w==
X-Received: by 2002:a05:6830:1e31:b0:61c:ac69:94ce with SMTP id t17-20020a0568301e3100b0061cac6994cemr1559544otr.282.1658177819445;
        Mon, 18 Jul 2022 13:56:59 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ab2c8000000b0035eb4e5a6cbsm5252065ooo.33.2022.07.18.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:56:59 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v3 5/6] gpio: 104-idi-48: Implement and utilize register structures
Date:   Fri, 15 Jul 2022 14:52:27 -0400
Message-Id: <300ea3f4c4b1ebc0ef934875fdefe9402ab1e9a4.1657907849.git.william.gray@linaro.org>
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
utilizing named register data structures. The 104-IDI-48 device features
an Intel 8255 compatible GPIO interface, so the i8255 GPIO module is
selected and utilized as well.

Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3:
 - Include "gpio-i8255.h" instead of <linux/gpio/i8255.h>
 - Import I8255 symbol namespace
 - Consolidate 'lock' and 'ack_lock' into a single spinlock 'lock'
   synchronizing I/O as well as protecting irq_mask states

 drivers/gpio/Kconfig           |   1 +
 drivers/gpio/gpio-104-idi-48.c | 141 ++++++++++++++-------------------
 2 files changed, 60 insertions(+), 82 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1d4529c39dc6..253a03ee3fa4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -868,6 +868,7 @@ config GPIO_104_IDI_48
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
 	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 9521ece3ebef..380ab1221a66 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -6,7 +6,6 @@
  * This driver supports the following ACCES devices: 104-IDI-48A,
  * 104-IDI-48AC, 104-IDI-48B, and 104-IDI-48BC.
  */
-#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -20,6 +19,11 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "gpio-i8255.h"
+
+MODULE_IMPORT_NS(I8255);
 
 #define IDI_48_EXTENT 8
 #define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
@@ -33,21 +37,34 @@ static unsigned int irq[MAX_NUM_IDI_48];
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
- * @ack_lock:	synchronization lock to prevent IRQ handler race conditions
  * @irq_mask:	input bits affected by interrupts
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  * @cos_enb:	Change-Of-State IRQ enable boundaries mask
  */
 struct idi_48_gpio {
 	struct gpio_chip chip;
-	raw_spinlock_t lock;
-	spinlock_t ack_lock;
+	spinlock_t lock;
 	unsigned char irq_mask[6];
-	void __iomem *base;
+	struct idi_48_reg __iomem *reg;
 	unsigned char cos_enb;
 };
 
@@ -64,42 +81,18 @@ static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
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
-
-			return !!(ioread8(port_addr) & mask);
-		}
+	const void __iomem *const ppi = idi48gpio->reg;
 
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
@@ -113,30 +106,24 @@ static void idi_48_irq_mask(struct irq_data *data)
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
+	spin_lock_irqsave(&idi48gpio->lock, flags);
 
-			if (!idi48gpio->irq_mask[boundary]) {
-				idi48gpio->cos_enb &= ~BIT(boundary);
+	idi48gpio->irq_mask[boundary] &= ~mask;
 
-				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	/* Exit early if there are still input lines with IRQ unmasked */
+	if (idi48gpio->irq_mask[boundary])
+		goto exit;
 
-				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
+	idi48gpio->cos_enb &= ~BIT(boundary);
 
-				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
-			}
+	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
 
-			return;
-		}
+exit:
+	spin_unlock_irqrestore(&idi48gpio->lock, flags);
 }
 
 static void idi_48_irq_unmask(struct irq_data *data)
@@ -144,32 +131,27 @@ static void idi_48_irq_unmask(struct irq_data *data)
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
+	spin_lock_irqsave(&idi48gpio->lock, flags);
 
-			idi48gpio->irq_mask[boundary] |= mask;
+	prev_irq_mask = idi48gpio->irq_mask[boundary];
 
-			if (!prev_irq_mask) {
-				idi48gpio->cos_enb |= BIT(boundary);
+	idi48gpio->irq_mask[boundary] |= mask;
 
-				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	/* Exit early if IRQ was already unmasked for this boundary */
+	if (prev_irq_mask)
+		goto exit;
 
-				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
+	idi48gpio->cos_enb |= BIT(boundary);
 
-				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
-			}
+	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
 
-			return;
-		}
+exit:
+	spin_unlock_irqrestore(&idi48gpio->lock, flags);
 }
 
 static int idi_48_irq_set_type(struct irq_data *data, unsigned flow_type)
@@ -200,17 +182,13 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 	unsigned long gpio;
 	struct gpio_chip *const chip = &idi48gpio->chip;
 
-	spin_lock(&idi48gpio->ack_lock);
-
-	raw_spin_lock(&idi48gpio->lock);
-
-	cos_status = ioread8(idi48gpio->base + 7);
+	spin_lock(&idi48gpio->lock);
 
-	raw_spin_unlock(&idi48gpio->lock);
+	cos_status = ioread8(&idi48gpio->reg->irq);
 
 	/* IRQ Status (bit 6) is active low (0 = IRQ generated by device) */
 	if (cos_status & BIT(6)) {
-		spin_unlock(&idi48gpio->ack_lock);
+		spin_unlock(&idi48gpio->lock);
 		return IRQ_NONE;
 	}
 
@@ -228,7 +206,7 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 		}
 	}
 
-	spin_unlock(&idi48gpio->ack_lock);
+	spin_unlock(&idi48gpio->lock);
 
 	return IRQ_HANDLED;
 }
@@ -250,8 +228,8 @@ static int idi_48_irq_init_hw(struct gpio_chip *gc)
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	iowrite8(0, idi48gpio->base + 7);
-	ioread8(idi48gpio->base + 7);
+	iowrite8(0, &idi48gpio->reg->irq);
+	ioread8(&idi48gpio->reg->irq);
 
 	return 0;
 }
@@ -273,8 +251,8 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idi48gpio->base = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
-	if (!idi48gpio->base)
+	idi48gpio->reg = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!idi48gpio->reg)
 		return -ENOMEM;
 
 	idi48gpio->chip.label = name;
@@ -298,8 +276,7 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	girq->handler = handle_edge_irq;
 	girq->init_hw = idi_48_irq_init_hw;
 
-	raw_spin_lock_init(&idi48gpio->lock);
-	spin_lock_init(&idi48gpio->ack_lock);
+	spin_lock_init(&idi48gpio->lock);
 
 	err = devm_gpiochip_add_data(dev, &idi48gpio->chip, idi48gpio);
 	if (err) {
-- 
2.36.1

