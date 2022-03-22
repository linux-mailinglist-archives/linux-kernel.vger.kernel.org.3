Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61B64E37ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiCVEbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiCVEbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:31:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38B1408C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647923387; x=1679459387;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1W86sXEli1RnC50Lifh7zwKkpipBaeccg3PcImsLsw=;
  b=ck+BZ7PLCOdFTPPGI353q+vIdU+Plw81S5dz1ka9z6sd7x7coJ2NYX0p
   pVfZQK8YL7NP0iU0nS/ijUy777rx1E/GpUDbb267he4wzycYIAIuaFnl5
   zwRYlrKRzUQ/TDQ/TaMoW7i8BS/Z3Bc1Rw2UVyKnW80EyGL8O4qoTYQqN
   N2Ej8RWHRrzxkgL6InM02eaYdRIgkcwYiAZ8w24ZiC4fObi/tUsRMK3mJ
   F20vj58msuA8QtMLdyq0mafa9HB19AYo1UktJRSLRP5uFr1vKl9G3CmFn
   EkE7fgz75dAgokKC4dSepDwbg8LUiHLSPWTt31QhHn5jiQim32F1SrO98
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257667672"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257667672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:29:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518718729"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186]) ([10.254.209.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:29:42 -0700
Message-ID: <ba9802c5-2a45-9a85-2e0b-ebbc84870dc8@linux.intel.com>
Date:   Tue, 22 Mar 2022 12:29:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com> <YjhiohZAbN1ornmB@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YjhiohZAbN1ornmB@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 19:33, Jean-Philippe Brucker wrote:
> On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..47cf98e661ff 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -3,6 +3,8 @@
>>    * Helpers for IOMMU drivers implementing SVA
>>    */
>>   #include <linux/mutex.h>
>> +#include <linux/iommu.h>
>> +#include <linux/slab.h>
>>   #include <linux/sched/mm.h>
>>   
>>   #include "iommu-sva-lib.h"
>> @@ -69,3 +71,101 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>> +
>> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
>> +{
>> +	struct bus_type *bus = dev->bus;
>> +	struct iommu_domain *domain;
>> +
>> +	if (!bus || !bus->iommu_ops)
>> +		return NULL;
>> +
>> +	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (domain)
>> +		domain->type = IOMMU_DOMAIN_SVA;
>> +
>> +	return domain;
>> +}
>> +
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @drvdata: opaque data pointer to pass to bind callback
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken.
> This is not true anymore, we return a different structure for each call.
> 
>> Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
>> +	if (ret)
>> +		goto out;
>> +
>> +	domain = iommu_sva_domain_alloc(dev);
>> +	if (!domain) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	domain->sva_cookie = mm;
>> +
>> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
>> +	if (ret)
>> +		goto out_free_domain;
>> +
>> +	handle->dev = dev;
>> +	handle->domain = domain;
>> +	handle->pasid = mm->pasid;
>> +
>> +	return handle;
>> +
>> +out_free_domain:
>> +	iommu_domain_free(domain);
>> +out:
>> +	kfree(handle);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
>> +
>> +/**
>> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
>> + * @handle: the handle returned by iommu_sva_bind_device()
>> + *
>> + * Put reference to a bond between device and address space.
> Same here. But I'd prefer keeping the old behavior so device drivers don't
> have to keep track of {dev, mm} pairs themselves.

Okay. Thank you for pointing this out. Let me figure it out in the next
version.

Best regards,
baolu
