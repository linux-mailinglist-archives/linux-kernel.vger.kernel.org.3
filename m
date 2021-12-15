Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D94766A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhLOXpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:45:01 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:32337 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232096AbhLOXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:45:00 -0500
X-IronPort-AV: E=Sophos;i="5.88,209,1635174000"; 
   d="scan'208";a="103632380"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 08:44:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8ACC24007F5C;
        Thu, 16 Dec 2021 08:44:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional() to get the interrupt
Date:   Wed, 15 Dec 2021 23:44:48 +0000
Message-Id: <20211215234448.5631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/irqchip/irq-renesas-intc-irqpin.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index cb7f60b3b4a9..c35d9fbcda5c 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -375,7 +375,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	struct intc_irqpin_priv *p;
 	struct intc_irqpin_iomem *i;
 	struct resource *io[INTC_IRQPIN_REG_NR];
-	struct resource *irq;
 	struct irq_chip *irq_chip;
 	void (*enable_fn)(struct irq_data *d);
 	void (*disable_fn)(struct irq_data *d);
@@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 	/* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
 	for (k = 0; k < INTC_IRQPIN_MAX; k++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
-		if (!irq)
+		ret = platform_get_irq_optional(pdev, k);
+		if (ret == -EPROBE_DEFER)
+			goto err0;
+		if (ret < 0)
 			break;
 
 		p->irq[k].p = p;
-		p->irq[k].requested_irq = irq->start;
+		p->irq[k].requested_irq = ret;
 	}
 
 	nirqs = k;
-- 
2.17.1

