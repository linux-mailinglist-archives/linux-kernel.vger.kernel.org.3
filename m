Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60D551DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiFTOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbiFTOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:20 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D161FCD9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-317710edb9dso100916797b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIuI4RCTb90zIPiwyne5eQXzXeGLUJKIbNqh+rIdowY=;
        b=FTr4DRmCpN/Wjfvv+34a5xerinXh1vz1NuZLpJy+x7IMGgPJaN6vi1eqMOs8rhIww/
         hwl0GymjliBdt4N2EtKGliNSE0sdRpNEcyHKI8LGrD55dbaIXUJ6AH+UguhcZpNSbX+/
         dgIDVGp0oQdo5MpMKLxiWmfksa7nA/ysA9bSVslaQRNb3a3usqUbZZoswWjTPR2g4yWK
         vUF21TVqQfcf5PJ3Azzmd+dXGX0osLprdGUa1nQXUIKNWZZ+s9+1SOyZdAeTQHYdL8J3
         ZwsneouB+uZsrV0Pn+0Fw+1HCDTnPyUzU6B2x1eSJ6kAvd7wJX8iI0eRyZc/DhkgFuN1
         7kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIuI4RCTb90zIPiwyne5eQXzXeGLUJKIbNqh+rIdowY=;
        b=gtDz6oKsozAVzPS7m5APMVsEKptwPProAenG6meEDctIXZMwkIuxmGzL3S6qhNJOjC
         ZB3cf0/piCuJqCPcjQmZvMK8gRzjvUuRY3kDceImWk7wVeurxCzp7iqAmiLOXwAYoYOm
         kZGfAbvdxPnJeOWl/WS09jsrQ6MgRYALISAUtbXDJaN2vqlCVFUEWT1ENbUGfa8LIp6Q
         jNXnOkd03B1KhJFZgEInzXPqUuKyOQzawEu71gFxWwg4r47qrpImWQkZKUBnalwrwsKG
         RKNUHdDWsCSaX2q9Q9JnvDKHtZL9uYSjvVqYSAF3I/0diB/iUisJBjeLwRkNt3Si68on
         48BA==
X-Gm-Message-State: AJIora/XNaBUghAlAZJOa3s3jq33pyPqAviCUPG3OR3U445uGEM4ffwZ
        baCsrRogS9Ivr9o7tDp0Uk/oOFed6uT/zaQWBF2FZA==
X-Google-Smtp-Source: AGRyM1uAWiiqEaEiDuQ4K5RHnwUdlQDkUSjJy/UzaEd6ovDivgJdTbeDH4rX4o24LeYreoGsE7AolpKI8yLV3Koe+V4=
X-Received: by 2002:a0d:f4c6:0:b0:30c:8e46:abe5 with SMTP id
 d189-20020a0df4c6000000b0030c8e46abe5mr27511237ywf.333.1655732410435; Mon, 20
 Jun 2022 06:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <ad7b6cfa3fbe10d2d9c4d15a9d30c2db9a41362c.1655150842.git.andreyknvl@google.com>
In-Reply-To: <ad7b6cfa3fbe10d2d9c4d15a9d30c2db9a41362c.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:34 +0200
Message-ID: <CANpmjNOJoR2ReowDbw5DG3i95392uiukXmVmkSKL3ORLeW_6Zg@mail.gmail.com>
Subject: Re: [PATCH 03/32] kasan: move is_kmalloc check out of save_alloc_info
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, 13 Jun 2022 at 22:15, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Move kasan_info.is_kmalloc check out of save_alloc_info().
>
> This is a preparatory change that simplifies the following patches
> in this series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/common.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 753775b894b6..a6107e8375e0 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -423,15 +423,10 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>         }
>  }
>
> -static void save_alloc_info(struct kmem_cache *cache, void *object,
> -                               gfp_t flags, bool is_kmalloc)
> +static void save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
>         struct kasan_alloc_meta *alloc_meta;
>
> -       /* Don't save alloc info for kmalloc caches in kasan_slab_alloc(). */
> -       if (cache->kasan_info.is_kmalloc && !is_kmalloc)
> -               return;
> -
>         alloc_meta = kasan_get_alloc_meta(cache, object);
>         if (alloc_meta)
>                 kasan_set_track(&alloc_meta->alloc_track, flags);
> @@ -466,8 +461,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>         kasan_unpoison(tagged_object, cache->object_size, init);
>
>         /* Save alloc info (if possible) for non-kmalloc() allocations. */
> -       if (kasan_stack_collection_enabled())
> -               save_alloc_info(cache, (void *)object, flags, false);
> +       if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
> +               save_alloc_info(cache, (void *)object, flags);
>
>         return tagged_object;
>  }
> @@ -512,8 +507,8 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
>          * Save alloc info (if possible) for kmalloc() allocations.
>          * This also rewrites the alloc info when called from kasan_krealloc().
>          */
> -       if (kasan_stack_collection_enabled())
> -               save_alloc_info(cache, (void *)object, flags, true);
> +       if (kasan_stack_collection_enabled() && cache->kasan_info.is_kmalloc)
> +               save_alloc_info(cache, (void *)object, flags);
>
>         /* Keep the tag that was set by kasan_slab_alloc(). */
>         return (void *)object;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/ad7b6cfa3fbe10d2d9c4d15a9d30c2db9a41362c.1655150842.git.andreyknvl%40google.com.
