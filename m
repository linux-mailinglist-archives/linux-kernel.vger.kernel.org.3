Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD924B01E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiBJBVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:21:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiBJBVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:21:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D97642
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456065; x=1675992065;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xwE1+7sMycEL12v2IFo1+/lSPYpAhi5LFao4nn13fD8=;
  b=BpK2yLJa/KjhPp6QwyOvoyMzaaZr7FQrbaN6wWPz5ZfIPiVpamaZdwaz
   Sz18WT4ijWQfipVDGAchIPaeslp47FB/NLJFlrq4/p49G/N0hydbMl4LJ
   8Bgae38zVl4qtpudgYQ8wL3YKlVKGXZm4J8cb2S4P4Y+fg/tY6M9M0chy
   92248znlDBF5s3Nvo8R8RwmsRN7B97i3njpRusp2gNfuSIXNNrAtikUZ9
   voylm17ASuc6fBze3VCK2ft1Q/szf2tKQJ+6CUsBYZNvpjHJkVNTVlK6F
   gl7D88lP9rrkXpy0PZ0aa6sabnEhXh5BansQOAErd6t36vqE9pztQdKLN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335794104"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="335794104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678975431"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 17:21:02 -0800
Message-ID: <16e2142d-30cf-a4e2-c010-b58301b5392e@linux.intel.com>
Date:   Thu, 10 Feb 2022 09:19:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Don't cast parameter in
 for_each_set_bit()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220209174913.4319-1-andriy.shevchenko@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209174913.4319-1-andriy.shevchenko@linux.intel.com>
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

Hi Andy,

On 2/10/22 1:49 AM, Andy Shevchenko wrote:
> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case the location
> of the parameter is changed.
> 
> Don't cast parameter to unsigned long pointer in for_each_set_bit().
> Instead copy to a local variable on stack of a proper type and use.
> 
> Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..777e81b8f4f5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4973,6 +4973,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   	struct device_domain_info *info;
>   	struct intel_iommu *iommu;
> +	unsigned long cache_bits;
>   	unsigned long flags;
>   	int cache_type;
>   	u8 bus, devfn;
> @@ -5008,9 +5009,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
>   				   inv_info->granu.addr_info.nb_granules);
>   
> -	for_each_set_bit(cache_type,
> -			 (unsigned long *)&inv_info->cache,
> -			 IOMMU_CACHE_INV_TYPE_NR) {
> +	cache_bits = inv_info->cache;
> +	for_each_set_bit(cache_type, &cache_bits, IOMMU_CACHE_INV_TYPE_NR) {
>   		int granu = 0;
>   		u64 pasid = 0;
>   		u64 addr = 0;

Thanks for your patch. The function that you are changing becomes dead
code (nobody uses it and there's no plan to use it anymore) now. I
already have a patch to remove this function.

Best regards,
baolu
