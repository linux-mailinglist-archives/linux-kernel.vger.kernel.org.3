Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47402474AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhLNS1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45126 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhLNS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E01616A2;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059EAC34613;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506421;
        bh=WpijYVmW1mn0d1H0aJ8oMDdr/yhn6zPfMyIhyDwj62g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scGKsBrctpsshGUsuVsEk5XRfEkiRbkfqam/upYWtIAmTsHeBarpsW/nc3y0yErp4
         L8AlIghgo2rYWV6ZmsvmRglZIRYmg5tr92KUXD6qhD1JmZN7XwGLofSBZ3YZwqDhFa
         wDBeOOE6nw8kwIE7PUWtgToARDP8yNqIUs8SgUkPNEF6FCz3ZDj85vF5KpQJGRJkSG
         YHkbm/O+QPnNdQ+KD9cxOb/J6+89NfAF9/NWnjHTeChEhyOrzWYCjZ+w/t7lTqvAzl
         rd20ZMaRbgIrW9ngf+Rc89tFVjRAY7N2MsxqykJxcL/SINqekLYhdDuMoDbF2hfiVW
         2Q+sidNEVPQKA==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVv-00C7Tq-8U; Tue, 14 Dec 2021 18:26:59 +0000
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
Subject: [PATCH v3 04/10] irqchip/apple-aic: Parse FIQ affinities from device-tree
Date:   Tue, 14 Dec 2021 18:26:28 +0000
Message-Id: <20211214182634.727330-5-maz@kernel.org>
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

In order to be able to tell the core IRQ code about the affinity
of the PMU interrupt in later patches, parse the affinities kindly
provided in the device-tree.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 2543ef65825b..b51eb9468701 100644
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
 	int ipi_hwirq;
 };
@@ -794,12 +797,51 @@ static struct gic_kvm_info vgic_info __initdata = {
 	.no_hw_deactivation	= true,
 };
 
+static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
+{
+	int i, n;
+	u32 fiq;
+
+	if (of_property_read_u32(aff, "fiq-index", &fiq) ||
+	    WARN_ON(fiq >= AIC_NR_FIQ))
+		return;
+
+	n = of_property_count_elems_of_size(aff, "affinity", sizeof(u32));
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
+		if (of_property_read_u32_index(aff, "affinity",
+					       i, &cpu_phandle))
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
@@ -833,6 +875,14 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
 
-- 
2.30.2

