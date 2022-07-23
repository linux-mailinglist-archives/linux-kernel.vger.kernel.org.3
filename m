Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6057ED52
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiGWJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:50:08 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D187BED
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 02:50:06 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8471F2FF806;
        Sat, 23 Jul 2022 11:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658569802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E33Xxy+PobJdSqPgaU82YEs/7yYt9XPULOyc+ZcMM80=;
        b=bmF5lZnu56VYl/tCxKNr8l/upDuoVQyZk9xmlKSnOMcMgUZWI7i72NdX9Gq9t2fY8eLyVR
        CvKh4pvyRtdT++t/84OzRQfdFrHyOBdQxfOeMkUFbhJUpJTS4UoYlo6XeH2g88HDX4pWFV
        s/MyPhhHl9DUjfSxdO4XYytTVDY7K7JnkEpOmXwFt/0gpu1vJnbADvsIzVmiDFnJGW1IX8
        D/dL+A6dRy2P9RMokOHfNHpitjOrM2PJv048rLlEgMd8KRTAgvik5q8i5oW+AleLWoEKFK
        dEMnvJXxWRpC3XqbOFsnLZfw9A+pLmyO5Y/tBrv0iPb0SP6UaTeNQvo+fl/Upg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v1] gpio: realtek-otto: switch to 32-bit I/O
Date:   Sat, 23 Jul 2022 11:49:57 +0200
Message-Id: <20220723094957.73880-1-sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using 16-bit I/O on the GPIO peripheral, which is apparently not safe
on MIPS, the IMR can end up containing garbage. This then results in
interrupt triggers for lines that don't have an interrupt source
associated. The irq_desc lookup fails, and the ISR will not be cleared,
keeping the CPU busy until reboot, or until another IMR operation
restores the correct value. This situation appears to happen very
rarely, in < 0.5% of IMR writes.

Instead of using 8-bit or 16-bit I/O operations on the 32-bit memory
mapped peripheral registers, switch to using 32-bit I/O only. This
allows to put all the GPIO lines in-order for 8-bit port values. For
16-bit values, stick to manual (un)packing of per-port values.

Cc: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/gpio/gpio-realtek-otto.c | 122 ++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 49 deletions(-)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index 43b5c064dfeb..6a1d7ffd6d5d 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -48,6 +48,16 @@
  * @lock: Lock for accessing the IRQ registers and values
  * @intr_mask: Mask for interrupts lines
  * @intr_type: Interrupt type selection
+ * @read32: Read a 32-bit value
+ * @write32: Write a 32-bit value
+ * @port_write16: Write a 16-bit port value
+ *
+ * The DIR, DATA, and ISR registers consist of four u8 port values, packed into
+ * a single 32-bit register. Use @read32 (@write32) to get (assign) a value
+ * from (to) the correct bit offset inside that register. The IMR register
+ * consists of four u16 port values, packed into two 32-bit registers. Use
+ * @port_write16 to get the value from the correct offset, starting from the
+ * first register.
  *
  * Because the interrupt mask register (IMR) combines the function of IRQ type
  * selection and masking, two extra values are stored. @intr_mask is used to
@@ -63,8 +73,9 @@ struct realtek_gpio_ctrl {
 	raw_spinlock_t lock;
 	u16 intr_mask[REALTEK_GPIO_PORTS_PER_BANK];
 	u16 intr_type[REALTEK_GPIO_PORTS_PER_BANK];
-	unsigned int (*port_offset_u8)(unsigned int port);
-	unsigned int (*port_offset_u16)(unsigned int port);
+	u32 (*read32)(void __iomem *reg);
+	void (*write32)(void __iomem *reg, u32 value);
+	void (*port_write16)(void __iomem *reg, unsigned int port, u16 value);
 };
 
 /* Expand with more flags as devices with other quirks are added */
@@ -103,14 +114,25 @@ static struct realtek_gpio_ctrl *irq_data_to_ctrl(struct irq_data *data)
  * port. The two interrupt mask registers store two bits per GPIO, so use u16
  * values.
  */
-static unsigned int realtek_gpio_port_offset_u8(unsigned int port)
+static u32 realtek_gpio_read32be(void __iomem *reg)
 {
-	return port;
+	return ioread32be(reg);
 }
 
