Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9149AC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357132AbiAYGm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:42:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:47421 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354164AbiAYGh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643092679; x=1674628679;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vnizT3M8E7HLvegXGDRHVDhJXi99qJ4cXdVd24dhnZQ=;
  b=kkG0lLzlPkJrmwSoHJeLb1yIZ2am4o01atxkQB1OjACn34hBQWM0Jz4S
   xvtJniRVIyjSqDbOKILwK4XiUXtoGWsy8rqxDzkX2Gu84GQ96spxBZl/A
   DLV2a2EL1azK0/3PksiON2hjEp8Y2cT84oRrZfKqXcLsh8sdoeLJGfs7a
   FAwmihamw5YttcDNDUXHnTcqAX/7VHEEUFJF/sx+gUmpCSoobn+ROmvrN
   8pzeOOaCxSI6CYzljiPTSesQyQr3CXsLwzdiDpwLRWz1MRcMCumOtyn+x
   m0BT18uX4L6lvfJpOMfeD/efYYBnfhiDJrx1+wCrhizL5MmB3rCoWWbXi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233601098"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="233601098"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 22:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534589761"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 22:28:03 -0800
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <99023cd7-f037-282f-3f25-629a14a1578b@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <82c5db53-088f-a51f-6fbc-c977ef871d8f@linux.intel.com>
Date:   Tue, 25 Jan 2022 14:27:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <99023cd7-f037-282f-3f25-629a14a1578b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 8:57 AM, Robin Murphy wrote:
> On 2022-01-24 07:11, Lu Baolu wrote:
>> Add a domain specific callback set, domain_ops, for vendor iommu driver
>> to provide domain specific operations. Move domain-specific callbacks
>> from iommu_ops to the domain_ops and hook them when a domain is 
>> allocated.
> 
> I think it would make a lot of sense for iommu_domain_ops to be a 
> substructure *within* iommu_ops. That way we can save most of the driver 
> boilerplate here by not needing extra variables everywhere, and letting 
> iommu_domain_alloc() still do a default initialisation like "domain->ops 
> = bus->iommu_ops->domain_ops;"

In the new model, iommu_domain_ops and iommu_ops are not 1:1 mapped.
For example, a PASID-capable IOMMU could support DMA domain (which
supports map/unmap), SVA domain (which does not), and others in the
future. Different type of domain has its own domain_ops.

