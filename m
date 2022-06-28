Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A655E31F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiF1F47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiF1F4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:56:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F812872D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656395812; x=1687931812;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jkkFnV1SzLceUSN26FhY9YeMuVcIqRLbH9OTJaJLTP8=;
  b=FmBSpysHTDqBKTfU5nGFU5R3kuqZMFBqgO/xt2EIH7BBuQyHMDv87m/e
   /iMYyKAMs0jbVoS0K6q66s+V53CCgZlALiHp3EJOMKYv0MTNGERHKSp72
   CAzXSASl6KtVj6wqk2oYt4TQgDwlt3kgd8apDY+ddVAH7c4ijIZ27RkVB
   z4nkrXLrmCL0TF/EFV1L3Ct5gDfuv8MK8vGk4nD0kj3sNUm1sgCTLKoVC
   Nrd7AsRkUuG+Y4CacpeH0vOD3bbhjr7fTJ3IlJg2jnHom53W+ki7NwYh9
   UXt3s4gjcc19SY77R+6ZVtxILnmAZGwc9ZmBfe1SLO55QVPK7EA2afs5R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307121855"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307121855"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646762122"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:53:37 -0700
Message-ID: <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
Date:   Tue, 28 Jun 2022 13:53:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
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
 <20220621144353.17547-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/27 18:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 10:44 PM
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>> mm_struct *mm)
>> +{
>> +	struct iommu_domain *domain;
>> +	ioasid_t max_pasids;
>> +	int ret = -EINVAL;
>> +
>> +	/* Allocate mm->pasid if necessary. */
> 
> this comment is for iommu_sva_alloc_pasid()

Updated.

> 
>> +	max_pasids = dev->iommu->max_pasids;
>> +	if (!max_pasids)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
> 
> 
> ...
>> +void iommu_sva_unbind_device(struct iommu_sva *handle)
>> +{
>> +	struct device *dev = handle->dev;
>> +	struct iommu_domain *domain =
>> +			container_of(handle, struct iommu_domain, bond);
>> +	ioasid_t pasid = iommu_sva_get_pasid(handle);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	if (refcount_dec_and_test(&domain->bond.users)) {
>> +		iommu_detach_device_pasid(domain, dev, pasid);
>> +		iommu_domain_free(domain);
>> +	}
>> +	mutex_unlock(&iommu_sva_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>> +
>> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>> +{
>> +	struct iommu_domain *domain =
>> +			container_of(handle, struct iommu_domain, bond);
>> +
>> +	return domain->mm->pasid;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> 
> Looks this is only used by unbind_device. Just open code it.

It's part of current IOMMU/SVA interfaces for the device drivers, and
has been used in various drivers.

$ git grep iommu_sva_get_pasid
drivers/dma/idxd/cdev.c:                pasid = iommu_sva_get_pasid(sva);
drivers/iommu/iommu-sva-lib.c:  ioasid_t pasid = 
iommu_sva_get_pasid(handle);
drivers/iommu/iommu-sva-lib.c:u32 iommu_sva_get_pasid(struct iommu_sva 
*handle)
drivers/iommu/iommu-sva-lib.c:EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
drivers/misc/uacce/uacce.c:     pasid = iommu_sva_get_pasid(handle);
include/linux/iommu.h:u32 iommu_sva_get_pasid(struct iommu_sva *handle);
include/linux/iommu.h:static inline u32 iommu_sva_get_pasid(struct 
iommu_sva *handle)

Or, I missed anything?

Best regards,
baolu
