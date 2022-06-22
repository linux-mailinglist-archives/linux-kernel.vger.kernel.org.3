Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0555401C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355440AbiFVBdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiFVBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:33:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D896CE027
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655861620; x=1687397620;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pJdqvRBiCPlK7UZbaNKlDRpZsDkk8unk6mQOBeFOpcY=;
  b=j+wVCrmDteq/WZES2C+8KcvQJq+JnmX++IkCoIPSalzc1WC4zX2vkues
   We1RImSBLQKTBGM2YG4qdA83BZeq15MlQO3/Y4Chm68nx8YJCalCYhOxv
   ukcRJq9WMtrOm9OgxKiuybqcUXMdj5hfAxsYpYm7xSmjPGx3WPL+3SJBN
   5NRbV0rc/Ot1SuDjfBc2EX7T+JXy6UsA4vgSZn95yIez/Y9jQ63KtmPLB
   8dxx0vI+kVoSNV26DMhRVGePajkv5KbRW5aRBRmjQIOZ654ZDj/lvh6E7
   jXbMhrPoPhe4K7j+2FOyrrtyxHZnhNM7KMohWbHLcIsJY/4VIGextI+1C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281014312"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="281014312"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:33:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="833848950"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26]) ([10.249.172.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:33:38 -0700
Message-ID: <3f8d1656-dea5-6525-07f9-6dfe5f2aaf23@linux.intel.com>
Date:   Wed, 22 Jun 2022 09:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu: Make .release_device optional
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <bda9d3eb4527eac8f6544a15067e2529cca54a2e.1655822151.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bda9d3eb4527eac8f6544a15067e2529cca54a2e.1655822151.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 23:14, Robin Murphy wrote:
> Many drivers do nothing meaningful for .release_device, and it's neatly
> abstracted to just two callsites in the core code, so let's make it
> optional to implement.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/fsl_pamu_domain.c | 5 -----
>   drivers/iommu/iommu.c           | 6 ++++--
>   drivers/iommu/msm_iommu.c       | 5 -----
>   drivers/iommu/sun50i-iommu.c    | 3 ---
>   drivers/iommu/tegra-gart.c      | 5 -----
>   drivers/iommu/tegra-smmu.c      | 3 ---
>   6 files changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 94b4589dc67c..011f9ab7f743 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -447,15 +447,10 @@ static struct iommu_device *fsl_pamu_probe_device(struct device *dev)
>   	return &pamu_iommu;
>   }
>   
> -static void fsl_pamu_release_device(struct device *dev)
> -{
> -}
> -
>   static const struct iommu_ops fsl_pamu_ops = {
>   	.capable	= fsl_pamu_capable,
>   	.domain_alloc	= fsl_pamu_domain_alloc,
>   	.probe_device	= fsl_pamu_probe_device,
> -	.release_device	= fsl_pamu_release_device,
>   	.device_group   = fsl_pamu_device_group,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= fsl_pamu_attach_device,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 06d6989f07f6..8b4fc7e62b99 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -259,7 +259,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	return 0;
>   
>   out_release:
> -	ops->release_device(dev);
> +	if (ops->release_device)
> +		ops->release_device(dev);
>   
>   out_module_put:
>   	module_put(ops->owner);
> @@ -337,7 +338,8 @@ void iommu_release_device(struct device *dev)
>   	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>   
>   	ops = dev_iommu_ops(dev);
> -	ops->release_device(dev);
> +	if (ops->release_device)
> +		ops->release_device(dev);
>   
>   	iommu_group_remove_device(dev);
>   	module_put(ops->owner);
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index f09aedfdd462..428919a474c1 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -394,10 +394,6 @@ static struct iommu_device *msm_iommu_probe_device(struct device *dev)
>   	return &iommu->iommu;
>   }
>   
> -static void msm_iommu_release_device(struct device *dev)
> -{
> -}
> -
>   static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   {
>   	int ret = 0;
> @@ -677,7 +673,6 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>   static struct iommu_ops msm_iommu_ops = {
>   	.domain_alloc = msm_iommu_domain_alloc,
>   	.probe_device = msm_iommu_probe_device,
> -	.release_device = msm_iommu_release_device,
>   	.device_group = generic_device_group,
>   	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
>   	.of_xlate = qcom_iommu_of_xlate,
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index c54ab477b8fd..a84c63518773 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -738,8 +738,6 @@ static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
>   	return &iommu->iommu;
>   }
>   
> -static void sun50i_iommu_release_device(struct device *dev) {}
> -
>   static struct iommu_group *sun50i_iommu_device_group(struct device *dev)
>   {
>   	struct sun50i_iommu *iommu = sun50i_iommu_from_dev(dev);
> @@ -764,7 +762,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
>   	.domain_alloc	= sun50i_iommu_domain_alloc,
>   	.of_xlate	= sun50i_iommu_of_xlate,
>   	.probe_device	= sun50i_iommu_probe_device,
> -	.release_device	= sun50i_iommu_release_device,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= sun50i_iommu_attach_device,
>   		.detach_dev	= sun50i_iommu_detach_device,
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index a6700a40a6f8..e5ca3cf1a949 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -246,10 +246,6 @@ static struct iommu_device *gart_iommu_probe_device(struct device *dev)
>   	return &gart_handle->iommu;
>   }
>   
> -static void gart_iommu_release_device(struct device *dev)
> -{
> -}
> -
>   static int gart_iommu_of_xlate(struct device *dev,
>   			       struct of_phandle_args *args)
>   {
> @@ -273,7 +269,6 @@ static void gart_iommu_sync(struct iommu_domain *domain,
>   static const struct iommu_ops gart_iommu_ops = {
>   	.domain_alloc	= gart_iommu_domain_alloc,
>   	.probe_device	= gart_iommu_probe_device,
> -	.release_device	= gart_iommu_release_device,
>   	.device_group	= generic_device_group,
>   	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
>   	.of_xlate	= gart_iommu_of_xlate,
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 1fea68e551f1..2a8de975fe63 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -864,8 +864,6 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
>   	return &smmu->iommu;
>   }
>   
> -static void tegra_smmu_release_device(struct device *dev) {}
> -
>   static const struct tegra_smmu_group_soc *
>   tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
>   {
> @@ -966,7 +964,6 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   static const struct iommu_ops tegra_smmu_ops = {
>   	.domain_alloc = tegra_smmu_domain_alloc,
>   	.probe_device = tegra_smmu_probe_device,
> -	.release_device = tegra_smmu_release_device,
>   	.device_group = tegra_smmu_device_group,
>   	.of_xlate = tegra_smmu_of_xlate,
>   	.pgsize_bitmap = SZ_4K,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
