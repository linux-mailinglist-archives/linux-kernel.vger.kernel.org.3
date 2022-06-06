Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7628B53FB7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbiFGKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiFGKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:38:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A214D11;
        Tue,  7 Jun 2022 03:38:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fu3so32811100ejc.7;
        Tue, 07 Jun 2022 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS/YdT6ua32na97CqWFvFSVkMxLLpKjcoq8R6JJDuMg=;
        b=TfSh23+p1T9WwCPk5m4pQlk64AAbGXFaKssSeb89lrBlH61XMvE7agjozS4le3KPgE
         eE1vOoqCF7AaTVQN3k826+EK49j/m3GPCkZUSxV7jYuh07XbgEEYYLT3EIzjsR02+2sg
         qhAdaoiyNuGLlzfGyyB+BBvcz+Kr/dfUbk64LEDzKjKejwj7TIZLmCZiI7mgISfYD6F3
         DJUvAhyW0TYYxQ5uXcyFnNC1Mp3pJ2iq2Pm1qBaHk0DD+WPmwORRNVH0JNWq3LfRKHHJ
         3c2b57CotnxLsd/CFm55hivT/1ehZlKY17NOY7kbeR4WyXue2Om4pmQMyb6udCpGif9G
         ksJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS/YdT6ua32na97CqWFvFSVkMxLLpKjcoq8R6JJDuMg=;
        b=aK8AYsPQUpq8L3XjhuGcKnZ0f7TzzTNxLPNau4pGnnXSsGva5IJMkhuKDCYOOWOs/3
         mXDg2vJZUUpQyTr4cZCuj/7y2VYBEKplDDWxG3vfHC5J7HArHJv+ZD6IZMaox3EKfSUM
         1IEiKSnAZ+temz0a6AarY/zRdF8QE8l9M6qEJyBQPRhMELv6omZlCS/E8g+KiWgy4nQR
         qr2Weo6VYN/RtNw2XPBfW7tofUxJ2lpt8f3kNEhroXYrKPRm/d1Zj4fglak669afKm0x
         c/L0yqOHvBm5EDqgK9u84DWsIYr2Qrd8RQpYk6+tpHBL5YCWcbfd/kp+T9+GTKMmzw4t
         mULQ==
X-Gm-Message-State: AOAM533DnGbdXJDlc9EBDM6F0ZhNtk8Yj5Oma0CR92W/pwMHAQOAZCZz
        wC+YDtCVkpDp0Dy7Aga8Y+wjkGtWnx6mzu6NNqA=
X-Google-Smtp-Source: ABdhPJzS03JWNFZZz5z/idTatyLremjDt75688yaaDyJMkBy/6BjtQbZ6nWd3GG+MYuo4832pvTDkETByAnSxxcSeWM=
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id
 jg21-20020a170907971500b00711ca06ca50mr10634070ejc.192.1654598279517; Tue, 07
 Jun 2022 03:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com> <20220607102135.GA32448@willie-the-truck>
In-Reply-To: <20220607102135.GA32448@willie-the-truck>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 7 Jun 2022 10:37:46 +1200
Message-ID: <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Will Deacon <will@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
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
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 10:21 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 07, 2022 at 07:37:10PM +1200, Barry Song wrote:
> > On Mon, Jun 6, 2022 at 9:25 PM Barry Song <21cnbao@gmail.com> wrote:
> > > On Wed, May 18, 2022 at 4:49 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index fedb82371efe..7cb7ef29088a 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -73,6 +73,7 @@
> > > >  #include <linux/page_idle.h>
> > > >  #include <linux/memremap.h>
> > > >  #include <linux/userfaultfd_k.h>
> > > > +#include <linux/mm_inline.h>
> > > >
> > > >  #include <asm/tlbflush.h>
> > > >
> > > > @@ -821,6 +822,12 @@ static bool folio_referenced_one(struct folio *folio,
> > > >                 }
> > > >
> > > >                 if (pvmw.pte) {
> > > > +                       if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
> > > > +                           !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
> > > > +                               lru_gen_look_around(&pvmw);
> > > > +                               referenced++;
> > > > +                       }
> > > > +
> > > >                         if (ptep_clear_flush_young_notify(vma, address,
> > >
> > > Hello, Yu.
> > > look_around() is calling ptep_test_and_clear_young(pvmw->vma, addr, pte + i)
> > > only without flush and notify. for flush, there is a tlb operation for arm64:
> > > static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> > >                                          unsigned long address, pte_t *ptep)
> > > {
> > >         int young = ptep_test_and_clear_young(vma, address, ptep);
> > >
> > >         if (young) {
> > >                 /*
> > >                  * We can elide the trailing DSB here since the worst that can
> > >                  * happen is that a CPU continues to use the young entry in its
> > >                  * TLB and we mistakenly reclaim the associated page. The
> > >                  * window for such an event is bounded by the next
> > >                  * context-switch, which provides a DSB to complete the TLB
> > >                  * invalidation.
> > >                  */
> > >                 flush_tlb_page_nosync(vma, address);
> > >         }
> > >
> > >         return young;
> > > }
> > >
> > > Does it mean the current kernel is over cautious?  is it
> > > safe to call ptep_test_and_clear_young() only?
> >
> > I can't really explain why we are getting a random app/java vm crash in monkey
> > test by using ptep_test_and_clear_young() only in lru_gen_look_around() on an
> > armv8-a machine without hardware PTE young support.
> >
> > Moving to  ptep_clear_flush_young() in look_around can make the random
> > hang disappear according to zhanyuan(Cc-ed).
> >
> > On x86, ptep_clear_flush_young() is exactly ptep_test_and_clear_young()
> > after
> >  'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> > the accessed bit instead of flushing the TLB")'
> >
> > But on arm64, they are different. according to Will's comments in this
> > thread which
> > tried to make arm64 same with x86,
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html
> >
> > "
> > This is blindly copied from x86 and isn't true for us: we don't invalidate
> > the TLB on context switch. That means our window for keeping the stale
> > entries around is potentially much bigger and might not be a great idea.
> >
> > If we roll a TLB invalidation routine without the trailing DSB, what sort of
> > performance does that get you?
> > "
> > We shouldn't think ptep_clear_flush_young() is safe enough in LRU to
> > clear PTE young? Any comments from Will?
>
> Given that this issue is specific to the multi-gen LRU work, I think Yu is
> the best person to comment. However, looking quickly at your analysis above,
> I wonder if the code is relying on this sequence:
>
>
>         ptep_test_and_clear_young(vma, address, ptep);
>         ptep_clear_flush_young(vma, address, ptep);
>
>
> to invalidate the TLB. On arm64, that won't be the case, as the invalidation
> in ptep_clear_flush_young() is predicated on the pte being young (and this
> patches the generic implementation in mm/pgtable-generic.c. In fact, that
> second function call is always going to be a no-op unless the pte became
> young again in the middle.

Hi Will,
thanks for your reply, sorry for failing to let you understand my question.
my question is actually as below,
right now  lru_gen_look_around() is using ptep_test_and_clear_young()
only without flush to clear pte for a couple of pages including the specific
address:
void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
{
       ...

       for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
               ...

               if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
                       continue;

               ...
}

I wonder if it is safe to arm64. Do we need to move to ptep_clear_flush_young()
in the loop?

>
> Will

Thanks
Barry
