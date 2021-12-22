Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9047D1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbhLVMci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:32:38 -0500
Received: from foss.arm.com ([217.140.110.172]:44266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240517AbhLVMch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:32:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131091FB;
        Wed, 22 Dec 2021 04:32:37 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02FE23F5A1;
        Wed, 22 Dec 2021 04:32:34 -0800 (PST)
Message-ID: <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
Date:   Wed, 22 Dec 2021 12:32:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest
 owned VINTF
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        will@kernel.org
Cc:     jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        thierry.reding@gmail.com, jgg@nvidia.com,
        linux-arm-kernel@lists.infradead.org
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-6-nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211119071959.16706-6-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-19 07:19, Nicolin Chen via iommu wrote:
> When VCMDQs are assigned to a VINTF that is owned by a guest, not
> hypervisor (HYP_OWN bit is unset), only TLB invalidation commands
> are supported. This requires get_cmd() function to scan the input
> cmd before selecting cmdq between smmu->cmdq and vintf->vcmdq, so
> unsupported commands can still go through emulated smmu->cmdq.
> 
> Also the guest shouldn't have HYP_OWN bit being set regardless of
> guest kernel driver writing it or not, i.e. the user space driver
> running in the host OS should wire this bit to zero when trapping
> a write access to this VINTF_CONFIG register from a guest kernel.
> So instead of using the existing regval, this patch reads out the
> register value explicitly to cache in vintf->cfg.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
>   .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 32 +++++++++++++++++--
>   3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b1182dd825fd..73941ccc1a3e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -337,10 +337,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   	return 0;
>   }
>   
> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>   {
>   	if (smmu->nvidia_grace_cmdqv)
> -		return nvidia_grace_cmdqv_get_cmdq(smmu);
> +		return nvidia_grace_cmdqv_get_cmdq(smmu, cmds, n);
>   
>   	return &smmu->cmdq;
>   }
> @@ -747,7 +747,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	u32 prod;
>   	unsigned long flags;
>   	bool owner;
> -	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
> +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
>   	struct arm_smmu_ll_queue llq, head;
>   	int ret = 0;
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 24f93444aeeb..085c775c2eea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -832,7 +832,8 @@ struct nvidia_grace_cmdqv *
>   nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
>   			      struct acpi_iort_node *node);
>   int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
> -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
> +						  u64 *cmds, int n);
>   #else /* CONFIG_NVIDIA_GRACE_CMDQV */
>   static inline struct nvidia_grace_cmdqv *
>   nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
> @@ -847,7 +848,7 @@ static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
>   }
>   
>   static inline struct arm_smmu_cmdq *
> -nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>   {
>   	return NULL;
>   }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> index c0d7351f13e2..71f6bc684e64 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> @@ -166,7 +166,8 @@ static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
>   	return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
>   }
>   
> -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +struct arm_smmu_cmdq *
> +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>   {
>   	struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
>   	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> @@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>   	if (!FIELD_GET(VINTF_STATUS, vintf0->status))
>   		return &smmu->cmdq;
>   
> +	/* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
> +	if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
> +		u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;

I'm not sure there was ever a conscious design decision that batches 
only ever contain one type of command - if something needs to start 
depending on that behaviour then that dependency probably wants to be 
clearly documented. Also, a sync on its own gets trapped to the main 
cmdq but a sync on the end of a batch of TLBIs or ATCIs goes to the 
VCMDQ, huh?

> +
> +		/* List all supported CMDs for vintf->cmdq pathway */
> +		switch (opcode) {
> +		case CMDQ_OP_TLBI_NH_ASID:
> +		case CMDQ_OP_TLBI_NH_VA:
> +		case CMDQ_OP_TLBI_S12_VMALL:
> +		case CMDQ_OP_TLBI_S2_IPA:

Fun! Can the guest invalidate any VMID it feels like, or is there some 
additional magic on the host side that we're missing here?

> +		case CMDQ_OP_ATC_INV:
> +			break;
Ditto for StreamID here.

Robin.


> +		default:
> +			/* Unsupported CMDs go for smmu->cmdq pathway */
> +			return &smmu->cmdq;
> +		}
> +	}
> +
>   	/*
>   	 * Select a vcmdq to use. Here we use a temporal solution to
>   	 * balance out traffic on cmdq issuing: each cmdq has its own
> @@ -199,13 +218,22 @@ int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
>   	vintf0->idx = 0;
>   	vintf0->base = cmdqv->base + NVIDIA_CMDQV_VINTF(0);
>   
> +	/*
> +	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
> +	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
> +	 * set of supported commands, by following the HW design.
> +	 */
>   	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
>   	writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
>   
>   	regval |= FIELD_PREP(VINTF_EN, 1);
>   	writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
>   
> -	vintf0->cfg = regval;
> +	/*
> +	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
> +	 * kernel, so read back regval from HW to ensure that reflects in cfg
> +	 */
> +	vintf0->cfg = readl(vintf0->base + NVIDIA_VINTF_CONFIG);
>   
>   	ret = readl_relaxed_poll_timeout(vintf0->base + NVIDIA_VINTF_STATUS,
>   					 regval, regval == VINTF_ENABLED,
