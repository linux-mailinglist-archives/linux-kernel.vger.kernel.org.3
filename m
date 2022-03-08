Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9DC4D1E01
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbiCHQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiCHQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586034EF56
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:45 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=06FSlG+KOa8czlggLmWl29rLkXxkfQf47l6OaWUOSpk=;
        b=p6RJJ9cOOSYiN96493dsNycAu3I49cOar3kM47DeKgbHXceTGc1fjvfR6AZzGgrAKye8SI
        gpptMFhD0umd4GAMj7Vpg+FvgDMtCpj62N0VwgGD1K50KCriJSx1JA5qSQ55RqqnLwvc9W
        jbtHdLPHjF50a97R54A0TM0dz7RGo4N8FGvwfqNbbLv/X+bDVa9THP3X3+iHfLwCgNDEyk
        SQKht8I3xGS+wS7LW//rE5/C2eDtiNIEKee5R+yEvjGL4szA8XltgJg8DQI3hs/7GPm3Ag
        w01skjYfkfYyMUak8RZF46NPYaUPpMlT0//AiciFWT52W+SqBuhD9jqNcZk4Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=06FSlG+KOa8czlggLmWl29rLkXxkfQf47l6OaWUOSpk=;
        b=urDvw6X5qGTmHyXgKsRS+60PIz78v/MjR4837HeB8AHi6Qk2uw6qyc0g973tNvWPX7Kudy
        gJYpT4NV47o0iFBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Wire PMU interrupts
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860293.16921.8859400353687189360.tip-bot2@tip-bot2>
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

Commit-ID:     c7708816c9442beb32488e07b0fb47b6f66577cb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c7708816c9442beb32488e07b0fb47b6f66577cb
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 01 Nov 2021 19:59:20 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:42 

irqchip/apple-aic: Wire PMU interrupts

Add the necessary code to configure and P and E-core PMU interrupts
with their respective affinities. When such an interrupt fires, map
it onto the right pseudo-interrupt.

Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 34 ++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 22d9b20..873544e 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -155,7 +155,7 @@
 #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
 #define UPMSR_IACT			BIT(0)
 
-#define AIC_NR_FIQ		4
+#define AIC_NR_FIQ		6
 #define AIC_NR_SWIPI		32
 
 /*
@@ -415,16 +415,15 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 						  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT);
 	}
 
-	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
-			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
-		/*
-		 * Not supported yet, let's figure out how to handle this when
-		 * we implement these proprietary performance counters. For now,
-		 * just mask it and move on.
-		 */
-		pr_err_ratelimited("PMC FIQ fired. Masking.\n");
-		sysreg_clear_set_s(SYS_IMP_APL_PMCR0_EL1, PMCR0_IMODE | PMCR0_IACT,
-				   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
+	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+		int irq;
+		if (cpumask_test_cpu(smp_processor_id(),
+				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))
+			irq = AIC_CPU_PMU_P;
+		else
+			irq = AIC_CPU_PMU_E;
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  aic_irqc->nr_hw + irq);
 	}
 
 	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
@@ -464,7 +463,18 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else {
-		irq_set_percpu_devid(irq);
+		int fiq = hw - ic->nr_hw;
+
+		switch (fiq) {
+		case AIC_CPU_PMU_P:
+		case AIC_CPU_PMU_E:
+			irq_set_percpu_devid_partition(irq, &ic->fiq_aff[fiq]->aff);
+			break;
+		default:
+			irq_set_percpu_devid(irq);
+			break;
+		}
+
 		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 	}
