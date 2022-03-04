Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572A44CDC91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiCDSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbiCDSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:34:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4A15AF39
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:33:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAD6B21136;
        Fri,  4 Mar 2022 18:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646418790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJnCxkBq7SDkx56n/I8CCu4Rod5CPYjuSp+zNXS2bSA=;
        b=t3fzROUoQfIORgMlNQfrmE24E4i5w4V9gbKbCg0gPcmdp3VuViPQc4JNMG+bVKLDiTBB7n
        9XoCWe+WZcoAhWSfiaLr9mUJNiDILJMTiuGI70n3vGmP8/9WRQgc22s2eiaby99v+9Q8pB
        lNEKjwVp7zaK8Ni8JfC7mm4qrnuEPMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646418790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJnCxkBq7SDkx56n/I8CCu4Rod5CPYjuSp+zNXS2bSA=;
        b=xarTsfu/8RTPI5FgQc2k8FfN4wFIS5J8JYlLKVqYVeXyhHwx2vz5Zdu77qvw2XIv1lLYZU
        Fvbpw/mxnngYHoDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C7C313B70;
        Fri,  4 Mar 2022 18:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RPkmHWZbImLdBAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 18:33:10 +0000
Message-ID: <e0e983ae-fce7-f814-131e-ac5386550bc3@suse.cz>
Date:   Fri, 4 Mar 2022 19:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 4/5] mm/slub: limit number of node partial slabs only
 in cache creation
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-5-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220304063427.372145-5-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 07:34, Hyeonggon Yoo wrote:
> SLUB sets number of minimum partial slabs for node (min_partial)
> using set_min_partial(). SLUB holds at least min_partial slabs even if
> they're empty to avoid excessive use of page allocator.
> 
> set_min_partial() limits value of min_partial limits value of
> min_partial MIN_PARTIAL and MAX_PARTIAL. As set_min_partial() can be
> called by min_partial_store() too, Only limit value of min_partial
> in kmem_cache_open() so that it can be changed to value that a user wants.
> 
> [ rientjes@google.com: Fold set_min_partial() into its callers ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6f0ebadd8f30..f9ae983a3dc6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3981,15 +3981,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>  	return 1;
>  }
>  
> -static void set_min_partial(struct kmem_cache *s, unsigned long min)
> -{
> -	if (min < MIN_PARTIAL)
> -		min = MIN_PARTIAL;
> -	else if (min > MAX_PARTIAL)
> -		min = MAX_PARTIAL;
> -	s->min_partial = min;
> -}
> -
>  static void set_cpu_partial(struct kmem_cache *s)
>  {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> @@ -4196,7 +4187,8 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	 * The larger the object size is, the more slabs we want on the partial
>  	 * list to avoid pounding the page allocator excessively.
>  	 */
> -	set_min_partial(s, ilog2(s->size) / 2);
> +	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
> +	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
>  
>  	set_cpu_partial(s);
>  
> @@ -5361,7 +5353,7 @@ static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
>  	if (err)
>  		return err;
>  
> -	set_min_partial(s, min);
> +	s->min_partial = min;
>  	return length;
>  }
>  SLAB_ATTR(min_partial);

