Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE91951A524
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353264AbiEDQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353239AbiEDQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBF46B2E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:12 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvWUCE05VAUNVaeaG/FzspO0hMzMwVZFzj5zR+dJitE=;
        b=ro5EkUP3JsJrHWnQX97a7xNzAPmI68rMu1k45m+5H3tW5mA+UzEimaRbZBT9rrvkZGj4kG
        nSPgBMlux9eGcCZgM+E4DjNXtcgTaFsc/8Cx4W/kw24V/UrM/cCLxxYsklbNVMR1TCsNvR
        Pr0yij/aEMiQFh+ERl5qUjjEN0ZPCB6k4ZwWyvtoyhqTLqr9NzIsEXSOHpFpjhM3N2yALV
        qUIJJRvmcxOGEXQRvFdH/7b3K1HK3cqNaHb7qhuKoKllqPNrpdf2h3toJwgNcr9clyP2C6
        BQBx6hndkQ+3jSmsJb8s+bQQzPAY+4oi6oZtRBD8H6JL3Acjj8rwPO2M1RVxWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvWUCE05VAUNVaeaG/FzspO0hMzMwVZFzj5zR+dJitE=;
        b=1xLlVyF5yQe+8d9rSzVvavYmxDrtfqVefmqJrGmkSMDDh7uJNU0EvMshOhKwgzmn34N5G8
        chB45YcBX6x9rHDg==
From:   "irqchip-bot for Nathan Rossi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/armada-370-xp: Enable MSI
 affinity configuration
Cc:     Nathan Rossi <nathan.rossi@digi.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220422043532.146946-1-nathan@nathanrossi.com>
References: <20220422043532.146946-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Message-ID: <165168090984.4207.14744416156306479417.tip-bot2@tip-bot2>
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

Commit-ID:     8ca61cde32c1db778aa52631184484e051cbdf27
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8ca61cde32c1db778aa52631184484e051cbdf27
Author:        Nathan Rossi <nathan.rossi@digi.com>
AuthorDate:    Fri, 22 Apr 2022 04:35:32 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:40:06 +01:00

irqchip/armada-370-xp: Enable MSI affinity configuration

With multiple devices attached via PCIe to an Armada 385 it is possible
to overwhelm a single CPU with MSI interrupts. Under certain scenarios
configuring the interrupts to be handled by more than one CPU would
prevent the system from being overwhelmed. However the
irqchip-aramada-370-xp driver is configured to only handle MSIs on the
boot CPU, and provides no affinity configuration.

This change adds support to the armada-370-xp driver to allow for
configuring the affinity of specific MSI irqs and to generate the
interrupts on secondary CPUs. This is done by enabling the private
doorbell for all online CPUs and configures all CPUs to unmask MSI
specific private doorbell bits. The CPU affinity selection of the
interrupt is handled by the target list of the software triggered
interrupt value, which is provided as the MSI message. The message has
the associated CPU bit set for the target CPU. For private doorbell
interrupts only one bit can be set otherwise all CPUs will receive the
interrupt, so the lowest CPU in the affinity mask is used. This means
that by default the first CPU will handle all the interrupts as was the
case before.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220422043532.146946-1-nathan@nathanrossi.com
---
 drivers/irqchip/irq-armada-370-xp.c | 45 ++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5b8d571..c877285 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -209,15 +209,29 @@ static struct msi_domain_info armada_370_xp_msi_domain_info = {
 
 static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
+	unsigned int cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
+
 	msg->address_lo = lower_32_bits(msi_doorbell_addr);
 	msg->address_hi = upper_32_bits(msi_doorbell_addr);
-	msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
+	msg->data = BIT(cpu + 8) | (data->hwirq + PCI_MSI_DOORBELL_START);
 }
 
 static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
 					  const struct cpumask *mask, bool force)
 {
-	 return -EINVAL;
+	unsigned int cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
 }
 
 static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
@@ -264,11 +278,21 @@ static const struct irq_domain_ops armada_370_xp_msi_domain_ops = {
 	.free	= armada_370_xp_msi_free,
 };
 
-static int armada_370_xp_msi_init(struct device_node *node,
-				  phys_addr_t main_int_phys_base)
+static void armada_370_xp_msi_reenable_percpu(void)
 {
 	u32 reg;
 
+	/* Enable MSI doorbell mask and combined cpu local interrupt */
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
+		| PCI_MSI_DOORBELL_MASK;
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	/* Unmask local doorbell interrupt */
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+}
+
+static int armada_370_xp_msi_init(struct device_node *node,
+				  phys_addr_t main_int_phys_base)
+{
 	msi_doorbell_addr = main_int_phys_base +
 		ARMADA_370_XP_SW_TRIG_INT_OFFS;
 
@@ -287,18 +311,13 @@ static int armada_370_xp_msi_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
-		| PCI_MSI_DOORBELL_MASK;
-
-	writel(reg, per_cpu_int_base +
-	       ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-
-	/* Unmask IPI interrupt */
-	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	armada_370_xp_msi_reenable_percpu();
 
 	return 0;
 }
 #else
+static void armada_370_xp_msi_reenable_percpu(void) {}
+
 static inline int armada_370_xp_msi_init(struct device_node *node,
 					 phys_addr_t main_int_phys_base)
 {
@@ -501,6 +520,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 	}
 
 	ipi_resume();
+
+	armada_370_xp_msi_reenable_percpu();
 }
 
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
