Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2962479B83
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 16:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhLRPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 10:06:33 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:45722 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231506AbhLRPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 10:06:31 -0500
X-IronPort-AV: E=Sophos;i="5.88,216,1635174000"; 
   d="scan'208";a="103925658"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Dec 2021 00:06:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3B01F424CFEA;
        Sun, 19 Dec 2021 00:06:28 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] crypto: ux500 - Use platform_get_irq() to get the interrupt
Date:   Sat, 18 Dec 2021 15:06:25 +0000
Message-Id: <20211218150625.15134-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
code use platform_get_irq() so that interrupt mapping is created on demand.

While at it also store the IRQ number in struct cryp_device_data so that
we don't have to call platform_get_irq() frequently.

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
 drivers/crypto/ux500/cryp/cryp.h      |  2 ++
 drivers/crypto/ux500/cryp/cryp_core.c | 26 +++++++-------------------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp.h b/drivers/crypto/ux500/cryp/cryp.h
index db5713d7c940..59e1557a620a 100644
--- a/drivers/crypto/ux500/cryp/cryp.h
+++ b/drivers/crypto/ux500/cryp/cryp.h
@@ -224,6 +224,7 @@ struct cryp_dma {
  * @phybase: Pointer to physical memory location of the cryp device.
  * @dev: Pointer to the devices dev structure.
  * @clk: Pointer to the device's clock control.
+ * @irq: IRQ number
  * @pwr_regulator: Pointer to the device's power control.
  * @power_status: Current status of the power.
  * @ctx_lock: Lock for current_ctx.
@@ -239,6 +240,7 @@ struct cryp_device_data {
 	phys_addr_t phybase;
 	struct device *dev;
 	struct clk *clk;
+	int irq;
 	struct regulator *pwr_regulator;
 	int power_status;
 	spinlock_t ctx_lock;
diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 30cdd5253929..97277b7150cb 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1257,7 +1257,6 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *res;
-	struct resource *res_irq;
 	struct cryp_device_data *device_data;
 	struct cryp_protection_config prot = {
 		.privilege_access = CRYP_STATE_ENABLE
@@ -1341,15 +1340,13 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 		goto out_power;
 	}
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq) {
-		dev_err(dev, "[%s]: IORESOURCE_IRQ unavailable",
-			__func__);
-		ret = -ENODEV;
+	device_data->irq = platform_get_irq(pdev, 0);
+	if (device_data->irq <= 0) {
+		ret = device_data->irq ? device_data->irq : -ENXIO;
 		goto out_power;
 	}
 
-	ret = devm_request_irq(&pdev->dev, res_irq->start,
+	ret = devm_request_irq(&pdev->dev, device_data->irq,
 			       cryp_interrupt_handler, 0, "cryp1", device_data);
 	if (ret) {
 		dev_err(dev, "[%s]: Unable to request IRQ", __func__);
@@ -1489,7 +1486,6 @@ static int ux500_cryp_suspend(struct device *dev)
 	int ret;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct cryp_device_data *device_data;
-	struct resource *res_irq;
 	struct cryp_ctx *temp_ctx = NULL;
 
 	dev_dbg(dev, "[%s]", __func__);
@@ -1501,11 +1497,7 @@ static int ux500_cryp_suspend(struct device *dev)
 		return -ENOMEM;
 	}
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
-		dev_err(dev, "[%s]: IORESOURCE_IRQ, unavailable", __func__);
-	else
-		disable_irq(res_irq->start);
+	disable_irq(device_data->irq);
 
 	spin_lock(&device_data->ctx_lock);
 	if (!device_data->current_ctx)
@@ -1532,7 +1524,6 @@ static int ux500_cryp_resume(struct device *dev)
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct cryp_device_data *device_data;
-	struct resource *res_irq;
 	struct cryp_ctx *temp_ctx = NULL;
 
 	dev_dbg(dev, "[%s]", __func__);
@@ -1556,11 +1547,8 @@ static int ux500_cryp_resume(struct device *dev)
 
 	if (ret)
 		dev_err(dev, "[%s]: cryp_enable_power() failed!", __func__);
-	else {
-		res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-		if (res_irq)
-			enable_irq(res_irq->start);
-	}
+	else
+		enable_irq(device_data->irq);
 
 	return ret;
 }
-- 
2.17.1

