Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948E5842FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiG1PXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiG1PXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:23:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D446113B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:23:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1172220E15;
        Thu, 28 Jul 2022 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659021810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBpbJCh/BB1+g0Qo38EpopiGfLAbdzkmDaIRkS3xMi4=;
        b=Mhy7DNYCHp0JeYv1QXVIwdw/DH4KsvDQoMf0Tp4G9XteI6wFPLmDX7sw4COArlbUcWI+He
        452iK//hFJQNR+a2OVAjt1jAI9cG9l2ztNWgTDLuiQGejrn1+6BATnYGzjtOBdedXrcX58
        Gh6t/wOxuvVD12glMwgh5HbTrw8IWK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659021810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBpbJCh/BB1+g0Qo38EpopiGfLAbdzkmDaIRkS3xMi4=;
        b=/zgVuQpFQuEfbYwq3HwMqstlHm9HXOvZCIWZcoWCeZQMCdDyrjR8zzQTosFhDiuclrxQhB
        2gRDvIzSqhIDtuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1B3913427;
        Thu, 28 Jul 2022 15:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4nVLMvGp4mKZdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 28 Jul 2022 15:23:29 +0000
Message-ID: <2e252179-0ffe-0d9c-9340-77e46f6ffdfd@suse.cz>
Date:   Thu, 28 Jul 2022 17:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/15] mm/slab_common: fold kmalloc_order_trace() into
 kmalloc_large()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-7-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-7-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 15:39, Hyeonggon Yoo wrote:
> There is no caller of kmalloc_order_trace() except kmalloc_large().
> Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().
> 
> Also add tracepoint in kmalloc_large() that was previously
> in kmalloc_order_trace().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Hmm noticed a small change in how we call trace_kmalloc() which will now
include the __GFP_COMP. I think we could just call alloc_pages() from
kmalloc_large() with flags | __GFP_COMP instead of doing flags |=
__GFP_COMP; first. AFAICS both kasan_kmalloc_large() and kmemleak_alloc()
will filter it out anyway.

> ---
>  include/linux/slab.h | 22 ++--------------------
>  mm/slab_common.c     | 14 +++-----------
>  2 files changed, 5 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index a0e57df3d5a4..15a4c59da59e 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -489,26 +489,8 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
>  }
>  #endif /* CONFIG_TRACING */
>  
> -extern void *kmalloc_order(size_t size, gfp_t flags, unsigned int order) __assume_page_alignment
> -									 __alloc_size(1);
> -
> -#ifdef CONFIG_TRACING
> -extern void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> -				__assume_page_alignment __alloc_size(1);
> -#else
> -static __always_inline __alloc_size(1) void *kmalloc_order_trace(size_t size, gfp_t flags,
> -								 unsigned int order)
> -{
> -	return kmalloc_order(size, flags, order);
> -}
> -#endif
> -
> -static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t flags)
> -{
> -	unsigned int order = get_order(size);
> -	return kmalloc_order_trace(size, flags, order);
> -}
> -
> +void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
> +					      __alloc_size(1);
>  /**
>   * kmalloc - allocate memory
>   * @size: how many bytes of memory are required.
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6c9aac5d8f4a..1f8af2106df0 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -932,10 +932,11 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
>   * directly to the page allocator. We use __GFP_COMP, because we will need to
>   * know the allocation order to free the pages properly in kfree.
>   */
> -void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> +void *kmalloc_large(size_t size, gfp_t flags)
>  {
>  	void *ret = NULL;
>  	struct page *page;
> +	unsigned int order = get_order(size);
>  
>  	if (unlikely(flags & GFP_SLAB_BUG_MASK))
>  		flags = kmalloc_fix_flags(flags);
> @@ -950,19 +951,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
>  	ret = kasan_kmalloc_large(ret, size, flags);
>  	/* As ret might get tagged, call kmemleak hook after KASAN. */
>  	kmemleak_alloc(ret, size, 1, flags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_order);
> -
> -#ifdef CONFIG_TRACING
> -void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> -{
> -	void *ret = kmalloc_order(size, flags, order);
>  	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
>  	return ret;
>  }
> -EXPORT_SYMBOL(kmalloc_order_trace);
> -#endif
> +EXPORT_SYMBOL(kmalloc_large);
>  
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  /* Randomize a generic freelist */

