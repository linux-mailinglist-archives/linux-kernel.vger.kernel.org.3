Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE44CD9A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiCDRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbiCDRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7C1C74E4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:04:38 -0800 (PST)
Date:   Fri, 04 Mar 2022 17:04:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646413476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oudGoazTvYhBcJSfcgh+peQ+VgFu16xV/OraEPFy1eI=;
        b=o+PRLhTI4wc0XN7lPi2AqwrqJNKisEoZQGoDL3oviv1Ve9T3ART5v+NYqepfLNZFY4v66n
        OWgPSgFp949TrvNDRxxoHt4zIFMV5jmf3fELD54UeIN0b9D/Otm0wut67lzGPnFEs7BOmi
        n7jnp94XgnSSnqaqvvH1jlAlk3DP6E0SXf3+GD2Ec9NuF/FH3pP2p3GjijgmkEumstKX+Q
        38JHl3sBHAiqbR+Nz+QlH0vWlRGTBjLa9tWZYfv18pJ8jVxhkwGFLG1a0SrIQuU04euq10
        UpqLQsOLS3S2NRk9hTLWBmbTDeGlzxA5SgWsVJyHZBeh1z0ZeJsoGZQCctUUSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646413476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oudGoazTvYhBcJSfcgh+peQ+VgFu16xV/OraEPFy1eI=;
        b=TeAeiqtUZXtvn9S6RvSiIPjXjQIjTH/8MnV1I9LZW3HFxqIhlBLptDTs2gKG0EH4IxFjPZ
        QQnFTBJv9NGOlwAQ==
From:   "irqchip-bot for Qianggui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/meson-gpio: add select trigger
 type callback
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220225055207.1048-4-qianggui.song@amlogic.com>
References: <20220225055207.1048-4-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <164641347553.16921.7075844011075435329.tip-bot2@tip-bot2>
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

Commit-ID:     be6692b923355206ab8cd3705d3ef0e0768adb90
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/be6692b923355206ab8cd3705d3ef0e0768adb90
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Fri, 25 Feb 2022 13:52:05 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 04 Mar 2022 17:01:04 

irqchip/meson-gpio: add select trigger type callback

Due to some chips may use different registers and offset, provide
a set trigger type call back and add one for old controller.

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220225055207.1048-4-qianggui.song@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 63841e1..7b5863e 100644
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
 
