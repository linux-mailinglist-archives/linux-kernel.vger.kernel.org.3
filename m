Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C14E3B56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiCVJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiCVJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:02:03 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2270ABE0F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:00:35 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 185so8691331vsq.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgfIwOPYuptRsTuNKCi9/HUJBoBxu7b265kLbqakkq0=;
        b=obV+azB1p6rhDPLAT0mRjy/R6+VmuleFeLZBUgp5ejFvuaC31FwKArh69ninRxOilY
         UOU0mD/cvDa75BFcaL93QMAAZsiZAhJYBQ5VpmVLW2Q4PEv5FQF3RJgY6lA/rz/aaGJ2
         FuoXy83LFS0Z/Ew2bm7VRW/0blWe3YJ00+lshmiaHdProRlqRvuXL3GJBjCSWHGDu3bC
         EpH6UX6k9qzwSQkpNIWrE8Uoi32P/XA4Hcp68A28HOUACLo4+gl9KpKHeNha/evqng88
         dPuLNKhCo2RPcYFSludSG698aIqeFgcvYwFJp3CzL5ntwwPPWJphFFW3BbDYzc4g1JVl
         aZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgfIwOPYuptRsTuNKCi9/HUJBoBxu7b265kLbqakkq0=;
        b=mL/E+Z/rd2t0Qhgshp3GJCxo9h6U1O7V9Mm2Lkt0epWDEyhO5wsrnzT3BhFbyY5gUa
         AB9sBA0gTyCegG6QhHg99ISzosrhlTNwWfQh645z2CERfuc6xjUz7B2kIjjYloKzqxeO
         EJfvuzS8n4ZEh1U6IgFcKXvqdAVcVCVNNPA5fRNpnWBsCLk2M5Eqj4kBtZ+aDB7+7KCC
         qKB1cVZgRBeFouG2tBzeQWHeaAsCx2P71K8NV8yUgb35hGRJkhqoT98HS8yXbrWnkGQN
         xxj8uBh5BUzIkroQ9eO6VWQyJHp0DheXihDZovip4Sg31sU7oGrPXWgDRaQcfGGZmX85
         Tq/A==
X-Gm-Message-State: AOAM5330nwkaU1tb9y87MERLAg42u8lQtk8imLEuUuxPvX8UsB08anXg
        tK/Y3jxZ/Zb21pZh9/XJfZcWqHknVZqr+9wtf95fYQ==
X-Google-Smtp-Source: ABdhPJwBytuxvl00Jby+t9xir1uQGJuN5IuNFpeHLDV+zBSHYjNu3Il+S3/PGYJpCRGGBFbHf0jtzBkDYfSUSEGwcTY=
X-Received: by 2002:a67:f956:0:b0:324:eb38:52fb with SMTP id
 u22-20020a67f956000000b00324eb3852fbmr5387865vsq.22.1647939634018; Tue, 22
 Mar 2022 02:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-11-yuzhao@google.com>
 <CAGsJ_4xqRGp1gV89+bAx5iA=AVwj2TA+No92UqLHFa0i14MBMQ@mail.gmail.com>
 <CAOUHufbP7kHquWiD3VsmD=veNFF2v_E9HWqdYSMbS1nPJic0Fg@mail.gmail.com> <CAGsJ_4wPWRkmioxGYOwZ9KwdiJUUdgH9Xd38MJH6B2sKJNG+iA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wPWRkmioxGYOwZ9KwdiJUUdgH9Xd38MJH6B2sKJNG+iA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 22 Mar 2022 03:00:23 -0600
Message-ID: <CAOUHufaLdywz7UtACypbGQsZ9m9cLhfZw78f0wiPGGjQYSGquQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/14] mm: multi-gen LRU: kill switch
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

On Tue, Mar 22, 2022 at 2:45 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 9:20 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 1:47 AM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > ...
> > > > +static bool drain_evictable(struct lruvec *lruvec)
> > > > +{
> > > > +       int gen, type, zone;
> > > > +       int remaining = MAX_LRU_BATCH;
> > > > +
> > > > +       for_each_gen_type_zone(gen, type, zone) {
> > > > +               struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
> > > > +
> > > > +               while (!list_empty(head)) {
> > > > +                       bool success;
> > > > +                       struct folio *folio = lru_to_folio(head);
> > > > +
> > > > +                       VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > > > +                       VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> > > > +                       VM_BUG_ON_FOLIO(folio_is_file_lru(folio) != type, folio);
> > > > +                       VM_BUG_ON_FOLIO(folio_zonenum(folio) != zone, folio);
> > > > +
> > > > +                       success = lru_gen_del_folio(lruvec, folio, false);
> > > > +                       VM_BUG_ON(!success);
> > > > +                       lruvec_add_folio(lruvec, folio);
> > >
> > > for example, max_seq=4(GEN=0) and max_seq-1=3, then we are supposed to put
> > > max_seq in the head of active list. but your code seems to be putting max_seq-1
> > > after putting max_seq, then max_seq is more likely to be evicted
> > > afterwards as it
> > > is in the tail of the active list.
> >
> > This is correct.
>
> maybe something like below can fix it:
>  #define for_each_gen_type_zone(gen, type, zone)
>          \
> -       for ((gen) = 0; (gen) < MAX_NR_GENS; (gen)++)                   \
> +       for (int seq = min_seq[type], (gen)=(seq_to_gen(seq)); seq <=
> max_seq ; seq++)                       \
>                 for ((type) = 0; (type) < ANON_AND_FILE; (type)++)      \
>                         for ((zone) = 0; (zone) < MAX_NR_ZONES; (zone)++)

I explained in another email that you might not have the time to go
over yet [1].

This has to be all *possible* generations, not just [min_seq, max_seq].

[1] https://lore.kernel.org/linux-mm/CAOUHufa50Mj6wusKvFX2cCAk58oTwCLDC8im+_B6OS_dP6=TJQ@mail.gmail.com/
