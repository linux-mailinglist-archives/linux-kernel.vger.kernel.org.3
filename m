Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6867C4C478E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiBYOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbiBYOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:33:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C18C71B84D1;
        Fri, 25 Feb 2022 06:32:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3914106F;
        Fri, 25 Feb 2022 06:32:27 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC7D3F5A1;
        Fri, 25 Feb 2022 06:32:26 -0800 (PST)
Message-ID: <af255483-a2b9-64dd-ec4f-4be21427e23f@arm.com>
Date:   Fri, 25 Feb 2022 14:32:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/arm-smmu: remove redundant assignment to variable
 res
Content-Language: en-GB
To:     Colin Ian King <colin.i.king@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220225093205.170973-1-colin.i.king@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220225093205.170973-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-25 09:32, Colin Ian King wrote:
> The variable res is being assigned a value that isn't being read
> later. The assignment is redundant and can be removed.
> 
> Cleans up clang scan warning:
> drivers/iommu/arm/arm-smmu/arm-smmu.c:2109:10: warning: Although the
> value stored to 'res' is used in the enclosing expression, the value
> is never actually read from 'res' [deadcode.DeadStores]

Thanks Colin, however in general we need to get rid of this 
platform_get_resource() call ASAP anyway, so Will should hopefully be 
picking up either [1] or [2] for 5.18.

Cheers,
Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/b2a40caaf1622eb35c555074a0d72f4f0513cff9.1645106346.git.robin.murphy@arm.com/
[2] 
https://lore.kernel.org/linux-arm-kernel/20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com/

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4bc75c4ce402..f83d2c32b5a9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2106,7 +2106,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		return PTR_ERR(smmu);
>   
>   	num_irqs = 0;
> -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> +	while (platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs)) {
>   		num_irqs++;
>   		if (num_irqs > smmu->num_global_irqs)
>   			smmu->num_context_irqs++;
