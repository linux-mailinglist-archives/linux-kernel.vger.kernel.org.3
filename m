Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B7501E22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbiDNWSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiDNWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:18:00 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026444742
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:15:32 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id v133so2230123vsv.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHW02OLiilkH2/+Tws3AW48zmC2lykajHWPQE7KEVbE=;
        b=cX6Ui3wEnVf9lN85AlE0FUWBTpgPIOpS5e99y4DrkVKNYMrdgCzmfdADxyijNbm6X1
         fz6WHCq5ohnl6+yC1UncZ1WpwyrihRAm9+jQSz6roUqF3/rjYSLROEUKjtqFyl9yjNIW
         7FHHbh6ObMLZbvzOvy94zur3rSlaNpITjBE+UFhtNiStA7J4ErpcYT5A2sbt7UjAeoXn
         CFYFmnrc3yVx9SOLuvGYpNrGFN2pqix/LOPwZbkZ1gQjNN9YpJqXxPcCKI75QgCXcLF9
         RG1ruAr+T6nchpqowA3VtEiWGkXX+PzH5Wqrqn1mPSxULozp8gPcvMGiuZyRLtL1yhVy
         3n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHW02OLiilkH2/+Tws3AW48zmC2lykajHWPQE7KEVbE=;
        b=oSwD4s84llDNPYk4TWw80GMgbnycjUEHQ82YESEZM7g3XYKP8DMj4KIz/E3La/1Wi3
         bLTSCKdAMpBmZ8J8r/baxWBZB0tL7L6fp8dG5lzTPMnMIG7pSMDf1O6OOMReys9eicby
         RM5e4W6y+Ug3quZQuDC14fFZci8UT6tpqXXL1W9fZVP2yeC33FyACntHyr7bo3efIyWJ
         AOjhlb2Ie//jkZvdhgyTRxWzsyowL7v1jlRstGMksjeVQdb/LENIZaQg2bBbqNHIRb9o
         vFfSymTR316fXzzeBKzthoFZpMh0ZPFnPr6l3/GQUllk9OvYPea9BsEXK6u844SpHZVk
         tpiw==
X-Gm-Message-State: AOAM531j7YlNVhtabtXmy5Rh/HwBPpDWWc3Lf+A654ONmSZAbao6/OPb
        Cqkzv3b/+TGUh8kYwvxMgh/JUXTI4gDjd2WOqvKxKQ==
X-Google-Smtp-Source: ABdhPJwseL3VhTE0AoGeVMgj+ftKNkyXKHXFohiK3nY6OH3s/IVxakxl8Gh+bQzen5ztytFfSWNkxCPOFoJ/uG2ezQg=
X-Received: by 2002:a05:6102:5cc:b0:320:9bd2:3823 with SMTP id
 v12-20020a05610205cc00b003209bd23823mr2297960vsf.81.1649974531117; Thu, 14
 Apr 2022 15:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-7-yuzhao@google.com>
 <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com>
 <YliFs3NOHeo2LeXl@google.com> <20220414143959.0daf4534613f2511b9b27f11@linux-foundation.org>
In-Reply-To: <20220414143959.0daf4534613f2511b9b27f11@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Apr 2022 16:14:55 -0600
Message-ID: <CAOUHufYmEYa4c7v4ATv+cHKu7uN7Lx7agMwWyPERyfMxDyFwoQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Barry Song <21cnbao@gmail.com>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
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

On Thu, Apr 14, 2022 at 3:40 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 14 Apr 2022 14:36:03 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > or it is only something
> > > meaningful for the internal code?
> >
> > This is how swappiness is interpreted.
> >
> > > if so, can we rename it to
> > > something else? otherwise, it is quite confusing.
> >
> > Feel free to suggest something.
>
> It is confusing,   swap_preference?

It's still largely swappiness -- the original swappiness is twisted a
bit around the corners (0, 1 and 200) to make it more suitable for
internal use.

I vote for __swappiness or lrugen_swappiness, which look ugly to me
but it captures what this variable actually is, i.e., an overridden
version of the original swappiness. And similar for lru_gen_mm_walk
*walk vs mm_walk *walk.

In other languages where polymorphism is supported, there are
established naming conversions. In this patchset, I just used the same
variable name when two things are closely related but distinguishable
from the _contexts_ they are used.
