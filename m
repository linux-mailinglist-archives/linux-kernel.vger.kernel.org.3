Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982CB51A385
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbiEDPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352067AbiEDPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:19:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E52228E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:15:38 -0700 (PDT)
Date:   Wed, 04 May 2022 15:15:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651677337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpDHPKG2vy1NwdO1Fvbhcfs3wbgBmuiDUKgBAk+wPmY=;
        b=qrr6J/k8dGH+lGGF6SGpubHYeQ2FIpO0P4fZ8dv94Rhwcv/Mpp5z69+rWETfpDF7E824IW
        jt7miNJ9W0ufvRX1RKa1qL8I2c/tFixMsglzwFKt/frJRxbGKDXRius1F+QflyDErR6jwi
        HSI3V44W2SsAOGQgtT2FtwP+UbJ52zgQOGVhLVFBulvfETLkUjesaxJFz99bjcGRiLDQHF
        85JtgXYAu2V2XFB1gMCvkajAdUQlgLVJVructHxb3mkjsrA3pcWqCMaO+RA5phHa19OMvj
        SNNUdlK5hg4ejPgMJBJzcfgvRrFLQwl6Nx8FbjqyKL0LzdLBE+lZyxDYHgs9Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651677337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpDHPKG2vy1NwdO1Fvbhcfs3wbgBmuiDUKgBAk+wPmY=;
        b=FfzEJi0Zn4LLUjnekAWLhsdbIs1XakWd5ws4yUlP9P/nHHrUlwKhn94Ldix99tgGiI3AXD
        f6T4VSbg9Y8AcHBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Detect LPI invalidation
 MMIO registers
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220405183857.205960-3-maz@kernel.org>
References: <20220405183857.205960-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165167733627.4207.16018760009857162875.tip-bot2@tip-bot2>
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

Commit-ID:     a837ed362e7070d48b6064138d3b61eb75eb9fd9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a837ed362e7070d48b6064138d3b61eb75eb9fd9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 05 Apr 2022 19:38:56 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 15:38:55 +01:00

irqchip/gic-v3: Detect LPI invalidation MMIO registers

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
Link: https://lore.kernel.org/r/20220405183857.205960-3-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b252d55..f98651e 100644
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
@@ -1803,8 +1817,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 
 	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
-	pr_info("Distributor has %sRange Selector support\n",
-		gic_data.has_rss ? "" : "no ");
 
 	if (typer & GICD_TYPER_MBIS) {
 		err = mbi_init(handle, gic_data.domain);
