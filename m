Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A628247B309
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhLTSmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:42:38 -0500
Received: from foss.arm.com ([217.140.110.172]:33236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240513AbhLTSmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:42:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2BC6D;
        Mon, 20 Dec 2021 10:42:35 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 904723F774;
        Mon, 20 Dec 2021 10:42:30 -0800 (PST)
Message-ID: <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
Date:   Mon, 20 Dec 2021 18:42:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA
 Grace CMDQ-V
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        will@kernel.org
Cc:     nicoleotsuka@gmail.com, thierry.reding@gmail.com,
        vdumpa@nvidia.com, nwatterson@nvidia.com, jean-philippe@linaro.org,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        Jonathan.Cameron@huawei.com, yuzenghui@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        jgg@nvidia.com
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211119071959.16706-5-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-19 07:19, Nicolin Chen wrote:
> From: Nate Watterson <nwatterson@nvidia.com>
> 
> NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
> which extends the standard ARM SMMU v3 IP to support multiple
> VCMDQs with virtualization capabilities. In-kernel of host OS,
> they're used to reduce contention on a single queue. In terms
> of command queue, they are very like the standard CMDQ/ECMDQs,
> but only support CS_NONE in the CS field of CMD_SYNC command.
> 
> This patch adds a new nvidia-grace-cmdqv file and inserts its
> structure pointer into the existing arm_smmu_device, and then
> adds related function calls in the arm-smmu-v3 driver.
> 
> In the CMDQV driver itself, this patch only adds minimal part
> for host kernel support. Upon probe(), VINTF0 is reserved for
> in-kernel use. And some of the VCMDQs are assigned to VINTF0.
> Then the driver will select one of VCMDQs in the VINTF0 based
> on the CPU currently executing, to issue commands.

Is there a tangible difference to DMA API or VFIO performance?

[...]
> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +{
> +	struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
> +	struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> +	u16 qidx;
> +
> +	/* Check error status of vintf0 */
> +	if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> +		return &smmu->cmdq;
> +
> +	/*
> +	 * Select a vcmdq to use. Here we use a temporal solution to
> +	 * balance out traffic on cmdq issuing: each cmdq has its own
> +	 * lock, if all cpus issue cmdlist using the same cmdq, only
> +	 * one CPU at a time can enter the process, while the others
> +	 * will be spinning at the same lock.
> +	 */
> +	qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;

How does ordering work between queues? Do they follow a global order 
such that a sync on any queue is guaranteed to complete all prior 
commands on all queues?

The challenge to make ECMDQ useful to Linux is how to make sure that all 
the commands expected to be within scope of a future CMND_SYNC plus that 
sync itself all get issued on the same queue, so I'd be mildly surprised 
if you didn't have the same problem.

Robin.

> +	return &vintf0->vcmdqs[qidx];
> +}
