Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08BF52E425
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbiETE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345472AbiETEzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:55:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61338A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653022552; x=1684558552;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X9avb/d0O6a8NxBxoEs+XuMddItGnculjWwGxAs+/8k=;
  b=GramgafIRMj27tn5PDEqQ3Gm7zhVbImaAIsKYjbPbjTUiGA1oCrXY8OT
   lGkxFjKRdVpAQNuOj93422O0atRKOl4+Bo1+hgjV2uG20f+S76PrYBR5D
   Ec63qfpZFY9iQvgVOfwLfSKg2RuHq18fH78lOFGNsoUxvbaXhjXG8LSGg
   BJ8MznlaFBMoS3RO1EYjVEhzNZIe6AfOg7nS46Pfb/McpJZNhtfwudlBR
   Hopr8a3VWX1XyT9FY4fElGL/95ZiLL0gpzfRHt+7hpvvfVGrgG8F93MUh
   toAOeWa+RnGHdk+DGcFZUjO/EB2MrDXK33v5M2BlH2B/0gewQfyzbvdAD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272615718"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272615718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 21:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="599005699"
Received: from wangyu5-mobl.ccr.corp.intel.com (HELO [10.249.172.121]) ([10.249.172.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 21:55:44 -0700
Message-ID: <d269d0b1-2e08-d469-0e32-2b042cd79bbd@linux.intel.com>
Date:   Fri, 20 May 2022 12:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com> <YoZxb26tYf8mmv87@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YoZxb26tYf8mmv87@myrica>
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

On 2022/5/20 00:33, Jean-Philippe Brucker wrote:
>> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
>> index 8909ea1094e3..1be21e6b93ec 100644
>> --- a/drivers/iommu/iommu-sva-lib.h
>> +++ b/drivers/iommu/iommu-sva-lib.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/ioasid.h>
>>   #include <linux/mm_types.h>
>> +#include <linux/iommu.h>
>>   
>>   int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>>   struct mm_struct *iommu_sva_find(ioasid_t pasid);
>> @@ -16,6 +17,20 @@ struct device;
>>   struct iommu_fault;
>>   struct iopf_queue;
>>   
>> +struct iommu_sva_domain {
>> +	struct iommu_domain	domain;
>> +	struct mm_struct	*mm;
>> +};
>> +
>> +#define to_sva_domain(d) container_of_safe(d, struct iommu_sva_domain, domain)
> Is there a reason to use the 'safe' version of container_of()?  Callers of
> to_sva_domain() don't check the return value before dereferencing it so
> they would break anyway if someone passes an error pointer as domain.  I
> think it matters because there is no other user of container_of_safe() in
> the kernel (the only user, lustre, went away in 2018) so someone will want
> to remove it.

Fair enough. I wondered why there's no user in the tree. Thanks for the
explanation. I will replace it with container_of().

> 
> Apart from that
> 
> Reviewed-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> 

Thank you!

Best regards,
baolu
