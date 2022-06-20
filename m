Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2528551DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351212AbiFTOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbiFTOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D32935C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p69so7339928ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qC8/39KyiVmkl5BIZHurMzBUhpZZ/2u2VsK+Aq1J8ck=;
        b=n5grsZvn37HTJvF7JA9iDYlBioHc18d2ANnnTFPfnz1iuWR3ngzEQtfFNI+L/z2FCv
         Kw+da3fcl8sTfSrM9d6BVz6LjzSfp55xy/s0TYpzX7DgcpiMalQQrXPtLO8qf+CKxXxJ
         oOFitOjgxGC+ccHqd9xVj9y8uqqfj/EvCg+GbaGgcURdSWtTE++dQKmGgq89cUK5rIbQ
         uEZeryy2q/4qpoHxj7npuMm7okgUIbpgP/y6GiGmfbAaRsPjfvoaN1Fh3VMF1i5Rr/Xb
         7jOf0IVwtVIMfaJvlfqFCPiQACWG43TX47vx95xFwHd+dzwJV/nCX96F3XL9Apn/2c3V
         XIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qC8/39KyiVmkl5BIZHurMzBUhpZZ/2u2VsK+Aq1J8ck=;
        b=ycfcTgWRiVlZyQ4YtdquIOSEs09ILEGgbducV0V9q6CfYCjFy7xK14IZauMazipqYm
         rXsHpXwt8einTWCo+Pc0lUVUK5H6MxRD4h3/xcjuk/wKSGhZiWhDABtkiQ00Cd7fl/11
         HXJAJznaZ79+LFiOZ4nFKAXAQARFONEOcNBNYDNBD57OofZfDZjCtBfM4bWGA+pMTZsT
         CCoOQBbvwSGNkWcF9P/7YQ8o5wGH3AMXOFnh/ZNJL/gZfyCRCE1cdTzbnQnRL++RjKCG
         vc02z7syS2yyOyrlZ6A/lU0JsGI3SovGZenIs9sIGhgVEd7SU7ntPgKe8K6WV2f5Wtqq
         P0nw==
X-Gm-Message-State: AJIora9unj7RDbgdB1506LTADlFlOpNsd+H5VRoDNw4CjnNh9gqDK1KV
        91HFqvClDCpBQO+kH0T7x5v7UDcPnS3jN79yo9gMVQ==
X-Google-Smtp-Source: AGRyM1tFQRMqH7PE0XOK25t/U3BmF+AvWBCqJkpRyfkJZxomI2+bNrTC9wgUda8cQUepFpAOOZt1wJOnaH/B7Ysif/s=
X-Received: by 2002:a25:1583:0:b0:668:e74a:995f with SMTP id
 125-20020a251583000000b00668e74a995fmr11104743ybv.1.1655732424678; Mon, 20
 Jun 2022 06:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <8d1cf94238a325e441f684cbdbb2a1da0db78add.1655150842.git.andreyknvl@google.com>
In-Reply-To: <8d1cf94238a325e441f684cbdbb2a1da0db78add.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:48 +0200
Message-ID: <CANpmjNO_DqF+=HMQ+j9uL7qeO4a7FGy1Vuzs=pHhpQVC_is9Pw@mail.gmail.com>
Subject: Re: [PATCH 08/32] kasan: introduce kasan_init_object_meta
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

On Mon, 13 Jun 2022 at 22:16, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Add a kasan_init_object_meta() helper that initializes metadata for a slab
> object and use it in the common code.
>
> For now, the implementations of this helper are the same for the Generic
> and tag-based modes, but they will diverge later in the series.
>
> This change hides references to alloc_meta from the common code. This is
> desired as only the Generic mode will be using per-object metadata after
> this series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/common.c  | 10 +++-------
>  mm/kasan/generic.c |  9 +++++++++
>  mm/kasan/kasan.h   |  2 ++
>  mm/kasan/tags.c    |  9 +++++++++
>  4 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2848c7a2402a..f0ee1c1b4b3c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -312,13 +312,9 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>  void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>                                                 const void *object)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       if (kasan_stack_collection_enabled()) {
> -               alloc_meta = kasan_get_alloc_meta(cache, object);
> -               if (alloc_meta)
> -                       __memset(alloc_meta, 0, sizeof(*alloc_meta));
> -       }
> +       /* Initialize per-object metadata if it is present. */
> +       if (kasan_stack_collection_enabled())
> +               kasan_init_object_meta(cache, object);
>
>         /* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
>         object = set_tag(object, assign_tag(cache, object, true));
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index f212b9ae57b5..5462ddbc21e6 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -328,6 +328,15 @@ DEFINE_ASAN_SET_SHADOW(f3);
>  DEFINE_ASAN_SET_SHADOW(f5);
>  DEFINE_ASAN_SET_SHADOW(f8);
>
> +void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (alloc_meta)
> +               __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +}
> +
>  static void __kasan_record_aux_stack(void *addr, bool can_alloc)
>  {
>         struct slab *slab = kasan_addr_to_slab(addr);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 4005da62a1e1..751c3b17749a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -278,6 +278,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
>  struct page *kasan_addr_to_page(const void *addr);
>  struct slab *kasan_addr_to_slab(const void *addr);
>
> +void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
> +
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
>  void kasan_set_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 7b1fc8e7c99c..2e200969a4b8 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -17,6 +17,15 @@
>
>  #include "kasan.h"
>
> +void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (alloc_meta)
> +               __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +}
> +
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/8d1cf94238a325e441f684cbdbb2a1da0db78add.1655150842.git.andreyknvl%40google.com.
