Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79FE580B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiGZG13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiGZG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:27:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C5DF53
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658816613; x=1690352613;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hNL6tcITzlHVuP1y/APtKz0FFvD/P1YcuLKevDlDZb8=;
  b=ODt9DW7MeEotra72Ed4zK7LJMrA/+EgrlTpq/ms77YRRxGX74mMExiR8
   j60p0uydUP3+dXQx8Fp+VMC7Rc2VFw4bpii4I02n4XOQPjjvZSI1oJ8cW
   RtUPAexfXELSxWksmYqssqs7QYGKcSkeP6K2lcif/xenxz1eeRgDwrAGe
   bEUVC8gTX7xCb/f9d7e2mzqqgXIXwbpVdtypOrcg2eJsetU/3cGibEw/f
   m4lSDPPtexbAq2AbULoQLYpoqe3q/fmShsslp5vBL0Up8BtzbD6f3Irlo
   /p943lG3GIgc/Nwz+Gi/9u/ixIHNwMi8KWeuG/GD7b3/yt8d4s9ACtaqD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313631286"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313631286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 23:23:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575359485"
Received: from hzhi-mobl4.ccr.corp.intel.com (HELO [10.255.30.159]) ([10.255.30.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 23:23:28 -0700
Message-ID: <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
Date:   Tue, 26 Jul 2022 14:23:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220725144005.GE3747@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/25 22:40, Jason Gunthorpe wrote:
> On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:
> 
>> How about rephrasing this part of commit message like below:
>>
>> Some buses, like PCI, route packets without considering the PASID value.
>> Thus a DMA target address with PASID might be treated as P2P if the
>> address falls into the MMIO BAR of other devices in the group. To make
>> things simple, these interfaces only apply to devices belonging to the
>> singleton groups.
> 
>   
>> Considering that the PCI bus supports hot-plug, even a device boots with
>> a singleton group, a later hot-added device is still possible to share
>> the group, which breaks the singleton group assumption. In order to
>> avoid this situation, this interface requires that the ACS is enabled on
>> all devices on the path from the device to the host-PCI bridge.
> 
> But ACS directly fixes the routing issue above
> 
> This entire explanation can be recast as saying we block PASID
> attachment in all cases where the PCI fabric is routing based on
> address. ACS disables that.
> 
> Not sure it even has anything to do with hotplug or singleton??

Yes, agreed. I polished this patch like below. Does it look good to you?

iommu: Add attach/detach_dev_pasid iommu interface

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

  - SVA (Shared Virtual Address)
  - kernel DMA with PASID
  - hardware-assist mediated device

This adds a pair of domain ops for this purpose and adds the interfaces
for device drivers to attach/detach a domain to/from a {device, PASID}.
The PCI bus routes packets without considering the PASID value. Thus a
DMA target address with PASID might be treated as P2P if the address
falls into the MMIO BAR of other devices in the group. This blocks the
PASID attachment in all cases where the PCI fabric is routing based on
address. The ACS disables that.

[...]
---
  drivers/iommu/iommu.c | 70 +++++++++++++++++++++++++++++++++++++++++++
  include/linux/iommu.h | 18 +++++++++++
  2 files changed, 88 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63fc4317cb47..493db6e9302f 100644
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
@@ -3254,3 +3256,71 @@ bool iommu_group_dma_owner_claimed(struct 
iommu_group *group)
  	return user;
  }
  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
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
+	void *curr;
+	int ret;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Block PASID attachment in all cases where the PCI fabric is
+	 * routing based on address. ACS disables it.
+	 */
+	if (dev_is_pci(dev) &&
+	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
+		return -ENODEV;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
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
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2f237c3cd680..2c385e6d4b1a 100644
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
@@ -680,6 +683,10 @@ int iommu_group_claim_dma_owner(struct iommu_group 
*group, void *owner);
  void iommu_group_release_dma_owner(struct iommu_group *group);
  bool iommu_group_dma_owner_claimed(struct iommu_group *group);

+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
  #else /* CONFIG_IOMMU_API */

  struct iommu_ops {};
@@ -1047,6 +1054,17 @@ static inline bool 
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
  #endif /* CONFIG_IOMMU_API */

  /**

Best regards,
baolu

