Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4069E57A2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiGSPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbiGSPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:14:36 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B0A545D7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:35 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bd4812c29so32199827fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJqWp+udTO0Z1cqQdPtymTtYII3QhZ3OpR+pl1jwWrE=;
        b=trQnNsFi5MMP/2ZUVE+WQv9ZDNEziTTNQ4NXmOisoEIALB3QuEo9709yC/mL+Bgwd6
         +ouzArgrDE4/un3Ia7SYJz72n7qjcoy4LMo3QmuRZoJbdKQI1Ethrq/BWArnSlXcaaed
         RTqv+48j1p0kKO6YFvNRcdIGlyT/VBFPYs/pgEvVOkyLIafBdvwQFKp/p+1o+k1KvDD6
         1NGEx6MxNxPF2xz/zbYRwoKwJnUjEAB0ULp73/OUFkw8q3MvKFBFtbxmxKH/JcVOG6xx
         L8ZlOu9XsrgdKaWPyHTQbvsEDS3xJpXIYZVaUTG/vhsFvmdLp3Ohv28qCmP7HcyepbCP
         16Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJqWp+udTO0Z1cqQdPtymTtYII3QhZ3OpR+pl1jwWrE=;
        b=ENGVDJu3jCX0tbht/SUZMVFKqL05CxdvIeG50698rXh/AUC0miXFNJW0S5bRlMF4xT
         YeBhEa8pG5nZalw7wfov07LoR1uM00bYKh/ky3dLkZHmn2m25unrFn+eO0+30w1/WkGf
         Pwv8tQDhgfpqO69xlsKkrkPcfrJX6PId492KO6ulLTsfXVGGNcYm1pBMosz5cCMioKyV
         mdTZVE3y8a93T664+ro/MSFFTVdOx4d39a/1mnpYUqyOsjUliPs17w7AIoH47UQQ8AJL
         juk/9S96SGPkgDHiQhydSZrRSOpdLhzc+kfrR36DU96D/f9lMvad5aksBNiftbcioSFb
         hSQg==
X-Gm-Message-State: AJIora/7mY3ml2ls96n21GPjtQnQ/a0/e1c+xBjRiBDlC4JM0ORiqOIN
        wW3Qbfl2LOubgQFVtsexoNCc0Q==
X-Google-Smtp-Source: AGRyM1smVDYloTBU9+bMDJbjj8L4wbqiVQW/Ylzxh6wc+zsCoDyplum0akn1CPfUmRN8KKJLJ+AWDQ==
X-Received: by 2002:a05:6870:600b:b0:10b:94bc:61ad with SMTP id t11-20020a056870600b00b0010b94bc61admr20851656oaa.208.1658243674625;
        Tue, 19 Jul 2022 08:14:34 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l24-20020a056830155800b0061c8bca21d8sm2334308otp.2.2022.07.19.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:14:34 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: [PATCH v4 1/6] gpio: ws16c48: Implement and utilize register structures
Date:   Tue, 19 Jul 2022 09:47:03 -0400
Message-Id: <68dbab857f380712e6d5bda2c57a5f11bb13e95f.1658236877.git.william.gray@linaro.org>
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
utilizing named register data structures.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Demetrotion <pdemetrotion@winsystems.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4:
 - Remove superfluous <linux/bitops.h> include

 drivers/gpio/gpio-ws16c48.c | 120 +++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 36 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 5078631d8014..b098f2dc196b 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2016 William Breathitt Gray
  */
 #include <linux/bitmap.h>
-#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -17,8 +16,9 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
-#define WS16C48_EXTENT 16
+#define WS16C48_EXTENT 10
 #define MAX_NUM_WS16C48 max_num_isa_dev(WS16C48_EXTENT)
 
 static unsigned int base[MAX_NUM_WS16C48];
@@ -30,6 +30,20 @@ static unsigned int irq[MAX_NUM_WS16C48];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "WinSystems WS16C48 interrupt line numbers");
 
