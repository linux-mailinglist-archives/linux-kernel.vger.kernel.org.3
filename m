Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF55F474ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhLNS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhLNS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:24 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C417C06179B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:27:20 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 14so25714029ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNu0JL6HpXjcm/zqB+v+1VOlm3E56pclkPSbwxcr2Ow=;
        b=g+76lc8hdBu0PzgZRXmfywDhm6CmfwRyPpztWb3ehzMsQVZryfHbQ65smWfKWvjLV+
         bRLehcroz2fYcBHTaTQ3UAWtXmNyz30oaPbUeUUscq7Y7GjJenQqsa0FgnNI/CBeOamD
         eB+tz/4Veqlhu7sYEt2yhV+Pj70eFvCbgQF+d9lVgJ+xRWpDfBFuve6qn9dr7zIQ3JZr
         5d0LCuicnyjz/nofZTxjyUKkPGfUhD0hqd7N2sxAaqHlAJKNtjflQjTDc/upu6mkjtBv
         jTK6HovB1zqh10pWY8qOuBXIkbCTeH271F/itffgHUif/pFq14KEKrW3LyxeiJYpj3i5
         cneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNu0JL6HpXjcm/zqB+v+1VOlm3E56pclkPSbwxcr2Ow=;
        b=poxLRYd7UwqAnWqBJArUWRR9zD07jaBVlKPboLAcG3szd9xcawJwm7fuIoTKFouYnn
         43Ctcol0DFD4OD/QGjGISIJ8OL5jFPmoq5CJvyYw9SIYWTpBLpE+qRdGZeOLrmfxxaS7
         ZzNJat1axcUXv0enzJ23bnEkEA9cXmGq+AFn4Rj/aFE9ncqXRtEIgMe6KstNN8C++Rhq
         o06tplL7ORUcuFmOzyVbpU6ZsROslpxPDmcXwjz5PpNtc0IBbtTGXTc20ysWwuPnS/BO
         Cjx05RGfTMeLLrCJo/F7Ggv9OW51yL5GIu7L3UYYgcINaPL5IuqzCDvL4Yotg2XaLXmL
         hjew==
X-Gm-Message-State: AOAM5333D1pCR+qY+AacQL7VUH/HXVZm0u2GYKRB9d9cBcSi3k4nGTP6
        pELJ7oFn1Co+w132c56cpAtKl+YTm2kZXkpKPFY=
X-Google-Smtp-Source: ABdhPJxb65V1u0Oh6yhMDoDv7bRWesVCxN2AGcyrCGq1JoOJ/QBqXadCHAN4ak6mF43E0irJoUU64AuaW1IrOVj3VE4=
X-Received: by 2002:a02:c04d:: with SMTP id u13mr3876471jam.524.1639506439659;
 Tue, 14 Dec 2021 10:27:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <d91e501aef74c5bb924cae90b469ff0dc1d56488.1639432170.git.andreyknvl@google.com>
 <YbjQNdst07JqbG0j@arm.com>
In-Reply-To: <YbjQNdst07JqbG0j@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 14 Dec 2021 19:27:09 +0100
Message-ID: <CA+fCnZftd93rARJ+xpUApimkgTsN0RRmiSVnrUMkCvdSu4-tcA@mail.gmail.com>
Subject: Re: [PATCH mm v3 25/38] kasan, vmalloc, arm64: mark vmalloc mappings
 as pgprot_tagged
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 6:11 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Dec 13, 2021 at 10:54:21PM +0100, andrey.konovalov@linux.dev wrote:
> > diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> > index b9185503feae..3d35adf365bf 100644
> > --- a/arch/arm64/include/asm/vmalloc.h
> > +++ b/arch/arm64/include/asm/vmalloc.h
> > @@ -25,4 +25,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
> >
> >  #endif
> >
> > +#define arch_vmalloc_pgprot_modify arch_vmalloc_pgprot_modify
> > +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> > +{
> > +     if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
> > +                     (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)))
> > +             prot = pgprot_tagged(prot);
> > +
> > +     return prot;
> > +}
> > +
> >  #endif /* _ASM_ARM64_VMALLOC_H */
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 28becb10d013..760caeedd749 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -115,6 +115,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
> >  }
> >  #endif
> >
> > +#ifndef arch_vmalloc_pgprot_modify
> > +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> > +{
> > +     return prot;
> > +}
> > +#endif
> > +
> >  /*
> >   *   Highlevel APIs for driver use
> >   */
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 837ed355bfc6..58bd2f7f86d7 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3060,6 +3060,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >               return NULL;
> >       }
> >
> > +     prot = arch_vmalloc_pgprot_modify(prot);
> > +
> >       if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
> >               unsigned long size_per_node;
>
> I wonder whether we could fix the prot bits in the caller instead and we
> won't need to worry about the exec or the module_alloc() case. Something
> like:
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..4e8c61255b92 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3112,7 +3112,7 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
>                             gfp_t gfp_mask, int node, const void *caller)
>  {
>         return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> -                               gfp_mask, PAGE_KERNEL, 0, node, caller);
> +                       gfp_mask, pgprot_hwasan(PAGE_KERNEL), 0, node, caller);
>  }
>  /*
>   * This is only for performance analysis of vmalloc and stress purpose.
> @@ -3161,7 +3161,7 @@ EXPORT_SYMBOL(vmalloc);
>  void *vmalloc_no_huge(unsigned long size)
>  {
>         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -                                   GFP_KERNEL, PAGE_KERNEL, VM_NO_HUGE_VMAP,
> +                                   GFP_KERNEL, pgprot_hwasan(PAGE_KERNEL), VM_NO_HUGE_VMAP,
>                                     NUMA_NO_NODE, __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(vmalloc_no_huge);
>
> with pgprot_hwasan() defined to pgprot_tagged() only if KASAN_HW_TAGS is
> enabled.

And also change kasan_unpoison_vmalloc() to tag only if
pgprot_tagged() has been applied, I assume.

Hm. Then __vmalloc_node_range() callers will never get tagged memory
unless requested. I suppose that's OK, most of them untag the pointer
anyway.

But this won't work for SW_TAGS mode, which is also affected by the
exec issue and needs those kasan_reset_tag()s in module_alloc()/BPF.
We could invent some virtual protection bit for it and reuse
pgprot_hwasan(). Not sure if this would be acceptable.
