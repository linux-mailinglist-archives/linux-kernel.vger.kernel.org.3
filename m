Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B305514E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377913AbiD2OwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377935AbiD2OwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:52:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D265B53D4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:48:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21F7D1F892;
        Fri, 29 Apr 2022 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651243737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJ3f1N/Kx7PKn1skloQ8FgV1j1hvN5zrUlINdB+GFGY=;
        b=aF3w5ZLmNsQpLlGrT1jnB+RTlwq+CK4IZ5uHkoiR6aExnWt5e1zWS/RlTlkAiomeWiP2l7
        hZX4mptcPLoQ4V9U/wgVyAPZOCXGBSxCT70u3N1zWFHO78yBw7ZV06q5tloucl+kiBgCE5
        LG8uJA4VYbOcLEyglqW8ncpMnHYXP3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651243737;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJ3f1N/Kx7PKn1skloQ8FgV1j1hvN5zrUlINdB+GFGY=;
        b=DUZWIGaW/OKRFr3H2RQDlZ6yyzmyKmNo3vsB98UVp0BkKq9v98rBlVaqM9C3/cLHb9hGYU
        CfZRYRrFzpQ7HVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCCA213AE0;
        Fri, 29 Apr 2022 14:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e8qPMNj6a2LHHgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Apr 2022 14:48:56 +0000
Message-ID: <76fe118f-0092-83de-7881-0bface4fc283@suse.cz>
Date:   Fri, 29 Apr 2022 16:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 20/23] mm/slab_common: factor out __do_kmalloc_node()
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
 <20220414085727.643099-21-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-21-42.hyeyoo@gmail.com>
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
> Factor out common code into __do_kmalloc_node().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Looks good but let's see how things look like after changes to previous patches.

> ---
>  mm/slab_common.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6abe7f61c197..af563e64e8aa 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -919,7 +919,9 @@ void free_large_kmalloc(struct folio *folio, void *object)
>  	__free_pages(folio_page(folio, 0), order);
>  }
>  
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +static __always_inline
> +void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
> +			unsigned long caller __maybe_unused)
>  {
>  	struct kmem_cache *s;
>  	void *ret;
> @@ -932,31 +934,22 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  	if (unlikely(ZERO_OR_NULL_PTR(s)))
>  		return s;
>  
> -	ret = __kmem_cache_alloc_node(s, NULL, flags, node, _RET_IP_);
> +	ret = __kmem_cache_alloc_node(s, NULL, flags, node, caller);
>  	ret = kasan_kmalloc(s, ret, size, flags);
>  
>  	return ret;
>  }
> +
> +void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> +}
>  EXPORT_SYMBOL(__kmalloc_node);
>  
>  void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
>  					int node, unsigned long caller)
>  {
> -	struct kmem_cache *s;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return kmalloc_large_node(size, gfpflags, node);
> -
> -	s = kmalloc_slab(size, gfpflags);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(s)))
> -		return s;
> -
> -	ret = __kmem_cache_alloc_node(s, NULL, gfpflags, node, caller);
> -	ret = kasan_kmalloc(s, ret, size, gfpflags);
> -
> -	return ret;
> +	return __do_kmalloc_node(size, flags, node, caller);
>  }
>  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  

