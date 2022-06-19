Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AB550CFD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiFSUhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiFSUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:37:09 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E7123
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:37:06 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id o21so3254967uat.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTIGwSFk5YWUK9VSbfy6N1NsIQybja1kZ/BQ9GPd0+Y=;
        b=l25j73P7uJr58OFr2RGZNSJFVUCIeErBN47QJRfE2KM7Uem87KOiTXbYIgXi9BxcTt
         sWYzpKDC6TGrQBTNQtuNdwtbaYnKJsgVaVdsFZv+IaMn2DToZeV6vPizK7ZrDQXMU+hf
         bdMAbun9VCUdeNKzyk74H49QlWqEeiCLPNdzifHPqxmz+bLx0QxUII9eSfw/3kU9XLNZ
         4jP9lF/7w+PLBz1HxpHA6UI9U5s8bgtiXE7XVUEMHCx5c0o066pja90toaVh0LoVQ8r8
         3rvDDt0Ql56kDzrOrxIKiLS6qxdHVoVpNW3A91/zB3K9qFIdJ0rxYpAOCWbW9ffeACS7
         fipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTIGwSFk5YWUK9VSbfy6N1NsIQybja1kZ/BQ9GPd0+Y=;
        b=leFGvzu3PS/YD78QgWyOnzRjB4LKUaH/aC0L3fCmxK9WQkXO4WlNPT8asyo6Hh/eXS
         N+MhRqdNxE9PzxGi2YxWJSWi7DuqPSFwPS30JlM14LeoGx4nITwb/pqe8FuTFJA7jede
         xvcMOobdn/mbAtvXBXC6Xk0sHXZE3YznDtneFl/PS0KbwsLCy6xY6l3J/4WASGM4EhLo
         2fZRdwSRajGjTSggpriq0j3Rvvt/0I92+7nqxUez575pSblfnhZfy+tjaWYsmGxKcMFU
         KkJCt2YlhLBeL65Kze0FgHzvVsTxfHI3PS1pUlzAGkyDnr+ZLQOrTJGha8g6uCusSJPY
         4XUQ==
X-Gm-Message-State: AJIora8EehLvTRGNW9ur9uC2hIOOoOMbYTFouWtVwZaeqI6VQFW9SyGh
        Qor4vyIb1e7pSuATVotSDXoTHSKo57p/ns9yhivWKg==
X-Google-Smtp-Source: AGRyM1uMtPky5PtZiObhqzIZShVdQHEZeFoF4ilcyHi/Ou4NXdsu8HPwWiKFza3RkKGzM6ygUE5FHweIOepNwDHpGRo=
X-Received: by 2002:ab0:2695:0:b0:352:5fc9:4132 with SMTP id
 t21-20020ab02695000000b003525fc94132mr7178761uao.29.1655671025102; Sun, 19
 Jun 2022 13:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck> <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
 <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com>
 <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com>
 <CAGsJ_4yLCsJJvK5QkFOk_7UW72DRO7gWnd6wdn2TWzBrTmRjSg@mail.gmail.com>
 <CAOUHufZn5L_R7b_S3P9O+VoJC=EnY10e+xyFF7UqiGbLzzzqKg@mail.gmail.com>
 <CAGsJ_4ws3uNWM1wpW603UPYrcXqMe3vmPzbLRkgj9SjSgurN3A@mail.gmail.com>
 <CAOUHufbOwPSbBwd7TG0QFt4YJvBp93Q9nUJEDvMpUA6PqjYMUQ@mail.gmail.com>
 <CAOUHufYvH2LaGyAJZFQNOsGDBKD2++aFnTV6=qaVtcNrKjS_bA@mail.gmail.com>
 <CAGsJ_4ypWMoxUJPjYiFdwQpLOXj8STDN8dSDEQbCpuNonBBkcA@mail.gmail.com>
 <CAOUHufYq81_1HAnTU84md5xr8a8msjxK3tDWmmRfLSUnY-+u+g@mail.gmail.com> <CAOUHufYGywncZGYGPnbS1rSEngtsj+RPevAAcvjQqRLDBTZbmQ@mail.gmail.com>
In-Reply-To: <CAOUHufYGywncZGYGPnbS1rSEngtsj+RPevAAcvjQqRLDBTZbmQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 19 Jun 2022 14:36:28 -0600
Message-ID: <CAOUHufbLhLFxisCmAzyjxf3fQJLDuO+zrVf6pp_Dx-qEp2YMrQ@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Barry Song <21cnbao@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
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

