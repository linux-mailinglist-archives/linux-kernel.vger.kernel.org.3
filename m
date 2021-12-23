Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0E47E476
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbhLWOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:19:33 -0500
Received: from foss.arm.com ([217.140.110.172]:42984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLWOTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:19:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D186D6E;
        Thu, 23 Dec 2021 06:19:32 -0800 (PST)
Received: from [10.57.66.229] (unknown [10.57.66.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41FB3F5A1;
        Thu, 23 Dec 2021 06:19:29 -0800 (PST)
Message-ID: <09bf1d0a-44d8-b382-2e08-e0c79f4fbbaf@arm.com>
Date:   Thu, 23 Dec 2021 14:19:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Propagate errors from
 platform_get_irq()
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
 <20211223130046.9365-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211223130046.9365-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-23 13:00, Lad Prabhakar wrote:
> The driver overrides the error code returned by platform_get_irq() to
> -ENODEV. Switch to propagating the error code upstream so that errors
> such as -EPROBE_DEFER are handled.

I wouldn't usually expect an SMMU to be wired up to a secondary 
interrupt controller that could cause deferral, but on the other hand I 
don't think there's any good reason *not* to propagate the original 
error anyway, so sure, why not.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4844cd075644..6cf5612efcda 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2129,7 +2129,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		int irq = platform_get_irq(pdev, i);
>   
>   		if (irq < 0)
> -			return -ENODEV;
> +			return irq;
>   		smmu->irqs[i] = irq;
>   	}
>   
