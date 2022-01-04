Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969754842BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiADNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:45:25 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:51036 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231358AbiADNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:45:24 -0500
X-IronPort-AV: E=Sophos;i="5.88,261,1635174000"; 
   d="scan'208";a="105482863"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jan 2022 22:45:22 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C415740065DB;
        Tue,  4 Jan 2022 22:45:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] soc: ti: smartreflex: Use platform_get_irq_optional() to get the interrupt
Date:   Tue,  4 Jan 2022 13:45:12 +0000
Message-Id: <20220104134512.18498-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

While at it return 0 instead of returning ret in the probe success path.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
* Used dev_err_probe() to print error message
* Returning 0 in probe success path.

v2->v3
* Switch back to platform_get_irq_optional()
* Only print error in case of error, and not when interrupt is missing.

v1->v2
* Updated commit message
* Drop check for IRQ0
* Switched to using platform_get_irq() so that the probe won't
  fail silently as requested by Nishanth.

v1:
* https://www.spinics.net/lists/arm-kernel/msg942549.html
---
 drivers/soc/ti/smartreflex.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index b5b2fa538d5c..a219c003a63f 100644
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
 
@@ -844,7 +844,13 @@ static int omap_sr_probe(struct platform_device *pdev)
 	if (IS_ERR(sr_info->base))
 		return PTR_ERR(sr_info->base);
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret < 0 && ret != -ENXIO) {
+		dev_err_probe(&pdev->dev, ret, "%s: failed to get IRQ resource\n", __func__);
+		return ret;
+	}
+	if (ret > 0)
+		sr_info->irq = ret;
 
 	sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
 	if (IS_ERR(sr_info->fck))
@@ -870,9 +876,6 @@ static int omap_sr_probe(struct platform_device *pdev)
 	sr_info->autocomp_active = false;
 	sr_info->ip_type = pdata->ip_type;
 
-	if (irq)
-		sr_info->irq = irq->start;
-
 	sr_set_clk_length(sr_info);
 
 	list_add(&sr_info->node, &sr_list);
@@ -926,7 +929,7 @@ static int omap_sr_probe(struct platform_device *pdev)
 
 	}
 
-	return ret;
+	return 0;
 
 err_debugfs:
 	debugfs_remove_recursive(sr_info->dbg_dir);
-- 
2.17.1

