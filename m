Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8665932FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiHOQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiHOQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFAED11153
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E3F81D31;
        Mon, 15 Aug 2022 09:20:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 359793F70D;
        Mon, 15 Aug 2022 09:20:28 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/16] iommu: Always register bus notifiers
Date:   Mon, 15 Aug 2022 17:20:05 +0100
Message-Id: <7462347bf938bd6eedb629a3a318434f6516e712.1660572783.git.robin.murphy@arm.com>
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

The number of bus types that the IOMMU subsystem deals with is small and
manageable, so pull that list into core code as a first step towards
cleaning up all the boilerplate bus-awareness from drivers. Calling
iommu_probe_device() before bus->iommu_ops is set will simply return
-ENODEV and not break the notifier call chain, so there should be no
harm in proactively registering all our bus notifiers at init time.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: Squash iommu_bus_init() entirely, for maximum simplicity. Ignoring
    the return from bus_register_notifier() is common, so hopefully it's
    all pretty self-explanatory now.

 drivers/iommu/iommu.c | 72 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..a8d14f2a1035 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt)    "iommu: " fmt
 
+#include <linux/amba/bus.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/kernel.h>
@@ -16,11 +17,13 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
@@ -75,6 +78,8 @@ static const char * const iommu_group_resv_type_string[] = {
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
 #define IOMMU_CMD_LINE_STRICT		BIT(1)
 
+static int iommu_bus_notifier(struct notifier_block *nb,
+			      unsigned long action, void *data);
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
@@ -103,6 +108,22 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
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
+#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
+	&host1x_context_device_bus_type,
+#endif
+};
+
 /*
  * Use a function instead of an array here because the domain-type is a
  * bit-field, so an array would waste memory.
@@ -126,6 +147,8 @@ static const char *iommu_domain_type_str(unsigned int t)
 
 static int __init iommu_subsys_init(void)
 {
+	struct notifier_block *nb;
+
 	if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
 		if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
 			iommu_set_default_passthrough(false);
@@ -152,6 +175,15 @@ static int __init iommu_subsys_init(void)
 			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
 				"(set via kernel command line)" : "");
 
+	nb = kcalloc(ARRAY_SIZE(iommu_buses), sizeof(*nb), GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		nb[i].notifier_call = iommu_bus_notifier;
+		bus_register_notifier(iommu_buses[i], &nb[i]);
+	}
+
 	return 0;
 }
 subsys_initcall(iommu_subsys_init);
@@ -1775,39 +1807,6 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
-static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
-{
-	struct notifier_block *nb;
-	int err;
-
-	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
-	if (!nb)
-		return -ENOMEM;
-
-	nb->notifier_call = iommu_bus_notifier;
-
-	err = bus_register_notifier(bus, nb);
-	if (err)
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
-
-	return err;
-}
-
 /**
  * bus_set_iommu - set iommu-callbacks for the bus
  * @bus: bus.
@@ -1836,9 +1835,12 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
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
2.36.1.dirty

