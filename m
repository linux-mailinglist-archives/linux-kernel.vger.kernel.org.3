Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156C3472A71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbhLMKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbhLMKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:41:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E7C02791A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:35:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9CA6ACE0F15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9551BC34601
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639391728;
        bh=qaFnVt1EAqbwGYADIjjscKTYFizhwZ4UZkOKbkkmaa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NcjlbOKpxhmkC7IG7Y3Y2hNxa2mzj4SqT7v1YSkkwWmuAxlbQkqf+m/bGWG8CEHPJ
         iwg8yveeVzGonmHcaA1/3srp/Qg6WiT7VM8jCd6+ai2ACy2juyvV9RRzMqolIqjtko
         G8kyBnaxC7D3/vTgzE8cE34CMsM7QI4nsT0QORhvXzMuIRul6gSnx5COJzFFaOu0Kt
         OzBigryA/szlXLCsNZvjrVcTn1LHch09gj63inEE0miDDQIPLiN1dYXwC617YGDUCM
         RbLS3vMi88UQx1edmrP2hllIoF2Yk7iUDTI6EXH5qlXGkDzAphP8j6b2xAyXcjaSmk
         FKx68E7Lq7boQ==
Received: by mail-oi1-f173.google.com with SMTP id s139so22480545oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:35:28 -0800 (PST)
X-Gm-Message-State: AOAM532n+hKNckBIYzRcgaRNs3MYrHt6JHNl5mlgk194Cz8zl/B7D9oa
        w07rwSXV9QdAC0FW3n7QGNwUYAQF4bo00NW/0uM=
X-Google-Smtp-Source: ABdhPJz36v+sSlTV9VjzyMxYB7XA3CFjBxjg2bYbOZAjycu60hMoxV1iyJ8NDOLFhH6sHy+oFmZoRtzp197XdonpNUc=
X-Received: by 2002:aca:ad95:: with SMTP id w143mr26442153oie.47.1639391727860;
 Mon, 13 Dec 2021 02:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20211210095432.51798-1-jianyong.wu@arm.com> <1e63e2f7-0563-2866-4665-84fe220b615f@arm.com>
In-Reply-To: <1e63e2f7-0563-2866-4665-84fe220b615f@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Dec 2021 11:35:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3Kf_OP-EL6oRfstw6VdEaqowVPioABxfMv+1FnPvfew@mail.gmail.com>
Message-ID: <CAMj1kXF3Kf_OP-EL6oRfstw6VdEaqowVPioABxfMv+1FnPvfew@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud mapping
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Jianyong Wu <jianyong.wu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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

On Mon, 13 Dec 2021 at 11:16, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 12/10/21 3:24 PM, Jianyong Wu wrote:
> > fixmap is a global resource and is used recursively in create pud mapping.
> > It may lead to race condition when alloc_init_pud is called concurrently.
> >
> > Fox example:
> > alloc_init_pud is called when kernel_init. If memory hotplug
> > thread, which will also call alloc_init_pud, happens during
> > kernel_init, the race for fixmap occurs.
> >
> > The race condition flow can be:
> >
> > *************** begin **************
> >
> > kerenl_init thread                          virtio-mem workqueue thread
> > ==================                          ======== ==================
> > alloc_init_pud(...)
> >   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
> > ...                                         ...
> >     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
> > ...                                         ...
> >   pud_clear_fixmap() //fixmap break
> >                                               READ_ONCE(*pudp) //CRASH!
> >
> > **************** end ***************
> >
> > Hence, a spin lock is introduced to protect the fixmap during create pdg
> > mapping.
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index acfae9b41cc8..98ac09ae9588 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> >  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> >
> >  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> > +static DEFINE_SPINLOCK(fixmap_lock);
> >
> >  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> >  {
> > @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> >       }
> >       BUG_ON(p4d_bad(p4d));
> >
> > +     /*
> > +      * fixmap is global resource, thus it needs to be protected by a lock
> > +      * in case of race condition.
> > +      */
>
> Small nit, format and align this comment block. I guess
> could also be done while merging this patch as well.
>
> > +     spin_lock(&fixmap_lock);
> >       pudp = pud_set_fixmap_offset(p4dp, addr);
> >       do {
> >               pud_t old_pud = READ_ONCE(*pudp);
> > @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> >       } while (pudp++, addr = next, addr != end);
> >
> >       pud_clear_fixmap();
> > +     spin_unlock(&fixmap_lock);
> >  }
> >
> >  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

We have different fixmap slots for different page table levels, so
'fixmap_lock' is not the right name.

But we already have swapper_pgdir_lock as well, which serializes the
use of the pgdir level fixmap slot. And we have no spinlocks
protecting the other levels.

So should we perhaps clean this up more comprehensively? Wouldn't it
be better to add a mutex to __create_pgd_mapping(), for instance?
