Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B9247B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhLTVi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhLTViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:38:55 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A323C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:38:55 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id k21so15149711ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXmZ+qTH7fz9THsh6sRW8Beptw0SkxxLv33cz0RQxd4=;
        b=UTnVYe+GGThhIyDprEn2wZxqDP8Z8xBG/uLPp6XFIAwW/suw6+1ow5LRtu+Pg6xcDT
         0ZriIG8pD3L6q8OKmD3XhK08zCmLCxXwzPDTZjEaebPrXyHNRYYIQ5F1vp92FdEPkX0O
         qTuHVrqJTWm/flACUWoG8zNAYX/DH01bPhEF3R+1SC7TlqiqOlYgzPqlsa7+MuJsxlVW
         /b5vlapxs8iLpdFEIbwyZ5vKAla5BG74+5wq85yBVU9VNbZlqGU/9oHc5vuZqDD2JObC
         q1SCUCRdxBP3SCOSn85B5ga/PZeW2zYhlzCQ/HEoT3tbFNayjSvgFCTE6aLKJ24oA39l
         7EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXmZ+qTH7fz9THsh6sRW8Beptw0SkxxLv33cz0RQxd4=;
        b=saruAwS7CO0CGYeJVOAMRQkzB1IntvpLd4Clovnqr75jr4ZC36qD2b9wJ+5sisPifM
         PQL3loxpTbAeSAbjLC/dph+3shaL3DkpvMO1/+z1nTk+Im1nTQ6iuoSQmIdN88megPrS
         SuQL6PRH/dqVSMq125GqtGFWc0HjoK0JGMXtHKRJlf68Vix0rJxYydZ3ocHyB4jiv7VC
         xTEb//zwH7scL/OXC2WS68QChYsipOLq724mt+ri3sjf9wRN9VMIDndEGFk7+ptVe11F
         DCQpbWAlgX1SvKzHiMng8Gtj7b5Kn8MKqKsrMAKyWweqDHmXc+K07AVDb3CcddfYFdMS
         7GfA==
X-Gm-Message-State: AOAM5304ZB/ikySYv34d7Er7Rqp7qSZIO0QFzQYPgvuIfeTD40MhjlT0
        1iDFqZ/9+W8TmWmRLUuAhxyesfDqZ+QZsR0FO+4=
X-Google-Smtp-Source: ABdhPJxeyUmnDdbXsgknOTn/FLvRFgBHRyYMqPetQbqBWRZhXny15fWy7BL16oR/ZDRe+WVEIdyrjNidsqhGx2LWSXg=
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr104863jat.22.1640036334760;
 Mon, 20 Dec 2021 13:38:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <d91e501aef74c5bb924cae90b469ff0dc1d56488.1639432170.git.andreyknvl@google.com>
 <YbjQNdst07JqbG0j@arm.com> <CA+fCnZftd93rARJ+xpUApimkgTsN0RRmiSVnrUMkCvdSu4-tcA@mail.gmail.com>
 <YbjwN0YlDV4hm3x6@arm.com>
In-Reply-To: <YbjwN0YlDV4hm3x6@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 20 Dec 2021 22:38:43 +0100
Message-ID: <CA+fCnZfmiqpnX-754Tqes6prNccG+cMzMEteqr+Ar8gM1RTjDg@mail.gmail.com>
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

On Tue, Dec 14, 2021 at 8:27 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Dec 14, 2021 at 07:27:09PM +0100, Andrey Konovalov wrote:
> > On Tue, Dec 14, 2021 at 6:11 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, Dec 13, 2021 at 10:54:21PM +0100, andrey.konovalov@linux.dev wrote:
> > > > diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> > > > index b9185503feae..3d35adf365bf 100644
> > > > --- a/arch/arm64/include/asm/vmalloc.h
> > > > +++ b/arch/arm64/include/asm/vmalloc.h
> > > > @@ -25,4 +25,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
> > > >
> > > >  #endif
> > > >
> > > > +#define arch_vmalloc_pgprot_modify arch_vmalloc_pgprot_modify
> > > > +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> > > > +{
> > > > +     if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
> > > > +                     (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)))
> > > > +             prot = pgprot_tagged(prot);
> > > > +
> > > > +     return prot;
> > > > +}
> > > > +
> > > >  #endif /* _ASM_ARM64_VMALLOC_H */
> > > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > > index 28becb10d013..760caeedd749 100644
> > > > --- a/include/linux/vmalloc.h
> > > > +++ b/include/linux/vmalloc.h
> > > > @@ -115,6 +115,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
> > > >  }
> > > >  #endif
> > > >
> > > > +#ifndef arch_vmalloc_pgprot_modify
> > > > +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> > > > +{
> > > > +     return prot;
> > > > +}
> > > > +#endif
> > > > +
> > > >  /*
> > > >   *   Highlevel APIs for driver use
> > > >   */
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 837ed355bfc6..58bd2f7f86d7 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3060,6 +3060,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > > >               return NULL;
> > > >       }
> > > >
> > > > +     prot = arch_vmalloc_pgprot_modify(prot);
> > > > +
> > > >       if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
> > > >               unsigned long size_per_node;
> > >
> > > I wonder whether we could fix the prot bits in the caller instead and we
> > > won't need to worry about the exec or the module_alloc() case. Something
> > > like:
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index d2a00ad4e1dd..4e8c61255b92 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3112,7 +3112,7 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
> > >                             gfp_t gfp_mask, int node, const void *caller)
> > >  {
> > >         return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> > > -                               gfp_mask, PAGE_KERNEL, 0, node, caller);
> > > +                       gfp_mask, pgprot_hwasan(PAGE_KERNEL), 0, node, caller);
> > >  }
> > >  /*
> > >   * This is only for performance analysis of vmalloc and stress purpose.
> > > @@ -3161,7 +3161,7 @@ EXPORT_SYMBOL(vmalloc);
> > >  void *vmalloc_no_huge(unsigned long size)
> > >  {
> > >         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > > -                                   GFP_KERNEL, PAGE_KERNEL, VM_NO_HUGE_VMAP,
> > > +                                   GFP_KERNEL, pgprot_hwasan(PAGE_KERNEL), VM_NO_HUGE_VMAP,
> > >                                     NUMA_NO_NODE, __builtin_return_address(0));
> > >  }
> > >  EXPORT_SYMBOL(vmalloc_no_huge);
> > >
> > > with pgprot_hwasan() defined to pgprot_tagged() only if KASAN_HW_TAGS is
> > > enabled.
> >
> > And also change kasan_unpoison_vmalloc() to tag only if
> > pgprot_tagged() has been applied, I assume.
> >
> > Hm. Then __vmalloc_node_range() callers will never get tagged memory
> > unless requested. I suppose that's OK, most of them untag the pointer
> > anyway.
> >
> > But this won't work for SW_TAGS mode, which is also affected by the
> > exec issue and needs those kasan_reset_tag()s in module_alloc()/BPF.
> > We could invent some virtual protection bit for it and reuse
> > pgprot_hwasan(). Not sure if this would be acceptable.
>
> Ah, a pgprot_hwasan() for the sw tags is probably not acceptable as this
> requires an unnecessary pte bit. An alternative could be a GFP flag that
> gets passed only from __vmalloc_node() etc.

This will still leave the BPF JIT special case though.

So I'm leaning towards keeping my approach.

Thanks!
