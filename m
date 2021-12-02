Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44041466671
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358957AbhLBP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347566AbhLBP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:28:55 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19866C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:25:33 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a11so179480qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OTX/WZkgF1pYK7eFLF3f7aWLqHA2vUJ/0VtDzBUjbo4=;
        b=PPgXGZVbb6SRg3/zNEAI0WNFcS0hZKvhenotWwSVpX2Z1SBSzLonZWYbTtG276BDIl
         I8PNS4FAApFYfk/QAM+4DuL/bv44snLd8kXKP7vL99SBKCxbb9A8K5AqXQayWrR8EqPn
         nbQWDslo5mrAy9taB0vf8a+ZHrX+TgqjMx9+Han0s9ohqmSGEVemzDSp1hu92Opkp9p4
         s5P4uMj3XkwPvUC3SMaGCMjKortElDqE+xMWad7MdA4C49jZymrXuWy+/j5SFWVDqdKF
         fFibY68XQdHONo4hllLFOpT4OEyepiQJIe6gGScJTjknVG1kJTyhE+ZcbzEA7PZluenF
         KlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OTX/WZkgF1pYK7eFLF3f7aWLqHA2vUJ/0VtDzBUjbo4=;
        b=S2NX7x4JkLM7G5fW9AZRen6NbyjORVM3VBSF96UiIoI4hrwxOaaGvcz1kGH5V0vtHX
         1dqUpbV+1l9FG4z6YLNT/q2svyDpUhPO96XN6nLGlcTQqcDQzDt+4y9pVlAT2f9vO46v
         4SE+mBgdqK7Sr82cUom6L1UhCIpnAPI/ThtNPzfyG+0KVmvre99/v77cBdwUQEl9zmC6
         yUL0604Ug5O3/uD2uaBi6jWdBgTsl14CUaDQ3ozHjSz85ZLOzVCa2KL5S6pAh5mndQda
         AW8Z7EGvEly7PcYQ+WTM/mmuceLQ/6Fg3aFI5SHDWxtlcjFX5+31Is8R1z6fY8pcHKt3
         3G7w==
X-Gm-Message-State: AOAM531f2ERu+TBE+56E7UnDxfrpPZk7KIWRTGU3QSAM8acPRYe75z9g
        Q8I7Nxy4y4tDvtZc9rFsOPRySdZg8rdtLQ71YViCjw==
X-Google-Smtp-Source: ABdhPJxikRNbxFEldmqXOONgbGRbB/mhWmugo/aWEnvF8f9TqA0PcSrbGSxTBmAV8cN6ugJILUMY7ahjJxpHPA6PZEY=
X-Received: by 2002:a05:620a:2955:: with SMTP id n21mr12547975qkp.581.1638458731912;
 Thu, 02 Dec 2021 07:25:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <e64fc8cd8e08fac044368aaba27be9fc6f60ff9c.1638308023.git.andreyknvl@google.com>
In-Reply-To: <e64fc8cd8e08fac044368aaba27be9fc6f60ff9c.1638308023.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Dec 2021 16:24:55 +0100
Message-ID: <CAG_fn=Uigry=Ou2Msw3DmmuytePji6wY-JkXrGk1YzP=5EzJeA@mail.gmail.com>
Subject: Re: [PATCH 02/31] kasan, page_alloc: move tag_clear_highpage out of kernel_init_free_pages
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
> Currently, kernel_init_free_pages() serves two purposes: either only
Nit: "it either"

> zeroes memory or zeroes both memory and memory tags via a different
> code path. As this function has only two callers, each using only one
> code path, this behaviour is confusing.
>
> This patch pulls the code that zeroes both memory and tags out of
> kernel_init_free_pages().
>
> As a result of this change, the code in free_pages_prepare() starts to
> look complicated, but this is improved in the few following patches.
> Those improvements are not integrated into this patch to make diffs
> easier to read.
>
> This patch does no functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/page_alloc.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c99566a3b67e..3589333b5b77 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1269,16 +1269,10 @@ static inline bool should_skip_kasan_poison(struc=
t page *page, fpi_t fpi_flags)
>                PageSkipKASanPoison(page);
>  }
>
> -static void kernel_init_free_pages(struct page *page, int numpages, bool=
 zero_tags)
> +static void kernel_init_free_pages(struct page *page, int numpages)
>  {
>         int i;
>
> -       if (zero_tags) {
> -               for (i =3D 0; i < numpages; i++)
> -                       tag_clear_highpage(page + i);
> -               return;
> -       }
> -
>         /* s390's use of memset() could override KASAN redzones. */
>         kasan_disable_current();
>         for (i =3D 0; i < numpages; i++) {
> @@ -1372,7 +1366,7 @@ static __always_inline bool free_pages_prepare(stru=
ct page *page,
>                 bool init =3D want_init_on_free();
>
>                 if (init)
> -                       kernel_init_free_pages(page, 1 << order, false);
> +                       kernel_init_free_pages(page, 1 << order);
>                 if (!skip_kasan_poison)
>                         kasan_poison_pages(page, order, init);
>         }
> @@ -2415,9 +2409,17 @@ inline void post_alloc_hook(struct page *page, uns=
igned int order,
>                 bool init =3D !want_init_on_free() && want_init_on_alloc(=
gfp_flags);
>
>                 kasan_unpoison_pages(page, order, init);
> -               if (init)
> -                       kernel_init_free_pages(page, 1 << order,
> -                                              gfp_flags & __GFP_ZEROTAGS=
);
> +
> +               if (init) {
> +                       if (gfp_flags & __GFP_ZEROTAGS) {
> +                               int i;
> +
> +                               for (i =3D 0; i < 1 << order; i++)
> +                                       tag_clear_highpage(page + i);
> +                       } else {
> +                               kernel_init_free_pages(page, 1 << order);
> +                       }
> +               }
>         }
>
>         set_page_owner(page, order, gfp_flags);
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/e64fc8cd8e08fac044368aaba27be9fc6f60ff9c.1638308023.git.andreyk=
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
