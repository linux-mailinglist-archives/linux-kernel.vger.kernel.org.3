Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9228596D64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiHQLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiHQLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:12:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E35676772
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:12:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7CD6113E;
        Wed, 17 Aug 2022 04:12:08 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315443F67D;
        Wed, 17 Aug 2022 04:12:07 -0700 (PDT)
Message-ID: <4f5e43ca-c02a-07bd-0c8e-1a90be49fec9@arm.com>
Date:   Wed, 17 Aug 2022 12:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] iova: Remove magazine BUG_ON() checks
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <1660730984-30333-3-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1660730984-30333-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-17 11:09, John Garry wrote:
> Two of the magazine helpers have BUG_ON() checks, as follows:
> - iova_magazine_pop() - here we ensure that the mag is not empty. However we
>    already ensure that in the only caller, __iova_rcache_get().
> - iova_magazine_push() - here we ensure that the mag is not full. However
>    we already ensure that in the only caller, __iova_rcache_insert().
> 
> As described, the two bug checks are pointless so drop them.

In some ways it's logical to have assertions to make sure that callers 
*are* already checking so as not to call incorrectly. However I'm 
inclined to agree that this particular case is very niche, with little 
chance of any new callers being added, so they're not offering much 
value, especially on performance-critical paths.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 580fdf669922..8aece052ce72 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -694,8 +694,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>   	int i;
>   	unsigned long pfn;
>   
> -	BUG_ON(iova_magazine_empty(mag));
> -
>   	/* Only fall back to the rbtree if we have no suitable pfns at all */
>   	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>   		if (i == 0)
> @@ -710,8 +708,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>   
>   static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>   {
> -	BUG_ON(iova_magazine_full(mag));
> -
>   	mag->pfns[mag->size++] = pfn;
>   }
>   
