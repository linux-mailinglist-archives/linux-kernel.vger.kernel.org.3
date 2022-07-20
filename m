Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5DB57B7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiGTNqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiGTNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:46:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3E5A47F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:46:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m6so13477600qvq.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKb2mSasNJyrXspITPqbYCazsTxN0bsowmCfKFzVHKg=;
        b=QfvoliDbXEH84383CNgRb4d5CFeD9R8VoEKBiSJUISC9bwuvDvZkpx8rLYWbqqGG8D
         SKMhB9x+SM4H5IP43Vi4ZfMv2FIXLNEiqSMRdlWweL8xZ3DI+AUvbonKVsxxNQWJRqLR
         6nEcaDkg8DqyWJXf+E0CL3blUUA5rkOZVdEiK84eBWHItfkOgwwNhHujksdJ6JshUEEg
         idq4YmpLII3EECNQwKPVNM3p41e+dEb4nycz6IEti3OK9lcXfHiZyTtwPn81Lo/AZDRH
         KJfSe+gqpzV2sJiNWPbx20ih1Ij74/RHLg9EJmf+BKcpTfBcl3o+8trBrpkSFqdytAXq
         cJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKb2mSasNJyrXspITPqbYCazsTxN0bsowmCfKFzVHKg=;
        b=XzoSRCX+xNFmCoFTzftyA+KtZypIExiWak/V4ZeesruT2kH0LakbpY1VnPbjWYmFbi
         j7FTH595mc8eRWW/Iy8YdIeTCVUfG2/llgHiAPeyPyF7+sZioJN6fHmaU3/3SADNyYRv
         6BHEKWFA2rfbNmsYRxzYx/VyCCyOkm7EfXIN58MQRhFTe10nFxn13NcAns4i7n2ndaNB
         vRsiWj45VdLw1Rm0KYBaLU0iYmOHI8/kFxl2Fl/6Hblt5JQJwvapBGBT7g3xUhKt9akG
         RWBhbe8RFiqUOz0LE+v+FmKbcOkvgG/LLQ2O7ITN9ugS4OfEZErzVACKynTzhWbBsKyK
         eXgA==
X-Gm-Message-State: AJIora9nkU7y9Ebu95oIcwX2yulb5YbcCla5oRlnpo9m93poJYFuB4CR
        05zJI8sk9LpS8o0Rk69vvTfPtg==
X-Google-Smtp-Source: AGRyM1v0AEGI7VmT7Bn6IH56fB09VomJ+U2qWr86iB/4/KVmIsedul2jOWa3AwbO4RfXRcAf6EbN9g==
X-Received: by 2002:a05:6214:2021:b0:474:5f9:8385 with SMTP id 1-20020a056214202100b0047405f98385mr1745492qvf.105.1658324775476;
        Wed, 20 Jul 2022 06:46:15 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bl13-20020a05620a1a8d00b006b5f8f32a8fsm5289853qkb.114.2022.07.20.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:46:15 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [RESEND PATCH v4 5/6] gpio: 104-idi-48: Implement and utilize register structures
Date:   Wed, 20 Jul 2022 09:46:01 -0400
Message-Id: <699f47f2301d1f6440cde1ecffaeb21a6f87d912.1658324498.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658324498.git.william.gray@linaro.org>
References: <cover.1658324498.git.william.gray@linaro.org>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4:
 - Replace superfluous <linux/bitops.h> include with <linux/bits.h>
 - Remove 'const' from '__iomem' pointers

 drivers/gpio/Kconfig           |   1 +
 drivers/gpio/gpio-104-idi-48.c | 143 ++++++++++++++-------------------
 2 files changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d070bd9f4f94..8f1d4d56f0aa 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -865,6 +865,7 @@ config GPIO_104_IDI_48
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select GPIO_I8255
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
 	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index c1e4c3629e17..40be76efeed7 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -6,8 +6,7 @@
  * This driver supports the following ACCES devices: 104-IDI-48A,
  * 104-IDI-48AC, 104-IDI-48B, and 104-IDI-48BC.
  */
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
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
 
@@ -64,42 +81,18 @@ static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned int offs
 static int idi_48_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	unsigned int i;
-	static const unsigned int register_offset[6] = { 0, 1, 2, 4, 5, 6 };
-	void __iomem *port_addr;
-	unsigned int mask;
-
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			port_addr = idi48gpio->base + register_offset[i / 8];
-			mask = BIT(offset - i);
-
-			return !!(ioread8(port_addr) & mask);
-		}
+	void __iomem *const ppi = idi48gpio->reg;
 
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
+	void __iomem *const ppi = idi48gpio->reg;
 
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
 	const unsigned int offset = irqd_to_hwirq(data);
-	unsigned int i;
-	unsigned int mask;
-	unsigned int boundary;
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
 	const unsigned int offset = irqd_to_hwirq(data);
-	unsigned int i;
-	unsigned int mask;
-	unsigned int boundary;
+	const unsigned long boundary = offset / 8;
+	const unsigned long mask = BIT(offset % 8);
 	unsigned int prev_irq_mask;
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
 
 static int idi_48_irq_set_type(struct irq_data *data, unsigned int flow_type)
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

