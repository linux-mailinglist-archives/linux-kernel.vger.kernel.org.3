Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0B52DA50
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiESQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiESQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:34:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA8C1EC8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:34:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k26so3196639wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qOSmNt42l/OCGmbno8l29QID+BV2mayim2UvNOvGqY=;
        b=yP/A3yGj0N6SZOh43a3pIa+w3fXBtI4hpdrWPhh1N5eoMB0juQ79P5JhtfFOB1cPz4
         NyeXJJ5soEpAtYrux2M/BQ2Ac1WFeeBS/ciip/G3DsrsjQ3YNsUZERK84YWLa9WhPGfj
         tSm0piD3Gd+IbH6nyV6lz+KNKPNSEy7KUmO8BxZ9e3WcKsYKWVdUqKAVIee1HNkBsdWh
         3ezgxe3NaXLZdEiL+/Zso4dYAfRu/q5EK0G2jqh7c/LRmG6ILsr4McjGh7DAhR6aS4Wv
         8vek315UWrjnBoPuPc10m0ZLRKnx50VS9cA6T8VXbOM2xDk0E3x8/XXVbb/hgkW2AXJi
         XCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qOSmNt42l/OCGmbno8l29QID+BV2mayim2UvNOvGqY=;
        b=8DTgwZ0VQt5/f0WU/RujYu4VU5q/eE7i485xUikZ3SVXcueYCUhi8LHRsTyn0pWGSY
         5kAJZUUQCgUBtzoQrXotOGNrjOKHZmjcAYuQwpPfteQ44SO0YwCJFYmsqzremJ5z92x8
         bsloExv+KnG/7oodPiJkVpqluvcrePWfEeMXyU+8xMBb9hCWE3VN392A5a1M+dX0Ga74
         Fsdk48wXCHEtTErYpaksjDFF4J+EkYolLYUSu+1r8v8Ik4VrbwrAMryqYmUJqFhojVkH
         KALtrMhRzd71eV1b0lx3PuVByar3z7le/NjebxNYqdAndadTpkrcugnyd+BMpDtnAC+W
         /WAQ==
X-Gm-Message-State: AOAM533O9bb/HyI9sZbGrR5nPEuLOJ4CuoQQguoxr4wi/cCKSF7bd75c
        2qaqzQjHTKt+bQynDt9qcK5HnA==
X-Google-Smtp-Source: ABdhPJwx+pk3DrU/je8ol5nx1VFMLrX7Y5X1mNEYsN1r8kdtwAn5EVi/tyYU30OPWARo2XuK3rS/Bg==
X-Received: by 2002:a05:600c:204b:b0:394:4028:b0f9 with SMTP id p11-20020a05600c204b00b003944028b0f9mr4562624wmg.114.1652978056479;
        Thu, 19 May 2022 09:34:16 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id p14-20020adfaa0e000000b0020d02ddf4d0sm32025wrd.69.2022.05.19.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:34:16 -0700 (PDT)
