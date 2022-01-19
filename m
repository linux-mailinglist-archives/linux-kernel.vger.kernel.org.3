Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734D149353E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351915AbiASHIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:08:22 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:18131 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351897AbiASHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:08:18 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Wed, 19 Jan 2022
 15:08:13 +0800
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
Subject: [PATCH v2 3/4] irqchip/meson-gpio: add select trigger type callback
Date:   Wed, 19 Jan 2022 15:08:08 +0800
Message-ID: <20220119070809.15563-4-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119070809.15563-1-qianggui.song@amlogic.com>
References: <20220119070809.15563-1-qianggui.song@amlogic.com>
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
 drivers/irqchip/irq-meson-gpio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index eefe15e1b3a6..b511f9532adc 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -55,6 +55,8 @@ struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
 				 unsigned int channel, unsigned long hwirq);
 	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
+	void (*gpio_irq_sel_type)(struct meson_gpio_irq_controller *ctl,
+				  unsigned int idx, u32 val);
 };
 
 struct meson_gpio_irq_params {
@@ -278,6 +280,12 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	 */
 	type &= IRQ_TYPE_SENSE_MASK;
 
+	/* Some controllers may have different calculation method*/
+	if (params->ops.gpio_irq_sel_type) {
+		params->ops.gpio_irq_sel_type(ctl, idx, type);
+		return 0;
+	}
+
 	/*
 	 * New controller support EDGE_BOTH trigger. This setting takes
 	 * precedence over the other edge/polarity settings
-- 
2.34.1

