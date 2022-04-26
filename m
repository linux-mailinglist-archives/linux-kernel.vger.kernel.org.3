Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C9510515
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353599AbiDZRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353458AbiDZRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69526E8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:15:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD090210EA;
        Tue, 26 Apr 2022 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650993306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvV2nJBzNibHRnWgDFAzy5khPlxaeLLn78Tf6Vn7WqQ=;
        b=ssga9CwJbOWK1c4zQuqN7zMjsjrJvUiAf4lSZv8141vNqAz90Qjw7dA9+A2nDDREXMIRE9
        AOT9tfFzRYlvmgiSHhZe6hzSBCvGTq2L6nZUi85XYXb/zko4VJWac1w2vRaEfvmB2UHYJi
        X24l560Rqy63nd+qvycSDJdbMmLf5CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650993306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvV2nJBzNibHRnWgDFAzy5khPlxaeLLn78Tf6Vn7WqQ=;
        b=qcui5A9TMEGwqvNzmE38B/X/KwhTA7UQOoUXO4fZsVpXyoZY+WzFaXBBJecilbkoitQMaA
        7Oe+6lmuxppQXtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EBAD13AD5;
        Tue, 26 Apr 2022 17:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vk26IZooaGIGFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 17:15:06 +0000
Message-ID: <37811df5-b0f5-355b-41cf-2e491fb3cd6c@suse.cz>
Date:   Tue, 26 Apr 2022 19:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
 <20220414085727.643099-9-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 08/23] mm/slab_common: make kmalloc_large_node()
 consistent with kmalloc_large()
In-Reply-To: <20220414085727.643099-9-42.hyeyoo@gmail.com>
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
> Move tracepoints into kmalloc_large_node() and add missing flag fix code.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Hm so there's a problem with the tracepoint's caller.

kmalloc_large() is only called from kmalloc() which is an inline  thus the
callsite of kmalloc() calls directly kmalloc_large(). So when
kmalloc_large() does "trace_kmalloc(_RET_IP_, ...)" the _RET_IP_ is the
callsite of kmalloc(), which is what we want.

But with kmalloc_large_node()...

> ---
>  mm/slab_common.c |  6 ++++++
>  mm/slub.c        | 22 ++++------------------
>  2 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e72089515030..cf17be8cd9ad 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -955,6 +955,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  	void *ptr = NULL;
>  	unsigned int order = get_order(size);
>  
> +	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> +		flags = kmalloc_fix_flags(flags);
> +
>  	flags |= __GFP_COMP;
>  	page = alloc_pages_node(node, flags, order);
>  	if (page) {
> @@ -966,6 +969,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  	ptr = kasan_kmalloc_large(ptr, size, flags);
>  	/* As ptr might get tagged, call kmemleak hook after KASAN. */
>  	kmemleak_alloc(ptr, size, 1, flags);
> +	trace_kmalloc_node(_RET_IP_, ptr,
> +			   size, PAGE_SIZE << order,
> +			   flags, node);

... the _RET_IP_ here would be __kmalloc_node() which is not useful.

>  	return ptr;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 640712706f2b..f10a892f1772 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4396,15 +4396,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  	struct kmem_cache *s;
>  	void *ret;
>  
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node(size, flags, node);
> -
> -		trace_kmalloc_node(_RET_IP_, ret,
> -				   size, PAGE_SIZE << get_order(size),
> -				   flags, node);

Here it was OK because __kmalloc_node is expanded from something inline
coming from slab.h.

> -
> -		return ret;
> -	}
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return kmalloc_large_node(size, flags, node);
>  
>  	s = kmalloc_slab(size, flags);
>  
> @@ -4861,15 +4854,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
>  	struct kmem_cache *s;
>  	void *ret;
>  
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node(size, gfpflags, node);
> -
> -		trace_kmalloc_node(caller, ret,
> -				   size, PAGE_SIZE << get_order(size),
> -				   gfpflags, node);
> -
> -		return ret;
> -	}
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return kmalloc_large_node(size, gfpflags, node);

And here it even forgets the 'caller'.

>  
>  	s = kmalloc_slab(size, gfpflags);
>  

