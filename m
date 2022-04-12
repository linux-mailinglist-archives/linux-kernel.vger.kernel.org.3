Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F964FE206
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355415AbiDLNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355538AbiDLNH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:07:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A676B09C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649768000; x=1681304000;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=3p+HZigMoDJf+SmGF5tM7x7zvBgqrhGgl3QbbiaEU7I=;
  b=JTFCxR5VxOJW/TgnO5Tu43UYQW1G71gsJwKvKQGTQ/shqJxq8ogaKrjk
   I3RztTRgXNDc2GZxIKZsqDy+IuxVKGK4amneU8vw24bzp3Hk3KVwG+QYr
   GTXeHnxUU2qIBJARM0TWUWn9PAjcs7zLl2FmbmkCWQ3FXdlERG0smjhRZ
   aMQtgu4MEqJ4ltLmDddNC92OJ4qBzHgXYtRBpAb3MtMaFzjqfGpIpXzzt
   2dfHz6jK9hXPODIxCo5djKD6Vzvlt0FlVGgWK8WqGclM79bpooB4rf8V3
   XpgBoAWEYeV4rYbiE5aZ8YeH71XAmH2JMKpi0LVLXhW3cMNaGojOgIGU3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244249533"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="244249533"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:53:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572752923"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:53:13 -0700
Message-ID: <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
Date:   Tue, 12 Apr 2022 20:53:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
In-Reply-To: <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 15:19, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
>> *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +	struct iommu_sva_ioas *ioas;
>> +
>> +	/*
>> +	 * TODO: Remove the drvdata parameter after kernel PASID support
>> is
>> +	 * enabled for the idxd driver.
>> +	 */
>> +	if (drvdata)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	/* Allocate mm->pasid if necessary. */
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits)
>> - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	ioas = iommu_sva_ioas_get(mm, mm->pasid);
>> +	if (!ioas) {
>> +		ret = -ENOMEM;
> 
> ioas can be NULL for multiple reasons, e.g. :
> 
> 1) ioas->mm != mm;
> 2) kzalloc failure;
> 3) xa_store failure;
> 
> It's more sensible to return error from iommu_sva_ioas_get() directly.

Fair enough.

> 
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* Search for an existing bond. */
>> +	list_for_each_entry(handle, &ioas->bonds, node) {
>> +		if (handle->dev == dev) {
>> +			refcount_inc(&handle->users);
>> +			/* No new bond, drop the counter. */
>> +			iommu_sva_ioas_put(ioas);
>> +			goto out_success;
>> +		}
>> +	}
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> 
> s/handle/bond/?

"handle" is used in the previous implementation but "bond" looks better
to read. :-)

> 
>> +	if (!handle) {
>> +		ret = -ENOMEM;
>> +		goto out_put_ioas;
>> +	}
>> +
>> +	/* The reference to ioas will be kept until domain free. */
>> +	domain = iommu_sva_alloc_domain(dev, ioas);
> 
> Shouldn't we first try whether existing domains are compatible to this
> device?

If we think that here domain represents a hardware pagetable actually
used by IOMMU for a {device, pasid}, we are able to use per-{device,
pasid} domain without checking compatibility. Sharing a domain among
devices under the same IOMMU may be an optimization. That could be done
in the IOMMU driver just like what vt-d driver is doing for pass-through
DMA domains.

> 
>> @@ -1952,6 +1954,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>>   void iommu_domain_free(struct iommu_domain *domain)
>>   {
>>   	iommu_put_dma_cookie(domain);
>> +	iommu_sva_ioas_put(domain->sva_ioas);
>>   	domain->ops->free(domain);
>>   }
> 
> is it good to have general iommu_domain_free() to always call a put()
> function for a specific domain type? Why cannot it be done before
> calling iommu_domain_free() in sva-lib.c?

It's better to have a generic free() helper since an sva domain could be
freed outside of iommu sva code as you can see in the following patches.

Best regards,
baolu
