Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C30513E43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352703AbiD1WDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiD1WDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:03:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F55838E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IciYgquXjhamNOQc3eIvez8Va8tbfMDIVBWGekd6Xp0=; b=Z2EY+5KSLqMNORd5yS/wuRQSzN
        JsSfjNkLvEA2hckP6IHsc8Q8spRvQkrej7xbwvXzWlKklR7+QUMV4ykgWlSISe8u7Vp3a3dCgbCBR
        qEeJ4bMWQsHOx8jUdqPxpRFj+dSkZaKKR2V38LCVS2u/xpQ4R4094hG8sjX7xDgqMT79eOWL1J9Wa
        eUkoaJOHflClk+uL0AXwkzECYv2At0cM2bgcCmw5Ze1n6PoUxoJiEgcL2OKp+eOamfdZKNh5ND7Rt
        /oJG+Qdq8bCUxIy/kwO3jG2pOuVW93EvgOlRqIoqVN+N3EHTsGx04niTC04tN1wAn2g9b0+/VahMT
        V+553cEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkCAv-00Bsk5-Uq; Thu, 28 Apr 2022 21:59:50 +0000
Date:   Thu, 28 Apr 2022 22:59:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kbusch@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm/dmapool: replace linked list with xarray
Message-ID: <YmsOVVfcycVdbzUs@casper.infradead.org>
References: <20220428202714.17630-1-kbusch@kernel.org>
 <20220428202714.17630-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428202714.17630-2-kbusch@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:27:13PM -0600, kbusch@kernel.org wrote:
> Store the cached dma pool pages in an xarray instead of a linked list.
> This allows constant lookup time to free the page, lockless iteration
> while displaying the attributes, and frees up space in 'struct dma_page'.

Hey Keith, this looks great, especially since there's more performance
you can squeeze out of it.

>  struct dma_pool {		/* the pool */
> -	struct list_head page_list;
> +	struct xarray pages;
>  	spinlock_t lock;

A further optimisation you could make is to use the xa_lock to protect
the rest of the data structure.  But that would be a subsequent patch.

> @@ -282,7 +281,8 @@ void dma_pool_destroy(struct dma_pool *pool)
>  		device_remove_file(pool->dev, &dev_attr_pools);
>  	mutex_unlock(&pools_reg_lock);
>  
> -	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
> +	xa_for_each(&pool->pages, i, page) {
> +		xa_erase(&pool->pages, i);
>  		if (is_page_busy(page)) {
>  			if (pool->dev)
>  				dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> @@ -291,12 +291,12 @@ void dma_pool_destroy(struct dma_pool *pool)
>  				pr_err("%s %s, %p busy\n", __func__,
>  				       pool->name, page->vaddr);
>  			/* leak the still-in-use consistent memory */
> -			list_del(&page->page_list);
>  			kfree(page);
>  		} else
>  			pool_free_page(pool, page);
>  	}
>  
> +	xa_destroy(&pool->pages);

If you're erasing the entries as you go, you don't need to call
xa_destroy().  Contrariwise, if you call xa_destroy(), you don't need to
call xa_erase().  I'd probably just call xa_destroy() at the end as it's
less work.

> @@ -316,13 +316,14 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>  {
>  	unsigned long flags;
>  	struct dma_page *page;
> +	unsigned long i;
>  	size_t offset;
>  	void *retval;
>  
>  	might_alloc(mem_flags);
>  
>  	spin_lock_irqsave(&pool->lock, flags);
> -	list_for_each_entry(page, &pool->page_list, page_list) {
> +	xa_for_each(&pool->pages, i, page) {
>  		if (page->offset < pool->allocation)
>  			goto ready;
>  	}

A further optimisation you could do is use xarray search marks to
search for only pages which have free entries.

> +	xa_store(&pool->pages, page->vaddr, page, mem_flags);

Oof.  The XArray isn't good at such sparse allocations.  You can improve
it (by a significant amount) by shifting the vaddr by PAGE_SHIFT bits.
Should save you two nodes of tree height and thus two cache lines per
lookup.
