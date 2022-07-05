Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDB567552
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiGERJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiGERJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:09:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083771EC61;
        Tue,  5 Jul 2022 10:09:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35CDC1596;
        Tue,  5 Jul 2022 10:09:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55B863F66F;
        Tue,  5 Jul 2022 10:09:01 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] iommu/mtk: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:34 +0100
Message-Id: <2a8ae79721a36c7b8960ce2ecb19ef5e202e36c2.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
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
the probe failure paths accordingly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Rebase around recent probe/remove changes

 drivers/iommu/mtk_iommu.c    | 24 +-----------------------
 drivers/iommu/mtk_iommu_v1.c | 13 +------------
 2 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb9dd92c9898..1a0780b65961 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1239,30 +1239,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->hw_list = &data->hw_list_head;
 	}
 
-	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
-		if (ret)
-			goto out_list_del;
-	}
-
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
-			goto out_bus_set_null;
-	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIE_SUPPORT)) {
-#ifdef CONFIG_PCI
-		if (!iommu_present(&pci_bus_type)) {
-			ret = bus_set_iommu(&pci_bus_type, &mtk_iommu_ops);
-			if (ret) /* PCIe fail don't affect platform_bus. */
-				goto out_list_del;
-		}
-#endif
+			goto out_list_del;
 	}
 	return ret;
 
-out_bus_set_null:
-	bus_set_iommu(&platform_bus_type, NULL);
 out_list_del:
 	list_del(&data->list);
 	iommu_device_unregister(&data->iommu);
@@ -1290,11 +1273,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
 		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIE_SUPPORT)) {
-#ifdef CONFIG_PCI
-		bus_set_iommu(&pci_bus_type, NULL);
-#endif
 	}
 	pm_runtime_disable(&pdev->dev);
 	for (i = 0; i < data->plat_data->banks_num; i++) {
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index e1cb51b9866c..e60e8890e45d 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -696,19 +696,11 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_sysfs_remove;
 
-	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type,  &mtk_iommu_v1_ops);
-		if (ret)
-			goto out_dev_unreg;
-	}
-
 	ret = component_master_add_with_match(dev, &mtk_iommu_v1_com_ops, match);
 	if (ret)
-		goto out_bus_set_null;
+		goto out_dev_unreg;
 	return ret;
 
-out_bus_set_null:
-	bus_set_iommu(&platform_bus_type, NULL);
 out_dev_unreg:
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
@@ -723,9 +715,6 @@ static int mtk_iommu_v1_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
 
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
-- 
2.36.1.dirty

