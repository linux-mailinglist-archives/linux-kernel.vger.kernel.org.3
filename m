Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8565843E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiG1QNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiG1QNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:13:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB26F7E3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:13:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D697B1FBAD;
        Thu, 28 Jul 2022 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659024789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFNLMsmaiX/KJpwTe1Kl7r0olPyBVX9u4w3byywnZaQ=;
        b=usHCPZMY4s4WbBkvRuD2vTWO1umj/trRQm5sTbc39MjAG/uLxnnEVAKF9Bim0Z73MR6wjZ
        /UEfFFonAjwfqvAYBi5JNx47btffkBIfJWtAU1He1/hO3WuKve4QYe30NouUak4TfIBPwB
        F3rxOAieDIrRLeVYZHDGtD3oLR6PpNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659024789;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFNLMsmaiX/KJpwTe1Kl7r0olPyBVX9u4w3byywnZaQ=;
        b=BamlEN9VBPnmc6zaO2Wyiok82LF254+J3XaWxFoJcCvvsGOldWETK2stJ6hX9DHKrZ6GK/
        +7UKQ4UJEU1JeLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA7E913427;
        Thu, 28 Jul 2022 16:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Ai7KJW14mKZDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 28 Jul 2022 16:13:09 +0000
Message-ID: <33ae1986-6f92-aa15-1be5-c7ae79320a34@suse.cz>
Date:   Thu, 28 Jul 2022 18:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 09/15] mm/slab_common: cleanup kmalloc_large()
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
 <20220712133946.307181-10-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-10-42.hyeyoo@gmail.com>
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
> Now that kmalloc_large() and kmalloc_large_node() do mostly same job,
> make kmalloc_large() wrapper of __kmalloc_large_node_notrace().
> 
> In the meantime, add missing flag fix code in
> __kmalloc_large_node_notrace().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab_common.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index dc872e0ef0fc..9c46e2f9589f 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -932,29 +932,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
>   * directly to the page allocator. We use __GFP_COMP, because we will need to
>   * know the allocation order to free the pages properly in kfree.
>   */
> -void *kmalloc_large(size_t size, gfp_t flags)
> -{
> -	void *ret = NULL;
> -	struct page *page;
> -	unsigned int order = get_order(size);
> -
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> -		flags = kmalloc_fix_flags(flags);
> -
> -	flags |= __GFP_COMP;
> -	page = alloc_pages(flags, order);
> -	if (likely(page)) {
> -		ret = page_address(page);
> -		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> -				      PAGE_SIZE << order);
> -	}
> -	ret = kasan_kmalloc_large(ret, size, flags);
> -	/* As ret might get tagged, call kmemleak hook after KASAN. */
> -	kmemleak_alloc(ret, size, 1, flags);
> -	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmalloc_large);
>  
>  static __always_inline
>  void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
> @@ -963,6 +940,9 @@ void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
>  	void *ptr = NULL;
>  	unsigned int order = get_order(size);
>  
> +	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> +		flags = kmalloc_fix_flags(flags);
> +
>  	flags |= __GFP_COMP;
>  	page = alloc_pages_node(node, flags, order);
>  	if (page) {
> @@ -978,6 +958,16 @@ void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
>  	return ptr;
>  }
>  
> +void *kmalloc_large(size_t size, gfp_t flags)
> +{
> +	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
> +
> +	trace_kmalloc(_RET_IP_, ret, NULL, size,
> +		      PAGE_SIZE << get_order(size), flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmalloc_large);
> +
>  void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
>  {
>  	return __kmalloc_large_node_notrace(size, flags, node);

