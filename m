Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DD596CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiHQKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiHQKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:36:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 727FC51A33
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:36:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06EF7113E;
        Wed, 17 Aug 2022 03:36:31 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530193F67D;
        Wed, 17 Aug 2022 03:36:29 -0700 (PDT)
Message-ID: <388efa0d-d8b8-a837-b301-ef04ba3d6e4e@arm.com>
Date:   Wed, 17 Aug 2022 11:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] iova: Remove some magazine pointer NULL checks
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <1660730984-30333-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1660730984-30333-2-git-send-email-john.garry@huawei.com>
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
> Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
> has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
> pointers. As such, the checks in iova_magazine_full(),
> iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 47d1983dfa2a..580fdf669922 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	unsigned long flags;
>   	int i;
>   
> -	if (!mag)
> -		return;
> -
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   
>   	for (i = 0 ; i < mag->size; ++i) {
> @@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   
>   static bool iova_magazine_full(struct iova_magazine *mag)
>   {
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> +	return mag->size == IOVA_MAG_SIZE;
>   }
>   
>   static bool iova_magazine_empty(struct iova_magazine *mag)
>   {
> -	return (!mag || mag->size == 0);
> +	return mag->size == 0;
>   }
>   
>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,
