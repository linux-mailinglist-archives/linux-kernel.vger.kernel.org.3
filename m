Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B957D4DB92E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355239AbiCPUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbiCPUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:08:53 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C89006E362;
        Wed, 16 Mar 2022 13:07:37 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,187,1643641200"; 
   d="scan'208";a="114644573"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2022 05:07:36 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05153409A4C2;
        Thu, 17 Mar 2022 05:07:34 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH] of/platform: Drop static setup of IRQ resource from DT core
Date:   Wed, 16 Mar 2022 20:06:33 +0000
Message-Id: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the DT drivers have switched to platform_get_irq() we can now
safely drop the static setup of IRQ resource from DT core code.

With the above change hierarchical setup of irq domains is no longer
bypassed and thus allowing hierarchical interrupt domains to describe
interrupts using "interrupts" DT property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

Sending this as RFC as couple of more drivers need to hit -rc yet with
the platform_get_irq() change while that is in progress I wanted to get
some feedback on this patch.

Cheers,
Prabhakar
---
 drivers/of/platform.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 793350028906..6890f7fe556f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -114,35 +114,31 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				  struct device *parent)
 {
 	struct platform_device *dev;
-	int rc, i, num_reg = 0, num_irq;
+	int rc, i, num_reg = 0;
 	struct resource *res, temp_res;
 
 	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
 	if (!dev)
 		return NULL;
 
-	/* count the io and irq resources */
+	/* count the io resources */
 	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
 		num_reg++;
-	num_irq = of_irq_count(np);
 
 	/* Populate the resource table */
-	if (num_irq || num_reg) {
-		res = kcalloc(num_irq + num_reg, sizeof(*res), GFP_KERNEL);
+	if (num_reg) {
+		res = kcalloc(num_reg, sizeof(*res), GFP_KERNEL);
 		if (!res) {
 			platform_device_put(dev);
 			return NULL;
 		}
 
-		dev->num_resources = num_reg + num_irq;
+		dev->num_resources = num_reg;
 		dev->resource = res;
 		for (i = 0; i < num_reg; i++, res++) {
 			rc = of_address_to_resource(np, i, res);
 			WARN_ON(rc);
 		}
-		if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
-			pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
-				 np);
 	}
 
 	dev->dev.of_node = of_node_get(np);
-- 
2.17.1

