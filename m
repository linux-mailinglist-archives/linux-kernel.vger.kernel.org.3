Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ECA533D68
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiEYNLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244220AbiEYNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:11:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A32E25
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653484292; x=1685020292;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ymcJkTLYpSMvn3R3fEnLHlEXa0nJaOVJzYIj+XJqO9o=;
  b=gEi/LDNGPgUumpYY4AtEzheZIP060YieoqnXvUMWBp2J8IrUUNwaGYDQ
   +Twpys5NnkSCaOMIgoUTlk6h4Ylc7zR/yCMHMBMB5+UXmjLGhByGbm6J4
   U1UiYmJKWDe/34yEestoaakPpvOQQ2PdPL3Ckroo+qAUsJRHhH/58M6Ev
   ZcyGdrWTJTQ0PcYwRe9W0jVWd0xsKx31wuKn06ZnTpQpU9QU9E/sbd3p1
   7FI0lraJiRDkVmWOQWEYrc2rQ6EoVKTb8a/q3Q8O9TtjTLi3IQMnO9lio
   sD/0ncJtnvHqcKdUGEQcZ3tmY3NoWk9fH0IJ12moawSg7wiZAAbMquHMh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336860741"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336860741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:11:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601898236"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:11:22 -0700
Message-ID: <99f72722-4dd4-b535-1e9b-c8ae3c6ca2f1@linux.intel.com>
Date:   Wed, 25 May 2022 21:11:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
 <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
 <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com> <Yo4Nw9QyllT1RZbd@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yo4Nw9QyllT1RZbd@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 19:06, Jean-Philippe Brucker wrote:
> On Wed, May 25, 2022 at 11:07:49AM +0100, Robin Murphy wrote:
>>> Did you mean @handler and @handler_token staffs below?
>>>
>>> struct iommu_domain {
>>>           unsigned type;
>>>           const struct iommu_domain_ops *ops;
>>>           unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>>>           iommu_fault_handler_t handler;
>>>           void *handler_token;
>>>           struct iommu_domain_geometry geometry;
>>>           struct iommu_dma_cookie *iova_cookie;
>>> };
>>>
>>> Is it only for DMA domains? From the point view of IOMMU faults, it
>>> seems to be generic.
>> Yes, it's the old common iommu_set_fault_handler() stuff (which arguably is
>> more of a "notifier" than a "handler"), but I assume that that's irrelevant
>> if SVA is using IOPF instead?
> Yes IOMMU drivers call either the newer iommu_report_device_fault() or the
> old report_iommu_fault(), and only the former can support IOPF/SVA. I've
> tried to merge them before but never completed it. I think the main issue
> was with finding the endpoint that caused the fault from the fault
> handler. Some IOMMU drivers just pass the IOMMU device to
> report_iommu_fault(). I'll probably pick that up at some point.

Thank you all for the comments and suggestions. Below is the refreshed
patch. Hope that I didn't miss anything.

 From 463c04cada8e8640598f981d8d16157781b9de6f Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Wed, 11 May 2022 20:59:24 +0800
Subject: [PATCH 04/11] iommu: Add sva iommu_domain support

The sva iommu_domain represents a hardware pagetable that the IOMMU
hardware could use for SVA translation. This adds some infrastructure
to support SVA domain in the iommu common layer. It includes:

- Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
   type. The IOMMU drivers that support SVA should provide the sva
   domain specific iommu_domain_ops.
- Add a helper to allocate an SVA domain. The iommu_domain_free()
   is still used to free an SVA domain.
- Add helpers to attach an SVA domain to a device and the reverse
   operation.

Some buses, like PCI, route packets without considering the PASID value.
Thus a DMA target address with PASID might be treated as P2P if the
address falls into the MMIO BAR of other devices in the group. To make
things simple, the attach/detach interfaces only apply to devices
belonging to the singleton groups, and the singleton is immutable in
fabric i.e. not affected by hotplug.

