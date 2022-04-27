Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F17510DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356596AbiD0BPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiD0BPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:15:42 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF503E5D5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:12:32 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id a127so417951vsa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OB4iCXtxiKbS3NMWNYxYIAROlGFdL0Wkd5J0MHv91A=;
        b=Bp9dT2NsWeXsrortAGIE6Vx0R7SGr+A/O59m+DJngXiWhnvAv4m8qbxVl4TUtOJQY5
         bAmLUMBUoJocnLAu4lLnTOo5zkNupj3UnX7QkNy45lihtzmQbwIdNBHV08x4R0xmEECs
         RHOOGe9FvdObHDrXgCsZGk886CHiL8Mvv/8I/3JeNmEJBjskYzLheGO/bCFQfgdYE8wx
         4/n80TAzYbqYYRM294NyAu8H8roXt4mF8a1JXWwVzzD+bSmgY1wQCgAeAWiStF7eoYXW
         /Ec0TvS1b2RbTQiLUA1gTqUxmZh8oiMj/QKw1CLegC52kGpb8aLHwXgU/6srNFGYZd2B
         J0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OB4iCXtxiKbS3NMWNYxYIAROlGFdL0Wkd5J0MHv91A=;
        b=GmCBolUg6a1Omq52xeTEt+PZFRAaF80p0aAZM2kRF8wEHVXceoIxK+CJWg6XkrVes3
         QmooM8iByZM8B3jazlGZKXgEvUPxBWEinr7yNJQj7Kb6Yo+/23cVpFgPG7xmLS67oHKb
         RPslntQZgksaSr2shTeGOcqJk2ctorZQi1XhnLgrIi+qboMvAzg9Vqel2KrqCTsmwwrD
         fUfrDQ0lzmJai/vXH6gpaCtuPfHHKXq4gEyiCr+dFkhJfB/wvuDo8nU3MVhi7sRyc90b
         8Gc9Y6cT/n906LC+g1DlLDL4AkZpgjS9eC+nPE/APsbjfvZvma95S7EmgtvwRybKysHu
         sj7Q==
X-Gm-Message-State: AOAM532rQc4zpBhxnYk7csToyslurnON5O595luEpnJoxahbr885V7v6
        ci+HxO2ElZiDHsT8YKbEBGIiq8BgrVrDczmZyh1F8g==
X-Google-Smtp-Source: ABdhPJwy/MRAp4oC6Hi1ll9gS9jBkgqQtmNi88ADT/C3NJcTx+Bes6COrB45hWc8WPeVFid4VYYYZG1IRGGt4+/7Wgg=
X-Received: by 2002:a05:6102:158a:b0:32a:56ea:3fba with SMTP id
 g10-20020a056102158a00b0032a56ea3fbamr7630158vsv.84.1651021951811; Tue, 26
 Apr 2022 18:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-11-yuzhao@google.com>
 <20220411191627.629f21de83cd0a520ef4a142@linux-foundation.org>
 <CAOUHufbtFj0Hez7wkw3DHGDwo6wudCzCvACt2GfgrFcubW_DYg@mail.gmail.com> <20220426152237.21d3f173eded69c0f63911f0@linux-foundation.org>
In-Reply-To: <20220426152237.21d3f173eded69c0f63911f0@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 26 Apr 2022 19:11:54 -0600
Message-ID: <CAOUHufZ3fRcDqyFPSL9buqcE_sZsZQE+fUW7XkiwubNSD0Zb5g@mail.gmail.com>
Subject: Re: [PATCH v10 10/14] mm: multi-gen LRU: kill switch
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@rothwell.id.au>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 26 Apr 2022 14:57:15 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed,  6 Apr 2022 21:15:22 -0600 Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > > Add /sys/kernel/mm/lru_gen/enabled as a kill switch. Components that
> > > > can be disabled include:
> > > >   0x0001: the multi-gen LRU core
> > > >   0x0002: walking page table, when arch_has_hw_pte_young() returns
> > > >           true
> > > >   0x0004: clearing the accessed bit in non-leaf PMD entries, when
> > > >           CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
> > > >   [yYnN]: apply to all the components above
> > > > E.g.,
> > > >   echo y >/sys/kernel/mm/lru_gen/enabled
> > > >   cat /sys/kernel/mm/lru_gen/enabled
> > > >   0x0007
> > > >   echo 5 >/sys/kernel/mm/lru_gen/enabled
> > > >   cat /sys/kernel/mm/lru_gen/enabled
> > > >   0x0005
> > >
> > > I'm shocked that this actually works.  How does it work?  Existing
> > > pages & folios are drained over time or synchrnously?
> >
> > Basically we have a double-throw way, and once flipped, new (isolated)
> > pages can only be added to the lists of the current implementation.
> > Existing pages on the lists of the previous implementation are
> > synchronously drained (isolated and then re-added), with
> > cond_resched() of course.
> >
> > > Supporting
> > > structures remain allocated, available for reenablement?
> >
> > Correct.
> >
> > > Why is it thought necessary to have this?  Is it expected to be
> > > permanent?
> >
> > This is almost a must for large scale deployments/experiments.
> >
> > For deployments, we need to keep fix rollout (high priority) and
> > feature enabling (low priority) separate. Rolling out multiple
> > binaries works but will make the process slower and more painful. So
> > generally for each release, there is only one binary to roll out, and
> > unless it's impossible, new features are disabled by default. Once a
> > rollout completes, i.e., reaches enough population and remains stable,
> > new features are turned on gradually. If something goes wrong with a
> > new feature, we turn off that feature rather than roll back the
> > kernel.
> >
> > Similarly, for A/B experiments, we don't want to use two binaries.
>
> Please let's spell out this sort of high-level thinking in the
> changelogging.

Will do.

> From what you're saying, this is a transient thing.  It sounds that
> this enablement is only needed when mglru is at an early stage.  Once
> it has matured more then successive rollouts will have essentially the
> same mglru implementation and being able to disable mglru at runtime
> will no longer be required?

I certainly hope so. But realistically this switch is here to stay,
just like anything else added after careful planning or on a whim.

> I guess the capability is reasonable simple/small and is livable with,
> but does it have a long-term future?

I see it as a necessary evil.

> I mean, when organizations such as google start adopting the mglru
> implementation which is present in Linus's tree we're, what, a year or
> more into the future?  Will they still need a kill switch then?

There are two distinct possibilities:
1. Naturally the number of caps would grow. Old caps that have been
proven remain the same values. New caps need to be flipped on/off for
deployments/experiments.
2. The worst case scenario: this file becomes something like
/sys/kernel/mm/transparent_hugepage/enabled. For different workloads,
it's set to different values. Otherwise we'd have to build multiple
kernel binaries.