> 
> I do like the future possibility of trying to flatten some of the 
> io-pgtable indirection by having the SMMU drivers subsequently swizzle 
> in alternate domain ops once they've picked a format, though. That was a 
> bit too clunky to achieve at the whole iommu_ops level when I 
> experimented with it years ago, but now it might well be worth another 
> try...
> 
> One other comment below.
> 
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h                       | 93 ++++++++++++---------
>>   drivers/iommu/amd/iommu.c                   | 21 +++--
>>   drivers/iommu/apple-dart.c                  | 24 ++++--
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 23 +++--
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 17 ++--
>>   drivers/iommu/exynos-iommu.c                | 17 ++--
>>   drivers/iommu/fsl_pamu_domain.c             | 13 ++-
>>   drivers/iommu/intel/iommu.c                 | 25 ++++--
>>   drivers/iommu/iommu.c                       | 15 ++--
>>   drivers/iommu/ipmmu-vmsa.c                  | 21 +++--
>>   drivers/iommu/msm_iommu.c                   | 17 ++--
>>   drivers/iommu/mtk_iommu.c                   | 24 ++++--
>>   drivers/iommu/mtk_iommu_v1.c                | 19 +++--
>>   drivers/iommu/omap-iommu.c                  | 15 ++--
>>   drivers/iommu/rockchip-iommu.c              | 17 ++--
>>   drivers/iommu/s390-iommu.c                  | 15 ++--
>>   drivers/iommu/sprd-iommu.c                  | 19 +++--
>>   drivers/iommu/sun50i-iommu.c                | 18 ++--
>>   drivers/iommu/tegra-gart.c                  | 15 ++--
>>   drivers/iommu/tegra-smmu.c                  | 16 ++--
>>   drivers/iommu/virtio-iommu.c                | 18 ++--
>>   22 files changed, 305 insertions(+), 179 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 111b3e9c79bb..33c5c0e5c465 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -88,7 +88,7 @@ struct iommu_domain_geometry {
>>   struct iommu_domain {
>>       unsigned type;
>> -    const struct iommu_ops *ops;
>> +    const struct domain_ops *ops;
>>       unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>>       iommu_fault_handler_t handler;
>>       void *handler_token;
>> @@ -192,26 +192,11 @@ struct iommu_iotlb_gather {
>>    * struct iommu_ops - iommu ops and capabilities
>>    * @capable: check capability
>>    * @domain_alloc: allocate iommu domain
>> - * @domain_free: free iommu domain
>> - * @attach_dev: attach device to an iommu domain
>> - * @detach_dev: detach device from an iommu domain
>> - * @map: map a physically contiguous memory region to an iommu domain
>> - * @map_pages: map a physically contiguous set of pages of the same 
>> size to
>> - *             an iommu domain.
>> - * @unmap: unmap a physically contiguous memory region from an iommu 
>> domain
>> - * @unmap_pages: unmap a number of pages of the same size from an 
>> iommu domain
>> - * @flush_iotlb_all: Synchronously flush all hardware TLBs for this 
>> domain
>> - * @iotlb_sync_map: Sync mappings created recently using @map to the 
>> hardware
>> - * @iotlb_sync: Flush all queued ranges from the hardware TLBs and 
>> empty flush
>> - *            queue
>> - * @iova_to_phys: translate iova to physical address
>>    * @probe_device: Add device to iommu driver handling
>>    * @release_device: Remove device from iommu driver handling
>>    * @probe_finalize: Do final setup work after the device is added to 
>> an IOMMU
>>    *                  group and attached to the groups domain
>>    * @device_group: find iommu group for a particular device
>> - * @enable_nesting: Enable nesting
>> - * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>>    * @get_resv_regions: Request list of reserved regions for a device
>>    * @put_resv_regions: Free list of reserved regions for a device
>>    * @apply_resv_region: Temporary helper call-back for iova reserved 
>> ranges
>> @@ -237,33 +222,11 @@ struct iommu_ops {
>>       /* Domain allocation and freeing by the iommu driver */
>>       struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
>> -    void (*domain_free)(struct iommu_domain *);
>> -    int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>> -    void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>> -    int (*map)(struct iommu_domain *domain, unsigned long iova,
>> -           phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>> -    int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
>> -             phys_addr_t paddr, size_t pgsize, size_t pgcount,
>> -             int prot, gfp_t gfp, size_t *mapped);
>> -    size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>> -             size_t size, struct iommu_iotlb_gather *iotlb_gather);
>> -    size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long 
>> iova,
>> -                  size_t pgsize, size_t pgcount,
>> -                  struct iommu_iotlb_gather *iotlb_gather);
>> -    void (*flush_iotlb_all)(struct iommu_domain *domain);
>> -    void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long 
>> iova,
>> -                   size_t size);
>> -    void (*iotlb_sync)(struct iommu_domain *domain,
>> -               struct iommu_iotlb_gather *iotlb_gather);
>> -    phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, 
>> dma_addr_t iova);
>>       struct iommu_device *(*probe_device)(struct device *dev);
>>       void (*release_device)(struct device *dev);
>>       void (*probe_finalize)(struct device *dev);
>>       struct iommu_group *(*device_group)(struct device *dev);
>> -    int (*enable_nesting)(struct iommu_domain *domain);
>> -    int (*set_pgtable_quirks)(struct iommu_domain *domain,
>> -                  unsigned long quirks);
>>       /* Request/Free a list of reserved regions for a device */
>>       void (*get_resv_regions)(struct device *dev, struct list_head 
>> *list);
>> @@ -296,6 +259,60 @@ struct iommu_ops {
>>       struct module *owner;
>>   };
>> +/**
>> + * struct domain_ops - per-domain ops
>> + * @attach_dev: attach an iommu domain to a device
>> + * @detach_dev: detach an iommu domain from a device
>> + * @map: map a physically contiguous memory region to an iommu domain
>> + * @map_pages: map a physically contiguous set of pages of the same 
>> size to
>> + *             an iommu domain.
>> + * @unmap: unmap a physically contiguous memory region from an iommu 
>> domain
>> + * @unmap_pages: unmap a number of pages of the same size from an 
>> iommu domain
>> + * @flush_iotlb_all: Synchronously flush all hardware TLBs for this 
>> domain
>> + * @iotlb_sync_map: Sync mappings created recently using @map to the 
>> hardware
>> + * @iotlb_sync: Flush all queued ranges from the hardware TLBs and 
>> empty flush
>> + *            queue
>> + * @iova_to_phys: translate iova to physical address
>> + * @enable_nesting: Enable nesting
>> + * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>> + * @release: Release the domain after use.
> 
> Not sure about the name change here - it's still logically a "free" that 
> matches an "alloc", we're not doing anything clever like refcounting or 
> devres, which is what I'd tend to associate with a "release" function 
> for an allocated resource.

Yes. "free" is better.

> 
> Robin.

Best regards,
baolu
