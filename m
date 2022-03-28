Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8637D4E908D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiC1Iyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbiC1Iyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:54:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF02517E2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648457592; x=1679993592;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=KY/woiP3Ikl6M8527fLcfhM7r8Pg9Vb7dRAlz6bGG2I=;
  b=W4QStA59EzJuU1TKXT9dsVHbJsDY8pzmWAkYJwaxOf4nxdJYDMflgqBd
   HY3ZNNmzuTMMVyGfrGoN7D97AyjexKy5aWmSXyrAk20waQv4dh5y0T1lb
   e3gpW8kBqrd34BqNdhQcv//+eY9AnAjz8Vb9k+WgNbE6XKcanjIO5e1cK
   +72MVDsN8bDgWO+wvFocVVHkhr/sLSWgZ4rzhI23/eQ/bKAWJ64UGqC7b
   S67Utzz3hWC3X+gTfAcZOs8208IcivyrifkoxeP+gZxHGELBLQ/PTXr8w
   1PrEMnaAMfSUXjTWLZeTZbruYaPWTuREvqs6rvH/WAjbn//cDWf3T2qB9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="246437997"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="246437997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 01:53:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="502440248"
Received: from zgao13-mobl2.ccr.corp.intel.com (HELO [10.254.210.12]) ([10.254.210.12])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 01:53:09 -0700
Message-ID: <21bc406b-96f0-ae99-1606-9493f3cc2621@linux.intel.com>
Date:   Mon, 28 Mar 2022 16:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Tina Zhang <tina.zhang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Language: en-US
To:     David Stevens <stevensd@chromium.org>,
        Kevin Tian <kevin.tian@intel.com>
References: <20220322063555.1422042-1-stevensd@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
In-Reply-To: <20220322063555.1422042-1-stevensd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2022/3/22 14:35, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Calculate the appropriate mask for non-size-aligned page selective
> invalidation. Since psi uses the mask value to mask out the lower order
> bits of the target address, properly flushing the iotlb requires using a
> mask value such that [pfn, pfn+pages) all lie within the flushed
> size-aligned region.  This is not normally an issue because iova.c
> always allocates iovas that are aligned to their size. However, iovas
> which come from other sources (e.g. userspace via VFIO) may not be
> aligned.

This is bug fix, right? Can you please add "Fixes" and "Cc stable" tags?

> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
> v1 -> v2:
>   - Calculate an appropriate mask for non-size-aligned iovas instead
>     of falling back to domain selective flush.
> 
>   drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5b196cfe9ed2..ab2273300346 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   				  unsigned long pfn, unsigned int pages,
>   				  int ih, int map)
>   {
> -	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
> +	unsigned int aligned_pages = __roundup_pow_of_two(pages);
> +	unsigned int mask = ilog2(aligned_pages);
>   	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
>   	u16 did = domain->iommu_did[iommu->seq_id];
>   
> @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	if (domain_use_first_level(domain)) {
>   		domain_flush_piotlb(iommu, domain, addr, pages, ih);
>   	} else {
> +		unsigned long bitmask = aligned_pages - 1;
> +
> +		/*
> +		 * PSI masks the low order bits of the base address. If the
> +		 * address isn't aligned to the mask, then compute a mask value
> +		 * needed to ensure the target range is flushed.
> +		 */
> +		if (unlikely(bitmask & pfn)) {
> +			unsigned long end_pfn = pfn + pages - 1, shared_bits;
> +
> +			/*
> +			 * Since end_pfn <= pfn + bitmask, the only way bits
> +			 * higher than bitmask can differ in pfn and end_pfn is
> +			 * by carrying. This means after masking out bitmask,
> +			 * high bits starting with the first set bit in
> +			 * shared_bits are all equal in both pfn and end_pfn.
> +			 */
> +			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
> +			mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;

Can you please add some lines in the commit message to explain how this
magic line works? It's easier for people to understand it if you can
take a real example. :-)

Best regards,
baolu

> +		}
> +
>   		/*
>   		 * Fallback to domain selective flush if no PSI support or
> -		 * the size is too big. PSI requires page size to be 2 ^ x,
> -		 * and the base address is naturally aligned to the size.
> +		 * the size is too big.
>   		 */
>   		if (!cap_pgsel_inv(iommu->cap) ||
>   		    mask > cap_max_amask_val(iommu->cap))
