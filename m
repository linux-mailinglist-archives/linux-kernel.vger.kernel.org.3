Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01259330D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiHOQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiHOQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DC9E1CFF9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E6A2106F;
        Mon, 15 Aug 2022 09:20:50 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9B2F3F70D;
        Mon, 15 Aug 2022 09:20:47 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/16] iommu: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:17 +0100
Message-Id: <ea383d5f4d74ffe200ab61248e5de6e95846180a.1660572783.git.robin.murphy@arm.com>
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

Clean up the remaining trivial bus_set_iommu() callsites along
with the implementation. Now drivers only have to know and care
about iommu_device instances, phew!

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/arm/arm-smmu/qcom_iommu.c |  4 ----
 drivers/iommu/fsl_pamu_domain.c         |  4 ----
 drivers/iommu/intel/iommu.c             |  2 --
 drivers/iommu/iommu.c                   | 24 ------------------------
 drivers/iommu/msm_iommu.c               |  2 --
 drivers/iommu/rockchip-iommu.c          |  2 --
 drivers/iommu/s390-iommu.c              |  6 ------
 drivers/iommu/sprd-iommu.c              |  5 -----
 drivers/iommu/sun50i-iommu.c            |  2 --
 include/linux/iommu.h                   |  1 -
 10 files changed, 52 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 17235116d3bb..a6aae2e20417 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -837,8 +837,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
-
 	if (qcom_iommu->local_base) {
 		pm_runtime_get_sync(dev);
 		writel_relaxed(0xffffffff, qcom_iommu->local_base + SMMU_INTR_SEL_NS);
@@ -856,8 +854,6 @@ static int qcom_iommu_device_remove(struct platform_device *pdev)
 {
 	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
 
-	bus_set_iommu(&platform_bus_type, NULL);
-
 	pm_runtime_force_suspend(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 011f9ab7f743..e4a6883228fd 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -476,11 +476,7 @@ int __init pamu_domain_init(void)
 	if (ret) {
 		iommu_device_sysfs_remove(&pamu_iommu);
 		pr_err("Can't register iommu device\n");
-		return ret;
 	}
 
-	bus_set_iommu(&platform_bus_type, &fsl_pamu_ops);
-	bus_set_iommu(&pci_bus_type, &fsl_pamu_ops);
-
 	return ret;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 65c340e2003c..85b09c34dc12 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3890,7 +3890,6 @@ static int __init probe_acpi_namespace_devices(void)
 					continue;
 				}
 
-				pn->dev->bus->iommu_ops = &intel_iommu_ops;
 				ret = iommu_probe_device(pn->dev);
 				if (ret)
 					break;
@@ -4023,7 +4022,6 @@ int __init intel_iommu_init(void)
 	}
 	up_read(&dmar_global_lock);
 
-	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4db0874a5ed6..daa4c7f17677 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1827,30 +1827,6 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
-/**
- * bus_set_iommu - set iommu-callbacks for the bus
- * @bus: bus.
- * @ops: the callbacks provided by the iommu-driver
- *
- * This function is called by an iommu driver to set the iommu methods
- * used for a particular bus. Drivers for devices on that bus can use
- * the iommu-api after these ops are registered.
- * This special function is needed because IOMMUs are usually devices on
- * the bus itself, so the iommu drivers are not initialized when the bus
- * is set up. With this function the iommu-driver can set the iommu-ops
- * afterwards.
- */
-int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
-{
-	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
-		return -EBUSY;
-
-	bus->iommu_ops = ops;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bus_set_iommu);
-
 bool iommu_present(struct bus_type *bus)
 {
 	return bus->iommu_ops != NULL;
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6a24aa804ea3..16179a9a7283 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -792,8 +792,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
-
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ab57c4b8fade..a3fc59b814ab 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1300,8 +1300,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
-	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
-
 	pm_runtime_enable(dev);
 
 	for (i = 0; i < iommu->num_irq; i++) {
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 8158a4ed0c60..762f892b4ec3 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -390,9 +390,3 @@ static const struct iommu_ops s390_iommu_ops = {
 		.free		= s390_domain_free,
 	}
 };
-
-static int __init s390_iommu_init(void)
-{
-	return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
-}
-subsys_initcall(s390_iommu_init);
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 511959c8a14d..fadd2c907222 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -496,9 +496,6 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_sysfs;
 
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &sprd_iommu_ops);
-
 	ret = sprd_iommu_clk_enable(sdev);
 	if (ret)
 		goto unregister_iommu;
@@ -534,8 +531,6 @@ static int sprd_iommu_remove(struct platform_device *pdev)
 	iommu_group_put(sdev->group);
 	sdev->group = NULL;
 
-	bus_set_iommu(&platform_bus_type, NULL);
-
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index a84c63518773..cd9b74ee24de 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -965,8 +965,6 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_unregister;
 
-	bus_set_iommu(&platform_bus_type, &sun50i_iommu_ops);
-
 	return 0;
 
 err_unregister:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..79b6fb3c6b84 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -416,7 +416,6 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-- 
2.36.1.dirty

