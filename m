Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16A510297
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiDZQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiDZQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:12:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3910173048
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:09:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1AE2210E8;
        Tue, 26 Apr 2022 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650989359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlBpaGo31htw44cELqk1nP5QrpL931cVvjwPWxcqiIw=;
        b=G0brHfDRp6/jozN4ch+TnhvQI1d60GJSxBhIqRPxgOLC1L9J+jWsBXcVNqcCmk8L9G4Rjn
        UzgQKBOfnnXPsNHq3zLgQvNa6QzhArgHNzQmrB7sx7V3lOvNMdejbgEfmaqc2NUphgOAQH
        Ddl0+68F3V6Kh3Vj2V0YCBWa1MQ006Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650989359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlBpaGo31htw44cELqk1nP5QrpL931cVvjwPWxcqiIw=;
        b=FUGUeiFnNOxUf8Nz3Wc9EqAAULhQFZ7VGNudwHF/sq6n5RKR5hdMdonCQz9zksWktJS74u
        g9UUiE6li98EhPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 772D413223;
        Tue, 26 Apr 2022 16:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pyZ9HC8ZaGLeeAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 16:09:19 +0000
Message-ID: <4c85b7b4-e2b3-79b0-f5c1-ae318b856750@suse.cz>
Date:   Tue, 26 Apr 2022 18:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 06/23] mm/sl[auo]b: fold kmalloc_order_trace() into
 kmalloc_large()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-7-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-7-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> There is no caller of kmalloc_order_trace() except kmalloc_large().
> Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().
> 
> Also add tracepoint in kmalloc_large() that was previously
> in kmalloc_order_trace().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Changes from v1:
> - updated some changelog (kmalloc_order() -> kmalloc_order_trace())
> 
>  include/linux/slab.h | 22 ++--------------------
>  mm/slab_common.c     | 14 +++-----------
>  2 files changed, 5 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4c06d15f731c..6f6e22959b39 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -484,26 +484,8 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
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
> +extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
> +						     __alloc_size(1);

I missed this extern in v1, please drop.

>  /**
>   * kmalloc - allocate memory
>   * @size: how many bytes of memory are required.
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c4d63f2c78b8..308cd5449285 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -925,10 +925,11 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
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
> @@ -943,19 +944,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
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
>  	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
>  	return ret;
>  }
> -EXPORT_SYMBOL(kmalloc_order_trace);
> -#endif
> +EXPORT_SYMBOL(kmalloc_large);
>  
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  /* Randomize a generic freelist */

