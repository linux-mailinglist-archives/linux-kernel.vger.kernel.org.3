Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6485229A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiEKCZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiEKCZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:25:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0C541A0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652235954; x=1683771954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W+VWsIRnkEGuh9oI6gzNdZHzNHTm1OXhUcAHi/Gdvh8=;
  b=MWwcUO+j7iAIlVWXSuLO6BUO268dgHW9PKCIjaC6E6QvWaxHo302/xri
   wWnmO0eEn++Wc7JSsG/ZKNz2OzKm59uMdYERg7r7HMhfO4dTg4lTd4R9s
   QrM4pijZm1yZ5XrqcX6dhMXMQdruN+DtGcFPxcyiWaGfQSo0tk1F1S9Qv
   am0DxQywez/VpA/eeuM/7oXMfTKQLwuup0xAl4J3s2hUnumGCtKF4KeN+
   J8Li3tU7H+AVaa4yE6pf+CyBDyyvq7WXD0Fk0YhGhb2mgAsw+OKXdvdVh
   m7SoHPx2nTtksHZ3V/ljRHAI4t6RNiw+PWXAB5PRgSPR4Xy2wUse78/lp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251610187"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="251610187"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:25:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="542091647"
Received: from chenji3x-mobl1.ccr.corp.intel.com (HELO [10.255.30.10]) ([10.255.30.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:25:50 -0700
Message-ID: <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
Date:   Wed, 11 May 2022 10:25:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
 <20220510143405.GE49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220510143405.GE49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 22:34, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 02:17:28PM +0800, Lu Baolu wrote:
> 
>>   int iommu_device_register(struct iommu_device *iommu,
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..afc63fce6107 100644
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>>   	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>>   		master->stall_enabled = true;
>>   
>> +	dev->iommu->pasid_bits = master->ssid_bits;
>>   	return &smmu->iommu;
>>   
>>   err_free_master:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 2990f80c5e08..99643f897f26 100644
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4624,8 +4624,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>   			if (pasid_supported(iommu)) {
>>   				int features = pci_pasid_features(pdev);
>>   
>> -				if (features >= 0)
>> +				if (features >= 0) {
>>   					info->pasid_supported = features | 1;
>> +					dev->iommu->pasid_bits =
>> +						fls(pci_max_pasids(pdev)) - 1;
>> +				}
> 
> It is not very nice that both the iommu drivers have to duplicate the
> code to read the pasid capability out of the PCI device.
> 
> IMHO it would make more sense for the iommu layer to report the
> capability of its own HW block only, and for the core code to figure
> out the master's limitation using a bus-specific approach.

Fair enough. The iommu hardware capability could be reported in

/**
  * struct iommu_device - IOMMU core representation of one IOMMU hardware
  *                       instance
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
  */
struct iommu_device {
         struct list_head list;
         const struct iommu_ops *ops;
         struct fwnode_handle *fwnode;
         struct device *dev;
};

I haven't checked ARM code yet, but it works for x86 as far as I can
see.

> 
> It is also unfortunate that the enable/disable pasid is inside the
> iommu driver as well - ideally the PCI driver itself would do this
> when it knows it wants to use PASIDs.
> 
> The ordering interaction with ATS makes this look quite annoying
> though. :(
> 
> I'm also not convinced individual IOMMU drivers should be forcing ATS
> on, there are performance and functional implications here. Using ATS
> or not is possibly best left as an administrator policy controlled by
> the core code. Again we seem to have some mess.

Agreed with you. This has already been in my task list. I will start to
solve it after the iommufd tasks.

Best regards,
baolu
