Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596752DA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiESQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiESQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:39:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42334DE310
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:39:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so3008084wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vqj1CdWbcGN30T9NF/kbs15BFwiUmmn2zNt8QD4Z5CU=;
        b=XLmcJa0DFyM7BbBsPcIdPn8GiMteWHaCt2UHPXRK7FQQ0ciWcQqdN/RiTJcMM0OI3M
         yCn6lDDmsL8cwydHFMlnLv1L4BvEHQhUx5zTqfQjGJ+bG+fzk0KIdBo4mW7/nYEWKDXR
         Amcg8FkasJdi0DrcaA6F1pmzQ1IaPuSEU4on7TCxIO5GYHskSYFGyRVFHtp0HoGlGdTh
         2ETaUEiYWTNSfCzc1kMGO28sgXODQXiNiXLQOkfBo/+dpH3msICGQ53VJGpNQvNHqyGY
         j764zJkmhV8llXSJz90fqktYysf2q3s5c0XEBQvKANrrmnZtS60T4HAXkqDhW2wRxXOS
         HC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vqj1CdWbcGN30T9NF/kbs15BFwiUmmn2zNt8QD4Z5CU=;
        b=GZpMaVvd1Avf7wqBQQiA9WK619FXeh47oJoPxUPvjzTGOkQMN4/2AIbuaL+PfxlRvI
         R2HPvNLjjuRERFaY10GDWCiOFMsV5oGGFAG1BzRwcIqfDyNnD7fy8aNEKHomXw9fHfFR
         UecRLdDmkOK4R0HTwuATY8mk3rZJhM3dq/d/QHVT7qTlvK3QVcvDMf5SzK4drRI/QAQZ
         cL004N5AHLOJ+MzhwRJVnR4nYJQ1aaJMsjn+tNL1nV1VdWg2KYCpnBlIaE+3DiXuUXCY
         cTcMo75zUQXlRP/ZRhKtsstsv8LFkIyn+F1yhcg/Nf3TLxZVjIcEiWotrHmYwYKidfky
         BADA==
X-Gm-Message-State: AOAM530gk6QbWe7F/sQRw54cRg11BblXvQxUOp8pd3bGo/93Rvq4vp9U
        2AzSjoM2TQGVkPQEPe11MRc2RQ==
X-Google-Smtp-Source: ABdhPJzyN2xYWcT9uQocuiPgEjwPimhGcSObCi/wkUxYY3Q0uRZC22eNFTH/F+69MowmdtdfuNfU5g==
X-Received: by 2002:a05:600c:354c:b0:394:586f:694f with SMTP id i12-20020a05600c354c00b00394586f694fmr4576126wmq.159.1652978390619;
        Thu, 19 May 2022 09:39:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id w5-20020adf8bc5000000b0020e615bab7bsm100344wra.7.2022.05.19.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:39:50 -0700 (PDT)
