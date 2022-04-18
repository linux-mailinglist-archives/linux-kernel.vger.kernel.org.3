Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA3504E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiDRKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiDRKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:01:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF88167D1;
        Mon, 18 Apr 2022 02:58:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v15so16874492edb.12;
        Mon, 18 Apr 2022 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H70ax/K9P4QL3LzdGVTK9ti/817Hb8ywEBUqt5hZdj0=;
        b=GeBFdqeInVINk9j3p1jL4YdrYvmbw+APLdasJXrZElFtNqqjtg0u5vMdO7cy1NM/oK
         cKMtopan96Nlh0y5BgOnmJ/UBkfjHuTlC/9hZVpL6/iXLm+7XIYVllPzDw0pYt8qgeSz
         12/ZpkNLlaeSpsjbW7hTunAU82WkAeq4GsXGy0kvSwfhQr+5ughxENWSbQ9rK0t+3kgW
         Emdt3rEYET5rIYUeSjM5OdkYOp818aaNVao/t3nX8GCRTyftk7k0EZwTMONBelx1B7UN
         YX5ttmpAv4E2e3DHxLz0B3kjysiVYCFmtfBWpGmH+quPSkF8mHy3BsJAb6wirxHomkzx
         dQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H70ax/K9P4QL3LzdGVTK9ti/817Hb8ywEBUqt5hZdj0=;
        b=RUomIwKfBmAoIDrGs47JXJjp/l/4L2VgDUtfkEL2Pkjxdq+NUj/3S0aCTBk3lY8c2u
         vWB9ZrtmqRjpSIb4kmS2fThsq/T62zKOjTy7Uns14wQQKL7abYXw6yu2sF8WwMNtlxbw
         SfqyphXprzQ8xQ9sm/U1D0NKlYQRFeuEJUKiPCbAVTVCTgSveNyy0dYXPkVXE5yirndY
         4xOwKW38HYcAMGFHfNDxWSszn+Eix/lGIKL9+ot3SuLvwAsInIDo7hKC6FlS7qJdsqGK
         Be1nSNWTXRDLQgvOgziOFYypkKY31BtbV1uv5ZZj0F0eSTbAP7w5aom43R2NSoY7xUJ+
         tAZw==
X-Gm-Message-State: AOAM531Cqex1snL9R7Wqapa1QRX4+DhTCKU+7yvrXus6EKGKf2A8Uh5l
        Lv8UJkNZdEJmp/VyT1MQkdq+jbo6kjVRm3E3lK8=
X-Google-Smtp-Source: ABdhPJyFy6C4Lp1eZgRvFaLJ1+gIuUbSNc6rO3HvTwRx0okGsHBwah/dQbuEAd2aZ9IYbsuVfjuGtMbjPinfw4cuKUU=
X-Received: by 2002:aa7:d2d6:0:b0:423:97a4:801c with SMTP id
 k22-20020aa7d2d6000000b0042397a4801cmr10507782edr.383.1650275917413; Mon, 18
 Apr 2022 02:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-7-yuzhao@google.com>
In-Reply-To: <20220407031525.2368067-7-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 18 Apr 2022 21:58:26 +1200
Message-ID: <CAGsJ_4x2wmR60GQO-jjd5UAvOMWMSi+kFpUa2DBm4e8KocH7jQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
To:     Yu Zhao <yuzhao@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 3:16 PM Yu Zhao <yuzhao@google.com> wrote:
>
> To avoid confusion, the terms "promotion" and "demotion" will be
> applied to the multi-gen LRU, as a new convention; the terms
> "activation" and "deactivation" will be applied to the active/inactive
> LRU, as usual.
>
> The aging produces young generations. Given an lruvec, it increments
> max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
> promotes hot pages to the youngest generation when it finds them
> accessed through page tables; the demotion of cold pages happens
> consequently when it increments max_seq. The aging has the complexity
> O(nr_hot_pages), since it is only interested in hot pages. Promotion
> in the aging path does not require any LRU list operations, only the
> updates of the gen counter and lrugen->nr_pages[]; demotion, unless as
> the result of the increment of max_seq, requires LRU list operations,
> e.g., lru_deactivate_fn().
>
> The eviction consumes old generations. Given an lruvec, it increments
> min_seq when the lists indexed by min_seq%MAX_NR_GENS become empty. A
> feedback loop modeled after the PID controller monitors refaults over
> anon and file types and decides which type to evict when both types
> are available from the same generation.
>
> Each generation is divided into multiple tiers. Tiers represent
> different ranges of numbers of accesses through file descriptors. A
> page accessed N times through file descriptors is in tier
> order_base_2(N). Tiers do not have dedicated lrugen->lists[], only
> bits in folio->flags. In contrast to moving across generations, which
> requires the LRU lock, moving across tiers only involves operations on
> folio->flags. The feedback loop also monitors refaults over all tiers
> and decides when to protect pages in which tiers (N>1), using the
> first tier (N=0,1) as a baseline. The first tier contains single-use
> unmapped clean pages, which are most likely the best choices. The
> eviction moves a page to the next generation, i.e., min_seq+1, if the
> feedback loop decides so. This approach has the following advantages:
> 1. It removes the cost of activation in the buffered access path by
>    inferring whether pages accessed multiple times through file
>    descriptors are statistically hot and thus worth protecting in the
>    eviction path.
> 2. It takes pages accessed through page tables into account and avoids
>    overprotecting pages accessed multiple times through file
>    descriptors. (Pages accessed through page tables are in the first
>    tier, since N=0.)
> 3. More tiers provide better protection for pages accessed more than
>    twice through file descriptors, when under heavy buffered I/O
>    workloads.
>

Hi Yu,
As I told you before,  I tried to change the current LRU (not MGLRU) by only
promoting unmapped file pages to the head of the inactive head rather than
the active head on its second access:
https://lore.kernel.org/lkml/CAGsJ_4y=TkCGoWWtWSAptW4RDFUEBeYXwfwu=fUFvV4Sa4VA4A@mail.gmail.com/
I have already seen some very good results by the decease of cpu consumption of
kswapd and direct reclamation in the testing.

in mglru, it seems "twice" isn't a concern at all, one unmapped file
page accessed
twice has no much difference with those ones which are accessed once as you
only begin to increase refs from the third time:

+static void folio_inc_refs(struct folio *folio)
+{
+       unsigned long refs;
+       unsigned long old_flags, new_flags;
+
+       if (folio_test_unevictable(folio))
+               return;
+
+       /* see the comment on MAX_NR_TIERS */
+       do {
+               new_flags = old_flags = READ_ONCE(folio->flags);
+
+               if (!(new_flags & BIT(PG_referenced))) {
+                       new_flags |= BIT(PG_referenced);
+                       continue;
+               }
+
+               if (!(new_flags & BIT(PG_workingset))) {
+                       new_flags |= BIT(PG_workingset);
+                       continue;
+               }
+
+               refs = new_flags & LRU_REFS_MASK;
+               refs = min(refs + BIT(LRU_REFS_PGOFF), LRU_REFS_MASK);
+
+               new_flags &= ~LRU_REFS_MASK;
+               new_flags |= refs;
+       } while (new_flags != old_flags &&
+                cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);
+}

So my question is what makes you so confident that twice doesn't need
any special treatment while the vanilla kernel is upgrading this kind of page
to the head of the active instead? I am asking this because I am considering
reclaiming unmapped file pages which are only accessed twice when they
get to the tail of the inactive list.

Thanks
Barry
