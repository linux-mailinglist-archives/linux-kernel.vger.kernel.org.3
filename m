Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E64AE1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385607AbiBHS50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385406AbiBHS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189FC0612C3;
        Tue,  8 Feb 2022 10:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D5061419;
        Tue,  8 Feb 2022 18:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160F4C340FD;
        Tue,  8 Feb 2022 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346625;
        bh=G9atuG1gvxA8sTH+XdAwaAyR2vEMcWxrL85sv2f+EY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3WB8Fp5/j6P1MX4QGFjrBPj86py5t00elz2sKjwWe+nOevEvqCEH2exn784G1pwd
         frRPfO6Zy2Oi+lexpI8OpyTIhVtPZqXZT8BvQvc15cym+Ao+xVBPREBmZ/UA8Wrf1V
         A3PGU7DpVje8rvpVvjAFzWy7YmXLgmwkJ4nf1TL+Ul1e+fez7NlZtVG2TKCadChPiP
         ETOJdibrPHgy1jH3X9xTtjl7ck/hRh4LrGLZiUpJdLQ755L03UwAYvfteE5K3aQAyq
         oLeTe8p2iZwjd05Dd+bcqzJrtODTjvBJIXvQOrwvIz09jGSfS5rimTAx5mvbmhoDJQ
         QXb6ec1JuPEXw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHVfj-006MEi-3b; Tue, 08 Feb 2022 18:57:03 +0000
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
Subject: [PATCH v5 04/10] irqchip/apple-aic: Parse FIQ affinities from device-tree
Date:   Tue,  8 Feb 2022 18:55:58 +0000
Message-Id: <20220208185604.1097957-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208185604.1097957-1-maz@kernel.org>
References: <20220208185604.1097957-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
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

In order to be able to tell the core IRQ code about the affinity
of the PMU interrupt in later patches, parse the affinities kindly
provided in the device-tree.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 49 +++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 38091ebb9403..22d9b2058612 100644
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
 
-- 
2.30.2

