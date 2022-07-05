Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45665662A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiGEFME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGEFL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:11:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB313D16
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656997918; x=1688533918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eh7Ts/jrbu3gu6i73diB/9eZuSBu3uGNqSXuF4Z/1cg=;
  b=UO/yWV9PD6YZXBi6lCbsf3iU916Nq8DlCpC/LXjY2BOT8O9jjQ7yywQw
   XGonprDzDjitS/RBej7ckf4X1yIw3PO1lSiPwuiFDvbQm6STZwORknBsd
   RL4VfQP7aNZB7O8gqh3RsfmPy1WNL3BlM+EqFVKcyAi9PxsBMv8g9dv7y
   jcXsDMEJmqXhN/IBAlq7SJM44h+0Yn+K/iFbbHsQqN0V1pr36+E5XvLHj
   wV+Bgpix5Ubx87p0Pytbp1d6XCgxMa9bcHsG9mM6DVFyasZfRwp2cw+2+
   zM2F5pANDgjDHiwNkdaO7tnYEFWx4rdISixZTtejAu2WtV+U6GPYD4bCN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263046090"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263046090"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542807414"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 22:11:53 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu interface
Date:   Tue,  5 Jul 2022 13:07:02 +0800
Message-Id: <20220705050710.2887204-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

 - SVA (Shared Virtual Address)
 - kernel DMA with PASID
 - hardware-assist mediated device

This adds a pair of domain ops for this purpose and adds the interfaces
for device drivers to attach/detach a domain to/from a {device, PASID}.
Some buses, like PCI, route packets without considering the PASID value.
Thus a DMA target address with PASID might be treated as P2P if the
address falls into the MMIO BAR of other devices in the group. To make
things simple, these interfaces only apply to devices belonging to the
singleton groups, and the singleton is immutable in fabric (i.e. not
affected by hotplug).

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h | 21 ++++++++++++
 drivers/iommu/iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f41eb2b3c7da..f2b5aa7efe43 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -262,6 +262,8 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @block_dev_pasid: block pasid of device from using iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -282,6 +284,10 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+			     ioasid_t pasid);
+	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+				ioasid_t pasid);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -679,6 +685,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			      ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			       ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1052,6 +1062,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
+					     struct device *dev, ioasid_t pasid)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 74a0a3ec0907..be48b09371f4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -39,6 +39,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -660,6 +661,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
 	if (ret < 0) {
@@ -3271,3 +3273,76 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+static bool iommu_group_immutable_singleton(struct iommu_group *group,
+					    struct device *dev)
+{
+	int count;
+
+	mutex_lock(&group->mutex);
+	count = iommu_group_device_count(group);
+	mutex_unlock(&group->mutex);
+
+	if (count != 1)
+		return false;
+
+	/*
+	 * The PCI device could be considered to be fully isolated if all
+	 * devices on the path from the device to the host-PCI bridge are
+	 * protected from peer-to-peer DMA by ACS.
+	 */
+	if (dev_is_pci(dev))
+		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
+					    REQ_ACS_FLAGS);
+
+	/*
+	 * Otherwise, the device came from DT/ACPI, assume it is static and
+	 * then singleton can know from the device count in the group.
+	 */
+	return true;
+}
+
+int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			      ioasid_t pasid)
+{
+	struct iommu_group *group;
+	void *curr;
+	int ret;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	group = iommu_group_get(dev);
+	if (!group || !iommu_group_immutable_singleton(group, dev)) {
+		iommu_group_put(group);
+		return -EINVAL;
+	}
+
+	mutex_lock(&group->mutex);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr) {
+		ret = xa_err(curr) ? : -EBUSY;
+		goto out_unlock;
+	}
+	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
+			       ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	domain->ops->block_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
-- 
2.25.1

