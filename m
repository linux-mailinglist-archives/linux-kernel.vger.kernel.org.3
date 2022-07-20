Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3557B7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiGTNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiGTNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:46:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DF3ED6E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:46:12 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g1so12853756qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJqWp+udTO0Z1cqQdPtymTtYII3QhZ3OpR+pl1jwWrE=;
        b=bbkc1RXc6gPBCpZhVQ6mD/NVoSvR8+fFUv6HFpiDG8dO7L4hclWPKP3n84Im5t+6CM
         oQ5FvRG94yRKWdutX8kds0Jg4FvU9DrrHW4Ldv8xO1C9tnMTdBjyriUvcs4hx3KazRe2
         B0YLgXyWG649Iw2STVv3IWDcl7YaBaJPCki6VTjscc8HC3GseTCiqlN8DjbIKaaiD3or
         zCB+c2d/u9aNJ7OGokjhukxpScTenaIKzAO7KTlznXcOD+dabR6pu14J1/bHDD9+87CP
         sUVy0tHiumqnjCvJj83pp1XDacskS+LPuDhy7f9THGyZUY/b/sQRu+CQ/cLgLt7/pfwV
         VaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJqWp+udTO0Z1cqQdPtymTtYII3QhZ3OpR+pl1jwWrE=;
        b=6rebbwa6JF9dhb52Mw24fGvGVyo1hByuQ6pGhly7rkSR7dNLeCztkgXSZp0CKMgyOG
         XVctJQGzSuPC4Ef2LM7yglzsB8wa2qxQeVPT17wrq0Qom7NjCsxn8qTwISfgPjlwDJTE
         Bzfh721bvKscq/1953bfOu84c+5/rMURiJw1qpWDRWLfPYbI+UtjJyLMAR3rBgkbd406
         MoJSgT2Ppt5HqnNkVlN8lBaDnDY8agypWo5ZqoP7mnfZCwciPSYXS20O8uL2UYVcZ4z1
         uTSizONcd7etczncCvmBdk/x2Gei5JCAo06rC/9F5o3vYmGoqCysuuwbX+dd+igkIc6c
         JVHg==
X-Gm-Message-State: AJIora+CpllqmWmIAv72OjoLdw1l0rnxnXH8xdhDRavPdUywRNjPdyAJ
        UHl+TA1WA6AB9C42dsXcRfahxM/0aIU9Cw==
X-Google-Smtp-Source: AGRyM1tFtjEsMsxt0GIZyXaf6U4f8oBGFTzUmzn8GD1h3YpTJRUzBrhh9kEjPgKuw3aqBSzoJ+f6JQ==
X-Received: by 2002:a05:620a:1ed:b0:6b5:51ef:a01b with SMTP id x13-20020a05620a01ed00b006b551efa01bmr24654360qkn.672.1658324771184;
        Wed, 20 Jul 2022 06:46:11 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bl13-20020a05620a1a8d00b006b5f8f32a8fsm5289853qkb.114.2022.07.20.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:46:10 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: [RESEND PATCH v4 1/6] gpio: ws16c48: Implement and utilize register structures
Date:   Wed, 20 Jul 2022 09:45:57 -0400
Message-Id: <1e78f806244495a6996c803af9452745bf6da1dd.1658324498.git.william.gray@linaro.org>
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

