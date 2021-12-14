Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999C4474ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhLNS1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhLNS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC612C06173F;
        Tue, 14 Dec 2021 10:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97629B81C56;
        Tue, 14 Dec 2021 18:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A8DC34608;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506421;
        bh=3aBHYeWafiwyES+3xn9qPYPeERgfXUbEtFnNZdNXqtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9f80Jlq05KkARDjaSnvb4vS1TjG08u/5Q2lTswAbFnK0EoyJ8G2GSzaJeBo76s0F
         0Ux2CEA3hk7SvbzOTDA/vrtsxNuskHTtoyESBgn5iSFFA3KqmKoFEMfnxLtL0Fz4rY
         aUjvRy5CHsLVWDNco20AH2nbp5dU5V1lJshlqjirE3ORctvd4fLFqOj82ygpkLUp+r
         UAkwBCNxKSLBFOyzmalDU7SRch65jotG51f41xw8lNiXoqtNWgX14jkXeXFQyOsdrj
         cNnoyG60Vie3TnQfLBQ7dHgoIioW1f+pwcM6+aTNacpTerJ/E/UaOsQuy23NzCsMJA
         kdqQArBc1WHXg==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVv-00C7Tq-Gi; Tue, 14 Dec 2021 18:26:59 +0000
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
Subject: [PATCH v3 05/10] irqchip/apple-aic: Wire PMU interrupts
Date:   Tue, 14 Dec 2021 18:26:29 +0000
Message-Id: <20211214182634.727330-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214182634.727330-1-maz@kernel.org>
References: <20211214182634.727330-1-maz@kernel.org>
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

Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index b51eb9468701..ceb7a68101e1 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -155,7 +155,7 @@
 #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
 #define UPMSR_IACT			BIT(0)
 
-#define AIC_NR_FIQ		4
+#define AIC_NR_FIQ		6
 #define AIC_NR_SWIPI		32
 
 /*
@@ -416,16 +416,15 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
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
@@ -465,7 +464,18 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
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
-- 
2.30.2

