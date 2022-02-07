Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE44AB90D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiBGKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiBGKng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:43:36 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 02:43:34 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 151D2C043189
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:43:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 595B811B3;
        Mon,  7 Feb 2022 02:26:20 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01BB3F718;
        Mon,  7 Feb 2022 02:26:18 -0800 (PST)
Message-ID: <f17da9b7-1642-762c-0854-e131e3c2f438@arm.com>
Date:   Mon, 7 Feb 2022 10:26:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in
 memory allocation
Content-Language: en-GB
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
References: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-05 17:10, Christophe JAILLET wrote:
> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
> 
> So turn a devm_kzalloc()+explicit size computation into an equivalent
> devm_kcalloc().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is NOT compile tested.
> I don't have the needed cross compiling tools.

FYI, https://cdn.kernel.org/pub/tools/crosstool/

Either way, the patch looks reasonable, thanks!

Acked-by: Robin Murphy <robin.murphy@arm.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6dc6d8b6b368..14d06aad0726 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2981,10 +2981,10 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>   {
>   	unsigned int i;
>   	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> -	size_t size = sizeof(*cfg->l1_desc) * cfg->num_l1_ents;
>   	void *strtab = smmu->strtab_cfg.strtab;
>   
> -	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
> +	cfg->l1_desc = devm_kcalloc(smmu->dev, cfg->num_l1_ents,
> +				    sizeof(*cfg->l1_desc), GFP_KERNEL);
>   	if (!cfg->l1_desc)
>   		return -ENOMEM;
>   
