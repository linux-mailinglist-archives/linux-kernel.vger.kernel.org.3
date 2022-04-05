Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC94F4C78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445290AbiDEXWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiDELQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:16:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8417DF56;
        Tue,  5 Apr 2022 03:41:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36D91474;
        Tue,  5 Apr 2022 03:41:10 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CDD73F5A1;
        Tue,  5 Apr 2022 03:41:09 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v3 1/4] iommu: Introduce device_iommu_capable()
Date:   Tue,  5 Apr 2022 11:41:01 +0100
Message-Id: <37ec2f9f67098d0caf60dcec558fbe1756ea2621.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649089693.git.robin.murphy@arm.com>
References: <cover.1649089693.git.robin.murphy@arm.com>
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

iommu_capable() only really works for systems where all IOMMU instances
are completely homogeneous, and all devices are IOMMU-mapped. Implement
the new variant which can give an accurate answer for whichever device
the caller is actually interested in.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: New patch; now that the dev_iommu_ops() work has landed we can go
    straight to a proper implementation. Also s/dev/device/ to match
    the precedent of device_iommu_mapped() for the public API.

 drivers/iommu/amd/iommu.c                   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  2 +-
 drivers/iommu/intel/iommu.c                 |  2 +-
 drivers/iommu/iommu.c                       | 25 ++++++++++++++++++++-
 drivers/iommu/s390-iommu.c                  |  2 +-
 include/linux/iommu.h                       |  8 ++++++-
 9 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1160a13c80ab..e412a50dce59 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2132,7 +2132,7 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 	return ops->iova_to_phys(ops, iova);
 }
 
-static bool amd_iommu_capable(enum iommu_cap cap)
+static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 73b7b1b17b77..b221525c31b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1981,7 +1981,7 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 };
 
 /* IOMMU API */
-static bool arm_smmu_capable(enum iommu_cap cap)
+static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index f0bec4a35df5..34cab56b9c6d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1313,7 +1313,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return ops->iova_to_phys(ops, iova);
 }
 
-static bool arm_smmu_capable(enum iommu_cap cap)
+static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 80af00f468b4..028649203d33 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -493,7 +493,7 @@ static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static bool qcom_iommu_capable(enum iommu_cap cap)
+static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 7274f86b2bc4..ddf5ab28615c 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -177,7 +177,7 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
 	return iova;
 }
 
-static bool fsl_pamu_capable(enum iommu_cap cap)
+static bool fsl_pamu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return cap == IOMMU_CAP_CACHE_COHERENCY;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 21111491ddfd..255304eb3b1f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4544,7 +4544,7 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static bool intel_iommu_capable(enum iommu_cap cap)
+static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
 		return domain_update_iommu_snooping(NULL);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index efad7c1675e0..469574e84e6a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1889,12 +1889,35 @@ static int iommu_bus_init(struct bus_type *bus)
 	return err;
 }
 
+/**
+ * device_iommu_capable() - check for a general IOMMU capability
+ * @dev: device to which the capability would be relevant, if available
+ * @cap: IOMMU capability
+ *
+ * Return: true if an IOMMU is present and supports the given capability
+ * for the given device, otherwise false.
+ */
+bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	const struct iommu_ops *ops;
+
+	if (!dev->iommu || !dev->iommu->iommu_dev)
+		return false;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->capable)
+		return false;
+
+	return ops->capable(dev, cap);
+}
+EXPORT_SYMBOL_GPL(device_iommu_capable);
+
 bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	if (!bus->iommu_ops || !bus->iommu_ops->capable)
 		return false;
 
-	return bus->iommu_ops->capable(cap);
+	return bus->iommu_ops->capable(NULL, cap);
 }
 EXPORT_SYMBOL_GPL(iommu_capable);
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 5f5f4bd91e6f..ea4ba9de04af 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -39,7 +39,7 @@ static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
 	return container_of(dom, struct s390_domain, domain);
 }
 
-static bool s390_iommu_capable(enum iommu_cap cap)
+static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4a25f8241207..1fa927e6f1c6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -219,7 +219,7 @@ struct iommu_iotlb_gather {
  * @owner: Driver module providing these ops
  */
 struct iommu_ops {
-	bool (*capable)(enum iommu_cap);
+	bool (*capable)(struct device *dev, enum iommu_cap);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
@@ -415,6 +415,7 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
 extern int bus_iommu_probe(struct bus_type *bus);
+extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct device *dev);
 extern struct iommu_group *iommu_group_get_by_id(int id);
@@ -682,6 +683,11 @@ struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
 
+static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	return false;
+}
+
 static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	return false;
-- 
2.28.0.dirty

