Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC24908A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiAQMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiAQMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:24:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:24:24 -0800 (PST)
Date:   Mon, 17 Jan 2022 12:24:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642422261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gas0a/0Ujt7eBwtVZIxV42eEbC5bT3S7poR6YQUQkF4=;
        b=YfPkZNLsHgjHkR7k6ZZRDFvwXxJffY6w1AnVXu4ZyMBwKSB9P0sS1ei9p6eEQVHtZ6p95x
        Yx4fxyi+Q1ZftdRRBL4Dco4AksypkEi7dNChCtTbKSLFszpNYDKwbIk4zyjCOkVus3EwZe
        UofHIPr+XTIR9bhtFCQuYPE1C+yUj/HVS9RFNohIXXJUJ4a7FZ3BlN+Fhn9gzRQTVp6FiF
        HL5Ns5qsEjjs/WxcWLAhalOvHBu8uVMcf8eJdAsNSilmc6VMx1eH376sDOi3fZxwQnM2D3
        HOUrm2zaNOVq8iqtMWX0yZrYrZocf+aJnK2GI9unONnHYfTdBnsSL00uLT1QoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642422261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gas0a/0Ujt7eBwtVZIxV42eEbC5bT3S7poR6YQUQkF4=;
        b=bu1qsWniPNeg79sjnTHkbswUauUI4OPwEOTWUjBKS1hcWMNona24foQvcauGlx/lWYYre+
        wSjoyCmMWiGVqfAg==
From:   "irqchip-bot for Sander Vanheule" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/realtek-rtl: Fix off-by-one in routing
Cc:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C177b920aa8d8610615692d0e657e509f363c85ca=2E16417?=
 =?utf-8?q?39718=2Egit=2Esander=40svanheule=2Enet=3E?=
References: =?utf-8?q?=3C177b920aa8d8610615692d0e657e509f363c85ca=2E164173?=
 =?utf-8?q?9718=2Egit=2Esander=40svanheule=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <164242226082.16921.16108534221087899214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     91351b5dd0fd494eb2d85e1bb6aca77b067447e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/91351b5dd0fd494eb2d85e1bb6aca77b067447e0
Author:        Sander Vanheule <sander@svanheule.net>
AuthorDate:    Sun, 09 Jan 2022 15:54:33 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 17 Jan 2022 12:14:04 

irqchip/realtek-rtl: Fix off-by-one in routing

There is an offset between routing values (1..6) and the connected MIPS
CPU interrupts (2..7), but no distinction was made between these two
values.

This issue was previously hidden during testing, because an interrupt
mapping was used where for each required interrupt another (unused)
routing was configured, with an offset of +1.

Offset the CPU IRQ numbers by -1 to retrieve the correct routing value.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/177b920aa8d8610615692d0e657e509f363c85ca.1641739718.git.sander@svanheule.net
---
 drivers/irqchip/irq-realtek-rtl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index d6788dd..568614e 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -95,7 +95,8 @@ out:
  * SoC interrupts are cascaded to MIPS CPU interrupts according to the
  * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
  * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
- * thus go into 4 IRRs.
+ * thus go into 4 IRRs. A routing value of '0' means the interrupt is left
+ * disconnected. Routing values {1..15} connect to output lines {0..14}.
  */
 static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
 {
@@ -134,7 +135,7 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 		of_node_put(cpu_ictl);
 
 		cpu_int = be32_to_cpup(imap + 2);
-		if (cpu_int > 7)
+		if (cpu_int > 7 || cpu_int < 2)
 			return -EINVAL;
 
 		if (!(mips_irqs_set & BIT(cpu_int))) {
@@ -143,7 +144,8 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 			mips_irqs_set |= BIT(cpu_int);
 		}
 
-		regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
+		/* Use routing values (1..6) for CPU interrupts (2..7) */
+		regs[(soc_int * 4) / 32] |= (cpu_int - 1) << (soc_int * 4) % 32;
 		imap += 3;
 	}
 
