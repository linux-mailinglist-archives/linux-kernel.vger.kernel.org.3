Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9C5AFE41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIGH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIGH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:59:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2BA927F;
        Wed,  7 Sep 2022 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662537559; x=1694073559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ElCbft8MgkbPL9x7AuoOschyBkoLeKrrG0xc2X+djpY=;
  b=dECBhZMvqQu+RAVBp3xKO075+csSnJnu26mu233+uBmdpbNBSKMyFk2+
   x16ot8jGc8i3H7JvG03KJDEK7s9xUQak9yV3X9pnQ2JMIwm4nwlnm1j2l
   nv9wK6CHMuoXQZ5qj4CtMn+dKo11WE3jInTPq00XIlmPnXFBuFW1l4xuL
   layuNTlMs3yk5WBKmhzWBKokSnTCJEoLjG7/ydN3G6UyV7BiHaLPYsxdB
   62zvUn7zgA1LSw5pFdi8RkJ1hxz0jNM3fxN/C0W7QqnaTgxyfb/gawEnr
   RDEbAOLQoB5+cof2J6Hb+IM/smfG8p3H484NZf3QvEYmf4Hnc9xp1jXHv
   w==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="175969835"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 00:59:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 00:59:15 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 00:59:14 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2] pinctrl: ocelot: Fix interrupt controller
Date:   Wed, 7 Sep 2022 10:02:51 +0200
Message-ID: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an external device generated a level based interrupt then the
interrupt controller could miss the interrupt. The reason is that the
interrupt controller can detect only link changes.

In the following example, if there is a PHY that generates an interrupt
then the following would happen. The GPIO detected that the interrupt
line changed, and then the 'ocelot_irq_handler' will be called. Here it
detects which GPIO line seen the change and for that will call the
following:
1. irq_mask
2. phy interrupt routine
3. irq_eoi
4. irq_unmask

And this works fine for simple cases, but if the PHY generates many
interrupts, for example when doing PTP timestamping, then the following
could happen. Again the function 'ocelot_irq_handler' will be called
and then from here the following could happen:
1. irq_mask
2. phy interrupt routine
3. irq_eoi
4. irq_unmask

Right before step 3(irq_eoi), the PHY will generate another interrupt.
Now the interrupt controller will acknowledge the change in the
interrupt line. So we miss the interrupt.

A solution will be to use 'handle_level_irq' instead of
'handle_fasteoi_irq', because for this will change routine order of
handling the interrupt.
1. irq_mask
2. irq_ack
3. phy interrupt routine
4. irq_unmask

And now if the PHY will generate a new interrupt before irq_unmask, the
interrupt controller will detect this because it already acknowledge the
change in interrupt line at step 2(irq_ack).

But this is not the full solution because there is another issue. In
case there are 2 PHYs that share the interrupt line. For example phy1
generates an interrupt, then the following can happen:
1.irq_mask
2.irq_ack
3.phy0 interrupt routine
4.phy1 interrupt routine
5.irq_unmask

In case phy0 will generate an interrupt while clearing the interrupt
source in phy1, then the interrupt line will be kept down by phy0. So
the interrupt controller will not see any changes in the interrupt line.
The solution here is to update 'irq_unmask' such that it can detect if
the interrupt line is still active or not. And if it is active then call
again the procedure to clear the interrupts. But we don't want to do it
every time, only if we know that the interrupt controller have not seen
already that the interrupt line has changed.

While at this, add support also for IRQ_TYPE_LEVEL_LOW.

Fixes: be36abb71d878f ("pinctrl: ocelot: add support for interrupt controller")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v1->v2:
- fix grammer mistakes
- remove redundant checks for type in ocelot_irq_set_type
- split assignment and declaration of work variable
- use irqd_get_trigger_type instead of getting trigger from action
---
 drivers/pinctrl/pinctrl-ocelot.c | 93 +++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index c5fd154990c8..29887d55c93b 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -338,6 +338,11 @@ struct ocelot_match_data {
 	struct ocelot_pincfg_data pincfg_data;
 };
 
+struct ocelot_irq_work {
+	struct work_struct irq_work;
+	struct irq_desc *irq_desc;
+};
+
 #define LUTON_P(p, f0, f1)						\
 static struct ocelot_pin_caps luton_pin_##p = {				\
 	.pin = p,							\
