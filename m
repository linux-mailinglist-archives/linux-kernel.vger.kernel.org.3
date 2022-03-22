Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848CA4E358F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiCVAbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiCVAbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:31:45 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21351375D05
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:30:19 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a127so9272528vsa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZqXUZvSGoiAU4OWPpv+kWmYsbJWpiQeFt4daxe81ds=;
        b=hfrCmbEHl2h5Rii7re10yHpXsfBWYOfGCKo+XQHmbiS2ORaNCnijKzF+qeBzW3BQpF
         fyyM1ZUD/bMfWg5gp9nIKppanhrDqXzd0BiDWLV4odII5vc2bLY4QqqpziOuJ2O1TrJw
         flhQd3vAAwtgT1Xv8Ojt/JsqvVFijWUgiWh0miJ97JPj/PZDacbcaVTJnJ+7etv/AVCb
         /mgprhIyrwN2hOE5UMF6b/8I774/2nwphiQzlUB+Lwssicdx9Q+0boWzoygBzkomBf1m
         M0MRwgVymI1GJRyV7aTF9G1e9F0CjK38bjWTNQmYAksU3FtMFXOstcscKc0OheQ8B1wS
         VTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZqXUZvSGoiAU4OWPpv+kWmYsbJWpiQeFt4daxe81ds=;
        b=5ODSj++clfIkR2yX8tqlLSpesAi9Le4Clnz+RbNNGG1vDjlQGSCZNDJQLnTOhvTQ2n
         zinNFQ3UFYMjMYa3GI5xmiRVF/XC4BdJppKJiK9bYhFJeK+k+TGqBidZIU1y1T4PrtiR
         h5+ZPjp7OzrmlJ/nVQC/b14c8XpbWe9ZUo3ux9NpULbV4Z4ODnNIGHVZTiK7/Hwxqcsx
         oV2sPy8A985ZFp+kLnLs6teYpCpghBpNbGW+ZynmMXyJIIDwtrQ7zyyM27KHk9A7znD8
         Uv2mOjrHlsRcvyhEdMvjgxOks63m/8Iswt8VJjhEm6biwP9HM4Iaf8d+WtlYWgkZ9HBu
         clqg==
X-Gm-Message-State: AOAM530+FfxveHAI3Zhzc3h6+wM/6iW0QbVB7GjhdGkraPMSoA5kCt/I
        sqfPaLbaHGwCN8nRfAAxol25BkDPdB46CX4UORxX5Q==
X-Google-Smtp-Source: ABdhPJzz/wKqvQqJK+JokQegaEl/jW4BCcQKHCuV6sRHJ+7nBGMqKAZzoeJYJwW4PjrsgyHNP+iVv5C2qA0h2jzH8mg=
X-Received: by 2002:a05:6102:291f:b0:325:11be:5bf0 with SMTP id
 cz31-20020a056102291f00b0032511be5bf0mr2955888vsb.41.1647909018098; Mon, 21
 Mar 2022 17:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <CAGsJ_4zw0gX0+OPE3MPaSRH53LdVR0TNv1RN5DK9dtNPvgd8iQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zw0gX0+OPE3MPaSRH53LdVR0TNv1RN5DK9dtNPvgd8iQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 18:30:06 -0600
Message-ID: <CAOUHufYmUPZY0gCC+wYk6Vr1L8KEx+tJeEAhjpBfUnLJsAHq5A@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Linux-MM <linux-mm@kvack.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 5:15 AM Barry Song <21cnbao@gmail.com> wrote:
>
> > +                            unsigned long *min_seq, bool can_swap, bool *need_aging)
> > +{
> > +       int gen, type, zone;
> > +       long old = 0;
> > +       long young = 0;
> > +       long total = 0;
> > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +
> > +       for (type = !can_swap; type < ANON_AND_FILE; type++) {
> > +               unsigned long seq;
> > +
> > +               for (seq = min_seq[type]; seq <= max_seq; seq++) {
> > +                       long size = 0;
> > +
> > +                       gen = lru_gen_from_seq(seq);
> > +
> > +                       for (zone = 0; zone < MAX_NR_ZONES; zone++)
> > +                               size += READ_ONCE(lrugen->nr_pages[gen][type][zone]);
> > +
> > +                       total += size;
> > +                       if (seq == max_seq)
> > +                               young += size;
> > +                       if (seq + MIN_NR_GENS == max_seq)
> > +                               old += size;
> > +               }
> > +       }
> > +
> > +       /* try to spread pages out across MIN_NR_GENS+1 generations */
> > +       if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS > max_seq)
> > +               *need_aging = true;
> > +       else if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS < max_seq)
> > +               *need_aging = false;
> > +       else if (young * MIN_NR_GENS > total)
> > +               *need_aging = true;
>
> Could we have some doc here?

Will do.

> Given MIN_NR_GENS=2 and MAX_NR_GENS=4,
> it seems you mean if we have three generations and the youngest pages are more
> than 1/2 of the total pages, we need aging?

Yes.

> > +       else if (old * (MIN_NR_GENS + 2) < total)
> > +               *need_aging = true;
>
> it seems you mean if the oldest pages are less than 1/4 of the total pages,
> we need aging?

Yes.

> Can we have comments to explain why here?
>
> your commit message only says " The aging produces young generations.
> Given an lruvec, it increments max_seq when max_seq-min_seq+1
> approaches MIN_NR_GENS." it can't explain what the code is doing
> here.

Fair enough. Approaching MIN_NR_GENS=2 means getting close to it. From
the consumer's POV, if it *reaches* 2, the eviction will have to
stall, because the two youngest generations are not yet fully aged,
i.e., the second chance policy similar to the active/inactive lru.
From the producer's POV, the aging tries to be lazy to reduce the
overhead. So ideally, we want 3 generations, which gives a reasonable
range [2, 4], hence the first two if's.

In addition, we want pages to spread out evenly over these 3
generations, meaning an average 1/3 of total pages for each
generation, which gives another reasonable range [1/2, 1/4]. Since the
eviction reduces the number of old pages, we only need to check
against the lower bound, i.e., 1/4. On the other hand, page (re)faults
increase the number of young pages, so in this case, we need to check
against the upper bound.

I'll include these details in the next spin.
