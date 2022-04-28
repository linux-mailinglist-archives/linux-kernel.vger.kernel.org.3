Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF55134E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbiD1NWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346988AbiD1NVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:21:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 052F3939D3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:18:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D244F1474;
        Thu, 28 Apr 2022 06:18:31 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C79543F73B;
        Thu, 28 Apr 2022 06:18:29 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] iommu: Always register bus notifiers
Date:   Thu, 28 Apr 2022 14:18:03 +0100
Message-Id: <26cc52902d2bd1232c2b777ff3b3c70248ca634d.1650890638.git.robin.murphy@arm.com>
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

The number of bus types that the IOMMU subsystem deals with is small and
manageable, so pull that list into core code as a first step towards
cleaning up all the boilerplate bus-awareness from drivers. Calling
iommu_probe_device() before bus->iommu_ops is set will simply return
-ENODEV and not break the notifier call chain, so there should be no
harm in proactively registering all our bus notifiers at init time.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-By: Krishna Reddy <vdumpa@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 49 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 00218b56a441..6c4621afc8cf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt)    "iommu: " fmt
 
+#include <linux/amba/bus.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/kernel.h>
@@ -22,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
@@ -74,6 +76,7 @@ static const char * const iommu_group_resv_type_string[] = {
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
 #define IOMMU_CMD_LINE_STRICT		BIT(1)
 
+static int iommu_bus_init(struct bus_type *bus);
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
@@ -102,6 +105,19 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 static LIST_HEAD(iommu_device_list);
 static DEFINE_SPINLOCK(iommu_device_lock);
 
+static struct bus_type * const iommu_buses[] = {
+	&platform_bus_type,
+#ifdef CONFIG_PCI
+	&pci_bus_type,
+#endif
+#ifdef CONFIG_ARM_AMBA
+	&amba_bustype,
+#endif
+#ifdef CONFIG_FSL_MC_BUS
+	&fsl_mc_bus_type,
+#endif
+};
+
 /*
  * Use a function instead of an array here because the domain-type is a
  * bit-field, so an array would waste memory.
@@ -151,6 +167,10 @@ static int __init iommu_subsys_init(void)
 			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
 				"(set via kernel command line)" : "");
 
+	/* If the system is so broken that this fails, it will WARN anyway */
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
+		iommu_bus_init(iommu_buses[i]);
+
 	return 0;
 }
 subsys_initcall(iommu_subsys_init);
@@ -1832,35 +1852,19 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
-static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
+static int iommu_bus_init(struct bus_type *bus)
 {
 	struct notifier_block *nb;
 	int err;
 
-	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
+	nb = kzalloc(sizeof(*nb), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	nb->notifier_call = iommu_bus_notifier;
-
 	err = bus_register_notifier(bus, nb);
 	if (err)
-		goto out_free;
-
-	err = bus_iommu_probe(bus);
-	if (err)
-		goto out_err;
-
-
-	return 0;
-
-out_err:
-	/* Clean up */
-	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
-	bus_unregister_notifier(bus, nb);
-
-out_free:
-	kfree(nb);
+		kfree(nb);
 
 	return err;
 }
@@ -1893,9 +1897,12 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 	bus->iommu_ops = ops;
 
 	/* Do IOMMU specific setup for this bus-type */
-	err = iommu_bus_init(bus, ops);
-	if (err)
+	err = bus_iommu_probe(bus);
+	if (err) {
+		/* Clean up */
+		bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
 		bus->iommu_ops = NULL;
+	}
 
 	return err;
 }
-- 
2.35.3.dirty

