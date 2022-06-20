Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78705551E03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351161AbiFTOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiFTOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7829804
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3176b6ed923so100498307b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noyHdIdjcWgOmBONcZA8+AUOpZ6dpWhX/KlWjxQGveQ=;
        b=cAFK183yUZa75c9qYUYUuEjy4qYJbiDtYJ906bEPcopKwCgjaJDejkLHqNeTyNENAe
         +xoWCt7cMb4dXVwvvGCKXSmK7dw4wLz7IIUvjEvK5humbtfcNNXCo51PP0fj9EsTjzU5
         9BkF510UgCqYCljPBVWCO8+KQgCnlSj30fh6Vddb6NGuFsnp0Y0SzgMm+8+JRDmtb5Oq
         WFtFHC5XpNYZ2+aHMsKOP2+sjRxRJnd5C68KU4/2pRuUJBagAET+iUi9i9AJBjA7ub08
         /ZZvrNyFh8eRMUkEtZtPCltiI6cTwu60fRIcloaNLdAJ08vJo+guP24TRNC5SVxAV4QS
         nt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noyHdIdjcWgOmBONcZA8+AUOpZ6dpWhX/KlWjxQGveQ=;
        b=tQivG11I/wq8LeOGyKTQN9LtO/Jv8Wx2hHZ0EKcuBtptWR+/bhXD6uoomuXztx+W0q
         ZGV9/4Pee/BBIWSwzkhZ/i/6u+QrL8C27sKMpj+FKED7g1PZe502QzJqEUwQnb+Rz+4l
         Abqua3NgUU7z4rGAO9u4e5t1b/PetOSgi2lNQA5lS6LWRK7zHdO8PrcBUtNQ7q/9gEiT
         /TZa0brnE7PBE7QHUocfERCx3AAUmlHi2+DNDtWU1xaN+6fIjCMhHt9N0Q1UmIVIyJhc
         N/4bZ1Iz1I1SHinZGvLMEuIPrQaeYuBblyJ4KunI5ZB1I/NfP06FYn7/LKEj5KAFP/rO
         n1Gw==
X-Gm-Message-State: AJIora/vkNRmlbp8SqnG05MgFog0JSzo3t+kliYAwYAHE9hYWQlZhusz
        OxUvvNKCtyHqvUrKG+6FSs9PIdQwD0jWGMcqCTvC2w==
X-Google-Smtp-Source: AGRyM1tEnstguP+n9LKiSu8CU2AZjzDeJiJpOkc6fEjXv4hIMqTi12kRMCw6AQfmYkPKTuwP6Mz6HRMZHOxXzcjn7gk=
X-Received: by 2002:a81:1591:0:b0:317:bb1f:fb83 with SMTP id
 139-20020a811591000000b00317bb1ffb83mr8126761ywv.362.1655732428401; Mon, 20
 Jun 2022 06:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <db6ce7b46d47aa26056e9eae5c2aa49a3160a566.1655150842.git.andreyknvl@google.com>
In-Reply-To: <db6ce7b46d47aa26056e9eae5c2aa49a3160a566.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:52 +0200
Message-ID: <CANpmjNOhyoQH0_RiWa+hGqsXq1kR06n+A1aoFL4YhZ9LsVbawA@mail.gmail.com>
Subject: Re: [PATCH 09/32] kasan: clear metadata functions for tag-based modes
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
> Remove implementations of the metadata-related functions for the tag-based
> modes.
>
> The following patches in the series will provide alternative
> implementations.
>
> As of this patch, the tag-based modes no longer collect alloc and free
> stack traces. This functionality will be restored later in the series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/tags.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 2e200969a4b8..f11c89505c77 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -19,54 +19,25 @@
>
>  void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> -               __memset(alloc_meta, 0, sizeof(*alloc_meta));
>  }
>
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> -               kasan_set_track(&alloc_meta->alloc_track, flags);
>  }
>
>  void kasan_save_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (!alloc_meta)
> -               return;
> -
> -       kasan_set_track(&alloc_meta->free_track, GFP_NOWAIT);
>  }
>
>  struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
>                                                 void *object)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (!alloc_meta)
> -               return NULL;
> -
> -       return &alloc_meta->alloc_track;
> +       return NULL;
>  }
>
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>                                                 void *object, u8 tag)
>  {
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (!alloc_meta)
> -               return NULL;
> -
> -       return &alloc_meta->free_track;
> +       return NULL;
>  }
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/db6ce7b46d47aa26056e9eae5c2aa49a3160a566.1655150842.git.andreyknvl%40google.com.
