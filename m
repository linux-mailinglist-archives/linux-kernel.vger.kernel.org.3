Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1E4CD9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiCDRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbiCDRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E676519D765
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:04:38 -0800 (PST)
Date:   Fri, 04 Mar 2022 17:04:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646413476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJ7C+WtEuvol/sPphNMaOxYWqTuEDx7BSH3Mp1sjm5U=;
        b=tJDZLclw8Sn8/mciPP3kraDCXe0k6BTxSCoQ2ezn3/sBg0g0Zjzo2mVUv7CRL9Ml0H6JA4
        Z12YoxNPXGEmGyEYXijI9wKV+gxEyecMeHImYUC3gcm+GQNrs9WeVp0+/4Se9ZRXJs9yM2
        Em7tqX+hGr8JGo5lEVuu9FSS+VHZRCF5OzzMVe9EemFc09Ldj4UbDhqHp+Gl326F7cqu9Y
        e0Rqp2dvZdK0NGc0QGDDdYu+i2N02MvdEgUPIVeeu8GN1+icGOSjH2b5Inzhh12JS34TKb
        dBuBsFSt+qzPE67gREU7XyGM2Ro5PJeoW4VE/KrGWCUmtOefXC+pmrVaFtvveg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646413476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJ7C+WtEuvol/sPphNMaOxYWqTuEDx7BSH3Mp1sjm5U=;
        b=IBu0gu9gqOuNBgpJl/dRmhEN+oJ3E0CBzqM16V/7BofufTv/fV0eua3anWbaT7rUzcrRyT
        pYTSPsQjjYIu/BBA==
From:   "irqchip-bot for Qianggui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/meson-gpio: Add support for meson s4 SoCs
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220225055207.1048-5-qianggui.song@amlogic.com>
References: <20220225055207.1048-5-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <164641347464.16921.6308199530707712987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d8a61a2ec7e75723083d33800423b151106922e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d8a61a2ec7e75723083d33800423b151106922e0
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Fri, 25 Feb 2022 13:52:06 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 04 Mar 2022 17:01:04 

irqchip/meson-gpio: Add support for meson s4 SoCs

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220225055207.1048-5-qianggui.song@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 67 +++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b5863e..a7ddbca 100644
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
