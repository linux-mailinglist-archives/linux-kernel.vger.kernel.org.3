Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD4464F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349637AbhLANxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349658AbhLANxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525EC061761;
        Wed,  1 Dec 2021 05:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77FE3B81F43;
        Wed,  1 Dec 2021 13:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5B2C56747;
        Wed,  1 Dec 2021 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366561;
        bh=Zl6H58qcgfUeyieN66WwDm5TyO/4vzr6D5P7MU2G3sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dngii+ec800kMxYsbxUDZBlY+OVtxnnAgOasyF7nt27wqx4w8etMYgms8qRE22emJ
         4ylaEjz37AOpBUAh9KpN/C1a0Who4kLrAQFPLJdpN6txUBxpb573v3ESudG0hK+fCY
         Mt04kIOUrwLyXfG1xdxr2VsHuQ2OfzffLxOyMwULGeNke9hGMr5fM/OOEYdMkpubBa
         mFRynxBpoaPMeYFSiBp/r4uzMSWHigumZLZ3jrWO0iG01jICCL0Tv03DIae0SOx30j
         5ICk4SgGnYv1l0pIL/2w8i49DEkV5wNbvlUqQmwXNpmvvmF0Y+7fETPAtg3XExaoet
         5Fx9ifCP6zWUQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msPz5-0098G7-Cd; Wed, 01 Dec 2021 13:49:19 +0000
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
Subject: [PATCH v2 3/8] irqchip/apple-aic: Add cpumasks for E and P cores
Date:   Wed,  1 Dec 2021 13:49:04 +0000
Message-Id: <20211201134909.390490-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201134909.390490-1-maz@kernel.org>
References: <20211201134909.390490-1-maz@kernel.org>
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
of the PMU interrupt in later patches, compute the cpumasks of the
P and E cores at boot time.

This relies on the affinity scheme used by the vendor, which seems
to work for the couple of SoCs that are out in the wild.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 3759dc36cc8f..30ca80ccda8b 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -177,6 +177,8 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
+	struct cpumask ecore_mask;
+	struct cpumask pcore_mask;
 	int nr_hw;
 	int ipi_hwirq;
 };
@@ -200,6 +202,11 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
 	writel_relaxed(val, ic->base + reg);
 }
 
+static bool __is_pcore(u64 mpidr)
+{
+	return MPIDR_AFFINITY_LEVEL(mpidr, 2) == 1;
+}
+
 /*
  * IRQ irqchip
  */
@@ -833,6 +840,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		return -ENODEV;
 	}
 
+	for_each_possible_cpu(i) {
+		if (__is_pcore(cpu_logical_map(i)))
+			cpumask_set_cpu(i, &irqc->pcore_mask);
+		else
+			cpumask_set_cpu(i, &irqc->ecore_mask);
+	}
+
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
 
-- 
2.30.2

