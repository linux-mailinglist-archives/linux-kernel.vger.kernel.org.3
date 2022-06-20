Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085D551E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351075AbiFTOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiFTOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:24 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA4289AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id u9so8875957ybq.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4db5qe9nfedraUSjBeWLX6x7hDJFPJYx1QIcCVkfBw=;
        b=gqJJODRW9TVM68r7z9oFsjnJGqLfS8dsvkZOhGNY0ryjyuxUArQlopicrr9CxvISNX
         eel4zLPD1tiL8PUNgn/Ppy2idcxs58uP58n1o8bkpYLpDAWfoZghGGBVPNfhtGq2gF7W
         RdWBkk6iZWRtX8ffH8HMV8nohwWKaRInEzCFW0iqsKNLOzH1Bm5ZF3m9YHB8ArCJr2V7
         dJbG/N9Q2bGIb0sQsgGdmgQ0Dsa4K5f0o2fXuamYhVN1WF1iXCBzNEHJSIDRJ0bNjzZv
         nP3EXdhYqAYmDdg1ZJ3Biy/6my1x3VclaSuWwpxHsFdkd4n3QyLhla8cMFjRV9T/tckb
         I8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4db5qe9nfedraUSjBeWLX6x7hDJFPJYx1QIcCVkfBw=;
        b=zOkD+SpGAEjWr6fHUnF43f5VXcXVqsQugSVBZLYxTBnzhKUoz+69CPbhxVq2liJpQ3
         J3xUdiLa09Xzfzf88AzGR3ioX0/wuzb+MZVpmusRJyXGHe4N88NtPedtVCH8Ov7VKWNQ
         dgvHxF11J6IPcaMhwtDCX6zXyqU4EVxZe3iEzrFY5MjE3QJ8KqqIVt2Phor/QQoE5ptH
         /nyGx6llE7aRq0NixAF4Y0RSoZtrivdX8rwak7aBaqg134+Dh47mQULDwEcreGp6TG3K
         x170OBUTyymAVM5XP0BBLJCFEb7HX9+ooPFAwxq3MtByM6lXeipx0CRCJf1eWN5UGxDO
         YRkw==
X-Gm-Message-State: AJIora/1W3gSbpoZLQKBDdhQqxv8Zbr9DcKjkJRNWcA1AA53Cr0mmFA+
        BslRj4wy92inXUdpGPRvDyK78SDzf5uvltY0Re0rLA==
X-Google-Smtp-Source: AGRyM1u+xdcL1FA8R5vc+y26zqgQbjzMDTgmfLW+tUOodR6tKbJRiRRfIk5BpTke++hURuzNbavNuBuCx94z7FEcjW0=
X-Received: by 2002:a25:c5cb:0:b0:668:c187:9d0 with SMTP id
 v194-20020a25c5cb000000b00668c18709d0mr16817150ybe.609.1655732414865; Mon, 20
 Jun 2022 06:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <ae1389c0717d1875077ee3f6cd4beb5b7e046ae0.1655150842.git.andreyknvl@google.com>
In-Reply-To: <ae1389c0717d1875077ee3f6cd4beb5b7e046ae0.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:39 +0200
Message-ID: <CANpmjNNdz58SKo0P8grXsP7ik_2wOiiJEbiN3ycGMrR1Xw9w7A@mail.gmail.com>
Subject: Re: [PATCH 04/32] kasan: split save_alloc_info implementations
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
> Provide standalone implementations of save_alloc_info() for the Generic
> and tag-based modes.
>
> For now, the implementations are the same, but they will diverge later
> in the series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/common.c  | 13 ++-----------
>  mm/kasan/generic.c |  9 +++++++++
>  mm/kasan/kasan.h   |  1 +
>  mm/kasan/tags.c    |  9 +++++++++
>  4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a6107e8375e0..2848c7a2402a 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -423,15 +423,6 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>         }
>  }
>
> -static void save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> -               kasan_set_track(&alloc_meta->alloc_track, flags);
> -}
> -
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>                                         void *object, gfp_t flags, bool init)
>  {
> @@ -462,7 +453,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>
>         /* Save alloc info (if possible) for non-kmalloc() allocations. */
>         if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
> -               save_alloc_info(cache, (void *)object, flags);
> +               kasan_save_alloc_info(cache, (void *)object, flags);
>
>         return tagged_object;
>  }
> @@ -508,7 +499,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
>          * This also rewrites the alloc info when called from kasan_krealloc().
>          */
>         if (kasan_stack_collection_enabled() && cache->kasan_info.is_kmalloc)
> -               save_alloc_info(cache, (void *)object, flags);
> +               kasan_save_alloc_info(cache, (void *)object, flags);
>
>         /* Keep the tag that was set by kasan_slab_alloc(). */
>         return (void *)object;
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 03a3770cfeae..98c451a3b01f 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -358,6 +358,15 @@ void kasan_record_aux_stack_noalloc(void *addr)
>         return __kasan_record_aux_stack(addr, false);
>  }
>
> +void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (alloc_meta)
> +               kasan_set_track(&alloc_meta->alloc_track, flags);
> +}
> +
>  void kasan_save_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 6df8d7b01073..610057e651d2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -284,6 +284,7 @@ struct slab *kasan_addr_to_slab(const void *addr);
>
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
>  void kasan_set_track(struct kasan_track *track, gfp_t flags);
> +void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
>  void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>                                 void *object, u8 tag);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index b453a353bc86..1ba3c8399f72 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -17,6 +17,15 @@
>
>  #include "kasan.h"
>
> +void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (alloc_meta)
> +               kasan_set_track(&alloc_meta->alloc_track, flags);
> +}
> +
>  void kasan_save_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/ae1389c0717d1875077ee3f6cd4beb5b7e046ae0.1655150842.git.andreyknvl%40google.com.
