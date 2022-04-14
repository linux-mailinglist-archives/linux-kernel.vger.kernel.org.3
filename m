Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27404500DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbiDNMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243520AbiDNMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:45:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 198E18D6B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:43:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4A815DB;
        Thu, 14 Apr 2022 05:43:07 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA21F3F70D;
        Thu, 14 Apr 2022 05:43:05 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] iommu/mtk: Clean up bus_set_iommu()
Date:   Thu, 14 Apr 2022 13:42:38 +0100
Message-Id: <cad5008c73c0d3ee1b31daa456f901ee9fbb8409.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/iommu/mtk_iommu.c    | 13 +------------
 drivers/iommu/mtk_iommu_v1.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fd75a60abd6..4278d9e032ad 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -920,19 +920,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	spin_lock_init(&data->tlb_lock);
 	list_add_tail(&data->list, &m4ulist);
 
-	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
-		if (ret)
-			goto out_list_del;
-	}
-
 	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 	if (ret)
-		goto out_bus_set_null;
+		goto out_list_del;
 	return ret;
 
-out_bus_set_null:
-	bus_set_iommu(&platform_bus_type, NULL);
 out_list_del:
 	list_del(&data->list);
 	iommu_device_unregister(&data->iommu);
@@ -952,9 +944,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
 
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
 	clk_disable_unprepare(data->bclk);
 	device_link_remove(data->smicomm_dev, &pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ecff800656e6..7d17d6a21803 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -660,19 +660,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_sysfs_remove;
 
-	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type,  &mtk_iommu_ops);
-		if (ret)
-			goto out_dev_unreg;
-	}
-
 	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 	if (ret)
-		goto out_bus_set_null;
+		goto out_dev_unreg;
 	return ret;
 
-out_bus_set_null:
-	bus_set_iommu(&platform_bus_type, NULL);
 out_dev_unreg:
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
@@ -687,9 +679,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
 
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-- 
2.28.0.dirty

