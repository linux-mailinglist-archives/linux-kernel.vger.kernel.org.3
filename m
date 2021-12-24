Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0A47F0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353487AbhLXT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 14:58:26 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:50522 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239476AbhLXT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 14:58:25 -0500
X-IronPort-AV: E=Sophos;i="5.88,233,1635174000"; 
   d="scan'208";a="104636686"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Dec 2021 04:58:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8EC8340078A8;
        Sat, 25 Dec 2021 04:58:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] soc: ti: smartreflex: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 19:58:17 +0000
Message-Id: <20211224195818.26081-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Updated commit message
* Drop check for IRQ0
* Switched to using platform_get_irq() so that the probe won't
  fail silently as requested by Nishanth.

v1:
* https://www.spinics.net/lists/arm-kernel/msg942549.html
---
 drivers/soc/ti/smartreflex.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index b5b2fa538d5c..3e2cddad0d93 100644
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
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
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