Date:   Thu, 19 May 2022 17:39:25 +0100
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
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YoZyvVxJLiYOjBHw@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-7-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:20:43PM +0800, Lu Baolu wrote:
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.
> 
> This refactors the IOMMU SVA interfaces implementation by using the
> set/block_pasid_dev ops and align them with the concept of the SVA
> iommu domain. Put the new SVA code in the sva related file in order
> to make it self-contained.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         |  48 ++++++++------
>  drivers/iommu/iommu-sva-lib.h |   1 +
>  drivers/iommu/iommu-sva-lib.c | 113 ++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         | 119 ++++++++--------------------------
>  4 files changed, 170 insertions(+), 111 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e8cf82d46ce1..d9ac5ebe5bbb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -635,6 +635,7 @@ struct iommu_fwspec {
>   */
>  struct iommu_sva {
>  	struct device			*dev;
> +	refcount_t			users;
>  };
>  
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> @@ -677,11 +678,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>  int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>  bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
>  
> -struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm);
> -void iommu_sva_unbind_device(struct iommu_sva *handle);
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> -
>  int iommu_device_use_default_domain(struct device *dev);
>  void iommu_device_unuse_default_domain(struct device *dev);
>  
> @@ -693,6 +689,8 @@ int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
>  			   ioasid_t pasid);
>  void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
>  			      ioasid_t pasid);
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1023,21 +1021,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>  	return -ENODEV;
>  }
>  
> -static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	return NULL;
> -}
> -
> -static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -}
> -
> -static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>  static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>  {
>  	return NULL;
> @@ -1077,6 +1060,12 @@ static inline void iommu_block_device_pasid(struct iommu_domain *domain,
>  					    struct device *dev, ioasid_t pasid)
>  {
>  }
> +
> +static inline struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> @@ -1108,6 +1097,10 @@ iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm);
>  void iommu_sva_free_domain(struct iommu_domain *domain);
>  int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
>  			 ioasid_t pasid);
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> +					struct mm_struct *mm);
> +void iommu_sva_unbind_device(struct iommu_sva *handle);
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>  #else /* CONFIG_IOMMU_SVA */
>  static inline struct iommu_domain *
>  iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> @@ -1124,6 +1117,21 @@ static inline int iommu_sva_set_domain(struct iommu_domain *domain,
>  {
>  	return -EINVAL;
>  }
> +
> +static inline struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	return NULL;
> +}
> +
> +static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +}
> +
> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
>  #endif /* CONFIG_IOMMU_SVA */
>  
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 1be21e6b93ec..ebab5a8cb126 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -20,6 +20,7 @@ struct iopf_queue;
>  struct iommu_sva_domain {
>  	struct iommu_domain	domain;
>  	struct mm_struct	*mm;
> +	struct iommu_sva	bond;
>  };
>  
>  #define to_sva_domain(d) container_of_safe(d, struct iommu_sva_domain, domain)
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 210c376f6043..568e0f64edac 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -4,6 +4,8 @@
>   */
>  #include <linux/mutex.h>
>  #include <linux/sched/mm.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  
>  #include "iommu-sva-lib.h"
>  
> @@ -117,3 +119,114 @@ int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
>  
>  	return iommu_set_device_pasid(domain, dev, pasid);
>  }
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_sva_domain *sva_domain;
> +	struct iommu_domain *domain;
> +	ioasid_t max_pasid = 0;
> +	int ret = -EINVAL;
> +
> +	/* Allocate mm->pasid if necessary. */
> +	if (!dev->iommu->iommu_dev->pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (dev_is_pci(dev)) {
> +		max_pasid = pci_max_pasids(to_pci_dev(dev));
> +		if (max_pasid < 0)
> +			return ERR_PTR(max_pasid);
> +	} else {
> +		ret = device_property_read_u32(dev, "pasid-num-bits",
> +					       &max_pasid);
> +		if (ret)
> +			return ERR_PTR(ret);
> +		max_pasid = (1UL << max_pasid);
> +	}

The IOMMU driver needs this PASID width information earlier, when creating
the PASID table (in .probe_device(), .attach_dev()). Since we're moving it
to the IOMMU core to avoid code duplication, it should be done earlier and
stored in dev->iommu

Thanks,
Jean

> +	max_pasid = min_t(u32, max_pasid, dev->iommu->iommu_dev->pasids);
> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasid - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> +	if (domain) {
> +		sva_domain = to_sva_domain(domain);
> +		refcount_inc(&sva_domain->bond.users);
> +		goto out_success;
> +	}
> +
> +	/* Allocate a new domain and set it on device pasid. */
> +	domain = iommu_sva_alloc_domain(dev->bus, mm);
> +	if (IS_ERR(domain)) {
> +		ret = PTR_ERR(domain);
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_sva_set_domain(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +	sva_domain = to_sva_domain(domain);
> +	sva_domain->bond.dev = dev;
> +	refcount_set(&sva_domain->bond.users, 1);
> +
> +out_success:
> +	mutex_unlock(&iommu_sva_lock);
> +	return &sva_domain->bond;
> +
> +out_free_domain:
> +	iommu_sva_free_domain(domain);
> +out_unlock:
> +	mutex_unlock(&iommu_sva_lock);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> +
> +/**
> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> + * @handle: the handle returned by iommu_sva_bind_device()
> + *
> + * Put reference to a bond between device and address space. The device should
> + * not be issuing any more transaction for this PASID. All outstanding page
> + * requests for this PASID must have been flushed to the IOMMU.
> + */
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct device *dev = handle->dev;
> +	struct iommu_sva_domain *sva_domain =
> +			container_of(handle, struct iommu_sva_domain, bond);
> +	ioasid_t pasid = iommu_sva_get_pasid(handle);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	if (refcount_dec_and_test(&sva_domain->bond.users)) {
> +		iommu_block_device_pasid(&sva_domain->domain, dev, pasid);
> +		iommu_sva_free_domain(&sva_domain->domain);
> +	}
> +	mutex_unlock(&iommu_sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct iommu_sva_domain *sva_domain =
> +			container_of(handle, struct iommu_sva_domain, bond);
> +
> +	return sva_domain->mm->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 789816e4b9d6..e49c5a5b8cc1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2766,97 +2766,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>  }
>  EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>  
> -/**
> - * iommu_sva_bind_device() - Bind a process address space to a device
> - * @dev: the device
> - * @mm: the mm to bind, caller must hold a reference to it
> - *
> - * Create a bond between device and address space, allowing the device to access
> - * the mm using the returned PASID. If a bond already exists between @device and
> - * @mm, it is returned and an additional reference is taken. Caller must call
> - * iommu_sva_unbind_device() to release each reference.
> - *
> - * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> - * initialize the required SVA features.
> - *
> - * On error, returns an ERR_PTR value.
> - */
> -struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	struct iommu_group *group;
> -	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_bind)
> -		return ERR_PTR(-ENODEV);
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return ERR_PTR(-ENODEV);
> -
> -	/* Ensure device count and domain don't change while we're binding */
> -	mutex_lock(&group->mutex);
> -
> -	/*
> -	 * To keep things simple, SVA currently doesn't support IOMMU groups
> -	 * with more than one device. Existing SVA-capable systems are not
> -	 * affected by the problems that required IOMMU groups (lack of ACS
> -	 * isolation, device ID aliasing and other hardware issues).
> -	 */
> -	if (iommu_group_device_count(group) != 1)
> -		goto out_unlock;
> -
> -	handle = ops->sva_bind(dev, mm);
> -
> -out_unlock:
> -	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> -
> -	return handle;
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> -
> -/**
> - * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> - * @handle: the handle returned by iommu_sva_bind_device()
> - *
> - * Put reference to a bond between device and address space. The device should
> - * not be issuing any more transaction for this PASID. All outstanding page
> - * requests for this PASID must have been flushed to the IOMMU.
> - */
> -void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -	struct iommu_group *group;
> -	struct device *dev = handle->dev;
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_unbind)
> -		return;
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return;
> -
> -	mutex_lock(&group->mutex);
> -	ops->sva_unbind(handle);
> -	mutex_unlock(&group->mutex);
> -
> -	iommu_group_put(group);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> -
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
> -
> -	if (!ops->sva_get_pasid)
> -		return IOMMU_PASID_INVALID;
> -
> -	return ops->sva_get_pasid(handle);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> -
>  /*
>   * Changes the default domain of an iommu group that has *only* one device
>   *
> @@ -3322,3 +3231,31 @@ void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
>  
>  	iommu_group_put(group);
>  }
> +
> +/*
> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
> + * domain attached to pasid of a device. It's only for internal use of the
> + * IOMMU subsystem. The caller must take care to avoid any possible
> + * use-after-free case.
> + */
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +	/*
> +	 * The xarray protects its internal state with RCU. Hence the domain
> +	 * obtained is either NULL or fully formed.
> +	 */
> +	domain = xa_load(&group->pasid_array, pasid);
> +	iommu_group_put(group);
> +
> +	return domain;
> +}
> -- 
> 2.25.1
> 
