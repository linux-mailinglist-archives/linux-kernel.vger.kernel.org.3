Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026135134DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiD1NWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347011AbiD1NV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:21:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 902C9939D3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:18:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5964F1477;
        Thu, 28 Apr 2022 06:18:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 542D53F73B;
        Thu, 28 Apr 2022 06:18:41 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] iommu/dart: Clean up bus_set_iommu()
Date:   Thu, 28 Apr 2022 14:18:08 +0100
Message-Id: <2a56bc5322c02da954d7890c5b162768f57c3277.1650890638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650890638.git.robin.murphy@arm.com>
References: <cover.1650890638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the probe failure path accordingly.

Tested-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/apple-dart.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad08..a679e4c02291 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -823,27 +823,6 @@ static irqreturn_t apple_dart_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int apple_dart_set_bus_ops(const struct iommu_ops *ops)
-{
-	int ret;
-
-	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type, ops);
-		if (ret)
-			return ret;
-	}
-#ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		ret = bus_set_iommu(&pci_bus_type, ops);
-		if (ret) {
-			bus_set_iommu(&platform_bus_type, NULL);
-			return ret;
-		}
-	}
-#endif
-	return 0;
-}
-
 static int apple_dart_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -899,14 +878,10 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dart);
 
-	ret = apple_dart_set_bus_ops(&apple_dart_iommu_ops);
-	if (ret)
-		goto err_free_irq;
-
 	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
 				     dev_name(&pdev->dev));
 	if (ret)
-		goto err_remove_bus_ops;
+		goto err_free_irq;
 
 	ret = iommu_device_register(&dart->iommu, &apple_dart_iommu_ops, dev);
 	if (ret)
@@ -920,8 +895,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 err_sysfs_remove:
 	iommu_device_sysfs_remove(&dart->iommu);
-err_remove_bus_ops:
-	apple_dart_set_bus_ops(NULL);
 err_free_irq:
 	free_irq(dart->irq, dart);
 err_clk_disable:
@@ -936,7 +909,6 @@ static int apple_dart_remove(struct platform_device *pdev)
 
 	apple_dart_hw_reset(dart);
 	free_irq(dart->irq, dart);
-	apple_dart_set_bus_ops(NULL);
 
 	iommu_device_unregister(&dart->iommu);
 	iommu_device_sysfs_remove(&dart->iommu);
-- 
2.35.3.dirty

