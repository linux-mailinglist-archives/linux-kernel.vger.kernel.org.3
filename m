Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85E4660E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356773AbhLBJ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:57:06 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33049 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356742AbhLBJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:36 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id 8E5CF240003;
        Thu,  2 Dec 2021 09:53:10 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/6] pinctrl: spear: plgpio: Convert to regmap
Date:   Thu,  2 Dec 2021 10:52:51 +0100
Message-Id: <20211202095255.165797-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources need to be shared between pinmux and plgpio.

Use regmap (syscon) to access resources to allow an
easy way to share resources.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pinctrl/spear/pinctrl-plgpio.c | 136 ++++++++++++++-----------
 1 file changed, 76 insertions(+), 60 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 43bb334af1e1..28538ac99eed 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -14,11 +14,13 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 
 #define MAX_GPIO_PER_REG		32
@@ -64,7 +66,7 @@ struct plgpio_regs {
  */
 struct plgpio {
 	spinlock_t		lock;
-	void __iomem		*base;
+	struct regmap		*regmap;
 	struct clk		*clk;
 	struct gpio_chip	chip;
 	int			(*p2o)(int pin);	/* pin_to_offset */
@@ -77,33 +79,38 @@ struct plgpio {
 };
 
 /* register manipulation inline functions */
-static inline u32 is_plgpio_set(void __iomem *base, u32 pin, u32 reg)
+static inline u32 is_plgpio_set(struct regmap *regmap, u32 pin, u32 reg)
 {
 	u32 offset = PIN_OFFSET(pin);
-	void __iomem *reg_off = REG_OFFSET(base, reg, pin);
-	u32 val = readl_relaxed(reg_off);
+	u32 reg_off = REG_OFFSET(0, reg, pin);
+	u32 val;
+
+	regmap_read(regmap, reg_off, &val);
 
 	return !!(val & (1 << offset));
 }
 
-static inline void plgpio_reg_set(void __iomem *base, u32 pin, u32 reg)
+static inline void plgpio_reg_set(struct regmap *regmap, u32 pin, u32 reg)
 {
 	u32 offset = PIN_OFFSET(pin);
-	void __iomem *reg_off = REG_OFFSET(base, reg, pin);
-	u32 val = readl_relaxed(reg_off);
+	u32 reg_off = REG_OFFSET(0, reg, pin);
+	u32 mask;
 
-	writel_relaxed(val | (1 << offset), reg_off);
+	mask = 1 << offset;
+	regmap_update_bits(regmap, reg_off, mask, mask);
 }
 
-static inline void plgpio_reg_reset(void __iomem *base, u32 pin, u32 reg)
+static inline void plgpio_reg_reset(struct regmap *regmap, u32 pin, u32 reg)
 {
 	u32 offset = PIN_OFFSET(pin);
-	void __iomem *reg_off = REG_OFFSET(base, reg, pin);
-	u32 val = readl_relaxed(reg_off);
+	u32 reg_off = REG_OFFSET(0, reg, pin);
+	u32 mask;
 
-	writel_relaxed(val & ~(1 << offset), reg_off);
+	mask = 1 << offset;
+	regmap_update_bits(regmap, reg_off, mask, 0);
 }
 
+
 /* gpio framework specific routines */
 static int plgpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
@@ -118,7 +125,7 @@ static int plgpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_set(plgpio->base, offset, plgpio->regs.dir);
+	plgpio_reg_set(plgpio->regmap, offset, plgpio->regs.dir);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 
 	return 0;
@@ -145,13 +152,13 @@ static int plgpio_direction_output(struct gpio_chip *chip, unsigned offset,
 
 	spin_lock_irqsave(&plgpio->lock, flags);
 	if (value)
-		plgpio_reg_set(plgpio->base, wdata_offset,
+		plgpio_reg_set(plgpio->regmap, wdata_offset,
 				plgpio->regs.wdata);
 	else
-		plgpio_reg_reset(plgpio->base, wdata_offset,
+		plgpio_reg_reset(plgpio->regmap, wdata_offset,
 				plgpio->regs.wdata);
 
-	plgpio_reg_reset(plgpio->base, dir_offset, plgpio->regs.dir);
+	plgpio_reg_reset(plgpio->regmap, dir_offset, plgpio->regs.dir);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 
 	return 0;
@@ -171,7 +178,7 @@ static int plgpio_get_value(struct gpio_chip *chip, unsigned offset)
 			return -EINVAL;
 	}
 
-	return is_plgpio_set(plgpio->base, offset, plgpio->regs.rdata);
+	return is_plgpio_set(plgpio->regmap, offset, plgpio->regs.rdata);
 }
 
 static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
@@ -189,9 +196,9 @@ static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
 	}
 
 	if (value)
-		plgpio_reg_set(plgpio->base, offset, plgpio->regs.wdata);
+		plgpio_reg_set(plgpio->regmap, offset, plgpio->regs.wdata);
 	else
-		plgpio_reg_reset(plgpio->base, offset, plgpio->regs.wdata);
+		plgpio_reg_reset(plgpio->regmap, offset, plgpio->regs.wdata);
 }
 
 static int plgpio_request(struct gpio_chip *chip, unsigned offset)
@@ -234,7 +241,7 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_set(plgpio->base, offset, plgpio->regs.enb);
+	plgpio_reg_set(plgpio->regmap, offset, plgpio->regs.enb);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 	return 0;
 
@@ -266,7 +273,7 @@ static void plgpio_free(struct gpio_chip *chip, unsigned offset)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_reset(plgpio->base, offset, plgpio->regs.enb);
+	plgpio_reg_reset(plgpio->regmap, offset, plgpio->regs.enb);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 
 disable_clk:
@@ -292,7 +299,7 @@ static void plgpio_irq_disable(struct irq_data *d)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_set(plgpio->base, offset, plgpio->regs.ie);
+	plgpio_reg_set(plgpio->regmap, offset, plgpio->regs.ie);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 }
 
