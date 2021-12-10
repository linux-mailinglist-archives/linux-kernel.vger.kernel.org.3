Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2796946FAC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhLJGuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:50:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:7761 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237147AbhLJGuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:50:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225561527"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="225561527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 22:46:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="516643571"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.25]) ([10.254.211.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 22:46:36 -0800
Message-ID: <921a766f-d826-2ca4-f739-4d196b32a681@linux.intel.com>
Date:   Fri, 10 Dec 2021 14:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208132255.GS6385@nvidia.com> <20211208111659.6de22e52@jacob-builder>
 <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
 <20211209152113.64b817b9@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
In-Reply-To: <20211209152113.64b817b9@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/10 7:21, Jacob Pan wrote:
> On Thu, 9 Dec 2021 10:32:43 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 12/9/21 3:16 AM, Jacob Pan wrote:
>>> Hi Jason,
>>>
>>> On Wed, 8 Dec 2021 09:22:55 -0400, Jason Gunthorpe<jgg@nvidia.com>
>>> wrote:
>>>> On Tue, Dec 07, 2021 at 05:47:13AM -0800, Jacob Pan wrote:
>>>>> Between DMA requests with and without PASID (legacy), DMA mapping APIs
>>>>> are used indiscriminately on a device. Therefore, we should always
>>>>> match the addressing mode of the legacy DMA when enabling kernel
>>>>> PASID.
>>>>>
>>>>> This patch adds support for VT-d driver where the kernel PASID is
>>>>> programmed to match RIDPASID. i.e. if the device is in pass-through,
>>>>> the kernel PASID is also in pass-through; if the device is in IOVA
>>>>> mode, the kernel PASID will also be using the same IOVA space.
>>>>>
>>>>> There is additional handling for IOTLB and device TLB flush w.r.t. the
>>>>> kernel PASID. On VT-d, PASID-selective IOTLB flush is also on a
>>>>> per-domain basis; whereas device TLB flush is per device. Note that
>>>>> IOTLBs are used even when devices are in pass-through mode. ATS is
>>>>> enabled device-wide, but the device drivers can choose to manage ATS
>>>>> at per PASID level whenever control is available.
>>>>>
>>>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>>>>    drivers/iommu/intel/iommu.c | 105
>>>>> +++++++++++++++++++++++++++++++++++- drivers/iommu/intel/pasid.c |
>>>>> 7 +++ include/linux/intel-iommu.h |   3 +-
>>>>>    3 files changed, 113 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>>> index 60253bc436bb..a2ef6b9e4bfc 100644
>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>> @@ -1743,7 +1743,14 @@ static void domain_flush_piotlb(struct
>>>>> intel_iommu *iommu, if (domain->default_pasid)
>>>>>    		qi_flush_piotlb(iommu, did, domain->default_pasid,
>>>>>    				addr, npages, ih);
>>>>> -
>>>>> +	if (domain->kernel_pasid && !domain_type_is_si(domain)) {
>>>>> +		/*
>>>>> +		 * REVISIT: we only do PASID IOTLB inval for FL, we
>>>>> could have SL
>>>>> +		 * for PASID in the future such as vIOMMU PT. this
>>>>> doesn't get hit.
>>>>> +		 */
>>>>> +		qi_flush_piotlb(iommu, did, domain->kernel_pasid,
>>>>> +				addr, npages, ih);
>>>>> +	}
>>>>>    	if (!list_empty(&domain->devices))
>>>>>    		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr,
>>>>> npages, ih); }
>>>>> @@ -5695,6 +5702,100 @@ static void intel_iommu_iotlb_sync_map(struct
>>>>> iommu_domain *domain, }
>>>>>    }
>>>>>    
>>>>> +static int intel_enable_pasid_dma(struct device *dev, u32 pasid)
>>>>> +{
>>>> This seems like completely the wrong kind of op.
>>>>
>>>> At the level of the iommu driver things should be iommu_domain centric
>>>>
>>>> The op should be
>>>>
>>>> int attach_dev_pasid(struct iommu_domain *domain, struct device *dev,
>>>> ioasid_t pasid)
>>>>
>>>> Where 'dev' purpose is to provide the RID
>>>>
>>>> The iommu_domain passed in should be the 'default domain' ie the table
>>>> used for on-demand mapping, or the passthrough page table.
>>>>   
>>> Makes sense. DMA API is device centric, iommu API is domain centric. It
>>> should be the common IOMMU code to get the default domain then pass to
>>> vendor drivers. Then we can enforce default domain behavior across all
>>> vendor drivers.
>>> i.e. 	
>>> 	dom = iommu_get_dma_domain(dev);
>>> 	attach_dev_pasid(dom, dev, pasid);
>>>    
>>>>> +	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>>>>> +	struct device_domain_info *info;
>>>> I don't even want to know why an iommu driver is tracking its own
>>>> per-device state. That seems like completely wrong layering.
>>>>   
>>> This is for IOTLB and deTLB flush. IOTLB is flushed at per domain level,
>>> devTLB is per device.
>>>
>>> For multi-device groups, this is a need to track how many devices are
>>> using the kernel DMA PASID.
>>>
>>> Are you suggesting we add the tracking info in the generic layer? i.e.
>>> iommu_group.
>>>
>>> We could also have a generic device domain info to replace what is in
>>> VT-d and FSL IOMMU driver, etc.
>> The store place of per-device iommu driver private data has already been
>> standardized. The iommu core provides below interfaces for this purpose:
>>
>> void dev_iommu_priv_set(struct device *dev, void *priv);
>> void *dev_iommu_priv_get(struct device *dev);
>>
>> If we have anything generic among different vendor iommu drivers,
>> perhaps we could move them into dev->iommu.
>>
> Yes, good suggestion. DMA PASID should be a generic feature, not suitable
> for the opaque private date. Can we agree on adding the following flag for
> devTLB invalidation?
> 
> @@ -379,6 +379,7 @@ struct dev_iommu {
>          struct iommu_fwspec             *fwspec;
>          struct iommu_device             *iommu_dev;
>          void                            *priv;
> +       u32 pasid_dma_enabled           : 1;
>   };
> 
> For DMA PASID storage, can we store it in the iommu_domain instead of
> iommu_group? In the end, this PASID is only used for the default domain. It
> will be easier to refcount how many attached devices are using the PASID.
> Destroy the PASID when no devices in the group are using PASID DMA. IOTLB
> flush is per domain also.

Tying pasid to an iommu_domain is not a good idea. An iommu_domain
represents an I/O address translation table. It could be attached to a
device or a PASID on the device.

Perhaps the dev_iommu is a reasonable place for this.

@@ -390,6 +390,8 @@ struct dev_iommu {
         struct iommu_fwspec             *fwspec;
         struct iommu_device             *iommu_dev;
         void                            *priv;
+       unsigned int                    pasid_bits;
+       u32                             kernel_dma_pasid;
  };

@pasid_bits is a static attribute of a device which supports PASID
feature. It reads the PASID bitwidth that the device could support.
The vendor iommu driver could set this when the PASID feature is about
to be enabled. Normally, it's the MIN of device and iommu capabilities.

@kernel_dma_pasid is the PASID value used for kernel DMA if it's
enabled. It reads INVALID_IOASID if kernel DMA with PASID is not
enabled.

Best regards,
baolu
