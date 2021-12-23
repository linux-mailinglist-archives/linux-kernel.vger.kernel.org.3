Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0847E46A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbhLWOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:14:43 -0500
Received: from foss.arm.com ([217.140.110.172]:42892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243804AbhLWOOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:14:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75DE6D6E;
        Thu, 23 Dec 2021 06:14:41 -0800 (PST)
Received: from [10.57.66.229] (unknown [10.57.66.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920083F5A1;
        Thu, 23 Dec 2021 06:14:39 -0800 (PST)
Message-ID: <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
Date:   Thu, 23 Dec 2021 14:14:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
Content-Language: en-GB
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Xin Tan <tanxin.ctf@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-23 13:00, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_count().

Nit: platform_irq_count()

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4bc75c4ce402..4844cd075644 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	if (IS_ERR(smmu))
>   		return PTR_ERR(smmu);
>   
> -	num_irqs = 0;
> -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> -		num_irqs++;
> -		if (num_irqs > smmu->num_global_irqs)
> -			smmu->num_context_irqs++;
> -	}
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 0)
> +		return num_irqs;
> +
> +	if (num_irqs > smmu->num_global_irqs)
> +		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);

This seems a bit overcomplicated. I reckon:

	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
	if (num_irqs <= smmu->num_global_irqs) {
		dev_err(...

should do it.

However, FYI I have some patches refactoring most of the IRQ stuff here 
that I plan to post next cycle (didn't quite have time to get them done 
for 5.17 as I'd hoped...), so unless this needs to go in right now as an 
urgent fix, I'm happy to take care of removing platform_get_resource() 
as part of that if it's easier.

Thanks,
Robin.

>   
>   	if (!smmu->num_context_irqs) {
>   		dev_err(dev, "found %d interrupts but expected at least %d\n",
