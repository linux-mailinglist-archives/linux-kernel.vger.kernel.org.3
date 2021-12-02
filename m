Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9794666E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbhLBPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhLBPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:44:22 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945EFC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:40:58 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t6so309307qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ze4OYA4kCMJmMvK5z2d/7YkRmJBRmguQKYCL2ja2UL4=;
        b=pa2nCnfcRmkfZILR1cKeKiXikJJYJxwm6pPDIZkUI9fIsp0wzT4DJPsBWQ+c1tjVZi
         HxIeTB5eh/Z0o+Nj7imU/f5ZFLK7xUn5IGWQoc/NRCLyXTC1ykJ8PyrN0+cmHM7wke3o
         MWHZwLYvzVsPm7zCf5WUdNRPx7nancl1Hp2WLnXAT1fLs178a0VOTJtoXbN30ppfuKoN
         mvE1qkW0UprQ50X7XWTbAafs5zJda+F/N9WKyIVOwo2VXVJfVnB2dV3MNAqE0seXEv1n
         qTA1pnu5NsVDmW0T91pNKwdD35lBrI/Gix8wUJdWrpLC5uZoM3Y/ccF7piLjffSmNOPs
         qeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ze4OYA4kCMJmMvK5z2d/7YkRmJBRmguQKYCL2ja2UL4=;
        b=RuBo+s66Cxn4J4PjBcr7Pld2E2QGGvgDDJym1pomI2IEtd/vRqfLZ2QyF/N9YlDHW1
         D1QbUd1ppcrKMKhe8uFEpdyDzt6/bMB9wECWdHbTKcHnyKcx4EcWvXeKkWx2CRhKxLGl
         piv4s4MN2CmDHwd8exlqri1HYn9419SGlVjCRm+Q30yLcy/F5NjfcT1OECccc4vixJSM
         z7QeOo3DAiiTN7c7BHKKhrY2/fS0ZkhJjEaXFfAFaN6lgqfc7dhxXssKdxpxRSIoxBaM
         hhA1bXpZd6wn6Eg9kfmufg6SNTMOg3V7K1SlCOeyneoXQH/SQUKvCckuZvRMS6MihBc9
         uPjg==
X-Gm-Message-State: AOAM5335Q8Hj567WwZOv6LXpMQlxCor4CzxZa3qpLYY1RfT7da9TGzGA
        gokwC7dYuAwEqs0rGp7wnkgaf7rz3YyBojQ1Pfrj2w==
X-Google-Smtp-Source: ABdhPJwBy5Lmy0e4kFoPzEN++JCwpVABcIGXZw+uIkDEYR9B+YQxC7M1jL4oBMaNz8BbheiS7ZjNinJ1WJCaDQT6kYQ=
X-Received: by 2002:a05:620a:d84:: with SMTP id q4mr13046469qkl.610.1638459657279;
 Thu, 02 Dec 2021 07:40:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <938a827f9927ee2112d98e2053ad7764aae9d8f8.1638308023.git.andreyknvl@google.com>
In-Reply-To: <938a827f9927ee2112d98e2053ad7764aae9d8f8.1638308023.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Dec 2021 16:40:21 +0100
Message-ID: <CAG_fn=WRKRUskUrN1wb20gv2nLF-DOPBF5aDAg+q+sFKczDw1Q@mail.gmail.com>
Subject: Re: [PATCH 07/31] kasan: only apply __GFP_ZEROTAGS when memory is zeroed
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
> __GFP_ZEROTAGS should only be effective if memory is being zeroed.
> Currently, hardware tag-based KASAN violates this requirement.
>
> Fix by including an initialization check along with checking for
> __GFP_ZEROTAGS.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kasan/hw_tags.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 0b8225add2e4..c643740b8599 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -199,11 +199,12 @@ void kasan_alloc_pages(struct page *page, unsigned =
int order, gfp_t flags)
>          * page_alloc.c.
>          */
>         bool init =3D !want_init_on_free() && want_init_on_alloc(flags);
> +       bool init_tags =3D init && (flags & __GFP_ZEROTAGS);
>
>         if (flags & __GFP_SKIP_KASAN_POISON)
>                 SetPageSkipKASanPoison(page);
>
> -       if (flags & __GFP_ZEROTAGS) {
> +       if (init_tags) {
>                 int i;
>
>                 for (i =3D 0; i !=3D 1 << order; ++i)
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
