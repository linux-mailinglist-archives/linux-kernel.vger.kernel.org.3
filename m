Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C34F8098
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiDGNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiDGNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:33:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6213C286DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:31:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C9A12FC;
        Thu,  7 Apr 2022 06:31:51 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C3D3F73B;
        Thu,  7 Apr 2022 06:31:50 -0700 (PDT)
Message-ID: <f7039f1f-81ef-2fab-4ade-728316b54942@arm.com>
Date:   Thu, 7 Apr 2022 14:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Content-Language: en-GB
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220404204723.9767-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-04 21:47, Mario Limonciello wrote:
> Previously the AMD IOMMU would only enable SWIOTLB in certain
> circumstances:
>   * IOMMU in passthrough mode
>   * SME enabled
> 
> This logic however doesn't work when an untrusted device is plugged in
> that doesn't do page aligned DMA transactions.  The expectation is
> that a bounce buffer is used for those transactions.
> 
> This fails like this:
> 
> swiotlb buffer is full (sz: 4096 bytes), total 0 (slots), used 0 (slots)
> 
> That happens because the bounce buffers have been allocated, followed by
> freed during startup but the bounce buffering code expects that all IOMMUs
> have left it enabled.
> 
> Remove the criteria to set up bounce buffers on AMD systems to ensure
> they're always available for supporting untrusted devices.

FWIW it's also broken for another niche case where 
iommu_default_passthrough() == false at init, but the user later changes 
a 32-bit device's default domain type to passthrough via sysfs, such 
that it starts needing regular dma-direct bouncing.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Enable swiotlb for AMD instead of ignoring it for inactive
> 
>   drivers/iommu/amd/iommu.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a1ada7bff44e..079694f894b8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1838,17 +1838,10 @@ void amd_iommu_domain_update(struct protection_domain *domain)
>   	amd_iommu_domain_flush_complete(domain);
>   }
>   
> -static void __init amd_iommu_init_dma_ops(void)
> -{
> -	swiotlb = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
> -}
> -
>   int __init amd_iommu_init_api(void)
>   {
>   	int err;
>   
> -	amd_iommu_init_dma_ops();
> -
>   	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
>   	if (err)
>   		return err;
