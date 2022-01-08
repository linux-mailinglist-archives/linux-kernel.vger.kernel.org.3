Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F37488284
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiAHIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:42:29 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:35571 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiAHIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:42:26 -0500
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
Subject: [PATCH 2/4] irqchip/meson-gpio: support more than 8 channels gpio irq line
Date:   Sat, 8 Jan 2022 16:42:16 +0800
Message-ID: <20220108084218.31877-3-qianggui.song@amlogic.com>
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

Current meson gpio irqchip driver only support 8 channels for gpio irq
line, later chips may have more then 8 channels, so need to modify code
to support more.

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 33 +++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index d90ff0b92480..6a7b4fb13452 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#define NUM_CHANNEL 8
 #define MAX_INPUT_MUX 256
 
 #define REG_EDGE_POL	0x00
@@ -60,6 +59,7 @@ struct irq_ctl_ops {
 
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
+	unsigned int channel_num;
 	bool support_edge_both;
 	unsigned int edge_both_offset;
 	unsigned int edge_single_offset;
@@ -81,6 +81,7 @@ struct meson_gpio_irq_params {
 	.edge_single_offset = 0,				\
 	.pol_low_offset = 16,					\
 	.pin_sel_mask = 0xff,					\
+	.channel_num = 8,					\
 
 #define INIT_MESON_A1_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
@@ -90,6 +91,7 @@ struct meson_gpio_irq_params {
 	.edge_single_offset = 8,				\
 	.pol_low_offset = 0,					\
 	.pin_sel_mask = 0x7f,					\
+	.channel_num = 8,					\
 
 static const struct meson_gpio_irq_params meson8_params = {
 	INIT_MESON8_COMMON_DATA(134)
@@ -136,8 +138,9 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 struct meson_gpio_irq_controller {
 	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
-	u32 channel_irqs[NUM_CHANNEL];
-	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
+	u32 *channel_irqs;
+	unsigned long *channel_map;
+	u8 channel_num;
 	spinlock_t lock;
 };
 
@@ -207,8 +210,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	spin_lock_irqsave(&ctl->lock, flags);
 
 	/* Find a free channel */
-	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
-	if (idx >= NUM_CHANNEL) {
+	idx = find_first_zero_bit(ctl->channel_map, ctl->channel_num);
+	if (idx >= ctl->channel_num) {
 		spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
@@ -447,13 +450,25 @@ static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_i
 
 	ctl->params = match->data;
 
+	ctl->channel_num = ctl->params->channel_num;
+	ctl->channel_irqs = kcalloc(ctl->channel_num,
+				    sizeof(*ctl->channel_irqs), GFP_KERNEL);
+	if (!ctl->channel_irqs)
+		return -ENOMEM;
+
+	ctl->channel_map = bitmap_zalloc(ctl->params->channel_num, GFP_KERNEL);
+	if (!ctl->channel_map) {
+		kfree(ctl->channel_irqs);
+		return -ENOMEM;
+	}
+
 	ret = of_property_read_variable_u32_array(node,
 						  "amlogic,channel-interrupts",
 						  ctl->channel_irqs,
-						  NUM_CHANNEL,
-						  NUM_CHANNEL);
+						  ctl->channel_num,
+						  ctl->channel_num);
 	if (ret < 0) {
-		pr_err("can't get %d channel interrupts\n", NUM_CHANNEL);
+		pr_err("can't get %d channel interrupts\n", ctl->channel_num);
 		return ret;
 	}
 
@@ -507,7 +522,7 @@ static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *
 	}
 
 	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->params->nr_hwirq, NUM_CHANNEL);
+		ctl->params->nr_hwirq, ctl->channel_num);
 
 	return 0;
 
-- 
2.34.1