@@ -311,7 +318,7 @@ static void plgpio_irq_enable(struct irq_data *d)
 	}
 
 	spin_lock_irqsave(&plgpio->lock, flags);
-	plgpio_reg_reset(plgpio->base, offset, plgpio->regs.ie);
+	plgpio_reg_reset(plgpio->regmap, offset, plgpio->regs.ie);
 	spin_unlock_irqrestore(&plgpio->lock, flags);
 }
 
@@ -320,7 +327,7 @@ static int plgpio_irq_set_type(struct irq_data *d, unsigned trigger)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct plgpio *plgpio = gpiochip_get_data(gc);
 	int offset = d->hwirq;
-	void __iomem *reg_off;
+	u32 reg_off;
 	unsigned int supported_type = 0, val;
 
 	if (offset >= plgpio->chip.ngpio)
@@ -337,14 +344,14 @@ static int plgpio_irq_set_type(struct irq_data *d, unsigned trigger)
 	if (plgpio->regs.eit == -1)
 		return 0;
 
-	reg_off = REG_OFFSET(plgpio->base, plgpio->regs.eit, offset);
-	val = readl_relaxed(reg_off);
+	reg_off = REG_OFFSET(0, plgpio->regs.eit, offset);
+	regmap_read(plgpio->regmap, reg_off, &val);
 
 	offset = PIN_OFFSET(offset);
 	if (trigger & IRQ_TYPE_EDGE_RISING)
-		writel_relaxed(val | (1 << offset), reg_off);
+		regmap_write(plgpio->regmap, reg_off, val | (1 << offset));
 	else
-		writel_relaxed(val & ~(1 << offset), reg_off);
+		regmap_write(plgpio->regmap, reg_off, val & ~(1 << offset));
 
 	return 0;
 }
