Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A688A500C57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiDNLsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiDNLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:48:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2526E3CA49
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:45:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so4443573plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gYonQ4otreGQNUPR7uDxnaoGparDp2Lon5DnR3rgEKk=;
        b=n1Cdexfc2bThmw0GtJu7PmqXDsx3RgixBt3QRyOaCVGE1MJdhqB9S5M0091k5xWqqb
         iIHP8FZTF89O0RsUeHVKXdEamBycgOTy7IbsKWuhfAFpCbUf87brMod+yK0dKU90UKCB
         AMNTiOUPMEwJiLCk7FXQZIWAKmEeUEK0oBrfFnMlYcfP3/TbNiXF/ryr5QXuEVL0Cf/M
         8U3MdLtfyjWw8XIhy3Qsx6Yt77qC+iowxMxBRuE0hKXYWGZNRMfhp8R7cAZM8oZaPDtx
         q5d2+EZXs1SHauEbgdv5Vl+o1Aq0PqL2Jay+tctBhuh56nOLQI4RkeXeJ71RpHByLgXE
         hmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gYonQ4otreGQNUPR7uDxnaoGparDp2Lon5DnR3rgEKk=;
        b=uOWGNjTlt4ldVIU3MiRMic0sgZbW4gR7DY35J16d4hQ3QLCL4QkBfFDHPbyMFppIaF
         y/3HCYfczozZU11my3m72vJ/7oBvpwRySAB4zwr5R/rz73QE5vqeI/+5mfw6TnxEJKX1
         S8CQ/F9cpI3S3PUUWw83JhUI0jin5LXY+MUuaHdJ2qLBYcfKpB3t+oUHAB+GBTgSeP0T
         JU6oqqYAOx1LMQU4LsZGtUI59EhY3omP2FLvqDP1m6Y824cdT9h9Vytz1B/q8V8Jx+j3
         o4rKV5Q2dgxCGCG7U7ZyJK38juBnMr95gXvqhvdc93jLp6kB371xqfFK13OQ9nGG7Sxt
         bkgQ==
X-Gm-Message-State: AOAM533aJXwh9/zqGRpq3msJDf2YS47rE8PUjaTi+sAokI6a93/89yYH
        4U4e2DSXbDyXjXHEKvd8Q6s=
X-Google-Smtp-Source: ABdhPJyU0dDu4aSwgC/9C8cCIEQ49voe2/LETlyodXWMenwGPIW0IzLvI3lme+mSCCvn7J8weVzB9A==
X-Received: by 2002:a17:90b:3ecb:b0:1c7:74f6:ae73 with SMTP id rm11-20020a17090b3ecb00b001c774f6ae73mr3260303pjb.236.1649936756619;
        Thu, 14 Apr 2022 04:45:56 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm1985823pfx.34.2022.04.14.04.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:45:55 -0700 (PDT)
Date:   Thu, 14 Apr 2022 20:45:47 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/23] mm/slab_common: factor out __do_kmalloc_node()
Message-ID: <YlgJay8qV/f+k4X6@hyeyoo>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-21-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414085727.643099-21-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:57:24PM +0900, Hyeonggon Yoo wrote:
> Factor out common code into __do_kmalloc_node().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

Ah, 'flags' is undefined here. (it's gfpflags here)
Seems like I sent a version of this patch before fixing build error.

I'll send updated version when sending v3 :)


>  }
>  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  
> -- 
> 2.32.0
> 

-- 
Thanks,
Hyeonggon
