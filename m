Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243224E891A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiC0RdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiC0RdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:33:21 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C283849C80
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:31:41 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y142so22328119ybe.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zr0NjEDn5ahm6BQl9cvFf4dmTZugbKlSBosKFEdMvGE=;
        b=h+37ODtnkJ7MiURB8YYbqoFGCcPx7Qpg+DWSWAL7f82ah+0CBjQXs8wpusJLry2oe6
         yWVZm64apx6y+McOu+Y2QhsCOOYd+iP5/4DM/w4bPTagYTgmt2BiSpQOkFt/pyYPamQz
         1csnIsLYgjd2h9zEc9On5mOzBpY1DuXBRhKaPhyikp/qUrj1yZd0zOfHBbnwZ3Sz+CMO
         wI0lzkbj4mcZLDTSaAHTIoET5WxkiGl79BjthFc0YS7umTyQR61LOi3jwKX3GRW1ZIUW
         tQ8AjxiH4zS28VWB5gqNysY7172nuAHgLwoKQd0hozmCWhXMpsPU0K4aemCAS9+TZJQK
         Xt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zr0NjEDn5ahm6BQl9cvFf4dmTZugbKlSBosKFEdMvGE=;
        b=bzPxi3/1py6CNEzrErydR6YCwbUwTJ3/wYKkSrfBIYX5HYyTwkE0Vv27INph0V22L/
         B6ecx5jOWAxgVWVhHz0PPokv4nTFQHJLOBQokzLkBbOpnfY9bjWvbqxLq10oMr3+dE85
         ntuPY7rUuvWB1BQk9o8p6E60RxoBvxSB7ffM8ws0XZahwaSUgjlCKb8AfjRGyNjBCPq8
         jnAX98i4TgL2X6vDopsij4Z/jjZu4956WOkHMbNf2nvGskHkKEdnr5KnAYn1bx/0cxX9
         Z4LAszWUk3LXGSIxp4ToSVtUR8MvGpCye54r3300b083B0rAFOXHdZgSKKTr4Mdgni6L
         n7qg==
X-Gm-Message-State: AOAM530EwZcPLlc+R1gtXJnTKomsMuLQKTVb1NUeuTkt2mCFkJBklGCk
        w3F/fS2HayM7qaSzL2kyadbHHkbCL+T/SOvrbObxaVvR40I=
X-Google-Smtp-Source: ABdhPJyGnwKMfYcqaiFZe1zeZU3RqSmU7N6GnYgQV6XjaXq8hsj8Vi7m8Y1L2eKljjv4r5eGm1bTnSJVmmXUyEVfi+g=
X-Received: by 2002:a05:6902:1149:b0:634:63a3:f6a1 with SMTP id
 p9-20020a056902114900b0063463a3f6a1mr19743428ybu.425.1648402300751; Sun, 27
 Mar 2022 10:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220327051853.57647-1-songmuchun@bytedance.com> <20220327051853.57647-2-songmuchun@bytedance.com>
In-Reply-To: <20220327051853.57647-2-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 27 Mar 2022 19:31:04 +0200
Message-ID: <CANpmjNPA71CyZefox1rb_f8HqEM_R70EgZCX8fHeeAnDyujO8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: kfence: fix objcgs vector allocation
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     torvalds@linux-foundation.org, glider@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Sun, 27 Mar 2022 at 07:19, Muchun Song <songmuchun@bytedance.com> wrote:
>
> If the kfence object is allocated to be used for objects vector, then
> this slot of the pool eventually being occupied permanently since
> the vector is never freed.  The solutions could be 1) freeing vector
> when the kfence object is freed or 2) allocating all vectors statically.
> Since the memory consumption of object vectors is low, it is better to
> chose 2) to fix the issue and it is also can reduce overhead of vectors
> allocating in the future.
>
> Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/kfence/core.c   | 3 +++
>  mm/kfence/kfence.h | 1 +
>  2 files changed, 4 insertions(+)

Thanks for this -- mostly looks good. Minor comments below + also
please fix what the test robot reported.

> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 13128fa13062..9976b3f0d097 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -579,9 +579,11 @@ static bool __init kfence_init_pool(void)
>         }
>
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +               struct slab *slab = virt_to_slab(addr);
>                 struct kfence_metadata *meta = &kfence_metadata[i];
>
>                 /* Initialize metadata. */
> +               slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;

Maybe just move it to kfence_guarded_alloc(), see "/* Set required
slab fields */", where similar initialization on slab is done.

>                 INIT_LIST_HEAD(&meta->list);
>                 raw_spin_lock_init(&meta->lock);
>                 meta->state = KFENCE_OBJECT_UNUSED;
> @@ -938,6 +940,7 @@ void __kfence_free(void *addr)
>  {
>         struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
>
> +       KFENCE_WARN_ON(meta->objcg);

This holds true for both SLAB and SLUB, right? (I think it does, but
just double-checking.)

>         /*
>          * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
>          * the object, as the object page may be recycled for other-typed
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 2a2d5de9d379..6f0e1aece3f8 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -89,6 +89,7 @@ struct kfence_metadata {
>         struct kfence_track free_track;
>         /* For updating alloc_covered on frees. */
>         u32 alloc_stack_hash;
> +       struct obj_cgroup *objcg;
>  };
>
>  extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> --
> 2.11.0
>
