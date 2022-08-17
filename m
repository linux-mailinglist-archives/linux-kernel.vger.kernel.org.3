Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F8596E86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiHQMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHQMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:32:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A6E80E9C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:32:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C073D113E;
        Wed, 17 Aug 2022 05:32:50 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A17703F67D;
        Wed, 17 Aug 2022 05:32:48 -0700 (PDT)
Message-ID: <777145ed-7936-6d8a-d706-57e609f4deb6@arm.com>
Date:   Wed, 17 Aug 2022 13:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dma-pool: factor out a calculate_pool_size helper
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-2-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220817060647.1032426-2-hch@lst.de>
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

On 2022-08-17 07:06, Christoph Hellwig wrote:
> Add a helper to calculate the pool size from dma_atomic_pool_init,
> and fix up the last max_t to use the proper type.

Hmm, both atomic_pool_size and the argument to __dma_atomic_pool_init() 
where this gets directly passed later are size_t, not to mention that 
the function name says we're calculating a size, so I'd say size_t *is* 
the proper type to return here.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/pool.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 4d40dcce7604b..56f96678934bf 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -184,6 +184,15 @@ static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
>   	return pool;
>   }
>   
> +static unsigned long calculate_pool_size(unsigned long zone_pages)
> +{
> +	unsigned long nr_pages = min_t(unsigned long,
> +				       zone_pages / (SZ_1G / SZ_128K),
> +				       MAX_ORDER_NR_PAGES);

Nit: this is arguably less readable, and objectively one line longer, 
than the original two statements.

Other that those nits though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
> +	return max_t(unsigned long, nr_pages << PAGE_SHIFT, SZ_128K);
> +}
> +
>   static int __init dma_atomic_pool_init(void)
>   {
>   	int ret = 0;
> @@ -192,11 +201,9 @@ static int __init dma_atomic_pool_init(void)
>   	 * If coherent_pool was not used on the command line, default the pool
>   	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>   	 */
> -	if (!atomic_pool_size) {
> -		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
> -		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
> -		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
> -	}
> +	if (!atomic_pool_size)
> +		atomic_pool_size = calculate_pool_size(totalram_pages());
> +
>   	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
>   
>   	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
