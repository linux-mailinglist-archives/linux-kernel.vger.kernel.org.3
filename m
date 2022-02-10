Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556634B0235
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiBJB1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:27:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiBJB1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:27:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41047201AB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456424; x=1675992424;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aWgYdPh3hxkc5p9L3CTkYdSFZfZ5U7JLDAtc29XbeFU=;
  b=e61ms+AK3gpQCofjQxnkM75MMfMRU9Vvxmxq4lSvTmnxTRZ4WVKFexbC
   EIIZDviPGFwJpF+pIfb94KHB/mFnyyDnvVW5VJrZUg7SwlCRVQNc9Gvss
   lMqSqVsFna+HkbWSKHwV5nAmapS4pV6eu01qSV4g9alFeMy7NyFaq3+GE
   AV7UQlGKWYerGYImG9kxd6nz4elCV91Hn5LqbAjSFR5MzWL5EQyJz850G
   BU888SVAwdPxYCFb0wruilqDQ8dD3DwzKIqhmE84nr9CLtEvP/Q1s74Hd
   T/SRwsDWIN65ee/lZqWZkhpeJvDKJgVsUqU5xvnhRi1GhEjo14GM88YaR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335792989"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="335792989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678973478"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 17:11:47 -0800
Message-ID: <2707a77d-6171-0180-fa0e-72cf44719ed7@linux.intel.com>
Date:   Thu, 10 Feb 2022 09:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iommu: Use dev_iommu_ops() helper
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-10-baolu.lu@linux.intel.com>
 <20220209134152.GA4160@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209134152.GA4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 9:41 PM, Jason Gunthorpe wrote:
> On Tue, Feb 08, 2022 at 09:25:58AM +0800, Lu Baolu wrote:
>> Convert all the feasible instances of dev->bus->iommu_ops to
>> dev_iommu_ops() in order to making the operation of obtaining
>> iommu_ops from a device consistent.
> 
> Why are there two patches doing this conversion? Roll this into the
> prior patch?

It's reasonable to merge this patch into the previous one where
dev_iommu_ops() was added.

> 
>>   void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>   {
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   
>>   	if (ops && ops->get_resv_regions)
>>   		ops->get_resv_regions(dev, list);
> 
> And agree with Christoph, don't keep confusing ops null tests -
> dev_iommu_ops() never returns null and any function using it must rely
> on the caller to handle this, somehow.

Agree with you both.

> 
> However, I wonder how safe this is. Certainly some APIs like this one
> it is fine, but I would be happier if the 'first' APIs like
> bind/attach/alloc/etc fail silently upwards. In many cases these APIs
> are called based on things like DT configuration, or VFIO or
> something, and the caller is expecting the iommu layer to do all
> necessary validation.

domain_alloc()/bind/unbind/attach/detach/etc are APIs for external
kernel components. We shouldn't use dev_iommu_ops() there and all
necessary validation should be done.

The dev_iommu_ops() are for IOMMU subsystem internal use purpose, hence
we can add a WARN there and avoid further checks.

> 
>> @@ -2788,7 +2789,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>>   {
>>   	struct iommu_group *group;
>>   	struct iommu_sva *handle = ERR_PTR(-EINVAL);
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   
>>   	if (!ops || !ops->sva_bind)
>>   		return ERR_PTR(-ENODEV);
>> @@ -2831,7 +2832,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>   {
>>   	struct iommu_group *group;
>>   	struct device *dev = handle->dev;
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   
>>   	if (!ops || !ops->sva_unbind)
>>   		return;
>> @@ -2850,7 +2851,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>>   
>>   u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>>   {
>> -	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
>>   
>>   	if (!ops || !ops->sva_get_pasid)
>>   		return IOMMU_PASID_INVALID;
> 
> We all agreed that this sva object will turn into a domain and thus
> all of this will eventually move to domain ops?

Partially yes.

My plan is to leverage the sva-domain specific .attach/detach_dev_pasid
callbacks. All the sva related ops in iommu_ops could be removed.

> 
> Jason

Best regards,
baolu
