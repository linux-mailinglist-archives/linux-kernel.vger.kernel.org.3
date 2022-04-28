Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C685134E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiD1NWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbiD1NWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:22:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FBC795A32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:18:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C34691477;
        Thu, 28 Apr 2022 06:18:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF08D3F73B;
        Thu, 28 Apr 2022 06:18:54 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/14] iommu/virtio: Clean up bus_set_iommu()
Date:   Thu, 28 Apr 2022 14:18:14 +0100
Message-Id: <096fa605b5f01df4c5627a6c8abb95f1b940f82f.1650890638.git.robin.murphy@arm.com>
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

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/virtio-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..bcbd10ec4ccb 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -7,7 +7,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/dma-map-ops.h>
@@ -17,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
-#include <linux/platform_device.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
@@ -1146,26 +1144,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
 
-#ifdef CONFIG_PCI
-	if (pci_bus_type.iommu_ops != &viommu_ops) {
-		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
-		if (ret)
-			goto err_unregister;
-	}
-#endif
-#ifdef CONFIG_ARM_AMBA
-	if (amba_bustype.iommu_ops != &viommu_ops) {
-		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
-		if (ret)
-			goto err_unregister;
-	}
-#endif
-	if (platform_bus_type.iommu_ops != &viommu_ops) {
-		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
-		if (ret)
-			goto err_unregister;
-	}
-
 	vdev->priv = viommu;
 
 	dev_info(dev, "input address: %u bits\n",
@@ -1174,9 +1152,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
-err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
-	iommu_device_unregister(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.35.3.dirty

