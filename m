Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1FD47C8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhLUVf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:35:57 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:23027 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236211AbhLUVfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:35:54 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104266934"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 06:35:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A77B64008C6B;
        Wed, 22 Dec 2021 06:35:51 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] mfd: ab8500-core: Use platform_get_irq() to get the interrupt
Date:   Tue, 21 Dec 2021 21:35:47 +0000
Message-Id: <20211221213547.1553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Hi,

Usage of platform_get_irq() was agreed based on the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/mfd/ab8500-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index cca0aac26148..1e61c3dacb0d 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1042,7 +1042,6 @@ static int ab8500_probe(struct platform_device *pdev)
 	enum ab8500_version version = AB8500_VERSION_UNDEFINED;
 	struct device_node *np = pdev->dev.of_node;
 	struct ab8500 *ab8500;
-	struct resource *resource;
 	int ret;
 	int i;
 	u8 value;
@@ -1053,13 +1052,9 @@ static int ab8500_probe(struct platform_device *pdev)
 
 	ab8500->dev = &pdev->dev;
 
-	resource = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!resource) {
-		dev_err(&pdev->dev, "no IRQ resource\n");
-		return -ENODEV;
-	}
-
-	ab8500->irq = resource->start;
+	ab8500->irq = platform_get_irq(pdev, 0);
+	if (ab8500->irq < 0)
+		return ab8500->irq;
 
 	ab8500->read = ab8500_prcmu_read;
 	ab8500->write = ab8500_prcmu_write;
-- 
2.17.1

