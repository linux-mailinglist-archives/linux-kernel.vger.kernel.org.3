Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F73569E22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiGGIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiGGIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:50:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F64B326E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:50:07 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:50:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657183806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoRS9Qp1TorgML/CEEEoIjawSrsi3st5GVeXr//dIdk=;
        b=DoNTISV9HRqyvXyHfbwWLvI50geNeLTdMjbdnm05CliilPzUszZD+XbRNu3DktM3YFtKmN
        kTzqGWVs0HtQsSQHCB9gE3CD69ig1L/oKoUBY4Lo7dmTQUcqRIkPBPGW2QWVozIpXjrKwR
        hNZ/pnZP0Xr5Ks7vSkUFm5CDCRA165OmovwajkikYFql42IwikivkB21PNJ4zUONhXI7Q9
        TCWMxW7whh4hzV9irdS/IkGDUZq0nV7P6CkuDLmyDR7zoGqMIS5dKwPVJrG8rzgyOMesrc
        mJLvybjs7R2d0n9CMI7uYxVRaYHDrUtYg8xnGPKIztDqbiB9HOHw1zJG76uH0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657183806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoRS9Qp1TorgML/CEEEoIjawSrsi3st5GVeXr//dIdk=;
        b=LEJbjwLsZS/6bOsY2yKZbDDnqTxChq5UMHIMEWIgtmmeNzJ+VBhtTO+sqhWsa1iaizHrxV
        Of5Slj2SDcpFs2BQ==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK
 depends on SMP
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701200056.46555-4-samuel@sholland.org>
References: <20220701200056.46555-4-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165718380494.15455.410881494008665500.tip-bot2@tip-bot2>
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

Commit-ID:     0e6c027c035507abc67b356264a12c49f58c946e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0e6c027c035507abc67b356264a12c49f58c946e
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:00:51 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:38:04 +01:00

genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK depends on SMP

An IRQ's effective affinity can only be different from its configured
affinity if there are multiple CPUs. Make it clear that this option is
only meaningful when SMP is enabled. Most of the relevant code in
irqdesc.c is already hidden behind CONFIG_SMP anyway.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-4-samuel@sholland.org
---
 arch/arm/mach-hisi/Kconfig |  2 +-
 drivers/irqchip/Kconfig    | 14 +++++++-------
 kernel/irq/Kconfig         |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 75cccbd..7b34406 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -40,7 +40,7 @@ config ARCH_HIP04
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	  Support for Hisilicon HiP04 SoC family
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5dd98a8..462adac 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,7 +8,7 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_PM
 	bool
@@ -34,7 +34,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ARM_GIC_V3_ITS
 	bool
@@ -76,7 +76,7 @@ config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI if PCI
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ALPINE_MSI
 	bool
@@ -112,7 +112,7 @@ config BCM6345_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
@@ -120,7 +120,7 @@ config BCM7038_L1_IRQ
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
@@ -179,7 +179,7 @@ config IRQ_MIPS_CPU
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_IPI if SMP && SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config CLPS711X_IRQCHIP
 	bool
@@ -294,7 +294,7 @@ config VERSATILE_FPGA_IRQ_NR
 config XTENSA_MX
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fc760d0..db3d174 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -24,6 +24,7 @@ config GENERIC_IRQ_SHOW_LEVEL
 
 # Supports effective affinity mask
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
+       depends on SMP
        bool
 
 # Support for delayed migration from interrupt context