@@ -362,7 +369,8 @@ static void plgpio_irq_handler(struct irq_desc *desc)
 	struct plgpio *plgpio = gpiochip_get_data(gc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	int regs_count, count, pin, offset, i = 0;
-	unsigned long pending;
+	u32 pending;
+	unsigned long pendingl;
 
 	count = plgpio->chip.ngpio;
 	regs_count = DIV_ROUND_UP(count, MAX_GPIO_PER_REG);
@@ -370,14 +378,14 @@ static void plgpio_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(irqchip, desc);
 	/* check all plgpio MIS registers for a possible interrupt */
 	for (; i < regs_count; i++) {
-		pending = readl_relaxed(plgpio->base + plgpio->regs.mis +
-				i * sizeof(int *));
+		regmap_read(plgpio->regmap, plgpio->regs.mis +
+			i * sizeof(int *), &pending);
 		if (!pending)
 			continue;
 
 		/* clear interrupts */
-		writel_relaxed(~pending, plgpio->base + plgpio->regs.mis +
-				i * sizeof(int *));
+		regmap_write(plgpio->regmap, plgpio->regs.mis +
+			i * sizeof(int *), ~pending);
 		/*
 		 * clear extra bits in last register having gpios < MAX/REG
 		 * ex: Suppose there are max 102 plgpios. then last register
@@ -389,7 +397,8 @@ static void plgpio_irq_handler(struct irq_desc *desc)
 		if (count < MAX_GPIO_PER_REG)
 			pending &= (1 << count) - 1;
 
-		for_each_set_bit(offset, &pending, MAX_GPIO_PER_REG) {
+		pendingl = pending;
+		for_each_set_bit(offset, &pendingl, MAX_GPIO_PER_REG) {
 			/* get correct pin for "offset" */
 			if (plgpio->o2p && (plgpio->p2o_regs & PTO_MIS_REG)) {
 				pin = plgpio->o2p(offset);
@@ -511,6 +520,7 @@ static int plgpio_probe_dt(struct platform_device *pdev, struct plgpio *plgpio)
 end:
 	return ret;
 }
+
 static int plgpio_probe(struct platform_device *pdev)
 {
 	struct plgpio *plgpio;
@@ -520,9 +530,12 @@ static int plgpio_probe(struct platform_device *pdev)
 	if (!plgpio)
 		return -ENOMEM;
 
-	plgpio->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(plgpio->base))
-		return PTR_ERR(plgpio->base);
+	plgpio->regmap = device_node_to_regmap(pdev->dev.of_node);
+	if (IS_ERR(plgpio->regmap)) {
+		dev_err(&pdev->dev, "Init regmap failed (%pe)\n",
+			plgpio->regmap);
+		return PTR_ERR(plgpio->regmap);
+	}
 
 	ret = plgpio_probe_dt(pdev, plgpio);
 	if (ret) {
@@ -607,22 +620,23 @@ static int plgpio_suspend(struct device *dev)
 {
 	struct plgpio *plgpio = dev_get_drvdata(dev);
 	int i, reg_count = DIV_ROUND_UP(plgpio->chip.ngpio, MAX_GPIO_PER_REG);
-	void __iomem *off;
+	u32 off;
 
 	for (i = 0; i < reg_count; i++) {
-		off = plgpio->base + i * sizeof(int *);
+		off = i * sizeof(int *);
 
 		if (plgpio->regs.enb != -1)
-			plgpio->csave_regs[i].enb =
-				readl_relaxed(plgpio->regs.enb + off);
+			regmap_read(plgpio->regmap, plgpio->regs.enb + off,
+				&plgpio->csave_regs[i].enb);
 		if (plgpio->regs.eit != -1)
-			plgpio->csave_regs[i].eit =
-				readl_relaxed(plgpio->regs.eit + off);
-		plgpio->csave_regs[i].wdata = readl_relaxed(plgpio->regs.wdata +
-				off);
-		plgpio->csave_regs[i].dir = readl_relaxed(plgpio->regs.dir +
-				off);
-		plgpio->csave_regs[i].ie = readl_relaxed(plgpio->regs.ie + off);
+			regmap_read(plgpio->regmap, plgpio->regs.eit + off,
+				&plgpio->csave_regs[i].eit);
+		regmap_read(plgpio->regmap, plgpio->regs.wdata + off,
+				&plgpio->csave_regs[i].wdata);
+		regmap_read(plgpio->regmap, plgpio->regs.dir + off,
+				&plgpio->csave_regs[i].dir);
+		regmap_read(plgpio->regmap, plgpio->regs.ie + off,
+				&plgpio->csave_regs[i].ie);
 	}
 
 	return 0;
@@ -636,7 +650,7 @@ static int plgpio_suspend(struct device *dev)
  */
 #define plgpio_prepare_reg(__reg, _off, _mask, _tmp)		\
 {								\
-	_tmp = readl_relaxed(plgpio->regs.__reg + _off);		\
+	regmap_read(plgpio->regmap, plgpio->regs.__reg + _off, &_tmp); \
 	_tmp &= ~_mask;						\
 	plgpio->csave_regs[i].__reg =				\
 		_tmp | (plgpio->csave_regs[i].__reg & _mask);	\
@@ -646,11 +660,11 @@ static int plgpio_resume(struct device *dev)
 {
 	struct plgpio *plgpio = dev_get_drvdata(dev);
 	int i, reg_count = DIV_ROUND_UP(plgpio->chip.ngpio, MAX_GPIO_PER_REG);
-	void __iomem *off;
+	u32 off;
 	u32 mask, tmp;
 
 	for (i = 0; i < reg_count; i++) {
-		off = plgpio->base + i * sizeof(int *);
+		off = i * sizeof(int *);
 
 		if (i == reg_count - 1) {
 			mask = (1 << (plgpio->chip.ngpio - i *
@@ -667,20 +681,22 @@ static int plgpio_resume(struct device *dev)
 			plgpio_prepare_reg(ie, off, mask, tmp);
 		}
 
-		writel_relaxed(plgpio->csave_regs[i].wdata, plgpio->regs.wdata +
-				off);
-		writel_relaxed(plgpio->csave_regs[i].dir, plgpio->regs.dir +
-				off);
+		regmap_write(plgpio->regmap, plgpio->regs.wdata + off,
+			plgpio->csave_regs[i].wdata);
+
+		regmap_write(plgpio->regmap, plgpio->regs.dir + off,
+			plgpio->csave_regs[i].dir);
 
 		if (plgpio->regs.eit != -1)
-			writel_relaxed(plgpio->csave_regs[i].eit,
-					plgpio->regs.eit + off);
+			regmap_write(plgpio->regmap, plgpio->regs.eit + off,
+				plgpio->csave_regs[i].eit);
 
-		writel_relaxed(plgpio->csave_regs[i].ie, plgpio->regs.ie + off);
+		regmap_write(plgpio->regmap, plgpio->regs.ie + off,
+			plgpio->csave_regs[i].ie);
 
 		if (plgpio->regs.enb != -1)
-			writel_relaxed(plgpio->csave_regs[i].enb,
-					plgpio->regs.enb + off);
+			regmap_write(plgpio->regmap, plgpio->regs.enb + off,
+				plgpio->csave_regs[i].enb);
 	}
 
 	return 0;
-- 
2.31.1

