Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C24551DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351216AbiFTOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351146AbiFTOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9328E3F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:22 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31772f8495fso99753027b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3ftVDEg1TDDghcSSxJkEC5/y2JJbqzI/pYg/LWTE5M=;
        b=eQi9zaETbW4lHIIHxYGnQFaf8AKQt0sBKp0IbSlyW9dV5l1FyBP28/JhSX7ZhHu+EC
         tq9L0qSxqCjnYc8aQp21Dd+5qgn0BytcW0NQTRXtMcAQa7B+KEsgsbEmNd6TAlPi9AIQ
         ZZOT1mZeBnc/gpoJG9mRYLpUl2CTZMQwYc/Cjht516keHKmlelKQqbybpmzoSewBOAlb
         P8TTBOQauRSlBcojdTn+Vvy+OZRLdawcAIc/nuA2hRx8y0fw6cRh3e48d3wxu6Ao3go3
         YpU8fhOcLfj3jeqCwfG7NEi3xcWiwxHToSWrmUMunOpsbs0chbwsMR1i5RxQjQsiyVuX
         j7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3ftVDEg1TDDghcSSxJkEC5/y2JJbqzI/pYg/LWTE5M=;
        b=mZMa72Xi4lapTNSqoRdAfJyKkBlgsUVZ3KM7W18CQFVWzIipL768KxCT38LV0c32d5
         XskxA3e08Zw+rFbXGgnKNO85a0VLyGrHuYaCi7TzYdhm4IWCCiSLUg0PJazTsaGvy0Hc
         15H4HGhSdx25vkOh8ZDHYZ9tpxonEjHXP1OxtRSf10seAWCIvOYQnlC6sPZYhf6XDpyk
         YDuMBzAexGTvyONtdZVBH/+yvEcpcG0QgyxHJwRO6lRfStJzFxtiq4TzvGiBzLoyHeVU
         4Su7slcOQjzsjvDFrFSllZWQ/3sqM4xq1RO2LJT6HMaM+KFUHWPOMBO2WFfxeoMTuknu
         rSDA==
X-Gm-Message-State: AJIora9Q1H4GdYm6TuKLei29g9ysTicIMtJ0w6TwUhXviG/tOzGJkZgi
        pCjy9Wf0qN2nXyLIDs+gFRRFO96t5smW+6MXx+XNbA==
X-Google-Smtp-Source: AGRyM1tuzS2F5lnMM3e3LuptJnclgKnMIb8eaxxILsezytDKBMYiD1qJfqe3ULRqbbhVvRi5Hs3vo84qgTBXGVi6G+M=
X-Received: by 2002:a81:3a12:0:b0:314:6097:b801 with SMTP id
 h18-20020a813a12000000b003146097b801mr27848775ywa.512.1655732421684; Mon, 20
 Jun 2022 06:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <184ac9df81406e73611e1f639c5d4d09f8d7693a.1655150842.git.andreyknvl@google.com>
In-Reply-To: <184ac9df81406e73611e1f639c5d4d09f8d7693a.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:45 +0200
Message-ID: <CANpmjNM63AQK71Nd2UQ2VNFDQfog9rMScdG2FatgHnGVX4F+gQ@mail.gmail.com>
Subject: Re: [PATCH 07/32] kasan: introduce kasan_get_alloc_track
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
> Add a kasan_get_alloc_track() helper that fetches alloc_track for a slab
> object and use this helper in the common reporting code.
>
> For now, the implementations of this helper are the same for the Generic
> and tag-based modes, but they will diverge later in the series.
>
> This change hides references to alloc_meta from the common reporting code.
> This is desired as only the Generic mode will be using per-object metadata
> after this series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/generic.c | 14 +++++++++++++-
>  mm/kasan/kasan.h   |  4 +++-
>  mm/kasan/report.c  |  8 ++++----
>  mm/kasan/tags.c    | 14 +++++++++++++-
>  4 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 98c451a3b01f..f212b9ae57b5 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -381,8 +381,20 @@ void kasan_save_free_info(struct kmem_cache *cache,
>         *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
>  }
>
> +struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
> +                                               void *object)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (!alloc_meta)
> +               return NULL;
> +
> +       return &alloc_meta->alloc_track;
> +}
> +
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -                               void *object, u8 tag)
> +                                               void *object, u8 tag)
>  {
>         if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREETRACK)
>                 return NULL;
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index bcea5ed15631..4005da62a1e1 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -282,8 +282,10 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
>  void kasan_set_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
>  void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
> +struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
> +                                               void *object);
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -                               void *object, u8 tag);
> +                                               void *object, u8 tag);
>
>  #if defined(CONFIG_KASAN_GENERIC) && \
>         (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 35dd8aeb115c..f951fd39db74 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -251,12 +251,12 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>  static void describe_object_stacks(struct kmem_cache *cache, void *object,
>                                         const void *addr, u8 tag)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> +       struct kasan_track *alloc_track;
>         struct kasan_track *free_track;
>
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta) {
> -               print_track(&alloc_meta->alloc_track, "Allocated");
> +       alloc_track = kasan_get_alloc_track(cache, object);
> +       if (alloc_track) {
> +               print_track(alloc_track, "Allocated");
>                 pr_err("\n");
>         }
>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index e0e5de8ce834..7b1fc8e7c99c 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -38,8 +38,20 @@ void kasan_save_free_info(struct kmem_cache *cache,
>         kasan_set_track(&alloc_meta->free_track, GFP_NOWAIT);
>  }
>
> +struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
> +                                               void *object)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (!alloc_meta)
> +               return NULL;
> +
> +       return &alloc_meta->alloc_track;
> +}
> +
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -                               void *object, u8 tag)
> +                                               void *object, u8 tag)
>  {
>         struct kasan_alloc_meta *alloc_meta;
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/184ac9df81406e73611e1f639c5d4d09f8d7693a.1655150842.git.andreyknvl%40google.com.
