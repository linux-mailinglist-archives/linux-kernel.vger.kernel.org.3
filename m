Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C184F8B22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiDGXyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiDGXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:54:04 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C76B1E6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:52:02 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id w67so1441589vkw.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2o8XyYQ0xmNcxKBL4HU7d9kJ83bRGbyiA4C3lqn/Jg=;
        b=pHa9t1vY4G3g2veZzfNaljZ/ODjXhV2qKJlnku7tStXx/0bNUioBEP3vV3f0BDiuK6
         hH94GBax6Xp/sQJXPDobV4hjMyHFpCJOJaggMaEnDIAAW4ogVzp/3xpwWmhnl/FmXBHo
         f9FIDTu1gAk8+OOMPOS4KCSGJkzTxlwjzsTeW2yWq86SPpiyjw0UvzuGv2S6NxLXZIKJ
         +/Oe9syDdzEZuz/BrOKZT0KJEH6QF4YyK93gFRcaGmj715NClbnKJHCwJOqcw4s5H8SC
         VNHBGY74iMRpwF+Afqjt3G9ynR6r7jacBDvoE93qsSq7iW+qGFGJVpn6Sshd0TVf8skQ
         QRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2o8XyYQ0xmNcxKBL4HU7d9kJ83bRGbyiA4C3lqn/Jg=;
        b=eoWmiB9fnVKZty4RFc0/bQtZmUVvtlkuhxQEA3UPD9u/4E5ZtGsYVrQv1BaXRI76Mf
         MX89mG8kfrcHU2rSwV3YN/47yfRcVO1iTrqq0VTdUlkIRrNTYhQm5GPtJ1+r77pUv2RC
         VX+l9mgt1aR76ZM9z33E/T9NfW+ZjR7E/9zOmvvwWqCntnO3dVeheNNzQcvzE2R/n0ZJ
         9mNvnwmiT7u9os4j+OmOzs3PlYDNtJWnksFzq1HQ+V6J7TrnjC38wMs97IaglITgcaQC
         LJco/oAb8MLz7n4T+Dt2A3+ofCGXAu3c5JWWgxR07RYhnaE1/KJib9ThNsvu+LhBxfZc
         RNnA==
X-Gm-Message-State: AOAM531fUif3TWXiq5xz32AA+VDNt2xxIYtQsG3NjGRpQYd1kxxhmE1x
        xPEGQutjAuoXhm1/sypZYJo06rpNPU5xt/cKE1JDsQ==
X-Google-Smtp-Source: ABdhPJw/ZEsQZOlZeReph1+ASuuLZlJIuOVM82pvmZCPJ8cvFd3dbcfY3do0xiB4PlkDl4vZ7xT9XS2v6fqp8nCNOS4=
X-Received: by 2002:a1f:a9cb:0:b0:33e:d145:85f0 with SMTP id
 s194-20020a1fa9cb000000b0033ed14585f0mr6025223vke.7.1649375521681; Thu, 07
 Apr 2022 16:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-8-yuzhao@google.com>
 <CAGsJ_4wVA6G42y4Oj7ToaCoroZTRbS-tU606ELwra3_Sfrgo7w@mail.gmail.com>
 <CAOUHufbUdoWiBF5x2ZeK104jT39zAuuU0xXKZ51eaU6P8SNUyg@mail.gmail.com> <CAGsJ_4z=vkub4e5J5ggsTN=YN4qsqmXSOpf_gu993oOGreLjPg@mail.gmail.com>
In-Reply-To: <CAGsJ_4z=vkub4e5J5ggsTN=YN4qsqmXSOpf_gu993oOGreLjPg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 7 Apr 2022 17:51:50 -0600
Message-ID: <CAOUHufbU=Uov54da8u9AqEuP0Y-1T2Khgd5Br-AhTfP=jbM1mA@mail.gmail.com>
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

On Wed, Apr 6, 2022 at 9:46 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 3:04 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Wed, Apr 6, 2022 at 8:29 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Wed, Mar 9, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > Searching the rmap for PTEs mapping each page on an LRU list (to test
> > > > and clear the accessed bit) can be expensive because pages from
> > > > different VMAs (PA space) are not cache friendly to the rmap (VA
> > > > space). For workloads mostly using mapped pages, the rmap has a high
> > > > CPU cost in the reclaim path.
> > > >
> > > > This patch exploits spatial locality to reduce the trips into the
> > > > rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
> > > > new function lru_gen_look_around() scans at most BITS_PER_LONG-1
> > > > adjacent PTEs. On finding another young PTE, it clears the accessed
> > > > bit and updates the gen counter of the page mapped by this PTE to
> > > > (max_seq%MAX_NR_GENS)+1.
> > >
> > > Hi Yu,
> > > It seems an interesting feature to save the cost of rmap. but will it lead to
> > > possible judging of cold pages as hot pages?
> > > In case a page is mapped by 20 processes,  and it has been accessed
> > > by 5 of them, when we look around one of the 5 processes, the page
> > > will be young and this pte is cleared. but we still have 4 ptes which are not
> > > cleared. then we don't access the page for a long time, but the 4 uncleared
> > > PTEs will still make the page "hot" since they are not cleared, we will find
> > > the page is hot either due to look-arounding the 4 processes or rmapping
> > > the page later?
> >
> > Why are the remaining 4 accessed PTEs skipped? The rmap should check
> > all the 20 PTEs.
>
> for example page A is the neighbour of page B in process 1, when we do rmap
> for B, we look-around and clear A's pte in process 1. but A's ptes are
> still set in
> process 2,3,4,5.

It makes no difference because it's too insignificant. The goal is not
to give several million pages unique timestamps and sort them; it's to
partition pages on the orders one tenth to a few seconds and quickly
find some reasonable candidates. Temporal locality gets weaker
exponentially over time. Even on small systems, the difference is not
measurable if several thousand pages used in the last few seconds are
chosen over another several thousand pages used in the last minute.
