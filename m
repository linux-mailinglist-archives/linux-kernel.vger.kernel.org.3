Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E535C474BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhLNT17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhLNT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:27:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:27:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B519616C2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174C0C34604;
        Tue, 14 Dec 2021 19:27:54 +0000 (UTC)
Date:   Tue, 14 Dec 2021 19:27:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
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
Subject: Re: [PATCH mm v3 25/38] kasan, vmalloc, arm64: mark vmalloc mappings
 as pgprot_tagged
Message-ID: <YbjwN0YlDV4hm3x6@arm.com>
References: <cover.1639432170.git.andreyknvl@google.com>
 <d91e501aef74c5bb924cae90b469ff0dc1d56488.1639432170.git.andreyknvl@google.com>
 <YbjQNdst07JqbG0j@arm.com>
 <CA+fCnZftd93rARJ+xpUApimkgTsN0RRmiSVnrUMkCvdSu4-tcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZftd93rARJ+xpUApimkgTsN0RRmiSVnrUMkCvdSu4-tcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:27:09PM +0100, Andrey Konovalov wrote:
> On Tue, Dec 14, 2021 at 6:11 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Dec 13, 2021 at 10:54:21PM +0100, andrey.konovalov@linux.dev wrote:
> > > diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> > > index b9185503feae..3d35adf365bf 100644
> > > --- a/arch/arm64/include/asm/vmalloc.h
> > > +++ b/arch/arm64/include/asm/vmalloc.h
> > > @@ -25,4 +25,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
> > >
> > >  #endif
> > >
> > > +#define arch_vmalloc_pgprot_modify arch_vmalloc_pgprot_modify
> > > +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> > > +{
> > > +     if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
> > > +                     (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)))
> > > +             prot = pgprot_tagged(prot);
> > > +
> > > +     return prot;
> > > +}
> > > +
> > >  #endif /* _ASM_ARM64_VMALLOC_H */
> > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > index 28becb10d013..760caeedd749 100644
> > > --- a/include/linux/vmalloc.h
> > > +++ b/include/linux/vmalloc.h
> > > @@ -115,6 +115,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
> > >  }
> > >  #endif
> > >
> > > +#ifndef arch_vmalloc_pgprot_modify
> > > +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> > > +{
> > > +     return prot;
> > > +}
> > > +#endif
> > > +
> > >  /*
> > >   *   Highlevel APIs for driver use
> > >   */
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 837ed355bfc6..58bd2f7f86d7 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3060,6 +3060,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > >               return NULL;
> > >       }
> > >
> > > +     prot = arch_vmalloc_pgprot_modify(prot);
> > > +
> > >       if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
> > >               unsigned long size_per_node;
> >
> > I wonder whether we could fix the prot bits in the caller instead and we
> > won't need to worry about the exec or the module_alloc() case. Something
> > like:
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d2a00ad4e1dd..4e8c61255b92 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3112,7 +3112,7 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
> >                             gfp_t gfp_mask, int node, const void *caller)
> >  {
> >         return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
> > -                               gfp_mask, PAGE_KERNEL, 0, node, caller);
> > +                       gfp_mask, pgprot_hwasan(PAGE_KERNEL), 0, node, caller);
> >  }
> >  /*
> >   * This is only for performance analysis of vmalloc and stress purpose.
> > @@ -3161,7 +3161,7 @@ EXPORT_SYMBOL(vmalloc);
> >  void *vmalloc_no_huge(unsigned long size)
> >  {
> >         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > -                                   GFP_KERNEL, PAGE_KERNEL, VM_NO_HUGE_VMAP,
> > +                                   GFP_KERNEL, pgprot_hwasan(PAGE_KERNEL), VM_NO_HUGE_VMAP,
> >                                     NUMA_NO_NODE, __builtin_return_address(0));
> >  }
> >  EXPORT_SYMBOL(vmalloc_no_huge);
> >
> > with pgprot_hwasan() defined to pgprot_tagged() only if KASAN_HW_TAGS is
> > enabled.
> 
> And also change kasan_unpoison_vmalloc() to tag only if
> pgprot_tagged() has been applied, I assume.
> 
> Hm. Then __vmalloc_node_range() callers will never get tagged memory
> unless requested. I suppose that's OK, most of them untag the pointer
> anyway.
> 
> But this won't work for SW_TAGS mode, which is also affected by the
> exec issue and needs those kasan_reset_tag()s in module_alloc()/BPF.
> We could invent some virtual protection bit for it and reuse
> pgprot_hwasan(). Not sure if this would be acceptable.

Ah, a pgprot_hwasan() for the sw tags is probably not acceptable as this
requires an unnecessary pte bit. An alternative could be a GFP flag that
gets passed only from __vmalloc_node() etc.

Otherwise your original approach works as well.

-- 
Catalin
