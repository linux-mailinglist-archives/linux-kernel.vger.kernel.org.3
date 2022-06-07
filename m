Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127885425AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387673AbiFHB1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453564AbiFGXPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:15:38 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75743248561
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:07:43 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id e11so3345652vsh.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgxQ0h6I958Y2GI2JoqVGW/OESE9fxrXKfh9ZN0Zq08=;
        b=oKoX3EKP+If3Pg3CSsiIzp7MdgwGoVt1eWuoV8GtnXDvuCJWY+M7wmLS8sygJpkjaK
         iOAb0QC3WVE1pARsV9XTNGUaZNsCEia7M1Y1OMdqEzCr2DXhR1x2R0fjgls2GHghq0DJ
         kmV9VrpihV+4mk7fDF1AIBg06e8OMvXc5a6mzwLGlAFIx2PS+fPJA4xnLb/RNoCfe/qz
         5sLk3qDe0vNhpDymnq40eNUHcQXuLAYm2G/O3hH9F58tM1JmX/d7h9aWfcX3LmHxBJIg
         ulq8z9he5xJHfSCzWyqQiUlWhK6wtsKlDnmt21fI11y8OSoQVCEq2KhLU5sFa9gV6pa0
         7+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgxQ0h6I958Y2GI2JoqVGW/OESE9fxrXKfh9ZN0Zq08=;
        b=4TsVOPqGZ66Ay0eKJwnanJlUPjdoFI2EBZdQ3mjbzh6Mdr4uQnbqEdHlXqm7RZFYFa
         6iUs9bKWYY7vsEcvO7+x50OxvT/akLVScknQDUzElFRpHvrpc+mJhGe5rlzsydLzd7+h
         zzvZT3We6/aRTXhoCmPD8tP61atelWAOX5AsoFGStPFoyEtrSpWNzWRYxBgS8Bx8sRj8
         cALbbpVzaVHxtJZt+7ulvDMU59FPd/pqbLvlnij+XrSqxgUsmDTOpI+vmkTuddFnV8fk
         YlwRGt8WkSpYkrK5lkFfV0WEex2512rj62OKDaOkd3LzE8/4xSi9vBQuyXW0gIg6IUh1
         V6pw==
X-Gm-Message-State: AOAM530MRNIij+91BnEuBjNA5XILAvVReLMkQ4myD1nzfDi448FT3dUa
        KrDCGqEckVo78JkEregbzPYnylZkk1FXimFoISCtHg==
X-Google-Smtp-Source: ABdhPJyjqcySNrRwXkeaEuBGNMG5NFNqHbpYoFwoZhrkb2oGCeTEFoqKeluO9Bya5UCEshSWAgyv3unWIgN/r4anB6o=
X-Received: by 2002:a67:f3d0:0:b0:34b:b52d:d676 with SMTP id
 j16-20020a67f3d0000000b0034bb52dd676mr6635528vsn.6.1654636053943; Tue, 07 Jun
 2022 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck>
In-Reply-To: <20220607104358.GA32583@willie-the-truck>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 7 Jun 2022 15:06:57 -0600
Message-ID: <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Will Deacon <will@kernel.org>
Cc:     Barry Song <21cnbao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 4:44 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 07, 2022 at 10:37:46AM +1200, Barry Song wrote:
> > On Tue, Jun 7, 2022 at 10:21 PM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Jun 07, 2022 at 07:37:10PM +1200, Barry Song wrote:
> > > > I can't really explain why we are getting a random app/java vm crash in monkey
> > > > test by using ptep_test_and_clear_young() only in lru_gen_look_around() on an
> > > > armv8-a machine without hardware PTE young support.
> > > >
> > > > Moving to  ptep_clear_flush_young() in look_around can make the random
> > > > hang disappear according to zhanyuan(Cc-ed).
> > > >
> > > > On x86, ptep_clear_flush_young() is exactly ptep_test_and_clear_young()
> > > > after
> > > >  'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> > > > the accessed bit instead of flushing the TLB")'
> > > >
> > > > But on arm64, they are different. according to Will's comments in this
> > > > thread which
> > > > tried to make arm64 same with x86,
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html
> > > >
> > > > "
> > > > This is blindly copied from x86 and isn't true for us: we don't invalidate
> > > > the TLB on context switch. That means our window for keeping the stale
> > > > entries around is potentially much bigger and might not be a great idea.
> > > >
> > > > If we roll a TLB invalidation routine without the trailing DSB, what sort of
> > > > performance does that get you?
> > > > "
> > > > We shouldn't think ptep_clear_flush_young() is safe enough in LRU to
> > > > clear PTE young? Any comments from Will?
> > >
> > > Given that this issue is specific to the multi-gen LRU work, I think Yu is
> > > the best person to comment. However, looking quickly at your analysis above,
> > > I wonder if the code is relying on this sequence:
> > >
> > >
> > >         ptep_test_and_clear_young(vma, address, ptep);
> > >         ptep_clear_flush_young(vma, address, ptep);
> > >
> > >
> > > to invalidate the TLB. On arm64, that won't be the case, as the invalidation
> > > in ptep_clear_flush_young() is predicated on the pte being young (and this
> > > patches the generic implementation in mm/pgtable-generic.c. In fact, that
> > > second function call is always going to be a no-op unless the pte became
> > > young again in the middle.
> >
> > thanks for your reply, sorry for failing to let you understand my question.
> > my question is actually as below,
> > right now  lru_gen_look_around() is using ptep_test_and_clear_young()
> > only without flush to clear pte for a couple of pages including the specific
> > address:
> > void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
> > {
> >        ...
> >
> >        for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
> >                ...
> >
> >                if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
> >                        continue;
> >
> >                ...
> > }
> >
> > I wonder if it is safe to arm64. Do we need to move to ptep_clear_flush_young()
> > in the loop?
>
> I don't know what this code is doing, so Yu is the best person to answer
> that. There's nothing inherently dangerous about eliding the TLB
> maintenance; it really depends on the guarantees needed by the caller.

Ack.

> However, the snippet you posted from folio_referenced_one():
>
>  |                  if (pvmw.pte) {
>  |  +                       if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
>  |  +                           !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
>  |  +                               lru_gen_look_around(&pvmw);
>  |  +                               referenced++;
>  |  +                       }
>  |  +
>  |                          if (ptep_clear_flush_young_notify(vma, address,
>
>
> Does seem to call lru_gen_look_around() *and*
> ptep_clear_flush_young_notify(), which is what prompted my question as it
> looks pretty suspicious to me.

The _notify varint reaches into the MMU notifier --
lru_gen_look_around() doesn't do that because GPA space generally has
no locality. I hope this explains why both.

As to why the code is organized this way -- it depends on the point of
view. Mine is that lru_gen_look_around() is an add-on, since its logic
is independent/separable from ptep_clear_flush_young_notify(). We can
make lru_gen_look_around() include ptep_clear_flush_young_notify(),
but that would make the code functionally interwinted, which is bad
for my taste.
