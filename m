Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAA4AB9D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbiBGLFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352892AbiBGK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:56:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1E4BC043189;
        Mon,  7 Feb 2022 02:56:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C69811D4;
        Mon,  7 Feb 2022 02:56:47 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634383F73B;
        Mon,  7 Feb 2022 02:56:45 -0800 (PST)
Message-ID: <f315aea5-b088-62ad-2234-81e8c0b13f74@arm.com>
Date:   Mon, 7 Feb 2022 10:56:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Simplify memory allocation
Content-Language: en-GB
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
References: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
 <018afc7c92ae4132ac901b088b72ab5979256a9e.1644081032.git.christophe.jaillet@wanadoo.fr>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <018afc7c92ae4132ac901b088b72ab5979256a9e.1644081032.git.christophe.jaillet@wanadoo.fr>
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

On 2022-02-05 17:11, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand writing it.

Heh, that reminds me that I have more or less the same patch sat locally 
somewhere, except IIRC I took it further and removed the unhelpful error 
message and pruned the local variables as well - I think that would 
still be my preference here (or I could dig out my patch and post it if 
you like).

Cheers,
Robin.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is NOT compile tested.
> I don't have the needed cross compiling tools.
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 14d06aad0726..ba0e7f1f7dbf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2911,12 +2911,6 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>   	return 0;
>   }
>   
> -static void arm_smmu_cmdq_free_bitmap(void *data)
> -{
> -	unsigned long *bitmap = data;
> -	bitmap_free(bitmap);
> -}
> -
>   static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>   {
>   	int ret = 0;
> @@ -2927,13 +2921,13 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>   	atomic_set(&cmdq->owner_prod, 0);
>   	atomic_set(&cmdq->lock, 0);
>   
> -	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
> +	bitmap = (atomic_long_t *)devm_bitmap_zalloc(smmu->dev, nents,
> +						     GFP_KERNEL);
>   	if (!bitmap) {
>   		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
>   		ret = -ENOMEM;
>   	} else {
>   		cmdq->valid_map = bitmap;
> -		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
>   	}
>   
>   	return ret;
