Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2953E6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiFFOg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbiFFOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:36:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FF12C971
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:36:14 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id t22-20020a0568301e3600b0060b333f7a1eso10913074otr.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Y0M6xu1GLZK7ZGrwULwxb7+/2I3xvkk3luUj/TCV1w=;
        b=vKVh+3cn1sqO6NjItSr8bIrjy5N6mODxNhLm7BkT42S6ggxLyfV4rUVJbuCJKgG6ux
         10LO6VLEaEyKtgxi4xtzXcYwK/TtyzOYjPna7rCVZwSHpnRmIJXAenU0NYYGXMMENo5s
         Dy7oZb/r04kcnJuX9AlHFIeIMnuRi91XjS0uKmGSVrjsMo0HlwDJ37i5QoeowbHiSlT+
         i+Z3uHg4F/HnPfW8SaxX8Hrwy+yc3GQ4oZxHIni8HcDOfj+0FFzUJC0RabmTs/c8o47j
         ztZ/6l/4cpQILHRsNnMhtPtz36xuCuODcZKwaVhohY0c88cfj9/yuGhtxcDNtqo89k1n
         TzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Y0M6xu1GLZK7ZGrwULwxb7+/2I3xvkk3luUj/TCV1w=;
        b=MTkUiA1eTo5dqOi9NszQ0/IrHQIGvJsxqmGq6RrmDMh9COD6MP+jxAJUaJxA74TIPQ
         xakToiAgvOpp1gh5mziYAKIPSosYn3nCu0Khwiq7D/a7oEkcP2luCLxqmlDNkSmcrGsi
         0UZA7g//3l1dAj1LM7tmXQM/z4W4+tyD6GX25D3Q2AwjEg3cOCzmzQEtd2yj6ArAKHCr
         lIcbn/nxDa5+tt3PsZvcKZpeaufmZ69jLeKmxJ6TqhfjbfyEJZKJ+T+MrebPK+CiH6en
         ewk6MbQFruLUCqws7q8M63HhyZUJml7GS81w+BRpKqeUtkHnw/OimoxLXtwQdDIG8L5y
         LFyA==
X-Gm-Message-State: AOAM5315ECK3T7IZrdB5ptp79XwA1+BrdFMYYtbU/frgQw9pIsJSV+lA
        vkwBQhb45SUbbFkKJbVw02iu8Kfz8LahPA==
X-Google-Smtp-Source: ABdhPJw0Bv8CWzQuDCGPXI/7xIJd7fqqhe0U+v5fXafIjzmN+St0QQYWG4P8olpSVj+0p6AtjoHxKw==
X-Received: by 2002:a05:6830:54d:b0:606:a7d6:f809 with SMTP id l13-20020a056830054d00b00606a7d6f809mr10494401otb.139.1654526174292;
        Mon, 06 Jun 2022 07:36:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u13-20020a056871008d00b000f5d4e5b9a0sm6942791oaa.2.2022.06.06.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:36:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 5/5] gpio: ws16c48: Implement and utilize register structures
Date:   Mon,  6 Jun 2022 10:33:20 -0400
Message-Id: <2991a4f1db1f12be499124e0059be23535894dad.1654525394.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654525394.git.william.gray@linaro.org>
References: <cover.1654525394.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/gpio/gpio-ws16c48.c | 119 +++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 5078631d8014..663d4491b90f 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -17,8 +17,9 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
-#define WS16C48_EXTENT 16
+#define WS16C48_EXTENT 10
 #define MAX_NUM_WS16C48 max_num_isa_dev(WS16C48_EXTENT)
 
 static unsigned int base[MAX_NUM_WS16C48];
@@ -30,6 +31,20 @@ static unsigned int irq[MAX_NUM_WS16C48];
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
@@ -38,7 +53,7 @@ MODULE_PARM_DESC(irq, "WinSystems WS16C48 interrupt line numbers");
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	I/O bits affected by interrupts
  * @flow_mask:	IRQ flow type mask for the respective I/O bits
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  */
 struct ws16c48_gpio {
 	struct gpio_chip chip;
@@ -47,7 +62,7 @@ struct ws16c48_gpio {
 	raw_spinlock_t lock;
 	unsigned long irq_mask;
 	unsigned long flow_mask;
-	void __iomem *base;
+	struct ws16c48_reg __iomem *reg;
 };
 
 static int ws16c48_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -73,7 +88,7 @@ static int ws16c48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	ws16c48gpio->io_state[port] |= mask;
 	ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -95,7 +110,7 @@ static int ws16c48_gpio_direction_output(struct gpio_chip *chip,
 		ws16c48gpio->out_state[port] |= mask;
 	else
 		ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -118,7 +133,7 @@ static int ws16c48_gpio_get(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	port_state = ioread8(ws16c48gpio->base + port);
+	port_state = ioread8(ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -131,14 +146,16 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
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
@@ -166,7 +183,7 @@ static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		ws16c48gpio->out_state[port] |= mask;
 	else
 		ws16c48gpio->out_state[port] &= ~mask;
-	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->reg->port + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -178,13 +195,13 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
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
@@ -219,10 +236,15 @@ static void ws16c48_irq_ack(struct irq_data *data)
 
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
@@ -235,6 +257,7 @@ static void ws16c48_irq_mask(struct irq_data *data)
 	const unsigned long mask = BIT(offset);
 	const unsigned port = offset / 8;
 	unsigned long flags;
+	unsigned long port_state;
 
 	/* only the first 3 ports support interrupts */
 	if (port > 2)
@@ -243,10 +266,16 @@ static void ws16c48_irq_mask(struct irq_data *data)
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
@@ -259,6 +288,7 @@ static void ws16c48_irq_unmask(struct irq_data *data)
 	const unsigned long mask = BIT(offset);
 	const unsigned port = offset / 8;
 	unsigned long flags;
+	unsigned long port_state;
 
 	/* only the first 3 ports support interrupts */
 	if (port > 2)
@@ -267,10 +297,16 @@ static void ws16c48_irq_unmask(struct irq_data *data)
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
@@ -283,6 +319,7 @@ static int ws16c48_irq_set_type(struct irq_data *data, unsigned flow_type)
 	const unsigned long mask = BIT(offset);
 	const unsigned port = offset / 8;
 	unsigned long flags;
+	unsigned long port_state;
 
 	/* only the first 3 ports support interrupts */
 	if (port > 2)
@@ -304,9 +341,16 @@ static int ws16c48_irq_set_type(struct irq_data *data, unsigned flow_type)
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
 
@@ -325,25 +369,26 @@ static irqreturn_t ws16c48_irq_handler(int irq, void *dev_id)
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
@@ -369,12 +414,16 @@ static int ws16c48_irq_init_hw(struct gpio_chip *gc)
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
@@ -396,8 +445,8 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
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

