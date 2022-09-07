Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114C45B0984
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIGQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiIGQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:00:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 298D631213
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:00:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA77106F;
        Wed,  7 Sep 2022 09:00:11 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC7603F71A;
        Wed,  7 Sep 2022 09:00:03 -0700 (PDT)
Message-ID: <51e9861b-38c0-0f22-385f-d4b57106d57b@arm.com>
Date:   Wed, 7 Sep 2022 16:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] iommu/virtio: Fix compile error with viommu_capable()
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220907151154.21911-1-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220907151154.21911-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-07 16:11, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent fix introduced viommu_capable() but other changes
> from Robin change the function signature of the call-back it
> is used for.
> 
> When both changes are merged a compile error will happen
> because the function pointer types mismatch. Fix that by
> updating the viommu_capable() signature after the merge.

I thought I'd called out somewhere that this was going to be a conflict, 
but apparently not, sorry about that.

Acked-by: Robin Murphy <robin.murphy@arm.com>

Lemme spin a patch for the outstanding LKP warning on the bus series 
before that gets annoying too...

> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/virtio-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index da463db9f12a..1b12825e2df1 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1005,7 +1005,7 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
>   }
>   
> -static bool viommu_capable(enum iommu_cap cap)
> +static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
