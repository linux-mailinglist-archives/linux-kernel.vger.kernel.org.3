Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44D4CA62C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiCBNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbiCBNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:41:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FE36E1F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:40:54 -0800 (PST)
Date:   Wed, 02 Mar 2022 13:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646228452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLGQ/WL/ftFkeXT1z6e2kqcR2dMs3LwyBbuotjCoh5U=;
        b=nyMkSewkJnZP8ztqzWaX6P/aHFFY+JLPLLbwe9ayV3/+n2uy1/G1je1L95lTyRPaSnaLjq
        OxfoIE/lsIxC/HDl9NdwXGO6zDVsyQDgr42qxVvoxDj23ShBZ2kLqAaR/sofUINLqY/THN
        UES8ps6PW6rUiZYB78gHClA7Zu4ON3mrhYG9ffTeMou3x7Wa0fQ36nxqZaj3emwu4UpLiM
        2peqouhPDZuCePNnOBz2zncyK3aNkjVQ33oDBSVRdDFLuc+ZtAukWksqzw9Wmomlr0cgnu
        uQBY+ROSRfkCRu8/XCM9sSxlMeQmL7EnBz0bdarHzKIJF4o/IN9LlylGB8n7Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646228452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLGQ/WL/ftFkeXT1z6e2kqcR2dMs3LwyBbuotjCoh5U=;
        b=W0vSlduBbDgR/emPCqR/CGdPZEuzAc8LETQyQdP51hShnSueokVOHbGYJIR0HwXmORLTt4
        eYHjUWDHUUt+6pBw==
From:   "irqchip-bot for Niklas Cassel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Disable S-mode IRQs
 if running in M-mode
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220302131544.3166154-3-Niklas.Cassel@wdc.com>
References: <20220302131544.3166154-3-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Message-ID: <164622845144.16921.18355558429149902686.tip-bot2@tip-bot2>
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

Commit-ID:     098fdbc3531f06aae2426b3a6f9bd730e7691258
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/098fdbc3531f06aae2426b3a6f9bd730e7691258
Author:        Niklas Cassel <niklas.cassel@wdc.com>
AuthorDate:    Wed, 02 Mar 2022 13:15:53 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Mar 2022 13:30:50 

irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode

When detecting a context for a privilege mode different from the current
running privilege mode, we simply skip to the next context register.

This means that we never clear the S-mode enable bits when running in
M-mode.

On canaan k210, a bunch of S-mode interrupts are enabled by the bootrom.
These S-mode specific interrupts should never trigger, since we never set
the mie.SEIE bit in the parent interrupt controller (riscv-intc).

However, we will be able to see the mip.SEIE bit set as pending.

This isn't a good default when CONFIG_RISCV_M_MODE is set, since in that
case we will never enter a lower privilege mode (e.g. S-mode).

Let's clear the S-mode enable bits when running the kernel in M-mode, such
that we won't have a interrupt pending bit set, which we will never clear.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220302131544.3166154-3-Niklas.Cassel@wdc.com
---
 drivers/irqchip/irq-sifive-plic.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 28b86cd..7ae12e5 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -81,17 +81,21 @@ static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
-	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
+	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
 
-	raw_spin_lock(&handler->enable_lock);
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
 	else
 		writel(readl(reg) & ~hwirq_mask, reg);
+}
+
+static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
+{
+	raw_spin_lock(&handler->enable_lock);
+	__plic_toggle(handler->enable_base, hwirq, enable);
 	raw_spin_unlock(&handler->enable_lock);
 }
 
@@ -324,8 +328,18 @@ static int __init plic_init(struct device_node *node,
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] != RV_IRQ_EXT)
+		if (parent.args[0] != RV_IRQ_EXT) {
+			/* Disable S-mode enable bits if running in M-mode. */
+			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
+				void __iomem *enable_base = priv->regs +
+					CONTEXT_ENABLE_BASE +
+					i * CONTEXT_ENABLE_SIZE;
+
+				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+					__plic_toggle(enable_base, hwirq, 0);
+			}
 			continue;
+		}
 
 		hartid = riscv_of_parent_hartid(parent.np);
 		if (hartid < 0) {
