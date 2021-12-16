Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF23477C37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhLPTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbhLPTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:21 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:08:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f20so232487qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LTFLzci/snq8/xtVRONsMSy0mihEg+vOqMAB8csECsE=;
        b=L8dy+Timm4f5E5Npe2DbOq9xzwGKpG1+4hQ6ygqKj09dycdC7VTgQxH7eFPTvFqbMQ
         j8Drp+Ale/C2YodVbTHikN5WV+R70LTmSr/TaULQZv2tOfHsSBStAi/shzWmGq2fuuct
         xbM4yVGWqQWk9IFeC5ezjhmZklCo6Z4wSE0ooVh/4T/WrsF62fPeqZOsbOpQ5Jxf03BT
         Bl8RvyWcTvKyYGQART9hRMY4GYpedFKrGTJqhUvBT4p7cFqgnNZcCu3kgk8nAKd7P0TJ
         as4cpHb3BXWj62lzbMD/v+ML5R2jWC/f5EZyKhWM1uaAs2ttHPKu/ZE1CYrSUoetjdG1
         DwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LTFLzci/snq8/xtVRONsMSy0mihEg+vOqMAB8csECsE=;
        b=kO1SK7VlyVF23QydlSX9djlLJBKfzkmlpJeVp+5Jn0MoYh+UJK2M0QqY9341oR3A+7
         nzWZUmI9IBdEf1AL2MCyebQFTlyjUdB1A8QXsXUh0wNVyV/qKT76g5+i0NfwVFrs5W7B
         5SUWI6JMMnQa+6RgQKD/poQilpDuDNURWNWCcZ6aKaruUCX0Uvw4zO0Del4ei4WvXX4s
         I7bsDcGWN73nJfoGYDpFReLLvU/2MkNS7V1ltoRiF7hnpMzH7KUdrypfZGNyJmNNshVh
         nK8jOvN4JmcPKLnDq2iAOfQsYRhwXt7jL1+Ac3gClDs1KKG65Hepsw8XIMgDWDVTp108
         BblA==
X-Gm-Message-State: AOAM531WoohPpiUMgFQTeK/BP/WRTAemZqC6z4BGGqi/sBBxJUNKSFem
        Ul3eEgVQ/wEd1n79YdKnJnWjIHrru/R7JNv5I0aVxg==
X-Google-Smtp-Source: ABdhPJzbHYLagr3JKwmmDyI7ccTWulHhGqeC5uq7UHzX5bZcjZqI6I7yvKpWKOzwK26WE+ezMiZBw3isoX34w8kBn+Y=
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr18754527qtk.492.1639681699782;
 Thu, 16 Dec 2021 11:08:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <1a2b5e3047faf05e5c11a9080c3f97a9b9b4c383.1639432170.git.andreyknvl@google.com>
In-Reply-To: <1a2b5e3047faf05e5c11a9080c3f97a9b9b4c383.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 20:07:43 +0100
Message-ID: <CAG_fn=UWe_wo+E1P-1RyTPRAaSqXcCbhEwLaU=SJ+7ueGSysEg@mail.gmail.com>
Subject: Re: [PATCH mm v3 26/38] kasan, vmalloc: don't unpoison VM_ALLOC pages
 before mapping
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Make KASAN unpoison vmalloc mappings after that have been mapped in
> when it's possible: for vmalloc() (indentified via VM_ALLOC) and
> vm_map_ram().

The subject says "don't unpoison VM_ALLOC pages", whereas the
description says "unpoison VM_ALLOC pages", or am I missing something?

> The reasons for this are:
>
> - For vmalloc() and vm_map_ram(): pages don't get unpoisoned in case
>   mapping them fails.
> - For vmalloc(): HW_TAGS KASAN needs pages to be mapped to set tags via
>   kasan_unpoison_vmalloc().
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v2->v3:
> - Update patch description.
> ---
>  mm/vmalloc.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 58bd2f7f86d7..9a6862e274df 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2208,14 +2208,15 @@ void *vm_map_ram(struct page **pages, unsigned in=
t count, int node)
>                 mem =3D (void *)addr;
>         }
>
> -       mem =3D kasan_unpoison_vmalloc(mem, size);
> -
>         if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
>                                 pages, PAGE_SHIFT) < 0) {
>                 vm_unmap_ram(mem, count);
>                 return NULL;
>         }
>
> +       /* Mark the pages as accessible after they were mapped in. */
> +       mem =3D kasan_unpoison_vmalloc(mem, size);
> +
>         return mem;
>  }
>  EXPORT_SYMBOL(vm_map_ram);
> @@ -2443,7 +2444,14 @@ static struct vm_struct *__get_vm_area_node(unsign=
ed long size,
>
>         setup_vmalloc_vm(area, va, flags, caller);
>
> -       area->addr =3D kasan_unpoison_vmalloc(area->addr, requested_size)=
;
> +       /*
> +        * For VM_ALLOC mappings, __vmalloc_node_range() mark the pages a=
s
> +        * accessible after they are mapped in.
> +        * Otherwise, as the pages can be mapped outside of vmalloc code,
> +        * mark them now as a best-effort approach.
> +        */
> +       if (!(flags & VM_ALLOC))
> +               area->addr =3D kasan_unpoison_vmalloc(area->addr, request=
ed_size);
>
>         return area;
>  }
> @@ -3104,6 +3112,12 @@ void *__vmalloc_node_range(unsigned long size, uns=
igned long align,
>         if (!addr)
>                 goto fail;
>
> +       /*
> +        * Mark the pages for VM_ALLOC mappings as accessible after they =
were
> +        * mapped in.
> +        */
> +       addr =3D kasan_unpoison_vmalloc(addr, real_size);
> +
>         /*
>          * In this function, newly allocated vm_struct has VM_UNINITIALIZ=
ED
>          * flag. It means that vm_struct is not fully initialized.
> @@ -3799,7 +3813,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigne=
d long *offsets,
>         }
>         spin_unlock(&vmap_area_lock);
>
> -       /* mark allocated areas as accessible */
> +       /*
> +        * Mark allocated areas as accessible.
> +        * As the pages are mapped outside of vmalloc code,
> +        * mark them now as a best-effort approach.
> +        */
>         for (area =3D 0; area < nr_vms; area++)
>                 vms[area]->addr =3D kasan_unpoison_vmalloc(vms[area]->add=
r,
>                                                          vms[area]->size)=
;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/1a2b5e3047faf05e5c11a9080c3f97a9b9b4c383.1639432170.git.andreyk=
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
