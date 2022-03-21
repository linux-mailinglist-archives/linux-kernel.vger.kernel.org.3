Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D344E256A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346842AbiCULtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbiCULtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:49:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C511A9B5;
        Mon, 21 Mar 2022 04:47:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f38so27534011ybi.3;
        Mon, 21 Mar 2022 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88d829WnB79xpVGm1h0821EVQqb5oWwm0bb9EwNJMDo=;
        b=qhGeg5cKrVFOw2yjKtU+GQcTq/4SPpNyUWoLrArrXPKczeCKtnrtpPcY+bo/QzhXx8
         cz2PbSvznBni6+X1UQZSEakm1Ol9znZz1TpkwHZqJtBYMxBezuuIf6+Gzjz0XROP1vso
         xXADlcbnv+8RWGxu1mG+cYH3kVfR72gVxF8nuiMGHKs722ZBmObGn9pAtyGmMRQu6pVB
         I42OdbIkrTIH+V8YoTztNOfm8ItTILuxMqkNNxPalgLdJ/f+DAQWj1t/xTE7tUtlPt+S
         WftMZe7Ebmeht1nx8P0v1nm7Qy1u9A7Mew3JGe6ClwSoBOrB+a72EEKz9XkAXy5xTGQv
         vzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88d829WnB79xpVGm1h0821EVQqb5oWwm0bb9EwNJMDo=;
        b=ibnIbHk3w25UIFjegs+47x4iTxzl/q90CJc4AVAET6HY6RAOOQVQRe80Zf6fU9UgXA
         sSNSgApf7KVsfHRHEPEvGq70LyYN2AcDq2hmsF9iM3Q8YQzm2ajdrRMeMH/280cfethK
         t+hpT3D8fe8yTBBsuOAQTSK7yE547ngcd/sRMxfu+upeBkEUPpKkYYxLicmsR4qC6k25
         5z/19hrf1k8n/uUe/XtGWktIW2kzIVoQpPQXYdt/6sCcZ0FqM+sR/kKxrI8/TcMOPf68
         qH8HOa1O+hPeTHjWjnNASlAPrDNV89xj7yG48Wvwpn4FVvjEc6YbyBgKl9E0CO4gVaCf
         VfIA==
X-Gm-Message-State: AOAM532hazmb6ofnfJkB4pQz4bN4+4f2r/hb34Yv9vsUjA+2AbF8Y0ZI
        Mjqdn9jCjNjHT8UMAwB+OCmQC4+NA8WEPFY+/bZg6/Om
X-Google-Smtp-Source: ABdhPJy4mCfB7UbhQkgDYhKqu0gWC3hL0WsSLUBqsXIk8w/CzUnJZKCMh6+zrUsxA/j/tMtD4xdz6T/C5TwrjaDLkbo=
X-Received: by 2002:a5b:807:0:b0:633:747:c7d1 with SMTP id x7-20020a5b0807000000b006330747c7d1mr22101647ybp.294.1647863256380;
 Mon, 21 Mar 2022 04:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-6-yuzhao@google.com>
 <CAGsJ_4zavaa_cjY8W5_9YKknfU5L=Txin51UbojnwA54orVAGQ@mail.gmail.com> <CAOUHufYPT3-_5sAX9r0hyZz4As79FKnVP=gOT=weFdYje0bR5Q@mail.gmail.com>
In-Reply-To: <CAOUHufYPT3-_5sAX9r0hyZz4As79FKnVP=gOT=weFdYje0bR5Q@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 22 Mar 2022 00:47:25 +1300
Message-ID: <CAGsJ_4zf6W7EPvWfJ19GkT59vKC6exfqcRp6MDD3_a2opwf50A@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:04 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Mar 16, 2022 at 5:25 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> ...
> > > +static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > +{
> > > +       int gen;
> > > +       unsigned long old_flags, new_flags;
> > > +       int type = folio_is_file_lru(folio);
> > > +       int zone = folio_zonenum(folio);
> > > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > +
> > > +       if (folio_test_unevictable(folio))
> > > +               return false;
> > > +       /*
> > > +        * There are three common cases for this page:
> > > +        * 1. If it's hot, e.g., freshly faulted in or previously hot and
> > > +        *    migrated, add it to the youngest generation.
> >
> > usually, one page is not active when it is faulted in. till its second
> > access is detected, it can be active.
>
> The active/inactive LRU *assumes* this; MGLRU *assumes* the opposite,
> and there is no "active" in MGLRU -- we call it hot to avoid confusion
> :)

yep.

>
> > > +        * 2. If it's cold but can't be evicted immediately, i.e., an anon page
> > > +        *    not in swapcache or a dirty page pending writeback, add it to the
> > > +        *    second oldest generation.
> > > +        * 3. Everything else (clean, cold) is added to the oldest generation.
> > > +        */
> ...
> > > +#define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
> > > +#define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
> >
> > The commit log said nothing about REFS flags and tiers.
> > but the code is here. either the commit log lacks something
> > or the code should belong to the next patch?
>
> It did:
>   A few macros, i.e., LRU_REFS_*, used later are added in this patch
> to make the patchset less diffy.

sorry for missing that.

>
> > > @@ -462,6 +462,11 @@ void folio_add_lru(struct folio *folio)
> > >         VM_BUG_ON_FOLIO(folio_test_active(folio) && folio_test_unevictable(folio), folio);
> > >         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> > >
> > > +       /* see the comment in lru_gen_add_folio() */
> > > +       if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
> > > +           lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
> > > +               folio_set_active(folio);
> >
> > So here is our magic to make folio active as long as it is
> > faulted in? i really don't think the below comment is good,
> > could we say our purpose directly and explicitly?
> >
> >  /* see the comment in lru_gen_add_folio() */
>
> I generally keep comments in a few major locations and reference them
> from many other minior locations so that it's easier to manage in the
> long run. It is a hassle for reviews but once in the tree you can jump
> to lru_gen_add_folio() with ctags/cscope or find all places that
> reference it by grepping. Assuming we state the purpose, which is to
> make lru_gen_add_folio() add the page to the youngest generation, you
> still want to go to lru_gen_add_folio() to check if this is really the
> case. So why bother :)

well understood though my pain was that I needed to email you to get
confirmed this is really the case.

Thanks
Barry
