Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69B539756
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbiEaTse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiEaTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:48:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78945DF93
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:48:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4283523A;
        Tue, 31 May 2022 12:48:30 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B791E3F766;
        Tue, 31 May 2022 12:48:28 -0700 (PDT)
Message-ID: <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
Date:   Tue, 31 May 2022 20:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/10] dmapool: improve accuracy of debug statistics
Content-Language: en-GB
To:     Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 19:17, Tony Battersby wrote:
> The "total number of blocks in pool" debug statistic currently does not
> take the boundary value into account, so it diverges from the "total
> number of blocks in use" statistic when a boundary is in effect.  Add a
> calculation for the number of blocks per allocation that takes the
> boundary into account, and use it to replace the inaccurate calculation.
> 
> This depends on the patch "dmapool: fix boundary comparison" for the
> calculated blks_per_alloc value to be correct.
> 
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   mm/dmapool.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 782143144a32..9e30f4425dea 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -47,6 +47,7 @@ struct dma_pool {		/* the pool */
>   	struct device *dev;
>   	unsigned int allocation;
>   	unsigned int boundary;
> +	unsigned int blks_per_alloc;
>   	char name[32];
>   	struct list_head pools;
>   };
> @@ -92,8 +93,7 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
>   		/* per-pool info, no real statistics yet */
>   		temp = scnprintf(next, size, "%-16s %4zu %4zu %4u %2u\n",

Nit: if we're tinkering with this, it's probably worth updating the 
whole function to use sysfs_emit{_at}().

>   				 pool->name, blocks,
> -				 (size_t) pages *
> -				 (pool->allocation / pool->size),
> +				 (size_t) pages * pool->blks_per_alloc,
>   				 pool->size, pages);
>   		size -= temp;
>   		next += temp;
> @@ -168,6 +168,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>   	retval->size = size;
>   	retval->boundary = boundary;
>   	retval->allocation = allocation;
> +	retval->blks_per_alloc =
> +		(allocation / boundary) * (boundary / size) +
> +		(allocation % boundary) / size;

Do we really need to store this? Sure, 4 divisions (which could possibly 
be fewer given the constraints on boundary) isn't the absolute cheapest 
calculation, but I still can't imagine anyone would be polling sysfs 
stats hard enough to even notice.

Thanks,
Robin.

>   
>   	INIT_LIST_HEAD(&retval->pools);
>   
