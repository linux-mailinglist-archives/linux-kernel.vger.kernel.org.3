Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E797F50616B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbiDSA45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiDSA4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:56:52 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1641AF0F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:54:09 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id n5so14173071vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3C2+caHv8rfuZKJYjuomt5I5i0GHTJeJj6r2gMkPo4=;
        b=sY1/qETR8xJYv+7PQKKD9u7SRjoHYTxZlea4GikwQGl5vh0KebU1mqtphJ0/IqZ/Hs
         27Lps4xZWwoPad2rPAkteq4a3iCcCfI2y9NrdmR+3C2+PdXbnZQqbZ4t/bq8BPh6TZSJ
         nXehsFD/15v+C9adRSC6yTGLhltfO3MLYwT63eRVBPKVZwkoGP25O5p4PivBJtGZzqA1
         KpSsQohLq9fTVEa7gUj7wvCRgC17wXNNySXNjBDU2z9hiyWBiIkzxO8Gbzlwi4pGxAka
         IAFoJ8parNnSSKhl/qTP34XTBuAcBNLYXQjxSJHSe2hAQQyAA9/YZU6fn9MmJqXG94ZA
         0deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3C2+caHv8rfuZKJYjuomt5I5i0GHTJeJj6r2gMkPo4=;
        b=P6UAUq5lZ+0Y4egxMd2oYw43jr3mrh5Lv9Mlmk+g8LVGuYKZ7SgY8TBGrICoOVUrwe
         kxuWUXW8r1wL/+cDY7pZXfrP8gmsbrlPzbb9Tj9Fr1mz9AEIKYm19zXmIet84STsams7
         oj8HfjMAg1FGG/7aG1Ezcnr86w4Ocz1BBx7N5kBxJeZx4fC8Q+Vg4Rs0MeADEqATdgvv
         oR9SaFFkuYupGa0nSxTflrYhzvuiyZy9lhWzGoyeIUdYvX6u5ePG0YD5PVLG2tvJDq1Q
         CfmGGG2bOBcXzaqHLCjKhplZpdQgSnBeYgtepF+8nF0ax7gfeVoekxM86aYIu1NpVWvG
         gatQ==
X-Gm-Message-State: AOAM5304MM8QC+6qzVxT+FAGPRQw/VLX5IIUGrr1+oNuKRnggYbCxqwL
        oL3dBRFw8PVvP+jccYUIEY6DE04SvJf9Zgsh37zGYg==
X-Google-Smtp-Source: ABdhPJwpwrKG1WQBxuDu20cBkE0r7NgyACL8c1C4NSVpgnbaTpSuS5006KhY82nMtW0OOx1VArtyX16RGcp7iYZtM14=
X-Received: by 2002:a67:de17:0:b0:32a:4007:cd86 with SMTP id
 q23-20020a67de17000000b0032a4007cd86mr3575490vsk.22.1650329648830; Mon, 18
 Apr 2022 17:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-7-yuzhao@google.com>
 <CAGsJ_4x2wmR60GQO-jjd5UAvOMWMSi+kFpUa2DBm4e8KocH7jQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4x2wmR60GQO-jjd5UAvOMWMSi+kFpUa2DBm4e8KocH7jQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 18 Apr 2022 18:53:32 -0600
