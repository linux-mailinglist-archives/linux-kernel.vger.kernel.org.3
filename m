Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57728593307
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiHOQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiHOQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CB12DF01
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9236E106F;
        Mon, 15 Aug 2022 09:20:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 593C13F70D;
        Mon, 15 Aug 2022 09:20:41 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/16] iommu/mtk: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:13 +0100
Message-Id: <9134322ecd24030eebeac73f37ca579094cc7df0.1660572783.git.robin.murphy@arm.com>
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
the probe failure paths accordingly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/mtk_iommu.c    | 24 +-----------------------
 drivers/iommu/mtk_iommu_v1.c | 13 +------------
 2 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..552e4eb8c610 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1243,30 +1243,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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
@@ -1294,11 +1277,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
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
index 128c7a3f1778..6e0e65831eb7 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -691,19 +691,11 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
@@ -718,9 +710,6 @@ static int mtk_iommu_v1_remove(struct platform_device *pdev)
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

