Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591F551E62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350063AbiFTOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbiFTOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:16 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E81FCDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:06 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-317741c86fdso98946627b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSBOYdsGO6+KrB480UmpDMZjJ15J65v7kSYVCX5JDz0=;
        b=K21MOgAwFOJwymBXGViBUBtmuOgyiDkKC8JKOME2iQ49Q33+sHQrYaRffrYzenwYl1
         KkOhhL1tV8dKS1TxM/JmojI/ToZ9jS+joWKrYybapZMBtoWyM12bO9IlvlChzhAMogk3
         052ujsSIPPO0q7rmzoXWo0KRxTXMsgUvmJm8Axe2vXouv2bNvg6+gz8UIukMoBZYQmYu
         Ba3fxB3GYBGxt/l9PXRrTG48EjlScBHyj06gEFhDoeTsJh7JPaTdy7/du/HdcFuYYBGI
         25HwhaJefSzo9DJG2/kIYiqJkR63+2mZKq43X1kUPkAf6awg3TBb8ivTzI4I40qzRqNw
         9x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSBOYdsGO6+KrB480UmpDMZjJ15J65v7kSYVCX5JDz0=;
        b=2Dx7nAo9Er+1RvyjSKUfG/WN4k6YSuq6t5yqOBCBrahzObo93dXFJVP9fluVDmZZLb
         wZM/ga8YWQbGlFSSen038/SDbvWHUgpqCH0aaEgpT06y9LhEu/yfxC+Kk/lP5aThbyJu
         dv+13ipFdDp5TtGGb7vrIplBCuolaxBEJEPPhiIiOEAHTk36Nl+rjdmrQyR9ay/vJKLb
         LMERzpI/zcBtwP5v93qYSLNGkJY2w1ozBKZh+PPQm9bpY3UdyFLWn5EmXZUBH7qb2gP8
         mKcVT+Ax6KFd4udgVVW4ySd0yCLcISbRCTfzi4Wy1FMDtV+J5tXTBz3RAlMgGctoT/xE
         0GIA==
X-Gm-Message-State: AJIora+QKzLkeXCYP6DaKl61GAqt0xC0xE9Os4VOyVJ56kk6S24FVZwR
        okHM2aULTsgJLOdHym1iP9+omYLSan64q6S9Fj5zUtCatYE=
X-Google-Smtp-Source: AGRyM1sr93/nC5DemPXH6UFp/nhpxfs+S+lhlHaWoQSU/uzTy/dkbnEsMdSfj5FSedHIPBGPDq/gcRliyypuvZx3WC4=
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr21447189ywb.316.1655732405833; Mon, 20
 Jun 2022 06:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <50cdd8e8d696a8958b7b59c940561c6ed8042436.1655150842.git.andreyknvl@google.com>
In-Reply-To: <50cdd8e8d696a8958b7b59c940561c6ed8042436.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:30 +0200
Message-ID: <CANpmjNP-TJs5pcnMXE7L2m9CPAdmiBjkeRCm3RtyPdQQFM3H0Q@mail.gmail.com>
Subject: Re: [PATCH 02/32] kasan: rename kasan_set_*_info to kasan_save_*_info
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
> Rename set_alloc_info() and kasan_set_free_info() to save_alloc_info()
> and kasan_save_free_info(). The new names make more sense.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/common.c  | 8 ++++----
>  mm/kasan/generic.c | 2 +-
>  mm/kasan/kasan.h   | 2 +-
>  mm/kasan/tags.c    | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 968d2365d8c1..753775b894b6 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -364,7 +364,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>                 return false;
>
>         if (kasan_stack_collection_enabled())
> -               kasan_set_free_info(cache, object, tag);
> +               kasan_save_free_info(cache, object, tag);
>
>         return kasan_quarantine_put(cache, object);
>  }
> @@ -423,7 +423,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>         }
>  }
>
> -static void set_alloc_info(struct kmem_cache *cache, void *object,
> +static void save_alloc_info(struct kmem_cache *cache, void *object,
>                                 gfp_t flags, bool is_kmalloc)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> @@ -467,7 +467,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>
>         /* Save alloc info (if possible) for non-kmalloc() allocations. */
>         if (kasan_stack_collection_enabled())
> -               set_alloc_info(cache, (void *)object, flags, false);
> +               save_alloc_info(cache, (void *)object, flags, false);
>
>         return tagged_object;
>  }
> @@ -513,7 +513,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
>          * This also rewrites the alloc info when called from kasan_krealloc().
>          */
>         if (kasan_stack_collection_enabled())
> -               set_alloc_info(cache, (void *)object, flags, true);
> +               save_alloc_info(cache, (void *)object, flags, true);
>
>         /* Keep the tag that was set by kasan_slab_alloc(). */
>         return (void *)object;
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 437fcc7e77cf..03a3770cfeae 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -358,7 +358,7 @@ void kasan_record_aux_stack_noalloc(void *addr)
>         return __kasan_record_aux_stack(addr, false);
>  }
>
> -void kasan_set_free_info(struct kmem_cache *cache,
> +void kasan_save_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
>         struct kasan_free_meta *free_meta;
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 610d60d6e5b8..6df8d7b01073 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -284,7 +284,7 @@ struct slab *kasan_addr_to_slab(const void *addr);
>
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
>  void kasan_set_track(struct kasan_track *track, gfp_t flags);
> -void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag);
> +void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>                                 void *object, u8 tag);
>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 8f48b9502a17..b453a353bc86 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -17,7 +17,7 @@
>
>  #include "kasan.h"
>
> -void kasan_set_free_info(struct kmem_cache *cache,
> +void kasan_save_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/50cdd8e8d696a8958b7b59c940561c6ed8042436.1655150842.git.andreyknvl%40google.com.
