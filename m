Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2655242F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiELDCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiELDCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:02:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB4B66ADE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652324566; x=1683860566;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CGKurnSeFsbLbVNz9r6t45Z5v3dxrNfQg/9bhybKC1Y=;
  b=AJwda6R52G/KUs0pP+Igkc/su45zyJ46GXpTXycI7xit7woTJGm2LrqG
   WAY/IgZnTOWAHHcy/pfLZHO8VoMFfPL7RWOXdy/fAxGO1vjuMjGMr4+sP
   Ku7s6trrrJlXC27UDTMuPgwGlJsgfEupNFrjJGPgqjOqlEyusAKY3LaHR
   SbHOr+2OLbJEcysWDNsYckOC6oS6HWLxcV85xDjXadKQYtVgQxl0EatrO
   2BOGozSKWIAVkatojIW1bK9r87FPfZffrJr7qdVxKRYsnDl2qVDXqaZon
   R3ukR6L99GG3qeSebI5rPTdLlRbPEh9jh6YgPMmMhF232kkMUErQq2xFV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332911936"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="332911936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:02:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594449960"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168]) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:02:41 -0700
Message-ID: <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
Date:   Thu, 12 May 2022 11:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220511145319.GZ49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>> Assuming we leave room for multi-device groups this logic should just
>>> be
>>>
>>> 	group = iommu_group_get(dev);
>>> 	if (!group)
>>> 		return -ENODEV;
>>>
>>> 	mutex_lock(&group->mutex);
>>> 	domain = xa_load(&group->pasid_array, mm->pasid);
>>> 	if (!domain || domain->type != IOMMU_DOMAIN_SVA || domain->mm != mm)
>>> 		domain = iommu_sva_alloc_domain(dev, mm);
>>>
>>> ?
>> Agreed. As a helper in iommu core, how about making it more generic like
>> below?
> IDK, is there more users of this? AFAIK SVA is the only place that
> will be auto-sharing?

The generic thing is that components, like SVA, want to fetch the
attached domain from the iommu core.

> 
>> +       mutex_lock(&group->mutex);
>> +       domain = xa_load(&group->pasid_array, pasid);
>> +       if (domain && domain->type != type)
>> +               domain = NULL;
>> +       mutex_unlock(&group->mutex);
>> +       iommu_group_put(group);
>> +
>> +       return domain;
> This is bad locking, group->pasid_array values cannot be taken outside
> the lock.

It's not iommu core, but SVA (or other feature components) that manage
the life cycle of a domain. The iommu core only provides a place to
store the domain pointer. The feature components are free to fetch their
domain pointers from iommu core as long as they are sure that the domain
is alive during use.

> 
>>> And stick the refcount in the sva_domain
>>>
>>> Also, given the current arrangement it might make sense to have a
>>> struct iommu_domain_sva given that no driver is wrappering this in
>>> something else.
>> Fair enough. How about below wrapper?
>>
>> +struct iommu_sva_domain {
>> +       /*
>> +        * Common iommu domain header,*must*  be put at the top
>> +        * of the structure.
>> +        */
>> +       struct iommu_domain domain;
>> +       struct mm_struct *mm;
>> +       struct iommu_sva bond;
>> +}
>>
>> The refcount is wrapped in bond.
> I'm still not sure that bond is necessary

"bond" is the sva handle that the device drivers get through calling
iommu_sva_bind().

> 
> But yes, something like that

Best regards,
baolu
