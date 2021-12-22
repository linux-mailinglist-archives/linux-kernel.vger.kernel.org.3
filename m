Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FFA47D75E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbhLVTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:12 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:26471 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345049AbhLVTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:10 -0500
X-IronPort-AV: E=Sophos;i="5.88,227,1635174000"; 
   d="scan'208";a="104382703"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 04:02:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4193740DF258;
        Thu, 23 Dec 2021 04:02:06 +0900 (JST)
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
Subject: [PATCH 5/5] drm/exynos: gsc: Use platform_get_irq() to get the interrupt
Date:   Wed, 22 Dec 2021 19:01:34 +0000
Message-Id: <20211222190134.24866-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222190134.24866-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222190134.24866-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 166a80262896..964dceb28c1e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1220,7 +1220,6 @@ static int gsc_probe(struct platform_device *pdev)
 	struct gsc_driverdata *driver_data;
 	struct exynos_drm_ipp_formats *formats;
 	struct gsc_context *ctx;
-	struct resource *res;
 	int num_formats, ret, i, j;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -1275,13 +1274,10 @@ static int gsc_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->regs);
 
 	/* resource irq */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "failed to request irq resource.\n");
-		return -ENOENT;
-	}
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0)
+		return ctx->irq;
 
-	ctx->irq = res->start;
 	ret = devm_request_irq(dev, ctx->irq, gsc_irq_handler, 0,
 			       dev_name(dev), ctx);
 	if (ret < 0) {
-- 
2.17.1

