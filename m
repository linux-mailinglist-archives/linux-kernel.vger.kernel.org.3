Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC04FB9AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiDKKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345515AbiDKKby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:31:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6792DD5F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:29:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA7861F864;
        Mon, 11 Apr 2022 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649672978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/9VhRHA3bs9D3N2QQLj6PkxXuNIk+sDoWn9CyzhHuI=;
        b=Ex6kVTaw1yBHbtQj6c/P8yf1mPjyw1jMH4/cp150YTqQMi+bvCshbuacrEvE7LEb9am6hC
        ePMnHKWIIaptDkJPXBdbYOSSaTQAgCQRfH5IU2KV52BHtCk0ttY1VE2G8psgaP8YCsKhjm
        QQKlBl+LIKgA4dyOwaMQpKSftCQGWew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649672978;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/9VhRHA3bs9D3N2QQLj6PkxXuNIk+sDoWn9CyzhHuI=;
        b=uSPfeSwGXu3KdtorMecGLntCVetyRQpy2lGl8ai/pdf6AjG1+TwVOpDMJjNEStf9uxjCzc
        xsRoAv/U+XaXV6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACCB513AB5;
        Mon, 11 Apr 2022 10:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J2tAKRIDVGKhYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Apr 2022 10:29:38 +0000
Message-ID: <61d43197-3ff4-d51a-d84f-fa5a41fcaf7d@suse.cz>
Date:   Mon, 11 Apr 2022 12:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/slub: remove unused parameter in setup_object*()
Content-Language: en-US
To:     JaeSang Yoo <js.yoo.5b@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        Christoph Lameter <clameter@sgi.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220411072534.3372768-1-jsyoo5b@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220411072534.3372768-1-jsyoo5b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 09:25, JaeSang Yoo wrote:
> setup_object_debug() and setup_object() has unused parameter, "struct
> slab *slab". Remove it.
> 
> By the commit 3ec0974210fe ("SLUB: Simplify debug code"),
> setup_object_debug() were introduced to refactor previous code blocks
> in the setup_object(). Previous code used SlabDebug() to init_object()
> and init_tracking(). As the SlabDebug() takes "struct page *page" as
> argument, the setup_object_debug() checks flag of "struct kmem_cache *s"
> which doesn't require "struct page *page".
> As the struct page were changed into struct slab by commit bb192ed9aa719
> ("mm/slub: Convert most struct page to struct slab by spatch"), but it's
> still unused parameter.
> 
> Suggested-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>

Thanks, added.

> ---
>  mm/slub.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9fe000fd19ca..273bbba74ca1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1264,8 +1264,7 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
>  }
>  
>  /* Object debug checks for alloc/free paths */
> -static void setup_object_debug(struct kmem_cache *s, struct slab *slab,
> -								void *object)
> +static void setup_object_debug(struct kmem_cache *s, void *object)
>  {
>  	if (!kmem_cache_debug_flags(s, SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON))
>  		return;
> @@ -1631,8 +1630,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  	return flags | slub_debug_local;
>  }
>  #else /* !CONFIG_SLUB_DEBUG */
> -static inline void setup_object_debug(struct kmem_cache *s,
> -			struct slab *slab, void *object) {}
> +static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
>  static inline
>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>  
> @@ -1775,10 +1773,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  	return *head != NULL;
>  }
>  
> -static void *setup_object(struct kmem_cache *s, struct slab *slab,
> -				void *object)
> +static void *setup_object(struct kmem_cache *s, void *object)
>  {
> -	setup_object_debug(s, slab, object);
> +	setup_object_debug(s, object);
>  	object = kasan_init_slab_obj(s, object);
>  	if (unlikely(s->ctor)) {
>  		kasan_unpoison_object_data(s, object);
> @@ -1897,13 +1894,13 @@ static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
>  	/* First entry is used as the base of the freelist */
>  	cur = next_freelist_entry(s, slab, &pos, start, page_limit,
>  				freelist_count);
> -	cur = setup_object(s, slab, cur);
> +	cur = setup_object(s, cur);
>  	slab->freelist = cur;
>  
>  	for (idx = 1; idx < slab->objects; idx++) {
>  		next = next_freelist_entry(s, slab, &pos, start, page_limit,
>  			freelist_count);
> -		next = setup_object(s, slab, next);
> +		next = setup_object(s, next);
>  		set_freepointer(s, cur, next);
>  		cur = next;
>  	}
> @@ -1974,11 +1971,11 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  
>  	if (!shuffle) {
>  		start = fixup_red_left(s, start);
> -		start = setup_object(s, slab, start);
> +		start = setup_object(s, start);
>  		slab->freelist = start;
>  		for (idx = 0, p = start; idx < slab->objects - 1; idx++) {
>  			next = p + s->size;
> -			next = setup_object(s, slab, next);
> +			next = setup_object(s, next);
>  			set_freepointer(s, p, next);
>  			p = next;
>  		}

