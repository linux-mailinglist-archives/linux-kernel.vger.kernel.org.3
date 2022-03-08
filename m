Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BA4D1E02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348606AbiCHQ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbiCHQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238652B1A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:46 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ODhEmTujSC3WrE5hr456h/CgBdnCvhwC8mQfoBypWkc=;
        b=u13Wi+tNl34UDNL1P/BhpOOCaJpHs80hSJjy7u1FFeBqdJl+OV3m0GH9s0vJWXRkqlOsR4
        RDQG3dNVG5nP9chuhClU1AXAHQC0Ny7OlAD+712dsOqTUpMdwa9xkQJyFwMShIL23IPvup
        0q58DiJaKGGhi5s6ZFq73MqhDp5Jmb97AsEgthsLSjF6IWKzD2kt3w6k6guWj8NEUk/BbZ
        6KXUuCOuVQIMtNT16eCaixmJlhYzcZtpGRAEl29NvOSCellX5h1O3BC18bV8Z+x34O8dye
        vFp+UClGD12siTZm36Enxw9+kIzGzERdl8YLrWqvAdoyw3Fi646Lm6IAVhGhxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ODhEmTujSC3WrE5hr456h/CgBdnCvhwC8mQfoBypWkc=;
        b=3MJxiwLUwbxFvF9EREcL6J0Tw+NSwoYyWBJX7pw6m0zaHxxRYLEVUZfYFMmGxsDO0hdITL
        PeKNm4fagX9ZTlDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Parse FIQ affinities
 from device-tree
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860397.16921.6473572713227692309.tip-bot2@tip-bot2>
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

Commit-ID:     a5e8801202b318622ea526aa5625e5f7eceb4d26
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a5e8801202b318622ea526aa5625e5f7eceb4d26
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 03 Nov 2021 13:35:25 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:42 

irqchip/apple-aic: Parse FIQ affinities from device-tree

In order to be able to tell the core IRQ code about the affinity
of the PMU interrupt in later patches, parse the affinities kindly
provided in the device-tree.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 49 ++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 38091eb..22d9b20 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -177,6 +177,9 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
+	struct {
+		cpumask_t aff;
+	} *fiq_aff[AIC_NR_FIQ];
 	int nr_hw;
 };
 
@@ -793,12 +796,50 @@ static struct gic_kvm_info vgic_info __initdata = {
 	.no_hw_deactivation	= true,
 };
 
+static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
+{
+	int i, n;
+	u32 fiq;
+
+	if (of_property_read_u32(aff, "apple,fiq-index", &fiq) ||
+	    WARN_ON(fiq >= AIC_NR_FIQ) || ic->fiq_aff[fiq])
+		return;
+
+	n = of_property_count_elems_of_size(aff, "cpus", sizeof(u32));
+	if (WARN_ON(n < 0))
+		return;
+
+	ic->fiq_aff[fiq] = kzalloc(sizeof(ic->fiq_aff[fiq]), GFP_KERNEL);
+	if (!ic->fiq_aff[fiq])
+		return;
+
+	for (i = 0; i < n; i++) {
+		struct device_node *cpu_node;
+		u32 cpu_phandle;
+		int cpu;
+
+		if (of_property_read_u32_index(aff, "cpus", i, &cpu_phandle))
+			continue;
+
+		cpu_node = of_find_node_by_phandle(cpu_phandle);
+		if (WARN_ON(!cpu_node))
+			continue;
+
+		cpu = of_cpu_node_to_id(cpu_node);
+		if (WARN_ON(cpu < 0))
+			continue;
+
+		cpumask_set_cpu(cpu, &ic->fiq_aff[fiq]->aff);
+	}
+}
+
 static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
 {
 	int i;
 	void __iomem *regs;
 	u32 info;
 	struct aic_irq_chip *irqc;
+	struct device_node *affs;
 
 	regs = of_iomap(node, 0);
 	if (WARN_ON(!regs))
@@ -832,6 +873,14 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		return -ENODEV;
 	}
 
+	affs = of_get_child_by_name(node, "affinities");
+	if (affs) {
+		struct device_node *chld;
+
+		for_each_child_of_node(affs, chld)
+			build_fiq_affinity(irqc, chld);
+	}
+
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
 
