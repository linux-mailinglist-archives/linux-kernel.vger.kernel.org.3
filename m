Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9136F47D75A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbhLVTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:05 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:26471 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344978AbhLVTCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:03 -0500
X-IronPort-AV: E=Sophos;i="5.88,227,1635174000"; 
   d="scan'208";a="104382689"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 04:02:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F3F4440DF258;
        Thu, 23 Dec 2021 04:01:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/5] drm/exynos/exynos_drm_fimd: Use platform_get_irq_byname() to get the interrupt
Date:   Wed, 22 Dec 2021 19:01:32 +0000
Message-Id: <20211222190134.24866-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222190134.24866-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222190134.24866-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_byname().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index c735e53939d8..7d5a483a54de 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -1133,7 +1133,6 @@ static int fimd_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fimd_context *ctx;
 	struct device_node *i80_if_timings;
-	struct resource *res;
 	int ret;
 
 	if (!dev->of_node)
@@ -1206,15 +1205,11 @@ static int fimd_probe(struct platform_device *pdev)
 	if (IS_ERR(ctx->regs))
 		return PTR_ERR(ctx->regs);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					   ctx->i80_if ? "lcd_sys" : "vsync");
-	if (!res) {
-		dev_err(dev, "irq request failed.\n");
-		return -ENXIO;
-	}
+	ret = platform_get_irq_byname(pdev, ctx->i80_if ? "lcd_sys" : "vsync");
+	if (ret < 0)
+		return ret;
 
-	ret = devm_request_irq(dev, res->start, fimd_irq_handler,
-							0, "drm_fimd", ctx);
+	ret = devm_request_irq(dev, ret, fimd_irq_handler, 0, "drm_fimd", ctx);
 	if (ret) {
 		dev_err(dev, "irq request failed.\n");
 		return ret;
-- 
2.17.1

