Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914384E9B49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiC1Pp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiC1PpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:45:25 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6C48395
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:43:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x20so26601034ybi.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLAMImTBODJ6p1BQ28mgm1zYhXSzYUbNlmQ348cuLdo=;
        b=GIYTLtunk/7VbdlxJz2L+F+hC5s7K7qDdgMJKyJ4TEI6TpypWEuW3uISWwVhgRmRe0
         L6LGJ+vHPyfz+1A/Jo+JJKPbg5dJjRwKEq9Lp9sylO86h5+/W3mpm/Kt8HzHfDRSdZVx
         E6N8kncLZ6ofsBbax1zxIM7Bnm3vnPrReCA3DePBTNMu5wBShS4HbsbK/ta1/YWSKJZ0
         3USyelDXZnfONkjzwyxvkcVd8DqqfxjXKo3qIeOx+eD6o+ITHJrCGnv6KnGg4fKwkaR+
         epyweFbyBMws3SiH3/Az2m5+5iAkEu0t+ZWOGGeaKmiWLmc7a1kImsNi87Lj7qDjkfdX
         +CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLAMImTBODJ6p1BQ28mgm1zYhXSzYUbNlmQ348cuLdo=;
        b=gKUfViQPoOjb3IirIHr2FSvVsxfPfWdRylcmu0DrD8FCFW9T4LJfsOufQ4USyfSeJG
         R69DZ5TYg8U63r89H2c36WhUe/XSzUr/l5c5nbRPdLiDZ6SXWyWjiWAJy9iO18LZKnCO
         f1Rdbv54Dt0Vge+KpHm9T1k59QV/B9moxHuURPTCbTpLuUPDP/N3vlk4xhWnd8sM48md
         xc1SYsBi5W9DCy6qXmVPkWBkyAGiBWDrGhK5GlZo7ItpioVaFYVpPcWgPmw9FPjywgeF
         4Pdu7uNEJNtzQSykV0k3RYiJrswT30o7pPf2QS4jTqP6eIi6NZTpo8H8oUpTfdx0UF0L
         9a4w==
X-Gm-Message-State: AOAM531k6ovh01WboeoJs1VkRBinfDWTrw3+ClE61T8NNruikarvDNZm
        bHWzCl4hLF9MYsuKRW/hoQOUje4PGA8AMcE7E2vUoy9ynaa01w==
X-Google-Smtp-Source: ABdhPJwmVXEqdR8lQkP19/L8e0cirz16e509iPdj4QWD1qSuTNtPHrKLywy+HWYdoSO5gRqUetj/qXfwkm9pxb46L88=
X-Received: by 2002:a05:6902:24f:b0:62d:69d:c9fc with SMTP id
 k15-20020a056902024f00b0062d069dc9fcmr22422814ybs.87.1648482223855; Mon, 28
 Mar 2022 08:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220328132843.16624-1-songmuchun@bytedance.com>
In-Reply-To: <20220328132843.16624-1-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Mar 2022 17:43:07 +0200
Message-ID: <CANpmjNO=vMYhL_Uf3ewXvfWoan3q+cYjWV0jEze7toKSh2HRjg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: fix objcgs vector allocation
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
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

On Mon, 28 Mar 2022 at 15:28, Muchun Song <songmuchun@bytedance.com> wrote:
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

Reviewed-by: Marco Elver <elver@google.com>

Btw, how did you test this?

Thanks,
-- Marco

> ---
> v2:
>  - Fix compiler error reported by kernel test robot <lkp@intel.com>.
>
>  mm/kfence/core.c   | 11 ++++++++++-
>  mm/kfence/kfence.h |  3 +++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 13128fa13062..d4c7978cd75e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -555,6 +555,8 @@ static bool __init kfence_init_pool(void)
>          * enters __slab_free() slow-path.
>          */
>         for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> +               struct slab *slab = page_slab(&pages[i]);
> +
>                 if (!i || (i % 2))
>                         continue;
>
> @@ -562,7 +564,11 @@ static bool __init kfence_init_pool(void)
>                 if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
>                         goto err;
>
> -               __SetPageSlab(&pages[i]);
> +               __folio_set_slab(slab_folio(slab));
> +#ifdef CONFIG_MEMCG
> +               slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> +                                  MEMCG_DATA_OBJCGS;
> +#endif
>         }
>
>         /*
> @@ -938,6 +944,9 @@ void __kfence_free(void *addr)
>  {
>         struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
>
> +#ifdef CONFIG_MEMCG
> +       KFENCE_WARN_ON(meta->objcg);
> +#endif
>         /*
>          * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
>          * the object, as the object page may be recycled for other-typed
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 2a2d5de9d379..9a6c4b1b12a8 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -89,6 +89,9 @@ struct kfence_metadata {
>         struct kfence_track free_track;
>         /* For updating alloc_covered on frees. */
>         u32 alloc_stack_hash;
> +#ifdef CONFIG_MEMCG
> +       struct obj_cgroup *objcg;
> +#endif
>  };
>
>  extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> --
> 2.11.0
>
