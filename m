Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE0E55CC37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245051AbiF1Flj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbiF1Flf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:41:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B11408B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656394894; x=1687930894;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UxZR/mfdIqnqviiBYRwMkxb2Ju8jlNFffAZNscjJglY=;
  b=Hc8Rx5qC34rHSI69z/UtaaonHnSYyA/QKaZWka4Aet9XGLALiqj+Q/Ag
   wfwZ2cm2zTCMf4QaYbsMilT6VEHu4dhxNq1VLnCfXMq9l4NCm0nEJdktz
   chb2WdhM9Yds4N6wTEC8b8JAe0yprIktGTInriF1sP7esXxMHUv/zRoZk
   dwGImLR8S+PoX6riff7yBQ95ol9Jlo2u42WjeGw+nMPzdPPYOAACZSq2T
   +tff0X9CvLUJ/+XAydbwZ4tt9endzpYaIDC/KrD4ScNZXaboC/IhIgZrg
   Wibgt7b4/qMfctu8pUbC1lXVYtzBYJOsZkwQgZPdQRqsOjso3sgpTnT4Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264680973"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264680973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:41:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646758511"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:41:30 -0700
Message-ID: <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
Date:   Tue, 28 Jun 2022 13:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/6/27 16:29, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 10:44 PM
>>
>> The sva iommu_domain represents a hardware pagetable that the IOMMU
>> hardware could use for SVA translation. This adds some infrastructure
>> to support SVA domain in the iommu common layer. It includes:
>>
>> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA
>> domain
>>    type. The IOMMU drivers that support SVA should provide the sva
>>    domain specific iommu_domain_ops.
>> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>>    is still used to free an SVA domain.
>> - Add helpers to attach an SVA domain to a device and the reverse
>>    operation.
>>
>> Some buses, like PCI, route packets without considering the PASID value.
>> Thus a DMA target address with PASID might be treated as P2P if the
>> address falls into the MMIO BAR of other devices in the group. To make
>> things simple, the attach/detach interfaces only apply to devices
>> belonging to the singleton groups, and the singleton is immutable in
>> fabric i.e. not affected by hotplug.
>>
>> The iommu_attach/detach_device_pasid() can be used for other purposes,
>> such as kernel DMA with pasid, mediation device, etc.
> 
> I'd split this into two patches. One for adding iommu_attach/
> detach_device_pasid() and set/block_dev_pasid ops, and the
> other for adding SVA.

Yes. Make sense.

> 
>>   struct iommu_domain {
>>   	unsigned type;
>>   	const struct iommu_domain_ops *ops;
>>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>> -	iommu_fault_handler_t handler;
>> -	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	union {
>> +		struct {	/* IOMMU_DOMAIN_DMA */
>> +			iommu_fault_handler_t handler;
>> +			void *handler_token;
>> +		};
> 
> why is it DMA domain specific? What about unmanaged
> domain? Unrecoverable fault can happen on any type
> including SVA. Hence I think above should be domain type
> agnostic.

The report_iommu_fault() should be replaced by the new
iommu_report_device_fault(). Jean has already started this work.

https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/

Currently this is only for DMA domains, hence Robin suggested to make it
exclude with the SVA domain things.

https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-68305f683349@arm.com/

> 
>> +		struct {	/* IOMMU_DOMAIN_SVA */
>> +			struct mm_struct *mm;
>> +		};
>> +	};
>>   };
>>
> 
> 
> 
>> +
>> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>> +					    struct mm_struct *mm)
>> +{
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +	struct iommu_domain *domain;
>> +
>> +	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (!domain)
>> +		return NULL;
>> +
>> +	domain->type = IOMMU_DOMAIN_SVA;
> 
> It's a bit weird that the type has been specified when calling
> ops->domain_alloc while it still leaves to the caller to set the
> type. But this is not caused by this series. could be cleaned
> up separately.

Yes. Robin has patches to refactor the domain allocation interface,
let's wait and see what it looks like finally.

> 
>> +
>> +	mutex_lock(&group->mutex);
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
>> GFP_KERNEL);
>> +	if (curr)
>> +		goto out_unlock;
> 
> Need check xa_is_err(old).

Either

(1) old entry is a valid pointer, or
(2) xa_is_err(curr)

are failure cases. Hence, "curr == NULL" is the only check we need. Did
I miss anything?

Best regards,
baolu
