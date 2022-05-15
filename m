Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0252789B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiEOP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiEOP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:57:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001413F89
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:57:23 -0700 (PDT)
Date:   Sun, 15 May 2022 15:57:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652630241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxSXahR5wTt/NUiqNGGcxad9XNn2eeoX+fkjOeuZ0WU=;
        b=HziaTTS9D3Nyv6M/YjVeoUDZhNMANw4mBiotjsYYliWvF96WWxmfejIv6C0HVnbFeHQg+z
        bcdNAb8/pTzsYZnWyVfpOWmzYO4YhmpDLp7uowp7KqYqN/ZYYKcpUGymOAUMed7x65dJ2u
        R+XVulv6PzCOm7uoJFQxw7SeMKbdTW+MJnV59t8j4saOM+gC3URQta1BRfO1KU0Fv0MNdP
        a1XhMxhTIEoQtdYIUwb4umdpARQDEH+Nk5tXYVJ7rhWCA4iASqpJEZ9WHZsVECrrwv9uFW
        9MJCt04GCscdXVkEU6BTg2tecxWXvjw1GKuGW/mpfJmlYLu1TAlxjCC/8wZhKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652630241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxSXahR5wTt/NUiqNGGcxad9XNn2eeoX+fkjOeuZ0WU=;
        b=LD+nhkwgMeqf6+PGuDBChjcAvWauledYXUk6QsgneO4L/FLmPfx3EoO7KtlIlkgmceoMCn
        oMHIiZfwIliD34AQ==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Refactor ISB + EOIR at ack time
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
In-Reply-To: <20220513133038.226182-3-mark.rutland@arm.com>
References: <20220513133038.226182-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <165263024034.4207.709104940680227234.tip-bot2@tip-bot2>
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

Commit-ID:     6efb50923771f392122f5ce69dfc43b08f16e449
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6efb50923771f392122f5ce69dfc43b08f16e449
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 13 May 2022 14:30:37 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 15 May 2022 16:38:25 +01:00

irqchip/gic-v3: Refactor ISB + EOIR at ack time

There are cases where a context synchronization event is necessary
between an IRQ being raised and being handled, and there are races such
that we cannot rely upon the exception entry being subsequent to the
interrupt being raised. To fix this, we place an ISB between a read of
IAR and the subsequent invocation of an IRQ handler.

When EOI mode 1 is in use, we need to EOI an interrupt prior to invoking
its handler, and we have a write to EOIR for this. As this write to EOIR
requires an ISB, and this is provided by the gic_write_eoir() helper, we
omit the usual ISB in this case, with the logic being:

|	if (static_branch_likely(&supports_deactivate_key))
|		gic_write_eoir(irqnr);
|	else
|		isb();

This is somewhat opaque, and it would be a little clearer if there were
an unconditional ISB, with only the write to EOIR being conditional,
e.g.

|	if (static_branch_likely(&supports_deactivate_key))
|		write_gicreg(irqnr, ICC_EOIR1_EL1);
|
|	isb();

This patch rewrites the code that way, with this logic factored into a
new helper function with comments explaining what the ISB is for, as
were originally laid out in commit:

  39a06b67c2c1256b ("irqchip/gic: Ensure we have an ISB between ack and ->handle_irq")

Note that since then, we removed the IAR polling in commit:

  342677d70ab92142 ("irqchip/gic-v3: Remove acknowledge loop")

... which removed one of the two race conditions.

For consistency, other portions of the driver are made to manipulate
EOIR using write_gicreg() and explcit ISBs, and the gic_write_eoir()
helper function is removed.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220513133038.226182-3-mark.rutland@arm.com
---
 arch/arm/include/asm/arch_gicv3.h   |  7 +-----
 arch/arm64/include/asm/arch_gicv3.h |  6 +----
 drivers/irqchip/irq-gic-v3.c        | 43 +++++++++++++++++++++-------
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 413abfb..f82a819 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -48,6 +48,7 @@ static inline u32 read_ ## a64(void)		\
 	return read_sysreg(a32); 		\
 }						\
 
+CPUIF_MAP(ICC_EOIR1, ICC_EOIR1_EL1)
 CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
 CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
 CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
@@ -63,12 +64,6 @@ CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
 
 /* Low-level accessors */
 
-static inline void gic_write_eoir(u32 irq)
-{
-	write_sysreg(irq, ICC_EOIR1);
-	isb();
-}
-
 static inline void gic_write_dir(u32 val)
 {
 	write_sysreg(val, ICC_DIR);
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 8bd5afc..48d4473 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -26,12 +26,6 @@
  * sets the GP register's most significant bits to 0 with an explicit cast.
  */
 
-static inline void gic_write_eoir(u32 irq)
-{
-	write_sysreg_s(irq, SYS_ICC_EOIR1_EL1);
-	isb();
-}
-
 static __always_inline void gic_write_dir(u32 irq)
 {
 	write_sysreg_s(irq, SYS_ICC_DIR_EL1);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7305d84..0cbc4e2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -556,7 +556,8 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	gic_write_eoir(gic_irq(d));
+	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
+	isb();
 }
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
@@ -640,10 +641,38 @@ static void gic_deactivate_unhandled(u32 irqnr)
 		if (irqnr < 8192)
 			gic_write_dir(irqnr);
 	} else {
-		gic_write_eoir(irqnr);
+		write_gicreg(irqnr, ICC_EOIR1_EL1);
+		isb();
 	}
 }
 
+/*
+ * Follow a read of the IAR with any HW maintenance that needs to happen prior
+ * to invoking the relevant IRQ handler. We must do two things:
+ *
+ * (1) Ensure instruction ordering between a read of IAR and subsequent
+ *     instructions in the IRQ handler using an ISB.
+ *
+ *     It is possible for the IAR to report an IRQ which was signalled *after*
+ *     the CPU took an IRQ exception as multiple interrupts can race to be
+ *     recognized by the GIC, earlier interrupts could be withdrawn, and/or
+ *     later interrupts could be prioritized by the GIC.
+ *
+ *     For devices which are tightly coupled to the CPU, such as PMUs, a
+ *     context synchronization event is necessary to ensure that system
+ *     register state is not stale, as these may have been indirectly written
+ *     *after* exception entry.
+ *
+ * (2) Deactivate the interrupt when EOI mode 1 is in use.
+ */
+static inline void gic_complete_ack(u32 irqnr)
+{
+	if (static_branch_likely(&supports_deactivate_key))
+		write_gicreg(irqnr, ICC_EOIR1_EL1);
+
+	isb();
+}
+
 static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 {
 	bool irqs_enabled = interrupts_enabled(regs);
@@ -652,10 +681,7 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 	if (irqs_enabled)
 		nmi_enter();
 
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
-	else
-		isb()
+	gic_complete_ack(irqnr);
 
 	/*
 	 * Leave the PSR.I bit set to prevent other NMIs to be
@@ -726,10 +752,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		gic_arch_enable_irqs();
 	}
 
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
-	else
-		isb();
+	gic_complete_ack(irqnr);
 
 	if (generic_handle_domain_irq(gic_data.domain, irqnr)) {
 		WARN_ONCE(true, "Unexpected interrupt received!\n");
