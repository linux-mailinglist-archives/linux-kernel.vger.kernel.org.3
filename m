Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C32C518BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiECSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiECSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:11:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73293EAAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:07:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g6so34986569ejw.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CAlYiIhh6pgNH2aA5Z1WYg+YY5VaTEuIKmdxG9INjP0=;
        b=Kh1WAjKn9+eoDulUuBkXOif8gJJyDVzvosxRo04NXHiWzAxo49XgCSb71PzbDS/+Jh
         gY//JhkQdnLdfiWgeNdqNuoCJ1p/SVZEsChjhDaT6jrzArLylfd/+nIiZBFzRAitVWvU
         EVh+YVCgJzObQhazQTV7X29ZQCAgZHg/fXcvggmB1KDYtT93t/YY0jWjKJcE/RBoeA+w
         Al4k1lkX3JbUU8dHDrtuHIr7drhMg0QxTd+gzfAadmNsMK9XlpgndsLZJtdJqCHQtIwS
         ozPBW+jKST3wAOfbWyvLxLh84Stnyn3WC5d5jmt26oyawsuvlNkRatwJZdVmQcDRe+L4
         153w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAlYiIhh6pgNH2aA5Z1WYg+YY5VaTEuIKmdxG9INjP0=;
        b=jX5iG6HgxZAVbAZe4/3/qAX8s0NTsFnIHSTIbWgCdXWdYZUhwxknqPZPHbo4tzpBrV
         eyOgdytfUGm6ODQZtNj5rocQ5mLmLpbLVX+Lb1E8tvgDRLfN/NUf74WRw2wBlC0if5BZ
         AArohDHjUPMsUJMyw2bszThich8Ku/KlVxEKVk8B4zOeAhnLB02SmsCrwOFzJn4qtsJ/
         pbNoAdoE62Mh2LIs98MyfXhbVsBeZAZMx8mfrTq1sKOhlTJ6RrZBfJjhTkqhH+3ipWW5
         urAz4byEj8+CW4s2KADlvvq/XI/DxJasDTWX59XyJJXJubSfJ/bcZsUe8vkiTWmErHx0
         4gtw==
X-Gm-Message-State: AOAM530ZRqaqiDDmgA9xi3CnLrIIPsLN0mdqxVmgcgmhWBU47qdBroes
        MWSZ2VIPX+Ns42fkupbzSsaDQQ==
X-Google-Smtp-Source: ABdhPJzhOeQPH/8j7gVM23B+jQ578rJRgDPkXcwX4cB7js1XoH0ZNbgdqXOgLT7NoLlHZxmSOokqZw==
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id m4-20020a17090679c400b006cf5489da57mr16263726ejo.48.1651601273400;
        Tue, 03 May 2022 11:07:53 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id a1-20020aa7cf01000000b0042617ba6398sm7986163edy.34.2022.05.03.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:07:52 -0700 (PDT)
Date:   Tue, 3 May 2022 19:07:27 +0100
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
Subject: Re: [PATCH v5 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <YnFvX8IUwP2drNoj@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-4-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:48:33AM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of common domain ops for this purpose and adds helpers
> to attach/detach a domain to/from a {device, PASID}. Some buses, like
> PCI, route packets without considering the PASID value. Thus a DMA target
> address with PASID might be treated as P2P if the address falls into the
> MMIO BAR of other devices in the group. To make things simple, these
> interfaces only apply to devices belonging to the singleton groups, and
> the singleton is immutable in fabric i.e. not affected by hotplug.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

just a nit below

> ---
>  include/linux/iommu.h | 21 ++++++++++++
>  drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b8ffaf2cb1d0..ab36244d4e94 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -263,6 +263,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -283,6 +285,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t pasid);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t pasid);
>  
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -678,6 +684,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid);
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1051,6 +1061,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
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
> index 29906bc16371..89c9d19ddb28 100644
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
> @@ -630,6 +631,7 @@ struct iommu_group *iommu_group_alloc(void)
>  	mutex_init(&group->mutex);
>  	INIT_LIST_HEAD(&group->devices);
>  	INIT_LIST_HEAD(&group->entry);
> +	xa_init(&group->pasid_array);
>  
>  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
> @@ -3190,3 +3192,77 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +/*
> + * Use standard PCI bus topology and isolation features to check immutable
> + * singleton. Otherwise, assume the bus is static and then singleton can
> + * know from the device count in the group.
> + */

The comment doesn't really add anything that can't be directly understood
from the code.

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
> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret = -EINVAL;
> +	void *curr;
> +
> +	if (!domain->ops->attach_dev_pasid)
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
> +	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&group->pasid_array, pasid);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->detach_dev_pasid(domain, dev, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	iommu_group_put(group);
> +}
> -- 
> 2.25.1
> 
