Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762D59330B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiHOQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiHOQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F23941D30A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B08113E;
        Mon, 15 Aug 2022 09:20:48 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DAC43F70D;
        Mon, 15 Aug 2022 09:20:46 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/16] iommu/virtio: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:16 +0100
Message-Id: <0ff6f9166081724510e6772e43d45b317cab8c58.1660572783.git.robin.murphy@arm.com>
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

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/virtio-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..31ab9d622b67 100644
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
@@ -1145,26 +1143,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
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
@@ -1173,9 +1151,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
-err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
-	iommu_device_unregister(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.36.1.dirty

