Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991B04B0B22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbiBJKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:43:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbiBJKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:43:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B088FFC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:43:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 622D9ED1;
        Thu, 10 Feb 2022 02:43:24 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 845013F718;
        Thu, 10 Feb 2022 02:43:23 -0800 (PST)
Message-ID: <b090141f-0822-609f-429d-ea790d7fc828@arm.com>
Date:   Thu, 10 Feb 2022 10:43:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] iommu: explicitly check for NULL in
 iommu_dma_get_resv_regions()
Content-Language: en-GB
To:     Aleksandr Fedorov <sanekf@nxt.ru>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
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

On 2022-02-09 14:09, Aleksandr Fedorov wrote:
> iommu_dma_get_resv_regions() assumes that iommu_fwspec field for
> corresponding device is set which is not always true.  Since
> iommu_dma_get_resv_regions() seems to be a future-proof generic API
> that can be used by any iommu driver, add an explicit check for NULL.

Except it's not a "generic" interface for drivers to call at random, 
it's a helper for retrieving common firmware-based information 
specifically for drivers already using the fwspec mechanism for common 
firmware bindings. If any driver calls this with a device *without* a 
valid fwnode, it deserves to crash because it's done something 
fundamentally wrong.

I concur that it's not exactly obvious that "non-IOMMU-specific" means 
"based on common firmware bindings, thus implying fwspec".

Robin.

> Currently it can work by accident since compiler can eliminate
> the 'iommu_fwspec' check altogether when CONFIG_ACPI_IORT=n, but
> code elimination from optimizations is not reliable.
> 
> Signed-off-by: Aleksandr Fedorov <halcien@gmail.com>
> ---
> A compilation failure has been observed on a gcc-compatible compiler based on EDG.
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d85d54f2b549..474b1b7211d7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -382,10 +382,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>    */
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
> +	struct iommu_fwspec *iommu_fwspec = dev_iommu_fwspec_get(dev);
>   
> -	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> +	if (iommu_fwspec && !is_of_node(iommu_fwspec->iommu_fwnode))
>   		iort_iommu_msi_get_resv_regions(dev, list);
> -
>   }
>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>   
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
