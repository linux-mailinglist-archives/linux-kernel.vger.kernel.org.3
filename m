Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83B545C93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbiFJGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiFJGrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:47:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06476005B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654843618; x=1686379618;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1AgV/VDwED8aBsSEyykhSM3WYKzT/Pl2+nELo3DDX6M=;
  b=TeZ404eIz9DzLZxQ5dFBCmM0UGv0ummp1W53MiBcEJCApjXO8Rv4MqO8
   w0OpoX2V5P8WLh+ZXrJfeRC0kraa09jCVCyIClBBPc4KGlzyonbT1yn98
   8f5Hdoh1/xmdd4BHqGUj0Xgx7YD9uNpt2qnQesOuZlXU3hAsLJ7SgFt1s
   WO4LzzBk62ZWF5C9dES0pYGx9iteu+M6nps8knTV/fPHpTpQI1rjmImAm
   OuGT/HKvTuOAHPV3UcQFmkq5Zyb2+nSp2coiSeljJjM2C53PXnRhTse9c
   ZPmwg3YgvpI6J89n2rRSfVAICvkjLYaeoK467WhTOPztmqO6YkOwL5LmJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302910574"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="302910574"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:46:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637975400"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148]) ([10.249.169.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:46:54 -0700
Message-ID: <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
Date:   Fri, 10 Jun 2022 14:46:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Content-Language: en-US
To:     "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
 <20220609190102.GC33363@araj-dh-work>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609190102.GC33363@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/10 03:01, Raj, Ashok wrote:
> On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
>> Use this field to save the number of PASIDs that a device is able to
>> consume. It is a generic attribute of a device and lifting it into the
>> per-device dev_iommu struct could help to avoid the boilerplate code
>> in various IOMMU drivers.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  2 ++
>>   drivers/iommu/iommu.c | 26 ++++++++++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 03fbb1b71536..d50afb2c9a09 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -364,6 +364,7 @@ struct iommu_fault_param {
>>    * @fwspec:	 IOMMU fwspec data
>>    * @iommu_dev:	 IOMMU device this device is linked to
>>    * @priv:	 IOMMU Driver private data
>> + * @max_pasids:  number of PASIDs device can consume
>>    *
>>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>>    *	struct iommu_group	*iommu_group;
>> @@ -375,6 +376,7 @@ struct dev_iommu {
>>   	struct iommu_fwspec		*fwspec;
>>   	struct iommu_device		*iommu_dev;
>>   	void				*priv;
>> +	u32				max_pasids;
>>   };
>>   
>>   int iommu_device_register(struct iommu_device *iommu,
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 847ad47a2dfd..adac85ccde73 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/err.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ats.h>
> 
> Is this needed for this patch?

Yes. It's for pci_max_pasids().

> 
>>   #include <linux/bitops.h>
>>   #include <linux/property.h>
>>   #include <linux/fsl/mc.h>
>> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
>>   	kfree(param);
>>   }
>>   
>> +static u32 dev_iommu_get_max_pasids(struct device *dev)
>> +{
>> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
>> +	u32 num_bits;
>> +	int ret;
>> +
>> +	if (!max_pasids)
>> +		return 0;
>> +
>> +	if (dev_is_pci(dev)) {
>> +		ret = pci_max_pasids(to_pci_dev(dev));
>> +		if (ret < 0)
>> +			return 0;
>> +
>> +		return min_t(u32, max_pasids, ret);
> 
> Ah.. that answers my other question to consider device pasid-max. I guess
> if we need any enforcement of restricting devices that aren't supporting
> the full PASID, that will be done by some higher layer?

The mm->pasid style of SVA is explicitly enabled through
iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA). The IOMMU driver specific
restriction might be put there?

> 
> too many returns in this function, maybe setup all returns to the end of
> the function might be elegant?

I didn't find cleanup room after a quick scan of the code. But sure, let
me go through code again offline.

> 
>> +	}
>> +
>> +	ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
>> +	if (ret)
>> +		return 0;
>> +
>> +	return min_t(u32, max_pasids, 1UL << num_bits);
>> +}
>> +
>>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>>   {
>>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> @@ -243,6 +268,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>   	}
>>   
>>   	dev->iommu->iommu_dev = iommu_dev;
>> +	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>>   
>>   	group = iommu_group_get_for_dev(dev);
>>   	if (IS_ERR(group)) {
>> -- 
>> 2.25.1
>>

Best regards,
Baolu
