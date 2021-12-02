Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A444466684
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbhLBPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347852AbhLBPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:36:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427E4C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:32:50 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id q14so36621qtx.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=evmGFi4x3OMEuAhoToZgbOGTd3Zzv0LAm/HoRCUBdXY=;
        b=dnoa81zGRMKX+fxgR59mxyYQdxdpV6Qj1lFXnDFyeJ3d1kJcXt1fJv+8OVT5vOB+P7
         dr5L7dJ/iKrcNwJrsvsHrk1BmjWE1g0DPb5Ris9uf/vvDcmbfIpefH8STyaPDbP0bPNT
         KZMxKP3nuw1Im+kS9zQkLV+XDvWSLtVcb5Gg13ALxW98jnUILNesY17smnjq7CF4oPiD
         jBq3K+vgx5jVRdo+iVjbmGw8wcZpIPaofJvqhkHO8Ngw4xpBzDgxYA2F6mmVSheVg1I7
         H/vClpYyvHGDh3FYRoTFPsP+k/WDtvjh7OKadojpMhwySoxYPb/2eG03TzlHQcFyb1ah
         Xm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=evmGFi4x3OMEuAhoToZgbOGTd3Zzv0LAm/HoRCUBdXY=;
        b=YllZcOC7rS9Ea36ohTK8gPfGUW9O9ms5sROR2uVh43lgPTzlGB63dHGn9dlRwHX3oN
         JRIHWexeWzGTl5rXPs78jJNf2G2e0Uhg+1Jvn8nc1ia2f9acOgYRLmIPKn81V+MkMETU
         82Hik8h49Z+kyvpEjiZ93s6YLqbK6jQ/VkBFBZJ6V2rreolq55Pa/JdVteO3VW57CNiz
         GTw/aNhuMlhYamgqvooywIKIr0vpvHI2FGFyknnFu/kgWVXndKoqJsBXOolzD3SkqxdS
         s+raElXUR0h1fcgcVcUEsbzpd7AxpoJ5HUffZJ9RscjxUPgcq96cyhUgmFJ6On8iwd46
         aVZA==
X-Gm-Message-State: AOAM533vSfo+rqjv+zRDOjNqJFiyAVz8AV+UGFCv0Gpgjmxyt97T4/sL
        vsU46xgjESK4Zaw5nWD36n+xzTNyjIpLA5BesWEXgw==
X-Google-Smtp-Source: ABdhPJxz3J2eijtJeTTJv1U94XJcpSfqGPlThSRton8V221yobaPgqr5L2B0Y28tNd/+wr09cEmnlOziw+BbN1/bEhQ=
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr14623476qtk.492.1638459169188;
 Thu, 02 Dec 2021 07:32:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <64f8b74a4766f886a6df77438e7e098205fd0863.1638308023.git.andreyknvl@google.com>
In-Reply-To: <64f8b74a4766f886a6df77438e7e098205fd0863.1638308023.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Dec 2021 16:32:12 +0100
Message-ID: <CAG_fn=V2PmihoVkyaNLJ2LMf4N1YsDJN1ZFbdsYecZdNHMdSpw@mail.gmail.com>
Subject: Re: [PATCH 03/31] kasan, page_alloc: merge kasan_free_pages into free_pages_prepare
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:40 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Currently, the code responsible for initializing and poisoning memory
> in free_pages_prepare() is scattered across two locations:
> kasan_free_pages() for HW_TAGS KASAN and free_pages_prepare() itself.
> This is confusing.
>
> This and a few following patches combine the code from these two
> locations. Along the way, these patches also simplify the performed
> checks to make them easier to follow.
>
> This patch replaces the only caller of kasan_free_pages() with its
> implementation.
>
> As kasan_has_integrated_init() is only true when CONFIG_KASAN_HW_TAGS
> is enabled, moving the code does no functional changes.
>
> This patch is not useful by itself but makes the simplifications in
> the following patches easier to follow.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  include/linux/kasan.h |  8 --------
>  mm/kasan/common.c     |  2 +-
>  mm/kasan/hw_tags.c    | 11 -----------
>  mm/page_alloc.c       |  6 ++++--
>  4 files changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d8783b682669..89a43d8ae4fe 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -95,7 +95,6 @@ static inline bool kasan_hw_tags_enabled(void)
>  }
>
>  void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flag=
s);
> -void kasan_free_pages(struct page *page, unsigned int order);
>
>  #else /* CONFIG_KASAN_HW_TAGS */
>
> @@ -116,13 +115,6 @@ static __always_inline void kasan_alloc_pages(struct=
 page *page,
>         BUILD_BUG();
>  }
>
> -static __always_inline void kasan_free_pages(struct page *page,
> -                                            unsigned int order)
> -{
> -       /* Only available for integrated init. */
> -       BUILD_BUG();
> -}
> -
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
>  static inline bool kasan_has_integrated_init(void)
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8428da2aaf17..66078cc1b4f0 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -387,7 +387,7 @@ static inline bool ____kasan_kfree_large(void *ptr, u=
nsigned long ip)
>         }
>
>         /*
> -        * The object will be poisoned by kasan_free_pages() or
> +        * The object will be poisoned by kasan_poison_pages() or
>          * kasan_slab_free_mempool().
>          */
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 7355cb534e4f..0b8225add2e4 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -213,17 +213,6 @@ void kasan_alloc_pages(struct page *page, unsigned i=
nt order, gfp_t flags)
>         }
>  }
>
> -void kasan_free_pages(struct page *page, unsigned int order)
> -{
> -       /*
> -        * This condition should match the one in free_pages_prepare() in
> -        * page_alloc.c.
> -        */
> -       bool init =3D want_init_on_free();
> -
> -       kasan_poison_pages(page, order, init);
> -}
> -
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>
>  void kasan_enable_tagging_sync(void)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589333b5b77..3f3ea41f8c64 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1353,15 +1353,17 @@ static __always_inline bool free_pages_prepare(st=
ruct page *page,
>
>         /*
>          * As memory initialization might be integrated into KASAN,
> -        * kasan_free_pages and kernel_init_free_pages must be
> +        * KASAN poisoning and memory initialization code must be
>          * kept together to avoid discrepancies in behavior.
>          *
>          * With hardware tag-based KASAN, memory tags must be set before =
the
>          * page becomes unavailable via debug_pagealloc or arch_free_page=
.
>          */
>         if (kasan_has_integrated_init()) {
> +               bool init =3D want_init_on_free();
> +
>                 if (!skip_kasan_poison)
> -                       kasan_free_pages(page, order);
> +                       kasan_poison_pages(page, order, init);
>         } else {
>                 bool init =3D want_init_on_free();
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/64f8b74a4766f886a6df77438e7e098205fd0863.1638308023.git.andreyk=
nvl%40google.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
