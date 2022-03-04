Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756F4CD690
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiCDOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCDOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:41:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96B1986E1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:40:26 -0800 (PST)
Date:   Fri, 04 Mar 2022 14:40:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646404824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LD96CHPrg+BDaWPvvqggTZ3L8vFJ3IVjPlhiiXozQ4=;
        b=E05fLLvcSl0l9yG9f8wo9NUS22QdMZnsymrsevFiC+Tks7NyaUtEHmMqtbgQBQQ7BeCuie
        lMw4Q0ZBSd8Fkejs+9iZHuIp+RzDdbaVpbBY8NDNACnR2gCeyztxm0DgErYnx3nVR6+w2q
        ctTB3Oua1KyhI+3EjqSDNYxikpBMuwX7Mn0tn3sBq/uA5QHOYLBy0hFmnJLq8rt4v9xmPP
        CXW+GX55XZCEDCAi5GFxa+nnUbp96iGOfzI6dHRu+xZYSyIULEoRI466DLVms47idCdAGW
        qeuLe6/ojzh5hZ4rH4OmV53mzeb/TBLlCDLC8CSA5P/9A4DlIt7zLMux2p888A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646404824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LD96CHPrg+BDaWPvvqggTZ3L8vFJ3IVjPlhiiXozQ4=;
        b=xo3Wo90MT4nJ4u5oMx99FWo65Mgowo3Lryv7POMv1WUtTZYmdL2xIarEINDm1aTYIBDtPB
        0TIGMh+NPuqAGFCQ==
From:   "irqchip-bot for Michal Simek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/xilinx: Switch to
 GENERIC_IRQ_MULTI_HANDLER
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Ce6c6595a81f662bf839cee3109d0fa58a596ea47=2E16463?=
 =?utf-8?q?80284=2Egit=2Emichal=2Esimek=40xilinx=2Ecom=3E?=
References: =?utf-8?q?=3Ce6c6595a81f662bf839cee3109d0fa58a596ea47=2E164638?=
 =?utf-8?q?0284=2Egit=2Emichal=2Esimek=40xilinx=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164640482346.16921.5343760008736288350.tip-bot2@tip-bot2>
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

Commit-ID:     1e364921b0085780153b1d03640ca41e1be83e8b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1e364921b0085780153b1d03640ca41e1be83e8b
Author:        Michal Simek <michal.simek@xilinx.com>
AuthorDate:    Fri, 04 Mar 2022 08:51:29 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 04 Mar 2022 14:32:57 

irqchip/xilinx: Switch to GENERIC_IRQ_MULTI_HANDLER

Register the Xilinx driver as the root interrupt controller using
the GENERIC_IRQ_MULTI_HANDLER API, instead of the arch-specific hack.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
[maz: repainted commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/e6c6595a81f662bf839cee3109d0fa58a596ea47.1646380284.git.michal.simek@xilinx.com
---
 arch/microblaze/Kconfig           |  2 ++-
 arch/microblaze/include/asm/irq.h |  3 +---
 arch/microblaze/kernel/irq.c      | 16 +---------------
 drivers/irqchip/irq-xilinx-intc.c | 30 ++++++++++++++++--------------
 4 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e4..da568e9 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -45,6 +45,8 @@ config MICROBLAZE
 	select SET_FS
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
+	select GENERIC_IRQ_MULTI_HANDLER
+	select HANDLE_DOMAIN_IRQ
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index 0a28e80..cb6ab55 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -11,7 +11,4 @@
 struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
 
-/* should be defined in each interrupt controller driver */
-extern unsigned int xintc_get_irq(void);
-
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 903dad8..1f8cb4c 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,27 +20,13 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 
-static u32 concurrent_irq;
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	unsigned int irq;
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
 
 	irq_enter();
-	irq = xintc_get_irq();
-next_irq:
-	BUG_ON(!irq);
-	generic_handle_irq(irq);
-
-	irq = xintc_get_irq();
-	if (irq != -1U) {
-		pr_debug("next irq: %d\n", irq);
-		++concurrent_irq;
-		goto next_irq;
-	}
-
+	handle_arch_irq(regs);
 	irq_exit();
 	set_irq_regs(old_regs);
 	trace_hardirqs_on();
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 356a597..238d3d3 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -32,6 +32,8 @@
 #define MER_ME (1<<0)
 #define MER_HIE (1<<1)
 
+#define SPURIOUS_IRQ	(-1U)
+
 static DEFINE_STATIC_KEY_FALSE(xintc_is_be);
 
 struct xintc_irq_chip {
@@ -110,20 +112,6 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
-unsigned int xintc_get_irq(void)
-{
-	unsigned int irq = -1;
-	u32 hwirq;
-
-	hwirq = xintc_read(primary_intc, IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct xintc_irq_chip *irqc = d->host_data;
@@ -164,6 +152,19 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+
+	do {
+		hwirq = xintc_read(primary_intc, IVR);
+		if (unlikely(hwirq == SPURIOUS_IRQ))
+			break;
+
+		generic_handle_domain_irq(primary_intc->root_domain, hwirq);
+	} while (true);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -233,6 +234,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
