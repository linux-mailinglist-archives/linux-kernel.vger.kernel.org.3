Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC0472DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhLMNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:45:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56874 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhLMNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:45:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2B460FF3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC9EC34601;
        Mon, 13 Dec 2021 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639403108;
        bh=91yVe1naGosE6KNTG6Oc+VHEYyMxHFTrdQmSPgcWi3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbxC2oCIfQeKo3kYgo2wl3ithsZJAwPeZZsS7N8sWga9fuPT9ocYgeiZSKOYqxtJD
         y0g7kGh67vnB4A90zLuUXZgnqSIR4yVa8fOVGM2QRgjFl26dkZHWwH+1z4uGToAkmp
         6Snw6uGZaxyQJPcfjqBZDaLL5ZVcNLQfYGL3cv1CsvEnPvkknWpIYngpyguHxckCxc
         o6UY/8J8ZvlBny/0Qenasg1tHfFpgvPHMB+tvYoJBTqZ3kr9woSdM/9rniweB92PMq
         uEYJjSqQ/ouAsABEB88jF3rYVcf86ztNk8pzVKbYM1YV19/ha7FmaxM5ZEEDITF+M9
         sDurvEPexN2OA==
Date:   Mon, 13 Dec 2021 13:45:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gavin Shan <gshan@redhat.com>, Jia He <justin.he@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <20211213134503.GD11570@willie-the-truck>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <1e63e2f7-0563-2866-4665-84fe220b615f@arm.com>
 <CAMj1kXF3Kf_OP-EL6oRfstw6VdEaqowVPioABxfMv+1FnPvfew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF3Kf_OP-EL6oRfstw6VdEaqowVPioABxfMv+1FnPvfew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:35:16AM +0100, Ard Biesheuvel wrote:
> On Mon, 13 Dec 2021 at 11:16, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > On 12/10/21 3:24 PM, Jianyong Wu wrote:
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index acfae9b41cc8..98ac09ae9588 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> > >  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> > >
> > >  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> > > +static DEFINE_SPINLOCK(fixmap_lock);
> > >
> > >  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> > >  {
> > > @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> > >       }
> > >       BUG_ON(p4d_bad(p4d));
> > >
> > > +     /*
> > > +      * fixmap is global resource, thus it needs to be protected by a lock
> > > +      * in case of race condition.
> > > +      */
> >
> > Small nit, format and align this comment block. I guess
> > could also be done while merging this patch as well.
> >
> > > +     spin_lock(&fixmap_lock);
> > >       pudp = pud_set_fixmap_offset(p4dp, addr);
> > >       do {
> > >               pud_t old_pud = READ_ONCE(*pudp);
> > > @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> > >       } while (pudp++, addr = next, addr != end);
> > >
> > >       pud_clear_fixmap();
> > > +     spin_unlock(&fixmap_lock);
> > >  }
> > >
> > >  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> > >
> >
> > Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> We have different fixmap slots for different page table levels, so
> 'fixmap_lock' is not the right name.
> 
> But we already have swapper_pgdir_lock as well, which serializes the
> use of the pgdir level fixmap slot. And we have no spinlocks
> protecting the other levels.
> 
> So should we perhaps clean this up more comprehensively? Wouldn't it
> be better to add a mutex to __create_pgd_mapping(), for instance?

That does sound like a better way to do things, but the simplicity of this
patch is quite attractive for backporting. Would you object to me queuing
it as-is, on the premise that I'm more than happy to take consolidation
changes on top?

Will
