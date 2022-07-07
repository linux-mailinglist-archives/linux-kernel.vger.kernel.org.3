Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBEE56A3B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiGGNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiGGNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:32:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8B31DCE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:31:59 -0700 (PDT)
Date:   Thu, 07 Jul 2022 13:31:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657200717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4a9+1fF8/GATQEeg8m313ct5YLydksmpM3u53E+3Tw=;
        b=J+QTuCKwd9xej6UZf/ByzL5X0YFSiHyXLUEql7Vd6/ZHl1h24UW0M5Ivd3kte3T75cxHGL
        EqgtXBxoC6UcJo2oWwToz5lSW6dCifBPgWzi04tz17WRIV5QUbDVLyG8fuo0JxE20MsfCp
        x8G/Bm+T5tcG+8UgxrwEjpblQDwau8yUEZR0FttLUINqYzQK1Kknak0GaNE1jf+sI5w7yB
        vrBogfTFpZOSVNkrYCV7PNNunZtNgJud4TKTc0VKTqqAdcj7AlAlefdH/NxoSvadf++Ww6
        zOE3rokll1Z7zECTIgvYCSHv7dZqApFYjgMDpi69fL+WGoGd5+dsvSlGkaqX3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657200717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4a9+1fF8/GATQEeg8m313ct5YLydksmpM3u53E+3Tw=;
        b=qAUWHIy6Gg3+mqzFJz/AGV349LLtBbReh7r8RmAc7/W+n5ygZS6vCPu4jaR/9Lg4Uaop7A
        /1chRAGJfNfcbXCw==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Separate the enable
 and mask operations
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701202440.59059-3-samuel@sholland.org>
References: <20220701202440.59059-3-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165720071576.15455.16877329557805101790.tip-bot2@tip-bot2>
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

Commit-ID:     b5121acddbfc5be09947b95991cae8c645eabcb5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b5121acddbfc5be09947b95991cae8c645eabcb5
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:24:40 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 14:19:48 +01:00

irqchip/sifive-plic: Separate the enable and mask operations

The PLIC has two per-IRQ checks before sending an IRQ to a hart context.
First, it checks that the IRQ's priority is nonzero. Then, it checks
that the enable bit is set for that combination of IRQ and context.

Currently, the PLIC driver sets both the priority value and the enable
bit in its (un)mask operations. However, modifying the enable bit is
problematic for two reasons:
  1) The enable bits are packed, so changes are not atomic and require
     taking a spinlock.
  2) The following requirement from the PLIC spec, which explains the
     racy (un)mask operations in plic_irq_eoi():

       If the completion ID does not match an interrupt source
       that is currently enabled for the target, the completion
       is silently ignored.

Both of these problems are solved by using the priority value to mask
IRQs. Each IRQ has a separate priority register, so writing the priority
value is atomic. And since the enable bit remains set while an IRQ is
masked, the EOI operation works normally. The enable bits are still used
to control the IRQ's affinity.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701202440.59059-3-samuel@sholland.org
---
 drivers/irqchip/irq-sifive-plic.c | 55 ++++++++++++++++++------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 46595e6..ba49381 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -108,9 +108,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
@@ -118,16 +116,37 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_unmask(struct irq_data *d)
+static void plic_irq_enable(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 }
 
-static void plic_irq_mask(struct irq_data *d)
+static void plic_irq_disable(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
 
+static void plic_irq_unmask(struct irq_data *d)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_mask(struct irq_data *d)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_eoi(struct irq_data *d)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+}
+
 #ifdef CONFIG_SMP
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
@@ -146,32 +165,21 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_mask(d);
+	plic_irq_disable(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-	if (!irqd_irq_masked(d))
-		plic_irq_unmask(d);
+	if (!irqd_irq_disabled(d))
+		plic_irq_enable(d);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
 
-static void plic_irq_eoi(struct irq_data *d)
-{
-	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-
-	if (irqd_irq_masked(d)) {
-		plic_irq_unmask(d);
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-		plic_irq_mask(d);
-	} else {
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-	}
-}
-
 static struct irq_chip plic_edge_chip = {
 	.name		= "SiFive PLIC",
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
 	.irq_ack	= plic_irq_eoi,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
@@ -184,6 +192,8 @@ static struct irq_chip plic_edge_chip = {
 
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
 	.irq_eoi	= plic_irq_eoi,
@@ -429,8 +439,11 @@ static int __init __plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 done:
-		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
+			writel(1, priv->regs + PRIORITY_BASE +
+				  hwirq * PRIORITY_PER_ID);
+		}
 		nr_handlers++;
 	}
 