On Thu, Jun 16, 2022 at 9:17 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Jun 16, 2022 at 9:03 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 8:01 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Fri, Jun 17, 2022 at 1:43 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 5:29 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Thu, Jun 16, 2022 at 4:33 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jun 17, 2022 at 9:56 AM Yu Zhao <yuzhao@google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 8, 2022 at 4:46 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jun 9, 2022 at 3:52 AM Linus Torvalds
> > > > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jun 7, 2022 at 5:43 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Given we used to have a flush for clear pte young in LRU, right now we are
> > > > > > > > > > moving to nop in almost all cases for the flush unless the address becomes
> > > > > > > > > > young exactly after look_around and before ptep_clear_flush_young_notify.
> > > > > > > > > > It means we are actually dropping flush. So the question is,  were we
> > > > > > > > > > overcautious? we actually don't need the flush at all even without mglru?
> > > > > > > > >
> > > > > > > > > We stopped flushing the TLB on A bit clears on x86 back in 2014.
> > > > > > > > >
> > > > > > > > > See commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case
> > > > > > > > > clear the accessed bit instead of flushing the TLB").
> > > > > > > >
> > > > > > > > This is true for x86, RISC-V, powerpc and S390. but it is not true for
> > > > > > > > most platforms.
> > > > > > > >
> > > > > > > > There was an attempt to do the same thing in arm64:
> > > > > > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793830.html
> > > > > > > > but arm64 still sent a nosync tlbi and depent on a deferred to dsb :
> > > > > > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1794484.html
> > > > > > >
> > > > > > > Barry, you've already answered your own question.
> > > > > > >
> > > > > > > Without commit 07509e10dcc7 arm64: pgtable: Fix pte_accessible():
> > > > > > >    #define pte_accessible(mm, pte)        \
> > > > > > >   -       (mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid_young(pte))
> > > > > > >   +       (mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
> > > > > > >
> > > > > > > You missed all TLB flushes for PTEs that have gone through
> > > > > > > ptep_test_and_clear_young() on the reclaim path. But most of the time,
> > > > > > > you got away with it, only occasional app crashes:
> > > > > > > https://lore.kernel.org/r/CAGsJ_4w6JjuG4rn2P=d974wBOUtXUUnaZKnx+-G6a8_mSROa+Q@mail.gmail.com/
> > > > > > >
> > > > > > > Why?
> > > > > >
> > > > > > Yes. On the arm64 platform, ptep_test_and_clear_young() without flush
> > > > > > can cause random
> > > > > > App to crash.
> > > > > > ptep_test_and_clear_young() + flush won't have this kind of crashes though.
> > > > > > But after applying commit 07509e10dcc7 arm64: pgtable: Fix
> > > > > > pte_accessible(), on arm64,
> > > > > > ptep_test_and_clear_young() without flush won't cause App to crash.
> > > > > >
> > > > > > ptep_test_and_clear_young(), with flush, without commit 07509e10dcc7:   OK
> > > > > > ptep_test_and_clear_young(), without flush, with commit 07509e10dcc7:   OK
> > > > > > ptep_test_and_clear_young(), without flush, without commit 07509e10dcc7:   CRASH
> > > > >
> > > > > I agree -- my question was rhetorical :)
> > > > >
> > > > > I was trying to imply this logic:
> > > > > 1. We cleared the A-bit in PTEs with ptep_test_and_clear_young()
> > > > > 2. We missed TLB flush for those PTEs on the reclaim path, i.e., case
> > > > > 3 (case 1 & 2 guarantee flushes)
> > > > > 3. We saw crashes, but only occasionally
> > > > >
> > > > > Assuming TLB cached those PTEs, we would have seen the crashes more
> > > > > often, which contradicts our observation. So the conclusion is TLB
> > > > > didn't cache them most of the time, meaning flushing TLB just for the
> > > > > sake of the A-bit isn't necessary.
> > > > >
> > > > > > do you think it is safe to totally remove the flush code even for
> > > > > > the original
> > > > > > LRU?
> > > > >
> > > > > Affirmative, based on not only my words, but 3rd parties':
> > > > > 1. Your (indirect) observation
> > > > > 2. Alexander's benchmark:
> > > > > https://lore.kernel.org/r/BYAPR12MB271295B398729E07F31082A7CFAA0@BYAPR12MB2712.namprd12.prod.outlook.com/
> > > > > 3. The fundamental hardware limitation in terms of the TLB scalability
> > > > > (Fig. 1): https://www.usenix.org/legacy/events/osdi02/tech/full_papers/navarro/navarro.pdf
> > > >
> > > > 4. Intel's commit b13b1d2d8692 ("x86/mm: In the PTE swapout page
> > > > reclaim case clear the accessed bit instead of flushing the TLB")
> > >
> > > Hi Yu,
> > > I am going to send a RFC based on the above discussion.
> > >
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 5bcb334cd6f2..7ce6f0b6c330 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -830,7 +830,7 @@ static bool folio_referenced_one(struct folio *folio,
> > >                 }
> > >
> > >                 if (pvmw.pte) {
> > > -                       if (ptep_clear_flush_young_notify(vma, address,
> > > +                       if (ptep_clear_young_notify(vma, address,
> > >                                                 pvmw.pte)) {
> > >                                 /*
> > >                                  * Don't treat a reference through
> >
> > Thanks!
> >
> > This might make a difference on my 64 core Altra -- I'll test after
> > you post the RFC.
>
> Also, IIRC, it made no difference on POWER9 because POWER9
> flushes TBL regardless which variant is used.
  ^^^^^^^ doesn't flush

I just verified this on POWER9. So on top of exhibit 1-4, we got:
  5. 3cb1aa7aa3940 ("powerpc/64s: Implement ptep_clear_flush_young
that does not flush TLBs")
