Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89547EFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 16:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbhLXPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 10:38:07 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:50957 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353080AbhLXPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 10:38:07 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105112283"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Dec 2021 00:38:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 155A9400BC04;
        Sat, 25 Dec 2021 00:38:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] tty: goldfish: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 15:37:53 +0000
Message-Id: <20211224153753.22210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/tty/goldfish.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index c01cd36dda41..5ed19a9857ad 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -298,7 +298,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct device *ttydev;
 	void __iomem *base;
-	u32 irq;
+	int irq;
 	unsigned int line;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -313,14 +313,12 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r) {
-		pr_err("goldfish_tty: No IRQ resource available!\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
 		goto err_unmap;
 	}
 
-	irq = r->start;
-
 	mutex_lock(&goldfish_tty_lock);
 
 	if (pdev->id == PLATFORM_DEVID_NONE)
-- 
2.17.1

