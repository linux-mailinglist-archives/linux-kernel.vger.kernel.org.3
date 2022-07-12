Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D29572069
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiGLQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiGLQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:09:45 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11EBA176
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:09:41 -0700 (PDT)
Received: from localhost.localdomain (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id EB5681F65E;
        Tue, 12 Jul 2022 18:09:33 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Date:   Tue, 12 Jul 2022 18:09:19 +0200
Message-Id: <20220712160919.740878-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712160919.740878-1-konrad.dybcio@somainline.org>
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for A7-A11 SoCs by if-ing out some features only present on
A12 & newer (UNCORE2 registers) or M1 & newer (EL2 registers - the
older SoCs don't implement EL2).

Also, annotate IPI regs support (A11 and newer*) so that the driver can
tell whether the SoC supports these (they are written to even if fast
IPI is disabled, when the registers are there of course).

*A11 is supposed to use this feature, but it is currently not working.
That said, it is not yet necessary, especially with only one core up,
and it works a-ok using the same featureset as earlier SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/irqchip/irq-apple-aic.c | 54 +++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 12dd48727a15..36f4b52addc2 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -245,7 +245,10 @@ struct aic_info {
 	u32 die_stride;
 
 	/* Features */
+	bool el2_regs;
 	bool fast_ipi;
+	bool ipi_regs;
+	bool uncore2_regs;
 };
 
 static const struct aic_info aic1_info = {
@@ -261,7 +264,10 @@ static const struct aic_info aic1_fipi_info = {
 	.event		= AIC_EVENT,
 	.target_cpu	= AIC_TARGET_CPU,
 
+	.el2_regs	= true,
 	.fast_ipi	= true,
+	.ipi_regs	= true,
+	.uncore2_regs	= true,
 };
 
 static const struct aic_info aic2_info = {
@@ -269,7 +275,10 @@ static const struct aic_info aic2_info = {
 
 	.irq_cfg	= AIC2_IRQ_CFG,
 
+	.el2_regs	= true,
 	.fast_ipi	= true,
+	.ipi_regs	= true,
+	.uncore2_regs	= true,
 };
 
 static const struct of_device_id aic_info_match[] = {
@@ -452,6 +461,9 @@ static unsigned long aic_fiq_get_idx(struct irq_data *d)
 
 static void aic_fiq_set_mask(struct irq_data *d)
 {
+	if (!aic_irqc->info.el2_regs)
+		return;
+
 	/* Only the guest timers have real mask bits, unfortunately. */
 	switch (aic_fiq_get_idx(d)) {
 	case AIC_TMR_EL02_PHYS:
@@ -469,6 +481,9 @@ static void aic_fiq_set_mask(struct irq_data *d)
 
 static void aic_fiq_clear_mask(struct irq_data *d)
 {
+	if (!aic_irqc->info.el2_regs)
+		return;
+
 	switch (aic_fiq_get_idx(d)) {
 	case AIC_TMR_EL02_PHYS:
 		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, 0, VM_TMR_FIQ_ENABLE_P);
@@ -524,12 +539,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
 
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (aic_irqc->info.ipi_regs) {
+		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
+			if (static_branch_likely(&use_fast_ipi)) {
+				aic_handle_ipi(regs);
+			} else {
+				pr_err_ratelimited("Fast IPI fired. Acking.\n");
+				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+			}
 		}
 	}
 
@@ -566,12 +583,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 					  AIC_FIQ_HWIRQ(irq));
 	}
 
-	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
-			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
-		/* Same story with uncore PMCs */
-		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
-		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (aic_irqc->info.uncore2_regs) {
+		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
+				(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
+			/* Same story with uncore PMCs */
+			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
+			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+		}
 	}
 }
 
@@ -676,7 +695,8 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 				break;
 			case AIC_TMR_HV_PHYS:
 			case AIC_TMR_HV_VIRT:
-				return -ENOENT;
+				if (aic_irqc->info.el2_regs)
+					return -ENOENT;
 			default:
 				break;
 			}
@@ -944,7 +964,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (aic_irqc->info.ipi_regs)
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -965,8 +986,9 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
 
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (aic_irqc->info.uncore2_regs)
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
 
 	/* Commit all of the above */
 	isb();
-- 
2.37.0

