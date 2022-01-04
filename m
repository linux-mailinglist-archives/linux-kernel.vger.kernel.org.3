Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5F4843D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiADOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:52:35 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:6078 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233208AbiADOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:52:31 -0500
X-IronPort-AV: E=Sophos;i="5.88,261,1635174000"; 
   d="scan'208";a="105485577"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jan 2022 23:52:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 800AB4205AA3;
        Tue,  4 Jan 2022 23:52:26 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] thermal: rcar_thermal: Use platform_get_irq_optional() to get the interrupt
Date:   Tue,  4 Jan 2022 14:52:11 +0000
Message-Id: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2-v3:
* Fixed review comment pointed by Andy

v1->v2
* Simplified checking error code
* Break loop earlier if no interrupts are seen

v1: https://lkml.org/lkml/2021/12/18/163
---
 drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b49f04daaf47..e480f7290ccf 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct rcar_thermal_common *common;
 	struct rcar_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	struct resource *res, *irq;
+	struct resource *res;
 	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
 	int mres = 0;
 	int i;
@@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	for (i = 0; i < chip->nirqs; i++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!irq)
-			continue;
+		int irq;
+
+		irq = platform_get_irq_optional(pdev, i);
+		if (irq < 0 && irq != -ENXIO) {
+			ret = irq;
+			goto error_unregister;
+		}
+		if (!irq || irq == -ENXIO)
+			break;
+
 		if (!common->base) {
 			/*
 			 * platform has IRQ support.
@@ -487,7 +494,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			idle = 0; /* polling delay is not needed */
 		}
 
-		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
+		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
 				       IRQF_SHARED, dev_name(dev), common);
 		if (ret) {
 			dev_err(dev, "irq request failed\n ");
-- 
2.17.1

