Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5152A0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiEQLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiEQLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:53:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B62F390
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:53:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 204so16675371pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CVgegZfYyke/xy3ajF4ERWjyVdzQLTtIY0n6Ao3JXc0=;
        b=lSW/P0b3k3p66ylal3rfH5748HQl8RXVC8gtA/IkQnIK0pD63m7chLp/uej+sYTVVg
         u/GJSgWgb8vKD9tu2FxJXllCuER2L42QXKQiKHQNbdFISzaNLuXR0ErQA/uG1ctd1NXa
         zTjaDPGsBmQXG1NT5mmBr1+ZG7/olsnwp5phb44w9nSxoDBETBVXsGLE+XNv9PQn1R9x
         iKPjpXgs3AS1Ls8QfEOxa3AXRVYHLdb+f22Uylmi3lVTzOKgx3Q1JdJcAGE90Jo3LF9Y
         rebP7uwhdg8sXlK0hLUBMFq9AKjKU2wmka6ILGSy0vLvrRxrSu/FE96UylEC8x/2MNXW
         7mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CVgegZfYyke/xy3ajF4ERWjyVdzQLTtIY0n6Ao3JXc0=;
        b=79qnegYokQTQDH4DjkctWQlrZNBTBjvuwV6FcXlvpxFIMpQaMd6OnphAuSJZe/ej5k
         A5tbH+iOJmfD+VYqN3sRhZKnJSAz5poSIhWrtyzkJHlv4K9YgoQT4sXisqXisZhz/dZm
         fw52sBp0C2vVPwnMMzAB8lP7h2sJRzcJJuLRbZXfCh6b4FCPUQH7ECJGlDDpguT5z6gq
         IwxiRGmT1WSzE7C8eR2x+tr/H3kKU2SdnPdWkQsspsnvpJ3LAFxBu/FIBvV0bs5bbQPL
         lZtqAYKM8yB+QS94cGvC7g0uZeHp2SsCL3/emO5QLkG0zn6fKpNzG6LL0iWBfd0iwZwY
         E7Ng==
X-Gm-Message-State: AOAM532Dj76++DesQ5g6P4xtfrUtbFgjBiFmgkX7VTxzpX84ahYMcjuM
        vdcSx1hmXpqbZqbiudyXubU=
X-Google-Smtp-Source: ABdhPJxRtoCo+i5tFV+cQxsgNEs1aFQJFfBRf0uqUhicibOKg24YxH4y0Pvt4vfr+oAHE/fmF1XOYA==
X-Received: by 2002:a62:d445:0:b0:50d:b868:47bc with SMTP id u5-20020a62d445000000b0050db86847bcmr21959290pfl.73.1652788390678;
        Tue, 17 May 2022 04:53:10 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027d8300b0015e8d4eb26dsm8829443plm.183.2022.05.17.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 04:53:09 -0700 (PDT)
Date:   Tue, 17 May 2022 20:53:03 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Message-ID: <YoOMn+Cwwgz/hPnh@hyeyoo>
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 09:53:32PM +0300, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
> marked with SLAB_ACCOUNT to the ftrace output.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  mm/slab.c | 3 +++
>  mm/slub.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 0edb474edef1..4c3da8dfcbdb 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3492,6 +3492,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>  
> +	if (cachep->flags & SLAB_ACCOUNT)
> +		flags |= __GFP_ACCOUNT;
> +
>  	trace_kmem_cache_alloc(_RET_IP_, ret,
>  			       cachep->object_size, cachep->size, flags);
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..670bbfef9e49 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3231,6 +3231,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>  
> +	if (s->flags & SLAB_ACCOUNT)
> +		gfpflags |= __GFP_ACCOUNT;
> +
>  	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
>  				s->size, gfpflags);
>  
> -- 
> 2.25.1
> 
> 

To me it sounds like it would confuse memory cgroup because:
	1) For now objects are charged only in slab memcg hooks
	2) This patch makes buddy allocator charge the page too

-- 
Thanks,
Hyeonggon
