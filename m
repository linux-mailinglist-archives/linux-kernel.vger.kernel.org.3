Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA79D510C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355891AbiDZWmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiDZWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:42:54 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FF1785A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:39:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id z144so133776vsz.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07Zd/16O2HE5Be6dl0YhxA/WYrWu/Ra4RQxC/o3rHN4=;
        b=mXqqHglO8XEfpNHe4xKmQqH8vvmuEmWI2bFNvmyTbbCSV0ya7UVXg/CycRw8F18FwN
         UcSuyVAxAkkxGzNmJMQQLPhr7tKKwVRzQg5TEQVjgMzzOOilYUIOThNtoL67+JZ+ZyhN
         5Pajba/FLU+hVEX2+YLmzV+ru2ChYCNly/8fbTWXtQoLaEtfEOoL7/pUYffGG7YWBfwo
         IwcYTlGqHA67e2TC163DJobE7uBZLHCJTXOOq/kEfJ0EBn/W8KeKWzAk1RDA7rhSVdju
         YJznNyD0LtFe11RwAAZLedbIeNvEpcI7u+tykPQ0OZYSXc4Ih1OudNrgdkLaGY0wVuJs
         QhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07Zd/16O2HE5Be6dl0YhxA/WYrWu/Ra4RQxC/o3rHN4=;
        b=D1NY5Az+iz5d9M2ozJnZcQrTKw2x/LKqpHNox67FyJIob9AfA3ljxYu++lCZRGU4W3
         DFbNw9DEuGZyWu4TejKVRi6iEloL1v9SFcP6j/mB47BdQlmTieV41Ufo5hHzW8SZJwuW
         VMhSORffOv7Swb+kPz18doav7zPD+57TajyD7FKR59/s1U6nyPfe/g6OSU6Bgb/73a++
         rsv7GcNtxa3J5dICgFPQJ9HkFkYMhMg37UiFl6ENMv+VV2BcHd/cMNnFjDP05DIXzOmW
         Gv2q+zQEYsmuiUwzR9iNAzdO7CdWAKjO3jDkKKIVG9FcqSnaeZ4fGqLvycgNEYJRLQZZ
         CovA==
X-Gm-Message-State: AOAM530jiNg1JCstXR76kmV9KcQkRKdZFY0rTeJvyxCBSEB09+6fXwEz
        hnP/+caLZUOJEvh71R3se263uCZ/H7Vc+gfqb5nCMg==
X-Google-Smtp-Source: ABdhPJz+toQujxv6dyO8lpqxNaRIpc4rYh12ObWjdCPFl2wj3PCxuXZcbz1W3wRfVwURFc/mI9NOxhiwyLvLEQzX21c=
X-Received: by 2002:a05:6102:158a:b0:32a:56ea:3fba with SMTP id
 g10-20020a056102158a00b0032a56ea3fbamr7477528vsv.84.1651012784332; Tue, 26
 Apr 2022 15:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-6-yuzhao@google.com>
 <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
In-Reply-To: <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 26 Apr 2022 16:39:07 -0600
Message-ID: <CAOUHufaeNzDJnDqatHe0MwsN-D6M_tw6JX2UBJFc+JpZNP86hQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  6 Apr 2022 21:15:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > Evictable pages are divided into multiple generations for each lruvec.
> > The youngest generation number is stored in lrugen->max_seq for both
> > anon and file types as they are aged on an equal footing. The oldest
> > generation numbers are stored in lrugen->min_seq[] separately for anon
> > and file types as clean file pages can be evicted regardless of swap
> > constraints. These three variables are monotonically increasing.
> >
> > ...
> >
> > +static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
>
> There's a lot of function inlining here.  Fortunately the compiler will
> ignore it all, because some of it looks wrong.  Please review (and
> remeasure!).  If inlining is reqlly justified, use __always_inline, and
> document the reasons for doing so.

I totally expect modern compilers to make better decisions than I do.
And personally, I'd never use __always_inline; instead, I'd strongly
recommend FDO/LTO.

