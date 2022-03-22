Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09254E35B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiCVAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiCVAqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:46:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB6DE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647909911; x=1679445911;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TSpDJqCgCqJQmfCcYan0G8S5Qg4VBq1hKKqgc00HwE4=;
  b=XFRLL3Z2p1krXhIPAwn+UCAPUCCEo7hUjZAgQpWO9XEZFSbJe7dKo31U
   I+oF4Xttns5meiBVYOZvH4w+z/tqc0q0HTQMs5b9qXXPRPcR3/nOWc0rv
   SZXVVaiNYa35sDJIFumbSAGkL+pIQ8Fk11qeY0Y35KrY346DP3NQFbG2N
   tNoSvTXLnJstqWVL7CdWwRws6KWA95XRiltklCnAU+xv+MSwopxxYRfl6
   45jflQHcLje4CJjtTShrc0+eMbZgaVp4P1ws86/B2TY6FcfM86wFYTZDS
   /N0PA1USQ5A4x1TIVHTBsDdazwo1f76bO3Pldu867cBbadCkJ+FKcwCic
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257876818"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257876818"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560118888"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.85]) ([10.254.208.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:45:07 -0700
Message-ID: <a0be971d-2cbc-8d62-4a05-9f8542fefe94@linux.intel.com>
Date:   Tue, 22 Mar 2022 08:45:05 +0800
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
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com> <Yjhf4dlthDkHBICr@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Yjhf4dlthDkHBICr@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 19:22, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Sun, Mar 20, 2022 at 02:40:20PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..8e262210b5ad 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>>   		master->iopf_enabled = true;
>>   		return 0;
>>   	case IOMMU_DEV_FEAT_SVA:
>> +		dev->iommu->pasid_bits = master->ssid_bits;
> This would be better in arm_smmu_probe_device()

Sure.

Best regards,
baolu
