Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4E4CD9AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbiCDRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiCDRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F471CA5D8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:04:38 -0800 (PST)
Date:   Fri, 04 Mar 2022 17:04:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646413477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9QYwuNq8Z8TrHdGXLl2GW6nmnmATUQKYK7r5uC3NCg=;
        b=W8tLfN16Vo++6i9/N6klxoX/DgM9IElVjKQVLIQKSPT3DFEPLbAQlpEhMdPqq5NFJI/4pt
        aHvx/hTGV6Dk2p0DG76HuEUE8aH7iwe6utGbbXNfJVjB+DEA30Rgu0UhrNJRUWFXs+KMJm
        t6ettpEAn4KcTpxhp8t2iwWG+K6AbaVfxfJA/k+LzU5DmYQOxt//c4iCbZFHu/33ZM2BlL
        9uIHDTpEOzN4ccMBJN2hGA9tDwUrZ1v3s4QH+DBwNyFYNTtnYDBmLZATDMdrUvHgMkXX2H
        l5krNcKcmM/i/y2VbVRS2U7eEItY4xODRdJUShuiZkWbqRIhIa7SdQgE88YuTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646413477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9QYwuNq8Z8TrHdGXLl2GW6nmnmATUQKYK7r5uC3NCg=;
        b=COV3wSiNyR+vG1kbYIdXoPSIX4SrjmSJdj2iG9EpgSKgbWlnGS1xjUx86cwKGZ46Bt/Z27
        cZPshvWXaS9i/YBg==
From:   "irqchip-bot for Qianggui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/meson-gpio: support more than 8
 channels gpio irq
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220225055207.1048-3-qianggui.song@amlogic.com>
References: <20220225055207.1048-3-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <164641347635.16921.15460164591748270551.tip-bot2@tip-bot2>
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

Commit-ID:     cc311074f681443266ed9f5969a5b5a0e833c5bc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cc311074f681443266ed9f5969a5b5a0e833c5bc
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Fri, 25 Feb 2022 13:52:04 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 04 Mar 2022 17:01:03 

irqchip/meson-gpio: support more than 8 channels gpio irq

Current meson gpio irqchip driver only support 8 channels for gpio irq
line, later chips may have more then 8 channels, so need to modify code
to support more.

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220225055207.1048-3-qianggui.song@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index d90ff0b..63841e1 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#define NUM_CHANNEL 8
+#define MAX_NUM_CHANNEL 64
 #define MAX_INPUT_MUX 256
 
 #define REG_EDGE_POL	0x00
@@ -60,6 +60,7 @@ struct irq_ctl_ops {
 
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
+	unsigned int nr_channels;
 	bool support_edge_both;
 	unsigned int edge_both_offset;
 	unsigned int edge_single_offset;
@@ -81,6 +82,7 @@ struct meson_gpio_irq_params {
 	.edge_single_offset = 0,				\
 	.pol_low_offset = 16,					\
 	.pin_sel_mask = 0xff,					\
+	.nr_channels = 8,					\
 
 #define INIT_MESON_A1_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
@@ -90,6 +92,7 @@ struct meson_gpio_irq_params {
 	.edge_single_offset = 8,				\
 	.pol_low_offset = 0,					\
 	.pin_sel_mask = 0x7f,					\
+	.nr_channels = 8,					\
 
 static const struct meson_gpio_irq_params meson8_params = {
 	INIT_MESON8_COMMON_DATA(134)
@@ -136,8 +139,8 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 struct meson_gpio_irq_controller {
 	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
-	u32 channel_irqs[NUM_CHANNEL];
-	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
+	u32 channel_irqs[MAX_NUM_CHANNEL];
+	DECLARE_BITMAP(channel_map, MAX_NUM_CHANNEL);
 	spinlock_t lock;
 };
 
@@ -207,8 +210,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	spin_lock_irqsave(&ctl->lock, flags);
 
 	/* Find a free channel */
-	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
-	if (idx >= NUM_CHANNEL) {
+	idx = find_first_zero_bit(ctl->channel_map, ctl->params->nr_channels);
+	if (idx >= ctl->params->nr_channels) {
 		spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
@@ -450,10 +453,10 @@ static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_i
 	ret = of_property_read_variable_u32_array(node,
 						  "amlogic,channel-interrupts",
 						  ctl->channel_irqs,
-						  NUM_CHANNEL,
-						  NUM_CHANNEL);
+						  ctl->params->nr_channels,
+						  ctl->params->nr_channels);
 	if (ret < 0) {
-		pr_err("can't get %d channel interrupts\n", NUM_CHANNEL);
+		pr_err("can't get %d channel interrupts\n", ctl->params->nr_channels);
 		return ret;
 	}
 
@@ -507,7 +510,7 @@ static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *
 	}
 
 	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->params->nr_hwirq, NUM_CHANNEL);
+		ctl->params->nr_hwirq, ctl->params->nr_channels);
 
 	return 0;
 