Message-ID: <CAOUHufY_DBk3R7a3=Zb1eofNyqq3VWOmffOR2LaWJQZPYUeCvA@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
To:     Barry Song <21cnbao@gmail.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Apr 18, 2022 at 3:58 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 3:16 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > To avoid confusion, the terms "promotion" and "demotion" will be
> > applied to the multi-gen LRU, as a new convention; the terms
> > "activation" and "deactivation" will be applied to the active/inactive
> > LRU, as usual.
> >
> > The aging produces young generations. Given an lruvec, it increments
> > max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
> > promotes hot pages to the youngest generation when it finds them
> > accessed through page tables; the demotion of cold pages happens
> > consequently when it increments max_seq. The aging has the complexity
> > O(nr_hot_pages), since it is only interested in hot pages. Promotion
> > in the aging path does not require any LRU list operations, only the
> > updates of the gen counter and lrugen->nr_pages[]; demotion, unless as
> > the result of the increment of max_seq, requires LRU list operations,
> > e.g., lru_deactivate_fn().
> >
> > The eviction consumes old generations. Given an lruvec, it increments
> > min_seq when the lists indexed by min_seq%MAX_NR_GENS become empty. A
> > feedback loop modeled after the PID controller monitors refaults over
> > anon and file types and decides which type to evict when both types
> > are available from the same generation.
> >
> > Each generation is divided into multiple tiers. Tiers represent
> > different ranges of numbers of accesses through file descriptors. A
> > page accessed N times through file descriptors is in tier
> > order_base_2(N). Tiers do not have dedicated lrugen->lists[], only
> > bits in folio->flags. In contrast to moving across generations, which
> > requires the LRU lock, moving across tiers only involves operations on
> > folio->flags. The feedback loop also monitors refaults over all tiers
> > and decides when to protect pages in which tiers (N>1), using the
> > first tier (N=0,1) as a baseline. The first tier contains single-use
> > unmapped clean pages, which are most likely the best choices. The
> > eviction moves a page to the next generation, i.e., min_seq+1, if the
> > feedback loop decides so. This approach has the following advantages:
> > 1. It removes the cost of activation in the buffered access path by
> >    inferring whether pages accessed multiple times through file
> >    descriptors are statistically hot and thus worth protecting in the
> >    eviction path.
> > 2. It takes pages accessed through page tables into account and avoids
> >    overprotecting pages accessed multiple times through file
> >    descriptors. (Pages accessed through page tables are in the first
> >    tier, since N=0.)
> > 3. More tiers provide better protection for pages accessed more than
> >    twice through file descriptors, when under heavy buffered I/O
> >    workloads.
> >
>
> Hi Yu,
> As I told you before,  I tried to change the current LRU (not MGLRU) by only
> promoting unmapped file pages to the head of the inactive head rather than
> the active head on its second access:
> https://lore.kernel.org/lkml/CAGsJ_4y=TkCGoWWtWSAptW4RDFUEBeYXwfwu=fUFvV4Sa4VA4A@mail.gmail.com/
> I have already seen some very good results by the decease of cpu consumption of
> kswapd and direct reclamation in the testing.

Glad to hear. I suspected you'd see some good results with that change :)

> in mglru, it seems "twice" isn't a concern at all, one unmapped file
> page accessed
> twice has no much difference with those ones which are accessed once as you
> only begin to increase refs from the third time:

refs are *additional* accesses:
PG_referenced: N=1
PG_referenced+PG_workingset: N=2
PG_referenced+PG_workingset+refs: N=3,4,5

When N=2, order_base_2(N)=1. So pages accessed twice are in the second
tier. Therefore they are "different".

More details [1]:

+/*
+ * Each generation is divided into multiple tiers. Tiers represent different
+ * ranges of numbers of accesses through file descriptors. A page accessed N
+ * times through file descriptors is in tier order_base_2(N). A page in the
+ * first tier (N=0,1) is marked by PG_referenced unless it was faulted in
+ * though page tables or read ahead. A page in any other tier (N>1) is marked
+ * by PG_referenced and PG_workingset.
+ *
+ * In contrast to moving across generations which requires the LRU lock, moving
+ * across tiers only requires operations on folio->flags and therefore has a
+ * negligible cost in the buffered access path. In the eviction path,
+ * comparisons of refaulted/(evicted+protected) from the first tier and the
+ * rest infer whether pages accessed multiple times through file descriptors
+ * are statistically hot and thus worth protecting.
+ *
+ * MAX_NR_TIERS is set to 4 so that the multi-gen LRU can support twice of the
+ * categories of the active/inactive LRU when keeping track of accesses through
+ * file descriptors. It requires MAX_NR_TIERS-2 additional bits in
folio->flags.
+ */
+#define MAX_NR_TIERS 4U

[1] https://lore.kernel.org/linux-mm/20220407031525.2368067-7-yuzhao@google.com/

> +static void folio_inc_refs(struct folio *folio)
> +{
> +       unsigned long refs;
> +       unsigned long old_flags, new_flags;
> +
> +       if (folio_test_unevictable(folio))
> +               return;
> +
> +       /* see the comment on MAX_NR_TIERS */
> +       do {
> +               new_flags = old_flags = READ_ONCE(folio->flags);
> +
> +               if (!(new_flags & BIT(PG_referenced))) {
> +                       new_flags |= BIT(PG_referenced);
> +                       continue;
> +               }
> +
> +               if (!(new_flags & BIT(PG_workingset))) {
> +                       new_flags |= BIT(PG_workingset);
> +                       continue;
> +               }
> +
> +               refs = new_flags & LRU_REFS_MASK;
> +               refs = min(refs + BIT(LRU_REFS_PGOFF), LRU_REFS_MASK);
> +
> +               new_flags &= ~LRU_REFS_MASK;
> +               new_flags |= refs;
> +       } while (new_flags != old_flags &&
> +                cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);
> +}
>
> So my question is what makes you so confident that twice doesn't need
> any special treatment while the vanilla kernel is upgrading this kind of page
> to the head of the active instead? I am asking this because I am considering
> reclaiming unmapped file pages which are only accessed twice when they
> get to the tail of the inactive list.

Per above, pages accessed twice are in their own tier. Hope this clarifies it.
