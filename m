Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3254E3B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiCVIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiCVIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:47:05 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86570488A0;
        Tue, 22 Mar 2022 01:45:37 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m67so32410087ybm.4;
        Tue, 22 Mar 2022 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iR4cCSnBvYIEX8JGakAV745I2rgE58S9R2YY4Ged7c=;
        b=NIARtr2oBs7uLYQBYidFLx6MPr55F+lN7qAoql6P3hnq45R1mXdc9VfJ8mEFo9hZXB
         brCk27+g2z4tjCw+jNan4V813Fu7jvJb4vKphwkvh0ixkI/X0rAJUfH/PMx12sHVSi6I
         5vB4YSwU7b7V0ZUbHVme3qC+0mM/LGF0as2ysi8L/04eTWPfCA1Tg/0GvoO3Q4Rh8W2i
         wRaNcLi/NQYckSD8SAv5+Ys0piFZrTv/qFor7iThwAjc1eu+sNNDfpwWobhd03+7bSEb
         xlYh+RuGpr0nY/ByJ43BeJNeSg8ECs3u6x9WvWLFjwaLpRQdNc+PxKPQPoAnjX0IxwBl
         n1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iR4cCSnBvYIEX8JGakAV745I2rgE58S9R2YY4Ged7c=;
        b=DR3Z3Mw2kUPjxbOWXrfA4K1Yofmx5x1uI2REfWTkcqnkxBlUPhqrNKvPmHJH2D9y7g
         Etbsw43OZupZkxfGGWkFZ6z+Uz1fcsbf3eFbg/LRZw/w/k/m9jNflmfU1Uch+HXrri3a
         2b/2mLmoheunOhPioBV2uz6b4G/fDCmXCcu1DuNk8gkomoeUrrK1UtmtJ4kucYFvqI+f
         tKDHDoKDiYeCClySL87zTUQ96PFg7qwDoo60ArhXlw4qL8ig9DLVvSrTWXvTinAF8omf
         TZMUyfCjcU0bXGwhjH4HQPE1uGSIUpjazDB+Yz8h3yEUXReijZbgoRlZ95GCFpRwFvRW
         01+Q==
X-Gm-Message-State: AOAM532NtC2Ej/UVzKpGn49+UD1BoMUEY/gsT+s8T6iV4odQmTOBbgBG
        s5X2kHQZEJc18dFLui5VHn/oylFF8ixCbvSK7Tk=
X-Google-Smtp-Source: ABdhPJw6H/IKc8pB2tyJzweSxfHKCrXN2p8geLUHg4bnZl1ae8zz+b4V+A1AAXqfxr8U643fQljqZsv1xh/JqETo5gI=
X-Received: by 2002:a25:4003:0:b0:633:8ab5:b93e with SMTP id
 n3-20020a254003000000b006338ab5b93emr26470634yba.387.1647938736779; Tue, 22
 Mar 2022 01:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-11-yuzhao@google.com>
 <CAGsJ_4xqRGp1gV89+bAx5iA=AVwj2TA+No92UqLHFa0i14MBMQ@mail.gmail.com> <CAOUHufbP7kHquWiD3VsmD=veNFF2v_E9HWqdYSMbS1nPJic0Fg@mail.gmail.com>
In-Reply-To: <CAOUHufbP7kHquWiD3VsmD=veNFF2v_E9HWqdYSMbS1nPJic0Fg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 22 Mar 2022 21:45:23 +1300
Message-ID: <CAGsJ_4wPWRkmioxGYOwZ9KwdiJUUdgH9Xd38MJH6B2sKJNG+iA@mail.gmail.com>
Subject: Re: [PATCH v9 10/14] mm: multi-gen LRU: kill switch
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

On Tue, Mar 22, 2022 at 9:20 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Mar 22, 2022 at 1:47 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> ...
> > > +static bool drain_evictable(struct lruvec *lruvec)
> > > +{
> > > +       int gen, type, zone;
> > > +       int remaining = MAX_LRU_BATCH;
> > > +
> > > +       for_each_gen_type_zone(gen, type, zone) {
> > > +               struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
> > > +
> > > +               while (!list_empty(head)) {
> > > +                       bool success;
> > > +                       struct folio *folio = lru_to_folio(head);
> > > +
> > > +                       VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > > +                       VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> > > +                       VM_BUG_ON_FOLIO(folio_is_file_lru(folio) != type, folio);
> > > +                       VM_BUG_ON_FOLIO(folio_zonenum(folio) != zone, folio);
> > > +
> > > +                       success = lru_gen_del_folio(lruvec, folio, false);
> > > +                       VM_BUG_ON(!success);
> > > +                       lruvec_add_folio(lruvec, folio);
> >
> > for example, max_seq=4(GEN=0) and max_seq-1=3, then we are supposed to put
> > max_seq in the head of active list. but your code seems to be putting max_seq-1
> > after putting max_seq, then max_seq is more likely to be evicted
> > afterwards as it
> > is in the tail of the active list.
>
> This is correct.

maybe something like below can fix it:
 #define for_each_gen_type_zone(gen, type, zone)
         \
-       for ((gen) = 0; (gen) < MAX_NR_GENS; (gen)++)                   \
+       for (int seq = min_seq[type], (gen)=(seq_to_gen(seq)); seq <=
max_seq ; seq++)                       \
                for ((type) = 0; (type) < ANON_AND_FILE; (type)++)      \
                        for ((zone) = 0; (zone) < MAX_NR_ZONES; (zone)++)

but i am not quite sure it is worth it if we don't switch mglru/lru that
often. so it is all up to you, either fix it or put a comment to describe
we are not trying to make an active list with completely the same
temperature (hot/cold) as pages were in mglru lists.

>
> > anyway, it might not be so important. I can't imagine we will
> > frequently switch mglru
> > with lru dynamically. will we?
>
> I certainly hope not :)

me too.

Thanks
Barry
