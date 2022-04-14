Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A3500DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiDNMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243472AbiDNMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:45:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 622DC85666
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:42:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A44139F;
        Thu, 14 Apr 2022 05:42:52 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B9943F70D;
        Thu, 14 Apr 2022 05:42:50 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Date:   Thu, 14 Apr 2022 13:42:31 +0100
Message-Id: <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
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

Move the bus setup to iommu_device_register(). This should allow
bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
and leaves bus_set_iommu() as a glorfied no-op to be cleaned up next.

Note that although the handling of errors from bus_iommu_probe() looks
inadequate, it is merely preserving the well-established existing
behaviour. This could be improved in future - probably combined with
equivalent cleanup for iommu_device_unregister() - but that isn't a
priority right now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13e1a8bd5435..51205c33c426 100644
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
@@ -197,6 +205,22 @@ int iommu_device_register(struct iommu_device *iommu,
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		struct bus_type *bus = iommu_buses[i];
+		const struct iommu_ops *bus_ops = bus->iommu_ops;
+		int err;
+
+		WARN_ON(bus_ops && bus_ops != ops);
+		bus->iommu_ops = ops;
+		err = bus_iommu_probe(bus);
+		if (err) {
+			bus_for_each_dev(bus, NULL, iommu, remove_iommu_group);
+			bus->iommu_ops = bus_ops;
+			return err;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
@@ -1654,13 +1678,6 @@ static int probe_iommu_group(struct device *dev, void *data)
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
@@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct bus_type *bus)
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
2.28.0.dirty

