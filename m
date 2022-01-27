Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2149E3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiA0NjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242033AbiA0Ni0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:38:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49007C061793
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t8uKPMm+WT9eNttOsz40v+9fY5TpP+ldKER0j08mQ5k=; b=P7dJz4qf2KlOhCsIxTJaRDVb3q
        AJN3yaOtHXfwE0zKeOD27j5ikUu4zdbrWit27WGyOhYk82giJzMUUFIimKEuLam+jo7nIx5qAGmsf
        9cml1xNfXJ1jw/3w11APXrHyKigNVqD8+o34S9Y0EJNeEsPlxqAp7fW/LZRi8zAm8orDEHouzIL1A
        UXAA7XjgmPld61YnqJ0gJBPPFthLixBB/JxsUr7ingkmMoKCNJqrIG12rbfNhZBCFd4W70lEfPzRJ
        k9SnHKZRs1086kJoxr3eO+s3H4f2OiHQZK0ZuI+SAeyIskETAnGobAm6+F6iobRaF63U06PyMWfht
        WOweGG+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD4xD-005H7t-Ez; Thu, 27 Jan 2022 13:36:47 +0000
Date:   Thu, 27 Jan 2022 13:36:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] tools: Move gfp.h and slab.h from radix-tree to lib
Message-ID: <YfKf74qdUXrPPZHZ@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:19PM +0100, Karolina Drobnik wrote:
> diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
> index 2d9c59df60de..81539f543954 100644
> --- a/tools/testing/radix-tree/linux.c
> +++ b/tools/testing/radix-tree/linux.c
> @@ -14,7 +14,6 @@
>  
>  int nr_allocated;
>  int preempt_count;
> -int kmalloc_verbose;
>  int test_verbose;
>  
>  struct kmem_cache {
> @@ -78,32 +77,6 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
>  	pthread_mutex_unlock(&cachep->lock);
>  }
>  
> -void *kmalloc(size_t size, gfp_t gfp)
> -{
> -	void *ret;
> -
> -	if (!(gfp & __GFP_DIRECT_RECLAIM))
> -		return NULL;
> -
> -	ret = malloc(size);
> -	uatomic_inc(&nr_allocated);
> -	if (kmalloc_verbose)
> -		printf("Allocating %p from malloc\n", ret);
> -	if (gfp & __GFP_ZERO)
> -		memset(ret, 0, size);
> -	return ret;
> -}
> -
> -void kfree(void *p)
> -{
> -	if (!p)
> -		return;
> -	uatomic_dec(&nr_allocated);
> -	if (kmalloc_verbose)
> -		printf("Freeing %p to malloc\n", p);
> -	free(p);
> -}
> -
>  struct kmem_cache *
>  kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  		unsigned int flags, void (*ctor)(void *))

I don't think it makes much sense to move kmalloc() and not to move
the kmem_cache* functions.  They're all provided by slab in the kernel
proper, so while you don't use them, I think keeping all the memory
allocation functions together is preferable.
