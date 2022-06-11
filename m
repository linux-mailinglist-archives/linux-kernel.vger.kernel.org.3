Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512D547720
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiFKSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiFKScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:32:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB02F65A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:32:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so3083919lfo.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y/Q2290+YOhK1bDLGmt6qXPcRk6v5jqFwCfmxJNUbhg=;
        b=dCtVTC9tTJH9oFz02XgCMQ8lPgmycesJKBImsDGNDzlhFS6zWOFAetpLNTPEJauTTb
         CYE385ZktNV6TitUaCVqUc3IGDDAh2rdjhWjpdoJ72tAm4bQzosQWLDQsgD5w26AmBcS
         ejBFyIExUHry+DT3HOcu354JG5VytsXWPOZczJr1hJGmPv3pN27UahMKj5jCH2vo7LpZ
         d8j1D4FnN9ZH2TElMiYEvFzB6hXXIvnP+brnAK4ZdL4g3H7THeabtRi48y5ULOZlf+TO
         P/L+6BUyLos9zYI7RUQJknwTutjTLKz+7axpxhfkunc3g8AZJX8/volSOlrlM3iS+89i
         wWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y/Q2290+YOhK1bDLGmt6qXPcRk6v5jqFwCfmxJNUbhg=;
        b=ygYDFXJcnVfodoK6MaTQoXxBl6HFFFr7P8tT8q1uvudmrhlGo7z/0Cuu5G9YgZYe0F
         n6aJnjEIvYx4CUOZw2+1BUqrf//V2WttewY/SZlINskpvGiWbO4pY4B6lGYm0LiEAxUd
         yU8PKt1DsuLPeOfoLyK5NpecLt1y7Df+MBi9I8EaJgXUvR0yB41giwc5EE/NLoeHNsnI
         vduLrv/u9gU7MmguMp/lkF5xPh63tHg03pF0IgWf+wqAYnSw+hNPsWwKK0fVG9FoVJsM
         wAV5Yd9G6CrihX8O39/jHFV7Azm4WfF/ECtSjD6qetspXZFAdJIE3+Eg7HM0YyqSaS/u
         Wf6w==
X-Gm-Message-State: AOAM53301RpVTQEYPydzQMWrHfx89ncWn/cbaOwN4yyAwFSMAUaAFP63
        xwqK6O8bKGByS7W2cpPb3f/CSXNsvJl5zw==
X-Google-Smtp-Source: ABdhPJymFrwkMTrhHRFUvL5FMxusP4kbC1Ig3W2VPrSrQ9wu9j/SjH2yBNxrM4FrRp0aFpKY0ggVrA==
X-Received: by 2002:a05:6512:39d6:b0:478:fd24:36 with SMTP id k22-20020a05651239d600b00478fd240036mr29951762lfu.504.1654972369804;
        Sat, 11 Jun 2022 11:32:49 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b00478efdea1e4sm344455lfr.64.2022.06.11.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 11:32:49 -0700 (PDT)
Message-ID: <1fc4f91c-8142-44dd-0f1d-a75420bf450d@openvz.org>
Date:   Sat, 11 Jun 2022 21:32:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shakeel Butt <shakeelb@google.com>
References: <20220610180310.1725111-1-roman.gushchin@linux.dev>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220610180310.1725111-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 21:03, Roman Gushchin wrote:
> Currently mem_cgroup_from_obj() is not working properly with objects
> allocated using vmalloc(). It creates problems in some cases, when
> it's called for static objects belonging to  modules or generally
> allocated using vmalloc().
> 
> This patch makes mem_cgroup_from_obj() safe to be called on objects
> allocated using vmalloc().
> 
> It also introduces mem_cgroup_from_slab_obj(), which is a faster
> version to use in places when we know the object is either a slab
> object or a generic slab page (e.g. when adding an object to a lru
> list).
> 
> Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

I've tested this patch together with my patch 
"net: set proper memcg for net_init hooks allocations"
and successfully booted test kernel on arm64 VM without
any memcg-related warnings.
[root@fedora ~]# uname -a
Linux fedora 5.19.0-rc1-next-20220610+ #1 SMP Sat Jun 11 16:06:23 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux

