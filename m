Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E324B1B51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbiBKBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:34:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiBKBeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:34:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7625582
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644543276; x=1676079276;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+BVql9j+nSKuX06ape3W050amhEw94XEN/hSBH7FZEM=;
  b=PSlsCtLDCT3aI+2ogqVTyfasyY6XYDFdoxmu1sJJeWUN9Uei1YquCJgG
   VnOcvi2e5AvEUOJ0umbcPAKsPbNC6Eq+AeuSfFZsueOdg9PUeM53AjHIr
   qcCrna2Q+wLRfl/b6VJjcdwsKsUoUQ0hnwPr+cXjjQwZhrG4V5TnmjkzL
   HbeQCQ9EYYTQUnPYLy/7VrkVzgs7h5rnUKaGM2P9sFzF7FR5f1SZfBHSz
   d8LD+UPFu8l+C14BkoURxaIy6GK1ntSR6s+RzQBbYTxFkAglrBBWF5Y98
   sP++HbAMJIrjjfWnnXmnLvkV+1VHWB9m+cWjT9R9a/QLVGQvGvva7Nc9b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247223268"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="247223268"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 17:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="679360603"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2022 17:34:34 -0800
Message-ID: <532a9259-a1f4-dc1e-acfe-8ac2c6de71b9@linux.intel.com>
Date:   Fri, 11 Feb 2022 09:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Remove trivial ops->capable implementations
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 8:29 PM, Robin Murphy wrote:
> Implementing ops->capable to always return false is pointless since it's
> the default behaviour anyway. Clean up the unnecessary implementations.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Spinning this out of my bus ops stuff (currently 30 patches and
> counting...) since it would be better off alongside Baolu's cleanup
> series to avoid conflicts, and I want to depend on those patches for
> dev_iommu_ops() anyway.
> 
>   drivers/iommu/msm_iommu.c  | 6 ------
>   drivers/iommu/tegra-gart.c | 6 ------
>   drivers/iommu/tegra-smmu.c | 6 ------
>   3 files changed, 18 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 06bde6b66732..22061ddbd5df 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -558,11 +558,6 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> -static bool msm_iommu_capable(enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static void print_ctx_regs(void __iomem *base, int ctx)
>   {
>   	unsigned int fsr = GET_FSR(base, ctx);
> @@ -672,7 +667,6 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>   }
>   
>   static struct iommu_ops msm_iommu_ops = {
> -	.capable = msm_iommu_capable,
>   	.domain_alloc = msm_iommu_domain_alloc,
>   	.domain_free = msm_iommu_domain_free,
>   	.attach_dev = msm_iommu_attach_dev,
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 6a358f92c7e5..bbd287d19324 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -238,11 +238,6 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
>   	return pte & GART_PAGE_MASK;
>   }
>   
> -static bool gart_iommu_capable(enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static struct iommu_device *gart_iommu_probe_device(struct device *dev)
>   {
>   	if (!dev_iommu_fwspec_get(dev))
> @@ -276,7 +271,6 @@ static void gart_iommu_sync(struct iommu_domain *domain,
>   }
>   
>   static const struct iommu_ops gart_iommu_ops = {
> -	.capable	= gart_iommu_capable,
>   	.domain_alloc	= gart_iommu_domain_alloc,
>   	.domain_free	= gart_iommu_domain_free,
>   	.attach_dev	= gart_iommu_attach_dev,
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e900e3c46903..43df44f918a1 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -272,11 +272,6 @@ static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
>   	clear_bit(id, smmu->asids);
>   }
>   
> -static bool tegra_smmu_capable(enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
>   {
>   	struct tegra_smmu_as *as;
> @@ -967,7 +962,6 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   }
>   
>   static const struct iommu_ops tegra_smmu_ops = {
> -	.capable = tegra_smmu_capable,
>   	.domain_alloc = tegra_smmu_domain_alloc,
>   	.domain_free = tegra_smmu_domain_free,
>   	.attach_dev = tegra_smmu_attach_dev,

Looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
