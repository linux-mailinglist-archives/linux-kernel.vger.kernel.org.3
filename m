Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFE50E099
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiDYMpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiDYMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:45:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58C70DA6D9;
        Mon, 25 Apr 2022 05:42:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22446113E;
        Mon, 25 Apr 2022 05:42:12 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEB763F5A1;
        Mon, 25 Apr 2022 05:42:10 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     baolu.lu@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, iommu@lists.linux-foundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v4 1/4] iommu: Introduce device_iommu_capable()
Date:   Mon, 25 Apr 2022 13:42:02 +0100
Message-Id: <8407eb9586677995b7a9fd70d0fd82d85929a9bb.1650878781.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650878781.git.robin.murphy@arm.com>
References: <cover.1650878781.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_capable() only really works for systems where all IOMMU instances
are completely homogeneous, and all devices are IOMMU-mapped. Implement
the new variant which will be able to give a more accurate answer for
whichever device the caller is actually interested in, and even more so
once all the external users have been converted and we can reliably pass
the device pointer through the internal driver interface too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: Hold off changing the internal callback interface for now

 drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
 include/linux/iommu.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..780c11734979 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1906,6 +1906,29 @@ bool iommu_present(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
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
+	return ops->capable(cap);
+}
+EXPORT_SYMBOL_GPL(device_iommu_capable);
+
 bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	if (!bus->iommu_ops || !bus->iommu_ops->capable)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..e26cf84e5d82 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -417,6 +417,7 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
+extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
@@ -689,6 +690,11 @@ static inline bool iommu_present(struct bus_type *bus)
 	return false;
 }
 
+static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	return false;
+}
+
 static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	return false;
-- 
2.35.3.dirty

