Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BFF4DA076
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiCOQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350213AbiCOQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3625715E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9682BB81802
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452F9C340F5;
        Tue, 15 Mar 2022 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363043;
        bh=xhdjH/t9SclaiYQ8bmgF90cNseOgXjX/v15wc5UmvGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIrhDTk5zYaHoLojixfhOvB5k7Z+il885Q2CzsDI9Q1J/e1nhwfurdh5+BlUD7At1
         EzanIHegv0MDssYkOtfyf9eXZ3Z8xyfGLDCpQT1WymMJnim82AGcJnfcH6LaFslUSi
         4qwc4fRYo2tx3jeD79Bv+qzC2wmHMgpnCkpu+IV1carWCZMYihgRIuSxNyXaLWneKB
         PXHletRfc/KdrlEe6ICCaZUZr82rn+P6qrgorjeIOx+SNiPRyYVs+0Di5IAY2WTGTd
         kgXU6jQRToK+WOdVxd98i/Uh9e0Oelqx9ehF/O3zb6pb6Tv2mq6l+vO05Zt2brEGs+
         59TfMsDPV/b8w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUANd-00EhkO-6w; Tue, 15 Mar 2022 16:50:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 2/3] irqchip/gic-v3: Detect LPI invalidation MMIO registers
Date:   Tue, 15 Mar 2022 16:50:33 +0000
Message-Id: <20220315165034.794482-3-maz@kernel.org>
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

Since GICv4.1, an implementation can offer the same MMIO-based
implementation as DirectLPI, only with an ITS. Given that this
can be hugely beneficial for workloads that are very LPI masking
heavy (although these workloads are admitedly a bit odd).

Interestingly, this is independent of RVPEI, which only *implies*
the functionnality.

So let's detect whether the implementation has GICR_CTLR.IR set,
and propagate this as DirectLPI to the ITS driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 15 +++++++++++----
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 736163d36b13..363bfe172033 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -918,7 +918,11 @@ static int gic_populate_rdist(void)
 static int __gic_update_rdist_properties(struct redist_region *region,
 					 void __iomem *ptr)
 {
-	u64 typer = gic_read_typer(ptr + GICR_TYPER);
+	u64 typer;
+	u32 ctlr;
+
+	typer = gic_read_typer(ptr + GICR_TYPER);
+	ctlr = readl_relaxed(ptr + GICR_CTLR);
 
 	/* Boot-time cleanip */
 	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
@@ -941,6 +945,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
 	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
 	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
+					   !!(ctlr & GICR_CTLR_IR) |
 					   gic_data.rdists.has_rvpeid);
 	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
 
@@ -962,7 +967,11 @@ static void gic_update_rdist_properties(void)
 	gic_iterate_rdists(__gic_update_rdist_properties);
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
-	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
+	pr_info("GICv3 features: %d PPIs, %s%s\n",
+		gic_data.ppi_nr,
+		gic_data.has_rss ? "RSS " : "",
+		gic_data.rdists.has_direct_lpi ? "DirectLPI " : "");
+	
 	if (gic_data.rdists.has_vlpis)
 		pr_info("GICv4 features: %s%s%s\n",
 			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
@@ -1797,8 +1806,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 
 	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
-	pr_info("Distributor has %sRange Selector support\n",
-		gic_data.has_rss ? "" : "no ");
 
 	if (typer & GICD_TYPER_MBIS) {
 		err = mbi_init(handle, gic_data.domain);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 12d91f0dedf9..aeb8ced53880 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -127,6 +127,8 @@
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_IR			(1UL << 1)
+#define GICR_CTLR_CES			(1UL << 2)
 #define GICR_CTLR_RWP			(1UL << 3)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
-- 
2.34.1

