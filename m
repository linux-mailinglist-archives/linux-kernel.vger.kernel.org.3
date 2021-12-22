Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154A147D757
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbhLVTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:01 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:26471 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231511AbhLVTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:00 -0500
X-IronPort-AV: E=Sophos;i="5.88,227,1635174000"; 
   d="scan'208";a="104382683"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 04:01:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D650940DF447;
        Thu, 23 Dec 2021 04:01:56 +0900 (JST)
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
Subject: [PATCH 2/5] drm/exynos: mixer: Use platform_get_irq() to get the interrupt
Date:   Wed, 22 Dec 2021 19:01:31 +0000
Message-Id: <20211222190134.24866-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Hi,

Ideally I would expect the mixer_resources_init() to be called from probe
instead from the bind callback. If platform_get_irq() returns -EPROBE_DEFER
the bind callback will fail :(

Cheers,
Prabhakar
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 41c54f1f60bc..e5204be86093 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -809,19 +809,17 @@ static int mixer_resources_init(struct mixer_context *mixer_ctx)
 		return -ENXIO;
 	}
 
-	res = platform_get_resource(mixer_ctx->pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(dev, "get interrupt resource failed.\n");
-		return -ENXIO;
-	}
+	ret = platform_get_irq(mixer_ctx->pdev, 0);
+	if (ret < 0)
+		return ret;
+	mixer_ctx->irq = ret;
 
-	ret = devm_request_irq(dev, res->start, mixer_irq_handler,
-						0, "drm_mixer", mixer_ctx);
+	ret = devm_request_irq(dev, mixer_ctx->irq, mixer_irq_handler,
+			       0, "drm_mixer", mixer_ctx);
 	if (ret) {
 		dev_err(dev, "request interrupt failed.\n");
 		return ret;
 	}
-	mixer_ctx->irq = res->start;
 
 	return 0;
 }
-- 
2.17.1

