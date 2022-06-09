Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339E254558F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiFIUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:25:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD869CC1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654806342; x=1686342342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=txE7FU3yncMCPt2ZReE/SPe7ebUWewV3IIqWc3P+mT8=;
  b=XzxuG0DktlzAEweYoouyyYI6nz7C/au5iNnzVtcnCsrGfbnslzNdZOp5
   CpAlHZRct4xO6v/W25NQ2doI8HCzJTebDg5Q2Sdj5TXX3lT4emvlo1IvO
   t/DWntLj4r4CY7Hm9sZe+s6gcKrZjT+piNIlNWaJgH6lbBATmvbSwysAa
   Xu7yEsBth1qt/NNXxMiTAic/6MO4aHPm/aYIRLhLjb97x896EQwM/5pNe
   BrCo5vbx8u9wroIDZo6Ccyn2ZqMgkLq3qcq1qJfe5MwYfJDqfFimXz+W3
   8NoWUjnS3qu00hTOgBM6uzMZCOEu2GKiQAS6GEZwYW7XpB1dOIXp3T+eB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="260529117"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="260529117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 13:25:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="533756508"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 13:25:40 -0700
Date:   Thu, 9 Jun 2022 20:25:40 +0000
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v8 04/11] iommu: Add sva iommu_domain support
Message-ID: <20220609202540.GD33363@araj-dh-work>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607014942.3954894-5-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu

some minor nits.

On Tue, Jun 07, 2022 at 09:49:35AM +0800, Lu Baolu wrote:
> The sva iommu_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
>   type. The IOMMU drivers that support SVA should provide the sva
>   domain specific iommu_domain_ops.
> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>   is still used to free an SVA domain.
> - Add helpers to attach an SVA domain to a device and the reverse
>   operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_attach/detach_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/iommu.h | 45 ++++++++++++++++++++-
>  drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3fbad42c0bf8..9173c5741447 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */

s/from CPU/with CPU

> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */

Do you mean general CPU VA? or Host CPU VA, I'm reading the latter as 2nd
stage?

> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,15 +89,24 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)

Doesn't shared automatically mean CPU VA? Do we need another flag?

>  
>  struct iommu_domain {
>  	unsigned type;
>  	const struct iommu_domain_ops *ops;
>  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> -	iommu_fault_handler_t handler;
> -	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	union {
> +		struct {	/* IOMMU_DOMAIN_DMA */
> +			iommu_fault_handler_t handler;
> +			void *handler_token;
> +		};
> +		struct {	/* IOMMU_DOMAIN_SVA */
> +			struct mm_struct *mm;
> +		};
> +	};
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -262,6 +274,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @set_dev_pasid: set an iommu domain to a pasid of device
> + * @block_dev_pasid: block pasid of device from using iommu domain
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -282,6 +296,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +			     ioasid_t pasid);
> +	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +				ioasid_t pasid);
>  
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -679,6 +697,12 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> +					    struct mm_struct *mm);
> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid);
> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			       ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1052,6 +1076,23 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
> +
> +static inline struct iommu_domain *
> +iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
> +{
> +	return NULL;
> +}
> +
> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
> +					     struct device *dev, ioasid_t pasid)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1ec855b1f72..e92391dcce33 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -27,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/cc_platform.h>
>  #include <trace/events/iommu.h>
> +#include <linux/sched/mm.h>
>  
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
> @@ -39,6 +40,7 @@ struct iommu_group {
>  	struct kobject kobj;
>  	struct kobject *devices_kobj;
>  	struct list_head devices;
> +	struct xarray pasid_array;
>  	struct mutex mutex;
>  	void *iommu_data;
>  	void (*iommu_data_release)(void *iommu_data);
> @@ -666,6 +668,7 @@ struct iommu_group *iommu_group_alloc(void)
>  	mutex_init(&group->mutex);
>  	INIT_LIST_HEAD(&group->devices);
>  	INIT_LIST_HEAD(&group->entry);
> +	xa_init(&group->pasid_array);
>  
>  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
> @@ -1961,6 +1964,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>  
>  void iommu_domain_free(struct iommu_domain *domain)
>  {
> +	if (domain->type == IOMMU_DOMAIN_SVA)
> +		mmdrop(domain->mm);
>  	iommu_put_dma_cookie(domain);
>  	domain->ops->free(domain);
>  }
> @@ -3277,3 +3282,91 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> +					    struct mm_struct *mm)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_domain *domain;
> +
> +	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +	if (!domain)
> +		return NULL;
> +
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	mmgrab(mm);
> +	domain->mm = mm;
> +
> +	return domain;
> +}
> +
> +static bool iommu_group_immutable_singleton(struct iommu_group *group,
> +					    struct device *dev)
> +{
> +	int count;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +
> +	if (count != 1)
> +		return false;
> +
> +	/*
> +	 * The PCI device could be considered to be fully isolated if all
> +	 * devices on the path from the device to the host-PCI bridge are
> +	 * protected from peer-to-peer DMA by ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
> +					    REQ_ACS_FLAGS);

Does this comprehend RCiEP devices? Since they are optional even if ACS is
lacking.


> +
> +	/*
> +	 * Otherwise, the device came from DT/ACPI, assume it is static and
> +	 * then singleton can know from the device count in the group.
> +	 */
> +	return true;
> +}
> +
> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret = -EBUSY;
> +	void *curr;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	group = iommu_group_get(dev);
> +	if (!group || !iommu_group_immutable_singleton(group, dev)) {
> +		iommu_group_put(group);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&group->mutex);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
> +	if (curr)
> +		goto out_unlock;
> +	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&group->pasid_array, pasid);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			       ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->block_dev_pasid(domain, dev, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	iommu_group_put(group);
> +}
> -- 
> 2.25.1
> 
