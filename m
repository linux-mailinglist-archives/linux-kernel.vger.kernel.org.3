Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED86554ED5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379010AbiFPWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378485AbiFPWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:33:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8D60A9A;
        Thu, 16 Jun 2022 15:33:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so5338967ejj.10;
        Thu, 16 Jun 2022 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oz0FXxNhpV77sRT+9uMO5C0T7fXnI8REMLiqL4J+sbc=;
        b=AXx7yCLvqlVFTzJfX0CnXNayJu51h3/JJ1q83ZC+OUrBcl2lANtsYhGkehIwfAMkNB
         +xjdRV2zP2hygqaE63pMpcYVT6Kh8TEPKK2h/urGujzN7l/x89h80MzVSQL7IhEB1VhA
         HgkC5kONftmYNAsF09JlEwwMMEkRHzNwhc4gKmWhiXPKA30CTkmggSFwLGTT/JE0pRvv
         wfaoH2DkhJI9AQ497Me4QScoda6mO5/XvL+Mqft7SDNc5szig+tfjR7875ZTOdM4q0Yz
         Ja6IX87j4qtBJeQzuVFNI0PLPrGVWJ36DAyYnEemS640Oox+9QL5Mtk0KuUQVQRBE+Ea
         b8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oz0FXxNhpV77sRT+9uMO5C0T7fXnI8REMLiqL4J+sbc=;
        b=vVv1CtOYDeaHh/+ZTPxXao0SxxEc5FujXwNK8DDbSWD9lFpWS4JJOpQT2k1tU8PjV0
         zhoPCqGEuVp3aXGF6SYE5kSzwD1qOo7l/8R3IaDFBdTr7HREKqN2gBdkkfDk+rS97v0A
         Z2tcJ5n4oacZ9gEN4QixT++rHWYaGDwJG4qfW9f1d07hiCp3jwQopffKd4IhQUFEjfRo
         3mqOsnubBjnYZ0A/K+T43H9XhK4NnE4tj51WTE/P3Ol11NGQ4R4xMbcBxpHQZ5bA8Eng
         1i7/h/JcKz2r/HSD0zNyUIb/u2ndIwF56qMWEyQ9wZX9jVXjgDutHyqc8FgbezvWNG8j
         e0Tw==
X-Gm-Message-State: AJIora9TuCc1ijlH/FHrY5Q6lj2UT+R+aT34KeT/P9y9+vzGl/3j8rg5
        1i9Mr/D1C81f9Lw5Z8veQoSQFuX/QQDuKbMYdPg=
X-Google-Smtp-Source: AGRyM1vJqcrVJsg8SRNSuUIyrwXDuawh731gePruRGVEfT3bLflMt6W9nC+logCtE0MVFEW719gCA2UmIaLi1u1M8WU=
X-Received: by 2002:a17:906:fb07:b0:706:ad5a:db9f with SMTP id
 lz7-20020a170906fb0700b00706ad5adb9fmr6622722ejb.91.1655418831793; Thu, 16
 Jun 2022 15:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck> <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
 <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com>
 <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com>
 <CAGsJ_4yLCsJJvK5QkFOk_7UW72DRO7gWnd6wdn2TWzBrTmRjSg@mail.gmail.com> <CAOUHufZn5L_R7b_S3P9O+VoJC=EnY10e+xyFF7UqiGbLzzzqKg@mail.gmail.com>
In-Reply-To: <CAOUHufZn5L_R7b_S3P9O+VoJC=EnY10e+xyFF7UqiGbLzzzqKg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 17 Jun 2022 10:33:40 +1200
Message-ID: <CAGsJ_4ws3uNWM1wpW603UPYrcXqMe3vmPzbLRkgj9SjSgurN3A@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Yu Zhao <yuzhao@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 9:56 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jun 8, 2022 at 4:46 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Thu, Jun 9, 2022 at 3:52 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Tue, Jun 7, 2022 at 5:43 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > Given we used to have a flush for clear pte young in LRU, right now we are
> > > > moving to nop in almost all cases for the flush unless the address becomes
> > > > young exactly after look_around and before ptep_clear_flush_young_notify.
> > > > It means we are actually dropping flush. So the question is,  were we
> > > > overcautious? we actually don't need the flush at all even without mglru?
> > >
> > > We stopped flushing the TLB on A bit clears on x86 back in 2014.
> > >
> > > See commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case
> > > clear the accessed bit instead of flushing the TLB").
> >
> > This is true for x86, RISC-V, powerpc and S390. but it is not true for
> > most platforms.
> >
> > There was an attempt to do the same thing in arm64:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793830.html
> > but arm64 still sent a nosync tlbi and depent on a deferred to dsb :
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1794484.html
>
> Barry, you've already answered your own question.
>
> Without commit 07509e10dcc7 arm64: pgtable: Fix pte_accessible():
>    #define pte_accessible(mm, pte)        \
>   -       (mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid_young(pte))
>   +       (mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
>
> You missed all TLB flushes for PTEs that have gone through
> ptep_test_and_clear_young() on the reclaim path. But most of the time,
> you got away with it, only occasional app crashes:
> https://lore.kernel.org/r/CAGsJ_4w6JjuG4rn2P=d974wBOUtXUUnaZKnx+-G6a8_mSROa+Q@mail.gmail.com/
>
> Why?

Yes. On the arm64 platform, ptep_test_and_clear_young() without flush
can cause random
App to crash.
ptep_test_and_clear_young() + flush won't have this kind of crashes though.
But after applying commit 07509e10dcc7 arm64: pgtable: Fix
pte_accessible(), on arm64,
ptep_test_and_clear_young() without flush won't cause App to crash.

ptep_test_and_clear_young(), with flush, without commit 07509e10dcc7:   OK
ptep_test_and_clear_young(), without flush, with commit 07509e10dcc7:   OK
ptep_test_and_clear_young(), without flush, without commit 07509e10dcc7:   CRASH

So is it possible that other platforms have similar problems with
arm64 while commit
07509e10dcc7 isn't there? but anyway, we depend on those platforms which can
really use mglru to expose this kind of potential bugs.

BTW, do you think it is safe to totally remove the flush code even for
the original
LRU? I don't see fundamental difference between MGLRU and LRU on this
"flush" thing. Since MGLRU doesn't need flush, why does LRU need it? flush
is very expensive, if we do think this flush is unnecessary, will we remove
it for the original LRU as well?

BTW, look_around is a great idea. Our experiments also show some great
decrease on the cpu consumption of page_referenced().

Thanks
Barry
