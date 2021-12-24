Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE947F003
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbhLXQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:13:41 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:8123 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241833AbhLXQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:13:40 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104628874"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Dec 2021 01:13:38 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8B8D44018934;
        Sat, 25 Dec 2021 01:13:37 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm-ccn: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 16:13:31 +0000
Message-Id: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/perf/arm-ccn.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index a96c31604545..40b352e8aa7f 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1460,8 +1460,7 @@ static irqreturn_t arm_ccn_irq_handler(int irq, void *dev_id)
 static int arm_ccn_probe(struct platform_device *pdev)
 {
 	struct arm_ccn *ccn;
-	struct resource *res;
-	unsigned int irq;
+	int irq;
 	int err;
 
 	ccn = devm_kzalloc(&pdev->dev, sizeof(*ccn), GFP_KERNEL);
@@ -1474,10 +1473,9 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	if (IS_ERR(ccn->base))
 		return PTR_ERR(ccn->base);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res)
-		return -EINVAL;
-	irq = res->start;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	/* Check if we can use the interrupt */
 	writel(CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLE,
-- 
2.17.1

