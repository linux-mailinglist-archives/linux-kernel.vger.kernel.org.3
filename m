Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B64488285
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiAHImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:42:31 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:35571 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiAHIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:42:28 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Sat, 8 Jan 2022
 16:42:20 +0800
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
Subject: [PATCH 3/4] irqchip/meson-gpio: add select trigger type callback
Date:   Sat, 8 Jan 2022 16:42:17 +0800
Message-ID: <20220108084218.31877-4-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108084218.31877-1-qianggui.song@amlogic.com>
References: <20220108084218.31877-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some chips may use different registers and offset, provide
a set trigger type call back.

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 6a7b4fb13452..98419428fcbd 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -55,6 +55,8 @@ struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
 				 unsigned int channel, unsigned long hwirq);
 	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
+	unsigned int (*gpio_irq_sel_type)(struct meson_gpio_irq_controller *ctl,
+					  unsigned int idx, u32 val);
 };
 
 struct meson_gpio_irq_params {
@@ -68,16 +70,17 @@ struct meson_gpio_irq_params {
 	struct irq_ctl_ops ops;
 };
 
-#define INIT_MESON_COMMON(irqs, init, sel)			\
+#define INIT_MESON_COMMON(irqs, init, sel, type)		\
 	.nr_hwirq = irqs,					\
 	.ops = {						\
 		.gpio_irq_init = init,				\
 		.gpio_irq_sel_pin = sel,			\
+		.gpio_irq_sel_type = type,			\
 	},
 
 #define INIT_MESON8_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_gpio_irq_init_dummy,	\
-			  meson8_gpio_irq_sel_pin)		\
+			  meson8_gpio_irq_sel_pin, NULL)	\
 	.edge_single_offset = 0,				\
 	.pol_low_offset = 16,					\
 	.pin_sel_mask = 0xff,					\
@@ -85,7 +88,7 @@ struct meson_gpio_irq_params {
 
 #define INIT_MESON_A1_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
-			  meson_a1_gpio_irq_sel_pin)		\
+			  meson_a1_gpio_irq_sel_pin, NULL)	\
 	.support_edge_both = true,				\
 	.edge_both_offset = 16,					\
 	.edge_single_offset = 8,				\
@@ -279,6 +282,10 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	 */
 	type &= IRQ_TYPE_SENSE_MASK;
 
+	/* Some controllers may have different calculation method*/
+	if (params->ops.gpio_irq_sel_type)
+		return params->ops.gpio_irq_sel_type(ctl, idx, type);
+
 	/*
 	 * New controller support EDGE_BOTH trigger. This setting takes
 	 * precedence over the other edge/polarity settings
-- 
2.34.1

