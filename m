Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861685849E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiG2CtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2CtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:49:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C581C61723
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659062951; x=1690598951;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=olo0bzw+vXINDWd3BWcSHONSjh9gy21tiHNZrzdJyYA=;
  b=lZVevqa2ZkV3PutCqc5cKSGhZmTAKi/wwku4ZSwiW/la06Jv7CXjpEQi
   ITxKJ/OsYH8eGZWH9g/UcOaPODVnkK+696512ZKu2NaStowUM/DJCxHWN
   UWusyZgt9QAYKsZ8I2sGd7O3zu5+AoMB7BgY2bHjFndgrP/E0AvLgq2cg
   wwLObY3kD5RCXWe+ECN7QlN4Y2ev+E11bwt4ew/BGbRCH+6hfPPQLN14y
   +Hk3X9bsuVjDmRB78g1dqHc58qZiztV6DUag79IPPgu4b2h6SktMVTOVQ
   /jqYavxLkgWNWYeQOKmxA9tw1HWwSk8+QaAIhVNZX/y7v8PlniWYIO3Gv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289444876"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289444876"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:49:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="633974963"
Received: from xianrong-mobl.ccr.corp.intel.com (HELO [10.255.29.50]) ([10.255.29.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:49:06 -0700
Message-ID: <78376ca4-9b55-7609-abf1-27a1a376a8e0@linux.intel.com>
Date:   Fri, 29 Jul 2022 10:49:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YuJ6MXoNTj0RKCb8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/28 19:59, Jason Gunthorpe wrote:
> On Thu, Jul 28, 2022 at 03:06:47AM +0000, Tian, Kevin wrote:
> 
>>> Then we don't need this weirdo check in the core iommu code at all.
>>
>> and then we could also move group->pasid_array to device->pasid_array
>> with this approach. Though the end result doesn't change i.e. still only
>> the singleton group can enable pasid the iommu core can just stick to
>> the device manner now.
> 
> I don't see why, the group is still logically the unit of attachment
> in the iommu area, and if we have a multi-device group it just means
> we iterate over all the devices in the group when doing pasid set, no
> different than a RID.

Okay. Based on the discussions in this thread, this patch will evolve to
look like below. Any comments or concerns?

[PATCH 04/12] iommu: Add attach/detach_dev_pasid iommu interface

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

  - SVA (Shared Virtual Address)
  - kernel DMA with PASID
  - hardware-assist mediated device

This adds set_dev_pasid domain ops for this purpose and also adds some
interfaces for device drivers to attach/detach/retrieve a domain for a
PASID of a device.

Multiple devices in an iommu group cannot be isolated from each other,
then it's also difficult to ensure that their pasid address spaces are
isolated without any guarantee of hardware mechanism. To make things
simple, this starts the PASID attach/detach support from the devices
belonging to singleton groups.

Some configurations of the PCI fabric will route device originated TLP
packets based on the memory addresses. These configurations are
incompatible with PASID as the PASID packets form a distinct address
space. For instance, any configuration where switches are present
without ACS enabled is incompatible. In the future, we can further
discuss the possibility of moving this restriction into PCI subsystem
and making it a prerequisite of pci_enable_pasid().

[--tags removed --]

---
  include/linux/iommu.h |  26 ++++++++
  drivers/iommu/iommu.c | 146 ++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 172 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2f237c3cd680..f1e8953b1e2e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,7 @@ struct iommu_ops {
   * struct iommu_domain_ops - domain specific operations
   * @attach_dev: attach an iommu domain to a device
   * @detach_dev: detach an iommu domain from a device
+ * @set_dev_pasid: set an iommu domain to a pasid of device
   * @map: map a physically contiguous memory region to an iommu domain
   * @map_pages: map a physically contiguous set of pages of the same 
size to
   *             an iommu domain.
@@ -286,6 +287,8 @@ struct iommu_ops {
  struct iommu_domain_ops {
  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+			     ioasid_t pasid);

  	int (*map)(struct iommu_domain *domain, unsigned long iova,
  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -680,6 +683,12 @@ int iommu_group_claim_dma_owner(struct iommu_group 
*group, void *owner);
  void iommu_group_release_dma_owner(struct iommu_group *group);
  bool iommu_group_dma_owner_claimed(struct iommu_group *group);

+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
  #else /* CONFIG_IOMMU_API */

  struct iommu_ops {};
@@ -1047,6 +1056,23 @@ static inline bool 
iommu_group_dma_owner_claimed(struct iommu_group *group)
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
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
  #endif /* CONFIG_IOMMU_API */

  /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63fc4317cb47..46b8bffddc4d 100644
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
@@ -663,6 +664,7 @@ struct iommu_group *iommu_group_alloc(void)
  	mutex_init(&group->mutex);
  	INIT_LIST_HEAD(&group->devices);
  	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);

  	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
  	if (ret < 0) {
@@ -890,6 +892,14 @@ int iommu_group_add_device(struct iommu_group 
*group, struct device *dev)
  	int ret, i = 0;
  	struct group_device *device;

+	/*
+	 * The iommu_attach_device_pasid() requires a singleton group.
+	 * Refuse to add a device into it if this assumption has been
+	 * made.
+	 */
+	if (!xa_empty(&group->pasid_array))
+		return -EBUSY;
+
  	device = kzalloc(sizeof(*device), GFP_KERNEL);
  	if (!device)
  		return -ENOMEM;
@@ -3254,3 +3264,139 @@ bool iommu_group_dma_owner_claimed(struct 
iommu_group *group)
  	return user;
  }
  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+/*
+ * Check the viability of PASID attach/detach on a @dev of a @group.
+ *
+ * Basically we don't support pasid attach/detach on multi-device groups.
+ * Multiple devices in an iommu group cannot be isolated from each other,
+ * then it's also difficult to ensure that their pasid address spaces are
+ * isolated without any guarantee of hardware mechanism. To make things
+ * simple, let's start the PASID attach/detach support from the devices
+ * belonging to singleton groups.
+ *
+ * Some configurations of the PCI fabric will route device originated TLP
+ * packets based on memory address, and these configurations are
+ * incompatible with PASID as the PASID packets form a distinct address
+ * space. For instance any configuration where switches are present
+ * without ACS enabled is incompatible.
+ */
+static bool iommu_group_device_pasid_viable(struct iommu_group *group,
+					    struct device *dev)
+{
+	int count;
+
+	count = iommu_group_device_count(group);
+	if (count != 1)
+		return false;
+
+	/*
+	 * Block PASID attachment in cases where the PCI fabric is
+	 * routing based on address. PCI/ACS disables that.
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
+/*
+ * iommu_attach_device_pasid() - Attach a domain to pasid of device
+ * @domain: the iommu domain.
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -ENODEV;
+	void *curr;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	if (!iommu_group_device_pasid_viable(group, dev))
+		goto out_unlock;
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
+/*
+ * iommu_detach_device_pasid() - Detach the domain from pasid of device
+ * @domain: the iommu domain.
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ *
+ * The @domain must have been attached to @pasid of the @dev with
+ * iommu_detach_device_pasid().
+ */
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
+			       ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	mutex_lock(&group->mutex);
+	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
+	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
+
+/*
+ * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
+ * @dev: the queried device
+ * @pasid: the pasid of the device
+ *
+ * This is a variant of iommu_get_domain_for_dev(). It returns the existing
+ * domain attached to pasid of a device. It's only for internal use of the
+ * IOMMU subsystem. The caller must take care to avoid any possible
+ * use-after-free case.
+ *
+ * Return: attached domain on success, NULL otherwise.
+ */
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	if (!pasid_valid(pasid))
+		return NULL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+	/*
+	 * The xarray protects its internal state with RCU. Hence the domain
+	 * obtained is either NULL or fully formed.
+	 */
+	domain = xa_load(&group->pasid_array, pasid);
+	iommu_group_put(group);
+
+	return domain;
+}

Best regards,
baolu
