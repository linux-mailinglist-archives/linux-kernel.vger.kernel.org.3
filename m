Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE648A464
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiAKAYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:24:08 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:57594 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345920AbiAKAXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:23:54 -0500
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="106595559"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jan 2022 09:23:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 376C44157D34;
        Tue, 11 Jan 2022 09:23:51 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] media: exynos4-is: Use platform_get_irq() to get the interrupt
Date:   Tue, 11 Jan 2022 00:23:11 +0000
Message-Id: <20220111002314.15213-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
* No change.
---
 drivers/media/platform/exynos4-is/fimc-core.c | 11 +++++------
 drivers/media/platform/exynos4-is/fimc-lite.c | 11 +++++------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-core.c b/drivers/media/platform/exynos4-is/fimc-core.c
index bfdee771cef9..91cc8d58a663 100644
--- a/drivers/media/platform/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/exynos4-is/fimc-core.c
@@ -926,6 +926,7 @@ static int fimc_probe(struct platform_device *pdev)
 	struct fimc_dev *fimc;
 	struct resource *res;
 	int ret = 0;
+	int irq;
 
 	fimc = devm_kzalloc(dev, sizeof(*fimc), GFP_KERNEL);
 	if (!fimc)
@@ -965,11 +966,9 @@ static int fimc_probe(struct platform_device *pdev)
 	if (IS_ERR(fimc->regs))
 		return PTR_ERR(fimc->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(dev, "Failed to get IRQ resource\n");
-		return -ENXIO;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	ret = fimc_clk_get(fimc);
 	if (ret)
@@ -986,7 +985,7 @@ static int fimc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_request_irq(dev, res->start, fimc_irq_handler,
+	ret = devm_request_irq(dev, irq, fimc_irq_handler,
 			       0, dev_name(dev), fimc);
 	if (ret < 0) {
 		dev_err(dev, "failed to install irq (%d)\n", ret);
diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
index aaa3af0493ce..9b7cc9564cf1 100644
--- a/drivers/media/platform/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/exynos4-is/fimc-lite.c
@@ -1454,6 +1454,7 @@ static int fimc_lite_probe(struct platform_device *pdev)
 	struct fimc_lite *fimc;
 	struct resource *res;
 	int ret;
+	int irq;
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -1485,17 +1486,15 @@ static int fimc_lite_probe(struct platform_device *pdev)
 	if (IS_ERR(fimc->regs))
 		return PTR_ERR(fimc->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(dev, "Failed to get IRQ resource\n");
-		return -ENXIO;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	ret = fimc_lite_clk_get(fimc);
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(dev, res->start, flite_irq_handler,
+	ret = devm_request_irq(dev, irq, flite_irq_handler,
 			       0, dev_name(dev), fimc);
 	if (ret) {
 		dev_err(dev, "Failed to install irq (%d)\n", ret);
-- 
2.17.1