-static unsigned int realtek_gpio_port_offset_u16(unsigned int port)
+static void realtek_gpio_write32be(void __iomem *reg, u32 value)
 {
-	return 2 * port;
+	iowrite32be(value, reg);
+}
+
+static void realtek_gpio_port_write16be(void __iomem *reg, unsigned int port, u16 value)
+{
+	unsigned int shift = (port % 2) * 16;
+	u32 reg_val;
+
+	reg += 4 * (port / 2);
+	reg_val = ioread32be(reg) & ~(GENMASK(15, 0) << shift);
+	reg_val |= swab16(value) << shift;
+	iowrite32be(reg_val, reg);
 }
 
 /*
@@ -121,32 +143,42 @@ static unsigned int realtek_gpio_port_offset_u16(unsigned int port)
  * per GPIO, so use u16 values. The first register contains ports 1 and 0, the
  * second ports 3 and 2.
  */
-static unsigned int realtek_gpio_port_offset_u8_rev(unsigned int port)
+static u32 realtek_gpio_read32(void __iomem *reg)
 {
-	return 3 - port;
+	return ioread32(reg);
 }
 
-static unsigned int realtek_gpio_port_offset_u16_rev(unsigned int port)
+static void realtek_gpio_write32(void __iomem *reg, u32 value)
 {
-	return 2 * (port ^ 1);
+	iowrite32(value, reg);
+}
+
+static void realtek_gpio_port_write16(void __iomem *reg, unsigned int port, u16 value)
+{
+	unsigned int shift = (port % 2) * 16;
+	u32 reg_val;
+
+	reg += 4 * (port / 2);
+	reg_val = ioread32(reg) & ~(GENMASK(15, 0) << shift);
+	reg_val |= value << shift;
+	iowrite32(reg_val, reg);
 }
 
+
 static void realtek_gpio_write_imr(struct realtek_gpio_ctrl *ctrl,
 	unsigned int port, u16 irq_type, u16 irq_mask)
 {
-	iowrite16(irq_type & irq_mask,
-		ctrl->base + REALTEK_GPIO_REG_IMR + ctrl->port_offset_u16(port));
+	ctrl->port_write16(ctrl->base + REALTEK_GPIO_REG_IMR, port, irq_type & irq_mask);
 }
 
-static void realtek_gpio_clear_isr(struct realtek_gpio_ctrl *ctrl,
-	unsigned int port, u8 mask)
+static void realtek_gpio_clear_isr(struct realtek_gpio_ctrl *ctrl, u32 mask)
 {
-	iowrite8(mask, ctrl->base + REALTEK_GPIO_REG_ISR + ctrl->port_offset_u8(port));
+	ctrl->write32(ctrl->base + REALTEK_GPIO_REG_ISR, mask);
 }
 
-static u8 realtek_gpio_read_isr(struct realtek_gpio_ctrl *ctrl, unsigned int port)
+static u32 realtek_gpio_read_isr(struct realtek_gpio_ctrl *ctrl)
 {
-	return ioread8(ctrl->base + REALTEK_GPIO_REG_ISR + ctrl->port_offset_u8(port));
+	return ctrl->read32(ctrl->base + REALTEK_GPIO_REG_ISR);
 }
 
 /* Set the rising and falling edge mask bits for a GPIO port pin */
@@ -159,10 +191,8 @@ static void realtek_gpio_irq_ack(struct irq_data *data)
 {
 	struct realtek_gpio_ctrl *ctrl = irq_data_to_ctrl(data);
 	irq_hw_number_t line = irqd_to_hwirq(data);
-	unsigned int port = line / 8;
-	unsigned int port_pin = line % 8;
 
-	realtek_gpio_clear_isr(ctrl, port, BIT(port_pin));
+	realtek_gpio_clear_isr(ctrl, BIT(line));
 }
 
 static void realtek_gpio_irq_unmask(struct irq_data *data)
@@ -244,28 +274,21 @@ static void realtek_gpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct realtek_gpio_ctrl *ctrl = gpiochip_get_data(gc);
 	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
-	unsigned int lines_done;
-	unsigned int port_pin_count;
 	unsigned long status;
 	int offset;
 
 	chained_irq_enter(irq_chip, desc);
 
-	for (lines_done = 0; lines_done < gc->ngpio; lines_done += 8) {
-		status = realtek_gpio_read_isr(ctrl, lines_done / 8);
-		port_pin_count = min(gc->ngpio - lines_done, 8U);
-		for_each_set_bit(offset, &status, port_pin_count)
-			generic_handle_domain_irq(gc->irq.domain, offset + lines_done);
-	}
+	status = realtek_gpio_read_isr(ctrl);
+	for_each_set_bit(offset, &status, gc->ngpio)
+		generic_handle_domain_irq(gc->irq.domain, offset);
 
 	chained_irq_exit(irq_chip, desc);
 }
 
