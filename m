Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35663464F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349753AbhLANxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349660AbhLANxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49297C0613D7;
        Wed,  1 Dec 2021 05:49:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F423CE1EC5;
        Wed,  1 Dec 2021 13:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7D7C58319;
        Wed,  1 Dec 2021 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366561;
        bh=8XSLpCyO2Dr3aC33MGUIooo50wK/EjNm/5jTa24ed54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HThpdllcFRje8aH4uA62WBzj2mzFaovp+oY+I1qEnYAonqgpOuYyl3ICq2HolFBFM
         SP20Bn90qQmSp44L8gr+8M+uhQd0RvdfWV0iKFCD9ZqV+QH71vnYPW4INV6n97yP5G
         j8DsK8L/bgUt9e1J1lJeztYWLiWsyinnyPmVEfFW7KXJlo+HRQsuME3sUYZwjyFNSh
         A1OS6GMinzf4gj7npz+5pNtgGlY1en0bgUZSfI420Zpi69KJW6brSNU26cKNa+IEe0
         e7MJGLi25heu8O3u3Q8FPQHVMWfiPT7fRyvY2MfnzrVJkv86Ipx8iRC7ANx4/EjLlM
         zAFr8yMi7SbVg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msPz5-0098G7-OU; Wed, 01 Dec 2021 13:49:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v2 4/8] irqchip/apple-aic: Wire PMU interrupts
Date:   Wed,  1 Dec 2021 13:49:05 +0000
Message-Id: <20211201134909.390490-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201134909.390490-1-maz@kernel.org>
References: <20211201134909.390490-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary code to configure and P and E-core PMU interrupts
with their respective affinities. When such an interrupt fires, map
it onto the right pseudo-interrupt.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 30ca80ccda8b..23f5f10e974e 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -155,7 +155,7 @@
 #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
 #define UPMSR_IACT			BIT(0)
 
-#define AIC_NR_FIQ		4
+#define AIC_NR_FIQ		6
 #define AIC_NR_SWIPI		32
 
 /*
@@ -207,6 +207,11 @@ static bool __is_pcore(u64 mpidr)
 	return MPIDR_AFFINITY_LEVEL(mpidr, 2) == 1;
 }
 
+static bool is_pcore(void)
+{
+	return __is_pcore(read_cpuid_mpidr());
+}
+
 /*
  * IRQ irqchip
  */
@@ -420,16 +425,10 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
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
+		int irq = is_pcore() ? AIC_CPU_PMU_P : AIC_CPU_PMU_E;
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  aic_irqc->nr_hw + irq);
 	}
 
 	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
@@ -469,7 +468,18 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else {
-		irq_set_percpu_devid(irq);
+		switch (hw - ic->nr_hw) {
+		case AIC_CPU_PMU_P:
+			irq_set_percpu_devid_partition(irq, &ic->pcore_mask);
+			break;
+		case AIC_CPU_PMU_E:
+			irq_set_percpu_devid_partition(irq, &ic->ecore_mask);
+			break;
+		default:
+			irq_set_percpu_devid(irq);
+			break;
+		}
+
 		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 	}
-- 
2.30.2

