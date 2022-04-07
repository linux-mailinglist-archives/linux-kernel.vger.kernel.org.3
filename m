Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D94F7278
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiDGDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiDGDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:06:38 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4B14DFFC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:04:39 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id a127so2412865vsa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlG6HVFbiriXMTJdqZSQqniMpGFV8xnAyrnEzIlMNOY=;
        b=g3dD8HMIW9o4XOj5/F4RYCZnbEq63R4EFyiRBbXsQlUUpD8109X/uRO1gnNIi0+9Pi
         lM1gQs/hacv3X7DHc77AbOsPgGGj22DYZPNeVsSVPpo97gzaVorDV1FW/tOTqx+DYT/P
         jBJwysHsCHMQOUC3rMpl0RAjgDGuNdLmjaqRyAgu6yjOnfQwLgp70zPEKn1m4byVx+Gn
         oaQ4TwpPmIJlhF6DGjFJDaCj+IZModFF71wQbWOneko1mH8M9Gnp2X+nPDvv8I+bcUjq
         1KXKi2GF347JNly/H9fpusZvX9svfQ6yBM2A9CFZJRzmHwYsiNuDABJBRzlGNgaeCuWI
         BRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlG6HVFbiriXMTJdqZSQqniMpGFV8xnAyrnEzIlMNOY=;
        b=Ptj8wT/XxS9nQHQpLERL9OxdPee3AsDzXeUtHyuJFEt715wfSUvBJenr/gPK0XiXwh
         HOZeB0xZVaG0yhUt717vlcRnLoCB8MIirIZAIjOy0uHMqWRb8bsTeDZVCxGVzA+bB7Vq
         AR7wEEzXVR1OpJ13BtA4ktlJOeLun8PU1GE6kzSmjeA4UMpBHL+qfuHaLOupy4L7nW0L
         yefX7mc7uj5K6tMX0VcfSCFHx38B9+pmuD2qCdM+F6GfzIywyUu7sKW7Mrx8vYcu1od/
         GbNTTvGDBbZgAjj5V5/J/IMMJETrGCMHRlDPpADyaEaA3G+WOZrk4v3m915voZmJG0ie
         ZTyQ==
X-Gm-Message-State: AOAM533m5WEw7LyMi4VtxtxuArL1rtJzrEfaZuJYNlGNxC0zWzmwrwoe
        73e246f0TNOXNJiKp3FBvLKZ45P2uKNavta/9NvLXA==
X-Google-Smtp-Source: ABdhPJyuYJMGr6LXPgy65MMvs9O/WDf8CYTQgrUNNgYQ5HIVVErldv2mOXJVQnNH++zy/vxigLt2YykfDAtVJj3qS2Q=
X-Received: by 2002:a05:6102:2922:b0:325:7818:8669 with SMTP id
 cz34-20020a056102292200b0032578188669mr4104348vsb.41.1649300678575; Wed, 06
 Apr 2022 20:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-8-yuzhao@google.com>
 <CAGsJ_4wVA6G42y4Oj7ToaCoroZTRbS-tU606ELwra3_Sfrgo7w@mail.gmail.com>
In-Reply-To: <CAGsJ_4wVA6G42y4Oj7ToaCoroZTRbS-tU606ELwra3_Sfrgo7w@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 6 Apr 2022 21:04:27 -0600
Message-ID: <CAOUHufbUdoWiBF5x2ZeK104jT39zAuuU0xXKZ51eaU6P8SNUyg@mail.gmail.com>
Subject: Re: [PATCH v9 07/14] mm: multi-gen LRU: exploit locality in rmap
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

On Wed, Apr 6, 2022 at 8:29 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Mar 9, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Searching the rmap for PTEs mapping each page on an LRU list (to test
> > and clear the accessed bit) can be expensive because pages from
> > different VMAs (PA space) are not cache friendly to the rmap (VA
> > space). For workloads mostly using mapped pages, the rmap has a high
> > CPU cost in the reclaim path.
> >
> > This patch exploits spatial locality to reduce the trips into the
> > rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
> > new function lru_gen_look_around() scans at most BITS_PER_LONG-1
> > adjacent PTEs. On finding another young PTE, it clears the accessed
> > bit and updates the gen counter of the page mapped by this PTE to
> > (max_seq%MAX_NR_GENS)+1.
>
> Hi Yu,
> It seems an interesting feature to save the cost of rmap. but will it lead to
> possible judging of cold pages as hot pages?
> In case a page is mapped by 20 processes,  and it has been accessed
> by 5 of them, when we look around one of the 5 processes, the page
> will be young and this pte is cleared. but we still have 4 ptes which are not
> cleared. then we don't access the page for a long time, but the 4 uncleared
> PTEs will still make the page "hot" since they are not cleared, we will find
> the page is hot either due to look-arounding the 4 processes or rmapping
> the page later?

Why are the remaining 4 accessed PTEs skipped? The rmap should check
all the 20 PTEs.

Even if they were skipped, it doesn't matter. The same argument could
be made for the rest of 1 millions minus 1 pages that have been timely
scanned, on a 4GB laptop. The fundamental principle (assumption) of
MGLRU is never about making the best choices. Nothing can because it's
impossible to predict the future that well, given the complexity of
today's workloads, not on a phone, definitely not on a server that
runs mixed types of workloads. The primary goal is to avoid the worst
choices at a minimum (scanning) cost. The second goal is to pick good
ones at an acceptable cost, which probably are a half of all possible
choices.
