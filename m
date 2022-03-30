Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D84EB9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiC3EcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiC3EcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:32:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CBF19298
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648614622; x=1680150622;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ymV54KbkzNGiX0mm/3VkYQ0yuZNW6n8dT6h/b4tupgE=;
  b=VHcvtfKysrfck03zdqYQd/7Zy9LCgR/UT0c3S+RcieVPwMmnLJzmMPt6
   PBwdzh/BOLHgnNgzE7A07GTpFmPb/hhrW0YAMOXNXP119r0utUws9M+yp
   4AiroHQz1YX7NpqeXQp6+UTAPh0no4kyMr29pvkEHmy+PLWUC8lfZd+Ry
   4qfUm/rfPPyyJpid0jMf3B85be8hwrpMzTbHA81+WBMad+yw8/Ttrjd0k
   pDgwZpI75GfPtWvMh9pfsOf3OEiULv2Xt/gsV4LFlYUsSqTRQDOrz0r28
   lXKkdyM/2jfUnppLcPXninBQf8kTqmOnHFpTypXaoWcMm2aZ7+TsoTBLD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="240039504"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="240039504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:30:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="565253787"
Received: from unknown (HELO [10.249.164.87]) ([10.249.164.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:30:18 -0700
Message-ID: <1bd9b977-500c-602b-8b55-e5f8a13f39ce@linux.intel.com>
Date:   Wed, 30 Mar 2022 12:30:15 +0800
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
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-2-baolu.lu@linux.intel.com>
 <20220329140015.70c073b6@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
In-Reply-To: <20220329140015.70c073b6@jacob-builder>
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

Hi Jacob,

On 2022/3/30 5:00, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Tue, 29 Mar 2022 13:37:50 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
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
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>>   drivers/iommu/intel/iommu.c                 | 5 ++++-
>>   3 files changed, 7 insertions(+), 1 deletion(-)
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
> pasid_width?
> PCI spec uses "Max PASID Width"
> 

My understanding is that this field represents "the pasid bits that the
device is able to use with its IOMMU". This field considers the
capabilities of both device and IOMMU. This is the reason why I put it
in the per-device iommu object and initialize it in the iommu
probe_device() callback.

Best regards,
baolu
