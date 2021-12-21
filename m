Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC4247C858
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhLUUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:39:30 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:28749 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234572AbhLUUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:39:28 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104263771"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 05:39:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3D858400CA05;
        Wed, 22 Dec 2021 05:39:26 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-omap@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] memory: omap-gpmc: Make use of the devm_platform_ioremap_resource()
Date:   Tue, 21 Dec 2021 20:39:16 +0000
Message-Id: <20211221203916.18588-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221203916.18588-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221203916.18588-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/omap-gpmc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 56f401ba53a5..582fe102f923 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2492,7 +2492,6 @@ static int gpmc_probe(struct platform_device *pdev)
 {
 	int rc;
 	u32 l;
-	struct resource *res;
 	struct gpmc_device *gpmc;
 
 	gpmc = devm_kzalloc(&pdev->dev, sizeof(*gpmc), GFP_KERNEL);
@@ -2502,11 +2501,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	gpmc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gpmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
-	gpmc_base = devm_ioremap_resource(&pdev->dev, res);
+	gpmc_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpmc_base))
 		return PTR_ERR(gpmc_base);
 
-- 
2.17.1

