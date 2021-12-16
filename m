Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADBF477F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhLPVr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:47:56 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:36568 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229840AbhLPVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:47:55 -0500
X-IronPort-AV: E=Sophos;i="5.88,212,1635174000"; 
   d="scan'208";a="104202773"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Dec 2021 06:47:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4422841114A8;
        Fri, 17 Dec 2021 06:47:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] watchdog: s3c2410: Use platform_get_irq() to get the interrupt
Date:   Thu, 16 Dec 2021 21:47:47 +0000
Message-Id: <20211216214747.10454-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Dropped goto and directly returned on error
---
 drivers/watchdog/s3c2410_wdt.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 2395f353e52d..d92bc1c24182 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -513,9 +513,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct s3c2410_wdt *wdt;
-	struct resource *wdt_irq;
 	unsigned int wtcon;
 	int started = 0;
+	int wdt_irq;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -536,12 +536,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (wdt_irq == NULL) {
-		dev_err(dev, "no irq resource specified\n");
-		ret = -ENOENT;
-		goto err;
-	}
+	wdt_irq = platform_get_irq(pdev, 0);
+	if (wdt_irq < 0)
+		return wdt_irq;
 
 	/* get the memory region for the watchdog timer */
 	wdt->reg_base = devm_platform_ioremap_resource(pdev, 0);
@@ -592,8 +589,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 			dev_info(dev, "default timer value is out of range, cannot start\n");
 	}
 
-	ret = devm_request_irq(dev, wdt_irq->start, s3c2410wdt_irq, 0,
-				pdev->name, pdev);
+	ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
+			       pdev->name, pdev);
 	if (ret != 0) {
 		dev_err(dev, "failed to install irq (%d)\n", ret);
 		goto err_cpufreq;
-- 
2.17.1

