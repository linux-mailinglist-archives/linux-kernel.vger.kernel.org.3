Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64425479B72
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhLROlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:41:46 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:21274 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230522AbhLROlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:41:45 -0500
X-IronPort-AV: E=Sophos;i="5.88,216,1635174000"; 
   d="scan'208";a="104382932"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Dec 2021 23:41:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 85B6D4006DEE;
        Sat, 18 Dec 2021 23:41:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] thermal: rcar_thermal: Use platform_get_irq_optional() to get the interrupt
Date:   Sat, 18 Dec 2021 14:41:36 +0000
Message-Id: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/thermal/rcar_thermal.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b49f04daaf47..e4c7bc1bf7ef 100644
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
+		int irq;
+
+		irq = platform_get_irq_optional(pdev, i);
+		if (irq <= 0 && irq != -ENXIO) {
+			ret = irq ? irq : -ENXIO;
+			goto error_unregister;
+		}
+		if (irq == -ENXIO)
 			continue;
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