+/**
+ * struct ws16c48_reg - device register structure
+ * @port:		Port 0 through 5 I/O
+ * @int_pending:	Interrupt Pending
+ * @page_lock:		Register page (Bits 7-6) and I/O port lock (Bits 5-0)
+ * @pol_enab_int_id:	Interrupt polarity, enable, and ID
+ */
+struct ws16c48_reg {
+	u8 port[6];
+	u8 int_pending;
+	u8 page_lock;
+	u8 pol_enab_int_id[3];
+};
+
 /**
  * struct ws16c48_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
@@ -38,7 +52,7 @@ MODULE_PARM_DESC(irq, "WinSystems WS16C48 interrupt line numbers");
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	I/O bits affected by interrupts
  * @flow_mask:	IRQ flow type mask for the respective I/O bits
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  */
 struct ws16c48_gpio {
 	struct gpio_chip chip;
@@ -47,7 +61,7 @@ struct ws16c48_gpio {
 	raw_spinlock_t lock;
 	unsigned long irq_mask;
 	unsigned long flow_mask;
-	void __iomem *base;
+	struct ws16c48_reg __iomem *reg;
 };
 
 static int ws16c48_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -73,7 +87,7 @@ static int ws16c48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	ws16c48gpio->io_state[port] |= mask;
 	ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -95,7 +109,7 @@ static int ws16c48_gpio_direction_output(struct gpio_chip *chip,
 		ws16c48gpio->out_state[port] |= mask;
 	else
 		ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -118,7 +132,7 @@ static int ws16c48_gpio_get(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	port_state = ioread8(ws16c48gpio->base + port);
+	port_state = ioread8(ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -131,14 +145,16 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
 	unsigned long offset;
 	unsigned long gpio_mask;
-	void __iomem *port_addr;
+	size_t index;
+	u8 __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
 	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
-		port_addr = ws16c48gpio->base + offset / 8;
+		index = offset / 8;
+		port_addr = ws16c48gpio->reg->port + index;
 		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
@@ -166,7 +182,7 @@ static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		ws16c48gpio->out_state[port] |= mask;
 	else
 		ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -178,13 +194,13 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	size_t index;
-	void __iomem *port_addr;
+	u8 __iomem *port_addr;
 	unsigned long bitmask;
 	unsigned long flags;
 
 	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
 		index = offset / 8;
-		port_addr = ws16c48gpio->base + index;
+		port_addr = ws16c48gpio->reg->port + index;
 
 		/* mask out GPIO configured for input */
 		gpio_mask &= ~ws16c48gpio->io_state[index];
@@ -219,10 +235,15 @@ static void ws16c48_irq_ack(struct irq_data *data)
 
 	port_state = ws16c48gpio->irq_mask >> (8*port);
 
-	iowrite8(0x80, ws16c48gpio->base + 7);
-	iowrite8(port_state & ~mask, ws16c48gpio->base + 8 + port);
-	iowrite8(port_state | mask, ws16c48gpio->base + 8 + port);
-	iowrite8(0xC0, ws16c48gpio->base + 7);
+	/* Select Register Page 2; Unlock all I/O ports */
+	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
+
+	/* Clear pending interrupt */
+	iowrite8(port_state & ~mask, ws16c48gpio->reg->pol_enab_int_id + port);
+	iowrite8(port_state | mask, ws16c48gpio->reg->pol_enab_int_id + port);
+
+	/* Select Register Page 3; Unlock all I/O ports */
+	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -235,6 +256,7 @@ static void ws16c48_irq_mask(struct irq_data *data)
 	const unsigned long mask = BIT(offset);
 	const unsigned port = offset / 8;
 	unsigned long flags;
+	unsigned long port_state;
 
 	/* only the first 3 ports support interrupts */
 	if (port > 2)
@@ -243,10 +265,16 @@ static void ws16c48_irq_mask(struct irq_data *data)
 	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
 	ws16c48gpio->irq_mask &= ~mask;
+	port_state = ws16c48gpio->irq_mask >> (8 * port);
+
+	/* Select Register Page 2; Unlock all I/O ports */
+	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
 
-	iowrite8(0x80, ws16c48gpio->base + 7);
-	iowrite8(ws16c48gpio->irq_mask >> (8*port), ws16c48gpio->base + 8 + port);
-	iowrite8(0xC0, ws16c48gpio->base + 7);
+	/* Disable interrupt */
+	iowrite8(port_state, ws16c48gpio->reg->pol_enab_int_id + port);
+
+	/* Select Register Page 3; Unlock all I/O ports */
+	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -259,6 +287,7 @@ static void ws16c48_irq_unmask(struct irq_data *data)
 	const unsigned long mask = BIT(offset);
 	const unsigned port = offset / 8;
 	unsigned long flags;
+	unsigned long port_state;
 
 	/* only the first 3 ports support interrupts */
 	if (port > 2)
@@ -267,10 +296,16 @@ static void ws16c48_irq_unmask(struct irq_data *data)
 	raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
 	ws16c48gpio->irq_mask |= mask;
+	port_state = ws16c48gpio->irq_mask >> (8 * port);
+
+	/* Select Register Page 2; Unlock all I/O ports */
+	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
 
-	iowrite8(0x80, ws16c48gpio->base + 7);
-	iowrite8(ws16c48gpio->irq_mask >> (8*port), ws16c48gpio->base + 8 + port);
-	iowrite8(0xC0, ws16c48gpio->base + 7);
+	/* Enable interrupt */
+	iowrite8(port_state, ws16c48gpio->reg->pol_enab_int_id + port);
+
+	/* Select Register Page 3; Unlock all I/O ports */
+	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -283,6 +318,7 @@ static int ws16c48_irq_set_type(struct irq_data *data, unsigned flow_type)
 	const unsigned long mask = BIT(offset);
 	const unsigned port = offset / 8;
 	unsigned long flags;
+	unsigned long port_state;
 
 	/* only the first 3 ports support interrupts */
 	if (port > 2)
@@ -304,9 +340,16 @@ static int ws16c48_irq_set_type(struct irq_data *data, unsigned flow_type)
 		return -EINVAL;
 	}
 
-	iowrite8(0x40, ws16c48gpio->base + 7);
-	iowrite8(ws16c48gpio->flow_mask >> (8*port), ws16c48gpio->base + 8 + port);
-	iowrite8(0xC0, ws16c48gpio->base + 7);
+	port_state = ws16c48gpio->flow_mask >> (8 * port);
+
+	/* Select Register Page 1; Unlock all I/O ports */
+	iowrite8(0x40, &ws16c48gpio->reg->page_lock);
+
+	/* Set interrupt polarity */
+	iowrite8(port_state, ws16c48gpio->reg->pol_enab_int_id + port);
+
+	/* Select Register Page 3; Unlock all I/O ports */
+	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -325,25 +368,26 @@ static irqreturn_t ws16c48_irq_handler(int irq, void *dev_id)
 {
 	struct ws16c48_gpio *const ws16c48gpio = dev_id;
 	struct gpio_chip *const chip = &ws16c48gpio->chip;
+	struct ws16c48_reg __iomem *const reg = ws16c48gpio->reg;
 	unsigned long int_pending;
 	unsigned long port;
 	unsigned long int_id;
 	unsigned long gpio;
 
-	int_pending = ioread8(ws16c48gpio->base + 6) & 0x7;
+	int_pending = ioread8(&reg->int_pending) & 0x7;
 	if (!int_pending)
 		return IRQ_NONE;
 
 	/* loop until all pending interrupts are handled */
 	do {
 		for_each_set_bit(port, &int_pending, 3) {
-			int_id = ioread8(ws16c48gpio->base + 8 + port);
+			int_id = ioread8(reg->pol_enab_int_id + port);
 			for_each_set_bit(gpio, &int_id, 8)
 				generic_handle_domain_irq(chip->irq.domain,
 							  gpio + 8*port);
 		}
 
-		int_pending = ioread8(ws16c48gpio->base + 6) & 0x7;
+		int_pending = ioread8(&reg->int_pending) & 0x7;
 	} while (int_pending);
 
 	return IRQ_HANDLED;
@@ -369,12 +413,16 @@ static int ws16c48_irq_init_hw(struct gpio_chip *gc)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(gc);
 
-	/* Disable IRQ by default */
-	iowrite8(0x80, ws16c48gpio->base + 7);
-	iowrite8(0, ws16c48gpio->base + 8);
-	iowrite8(0, ws16c48gpio->base + 9);
-	iowrite8(0, ws16c48gpio->base + 10);
-	iowrite8(0xC0, ws16c48gpio->base + 7);
+	/* Select Register Page 2; Unlock all I/O ports */
+	iowrite8(0x80, &ws16c48gpio->reg->page_lock);
+
+	/* Disable interrupts for all lines */
+	iowrite8(0, &ws16c48gpio->reg->pol_enab_int_id[0]);
+	iowrite8(0, &ws16c48gpio->reg->pol_enab_int_id[1]);
+	iowrite8(0, &ws16c48gpio->reg->pol_enab_int_id[2]);
+
+	/* Select Register Page 3; Unlock all I/O ports */
+	iowrite8(0xC0, &ws16c48gpio->reg->page_lock);
 
 	return 0;
 }
@@ -396,8 +444,8 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	ws16c48gpio->base = devm_ioport_map(dev, base[id], WS16C48_EXTENT);
-	if (!ws16c48gpio->base)
+	ws16c48gpio->reg = devm_ioport_map(dev, base[id], WS16C48_EXTENT);
+	if (!ws16c48gpio->reg)
 		return -ENOMEM;
 
 	ws16c48gpio->chip.label = name;
-- 
2.36.1

