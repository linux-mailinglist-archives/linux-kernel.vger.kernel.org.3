Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C635507AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbiDSUat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbiDSUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:30:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F239B3AA4D;
        Tue, 19 Apr 2022 13:28:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5F0E106F;
        Tue, 19 Apr 2022 13:28:02 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495383F73B;
        Tue, 19 Apr 2022 13:28:00 -0700 (PDT)
Message-ID: <52df6c79-3ee7-35e2-b72a-44ee9cb48c34@arm.com>
Date:   Tue, 19 Apr 2022 21:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v1] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Content-Language: en-GB
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        vdumpa@nvidia.com, will@kernel.org, joro@8bytes.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, Snikam@nvidia.com,
        Pritesh Raithatha <praithatha@nvidia.com>
References: <20220417090432.21110-1-amhetre@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220417090432.21110-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-17 10:04, Ashish Mhetre wrote:
> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> entries to not be invalidated correctly. The problem is that the walk
> cache index generated for IOVA is not same across translation and
> invalidation requests. This is leading to page faults when PMD entry is
> released during unmap and populated with new PTE table during subsequent
> map request. Disabling large page mappings avoids the release of PMD
> entry and avoid translations seeing stale PMD entry in walk cache.
> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
> Tegra234 devices. This is recommended fix from Tegra hardware design
> team.

Is this related to any of the several known MMU-500 invalidation errata, 
or is it definitely specific to something NVIDIA have done with their 
integration?

> Co-developed-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 23 ++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.c        |  3 +++
>   drivers/iommu/arm/arm-smmu/arm-smmu.h        |  1 +
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> index 01e9b50b10a1..b7a3d06da2f4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -258,6 +258,27 @@ static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct devi
>   			dev_name(dev), err);
>   }
>   
> +static void nvidia_smmu_cfg_pgsize_bitmap(struct arm_smmu_device *smmu)
> +{
> +	const struct device_node *np = smmu->dev->of_node;
> +
> +	/*
> +	 * Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> +	 * entries to not be invalidated correctly. The problem is that the walk
> +	 * cache index generated for IOVA is not same across translation and
> +	 * invalidation requests. This is leading to page faults when PMD entry
> +	 * is released during unmap and populated with new PTE table during
> +	 * subsequent map request. Disabling large page mappings avoids the
> +	 * release of PMD entry and avoid translations seeing stale PMD entry in
> +	 * walk cache.
> +	 * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
> +	 * Tegra234.
> +	 */
> +	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
> +	    of_device_is_compatible(np, "nvidia,tegra194-smmu"))
> +		smmu->pgsize_bitmap = PAGE_SIZE;
> +}
> +
>   static const struct arm_smmu_impl nvidia_smmu_impl = {
>   	.read_reg = nvidia_smmu_read_reg,
>   	.write_reg = nvidia_smmu_write_reg,
> @@ -268,10 +289,12 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
>   	.global_fault = nvidia_smmu_global_fault,
>   	.context_fault = nvidia_smmu_context_fault,
>   	.probe_finalize = nvidia_smmu_probe_finalize,
> +	.cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
>   };
>   
>   static const struct arm_smmu_impl nvidia_smmu_single_impl = {
>   	.probe_finalize = nvidia_smmu_probe_finalize,
> +	.cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
>   };
>   
>   struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 568cce590ccc..3692a19a588a 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1872,6 +1872,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K)
>   		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
>   
> +	if (smmu->impl && smmu->impl->cfg_pgsize_bitmap)
> +		smmu->impl->cfg_pgsize_bitmap(smmu);

I'm not the biggest fan of adding a super-specific hook for this, when 
it seems like it could just as easily be handled in the init_context 
hook, which is where it is precisely for the purpose of mangling the 
pgtable_cfg to influence io-pgtable's behaviour.

Thanks,
Robin.

> +
>   	if (arm_smmu_ops.pgsize_bitmap == -1UL)
>   		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
>   	else
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 2b9b42fb6f30..5d9b03024969 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -442,6 +442,7 @@ struct arm_smmu_impl {
>   	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
>   	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
>   	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
> +	void (*cfg_pgsize_bitmap)(struct arm_smmu_device *smmu);
>   };
>   
>   #define INVALID_SMENDX			-1
