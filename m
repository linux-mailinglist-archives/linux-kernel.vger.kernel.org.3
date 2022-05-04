Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B851A528
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353269AbiEDQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353259AbiEDQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24D10F1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:17 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2vHls7OFJ9WpNJVx5ui3b+OziiE0WeKT5e6e7wVy4g=;
        b=KqSGIo7aUE+doxcCKieI4MeeL/KtYnybsSDil/gUiWKzckzJmVOljqf8tYiAX+Rf8/o5Xk
        LZaF2XpNsblnM3bHwL9CVEgiXY+4BkXhNIi1KPQdebwjr8DZpk3XcqqVPeOOXt/YS4eTVE
        bsb1CYtZqRotyWx8O0NqUgbwB46ujLD2MTxjN+pb9WxOR3i2+qSVJfM2ZvO9uN8dPldcqm
        +Mlg17fyo2eugMlOt2SVEuofKLwcOT89/kx9gOaXrAiuYihNiNwlaEo3tbc9cb3z7ojkPY
        40GJziiplNr2OG+lZ8HTu5tQ9//OuMMOFeog42sMiJ4lJwgn3GhwGYCS/SQRrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2vHls7OFJ9WpNJVx5ui3b+OziiE0WeKT5e6e7wVy4g=;
        b=/J1STSEfG5kxkmu14GFOinCQE2qFEPRVnoTaBG3s/sr91vOSszBrSzj0FQSjaU0jHDQIh4
        zMjildlOQD8ezeAw==
From:   "irqchip-bot for Daniel Thompson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/exiu: Fix acknowledgment of edge
 triggered interrupts
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220503134541.2566457-1-daniel.thompson@linaro.org>
References: <20220503134541.2566457-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Message-ID: <165168091463.4207.2939998284968135016.tip-bot2@tip-bot2>
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

Commit-ID:     4efc851c36e389f7ed432edac0149acc5f94b0c7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4efc851c36e389f7ed432edac0149acc5f94b0c7
Author:        Daniel Thompson <daniel.thompson@linaro.org>
AuthorDate:    Tue, 03 May 2022 14:45:41 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:33:17 +01:00

irqchip/exiu: Fix acknowledgment of edge triggered interrupts

Currently the EXIU uses the fasteoi interrupt flow that is configured by
it's parent (irq-gic-v3.c). With this flow the only chance to clear the
interrupt request happens during .irq_eoi() and (obviously) this happens
after the interrupt handler has run. EXIU requires edge triggered
interrupts to be acked prior to interrupt handling. Without this we
risk incorrect interrupt dismissal when a new interrupt is delivered
after the handler reads and acknowledges the peripheral but before the
irq_eoi() takes place.

Fix this by clearing the interrupt request from .irq_ack() if we are
configured for edge triggered interrupts. This requires adopting the
fasteoi-ack flow instead of the fasteoi to ensure the ack gets called.

These changes have been tested using the power button on a
Developerbox/SC2A11 combined with some hackery in gpio-keys so I can
play with the different trigger mode [and an mdelay(500) so I can
can check what happens on a double click in both modes].

Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220503134541.2566457-1-daniel.thompson@linaro.org
---
 arch/arm64/Kconfig.platforms   |  1 +
 drivers/irqchip/irq-sni-exiu.c | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123c..aaeaf57 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -253,6 +253,7 @@ config ARCH_INTEL_SOCFPGA
 
 config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoC Family"
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index abd011f..c7db617 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -37,11 +37,26 @@ struct exiu_irq_data {
 	u32		spi_base;
 };
 
-static void exiu_irq_eoi(struct irq_data *d)
+static void exiu_irq_ack(struct irq_data *d)
 {
 	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
 
 	writel(BIT(d->hwirq), data->base + EIREQCLR);
+}
+
+static void exiu_irq_eoi(struct irq_data *d)
+{
+	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * Level triggered interrupts are latched and must be cleared during
+	 * EOI or the interrupt will be jammed on. Of course if a level
+	 * triggered interrupt is still asserted then the write will not clear
+	 * the interrupt.
+	 */
+	if (irqd_is_level_type(d))
+		writel(BIT(d->hwirq), data->base + EIREQCLR);
+
 	irq_chip_eoi_parent(d);
 }
 
@@ -91,10 +106,13 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
 	writel_relaxed(val, data->base + EILVL);
 
 	val = readl_relaxed(data->base + EIEDG);
-	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
+	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH) {
 		val &= ~BIT(d->hwirq);
-	else
+		irq_set_handler_locked(d, handle_fasteoi_irq);
+	} else {
 		val |= BIT(d->hwirq);
+		irq_set_handler_locked(d, handle_fasteoi_ack_irq);
+	}
 	writel_relaxed(val, data->base + EIEDG);
 
 	writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
@@ -104,6 +122,7 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
 
 static struct irq_chip exiu_irq_chip = {
 	.name			= "EXIU",
+	.irq_ack		= exiu_irq_ack,
 	.irq_eoi		= exiu_irq_eoi,
 	.irq_enable		= exiu_irq_enable,
 	.irq_mask		= exiu_irq_mask,
