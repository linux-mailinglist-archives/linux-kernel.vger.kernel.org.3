Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82D5134E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiD1NVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346998AbiD1NVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:21:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12E28D69D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:18:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E7B1477;
        Thu, 28 Apr 2022 06:18:34 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F8653F73B;
        Thu, 28 Apr 2022 06:18:31 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device registration
Date:   Thu, 28 Apr 2022 14:18:04 +0100
Message-Id: <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
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

Move the bus setup to iommu_device_register(). This should allow
bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.

At this point we can also handle cleanup better than just rolling back
the most-recently-touched bus upon failure - which may release devices
owned by other already-registered instances, and still leave devices on
other buses with dangling pointers to the failed instance. Now it's easy
to clean up the exact footprint of a given instance, no more, no less.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 51 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6c4621afc8cf..c89af4dc54c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -175,6 +175,14 @@ static int __init iommu_subsys_init(void)
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
@@ -197,12 +205,29 @@ int iommu_device_register(struct iommu_device *iommu,
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		struct bus_type *bus = iommu_buses[i];
+		int err;
+
+		WARN_ON(bus->iommu_ops && bus->iommu_ops != ops);
+		bus->iommu_ops = ops;
+		err = bus_iommu_probe(bus);
+		if (err) {
+			iommu_device_unregister(iommu);
+			return err;
+		}
+	}
+
 	return 0;
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
@@ -1655,13 +1680,6 @@ static int probe_iommu_group(struct device *dev, void *data)
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
@@ -1884,27 +1902,12 @@ static int iommu_bus_init(struct bus_type *bus)
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
2.35.3.dirty