-static inline void __iomem *realtek_gpio_irq_cpu_mask(struct realtek_gpio_ctrl *ctrl,
-	unsigned int port, int cpu)
+static inline void __iomem *realtek_gpio_irq_cpu_mask(struct realtek_gpio_ctrl *ctrl, int cpu)
 {
-	return ctrl->cpumask_base + ctrl->port_offset_u8(port) +
-		REALTEK_GPIO_PORTS_PER_BANK * cpu;
+	return ctrl->cpumask_base + REALTEK_GPIO_PORTS_PER_BANK * cpu;
 }
 
 static int realtek_gpio_irq_set_affinity(struct irq_data *data,
@@ -273,12 +296,10 @@ static int realtek_gpio_irq_set_affinity(struct irq_data *data,
 {
 	struct realtek_gpio_ctrl *ctrl = irq_data_to_ctrl(data);
 	unsigned int line = irqd_to_hwirq(data);
-	unsigned int port = line / 8;
-	unsigned int port_pin = line % 8;
 	void __iomem *irq_cpu_mask;
 	unsigned long flags;
 	int cpu;
-	u8 v;
+	u32 v;
 
 	if (!ctrl->cpumask_base)
 		return -ENXIO;
@@ -286,15 +307,15 @@ static int realtek_gpio_irq_set_affinity(struct irq_data *data,
 	raw_spin_lock_irqsave(&ctrl->lock, flags);
 
 	for_each_cpu(cpu, &ctrl->cpu_irq_maskable) {
-		irq_cpu_mask = realtek_gpio_irq_cpu_mask(ctrl, port, cpu);
-		v = ioread8(irq_cpu_mask);
+		irq_cpu_mask = realtek_gpio_irq_cpu_mask(ctrl, cpu);
+		v = ctrl->read32(irq_cpu_mask);
 
 		if (cpumask_test_cpu(cpu, dest))
-			v |= BIT(port_pin);
+			v |= BIT(line);
 		else
-			v &= ~BIT(port_pin);
+			v &= ~BIT(line);
 
-		iowrite8(v, irq_cpu_mask);
+		ctrl->write32(irq_cpu_mask, v);
 	}
 
 	raw_spin_unlock_irqrestore(&ctrl->lock, flags);
@@ -307,16 +328,17 @@ static int realtek_gpio_irq_set_affinity(struct irq_data *data,
 static int realtek_gpio_irq_init(struct gpio_chip *gc)
 {
 	struct realtek_gpio_ctrl *ctrl = gpiochip_get_data(gc);
+	u32 mask_all = GENMASK(gc->ngpio, 0);
 	unsigned int port;
 	int cpu;
 
-	for (port = 0; (port * 8) < gc->ngpio; port++) {
+	for (port = 0; (port * 8) < gc->ngpio; port++)
 		realtek_gpio_write_imr(ctrl, port, 0, 0);
-		realtek_gpio_clear_isr(ctrl, port, GENMASK(7, 0));
 
-		for_each_cpu(cpu, &ctrl->cpu_irq_maskable)
-			iowrite8(GENMASK(7, 0), realtek_gpio_irq_cpu_mask(ctrl, port, cpu));
-	}
+	realtek_gpio_clear_isr(ctrl, mask_all);
+
+	for_each_cpu(cpu, &ctrl->cpu_irq_maskable)
+		ctrl->write32(realtek_gpio_irq_cpu_mask(ctrl, cpu), mask_all);
 
 	return 0;
 }
@@ -389,12 +411,14 @@ static int realtek_gpio_probe(struct platform_device *pdev)
 
 	if (dev_flags & GPIO_PORTS_REVERSED) {
 		bgpio_flags = 0;
-		ctrl->port_offset_u8 = realtek_gpio_port_offset_u8_rev;
-		ctrl->port_offset_u16 = realtek_gpio_port_offset_u16_rev;
+		ctrl->read32 = realtek_gpio_read32;
+		ctrl->write32 = realtek_gpio_write32;
+		ctrl->port_write16 = realtek_gpio_port_write16;
 	} else {
 		bgpio_flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER;
-		ctrl->port_offset_u8 = realtek_gpio_port_offset_u8;
-		ctrl->port_offset_u16 = realtek_gpio_port_offset_u16;
+		ctrl->read32 = realtek_gpio_read32be;
+		ctrl->write32 = realtek_gpio_write32be;
+		ctrl->port_write16 = realtek_gpio_port_write16be;
 	}
 
 	err = bgpio_init(&ctrl->gc, dev, 4,
-- 
2.36.1

