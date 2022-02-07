Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5124AC4AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353457AbiBGP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382945AbiBGPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:55:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A7F9C0401D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:55:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA37A11D4;
        Mon,  7 Feb 2022 07:55:37 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA303F718;
        Mon,  7 Feb 2022 07:55:36 -0800 (PST)
Message-ID: <58e77093-51e2-59a2-e413-164d83ecd9b8@arm.com>
Date:   Mon, 7 Feb 2022 15:55:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct
 assignment
Content-Language: en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>
References: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
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

On 2022-02-07 14:13, Andy Shevchenko wrote:
> Use DMA ops setter instead of direct assignment. Even we know that
> this module doesn't perform access to the dma_ops member of struct device,
> it's better to use setter to avoid potential problems in the future.

What potential problems are you imagining? This whole file is a DMA ops 
implementation, not driver code (and definitely not a module); if anyone 
removes the "select DMA_OPS" from CONFIG_IOMMU_DMA they deserve whatever 
breakage they get.

I concur that there's no major harm in using the helper here, but I also 
see no point in pretending that there's any value to abstracting the 
operation in this particular context.

Thanks,
Robin.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rebased on top of the latest codebase
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d85d54f2b549..b585a3fdbc56 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1482,7 +1482,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>   	if (iommu_is_dma_domain(domain)) {
>   		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>   			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> +		set_dma_ops(dev, &iommu_dma_ops);
>   	}
>   
>   	return;
