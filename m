Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D0358F93F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiHKIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiHKIlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:41:01 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7818E0CA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:40:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n8so27219866yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/4ZTaTdAfStvS4s3TOdOS9NhP4siit/2BMoKXlrckaA=;
        b=maHTlgEHrpe6tj9nvhzxaSrJ45tS/dMomQsC4OUZtUDQIY91YBvD+WcD6l5LWlmBDR
         BDFUVlokTb9C+kv7eRbiexzQwKwt8IHYJrFQNtuj1yxO/6h5o4j3FYBGCzVDINm7hzfg
         n3JoDsTib4lPk2YSAfY14M6lCYe2pRgHI4SJgLHvenop0b7YzA32OtNRtqiHNSJLE4hi
         OZSddfCPZ+uBwwdyLx3Pct6tH86VEaq+Ge1D2T950HKZ9zFrtZ543CPY5mYuyNyd00hp
         P9l1DGgsMOp0AnFzbMlLJg6gslhG7VAnuxe2ut4tBGWDzk/kRVu/AFnqst6UsKr4R46V
         wAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/4ZTaTdAfStvS4s3TOdOS9NhP4siit/2BMoKXlrckaA=;
        b=DVj8vu5gWzA/cDPuJfvUVrDyJq6lhxFG7JMNPPN4U58wH2xbUqprkHqjtF0oAbu/31
         itHhJFwV1JO8Z1O+DQWsFJIl+QB2aGRjsYMYGyHi9jfgzqQ5C8odvGtaNfyNvYwnvALH
         hQDQAyYXuc1mcUWNFmCEMTqovQRiIS627GUwFYAcYzxTU1Zw++dWipQjHCRQsLn5sLmk
         KbSNKPQjskuKCjpezgtAs9o1snBDrOpMXqstWZUujv1AsIz239VAb7Fv9/Kc7cqquGVg
         Sa5W2mH6C5iH7W10LvlyD0gfoSTnqb98zh1qgBu4MfjUjKiHFHyI+KJUqxIWoidQye9J
         RDYQ==
X-Gm-Message-State: ACgBeo3geygB+hYYNQWfl+tFKIxvr8fweOgd2XEYq7Liyygn1bYcYaFW
        vvSp+2LhbgIkv+xX18tipKQP40n5ACKtkHSPfnHfVw==
X-Google-Smtp-Source: AA6agR5puIpv1SM0e6ZjHmAIk3xIEbhFB/Ezw1pbmfbdbe/PLTBFlB7hM8I4dwawIuHSOABt/sc6PePv5kMHYafXt+g=
X-Received: by 2002:a25:5c7:0:b0:67c:37a4:36d with SMTP id 190-20020a2505c7000000b0067c37a4036dmr8315769ybf.584.1660207258506;
 Thu, 11 Aug 2022 01:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220811072551.2506005-1-imran.f.khan@oracle.com>
In-Reply-To: <20220811072551.2506005-1-imran.f.khan@oracle.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 11 Aug 2022 10:40:22 +0200
Message-ID: <CANpmjNNDy5-OssTWP6sm7r0BOFkBVdOa1_ZsPWGQOKjLwGZoCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce sysfs interface to disable kfence for
 selected slabs.
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     glider@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 at 09:26, Imran Khan <imran.f.khan@oracle.com> wrote:
>
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
> This RFC patch is implementing the sysfs work mentioned in [1]. Since the
> approach taken in [1] was not proper, I am sending this RFC patch as a
> separate change.

This design is much simpler and looks good to me. Feel free to send as
a non-RFC.

> [1]: https://lore.kernel.org/lkml/20220727234241.1423357-1-imran.f.khan@oracle.com/
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
>  #define SLAB_NO_USER_FLAGS     ((slab_flags_t __force)0x10000000U)
>
> +#ifdef CONFIG_KFENCE
> +#define SLAB_SKIP_KFENCE            ((slab_flags_t __force)0x20000000U)
> +#else
> +#define SLAB_SKIP_KFENCE            0
> +#endif
> +
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
>  #define SLAB_RECLAIM_ACCOUNT   ((slab_flags_t __force)0x00020000U)
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c252081b11df..8c08ae2101d7 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1003,6 +1003,13 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>                 return NULL;
>         }
>
> +       /*
> +        * Skip allocations for this slab, if KFENCE has been disabled for
> +        * this slab.
> +        */
> +       if (s->flags & SLAB_SKIP_KFENCE)
> +               return NULL;
> +
>         if (atomic_inc_return(&kfence_allocation_gate) > 1)
>                 return NULL;
>  #ifdef CONFIG_KFENCE_STATIC_KEYS
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..ee8b48327536 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5745,6 +5745,30 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
>  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  #endif /* CONFIG_SLUB_STATS */
>
> +#ifdef CONFIG_KFENCE
> +static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
> +}
> +
> +static ssize_t skip_kfence_store(struct kmem_cache *s,
> +                       const char *buf, size_t length)
> +{
> +       int ret = length;
> +
> +       if (buf[0] == '0')
> +               s->flags &= ~SLAB_SKIP_KFENCE;
> +       else if (buf[0] == '1')
> +               s->flags |= SLAB_SKIP_KFENCE;
> +       else
> +               ret = -EINVAL;
> +
> +       return ret;
> +}
> +SLAB_ATTR(skip_kfence);
> +

^ unnecessary space?


> +#endif
> +
>  static struct attribute *slab_attrs[] = {
>         &slab_size_attr.attr,
>         &object_size_attr.attr,
> @@ -5812,6 +5836,9 @@ static struct attribute *slab_attrs[] = {
>         &failslab_attr.attr,
>  #endif
>         &usersize_attr.attr,
> +#ifdef CONFIG_KFENCE
> +       &skip_kfence_attr.attr,
> +#endif
>
>         NULL
>  };
>
> base-commit: 40d43a7507e1547dd45cb02af2e40d897c591870
> --
> 2.30.2
>
