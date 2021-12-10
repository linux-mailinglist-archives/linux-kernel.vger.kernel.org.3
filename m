Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B834707F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbhLJSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhLJSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:03:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBECEC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:00:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l25so32801361eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4cSh71dzUGeiXZRE4QW36EmwcI8AZrCxMvROIrZS14=;
        b=hZuwqUyMx6p4vq+XxIbn+14N9qyb4VjVKFc+XlT24PuxI8wuTRByd6L5UShZbYCPn6
         hFJEMkb+ZcKlIYkUV0tDiyObLesBR7irNUCiCMAa2lVRi3CC57aTV1alPZFU5Ysazrph
         YFhWPMKpxva8rtigETs3FTPO6R5mZn5VOWtBPJXZadHgtSqBE5wuIb/YuK6Qz1CH7KoK
         hnKUK9t4YQwu/yKgZT3oT89+N75FsEO9VhEY0F2y2bLckImDe4uov8SNI0AQgrJ3ZD5d
         S7s4cNZ1Mv66posmbYafTGVHKgSQlseJKI92d9yXya7GxXHGbGAnv0tL4KEZr7IYPLWc
         FeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4cSh71dzUGeiXZRE4QW36EmwcI8AZrCxMvROIrZS14=;
        b=ZUpRpeA2PZIQfrWoG2EL5eDocFNt4YADB5LBMx3Wnu4MJ8vSr0Fg0bEWDrRdoBaefH
         u+FZZFptPLY9QWL/s+djki0jZ0qA42qHukVzLQyCD/m0ljSC4RgzFeIJGmNPiq/ahQTk
         LDClrauHp6SNFx47HI1K/EAW4f6LYJWAULbuSb0fbblulG70Tb38gP6RxzA1UIteE+QI
         oK8FPUPqJY1auN9JoEOrMdI64r3t1xvIIzIDZaghG+nFbrbGDZOPAY7BEhOOwtmVwUwq
         jZ8GZCaa+L/0O2FF0N2mJl/GMWAN/PlPpEagPBnoXLyBKizO/KwxBKoDYvldq8utTFxz
         AfRg==
X-Gm-Message-State: AOAM532LHrx8hjZVsrAvJy/sIR4PZmWEWD8qZVVuEoKJSEd8QtcRrrEe
        ndKq6VBtE9q3FmyJmzDrxT/ki3ZyLI4FUbhOmiI=
X-Google-Smtp-Source: ABdhPJyMR1vnybSwdT0dzOqAU1cPEp/zYKbnjixRaU/JBnWxGfH4bMnkNn+t2j/Uf7ySIMQBrI/ELelqVgOUVCZ6KxY=
X-Received: by 2002:a50:e003:: with SMTP id e3mr40230046edl.374.1639159198508;
 Fri, 10 Dec 2021 09:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20211209230414.2766515-1-zi.yan@sent.com> <20211209230414.2766515-4-zi.yan@sent.com>
 <84807a03-f7d1-83cb-16df-bacc58de4529@gmail.com> <971750C3-DAEC-4EE8-B838-2DD3CBC29781@nvidia.com>
In-Reply-To: <971750C3-DAEC-4EE8-B838-2DD3CBC29781@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Dec 2021 09:59:46 -0800
Message-ID: <CAHbLzkr627vwDovZ23Ofje1vfu+m6BbYWs=tvptNpQwf1ramyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Eric Ren <renzhengeek@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 8:08 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 10 Dec 2021, at 2:53, Eric Ren wrote:
>
> > Hi,
> >
> > On 2021/12/10 07:04, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> alloc_migration_target() is used by alloc_contig_range() and non-LRU
> >> movable compound pages can be migrated. Current code does not allocate the
> >> right page size for such pages. Check THP precisely using
> >> is_transparent_huge() and add allocation support for non-LRU compound
> >> pages.
> > Could you elaborate on why the current code doesn't get the right size?  how this patch fixes it.
>
> The current code only check PageHuge() and PageTransHuge(). Non-LRU compound
> pages will be regarded as PageTransHuge() and an order-9 page is always allocated
> regardless of the actual page order. This patch makes the exact check for
> THPs using is_transparent_huge() instead of PageTransHuge() and checks PageCompound()
> after PageHuge() and is_transparent_huge() for non-LRU compound pages.
>
> >
> > The description sounds like it's an existing bug, if so, the patch subject should be changed to
> > "Fixes ..."?
>
> I have not seen any related bug report.
>
> >
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>   mm/migrate.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index d487a399253b..2ce3c771b1de 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1563,7 +1563,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> >>              return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
> >>      }
> >>  -   if (PageTransHuge(page)) {
> >> +    if (is_transparent_hugepage(page)) {
> >>              /*
> >>               * clear __GFP_RECLAIM to make the migration callback
> >>               * consistent with regular THP allocations.
> >> @@ -1572,13 +1572,17 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> > if (PageTransHuge(page)) {  // just give more code context
> > ...
> >>              gfp_mask |= GFP_TRANSHUGE;
> >>              order = HPAGE_PMD_ORDER;
> > order assigned here
> >>      }
> >> +    if (PageCompound(page)) {
> >> +            gfp_mask |= __GFP_COMP;
> >> +            order = compound_order(page);
> > re-assinged again as THP is a compound page?
>
> Ah, you are right. Will use else if instead. Thanks.

You don't have to use else if, you could just do:

if (PageCompound(page)) {
    gfp_mask |= __GFP_COMP;
    order = compound_order(page);
}

if (is_transparent_hugepage(page)) {
    /* Manipulate THP specific gfp mask */
    ....
}


>
> > Thanks,
> > Eric
> >> +    }
> >>      zidx = zone_idx(page_zone(page));
> >>      if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
> >>              gfp_mask |= __GFP_HIGHMEM;
> >>      new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
> >>  -   if (new_page && PageTransHuge(new_page))
> >> +    if (new_page && is_transparent_hugepage(page))
> >>              prep_transhuge_page(new_page);
> >>      return new_page;
>
>
> --
> Best Regards,
> Yan, Zi
