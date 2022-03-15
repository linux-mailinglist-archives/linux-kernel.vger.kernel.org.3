Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A184DA072
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbiCOQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350211AbiCOQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD7517D0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87EB9B8122D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACD9C340F6;
        Tue, 15 Mar 2022 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363043;
        bh=QZZYi5QmeQzKihh20U0K1CiBaYfurFjvlWB0iX29PWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/uqp3zcxOehHaa7hoOUopBn2FCbFcxG3GCi/ZnPLrRhDkCenlnMolZuTRkr9VUXg
         VfgHfdnzwqA1VCpUuHdZE4fO3Op4e4ePrEdnFvLB91/kCH5xtcm++Q8fc25A4mMTcJ
         btwcQrDIAxZu36mYtCd748A+jCQCj36dYjkzRoe9O6uJbc+ZfIZ8FCL2UkSpTEpttH
         G5M1ndAZxNAeqcuJI5KFnqOHHbGToOixEi7kEMnP9+DaNCABthU9ZEP3vza64dJIYw
         ZGen5bKX4l+WqSDa5YA9h1kWr4LsxTf6smZa2E6p0lwlsTsyKkyKCcxPjSqaQ8jSDt
         ADsnWHFr/WhPQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUANd-00EhkO-Cm; Tue, 15 Mar 2022 16:50:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 3/3] irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP
Date:   Tue, 15 Mar 2022 16:50:34 +0000
Message-Id: <20220315165034.794482-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220315165034.794482-1-maz@kernel.org>
References: <20220315165034.794482-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, andre.przywara@arm.com, tglx@linutronix.de, eric.auger@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/irqchip/irq-gic-v3.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 363bfe172033..05ff7fef64cb 100644
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
@@ -574,7 +573,6 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	enum gic_intid_range range;
 	unsigned int irq = gic_irq(d);
-	void (*rwp_wait)(void);
 	void __iomem *base;
 	u32 offset, index;
 	int ret;
@@ -590,17 +588,14 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
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
@@ -808,7 +803,7 @@ static void __init gic_dist_init(void)
 		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
 
 	/* Now do the common stuff, and wait for the distributor to drain */
-	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
+	gic_dist_config(base, GIC_LINE_NR, NULL);
 
 	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
 	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
@@ -818,6 +813,7 @@ static void __init gic_dist_init(void)
 
 	/* Enable distributor with ARE, Group1 */
 	writel_relaxed(val, base + GICD_CTLR);
+	gic_dist_wait_for_rwp();
 
 	/*
 	 * Set all global interrupts to the boot CPU only. ARE must be
@@ -1293,8 +1289,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	 */
 	if (enabled)
 		gic_unmask_irq(d);
-	else
-		gic_dist_wait_for_rwp();
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
2.34.1

