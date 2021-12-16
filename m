Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB66477B67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhLPSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:21:36 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:46569 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231292AbhLPSVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:21:36 -0500
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000"; 
   d="scan'208";a="103741223"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Dec 2021 03:21:34 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 71F924000AB0;
        Fri, 17 Dec 2021 03:21:33 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional() to get the interrupt
Date:   Thu, 16 Dec 2021 18:21:20 +0000
Message-Id: <20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2
* Check for -ENXIO in case of missing interrupt resource
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index cb7f60b3b4a9..37f9a4499fdb 100644
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
+		if (ret == -ENXIO)
 			break;
+		if (ret < 0)
+			goto err0;
 
 		p->irq[k].p = p;
-		p->irq[k].requested_irq = irq->start;
+		p->irq[k].requested_irq = ret;
 	}
 
 	nirqs = k;
-- 
2.17.1

