Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A94E243B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbiCUKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiCUKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:23:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0DA66EE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647858126; x=1679394126;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XQTkYCh9YcXqTv8VJW0SOk4W9PTAARN8gk3ZQyi7IxU=;
  b=Fc1XtqK41aPIlvb2T+C8rorrbd9c6RJh4Ex9XtMExWGqYmYrLbuGfmRB
   qHf0H1W+uSQXNBtGdboI08mrJP+624hvxvD0bAaKvUH5m9I3d7Ip9yTH6
   HzvTyLxfFXxlfh3jEKNwqxdeiEmUlSJEVm9u/FyU/Rg7OR5lJ5eoJjsbT
   9hIVx9AUjjLqMWhug7IRSfG2qOctBxpQ0ufY1PJDgHu6d4KBQso1HbODj
   qvDJI+/MCPmoWHUe+MFEwnYIvSkzwonjATbdG3yPWsGqe7uhlun0WO0cI
   +Rgnm16rsDbrIxUvMH0x9yAZgyHsvqE98lDLgRbMJUX3rPxP+EmZzv5PY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257235629"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257235629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:22:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559805216"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169]) ([10.254.213.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:22:02 -0700
Message-ID: <7de05f5e-864f-175e-5604-29561d330884@linux.intel.com>
Date:   Mon, 21 Mar 2022 18:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
 <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 15:01, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
>> Use this field to save the pasid/ssid bits that a device is able to
>> support with its IOMMU hardware. It is a generic attribute of a device
>> and lifting it into the per-device dev_iommu struct makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before features are enabled on the devices.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h                       | 1 +
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>>   drivers/iommu/intel/iommu.c                 | 5 ++++-
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 6ef2df258673..36f43af0af53 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -368,6 +368,7 @@ struct dev_iommu {
>>   	struct iommu_fwspec		*fwspec;
>>   	struct iommu_device		*iommu_dev;
>>   	void				*priv;
>> +	unsigned int			pasid_bits;
>>   };
>>
>>   int iommu_device_register(struct iommu_device *iommu,
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..8e262210b5ad 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct
>> device *dev,
>>   		master->iopf_enabled = true;
>>   		return 0;
>>   	case IOMMU_DEV_FEAT_SVA:
>> +		dev->iommu->pasid_bits = master->ssid_bits;
>>   		return arm_smmu_master_enable_sva(master);
>>   	default:
>>   		return -EINVAL;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 6f7485c44a4b..c1b91bce1530 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4587,8 +4587,11 @@ static struct iommu_device
>> *intel_iommu_probe_device(struct device *dev)
>>   			if (pasid_supported(iommu)) {
>>   				int features = pci_pasid_features(pdev);
>>
>> -				if (features >= 0)
>> +				if (features >= 0) {
>>   					info->pasid_supported = features | 1;
>> +					dev->iommu->pasid_bits =
>> +						fls(pci_max_pasids(pdev)) - 1;
> Original intel_svm_alloc_pasid() covers both PCI and non-PCI devices:
> 
> 	ioasid_t max_pasid = dev_is_pci(dev) ?
> 		pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> 
> though I'm not sure whether non-PCI SVA has been supported indeed, this
> patch implies a functional change here.
> 

The info->pasid_supported is only set for PCI devices. So the status is
that non-PCI SVA hasn't been supported. No functional change here from
this point of view.

Best regards,
baolu
