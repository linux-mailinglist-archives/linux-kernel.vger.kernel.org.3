Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF064F7448
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiDGDsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiDGDsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:48:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB5BEE;
        Wed,  6 Apr 2022 20:46:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so8161263ejc.7;
        Wed, 06 Apr 2022 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2osYizLMrar7QqOz8LD8setUutp7c0I8CuIlWyU0pBg=;
        b=cKZ6do/t2L9vKakesKtxffn9PtC9S2qbMr1610jgtP28xQz6M/jTZXicOp3+64uVHX
         qijM4rThv3VpwivwHnyedSzyRpf3vh4n1k0TQAAJPm/h8Bz9d85Jpr49IYQeUIVlM+cD
         ZmTFDpFRzm4xJyYGwYoOJ5+X2mqr09Y7sRAuxURsQ/icMKA7Wu8S7D+O6hq1eDEY8BDA
         VC8YgH7lGf+Yey31F5KelHmIX5na8552lGQkasonqsXOqDgLwPKyDx4wi/yPs6zzQhcB
         MZZWYzVqqtyDwlF3O6Ax60y95AqQ2heZZg3yOdHV9oD/k0Powk68JmG7cbwav6DWN2zp
         M2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2osYizLMrar7QqOz8LD8setUutp7c0I8CuIlWyU0pBg=;
        b=jZ2QtuS1dYRnxBH0eMk0c70d1/CsfnGSRsVsQztg+PxLQSeBJEFiq9Y8fFGzjGJ5D8
         7aWTnLbCSojG2sJKYV1GfLCAOyqBI0MOd4KKmU1cNGVCH5hhzVmb5VGk1K0zttSUIOFd
         WnmpYEqNHjcRYybQKCGJ9M9Ubz7liSJ+uT8KjnMO8vSpqrG4rGZo7n6VeUpHXEPVYZlD
         O+eAS7R2OAMEpA3VUR3/k52a+PdQrbp8R8J+NRLlePejGvNeMneJjWwD3sOeiBjJClIp
         kWWq85cfLSk0DGOospaYARzjfaWClnHZ8buQfb5/i2VQzTQmglpM+HIrzJUZ2J0pXjOF
         Qskg==
X-Gm-Message-State: AOAM530EIhLPxoBvNWiuvnNdGD+FDsMvtpkykZY30z9zQF09AKwK3uBD
        ZD7rrCxar/xmXoirdgP8U+Ce0VnNIyslxRtRzcQ=
X-Google-Smtp-Source: ABdhPJx0JJX3YOy4xz1wSArtme702dUMio1P+UzX3qxTFY7xH4BfET9qWERzTi+yH9291LSd38MyTL22akuCDuMuecM=
X-Received: by 2002:a17:906:39da:b0:6cf:7f09:a7bc with SMTP id
 i26-20020a17090639da00b006cf7f09a7bcmr11870481eje.457.1649303200136; Wed, 06
 Apr 2022 20:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-8-yuzhao@google.com>
 <CAGsJ_4wVA6G42y4Oj7ToaCoroZTRbS-tU606ELwra3_Sfrgo7w@mail.gmail.com> <CAOUHufbUdoWiBF5x2ZeK104jT39zAuuU0xXKZ51eaU6P8SNUyg@mail.gmail.com>
In-Reply-To: <CAOUHufbUdoWiBF5x2ZeK104jT39zAuuU0xXKZ51eaU6P8SNUyg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 7 Apr 2022 15:46:29 +1200
Message-ID: <CAGsJ_4z=vkub4e5J5ggsTN=YN4qsqmXSOpf_gu993oOGreLjPg@mail.gmail.com>
Subject: Re: [PATCH v9 07/14] mm: multi-gen LRU: exploit locality in rmap
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

On Thu, Apr 7, 2022 at 3:04 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Apr 6, 2022 at 8:29 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Wed, Mar 9, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > Searching the rmap for PTEs mapping each page on an LRU list (to test
> > > and clear the accessed bit) can be expensive because pages from
> > > different VMAs (PA space) are not cache friendly to the rmap (VA
> > > space). For workloads mostly using mapped pages, the rmap has a high
> > > CPU cost in the reclaim path.
> > >
> > > This patch exploits spatial locality to reduce the trips into the
> > > rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
> > > new function lru_gen_look_around() scans at most BITS_PER_LONG-1
> > > adjacent PTEs. On finding another young PTE, it clears the accessed
> > > bit and updates the gen counter of the page mapped by this PTE to
> > > (max_seq%MAX_NR_GENS)+1.
> >
> > Hi Yu,
> > It seems an interesting feature to save the cost of rmap. but will it lead to
> > possible judging of cold pages as hot pages?
> > In case a page is mapped by 20 processes,  and it has been accessed
> > by 5 of them, when we look around one of the 5 processes, the page
> > will be young and this pte is cleared. but we still have 4 ptes which are not
> > cleared. then we don't access the page for a long time, but the 4 uncleared
> > PTEs will still make the page "hot" since they are not cleared, we will find
> > the page is hot either due to look-arounding the 4 processes or rmapping
> > the page later?
>
> Why are the remaining 4 accessed PTEs skipped? The rmap should check
> all the 20 PTEs.

for example page A is the neighbour of page B in process 1, when we do rmap
for B, we look-around and clear A's pte in process 1. but A's ptes are
still set in
process 2,3,4,5.

>
> Even if they were skipped, it doesn't matter. The same argument could
> be made for the rest of 1 millions minus 1 pages that have been timely
> scanned, on a 4GB laptop. The fundamental principle (assumption) of
> MGLRU is never about making the best choices. Nothing can because it's
> impossible to predict the future that well, given the complexity of
> today's workloads, not on a phone, definitely not on a server that
> runs mixed types of workloads. The primary goal is to avoid the worst
> choices at a minimum (scanning) cost. The second goal is to pick good
> ones at an acceptable cost, which probably are a half of all possible
> choices.

thanks
barry