Tested-by: Vasily Averin <vvs@openvz.org>

> ---
>  include/linux/memcontrol.h |  6 ++++
>  mm/list_lru.c              |  2 +-
>  mm/memcontrol.c            | 71 +++++++++++++++++++++++++++-----------
>  3 files changed, 57 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0d7584e2f335..4d31ce55b1c0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1761,6 +1761,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
>  }
>  
>  struct mem_cgroup *mem_cgroup_from_obj(void *p);
> +struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
>  
>  static inline void count_objcg_event(struct obj_cgroup *objcg,
>  				     enum vm_event_item idx)
> @@ -1858,6 +1859,11 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	return NULL;
>  }
>  
> +static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> +{
> +	return NULL;
> +}
> +
>  static inline void count_objcg_event(struct obj_cgroup *objcg,
>  				     enum vm_event_item idx)
>  {
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index ba76428ceece..a05e5bef3b40 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -71,7 +71,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
>  	if (!list_lru_memcg_aware(lru))
>  		goto out;
>  
> -	memcg = mem_cgroup_from_obj(ptr);
> +	memcg = mem_cgroup_from_slab_obj(ptr);
>  	if (!memcg)
>  		goto out;
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4093062c5c9b..8c408d681377 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -783,7 +783,7 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  	struct lruvec *lruvec;
>  
>  	rcu_read_lock();
> -	memcg = mem_cgroup_from_obj(p);
> +	memcg = mem_cgroup_from_slab_obj(p);
>  
>  	/*
>  	 * Untracked pages have no memcg, no lruvec. Update only the
> @@ -2833,27 +2833,9 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
>  	return 0;
>  }
>  
> -/*
> - * Returns a pointer to the memory cgroup to which the kernel object is charged.
> - *
> - * A passed kernel object can be a slab object or a generic kernel page, so
> - * different mechanisms for getting the memory cgroup pointer should be used.
> - * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
> - * can not know for sure how the kernel object is implemented.
> - * mem_cgroup_from_obj() can be safely used in such cases.
> - *
> - * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
> - * cgroup_mutex, etc.
> - */
> -struct mem_cgroup *mem_cgroup_from_obj(void *p)
> +static __always_inline
> +struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
>  {
> -	struct folio *folio;
> -
> -	if (mem_cgroup_disabled())
> -		return NULL;
> -
> -	folio = virt_to_folio(p);
> -
>  	/*
>  	 * Slab objects are accounted individually, not per-page.
>  	 * Memcg membership data for each individual object is saved in
> @@ -2886,6 +2868,53 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	return page_memcg_check(folio_page(folio, 0));
>  }
>  
> +/*
> + * Returns a pointer to the memory cgroup to which the kernel object is charged.
> + *
> + * A passed kernel object can be a slab object, vmalloc object or a generic
> + * kernel page, so different mechanisms for getting the memory cgroup pointer
> + * should be used.
> + *
> + * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
> + * can not know for sure how the kernel object is implemented.
> + * mem_cgroup_from_obj() can be safely used in such cases.
> + *
> + * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
> + * cgroup_mutex, etc.
> + */
> +struct mem_cgroup *mem_cgroup_from_obj(void *p)
> +{
> +	struct folio *folio;
> +
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +
> +	if (unlikely(is_vmalloc_addr(p)))
> +		folio = page_folio(vmalloc_to_page(p));
> +	else
> +		folio = virt_to_folio(p);
> +
> +	return mem_cgroup_from_obj_folio(folio, p);
> +}
> +
> +/*
> + * Returns a pointer to the memory cgroup to which the kernel object is charged.
> + * Similar to mem_cgroup_from_obj(), but faster and not suitable for objects,
> + * allocated using vmalloc().
> + *
> + * A passed kernel object must be a slab object or a generic kernel page.
> + *
> + * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
> + * cgroup_mutex, etc.
> + */
> +struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> +{
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +
> +	return mem_cgroup_from_obj_folio(virt_to_folio(p), p);
> +}
> +
>  static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg = NULL;

