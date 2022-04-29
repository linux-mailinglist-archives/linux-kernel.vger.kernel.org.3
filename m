Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DACB514D17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377381AbiD2Ofi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377376AbiD2Odx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:33:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D71A5E97
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:30:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A18601F892;
        Fri, 29 Apr 2022 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651242629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbK2VEqmYvpAFl5tGkzJpb/gXsPJVD0IA8jHw9TPBBk=;
        b=zb3JmXdLKXZdz1SwxC3xXgYjGHX9p5y+S0k/iQ0ddBWXXwriLGxqFXaAj/HZDqWBpHvtg7
        lppkHfqFouL41dY0l05RcDB5FyWCPsccPM1yLlT/1clnOgZgP3M8KKi235D4DPup8pegLP
        rdsrc36ZcYAHO2xiNFl6g9InqAgBuro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651242629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbK2VEqmYvpAFl5tGkzJpb/gXsPJVD0IA8jHw9TPBBk=;
        b=wSCik5wU9movZ6tpuQnC+FTt9dt6fvNtbO5+a2+LMTGXrv2DvT6D+6Piy4299sC+GcxeUk
        ug8mqwoAP8H1KsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7887313AE0;
        Fri, 29 Apr 2022 14:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RKVyHIX2a2JIFwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Apr 2022 14:30:29 +0000
Message-ID: <3a12e66d-58cb-d768-7b2e-4eb239c03ee6@suse.cz>
Date:   Fri, 29 Apr 2022 16:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 18/23] mm/sl[au]b: generalize kmalloc subsystem
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
 <20220414085727.643099-19-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-19-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> Now everything in kmalloc subsystem can be generalized.
> Let's do it!
> 
> Generalize __kmalloc_node_track_caller(), kfree(), __ksize(),
> __kmalloc_node() and move them to slab_common.c.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slab.c        | 94 -----------------------------------------------
>  mm/slab_common.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/slub.c        | 88 --------------------------------------------
>  3 files changed, 95 insertions(+), 182 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index d35873da5572..fc00aca62ae3 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3527,36 +3527,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
>  #endif
>  
> -static __always_inline void *
> -__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> -{
> -	struct kmem_cache *cachep;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return kmalloc_large_node(size, flags, node);
> -	cachep = kmalloc_slab(size, flags);
> -	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
> -		return cachep;
> -	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
> -	ret = kasan_kmalloc(cachep, ret, size, flags);

SLAB did kasan_kmalloc() when called from __kmalloc_node_track_caller(), and
will not do after this patch, until the next patch 19/23. So I would just
fold it to this patch.

> -
> -	return ret;
> -}
> -
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc_node);
> -
> -void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> -		int node, unsigned long caller)
> -{
> -	return __do_kmalloc_node(size, flags, node, caller);
> -}
> -EXPORT_SYMBOL(__kmalloc_node_track_caller);
> -
>  #ifdef CONFIG_PRINTK
>  void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  {
