Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30E47F007
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbhLXQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:13:47 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:8123 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353174AbhLXQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:13:45 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104628883"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Dec 2021 01:13:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 43A8D4018924;
        Sat, 25 Dec 2021 01:13:44 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: axis-fifo: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 16:13:34 +0000
Message-Id: <20211224161334.31123-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/staging/axis-fifo/axis-fifo.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 632f140dddbc..dfd2b357f484 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -809,7 +809,6 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 
 static int axis_fifo_probe(struct platform_device *pdev)
 {
-	struct resource *r_irq; /* interrupt resources */
 	struct resource *r_mem; /* IO mem resources */
 	struct device *dev = &pdev->dev; /* OS device (from device tree) */
 	struct axis_fifo *fifo = NULL;
@@ -882,16 +881,12 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 */
 
 	/* get IRQ resource */
-	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r_irq) {
-		dev_err(fifo->dt_device, "no IRQ found for 0x%pa\n",
-			&r_mem->start);
-		rc = -EIO;
+	rc = platform_get_irq(pdev, 0);
+	if (rc < 0)
 		goto err_initial;
-	}
 
 	/* request IRQ */
-	fifo->irq = r_irq->start;
+	fifo->irq = rc;
 	rc = devm_request_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
 			      DRIVER_NAME, fifo);
 	if (rc) {
-- 
2.17.1