The iommu_attach/detach_device_pasid() can be used for other purposes,
such as kernel DMA with pasid, mediation device, etc.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
  drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++
  include/linux/iommu.h | 45 ++++++++++++++++++++-
  2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b64b4e8a38..b1a2ad64a413 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,7 @@
  #include <linux/module.h>
  #include <linux/cc_platform.h>
  #include <trace/events/iommu.h>
+#include <linux/sched/mm.h>

  static struct kset *iommu_group_kset;
  static DEFINE_IDA(iommu_group_ida);
@@ -39,6 +40,7 @@ struct iommu_group {
  	struct kobject kobj;
  	struct kobject *devices_kobj;
  	struct list_head devices;
+	struct xarray pasid_array;
  	struct mutex mutex;
  	void *iommu_data;
  	void (*iommu_data_release)(void *iommu_data);
@@ -666,6 +668,7 @@ struct iommu_group *iommu_group_alloc(void)
  	mutex_init(&group->mutex);
  	INIT_LIST_HEAD(&group->devices);
  	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);

  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
  	if (ret < 0) {
@@ -1961,6 +1964,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);

  void iommu_domain_free(struct iommu_domain *domain)
  {
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		mmdrop(domain->mm);
  	iommu_put_dma_cookie(domain);
  	domain->ops->free(domain);
  }
@@ -3277,3 +3282,91 @@ bool iommu_group_dma_owner_claimed(struct 
iommu_group *group)
  	return user;
  }
  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return NULL;
+
+	domain->type = IOMMU_DOMAIN_SVA;
+	mmgrab(mm);
+	domain->mm = mm;
+
+	return domain;
+}
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
+int iommu_attach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
+			      ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -EBUSY;
+	void *curr;
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
+	if (curr)
+		goto out_unlock;
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
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
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
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3fbad42c0bf8..9173c5741447 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,9 @@ struct iommu_domain_geometry {
  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */

+#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
+#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
+
  /*
   * This are the possible domain-types
   *
@@ -86,15 +89,24 @@ struct iommu_domain_geometry {
  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
  				 __IOMMU_DOMAIN_DMA_API |	\
  				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
+				 __IOMMU_DOMAIN_HOST_VA)

  struct iommu_domain {
  	unsigned type;
  	const struct iommu_domain_ops *ops;
  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
-	iommu_fault_handler_t handler;
-	void *handler_token;
  	struct iommu_domain_geometry geometry;
  	struct iommu_dma_cookie *iova_cookie;
+	union {
+		struct {	/* IOMMU_DOMAIN_DMA */
+			iommu_fault_handler_t handler;
+			void *handler_token;
+		};
+		struct {	/* IOMMU_DOMAIN_SVA */
+			struct mm_struct *mm;
+		};
+	};
  };

  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -262,6 +274,8 @@ struct iommu_ops {
   * struct iommu_domain_ops - domain specific operations
   * @attach_dev: attach an iommu domain to a device
   * @detach_dev: detach an iommu domain from a device
+ * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @block_dev_pasid: block pasid of device from using iommu domain
   * @map: map a physically contiguous memory region to an iommu domain
   * @map_pages: map a physically contiguous set of pages of the same 
size to
   *             an iommu domain.
@@ -282,6 +296,10 @@ struct iommu_ops {
  struct iommu_domain_ops {
  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+			     ioasid_t pasid);
+	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
+				ioasid_t pasid);

  	int (*map)(struct iommu_domain *domain, unsigned long iova,
  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -679,6 +697,12 @@ int iommu_group_claim_dma_owner(struct iommu_group 
*group, void *owner);
  void iommu_group_release_dma_owner(struct iommu_group *group);
  bool iommu_group_dma_owner_claimed(struct iommu_group *group);

+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
+int iommu_attach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
+			      ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain, struct 
device *dev,
+			       ioasid_t pasid);
  #else /* CONFIG_IOMMU_API */

  struct iommu_ops {};
@@ -1052,6 +1076,23 @@ static inline bool 
iommu_group_dma_owner_claimed(struct iommu_group *group)
  {
  	return false;
  }
+
+static inline struct iommu_domain *
+iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
+{
+	return NULL;
+}
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
-- 
2.25.1

Best regards,
baolu
