Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827CE53351C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiEYCDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiEYCDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:03:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC465D0F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653444213; x=1684980213;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=biV8YxTRJk34SukN2je6rt+JeuKJLQpZbk8KhgtBapk=;
  b=Y3S1Qq55ThhDpjO1DgY7mCMSpPd3J4ote2R2onTs9xIGYm8INXECjpEp
   D7L6zxlsVvZton06f1BSWGcxtNRNyiArQkgjtIavW78EehqmndsXyEOt7
   jdqrnWzffJ8yUVgy3VHuxlAlbl9/vypt72vPPMKonP+Tmymp23P0GKegw
   cdhwWmS27bvaGuu2eKI8nJ/l8GOWHzmQIuim2B2Xb9BdYfX12dNoctnFi
   4uAYmALNkeC/tR5YbLzrH2yJmDLSF/NraercmL81EyE/Fqz3ALgLaCVOO
   mWb3Q4i2mnDFtgE6Xs1GkBD97m8vhin1M03XcUDZ8ceTAG6BTnB6/czTz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="360084825"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360084825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:03:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601601512"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:03:28 -0700
Message-ID: <3c112762-f6e6-0b41-b38f-3bb2995d97cf@linux.intel.com>
Date:   Wed, 25 May 2022 10:03:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thank you for reviewing my patches.

On 2022/5/24 17:24, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 19, 2022 3:21 PM
>>
>> Use this field to keep the number of supported PASIDs that an IOMMU
>> hardware is able to support. This is a generic attribute of an IOMMU
>> and lifting it into the per-IOMMU device structure makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before enabling them on the devices.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>   include/linux/iommu.h                       | 2 ++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>>   drivers/iommu/intel/dmar.c                  | 4 ++++
>>   3 files changed, 7 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 5e1afe169549..da423e87f248 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -318,12 +318,14 @@ struct iommu_domain_ops {
>>    * @list: Used by the iommu-core to keep a list of registered iommus
>>    * @ops: iommu-ops for talking to this iommu
>>    * @dev: struct device for sysfs handling
>> + * @pasids: number of supported PASIDs
>>    */
>>   struct iommu_device {
>>   	struct list_head list;
>>   	const struct iommu_ops *ops;
>>   	struct fwnode_handle *fwnode;
>>   	struct device *dev;
>> +	u32 pasids;
> 
> max_pasid or nr_pasids?

max_pasid looks better.

> 
>>   };
>>
>>   /**
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 88817a3376ef..6e2cd082c670 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct
>> arm_smmu_device *smmu)
>>   	/* SID/SSID sizes */
>>   	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>>   	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
>> +	smmu->iommu.pasids = smmu->ssid_bits;
>>
>>   	/*
>>   	 * If the SMMU supports fewer bits than would fill a single L2 stream
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 4de960834a1b..1c3cf267934d 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1126,6 +1126,10 @@ static int alloc_iommu(struct dmar_drhd_unit
>> *drhd)
>>
>>   	raw_spin_lock_init(&iommu->register_lock);
>>
>> +	/* Supports full 20-bit PASID in scalable mode. */
>> +	if (ecap_pasid(iommu->ecap))
>> +		iommu->iommu.pasids = 1UL << 20;
>> +
> 
> supported pasid bits is reported by ecap_pss(). I don't think we should
> assume 20bits here.

Yes. I overlooked this. Thanks for reminding.

Another thing I need to improve is that scalable mode could be disabled.
This field should be 0 in that case.

> 
>>   	/*
>>   	 * This is only for hotplug; at boot time intel_iommu_enabled won't
>>   	 * be set yet. When intel_iommu_init() runs, it registers the units
>> --
>> 2.25.1
> 

Best regards,
baolu
