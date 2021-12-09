Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331ED46DF4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhLIAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:14:45 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:23020 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238478AbhLIAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:14:44 -0500
X-IronPort-AV: E=Sophos;i="5.88,190,1635174000"; 
   d="scan'208";a="103275904"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Dec 2021 09:11:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2DDD94137E0B;
        Thu,  9 Dec 2021 09:11:08 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
Date:   Thu,  9 Dec 2021 00:10:56 +0000
Message-Id: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_device_alloc() in early boot stage creates a interrupt mapping if
there exists a "interrupts" property in the node.

For hierarchical interrupt domains using "interrupts" property in the node
bypassed the hierarchical setup and messed up the irq setup.

This patch adds a check in of_device_alloc() to skip interrupt mapping if
"not-interrupt-producer" property is present in the node. This allows
nodes to describe the interrupts using "interrupts" property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

Spawning from discussion [1], here is simple patch (not the ideal probably
welcome for suggestions) from stopping the OF code from creating a map for
the interrupts when using "interrupts" property.

[1] https://lore.kernel.org/lkml/87pmqrck2m.wl-maz@kernel.org/
    T/#mbd1e47c1981082aded4b32a52e2c04291e515508

Cheers,
Prabhakar
---
 drivers/of/platform.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b3faf89744aa..629776ca1721 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -114,7 +114,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				  struct device *parent)
 {
 	struct platform_device *dev;
-	int rc, i, num_reg = 0, num_irq;
+	int rc, i, num_reg = 0, num_irq = 0;
 	struct resource *res, temp_res;
 
 	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
@@ -124,7 +124,14 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	/* count the io and irq resources */
 	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
 		num_reg++;
-	num_irq = of_irq_count(np);
+
+	/*
+	 * we don't want to map the interrupts of hierarchical interrupt domain
+	 * into the parent domain yet. This will be the job of the hierarchical
+	 * interrupt driver code to map the interrupts as and when needed.
+	 */
+	if (!of_property_read_bool(np, "not-interrupt-producer"))
+		num_irq = of_irq_count(np);
 
 	/* Populate the resource table */
 	if (num_irq || num_reg) {
@@ -140,7 +147,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 			rc = of_address_to_resource(np, i, res);
 			WARN_ON(rc);
 		}
-		if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
+		if (num_irq && of_irq_to_resource_table(np, res, num_irq) != num_irq)
 			pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
 				 np);
 	}
-- 
2.17.1

