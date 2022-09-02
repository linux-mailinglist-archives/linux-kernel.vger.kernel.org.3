Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAA5AA50B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiIBB3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiIBB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:29:10 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65F9FAB8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:29:08 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id i12so633699vsr.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=S/fTF/4dM/pEqTpy2bm0bAwsPgRgvgo33NrrNtuAix8=;
        b=drzeCFI6C3D4GkZ2WMTCU8o1/1IhLN/qaofev4e6fi1mIufwzBZlDMul7pVTnFowrj
         UckddCVK33VtTWFTYgSwggcc35E+H7akCFrt9aaUc+lQxJdtPiXUuUrFpYBqX8whJFLb
         maD1mApMxPqykVUQY8do9X2znhlNAa8zwt8fqeqCHOMVM2U4Lclb9fGQz7L2MFxi6a/X
         GAjAqGed8QjLRpy9QHJoiiouQPeURRiKw4HyoZ1wrnLam2rEtSyGqPqRP92Js5aUIZV+
         TR+++JpoQg+gEp4AScIH3ekOAcuqFdJ3sGEG67PWwlb6Flin6pQOiyjE829Zn852Pf+l
         XUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S/fTF/4dM/pEqTpy2bm0bAwsPgRgvgo33NrrNtuAix8=;
        b=bLIT/NJbSPYM1CTXZ43B0qZf6s3ZhYyM7d885Q/0pKte0kJdccIKUFEXhCc+TStEbp
         ouh6ATEGbobwIPsWQucrQFuzrywmo2i/CgOrKqq2aiEWJOuIut4amQ9s6eiM7W0uF9wd
         DBRhDYV+I3Qq9xiTAqOycrMWSspnjtJK9c99O/M37aEgEr2WlhezQgNeMBJQV0nc1NDa
         iTPUN40SEEDfSckidrAuDmDgQm8tJ51Y79QWgsjFRlGngI+qa+E8Beqt1XsYQRhWbo7R
         tw+Kj23dD4jJAIfreB+/NtyTur/9Es+axyREiOTCqKJ3c9DWjfblR8o7bzKslaly3ULX
         bMQA==
X-Gm-Message-State: ACgBeo1dBUpOwZ16B4UfrhZ1IorbJ5KDSjW0gxN9Amtd8YoQU2cWdH7V
        MdFR1al1OQjUjqJIVCWqgJn4dwinMaZeczaPPNYsgA==
X-Google-Smtp-Source: AA6agR4+ZFKFADL/9cwQOj7+rGh6g92ApnvKD8hhwNx3e9lydmKFAO6gZ8jfP/eZABigIsOdyeih9cEJv0DekXvb/JQ=
X-Received: by 2002:a67:f909:0:b0:390:e960:7f5a with SMTP id
 t9-20020a67f909000000b00390e9607f5amr7264884vsq.50.1662082147436; Thu, 01 Sep
 2022 18:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-8-yuzhao@google.com>
 <0F7CF2A7-F671-4196-B8FD-F35E9556391B@gmail.com> <CAOUHufZ6LGyBoPBkniB63-77r5=1POWpEWmUTESFtJo2bwbi-w@mail.gmail.com>
In-Reply-To: <CAOUHufZ6LGyBoPBkniB63-77r5=1POWpEWmUTESFtJo2bwbi-w@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 1 Sep 2022 19:28:31 -0600
Message-ID: <CAOUHufa+WpwP5NENgQ5jqgsVwqvK8vaayyJ4hT5071y=+ZYF6A@mail.gmail.com>
Subject: Re: [PATCH v14 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
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
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Barry Song <baohua@kernel.org>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 7:17 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Sep 1, 2022 at 3:18 AM Nadav Amit <nadav.amit@gmail.com> wrote:
> >
> >
> >
> > > On Aug 15, 2022, at 12:13 AM, Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > Searching the rmap for PTEs mapping each page on an LRU list (to test
> > > and clear the accessed bit) can be expensive because pages from
> > > different VMAs (PA space) are not cache friendly to the rmap (VA
> > > space). For workloads mostly using mapped pages, searching the rmap
> > > can incur the highest CPU cost in the reclaim path.
> >
> > Impressive work.

Thanks.

> > Sorry if my feedback is not timely.
> >
> > Just one minor point for thought, that can be left for a later cleanup.
> >
> > >
> > > +     for (i =3D 0, addr =3D start; addr !=3D end; i++, addr +=3D PAG=
E_SIZE) {
> > > +             unsigned long pfn;
> > > +
> > > +             pfn =3D get_pte_pfn(pte[i], pvmw->vma, addr);
> > > +             if (pfn =3D=3D -1)
> > > +                     continue;
> > > +
> > > +             if (!pte_young(pte[i]))
> > > +                     continue;
> > > +
> > > +             folio =3D get_pfn_folio(pfn, memcg, pgdat);
> > > +             if (!folio)
> > > +                     continue;
> > > +
> > > +             if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i=
))
> > > +                     continue;
> > > +
> >
> > You have already checked that the PTE is old (not young) so this check
> > seems redundant.
>
> You are right, for x86, which belongs to category 1: hardware and
> OS share the same paging data structure.
>
> > I do not see a way in which the access-bit can be cleared
> > since you hold the ptl.
>
> There is also category 2: the OS paging data structure is a shadow of wha=
t
> hardware actually uses, e.g., POWER9 radix.
>
> To make both categories work, the general rule is that the OS paging
> data structure must be more strict, i.e., it can have A/D bits set
> while the hardware paging data structure may not. The opposite is not
> allowed, even for the A bit, because the A bit can also be used to
> determine whether a TLB flush is required. The Linux kernel doesn't do
> this but there are other OSes that do.
>
> For prefaulted PTEs, we generally mark them young unless
> arch_wants_old_prefaulted_pte() returns true (currently only ARMv8.2+
> do). On POWER9, we'd see those PTEs pass the first check but fail the
> second.

Because the first check (non-atomic) is allowed to fetch from the OS
paging data structure (which is more strict) while the second check
(atomic) must fetch from the hardware page data structure (which does
not have the A bit because those PTEs are preffaulted).

> > IOW, there is no need for the =E2=80=9Cif" and =E2=80=9Ccontinue".
> >
> > Makes me also wonder whether having a separate ptep_clear_young() can
> > slightly help, since anyhow the access-bit is more of an estimation,
> > and having a separate ptep_clear_young() can enable optimizations.
> >
> > On x86, for instance, if the PTE is dirty, we may be able to clear the
> > access-bit without an atomic operation, which should be faster.
>
> Agreed.
