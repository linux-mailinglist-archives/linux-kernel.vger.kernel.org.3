Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EB5932FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiHOQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiHOQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF91313CFC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15E54113E;
        Mon, 15 Aug 2022 09:20:32 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D13C83F70D;
        Mon, 15 Aug 2022 09:20:29 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device registration
Date:   Mon, 15 Aug 2022 17:20:06 +0100
Message-Id: <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
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

Move the bus setup to iommu_device_register(). This should allow
bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.

At this point we can also handle cleanup better than just rolling back
the most-recently-touched bus upon failure - which may release devices
owned by other already-registered instances, and still leave devices on
other buses with dangling pointers to the failed instance. Now it's easy
to clean up the exact footprint of a given instance, no more, no less.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-By: Krishna Reddy <vdumpa@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: Factor out the ops check in iommu_device_register() to keep the loop
even simpler, and comment the nominal change in behaviour

 drivers/iommu/iommu.c | 55 +++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a8d14f2a1035..4db0874a5ed6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -188,6 +188,14 @@ static int __init iommu_subsys_init(void)
 }
 subsys_initcall(iommu_subsys_init);
 
+static int remove_iommu_group(struct device *dev, void *data)
+{
+	if (dev->iommu && dev->iommu->iommu_dev == data)
+		iommu_release_device(dev);
+
+	return 0;
+}
+
 /**
  * iommu_device_register() - Register an IOMMU hardware instance
  * @iommu: IOMMU handle for the instance
@@ -199,9 +207,18 @@ subsys_initcall(iommu_subsys_init);
 int iommu_device_register(struct iommu_device *iommu,
 			  const struct iommu_ops *ops, struct device *hwdev)
 {
+	int err = 0;
+
 	/* We need to be able to take module references appropriately */
 	if (WARN_ON(is_module_address((unsigned long)ops) && !ops->owner))
 		return -EINVAL;
+	/*
+	 * Temporarily enforce global restriction to a single driver. This was
+	 * already the de-facto behaviour, since any possible combination of
+	 * existing drivers would compete for at least the PCI or platform bus.
+	 */
+	if (iommu_buses[0]->iommu_ops && iommu_buses[0]->iommu_ops != ops)
+		return -EBUSY;
 
 	iommu->ops = ops;
 	if (hwdev)
@@ -210,12 +227,22 @@ int iommu_device_register(struct iommu_device *iommu,
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
-	return 0;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
+		iommu_buses[i]->iommu_ops = ops;
+		err = bus_iommu_probe(iommu_buses[i]);
+	}
+	if (err)
+		iommu_device_unregister(iommu);
+	return err;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
 
 void iommu_device_unregister(struct iommu_device *iommu)
 {
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
+		bus_for_each_dev(iommu_buses[i], NULL, iommu, remove_iommu_group);
+
 	spin_lock(&iommu_device_lock);
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
@@ -1644,13 +1671,6 @@ static int probe_iommu_group(struct device *dev, void *data)
 	return ret;
 }
 
-static int remove_iommu_group(struct device *dev, void *data)
-{
-	iommu_release_device(dev);
-
-	return 0;
-}
-
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
@@ -1822,27 +1842,12 @@ int bus_iommu_probe(struct bus_type *bus)
  */
 int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 {
-	int err;
-
-	if (ops == NULL) {
-		bus->iommu_ops = NULL;
-		return 0;
-	}
-
-	if (bus->iommu_ops != NULL)
+	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
 		return -EBUSY;
 
 	bus->iommu_ops = ops;
 
-	/* Do IOMMU specific setup for this bus-type */
-	err = bus_iommu_probe(bus);
-	if (err) {
-		/* Clean up */
-		bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
-		bus->iommu_ops = NULL;
-	}
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(bus_set_iommu);
 
-- 
2.36.1.dirty

