Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A042753970C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiEaTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347298AbiEaTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:33:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E129AE7B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:33:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B3723A;
        Tue, 31 May 2022 12:33:29 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDC683F766;
        Tue, 31 May 2022 12:33:27 -0700 (PDT)
Message-ID: <e5a97b61-6401-8a00-1088-5465a493a556@arm.com>
Date:   Tue, 31 May 2022 20:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
Content-Language: en-GB
To:     Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
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

On 2022-05-31 19:22, Tony Battersby wrote:
> Remove a small amount of code duplication between dma_pool_destroy() and
> pool_free_page() in preparation for adding more code without having to
> duplicate it.  No functional changes.
> 
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   mm/dmapool.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 8749a9d7927e..58c11dcaa4e4 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -250,14 +250,25 @@ static inline bool is_page_busy(struct dma_page *page)
>   	return page->in_use != 0;
>   }
>   
> -static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
> +static void pool_free_page(struct dma_pool *pool,
> +			   struct dma_page *page,
> +			   bool destroying_pool)
>   {
> +	void *vaddr = page->vaddr;
>   	dma_addr_t dma = page->dma;
>   
> +	if (destroying_pool && is_page_busy(page)) {
> +		dev_err(pool->dev,
> +			"dma_pool_destroy %s, %p busy\n",
> +			pool->name, vaddr);
> +		/* leak the still-in-use consistent memory */
> +	} else {
>   #ifdef	DMAPOOL_DEBUG
> -	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
> +		memset(vaddr, POOL_POISON_FREED, pool->allocation);
>   #endif
> -	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
> +		dma_free_coherent(pool->dev, pool->allocation, vaddr, dma);
> +	}
> +
>   	list_del(&page->page_list);

If we're tearing down the whole pool, surely we can skip this as well? 
(Same for the second list in patch #9)

In fact I think it might make more sense to refactor in the opposite 
direction and just streamline this directly into dma_pool_destroy(), 
more like:

	list_for_each_entry_safe() {
		if (is_page_busy()) {
			dev_err();
		} else {
			dma_free_coherent();
		}
		kfree(page);
	}

>   	kfree(page);
>   }
> @@ -272,7 +283,7 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
>    */
>   void dma_pool_destroy(struct dma_pool *pool)
>   {
> -	struct dma_page *page, *tmp;
> +	struct dma_page *page;

Nit: you bring this back again in patch #10, so we may as well leave the 
list_for_each_entry_safe() iterator in place until then as well, and 
save a bit of churn in this patch.

>   	bool empty = false;
>   
>   	if (unlikely(!pool))
> @@ -288,15 +299,10 @@ void dma_pool_destroy(struct dma_pool *pool)
>   		device_remove_file(pool->dev, &dev_attr_pools);
>   	mutex_unlock(&pools_reg_lock);
>   
> -	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
> -		if (is_page_busy(page)) {
> -			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> -				pool->name, page->vaddr);
> -			/* leak the still-in-use consistent memory */
> -			list_del(&page->page_list);
> -			kfree(page);
> -		} else
> -			pool_free_page(pool, page);
> +	while ((page = list_first_entry_or_null(&pool->page_list,
> +						struct dma_page,
> +						page_list))) {
> +		pool_free_page(pool, page, true);
>   	}
>   
>   	kfree(pool);
> @@ -469,7 +475,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   	page->offset = offset;
>   	/*
>   	 * Resist a temptation to do
> -	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
> +	 *    if (!is_page_busy(page)) pool_free_page(pool, page, false);

Further to the above, even if we did retain a separate function, if an 
argument is hard-coded at the one single callsite, and the only 
reference to passing any other value is in a comment effectively saying 
"don't do this", do we really need to pretend it's an argument at all? ;)

FWIW I'd just reword the comment in more general terms, e.g. "Resist the 
temptation to free unused pages immediately..."

Thanks,
Robin.

>   	 * Better have a few empty pages hang around.
>   	 */
>   	spin_unlock_irqrestore(&pool->lock, flags);
