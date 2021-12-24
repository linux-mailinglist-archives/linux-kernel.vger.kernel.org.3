Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2524147EEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352747AbhLXNNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:19 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53177 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352760AbhLXNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:14 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105104961"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 09D5543A1810;
        Fri, 24 Dec 2021 22:13:11 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 04/10] ata: pata_platform: Use platform_get_irq_optional() to get the interrupt
Date:   Fri, 24 Dec 2021 13:12:53 +0000
Message-Id: <20211224131300.18198-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistent with pata_of_platform driver use
platform_get_irq_optional() instead of
platform_get_resource(pdev, IORESOURCE_IRQ, 0).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* New patch
---
 drivers/ata/pata_platform.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 29902001e223..2e439b923762 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -184,8 +184,9 @@ static int pata_platform_probe(struct platform_device *pdev)
 {
 	struct resource *io_res;
 	struct resource *ctl_res;
-	struct resource *irq_res;
+	struct resource irq_res;
 	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
+	int irq;
 
 	/*
 	 * Simple resource validation ..
@@ -212,9 +213,15 @@ static int pata_platform_probe(struct platform_device *pdev)
 	/*
 	 * And the IRQ
 	 */
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq > 0) {
+		memset(&irq_res, 0x0, sizeof(struct resource));
+		irq_res.start = irq;
+	}
 
-	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
+	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq > 0 ? &irq_res : NULL,
 				     pp_info ? pp_info->ioport_shift : 0,
 				     pio_mask, &pata_platform_sht, false);
 }
-- 
2.17.1

