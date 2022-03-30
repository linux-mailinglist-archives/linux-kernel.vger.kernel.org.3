Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E184EB9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiC3FBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiC3FB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:01:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD9150B01
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648616382; x=1680152382;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AAnJAgMuarMezEE6861FCCJv3R52eEQVv1ovXHNPw/g=;
  b=O8VMFZptVLLR46R3S2ovfEKBNf098tapVKrkBEJcbvbKE1dxMfcwJ/wS
   jlmzaiHiP478hL+zB99J7dYtAv0oBa2HqKSSH9cCU83LgKK+il7njxlA7
   glT090ZniIS3nhbCdFRByXpcJkLYo3E0argBrbo9CQTsA707UOv41L4hH
   51pIOpBh7oFZAxkbNb7p7PoyY+xJOykg9y34X35EAhnHeCN61mOCgu9Mj
   wsUCOfvoEGIt4aBc4ZlS+Ow4FLq6zO6D/4axfshsLfeOVFFO+t1qX2pNw
   2UX9E6uQjGv5TvFNkFXTsznQ+OL9+Yjc7gh51LZOVg2ZdseIXBKfdJjy4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257025134"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="257025134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="565271463"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.164.87]) ([10.249.164.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:59:36 -0700
Message-ID: <9815626e-c42f-81a6-c933-52c1e6f48197@linux.intel.com>
Date:   Wed, 30 Mar 2022 12:59:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
In-Reply-To: <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/3/29 16:42, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, March 29, 2022 1:38 PM
>>
>> Some of the interfaces in the IOMMU core require that only a single
>> kernel device driver controls the device in the IOMMU group. The
>> existing method is to check the device count in the IOMMU group in
>> the interfaces. This is unreliable because any device added to the
>> IOMMU group later breaks this assumption without notifying the driver
>> using the interface. This adds iommu_group_singleton_lockdown() that
>> checks the requirement and locks down the IOMMU group with only single
>> device driver bound.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 30 ++++++++++++++++++------------
>>   1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0c42ece25854..9fb8a5b4491e 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -48,6 +48,7 @@ struct iommu_group {
>>   	struct list_head entry;
>>   	unsigned int owner_cnt;
>>   	void *owner;
>> +	bool singleton_lockdown;
>>   };
>>
>>   struct group_device {
>> @@ -968,15 +969,16 @@ void iommu_group_remove_device(struct device
>> *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_remove_device);
>>
>> -static int iommu_group_device_count(struct iommu_group *group)
>> +/* Callers should hold the group->mutex. */
>> +static bool iommu_group_singleton_lockdown(struct iommu_group *group)
>>   {
>> -	struct group_device *entry;
>> -	int ret = 0;
>> -
>> -	list_for_each_entry(entry, &group->devices, list)
>> -		ret++;
>> +	if (group->owner_cnt != 1 ||
>> +	    group->domain != group->default_domain ||
>> +	    group->owner)
>> +		return false;
> 
> Curious why there will be a case where group uses default_domain
> while still having a owner? I have the impression that owner is used
> for userspace DMA where a different domain is used.

You are right. The default domain is automatically detached when a user
is claimed. As long as a user is claimed, the group could only use an
empty or user-specified domain.

> 
>> +	group->singleton_lockdown = true;
>>
>> -	return ret;
>> +	return true;
>>   }
> 
> btw I'm not sure whether this is what SVA requires. IIRC the problem with
> SVA is because PASID TLP prefix is not counted in PCI packet routing thus
> a DMA target address with PASID might be treated as P2P if the address
> falls into the MMIO BAR of other devices in the group. This is why the
> original code needs to strictly apply SVA in a group containing a single
> device, instead of a group attached by a single driver, unless we want to
> reserve those MMIO ranges in CPU VA space.

You are right. But I don't think the IOMMU core is able to guarantee
above in a platform/device-agnostic way. Or any suggestions?

I guess this should be somewhat off-loaded to the device driver which
knows details of the device. The device driver should know this and
guarantee it before calling
iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA).

This patch itself just replaces the existing
"iommu_group_device_count(group) != 1" logic with a new one based on the
group ownership logistics. The former is obviously not friendly to
device hot joined afterward.

> 
> Jean can correct me if my memory is wrong.
> 
> Thanks
> Kevin

Best regards,
baolu
