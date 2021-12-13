Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9FB472E69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhLMOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhLMOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACF9EB80EFF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC50C34603
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639404127;
        bh=f/j742BUMo0QU9baS+yWgKBmRVntjzG99e6tjqBEtqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E/3w25C3E4nPRXqIFtG8aFk+koyzXySpeMfcpyhWuint/qzSlOsibK5v4vBCorz0R
         HtGrJIrCj6j86pCX8d2KEf0iKx+N6ngqk3IZ1t3TdL4t7brU+zWTxXdxy9yVfVBky5
         l4qSznVHzh1g9tV3DaxH2ePXbror20+etHa92EtpM2FcygxUbYorOXR16AVymmJ74g
         SP0vk2rbVc4TLRQh0QM9CXSA7xHsHHM/TV71RNszt6b2njTwgwQ62BFxPt15d/FO3o
         LRUsFUKlWsEiu8tpXBdSnJ3RbGksJMjs2R6MbI008nabgnOO038cfL4U6or34dSVm4
         /3fRX7mxNzAbA==
Received: by mail-oo1-f48.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so4200743oog.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:02:07 -0800 (PST)
X-Gm-Message-State: AOAM5329B69BR1hXMJcValYGhrQfOc6pWtP9qelhc7bEIauq2DaAS57k
        PPaqtOP2IsNhON+uVlEuwPFkR8iRffQCqTgFaSM=
X-Google-Smtp-Source: ABdhPJz+QkBo80K8nuAF1icHCzWOFgzDxeHuSiVnAaQ4GJAYqVrQJZfPTh6t3FLdvQfX++BzUlGiGCCW7LQDZWj5H3Q=
X-Received: by 2002:a05:6820:30b:: with SMTP id l11mr19558661ooe.32.1639404126737;
 Mon, 13 Dec 2021 06:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20211210095432.51798-1-jianyong.wu@arm.com> <1e63e2f7-0563-2866-4665-84fe220b615f@arm.com>
 <CAMj1kXF3Kf_OP-EL6oRfstw6VdEaqowVPioABxfMv+1FnPvfew@mail.gmail.com> <20211213134503.GD11570@willie-the-truck>
In-Reply-To: <20211213134503.GD11570@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Dec 2021 15:01:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH0qTEiUyJLxr8YJhpWc_iLCN9-30KD_WTyUfKga9O3YA@mail.gmail.com>
Message-ID: <CAMj1kXH0qTEiUyJLxr8YJhpWc_iLCN9-30KD_WTyUfKga9O3YA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud mapping
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gavin Shan <gshan@redhat.com>, Jia He <justin.he@arm.com>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 14:45, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Dec 13, 2021 at 11:35:16AM +0100, Ard Biesheuvel wrote:
> > On Mon, 13 Dec 2021 at 11:16, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> > > On 12/10/21 3:24 PM, Jianyong Wu wrote:
> > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > index acfae9b41cc8..98ac09ae9588 100644
> > > > --- a/arch/arm64/mm/mmu.c
> > > > +++ b/arch/arm64/mm/mmu.c
> > > > @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> > > >  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> > > >
> > > >  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> > > > +static DEFINE_SPINLOCK(fixmap_lock);
> > > >
> > > >  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> > > >  {
> > > > @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> > > >       }
> > > >       BUG_ON(p4d_bad(p4d));
> > > >
> > > > +     /*
> > > > +      * fixmap is global resource, thus it needs to be protected by a lock
> > > > +      * in case of race condition.
> > > > +      */
> > >
> > > Small nit, format and align this comment block. I guess
> > > could also be done while merging this patch as well.
> > >
> > > > +     spin_lock(&fixmap_lock);
> > > >       pudp = pud_set_fixmap_offset(p4dp, addr);
> > > >       do {
> > > >               pud_t old_pud = READ_ONCE(*pudp);
> > > > @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> > > >       } while (pudp++, addr = next, addr != end);
> > > >
> > > >       pud_clear_fixmap();
> > > > +     spin_unlock(&fixmap_lock);
> > > >  }
> > > >
> > > >  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> > > >
> > >
> > > Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >
> > We have different fixmap slots for different page table levels, so
> > 'fixmap_lock' is not the right name.
> >
> > But we already have swapper_pgdir_lock as well, which serializes the
> > use of the pgdir level fixmap slot. And we have no spinlocks
> > protecting the other levels.
> >
> > So should we perhaps clean this up more comprehensively? Wouldn't it
> > be better to add a mutex to __create_pgd_mapping(), for instance?
>
> That does sound like a better way to do things, but the simplicity of this
> patch is quite attractive for backporting. Would you object to me queuing
> it as-is, on the premise that I'm more than happy to take consolidation
> changes on top?
>

No objections from me.
