Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54661479B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 16:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhLRPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 10:40:00 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:8624 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233478AbhLRPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 10:39:58 -0500
X-IronPort-AV: E=Sophos;i="5.88,216,1635174000"; 
   d="scan'208";a="104385584"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Dec 2021 00:39:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5F2194008C5C;
        Sun, 19 Dec 2021 00:39:55 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        SantoshShilimkarssantosh@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] soc: ti: smartreflex: Use platform_get_irq_optional() to get the interrupt
Date:   Sat, 18 Dec 2021 15:39:43 +0000
Message-Id: <20211218153943.28014-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi,

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/soc/ti/smartreflex.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index b5b2fa538d5c..4f311e00fa46 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -819,7 +819,7 @@ static int omap_sr_probe(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info;
 	struct omap_sr_data *pdata = pdev->dev.platform_data;
-	struct resource *mem, *irq;
+	struct resource *mem;
 	struct dentry *nvalue_dir;
 	int i, ret = 0;
 
@@ -844,7 +844,12 @@ static int omap_sr_probe(struct platform_device *pdev)
 	if (IS_ERR(sr_info->base))
 		return PTR_ERR(sr_info->base);
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret <= 0 && ret != -ENXIO)
+		return ret ? ret : -ENXIO;
+	if (ret > 0)
+		sr_info->irq = ret;
+	ret = 0;
 
 	sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
 	if (IS_ERR(sr_info->fck))
@@ -870,9 +875,6 @@ static int omap_sr_probe(struct platform_device *pdev)
 	sr_info->autocomp_active = false;
 	sr_info->ip_type = pdata->ip_type;
 
-	if (irq)
-		sr_info->irq = irq->start;
-
 	sr_set_clk_length(sr_info);
 
 	list_add(&sr_info->node, &sr_list);
-- 
2.17.1

