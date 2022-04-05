Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045F4F5173
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846343AbiDFCD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573270AbiDESlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C320F58
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA42618DC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506CC385A5;
        Tue,  5 Apr 2022 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649183944;
        bh=Mf37t/W1q2zhLxqc/n4nwa3EUBb+kXfkqvJtsrPMcKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnpevcrnJ2AGbRcedLVdF64TDhd8sWv1AVgExWfU4wjsrr1N6QwNKoTuDmLIl9H2e
         lP28dp6bsdL9ez+Jm4hzDbrxsHvElc4KuXIP1MNNDTvRpqHDANTEJP5CrnfYfsuZEI
         dOHBusJ+pofZUNCj9BckfFiOOaTtWQZMZoL+ncTm7AwGEVWHBNpwZb/5JSeUSkvJzl
         WWJJbvfpY3644p97Nsqqy4yPIEGTbe4xSFgHMRD28pvfQmNeH78jkC3Yci1Ee6faLP
         V5tIJcNHF8yl+CG5SGlgwP1pezkUSZdASyXbLB8S9W/+CS9kjtTVN9ORlOiM79XVoz
         cUl921gWrp1fA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbo50-001tkq-KY; Tue, 05 Apr 2022 19:39:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 3/3] irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP
Date:   Tue,  5 Apr 2022 19:38:57 +0100
Message-Id: <20220405183857.205960-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405183857.205960-1-maz@kernel.org>
References: <20220405183857.205960-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, andre.przywara@arm.com, tglx@linutronix.de, eric.auger@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent work on the KVM GIC emulation has revealed that the GICv3
driver is a bit RWP-happy, as it polls this bit for each and
every write MMIO access involving a single interrupt.

As it turns out, polling RWP is only required when:
- Disabling an SGI, PPI or SPI
- Disabling LPIs at the redistributor level
- Disabling groups
- Enabling ARE
- Dealing with DPG*

Simplify the driver by removing all the other instances of RWP
polling, and add the one that was missing when enabling the distributor
(as that's where we set ARE).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 38 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 4d8517232f1e..93cfd2b1efdd 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -352,28 +352,27 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
-	void (*rwp_wait)(void);
 	void __iomem *base;
 	u32 index, mask;
 
 	offset = convert_offset_index(d, offset, &index);
 	mask = 1 << (index % 32);
 
-	if (gic_irq_in_rdist(d)) {
+	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
-		rwp_wait = gic_redist_wait_for_rwp;
-	} else {
+	else
 		base = gic_data.dist_base;
-		rwp_wait = gic_dist_wait_for_rwp;
-	}
 
 	writel_relaxed(mask, base + offset + (index / 32) * 4);
-	rwp_wait();
 }
 
 static void gic_mask_irq(struct irq_data *d)
 {
 	gic_poke_irq(d, GICD_ICENABLER);
+	if (gic_irq_in_rdist(d))
+		gic_redist_wait_for_rwp();
+	else
+		gic_dist_wait_for_rwp();
 }
 
 static void gic_eoimode1_mask_irq(struct irq_data *d)
@@ -420,7 +419,11 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 		break;
 
 	case IRQCHIP_STATE_MASKED:
-		reg = val ? GICD_ICENABLER : GICD_ISENABLER;
+		if (val) {
+			gic_mask_irq(d);
+			return 0;
+		}
+		reg = GICD_ISENABLER;
 		break;
 
 	default:
@@ -574,7 +577,6 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	enum gic_intid_range range;
 	unsigned int irq = gic_irq(d);
-	void (*rwp_wait)(void);
 	void __iomem *base;
 	u32 offset, index;
 	int ret;
@@ -590,17 +592,14 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	if (gic_irq_in_rdist(d)) {
+	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
-		rwp_wait = gic_redist_wait_for_rwp;
-	} else {
+	else
 		base = gic_data.dist_base;
-		rwp_wait = gic_dist_wait_for_rwp;
-	}
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
-	ret = gic_configure_irq(index, type, base + offset, rwp_wait);
+	ret = gic_configure_irq(index, type, base + offset, NULL);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
@@ -807,8 +806,8 @@ static void __init gic_dist_init(void)
 	for (i = 0; i < GIC_ESPI_NR; i += 4)
 		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
 
-	/* Now do the common stuff, and wait for the distributor to drain */
-	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
+	/* Now do the common stuff */
+	gic_dist_config(base, GIC_LINE_NR, NULL);
 
 	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
 	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
@@ -816,8 +815,9 @@ static void __init gic_dist_init(void)
 		val |= GICD_CTLR_nASSGIreq;
 	}
 
-	/* Enable distributor with ARE, Group1 */
+	/* Enable distributor with ARE, Group1, and wait for it to drain */
 	writel_relaxed(val, base + GICD_CTLR);
+	gic_dist_wait_for_rwp();
 
 	/*
 	 * Set all global interrupts to the boot CPU only. ARE must be
@@ -1298,8 +1298,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	 */
 	if (enabled)
 		gic_unmask_irq(d);
-	else
-		gic_dist_wait_for_rwp();
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
2.34.1

