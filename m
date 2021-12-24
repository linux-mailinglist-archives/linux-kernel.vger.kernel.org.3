Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2447F110
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhLXUWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:22:51 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:61703 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229683AbhLXUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:22:51 -0500
X-IronPort-AV: E=Sophos;i="5.88,233,1635174000"; 
   d="scan'208";a="105123796"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Dec 2021 05:22:49 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2142F40062AB;
        Sat, 25 Dec 2021 05:22:47 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] soc: ti: smartreflex: Use platform_get_irq_optional() to get the interrupt
Date:   Fri, 24 Dec 2021 20:22:31 +0000
Message-Id: <20211224202231.31130-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/soc/ti/smartreflex.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index b5b2fa538d5c..e2e3eb3db4cc 100644
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
 
@@ -844,7 +844,14 @@ static int omap_sr_probe(struct platform_device *pdev)
 	if (IS_ERR(sr_info->base))
 		return PTR_ERR(sr_info->base);
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret < 0 && ret != -ENXIO) {
+		dev_err(&pdev->dev, "%s: failed to get IRQ resource\n", __func__);
+		return ret;
+	}
+	if (ret > 0)
+		sr_info->irq = ret;
+	ret = 0;
 
 	sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
 	if (IS_ERR(sr_info->fck))
@@ -870,9 +877,6 @@ static int omap_sr_probe(struct platform_device *pdev)
 	sr_info->autocomp_active = false;
 	sr_info->ip_type = pdata->ip_type;
 
-	if (irq)
-		sr_info->irq = irq->start;
-
 	sr_set_clk_length(sr_info);
 
 	list_add(&sr_info->node, &sr_list);
-- 
2.17.1

