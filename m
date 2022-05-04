Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5451A37F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbiEDPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352062AbiEDPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:19:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3219C0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:15:37 -0700 (PDT)
Date:   Wed, 04 May 2022 15:15:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651677336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tQ2JT09/XLdjvRDwIz8c1xien+ZU4hYMIiu5EaQdR4=;
        b=KdnVZuv1MMA1BJsTv8m6eZnUfaQfrGq8zGBNp54P0SUy3USkuBSw2RBh0votLGIIan1/Oz
        ffo23P/YAikLEBknG5NB2naHEHTGrklOeT8BzNb79oaBI4IOLR3xC6/ufLN/xHojihBaKH
        nTtOoWJypN78/TWQUp7ILF/F+obXvEjHMmkpJBTj3oS+AIf7fTUVOISEqEQe8wdkC2YF1v
        9IssH+80VXIP+PdJb1V6kFUqc8gei3M+37jMBm+0ABdPhgRMx3YMpXSU0u4RelsGImaBek
        wLVZedi1GbXVax9AWiVcUQF87sbjib7ay0TuwgqicQjIl4y/8J5fhHlX9UlU0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651677336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tQ2JT09/XLdjvRDwIz8c1xien+ZU4hYMIiu5EaQdR4=;
        b=RLpc0eoHy5lmvhKKGj5BZVc1TjoS9JOzrcGK8hjmVsK57up2EMAyJ+BekeWDfgbiOQeLfp
        /Zq3tx5CbwE2nkBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Relax polling of
 GIC{R,D}_CTLR.RWP
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220405183857.205960-4-maz@kernel.org>
References: <20220405183857.205960-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165167733533.4207.6753839602204006581.tip-bot2@tip-bot2>
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

Commit-ID:     63f13483f0689a4de20fbfd847866ab39bec736f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/63f13483f0689a4de20fbfd847866ab39bec736f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 05 Apr 2022 19:38:57 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 15:38:55 +01:00

irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP

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
Link: https://lore.kernel.org/r/20220405183857.205960-4-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 38 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f98651e..b802684 100644
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
 
