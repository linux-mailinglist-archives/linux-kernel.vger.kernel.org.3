Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7C5932EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiHOQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiHOQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28A021D0ED
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CC82106F;
        Mon, 15 Aug 2022 09:20:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63E733F70D;
        Mon, 15 Aug 2022 09:20:36 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/16] iommu/dart: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:10 +0100
Message-Id: <afe138964196907d58147a686c1dcd6a12f9e210.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v4: No change

 drivers/iommu/apple-dart.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 1b1725759262..437aed674fba 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -820,27 +820,6 @@ static irqreturn_t apple_dart_irq(int irq, void *dev)
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
@@ -895,14 +874,10 @@ static int apple_dart_probe(struct platform_device *pdev)
 
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
@@ -916,8 +891,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 err_sysfs_remove:
 	iommu_device_sysfs_remove(&dart->iommu);
-err_remove_bus_ops:
-	apple_dart_set_bus_ops(NULL);
 err_free_irq:
 	free_irq(dart->irq, dart);
 err_clk_disable:
@@ -932,7 +905,6 @@ static int apple_dart_remove(struct platform_device *pdev)
 
 	apple_dart_hw_reset(dart);
 	free_irq(dart->irq, dart);
-	apple_dart_set_bus_ops(NULL);
 
 	iommu_device_unregister(&dart->iommu);
 	iommu_device_sysfs_remove(&dart->iommu);
-- 
2.36.1.dirty

