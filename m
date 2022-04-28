Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327B5134DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347051AbiD1NWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347003AbiD1NV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:21:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BEE39399F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:18:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E7A150C;
        Thu, 28 Apr 2022 06:18:41 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EC453F73B;
        Thu, 28 Apr 2022 06:18:39 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] iommu/arm-smmu-v3: Clean up bus_set_iommu()
Date:   Thu, 28 Apr 2022 14:18:07 +0100
Message-Id: <4abe6fc30d5630c99b034ddd0cdac56d19bd9f15.1650890638.git.robin.murphy@arm.com>
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

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 +--------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 627a3ed5ee8f..73b7b1b17b77 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -28,8 +28,6 @@
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 
-#include <linux/amba/bus.h>
-
 #include "arm-smmu-v3.h"
 #include "../../iommu-sva-lib.h"
 
@@ -3698,43 +3696,6 @@ static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
 		return SZ_128K;
 }
 
-static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
-{
-	int err;
-
-#ifdef CONFIG_PCI
-	if (pci_bus_type.iommu_ops != ops) {
-		err = bus_set_iommu(&pci_bus_type, ops);
-		if (err)
-			return err;
-	}
-#endif
-#ifdef CONFIG_ARM_AMBA
-	if (amba_bustype.iommu_ops != ops) {
-		err = bus_set_iommu(&amba_bustype, ops);
-		if (err)
-			goto err_reset_pci_ops;
-	}
-#endif
-	if (platform_bus_type.iommu_ops != ops) {
-		err = bus_set_iommu(&platform_bus_type, ops);
-		if (err)
-			goto err_reset_amba_ops;
-	}
-
-	return 0;
-
-err_reset_amba_ops:
-#ifdef CONFIG_ARM_AMBA
-	bus_set_iommu(&amba_bustype, NULL);
-#endif
-err_reset_pci_ops: __maybe_unused;
-#ifdef CONFIG_PCI
-	bus_set_iommu(&pci_bus_type, NULL);
-#endif
-	return err;
-}
-
 static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 				      resource_size_t size)
 {
@@ -3838,27 +3799,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_sysfs_remove;
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ret;
 	}
 
-	ret = arm_smmu_set_bus_ops(&arm_smmu_ops);
-	if (ret)
-		goto err_unregister_device;
-
 	return 0;
-
-err_unregister_device:
-	iommu_device_unregister(&smmu->iommu);
-err_sysfs_remove:
-	iommu_device_sysfs_remove(&smmu->iommu);
-	return ret;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	arm_smmu_set_bus_ops(NULL);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
-- 
2.35.3.dirty

