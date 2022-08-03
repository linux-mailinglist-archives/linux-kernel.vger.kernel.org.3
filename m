Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F662588CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiHCNHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiHCNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:07:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDFDDEA9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659532062; x=1691068062;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sInqaiCAPb9MV1x88tn2JQMyYANVNkkXOIJIYp+SHE8=;
  b=MAYsvTz8Wd8/S/S+ynG5O/4ypiSEazZNKlbJ4Nggg+p9x6e61HTCtWwO
   8/0Cy854ukV6ODk45b/fNvY6PX6gP6NjNpkElSCZIdP4IBsDlfTmvwMwR
   FiYrxrT/00lkC7iuuxCvE04XJD4smH4O8HPN63uFD4rG1Feo4nHfg3IDq
   DL14zd7u1FceViDehzYeZNgedC66SKJSFBBDYrkn8p5KvBIbrKbx45wNC
   TAvJy5ofGiCKg7+0IBgyX5yuj8S/ZAFO9JUWVtMHCvlauXObGYdbWs9SA
   b8Wf50lsKdt1rgOHoV08CqJ6CdFwSfh7XvqiVy/msWIUUoLxBpO0o/ToS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="375964956"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="375964956"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 06:07:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631141805"
Received: from smyang-mobl3.ccr.corp.intel.com (HELO [10.254.215.243]) ([10.254.215.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 06:07:37 -0700
Message-ID: <3eb62531-fa1c-4c78-c1d2-526a3758a033@linux.intel.com>
Date:   Wed, 3 Aug 2022 21:07:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
 <Yukac8X81CP7gDsM@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yukac8X81CP7gDsM@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/2 20:37, Jason Gunthorpe wrote:
> On Tue, Aug 02, 2022 at 10:19:08AM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 7/26/22 9:57 PM, Jason Gunthorpe wrote:
>>>> +	/*
>>>> +	 * Block PASID attachment in all cases where the PCI fabric is
>>>> +	 * routing based on address. ACS disables it.
>>>> +	 */
>>>> +	if (dev_is_pci(dev) &&
>>>> +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
>>>> +		return -ENODEV;
>>> I would probably still put this in a function just to be clear, and
>>> probably even a PCI layer funcion 'pci_is_pasid_supported' that
>>> clearly indicates that the fabric path can route a PASID packet
>>> without mis-routing it.
>>
>> I am fine with putting above in a function to make it clear. But I am
>> hesitant to move this part of logic into the PCI layer.
>>
>>  From the perspective of IOMMU, TLPs with PASID prefix form distinct
>> address spaces, so it's reasonable to require ACS protection on the
>> upstream path.
>>
>> But PCI spec doesn't require this. The interfaces defined in drivers/pci
>> /ats.c should work as well even the IOMMU is disabled.
> 
> No, I don't think so, that is useless.
> 
> PCI SIG has given a bunch of tools, and it is up to the system
> software to figure out how to use them.
> 
> There is no reasonable case where Linux would want PASID and broken
> fabric routing - so just block it at the PCI layer.

Okay. I will follow. Thank you for the confirmation.

> 
>> Yes, agreed. The iommu groups are not an issue any more. But just like
>> iommu_attach_device(), if multiple devices share a group, there must be
>> some mechanism to make sure that device drivers are aware of this fact
>> and only attach a shared domain to any PASID of those devices.'
>> Otherwise, the iommu_attach/detach_dev_pasid() might be misused.
> 
> I think it is the same as the existing attach logic for groups, with
> the sharing, owern and everything else did. No change for pasid.

Agreed. This is a complete scheme. I updated this patch accordingly. Can
you please help to give it a quick review?

[PATCH 04/12] iommu: Add attach/detach_dev_pasid iommu interfaces

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

  - SVA (Shared Virtual Address)
  - kernel DMA with PASID
  - hardware-assist mediated device

This adds set_dev_pasid domain ops for this purpose and also adds some
interfaces for device drivers to attach/detach a domain to/from a PASID
of a device.

The device drivers should use below interfaces to claim the ownership of
a device before attaching domain to it, and release the ownership after
detaching the domain.

int iommu_device_claim_pasid_owner(struct device *dev,
			ioasid_t pasid, void *owner)
void iommu_device_release_pasid_owner(struct device *dev,
			ioasid_t pasid)

After the ownership claimed successfully, the device drivers could use
below interfaces for domain attaching and detaching. The owner token
passed to iommu_attach_device_pasid() must match the one used to claim
the ownership.

int iommu_attach_device_pasid(struct iommu_domain *domain,
			struct device *dev, ioasid_t pasid,
                         void *owner)
void iommu_detach_device_pasid(struct iommu_domain *domain,
			struct device *dev, ioasid_t pasid)

This also adds below interface to retrieve the domain that has been
attached to a PASID of the device. This is only for uses in the IOMMU
subsystem. For example, the I/O page fault handling framework could use
it to get the domain from a {device, PASID} pair reported by hardware,
and the IOMMU device drivers could use it to get the existing domain
when a blocking domain is about to set.

struct iommu_domain *ommu_get_domain_for_dev_pasid(struct device *dev,
			ioasid_t pasid);

[--tags skipped--]
---
  drivers/iommu/iommu.c | 227 ++++++++++++++++++++++++++++++++++++++++++
  include/linux/iommu.h |  36 +++++++
  2 files changed, 263 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63fc4317cb47..fd105441ca4d 100644
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
@@ -58,6 +59,13 @@ struct group_device {
  	char *name;
  };

+struct group_pasid {
+	struct iommu_domain *domain;
+	unsigned int attach_cnt;
+	unsigned int owner_cnt;
+	void *owner;
+};
+
  struct iommu_group_attribute {
  	struct attribute attr;
  	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -663,6 +671,7 @@ struct iommu_group *iommu_group_alloc(void)
  	mutex_init(&group->mutex);
  	INIT_LIST_HEAD(&group->devices);
  	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);

  	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
  	if (ret < 0) {
@@ -3254,3 +3263,221 @@ bool iommu_group_dma_owner_claimed(struct 
iommu_group *group)
  	return user;
  }
  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+static int __iommu_attach_group_pasid(struct iommu_domain *domain,
+				      struct iommu_group *group,
+				      ioasid_t pasid)
+{
+	struct group_device *device;
+	int ret = 0;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	list_for_each_entry(device, &group->devices, list) {
+		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * iommu_device_claim_pasid_owner() - Set ownership of a pasid on device
+ * @dev: the device.
+ * @pasid: the pasid of the device.
+ * @owner: caller specified pointer. Used for exclusive ownership.
+ *
+ * Return 0 if it is allowed, otherwise an error.
+ */
+int iommu_device_claim_pasid_owner(struct device *dev, ioasid_t pasid, 
void *owner)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	struct group_pasid *group_pasid;
+	void *curr;
+	int ret;
+
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	group_pasid = xa_load(&group->pasid_array, pasid);
+	if (group_pasid) {
+		if (group_pasid->owner != owner) {
+			ret = -EBUSY;
+			goto err_unlock;
+		}
+		group_pasid->owner_cnt++;
+		goto out;
+	}
+
+	group_pasid = kzalloc(sizeof(*group_pasid), GFP_KERNEL);
+	if (!group_pasid) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	group_pasid->owner = owner;
+	group_pasid->owner_cnt = 1;
+	curr = xa_store(&group->pasid_array, pasid, group_pasid, GFP_KERNEL);
+	if (curr) {
+		ret = xa_err(curr) ? : -EBUSY;
+		goto err_free;
+	}
+out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return 0;
+
+err_free:
+	kfree(group_pasid);
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_device_claim_pasid_owner);
+
+/**
+ * iommu_device_release_pasid_owner() - Release ownership of a pasid on 
device
+ * @group: The group.
+ *
+ * Release the pasid ownership claimed by iommu_device_claim_pasid_owner().
+ */
+void iommu_device_release_pasid_owner(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	struct group_pasid *group_pasid;
+
+	mutex_lock(&group->mutex);
+	group_pasid = xa_load(&group->pasid_array, pasid);
+	if (WARN_ON(!group_pasid))
+		goto unlock_out;
+
+	if (--group_pasid->owner_cnt == 0) {
+		if (WARN_ON(group_pasid->attach_cnt))
+			goto unlock_out;
+		xa_erase(&group->pasid_array, pasid);
+		kfree(group_pasid);
+	}
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_device_release_pasid_owner);
+
+/**
+ * iommu_attach_device_pasid() - Attach a domain to pasid of device
+ * @domain: the iommu domain.
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ * @owner: the ownership token.
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      void *owner)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	struct group_pasid *group_pasid;
+	int ret = 0;
+
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	group_pasid = xa_load(&group->pasid_array, pasid);
+	if (!group_pasid || group_pasid->owner != owner) {
+		ret = -EPERM;
+		goto unlock_out;
+	}
+
+	if (group_pasid->domain && group_pasid->domain != domain) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	if (!group_pasid->attach_cnt) {
+		ret = __iommu_attach_group_pasid(domain, group, pasid);
+		if (ret)
+			__iommu_attach_group_pasid(group->blocking_domain,
+						   group, pasid);
+	}
+
+	if (!ret)
+		group_pasid->attach_cnt++;
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
+
+/**
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
+	struct group_pasid *group_pasid;
+
+	mutex_lock(&group->mutex);
+	group_pasid = xa_load(&group->pasid_array, pasid);
+	if (!WARN_ON(!group_pasid || group_pasid->domain != domain) &&
+	    --group_pasid->attach_cnt == 0) {
+		__iommu_attach_group_pasid(group->blocking_domain, group, pasid);
+		group_pasid->domain = NULL;
+	}
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
+
+/**
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
+	struct group_pasid *group_pasid;
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
+	group_pasid = xa_load(&group->pasid_array, pasid);
+	iommu_group_put(group);
+
+	return group_pasid ? group_pasid->domain : NULL;
+}
+EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_pasid);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2f237c3cd680..437980c54bb6 100644
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
@@ -680,6 +683,16 @@ int iommu_group_claim_dma_owner(struct iommu_group 
*group, void *owner);
  void iommu_group_release_dma_owner(struct iommu_group *group);
  bool iommu_group_dma_owner_claimed(struct iommu_group *group);

+int iommu_device_claim_pasid_owner(struct device *dev,
+				   ioasid_t pasid, void *owner);
+void iommu_device_release_pasid_owner(struct device *dev, ioasid_t pasid);
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      void *owner);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
  #else /* CONFIG_IOMMU_API */

  struct iommu_ops {};
@@ -1047,6 +1060,29 @@ static inline bool 
iommu_group_dma_owner_claimed(struct iommu_group *group)
  {
  	return false;
  }
+
+static inline int
+iommu_device_claim_pasid_owner(struct device *dev, ioasid_t pasid, void 
*owner)
+{
+	return -ENODEV;
+}
+
+static inline void
+iommu_device_release_pasid_owner(struct device *dev, ioasid_t pasid)
+{
+}
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid,
+					    void *owner)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
+					     struct device *dev, ioasid_t pasid)
+{
+}
  #endif /* CONFIG_IOMMU_API */

Best regards,
baolu
