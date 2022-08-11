Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178DD58FACD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiHKKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiHKKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:40:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC830F53
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:40:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d16so16578019pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eGbXQsKb8yt2To4bDCbL2Z7QyRG8T1fC5MTNEkBLar0=;
        b=iUXron1LpIR8hrtUavxu3b9yUZKvnb030Kb9YJEVur5ODX7G3kCMK7hHRb+5CE5j4e
         qNCO+YrnCkl5eDB84ADA0UFgtoAFO27Zn2z44MIqzqKx6LatbdRdviXLRuSjn557aRwn
         7rAX1F8NqjBSoLvXkCFoBbUyMYsgIDCJpXFVyCiouVUyNggAbnJbMZgW/ZFgSL8kCSqS
         oL7wpa+uyP+H4YMZeZp0JaufVmf6Dd6qcS5clnfezwA9Hy4pLSpbukFTVs3QyyWWjc01
         5RJyXsCFKYnj/cfzrbZLSIe2QXPdtR7/lhpNLq3x4Ga00Kpwl45ohXKX73M5yonMPt11
         A4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eGbXQsKb8yt2To4bDCbL2Z7QyRG8T1fC5MTNEkBLar0=;
        b=wS1wmsMesDQgLiYURPbVQhJdd36jIyqYnb44YiCpLs+DZepMVRSvG2unj3x9l1vtiX
         j8UM0eHOc3P3obGfuf+5tOLIjE1G50sfDQr2TpvYSxRcQDThZ2z8g22NNsdr5BOTHv50
         Ql40UD0ToKr4oCjW1Hpuydf9kRUjjZbEjEV1WsTP5CrTS/ZtlAdbEa/JdzWxz0tEx+it
         NhAk76bo2tHZDES63lZEVUhpICumXyozb2ePYxKnndhPem28yYGoxwtJ+UlntSo51mav
         3RxN6bVHaK0++zIYDC71vhydVkzIhjhKiYnVFLHbPi3KiOyxR65KOdYKpetGU4MkL7BF
         At8A==
X-Gm-Message-State: ACgBeo3U+jN7nXjJ7oZ63j9PjIeuQFBGD8qVLe91YzsFJEk9ayv/Jqnd
        w7lYq1P3vOT7QkgmMC3XM60=
X-Google-Smtp-Source: AA6agR73mfxCoAqPIDjSSr9ENX+w797y+jQ/7NJs9mylmjnXYgBynDf220LcvxKAPJ9HcWz3Hph5tA==
X-Received: by 2002:a17:90b:3e8c:b0:1f7:3792:d336 with SMTP id rj12-20020a17090b3e8c00b001f73792d336mr8325711pjb.0.1660214422056;
        Thu, 11 Aug 2022 03:40:22 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090aa88b00b001f4fb21c11asm3402986pjq.21.2022.08.11.03.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:40:21 -0700 (PDT)
Date:   Thu, 11 Aug 2022 19:40:15 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
Message-ID: <YvTcj37kS5xmNWCH@hyeyoo>
References: <20220811085938.2506536-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811085938.2506536-1-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 06:59:38PM +1000, Imran Khan wrote:
> By default kfence allocation can happen for any slab object, whose size
> is up to PAGE_SIZE, as long as that allocation is the first allocation
> after expiration of kfence sample interval. But in certain debugging
> scenarios we may be interested in debugging corruptions involving
> some specific slub objects like dentry or ext4_* etc. In such cases
> limiting kfence for allocations involving only specific slub objects
> will increase the probablity of catching the issue since kfence pool
> will not be consumed by other slab objects.
> 
> This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
> to disable kfence for specific slabs. Having the interface work in this
> way does not impact current/default behavior of kfence and allows us to
> use kfence for specific slabs (when needed) as well. The decision to
> skip/use kfence is taken depending on whether kmem_cache.flags has
> (newly introduced) SLAB_SKIP_KFENCE flag set or not.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
> 
> Changes since v1:
>  - Remove RFC tag
> 
>  include/linux/slab.h |  6 ++++++
>  mm/kfence/core.c     |  7 +++++++
>  mm/slub.c            | 27 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..947d912fd08c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -119,6 +119,12 @@
>   */
>  #define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
>  
> +#ifdef CONFIG_KFENCE
> +#define SLAB_SKIP_KFENCE            ((slab_flags_t __force)0x20000000U)
> +#else
> +#define SLAB_SKIP_KFENCE            0
> +#endif
> +
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c252081b11df..8c08ae2101d7 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1003,6 +1003,13 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Skip allocations for this slab, if KFENCE has been disabled for
> +	 * this slab.
> +	 */
> +	if (s->flags & SLAB_SKIP_KFENCE)
> +		return NULL;
> +
>  	if (atomic_inc_return(&kfence_allocation_gate) > 1)
>  		return NULL;
>  #ifdef CONFIG_KFENCE_STATIC_KEYS
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..ee8b48327536 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5745,6 +5745,30 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
>  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  #endif	/* CONFIG_SLUB_STATS */
>  
> +#ifdef CONFIG_KFENCE
> +static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
> +}
> +
> +static ssize_t skip_kfence_store(struct kmem_cache *s,
> +			const char *buf, size_t length)
> +{
> +	int ret = length;
> +
> +	if (buf[0] == '0')
> +		s->flags &= ~SLAB_SKIP_KFENCE;
> +	else if (buf[0] == '1')
> +		s->flags |= SLAB_SKIP_KFENCE;
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +SLAB_ATTR(skip_kfence);
> +
> +#endif
> +
>  static struct attribute *slab_attrs[] = {
>  	&slab_size_attr.attr,
>  	&object_size_attr.attr,
> @@ -5812,6 +5836,9 @@ static struct attribute *slab_attrs[] = {
>  	&failslab_attr.attr,
>  #endif
>  	&usersize_attr.attr,
> +#ifdef CONFIG_KFENCE
> +	&skip_kfence_attr.attr,
> +#endif
>  
>  	NULL
>  };
> 
> base-commit: 40d43a7507e1547dd45cb02af2e40d897c591870
> -- 
> 2.30.2

No strong opinion on its interface, but from view of correctness:

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
