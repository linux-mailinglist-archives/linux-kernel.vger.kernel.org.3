Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061424F4F99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838726AbiDFA4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573269AbiDESlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848B20BEF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34DC3618D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF6DC385A1;
        Tue,  5 Apr 2022 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649183944;
        bh=YINtmfTLrtIkESCqMaszau4vpZeKcCuTh9FLwNMrA9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4ia9nAZLyBw36K8gMDvcjYTjFJeMJB8dxuZ+h2NiUNDSRvtJAtuJpEFt6FVMB0il
         H3se+4jn2KzM6dycekuoXB2uV/pcCrsAeNESTlnrcvem82qc2o7TSLc/vOj/cjmdKb
         ib/a/iruIVYL3qZ45UT8kp6GhlUjprNi7RG/07e6S4hlWc9fLMU3ucJ3LacWOGHP5c
         sHFkc6j9oPSkcb2Z7ISJ237XBRv+X9myzzxuvhsHN8/d3HXpGGe+IVwcXb7KdHQt7S
         p1Cxm/KVGXYsgjZ4R0y4ITMUYWr2lU+PGzsyd+U77uP1YpydUDkd+vnh/ORIlVJdVr
         UlnHL9w1EoqHQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbo50-001tkq-F6; Tue, 05 Apr 2022 19:39:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 2/3] irqchip/gic-v3: Detect LPI invalidation MMIO registers
Date:   Tue,  5 Apr 2022 19:38:56 +0100
Message-Id: <20220405183857.205960-3-maz@kernel.org>
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

Since GICv4.1, an implementation can offer the same MMIO-based
implementation as DirectLPI, only with an ITS. Given that this
can be hugely beneficial for workloads that are very LPI masking
heavy (although these workloads are admitedly a bit odd).

Interestingly, this is independent of RVPEI, which only *implies*
the functionnality.

So let's detect whether the implementation has GICR_CTLR.IR set,
and propagate this as DirectLPI to the ITS driver.

While we're at it, repaint the GICv3 banner so that we advertise
the various capabilities at boot time to be slightly less invasive.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0efe1a9a9f3b..4d8517232f1e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -919,6 +919,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 					 void __iomem *ptr)
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
+	u32 ctlr = readl_relaxed(ptr + GICR_CTLR);
 
 	/* Boot-time cleanip */
 	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
@@ -938,9 +939,18 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
 
-	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
+	/*
+	 * TYPER.RVPEID implies some form of DirectLPI, no matter what the
+	 * doc says... :-/ And CTLR.IR implies another subset of DirectLPI
+	 * that the ITS driver can make use of for LPIs (and not VLPIs).
+	 *
+	 * These are 3 different ways to express the same thing, depending
+	 * on the revision of the architecture and its relaxations over
+	 * time. Just group them under the 'direct_lpi' banner.
+	 */
 	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
 	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
+					   !!(ctlr & GICR_CTLR_IR) |
 					   gic_data.rdists.has_rvpeid);
 	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
 
@@ -962,7 +972,11 @@ static void gic_update_rdist_properties(void)
 	gic_iterate_rdists(__gic_update_rdist_properties);
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
-	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
+	pr_info("GICv3 features: %d PPIs%s%s\n",
+		gic_data.ppi_nr,
+		gic_data.has_rss ? ", RSS" : "",
+		gic_data.rdists.has_direct_lpi ? ", DirectLPI" : "");
+	
 	if (gic_data.rdists.has_vlpis)
 		pr_info("GICv4 features: %s%s%s\n",
 			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
@@ -1797,8 +1811,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 
 	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
-	pr_info("Distributor has %sRange Selector support\n",
-		gic_data.has_rss ? "" : "no ");
 
 	if (typer & GICD_TYPER_MBIS) {
 		err = mbi_init(handle, gic_data.domain);
-- 
2.34.1