@@ -1813,6 +1818,74 @@ static void ocelot_irq_mask(struct irq_data *data)
 	gpiochip_disable_irq(chip, gpio);
 }
 
+static void ocelot_irq_work(struct work_struct *work)
+{
+	struct ocelot_irq_work *w = container_of(work, struct ocelot_irq_work, irq_work);
+	struct irq_chip *parent_chip = irq_desc_get_chip(w->irq_desc);
+	struct gpio_chip *chip = irq_desc_get_chip_data(w->irq_desc);
+	struct irq_data *data = irq_desc_get_irq_data(w->irq_desc);
+	unsigned int gpio = irqd_to_hwirq(data);
+
+	local_irq_disable();
+	chained_irq_enter(parent_chip, w->irq_desc);
+	generic_handle_domain_irq(chip->irq.domain, gpio);
+	chained_irq_exit(parent_chip, w->irq_desc);
+	local_irq_enable();
+
+	kfree(w);
+}
+
+static void ocelot_irq_unmask_level(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	struct irq_desc *desc = irq_data_to_desc(data);
+	unsigned int gpio = irqd_to_hwirq(data);
+	bool ack = false, active = false;
+	u8 trigger_level;
+	int val;
+
+	trigger_level = irqd_get_trigger_type(data);
+
+	/* Check if the interrupt line is still active. */
+	regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
+	if ((!(val & BIT(gpio % 32)) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
+	      (val & BIT(gpio % 32) && trigger_level == IRQ_TYPE_LEVEL_HIGH))
+		active = true;
+
+	/*
+	 * Check if the interrupt controller has seen any changes in the
+	 * interrupt line.
+	 */
+	regmap_read(info->map, REG(OCELOT_GPIO_INTR, info, gpio), &val);
+	if (val & BIT(gpio % 32))
+		ack = true;
+
+	/* Enable the interrupt now */
+	gpiochip_enable_irq(chip, gpio);
+	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
+			   BIT(gpio % 32), BIT(gpio % 32));
+
+	/*
+	 * In case the interrupt line is still active and the interrupt
+	 * controller has not seen any changes in the interrupt line, then it
+	 * means that there happen another interrupt while the line was active.
+	 * So we missed that one, so we need to kick again the interrupt
+	 * handler.
+	 */
+	if (active && !ack) {
+		struct ocelot_irq_work *work;
+
+		work = kmalloc(sizeof(*work), GFP_ATOMIC);
+		if (!work)
+			return;
+
+		work->irq_desc = desc;
+		INIT_WORK(&work->irq_work, ocelot_irq_work);
+		queue_work(system_wq, &work->irq_work);
+	}
+}
+
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
@@ -1836,13 +1909,12 @@ static void ocelot_irq_ack(struct irq_data *data)
 
 static int ocelot_irq_set_type(struct irq_data *data, unsigned int type);
 
-static struct irq_chip ocelot_eoi_irqchip = {
+static struct irq_chip ocelot_level_irqchip = {
 	.name		= "gpio",
 	.irq_mask	= ocelot_irq_mask,
-	.irq_eoi	= ocelot_irq_ack,
-	.irq_unmask	= ocelot_irq_unmask,
-	.flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
-			  IRQCHIP_IMMUTABLE,
+	.irq_ack	= ocelot_irq_ack,
+	.irq_unmask	= ocelot_irq_unmask_level,
+	.flags		= IRQCHIP_IMMUTABLE,
 	.irq_set_type	= ocelot_irq_set_type,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS
 };
@@ -1859,14 +1931,9 @@ static struct irq_chip ocelot_irqchip = {
 
 static int ocelot_irq_set_type(struct irq_data *data, unsigned int type)
 {
-	type &= IRQ_TYPE_SENSE_MASK;
-
-	if (!(type & (IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH)))
-		return -EINVAL;
-
-	if (type & IRQ_TYPE_LEVEL_HIGH)
-		irq_set_chip_handler_name_locked(data, &ocelot_eoi_irqchip,
-						 handle_fasteoi_irq, NULL);
+	if (type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		irq_set_chip_handler_name_locked(data, &ocelot_level_irqchip,
+						 handle_level_irq, NULL);
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_chip_handler_name_locked(data, &ocelot_irqchip,
 						 handle_edge_irq, NULL);
-- 
2.33.0

