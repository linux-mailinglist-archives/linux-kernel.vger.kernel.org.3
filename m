Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05C499BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575464AbiAXVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450006AbiAXVRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:17:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E07C067A6C;
        Mon, 24 Jan 2022 12:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A80EB81239;
        Mon, 24 Jan 2022 20:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEBAC340F0;
        Mon, 24 Jan 2022 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055159;
        bh=YFbjp7SnnvEiZt+2COv/vSHjC8OQzGUpP2h1k/W2R1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZRhLu+xJf8N1IDy93rbW47QecJUpX77o8mQEIOOF7A8eQEBabUQ3kzXWctqC5O+E
         8Cw2scnwPeTHNN56+3im/amP8m2TpqLLiH0HETbMaVCa9XNcrgXisLzs8/PSa/ZDeD
         DXnIXjnCS4hxznqN4IzgUtqdeKS+xG9ylWkmYDBm+aY6GVJVusxMDy/4summ4vUvT1
         w2ClXvyYmsCCAzVp5zN7BADiQyi7ZGljw46Y+Ggpss/eRNkR/NbtwHCql7kn2IVzob
         y9TA8dqerw4krkJYAKNOkgXwNzwDtd9rTFN7RFjGjMh0xLl7sihOzu6sAZZOa84lbF
         dD1Yn/ysEJkxA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hd-002Y3f-4l; Mon, 24 Jan 2022 20:12:37 +0000
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
Subject: [PATCH v4 05/10] irqchip/apple-aic: Wire PMU interrupts
Date:   Mon, 24 Jan 2022 20:12:26 +0000
Message-Id: <20220124201231.298961-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
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
index 2d31ac605573..9daa28c55fa1 100644
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