> > +{
> > +     int gen;
> > +     unsigned long old_flags, new_flags;
> > +
> > +     do {
> > +             new_flags = old_flags = READ_ONCE(folio->flags);
> > +             if (!(new_flags & LRU_GEN_MASK))
> > +                     return false;
> > +
> > +             VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> > +             VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > +
> > +             gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > +
> > +             new_flags &= ~LRU_GEN_MASK;
> > +             /* for shrink_page_list() */
> > +             if (reclaiming)
> > +                     new_flags &= ~(BIT(PG_referenced) | BIT(PG_reclaim));
> > +             else if (lru_gen_is_active(lruvec, gen))
> > +                     new_flags |= BIT(PG_active);
> > +     } while (cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);
>
> Clearly the cmpxchg loop is handling races against a concurrent
> updater.  But it's unclear who that updater is, what are the dynamics
> here and why the designer didn't use, say, spin_lock().  The way to
> clarify such thigs is with code comments!

Right. set_mask_bits() should suffice here.

> > +#endif /* !__GENERATING_BOUNDS_H */
> > +
> > +/*
> > + * Evictable pages are divided into multiple generations. The youngest and the
> > + * oldest generation numbers, max_seq and min_seq, are monotonically increasing.
> > + * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
> > + * offset within MAX_NR_GENS, gen, indexes the LRU list of the corresponding
>
> The "within MAX_NR_GENS, gen," text here is unclear?

Will update: "i.e., gen".

> > + * generation. The gen counter in folio->flags stores gen+1 while a page is on
> > + * one of lrugen->lists[]. Otherwise it stores 0.
> > + *
> > + * A page is added to the youngest generation on faulting. The aging needs to
> > + * check the accessed bit at least twice before handing this page over to the
> > + * eviction. The first check takes care of the accessed bit set on the initial
> > + * fault; the second check makes sure this page hasn't been used since then.
> > + * This process, AKA second chance, requires a minimum of two generations,
> > + * hence MIN_NR_GENS. And to maintain ABI compatibility with the active/inactive
>
> Where is the ABI compatibility issue?  Is it in some way in which the
> legacy LRU is presented to userspace?

Will update: yes, active/inactive LRU sizes in /proc/vmstat.

> > + * LRU, these two generations are considered active; the rest of generations, if
> > + * they exist, are considered inactive. See lru_gen_is_active(). PG_active is
> > + * always cleared while a page is on one of lrugen->lists[] so that the aging
> > + * needs not to worry about it. And it's set again when a page considered active
> > + * is isolated for non-reclaiming purposes, e.g., migration. See
> > + * lru_gen_add_folio() and lru_gen_del_folio().
> > + *
> > + * MAX_NR_GENS is set to 4 so that the multi-gen LRU can support twice of the
>
> "twice the number of"?

Will update.

> > + * categories of the active/inactive LRU when keeping track of accesses through
> > + * page tables. It requires order_base_2(MAX_NR_GENS+1) bits in folio->flags.
> > + */
>
> Helpful comment, overall.
>
> >
> > ...
> >
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -909,6 +909,14 @@ config ANON_VMA_NAME
> >         area from being merged with adjacent virtual memory areas due to the
> >         difference in their name.
> >
> > +config LRU_GEN
> > +     bool "Multi-Gen LRU"
> > +     depends on MMU
> > +     # the following options can use up the spare bits in page flags
> > +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> > +     help
> > +       A high performance LRU implementation to overcommit memory.
> > +
> >  source "mm/damon/Kconfig"
>
> This is a problem.  I had to jump through hoops just to be able to
> compile-test this.  Turns out I had to figure out how to disable
> MAXSMP.
>
> Can we please figure out a way to ensure that more testers are at least
> compile testing this?  Allnoconfig, defconfig, allyesconfig, allmodconfig.
>
> Also, I suggest that we actually make MGLRU the default while in linux-next.

The !MAXSMP is to work around [1], which I haven't had the time to
fix. That BUILD_BUG_ON() shouldn't assert sizeof(struct page) == 64
since the true size depends on WANT_PAGE_VIRTUAL as well as
LAST_CPUPID_NOT_IN_PAGE_FLAGS. My plan is here [2].

[1] https://lore.kernel.org/r/20190905154603.10349-4-aneesh.kumar@linux.ibm.com/
[2] https://lore.kernel.org/r/Ygl1Gf+ATBuI%2Fm2q@google.com/
