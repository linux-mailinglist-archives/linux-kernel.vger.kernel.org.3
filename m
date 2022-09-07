Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89B5B050F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiIGNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:22:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A4E8B995
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:22:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B32561042;
        Wed,  7 Sep 2022 06:22:19 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB51C3F7B4;
        Wed,  7 Sep 2022 06:22:10 -0700 (PDT)
Message-ID: <342eeb04-f240-b4a7-2994-8f69d4ca4087@arm.com>
Date:   Wed, 7 Sep 2022 14:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 3/3] iova: Remove iovad->rcaches check in
 iova_rcache_get()
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, jsnitsel@redhat.com,
        haifeng.zhao@linux.intel.com
References: <1662555754-142760-1-git-send-email-john.garry@huawei.com>
 <1662555754-142760-4-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1662555754-142760-4-git-send-email-john.garry@huawei.com>
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

On 2022-09-07 14:02, John Garry wrote:
> The iovad->rcaches check in iova_rcache_get() is pretty much useless
> without the same check in iova_rcache_insert().
> 
> Instead of adding this symmetric check to fathpath iova_rcache_insert(),

Nit: "fastpath"

> drop the check in iova_rcache_get() in favour of making the IOVA domain
> rcache init more robust to failure in future.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 8aece052ce72..a44ad92fc5eb 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -875,7 +875,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   {
>   	unsigned int log_size = order_base_2(size);
>   
> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
> +	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>   		return 0;
>   
>   	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
