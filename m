Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CDE4E3511
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiCUXxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiCUXx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:53:29 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6987B288AA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:51:53 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id i5so1140688uab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UTkGkxH5z61CFvvV+2N0qMPgD0+CXKYTvEk2R706LAM=;
        b=LmC5XeHMDSyMfs8sqcXs4MtdfXUq+ej1d0yqeFGBoARUAOlwT6Oo6hiE8GJLAyipV7
         6Ys+1yodh0I0YOEIlJio68bp2A6satdIrW9COEKhv6wvoP88UuxUhOhDwCAezrDuQDDI
         gJkCci+X+SERoIspL0e1CK1WwYxrGhhIA7Vi270rwI8K/6w00v/xEw9n/puGwnlQ2+Nx
         P6RIdkbmFMhV++N6pfqesnBvJHLkTZw5Wmgh2Cu2oZiKjAdBgtSd6+dgSnBhyLDADBHq
         rbKMhEKI3pdjITumRYZ5K9ZeL1SiavuOytAg4+BsM/JrK7qfhzCpXZAg7b7ec0EWFjKa
         GP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UTkGkxH5z61CFvvV+2N0qMPgD0+CXKYTvEk2R706LAM=;
        b=2QhfrH9YcojXWfmHMh5prfH6x9nCuz5T+RiAQ4NSzKjWHbjHCYcfHNrgm9l7E1TSDB
         nR9LmdLr5Ieu6TLf4lZI8JD3swtQGh94XPewSkUzCs+IOIBYsQUp0Tl78uGalfpd0GUm
         Qa0Sk1AIJ61xNw2gOPlaRIvyx4RqX3NMNZc3Du8uBwUT4ohRq6VKKrQPHDpZ4lw2JY0Q
         t1pdNQxq8R0GU91LfpdTltG8emaK0WWEil2rK5NUUeHTY2BSjA5BdXVVWMs3NRMg0o9r
         uUpsszYYYodLsFz7i2MqXenHr4vWiQQKaXIwY7W2H5laGDPqHqINJhZel7sO6oH9p0jZ
         rSvw==
X-Gm-Message-State: AOAM532Ii00MmRTYT9eGgmBp+DacT8UXb741+quh9TUEU+SvS20YGG5O
        8Bvqlr88/R3d+zLQMTTga7rxE5DJeQwv6BvGlFat7g==
X-Google-Smtp-Source: ABdhPJxbhMJeBQEf3j1JZxDTy/ndgvixACjKlQy40+dklccM507ablsvs0srEgLOR5fHAAQwED3gOjGvVZyRkFztdhI=
X-Received: by 2002:ab0:6499:0:b0:351:b9b5:9715 with SMTP id
 p25-20020ab06499000000b00351b9b59715mr6585658uam.17.1647906710154; Mon, 21
 Mar 2022 16:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <CAGsJ_4wW-SUPZ+soz5L+TROcmWtiYoABMcYzNyw4p=f2ro9vLQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wW-SUPZ+soz5L+TROcmWtiYoABMcYzNyw4p=f2ro9vLQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 17:51:39 -0600
Message-ID: <CAOUHufa50Mj6wusKvFX2cCAk58oTwCLDC8im+_B6OS_dP6=TJQ@mail.gmail.com>
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

On Sat, Mar 19, 2022 at 4:14 AM Barry Song <21cnbao@gmail.com> wrote:
>
> > +static void inc_max_seq(struct lruvec *lruvec, unsigned long max_seq)
> > +{
> > +       int prev, next;
> > +       int type, zone;
> > +       struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
> > +
> > +       spin_lock_irq(&lruvec->lru_lock);
> > +
> > +       VM_BUG_ON(!seq_is_valid(lruvec));
> > +
> > +       if (max_seq !=3D lrugen->max_seq)
> > +               goto unlock;
> > +
> > +       inc_min_seq(lruvec);
> > +
> > +       /* update the active/inactive LRU sizes for compatibility */
> > +       prev =3D lru_gen_from_seq(lrugen->max_seq - 1);
> > +       next =3D lru_gen_from_seq(lrugen->max_seq + 1);
> > +
> > +       for (type =3D 0; type < ANON_AND_FILE; type++) {
> > +               for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
> > +                       enum lru_list lru =3D type * LRU_INACTIVE_FILE;
> > +                       long delta =3D lrugen->nr_pages[prev][type][zon=
e] -
> > +                                    lrugen->nr_pages[next][type][zone]=
;
>
> this is confusing to me. does lrugen->nr_pages[next][type][zone] have a
> chance to be none-zero even before max_seq is increased? some pages
> can be in the next generation before the generation is born?

Yes.

> isn't it a bug if(lrugen->nr_pages[next][type][zone] > 0)? shouldn't it b=
e=EF=BC=9F
>
> delta =3D lrugen->nr_pages[prev][type][zone]=EF=BC=9B

No. The gen counter in page flags can be updated locklessly
(lru_lock). Later a batched update of nr_pages[] will account for the
change made. If the gen counter is updated to a stale max_seq, and
this stale max_seq is less than min_seq, then this page will be in a
generation yet to be born. Extremely unlikely, but still possible.

This is not a bug because pages might be misplaced but they won't be
lost. IOW, nr_pages[] is always balanced across all *possible*
generations. For the same reason, reset_batch_size() and
drain_evictable() use for_each_gen_type_zone() to go through all
possible generations rather than only those between[max_seq, min_seq].

I'll add a comment here. Sounds good?
