Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1E4C3E36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiBYGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiBYGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:08:02 -0500
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E816939B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:07:25 -0800 (PST)
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 25 Feb 2022
 13:52:10 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: [PATCH v3 4/4] irqchip/meson-gpio: Add support for meson s4 SoCs
Date:   Fri, 25 Feb 2022 13:52:06 +0800
Message-ID: <20220225055207.1048-5-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225055207.1048-1-qianggui.song@amlogic.com>
References: <20220225055207.1048-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson s4 SoCs support 12 gpio irq lines compared with previous
serial chips and have something different, details are as below.

IRQ Number:
- 80:68 13 pins on bank Z
- 67:48 20 pins on bank X
- 47:36 12 pins on bank H
- 35:24 12 pins on bank D
- 23:22 2  pins on bank E
- 21:14 8  pins on bank C
- 13:0  13 pins on bank B

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 67 ++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b5863e36816..a7ddbcac9772 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -26,6 +26,8 @@
 
 /* use for A1 like chips */
 #define REG_PIN_A1_SEL	0x04
+/* Used for s4 chips */
+#define REG_EDGE_POL_S4	0x1c
 
 /*
  * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
@@ -53,6 +55,8 @@ static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
 static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
 static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
 				    unsigned int type, u32 *channel_hwirq);
+static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				      unsigned int type, u32 *channel_hwirq);
 
 struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
@@ -101,6 +105,17 @@ struct meson_gpio_irq_params {
 	.pin_sel_mask = 0x7f,					\
 	.nr_channels = 8,					\
 
+#define INIT_MESON_S4_COMMON_DATA(irqs)				\
+	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
+			  meson_a1_gpio_irq_sel_pin,		\
+			  meson_s4_gpio_irq_set_type)		\
+	.support_edge_both = true,				\
+	.edge_both_offset = 0,					\
+	.edge_single_offset = 12,				\
+	.pol_low_offset = 0,					\
+	.pin_sel_mask = 0xff,					\
+	.nr_channels = 12,					\
+
 static const struct meson_gpio_irq_params meson8_params = {
 	INIT_MESON8_COMMON_DATA(134)
 };
@@ -131,6 +146,10 @@ static const struct meson_gpio_irq_params a1_params = {
 	INIT_MESON_A1_COMMON_DATA(62)
 };
 
+static const struct meson_gpio_irq_params s4_params = {
+	INIT_MESON_S4_COMMON_DATA(82)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -140,6 +159,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
 	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
+	{ .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
 	{ }
 };
 
@@ -308,6 +328,53 @@ static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
 	return 0;
 }
 
+/*
+ * gpio irq relative registers for s4
+ * -PADCTRL_GPIO_IRQ_CTRL0
+ * bit[31]:    enable/disable all the irq lines
+ * bit[12-23]: single edge trigger
+ * bit[0-11]:  polarity trigger
+ *
+ * -PADCTRL_GPIO_IRQ_CTRL[X]
+ * bit[0-16]: 7 bits to choose gpio source for irq line 2*[X] - 2
+ * bit[16-22]:7 bits to choose gpio source for irq line 2*[X] - 1
+ * where X = 1-6
+ *
+ * -PADCTRL_GPIO_IRQ_CTRL[7]
+ * bit[0-11]: both edge trigger
+ */
+static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				      unsigned int type, u32 *channel_hwirq)
+{
+	u32 val = 0;
+	unsigned int idx;
+	const struct meson_gpio_irq_params *params;
+
+	params = ctl->params;
+	idx = meson_gpio_irq_get_channel_idx(ctl, channel_hwirq);
+
+	type &= IRQ_TYPE_SENSE_MASK;
+
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_S4, BIT(idx), 0);
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		val |= BIT(ctl->params->edge_both_offset + idx);
+		meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_S4,
+					   BIT(ctl->params->edge_both_offset + idx), val);
+		return 0;
+	}
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
+		val |= BIT(ctl->params->pol_low_offset + idx);
+
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+		val |= BIT(ctl->params->edge_single_offset + idx);
+
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
+				   BIT(idx) | BIT(12 + idx), val);
+	return 0;
+};
+
 static unsigned int meson_gpio_irq_type_output(unsigned int type)
 {
 	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
-- 
2.34.1

