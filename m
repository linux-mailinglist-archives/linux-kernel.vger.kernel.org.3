Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148AE539638
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiEaSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347012AbiEaSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:23:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808059CCAF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:23:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3012523A;
        Tue, 31 May 2022 11:23:56 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3183F766;
        Tue, 31 May 2022 11:23:54 -0700 (PDT)
Message-ID: <8a86ff8b-ea16-4004-82e4-d20e46501c75@arm.com>
Date:   Tue, 31 May 2022 19:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/10] dmapool: remove checks for dev == NULL
Content-Language: en-GB
To:     Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <7f6f9ff5-cdb9-e386-988d-fa013538dee7@cybernetics.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7f6f9ff5-cdb9-e386-988d-fa013538dee7@cybernetics.com>
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

On 2022-05-31 19:12, Tony Battersby wrote:
> dmapool originally tried to support pools without a device because
> dma_alloc_coherent() supports allocations without a device.  But nobody
> ended up using dma pools without a device, so the current checks in
> dmapool.c for pool->dev == NULL are both insufficient and causing bloat.
> Remove them.

Furthermore, dma_pool_create() already dereferences the dev argument 
unconditionally, so there's no way we could possibly get as far as these 
checks even if a caller did ever pass NULL.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   mm/dmapool.c | 42 +++++++++++-------------------------------
>   1 file changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index a7eb5d0eb2da..0f89de408cbe 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -275,7 +275,7 @@ void dma_pool_destroy(struct dma_pool *pool)
>   	mutex_lock(&pools_reg_lock);
>   	mutex_lock(&pools_lock);
>   	list_del(&pool->pools);
> -	if (pool->dev && list_empty(&pool->dev->dma_pools))
> +	if (list_empty(&pool->dev->dma_pools))
>   		empty = true;
>   	mutex_unlock(&pools_lock);
>   	if (empty)
> @@ -284,12 +284,8 @@ void dma_pool_destroy(struct dma_pool *pool)
>   
>   	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
>   		if (is_page_busy(page)) {
> -			if (pool->dev)
> -				dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> -					pool->name, page->vaddr);
> -			else
> -				pr_err("%s %s, %p busy\n", __func__,
> -				       pool->name, page->vaddr);
> +			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> +				pool->name, page->vaddr);
>   			/* leak the still-in-use consistent memory */
>   			list_del(&page->page_list);
>   			kfree(page);
> @@ -351,12 +347,8 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>   		for (i = sizeof(page->offset); i < pool->size; i++) {
>   			if (data[i] == POOL_POISON_FREED)
>   				continue;
> -			if (pool->dev)
> -				dev_err(pool->dev, "%s %s, %p (corrupted)\n",
> -					__func__, pool->name, retval);
> -			else
> -				pr_err("%s %s, %p (corrupted)\n",
> -					__func__, pool->name, retval);
> +			dev_err(pool->dev, "%s %s, %p (corrupted)\n",
> +				__func__, pool->name, retval);
>   
>   			/*
>   			 * Dump the first 4 bytes even if they are not
> @@ -411,12 +403,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   	page = pool_find_page(pool, dma);
>   	if (!page) {
>   		spin_unlock_irqrestore(&pool->lock, flags);
> -		if (pool->dev)
> -			dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
> -				__func__, pool->name, vaddr, &dma);
> -		else
> -			pr_err("%s %s, %p/%pad (bad dma)\n",
> -			       __func__, pool->name, vaddr, &dma);
> +		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
> +			__func__, pool->name, vaddr, &dma);
>   		return;
>   	}
>   
> @@ -426,12 +414,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   #ifdef	DMAPOOL_DEBUG
>   	if ((dma - page->dma) != offset) {
>   		spin_unlock_irqrestore(&pool->lock, flags);
> -		if (pool->dev)
> -			dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
> -				__func__, pool->name, vaddr, &dma);
> -		else
> -			pr_err("%s %s, %p (bad vaddr)/%pad\n",
> -			       __func__, pool->name, vaddr, &dma);
> +		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
> +			__func__, pool->name, vaddr, &dma);
>   		return;
>   	}
>   	{
> @@ -442,12 +426,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   				continue;
>   			}
>   			spin_unlock_irqrestore(&pool->lock, flags);
> -			if (pool->dev)
> -				dev_err(pool->dev, "%s %s, dma %pad already free\n",
> -					__func__, pool->name, &dma);
> -			else
> -				pr_err("%s %s, dma %pad already free\n",
> -				       __func__, pool->name, &dma);
> +			dev_err(pool->dev, "%s %s, dma %pad already free\n",
> +				__func__, pool->name, &dma);
>   			return;
>   		}
>   	}