Date:   Thu, 19 May 2022 17:33:51 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <YoZxb26tYf8mmv87@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
X-TUID: Nkj467R+9Ewb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:20:40PM +0800, Lu Baolu wrote:
> The iommu_sva_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA domain
>   type.
> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>   support SVA should provide the callbacks.
> - Add helpers to allocate and free an SVA domain.
> - Add helpers to set an SVA domain to a device and the reverse
>   operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_set/block_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> in the iommu.c.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         | 51 +++++++++++++++++++++++++
>  drivers/iommu/iommu-sva-lib.h | 15 ++++++++
>  drivers/iommu/iommu-sva-lib.c | 48 +++++++++++++++++++++++
>  drivers/iommu/iommu.c         | 71 +++++++++++++++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0c358b7c583b..e8cf82d46ce1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>  
>  struct iommu_domain {
>  	unsigned type;
> @@ -254,6 +259,7 @@ struct iommu_ops {
>  	int (*def_domain_type)(struct device *dev);
>  
>  	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *sva_domain_ops;
>  	unsigned long pgsize_bitmap;
>  	struct module *owner;
>  };
> @@ -262,6 +268,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @set_dev_pasid: set an iommu domain to a pasid of device
> + * @block_dev_pasid: block pasid of device from using iommu domain
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -282,6 +290,10 @@ struct iommu_ops {
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
> @@ -677,6 +689,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			   ioasid_t pasid);
> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1050,6 +1066,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
> +
> +static inline int iommu_set_device_pasid(struct iommu_domain *domain,
> +					 struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_block_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> @@ -1075,4 +1102,28 @@ void iommu_debugfs_setup(void);
>  static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
> +#ifdef CONFIG_IOMMU_SVA
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm);
> +void iommu_sva_free_domain(struct iommu_domain *domain);
> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
> +			 ioasid_t pasid);
> +#else /* CONFIG_IOMMU_SVA */
> +static inline struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +}
> +
> +static inline int iommu_sva_set_domain(struct iommu_domain *domain,
> +				       struct device *dev, ioasid_t pasid)
> +{
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 8909ea1094e3..1be21e6b93ec 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
> +#include <linux/iommu.h>
>  
>  int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>  struct mm_struct *iommu_sva_find(ioasid_t pasid);
> @@ -16,6 +17,20 @@ struct device;
>  struct iommu_fault;
>  struct iopf_queue;
>  
> +struct iommu_sva_domain {
> +	struct iommu_domain	domain;
> +	struct mm_struct	*mm;
> +};
> +
> +#define to_sva_domain(d) container_of_safe(d, struct iommu_sva_domain, domain)

Is there a reason to use the 'safe' version of container_of()?  Callers of
to_sva_domain() don't check the return value before dereferencing it so
they would break anyway if someone passes an error pointer as domain.  I
think it matters because there is no other user of container_of_safe() in
the kernel (the only user, lustre, went away in 2018) so someone will want
to remove it.

Apart from that

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> +
> +static inline struct mm_struct *domain_to_mm(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	return sva_domain->mm;
> +}
> +
>  #ifdef CONFIG_IOMMU_SVA
>  int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
>  
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..210c376f6043 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/*
> + * IOMMU SVA driver-oriented interfaces
> + */
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> +{
> +	struct iommu_sva_domain *sva_domain;
> +	struct iommu_domain *domain;
> +
> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> +	if (!sva_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mmgrab(mm);
> +	sva_domain->mm = mm;
> +
> +	domain = &sva_domain->domain;
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->ops = bus->iommu_ops->sva_domain_ops;
> +
> +	return domain;
> +}
> +
> +void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	mmdrop(sva_domain->mm);
> +	kfree(sva_domain);
> +}
> +
> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
> +			 ioasid_t pasid)
> +{
> +	struct bus_type *bus = dev->bus;
> +
> +	if (!bus || !bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return -ENODEV;
> +
> +	if (domain->ops != bus->iommu_ops->sva_domain_ops)
> +		return -EINVAL;
> +
> +	return iommu_set_device_pasid(domain, dev, pasid);
> +}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9955f58bd08c..789816e4b9d6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -38,6 +38,7 @@ struct iommu_group {
>  	struct kobject kobj;
>  	struct kobject *devices_kobj;
>  	struct list_head devices;
> +	struct xarray pasid_array;
>  	struct mutex mutex;
>  	void *iommu_data;
>  	void (*iommu_data_release)(void *iommu_data);
> @@ -640,6 +641,7 @@ struct iommu_group *iommu_group_alloc(void)
>  	mutex_init(&group->mutex);
>  	INIT_LIST_HEAD(&group->devices);
>  	INIT_LIST_HEAD(&group->entry);
> +	xa_init(&group->pasid_array);
>  
>  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
> @@ -3251,3 +3253,72 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +static bool device_group_immutable_singleton(struct device *dev)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +	int count;
> +
> +	if (!group)
> +		return false;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
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
> +
> +	return true;
> +}
> +
> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			   ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret = -EBUSY;
> +	void *curr;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (!device_group_immutable_singleton(dev))
> +		return -EINVAL;
> +
> +	group = iommu_group_get(dev);
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
> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid)
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
