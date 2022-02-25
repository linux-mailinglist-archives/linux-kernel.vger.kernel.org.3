Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C314C3E38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiBYGIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiBYGHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:07:55 -0500
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620112B775
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:07:22 -0800 (PST)
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 25 Feb 2022
 13:52:09 +0800
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
Subject: [PATCH v3 3/4] irqchip/meson-gpio: add select trigger type callback
Date:   Fri, 25 Feb 2022 13:52:05 +0800
Message-ID: <20220225055207.1048-4-qianggui.song@amlogic.com>
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

Due to some chips may use different registers and offset, provide
a set trigger type call back and add one for old controller.

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 63841e1578f5..7b5863e36816 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -51,11 +51,15 @@ static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
 				      unsigned int channel,
 				      unsigned long hwirq);
 static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
+static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				    unsigned int type, u32 *channel_hwirq);
 
 struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
 				 unsigned int channel, unsigned long hwirq);
 	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
+	int (*gpio_irq_set_type)(struct meson_gpio_irq_controller *ctl,
+				 unsigned int type, u32 *channel_hwirq);
 };
 
 struct meson_gpio_irq_params {
@@ -69,16 +73,18 @@ struct meson_gpio_irq_params {
 	struct irq_ctl_ops ops;
 };
 
-#define INIT_MESON_COMMON(irqs, init, sel)			\
+#define INIT_MESON_COMMON(irqs, init, sel, type)		\
 	.nr_hwirq = irqs,					\
 	.ops = {						\
 		.gpio_irq_init = init,				\
 		.gpio_irq_sel_pin = sel,			\
+		.gpio_irq_set_type = type,			\
 	},
 
 #define INIT_MESON8_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_gpio_irq_init_dummy,	\
-			  meson8_gpio_irq_sel_pin)		\
+			  meson8_gpio_irq_sel_pin,		\
+			  meson8_gpio_irq_set_type)		\
 	.edge_single_offset = 0,				\
 	.pol_low_offset = 16,					\
 	.pin_sel_mask = 0xff,					\
@@ -86,7 +92,8 @@ struct meson_gpio_irq_params {
 
 #define INIT_MESON_A1_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
-			  meson_a1_gpio_irq_sel_pin)		\
+			  meson_a1_gpio_irq_sel_pin,		\
+			  meson8_gpio_irq_set_type)		\
 	.support_edge_both = true,				\
 	.edge_both_offset = 16,					\
 	.edge_single_offset = 8,				\
@@ -259,9 +266,8 @@ meson_gpio_irq_release_channel(struct meson_gpio_irq_controller *ctl,
 	clear_bit(idx, ctl->channel_map);
 }
 
-static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
-				     unsigned int type,
-				     u32 *channel_hwirq)
+static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				    unsigned int type, u32 *channel_hwirq)
 {
 	u32 val = 0;
 	unsigned int idx;
@@ -326,7 +332,7 @@ static int meson_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	u32 *channel_hwirq = irq_data_get_irq_chip_data(data);
 	int ret;
 
-	ret = meson_gpio_irq_type_setup(ctl, type, channel_hwirq);
+	ret = ctl->params->ops.gpio_irq_set_type(ctl, type, channel_hwirq);
 	if (ret)
 		return ret;
 
-- 
2.34.1

