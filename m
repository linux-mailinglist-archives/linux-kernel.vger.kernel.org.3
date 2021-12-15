Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A734766BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhLOXuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:50:02 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:61012 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231740AbhLOXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:50:01 -0500
X-IronPort-AV: E=Sophos;i="5.88,209,1635174000"; 
   d="scan'208";a="104081025"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2021 08:50:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 860BC4143D03;
        Thu, 16 Dec 2021 08:49:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to get the interrupt
Date:   Wed, 15 Dec 2021 23:49:46 +0000
Message-Id: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi,

Usage of platform_get_irq/_optional was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/irqchip/irq-renesas-irqc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 07a6d8b42b63..c460f3c228d0 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -126,7 +126,6 @@ static int irqc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const char *name = dev_name(dev);
 	struct irqc_priv *p;
-	struct resource *irq;
 	int ret;
 	int k;
 
@@ -142,13 +141,15 @@ static int irqc_probe(struct platform_device *pdev)
 
 	/* allow any number of IRQs between 1 and IRQC_IRQ_MAX */
 	for (k = 0; k < IRQC_IRQ_MAX; k++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
-		if (!irq)
+		ret = platform_get_irq_optional(pdev, k);
+		if (ret == -EPROBE_DEFER)
+			goto err_runtime_pm_disable;
+		if (ret < 0)
 			break;
 
 		p->irq[k].p = p;
 		p->irq[k].hw_irq = k;
-		p->irq[k].requested_irq = irq->start;
+		p->irq[k].requested_irq = ret;
 	}
 
 	p->number_of_irqs = k;
-- 
2.17.1

