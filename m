Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0849E551EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351093AbiFTOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbiFTOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772F28E1A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t1so19017705ybd.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mK//W8+alc6U2SRanqIfp5lLUuphqu6jqWQbXvYHju8=;
        b=rcNec0L28V59argJ+4p78OWpEUVBF0h7njQetuVutBS53hvZWQKuzmt27ET9pS9ZcD
         9W1NCt25xnDieQfUEJaCxfsUE+wDQc2j/ZVAkFFY1tOOvi56apy0D5bSbLc6YRBjhND+
         WXw8va9EmAT242Oc5aOd+xvJNOeDK3Ls9XR4f4JEPy/M8KwJ3Ixk+GPihpS+yao7ZrpK
         d+FCNGpT1F5fsc0bP4aNn4sEbNn7EYi8i9hlGVfYdZN7Y/Rp9GXqsRIWah+YLJE6Cpl7
         YGkz8sHY9Bdx1biY29nZLKLgEBCM8nXyoEiUvAU4O2XYc+N7qEwomZ/KHikBYMtnMeCM
         NToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mK//W8+alc6U2SRanqIfp5lLUuphqu6jqWQbXvYHju8=;
        b=L9PioKMX7x114aU6YZb9E2/KxbJqph13VukN7LwhGrRC7CWdZaAeYHOr0l14Ioe5rM
         HrkCJcaxQ/trzgh0f5BMw8X+eKHEpDzAk0CfO2oxB55jFRFyhxvbHHsu/3tp2Y+hfWu+
         Ycxv2XHKgVAmCsNixsWVXeiQdIr4pSrwNBf11N7HKboJt9+FP435kAq/59ezA/aaaxWq
         hJth6PtZmMSfEs5DEfSrCiMu7PaqFa6tFNGF2lBKpbYfyHosg6lOFeOfpri8oyBSr82G
         Pqm3mRp5S6PpyroRpdzPmlPCb7ELRI7FNo03cIWWjbE3DQR8g1Fn3dxS4EtGmY326TD4
         xScA==
X-Gm-Message-State: AJIora+AwXPZ2rzzTY/yo3dzuP8aeayjE2PpvyfE6zsbDG3gZieXO3Cx
        NNnqQvtIp37qkoyJidDrm8YvsM0qkMfx4RIfRAT3IA==
X-Google-Smtp-Source: AGRyM1u5HCt/E7YgbS4siTPjLChUt+KSYx6/jJ6HdGxCqmwqm/xwrh1hHxSTeT9pme5VcWkg9UjNJjUl3vG1LSDPFUs=
X-Received: by 2002:a25:bfc8:0:b0:664:a5a8:d518 with SMTP id
 q8-20020a25bfc8000000b00664a5a8d518mr25666775ybm.625.1655732418326; Mon, 20
 Jun 2022 06:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <cfc1744f4a5eb6f50eddee53238af1a2fb4e8583.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cfc1744f4a5eb6f50eddee53238af1a2fb4e8583.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:42 +0200
Message-ID: <CANpmjNNKKUkxOnOQBf5EZ3kCMv_wqd0V74R5Rx8K1+MhbXmSJQ@mail.gmail.com>
Subject: Re: [PATCH 05/32] kasan: drop CONFIG_KASAN_TAGS_IDENTIFY
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
> Drop CONFIG_KASAN_TAGS_IDENTIFY and related code to simplify making
> changes to the reporting code.
>
> The dropped functionality will be restored in the following patches in
> this series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/Kconfig.kasan      |  8 --------
>  mm/kasan/kasan.h       | 12 +-----------
>  mm/kasan/report_tags.c | 28 ----------------------------
>  mm/kasan/tags.c        | 21 ++-------------------
>  4 files changed, 3 insertions(+), 66 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index f0973da583e0..ca09b1cf8ee9 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -167,14 +167,6 @@ config KASAN_STACK
>           as well, as it adds inline-style instrumentation that is run
>           unconditionally.
>
> -config KASAN_TAGS_IDENTIFY
> -       bool "Memory corruption type identification"
> -       depends on KASAN_SW_TAGS || KASAN_HW_TAGS
> -       help
> -         Enables best-effort identification of the bug types (use-after-free
> -         or out-of-bounds) at the cost of increased memory consumption.
> -         Only applicable for the tag-based KASAN modes.
> -
>  config KASAN_VMALLOC
>         bool "Check accesses to vmalloc allocations"
>         depends on HAVE_ARCH_KASAN_VMALLOC
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 610057e651d2..aa6b43936f8d 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -168,23 +168,13 @@ struct kasan_track {
>         depot_stack_handle_t stack;
>  };
>
> -#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
> -#define KASAN_NR_FREE_STACKS 5
> -#else
> -#define KASAN_NR_FREE_STACKS 1
> -#endif
> -
>  struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>         /* Generic mode stores free track in kasan_free_meta. */
>  #ifdef CONFIG_KASAN_GENERIC
>         depot_stack_handle_t aux_stack[2];
>  #else
> -       struct kasan_track free_track[KASAN_NR_FREE_STACKS];
> -#endif
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
> -       u8 free_track_idx;
> +       struct kasan_track free_track;
>  #endif
>  };
>
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index e25d2166e813..35cf3cae4aa4 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -5,37 +5,9 @@
>   */
>
>  #include "kasan.h"
> -#include "../slab.h"
>
>  const char *kasan_get_bug_type(struct kasan_report_info *info)
>  {
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       struct kasan_alloc_meta *alloc_meta;
> -       struct kmem_cache *cache;
> -       struct slab *slab;
> -       const void *addr;
> -       void *object;
> -       u8 tag;
> -       int i;
> -
> -       tag = get_tag(info->access_addr);
> -       addr = kasan_reset_tag(info->access_addr);
> -       slab = kasan_addr_to_slab(addr);
> -       if (slab) {
> -               cache = slab->slab_cache;
> -               object = nearest_obj(cache, slab, (void *)addr);
> -               alloc_meta = kasan_get_alloc_meta(cache, object);
> -
> -               if (alloc_meta) {
> -                       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> -                               if (alloc_meta->free_pointer_tag[i] == tag)
> -                                       return "use-after-free";
> -                       }
> -               }
> -               return "out-of-bounds";
> -       }
> -#endif
> -
>         /*
>          * If access_size is a negative number, then it has reason to be
>          * defined as out-of-bounds bug type.
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 1ba3c8399f72..e0e5de8ce834 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -30,39 +30,22 @@ void kasan_save_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> -       u8 idx = 0;
>
>         alloc_meta = kasan_get_alloc_meta(cache, object);
>         if (!alloc_meta)
>                 return;
>
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       idx = alloc_meta->free_track_idx;
> -       alloc_meta->free_pointer_tag[idx] = tag;
> -       alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> -#endif
> -
> -       kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> +       kasan_set_track(&alloc_meta->free_track, GFP_NOWAIT);
>  }
>
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> -       int i = 0;
>
>         alloc_meta = kasan_get_alloc_meta(cache, object);
>         if (!alloc_meta)
>                 return NULL;
>
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> -               if (alloc_meta->free_pointer_tag[i] == tag)
> -                       break;
> -       }
> -       if (i == KASAN_NR_FREE_STACKS)
> -               i = alloc_meta->free_track_idx;
> -#endif
> -
> -       return &alloc_meta->free_track[i];
> +       return &alloc_meta->free_track;
>  }
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/cfc1744f4a5eb6f50eddee53238af1a2fb4e8583.1655150842.git.andreyknvl%40google.com.
