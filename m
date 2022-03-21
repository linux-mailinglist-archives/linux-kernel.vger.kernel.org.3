Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D341B4E22E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiCUJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCUJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:05:58 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004013D7A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:04:34 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id q85so315912vkq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSajJ2xfMXe0EesuiYqSnQHfA+SOs3A5X1wQXKbJeiY=;
        b=mhKgHTFztD4oE1EO0aenWDmlULX65b1m4LYL+6Va/xTwD8g+WylKqkfidYvvemJqQE
         sWKW4q+jh7O+QPqR5QigKYyd3Ed+LdIBHLCNLL83S6Aom8OkqzFm9eyF0iShDfNjahjk
         qSWGbA5KIK+XiK2K7lI+QTSvEbFkotgelp3oVrQ7wng+ePpozZYjgCAini9Dbk4oad88
         zNn4JUZ2F3CNGX70mqq43GUbix/DYaiELvDjkJb3a0Nwz26CP2Uf019q5/IOHIQJWDq8
         wPwl9GGmEspIMrKwLSmP11v9e7Vgy3/0p68Nv+V1o+IrDFUwu5BpAkabzo4k+hn7I3FE
         z1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSajJ2xfMXe0EesuiYqSnQHfA+SOs3A5X1wQXKbJeiY=;
        b=b/U7Ac0rjuTpswosemLfqopgCj1528n04Rv7sqYi4zMS6mvSuhlpV3WSEfg7U1FEZg
         XgeUD5U8Kc+WC1UZORtaWd/h9PnIsYcfjzSOL0m00ETYAv43chJOGU70ESDXJo0bSmIE
         IIhI++68F9an7XVGxHn+X/2lXEN+kI+2DoizF51jC6JvVKxr83fzqm+IxvCGuc+ec2hl
         2n2YHuTY8oFRAL7VX5P3U7Q9eFU6IH8OYO1AyqXaV+hVSsw/je0qu4Kc4feGZJd0NPwc
         t8WTKueuV5o+W+3qe8CXRkqcbTieKLC2bM3A5b1gbu715JPnjXnUlTrY2FocmL2gJJjL
         lRvw==
X-Gm-Message-State: AOAM533SDMLMoanWlwtBnlDpqnpIJSyYpc82I0eZwWfpuLWhhSaliEAd
        NhjwijgA7Gfhiz2VXvSQwzjy5lAhMUSl8V76AMjlxg==
X-Google-Smtp-Source: ABdhPJxuRciUn+oY3wnewEQkilpGm38vR9ImNxAg3e9AzR+RkgvyjkxY1qoy9t19D3xPUVD8aiVNfRU8zWykxCwstYE=
X-Received: by 2002:a1f:314b:0:b0:331:fff6:a89e with SMTP id
 x72-20020a1f314b000000b00331fff6a89emr7275468vkx.26.1647853473054; Mon, 21
 Mar 2022 02:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-6-yuzhao@google.com>
 <CAGsJ_4zavaa_cjY8W5_9YKknfU5L=Txin51UbojnwA54orVAGQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zavaa_cjY8W5_9YKknfU5L=Txin51UbojnwA54orVAGQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 03:04:22 -0600
Message-ID: <CAOUHufYPT3-_5sAX9r0hyZz4As79FKnVP=gOT=weFdYje0bR5Q@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 5:25 PM Barry Song <21cnbao@gmail.com> wrote:
>
...
> > +static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > +{
> > +       int gen;
> > +       unsigned long old_flags, new_flags;
> > +       int type = folio_is_file_lru(folio);
> > +       int zone = folio_zonenum(folio);
> > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +
> > +       if (folio_test_unevictable(folio))
> > +               return false;
> > +       /*
> > +        * There are three common cases for this page:
> > +        * 1. If it's hot, e.g., freshly faulted in or previously hot and
> > +        *    migrated, add it to the youngest generation.
>
> usually, one page is not active when it is faulted in. till its second
> access is detected, it can be active.

The active/inactive LRU *assumes* this; MGLRU *assumes* the opposite,
and there is no "active" in MGLRU -- we call it hot to avoid confusion
:)

> > +        * 2. If it's cold but can't be evicted immediately, i.e., an anon page
> > +        *    not in swapcache or a dirty page pending writeback, add it to the
> > +        *    second oldest generation.
> > +        * 3. Everything else (clean, cold) is added to the oldest generation.
> > +        */
...
> > +#define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
> > +#define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
>
> The commit log said nothing about REFS flags and tiers.
> but the code is here. either the commit log lacks something
> or the code should belong to the next patch?

It did:
  A few macros, i.e., LRU_REFS_*, used later are added in this patch
to make the patchset less diffy.

> > @@ -462,6 +462,11 @@ void folio_add_lru(struct folio *folio)
> >         VM_BUG_ON_FOLIO(folio_test_active(folio) && folio_test_unevictable(folio), folio);
> >         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >
> > +       /* see the comment in lru_gen_add_folio() */
> > +       if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
> > +           lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
> > +               folio_set_active(folio);
>
> So here is our magic to make folio active as long as it is
> faulted in? i really don't think the below comment is good,
> could we say our purpose directly and explicitly?
>
>  /* see the comment in lru_gen_add_folio() */

I generally keep comments in a few major locations and reference them
from many other minior locations so that it's easier to manage in the
long run. It is a hassle for reviews but once in the tree you can jump
to lru_gen_add_folio() with ctags/cscope or find all places that
reference it by grepping. Assuming we state the purpose, which is to
make lru_gen_add_folio() add the page to the youngest generation, you
still want to go to lru_gen_add_folio() to check if this is really the
case. So why bother :)
