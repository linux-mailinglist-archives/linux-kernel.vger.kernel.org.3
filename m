Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734A04667B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359383AbhLBQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359368AbhLBQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:17:34 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9949DC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:14:11 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so25376320qvm.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ufkuMHJENZAKBVIrvseO49pb4ZFToj5htqXCloJEnks=;
        b=Crx2IVA+3FT3DarQIHnHUeky6f0sOi0uyQVyUV5jrn7dSPq4qJ6fXu1TKwVoYru9Mv
         lXERzjbX5xXWNbnnILttG3dn193EsWXLZU+iwq8aed71iJ4kfDnZAs/kHkymZ/1awlNM
         fLX7BBPZfZvUg+4KyrempOVuGI3KkIG5e7MJFZBCTU0owbK3Q3G4LQ028mXapsNvnrwW
         UZnA7ljZEzwMbHaKdFEWf8nFiRXq1SbVyAwDYZSJraplDwo9euYtP0sbGVvq68Gu1BQv
         hiWyGOYqTb7XSz2rF15AgUM8rQwFWgrv3qwj7y6R9FGxplJsVtxKxzUqkjfCNfAvLd6V
         KWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ufkuMHJENZAKBVIrvseO49pb4ZFToj5htqXCloJEnks=;
        b=lozg4XWx17P4r5NG1wfrgCpJw60NHySWYj77Im+hZR5qYXjtYmc3IlHwaPSQYjnSUi
         KEojZzmNB+DyUC7z+F3QkyEgAIk+AAe4nEdv7/UbB4UnsBoZ5QEZW7XOAbb4ortAInX8
         68jQrfJ2ml9NkZaI1LjTYlNVJXEmJK474Gd+pBssc2FeqKcUPjjVQfBTHNAaJ4R+dzK2
         YLaLjXhmxbdY4+tOkf8jqJXTWo+X3Bwe4IMIdHz24Eb30z8SLlbN+75Qw0P/e/Ionv5/
         eVyIjQHvZSVby3sWTas6oe75tbnK4/ibtqDdvJwVGTaU1GgX2PxM21QM9Mv9q+Xv7eOD
         IHbQ==
X-Gm-Message-State: AOAM533oDQpAsRmHj0DVXyaKfn4h41l9Qh66VDeYgJ6/7NDzmF5mD+9D
        ujY3xuNcTZuvUsRwvzb+P17TLwIIr4rmCOYsyBfCwQ==
X-Google-Smtp-Source: ABdhPJxjUOHGzUULmdGYRPeP5vFSn8K/NzY6SOtvNi1xDsFneFX5rAQN0TOn/uuP8WGVW+Aei30O7ewS4oTjFJjcah0=
X-Received: by 2002:a0c:8031:: with SMTP id 46mr14089905qva.126.1638461650530;
 Thu, 02 Dec 2021 08:14:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <984104c118a451fc4afa2eadb7206065f13b7af2.1638308023.git.andreyknvl@google.com>
In-Reply-To: <984104c118a451fc4afa2eadb7206065f13b7af2.1638308023.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Dec 2021 17:13:34 +0100
Message-ID: <CAG_fn=U71Yn-qCGMBR=_uOt0QCEu9skGzhgRBJjpkQCjZ=dKiA@mail.gmail.com>
Subject: Re: [PATCH 08/31] kasan, page_alloc: refactor init checks in post_alloc_hook
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

On Tue, Nov 30, 2021 at 10:41 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> This patch separates code for zeroing memory from the code clearing tags
> in post_alloc_hook().
>
> This patch is not useful by itself but makes the simplifications in
> the following patches easier to follow.
>
> This patch does no functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/page_alloc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ada09a58e4b..0561cdafce36 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2406,19 +2406,21 @@ inline void post_alloc_hook(struct page *page, un=
signed int order,
>                 kasan_alloc_pages(page, order, gfp_flags);
>         } else {
>                 bool init =3D !want_init_on_free() && want_init_on_alloc(=
gfp_flags);
> +               bool init_tags =3D init && (gfp_flags & __GFP_ZEROTAGS);
>
>                 kasan_unpoison_pages(page, order, init);
>
> -               if (init) {
> -                       if (gfp_flags & __GFP_ZEROTAGS) {
> -                               int i;
> +               if (init_tags) {
> +                       int i;
>
> -                               for (i =3D 0; i < 1 << order; i++)
> -                                       tag_clear_highpage(page + i);
> -                       } else {
> -                               kernel_init_free_pages(page, 1 << order);
> -                       }
> +                       for (i =3D 0; i < 1 << order; i++)
> +                               tag_clear_highpage(page + i);
> +
> +                       init =3D false;

I find this a bit twisted and prone to breakages.
Maybe just check for (init && !init_tags) below?
>                 }
> +
> +               if (init)
> +                       kernel_init_free_pages(page, 1 << order);
>         }
>
>         set_page_owner(page, order, gfp_flags);
> --
> 2.25.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
