Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC594D8A20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiCNQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiCNQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:47:11 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B447ACE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:45:34 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id h30so17764722vsq.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK6xQEzNUd1duBz+V1fGWLl/8kdUc06iK3+U1HXRjMo=;
        b=s67JNRlTb4fgxk/9MHbNMID4yckc1N0y4F1nwnI5A5QmtYN8ZJ8xeBmj4G7HCKKOib
         3t5loeG2myKl1qM85EH7iiE7UjGcQRjnobKJwNjxqz4UEgDCj0VHq2qIe0F8k/3Id+Yw
         2xrNT+LRWHzn2beP0j9vtTNUfhyJ7YrSLxEX4CIf5gkQBJHvzFIbv5SvNfogwlKB9jaz
         3PVpS6hrzvFxrX7YmeA+3psFuv2TqlMjvOYfhwvc7KbtofhJEpP5CCWWTYunpUrJzJ8Z
         Bks4WPvNi9f3QIjv4iyi/d0L72cscRYhEghBgbPJ+T6ct0Usd2y79ype4iVXlKKbPxgJ
         JA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK6xQEzNUd1duBz+V1fGWLl/8kdUc06iK3+U1HXRjMo=;
        b=1vGmjw5Q5echcqO7c4TvTHMJQAuGv+L1uFPczEoiPwsnyLkxrITUc3uuteMIj4e2v2
         Q/92TmeQMHnpYJYkPKlEtQfWMRqQLrgTFfCHGinTGEyskhRVLZ2jNve7M8XgiVFPfEl+
         HSX5iWWBP16W5RYflZgj5kar0hwHQAthjrMCn0+52lxGFtt8ajtFp/t5IKU8mbjBREaM
         f/AMFAEAis2jQjju25ZufJd9uuUA/Kw8V4h9wr9aKgAgjabqTET2izbG+XEZGE+hI40Y
         U13HqjysD3ry6pEM04tKTiOmgUSBbAQ2zZXakWFnyTZyMon6Qz4KP+vMGBv+2U+WQRX8
         j/Ig==
X-Gm-Message-State: AOAM532DkJChN7QfxNQ9Cw8T9Xm+bkGjk5i8L5CEkBsfcXFke0qP+W3G
        FDEEGYtDKdj5A3i+lg8LzdghmzT+kO2prSokI+YwCQ==
X-Google-Smtp-Source: ABdhPJxItz/ZL1udHjdruNW05yngkUA9HNr7DupiDKhUsGJNi3CQjWpVNvETb3XoDdRgCaeVdt1dESHMLDkgH0IAY3g=
X-Received: by 2002:a05:6102:f0c:b0:320:9156:732f with SMTP id
 v12-20020a0561020f0c00b003209156732fmr10338597vss.6.1647276332996; Mon, 14
 Mar 2022 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org> <Ygt1qaQM5YobEZK9@google.com>
 <CAGsJ_4wN_CAOsyR3LATE+EUhuV0gO-zhhNiMwEBwyXOp0CbkZg@mail.gmail.com>
 <CAOUHufaUJD8nC6PDVfmkeTwB4BtzBzigxh+V-hfR-_26VwjOPA@mail.gmail.com>
 <CAGsJ_4zT7gtGSEoAay=VE6x_YZkNKtLymRL94pBnVgKekPzxaQ@mail.gmail.com>
 <CAOUHufbor4L5OfjNFEMcaM5bXnM9VWXw-LK9A04vP65rkcLNMg@mail.gmail.com>
 <CAGsJ_4x+BP1RuB4ig=z67br+cdUom1eUov6_t-wxGjWvbpF2Rg@mail.gmail.com> <CAGsJ_4zLWqQ44KkBwJW6e3AHS8XzzNK1D5WVU31mDGdzdqfgaQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zLWqQ44KkBwJW6e3AHS8XzzNK1D5WVU31mDGdzdqfgaQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 14 Mar 2022 10:45:21 -0600
Message-ID: <CAOUHufbN_56UJBkgA2LjAfbTt9nzPOCHaSeS4P3GHcYst+Y+eg@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Barry Song <21cnbao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
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
        Sofia Trinh <sofia.trinh@edi.works>
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

On Mon, Mar 14, 2022 at 5:12 AM Barry Song <21cnbao@gmail.com> wrote:
>
> > > > >
> > > > > > We used to put a faulted file page in inactive, if we access it a
> > > > > > second time, it can be promoted
> > > > > > to active. then in recent years, we have also applied this to anon
> > > > > > pages while kernel adds
> > > > > > workingset protection for anon pages. so basically both anon and file
> > > > > > pages go into the inactive
> > > > > > list for the 1st time, if we access it for the second time, they go to
> > > > > > the active list. if we don't access
> > > > > > it any more, they are likely to be reclaimed as they are inactive.
> > > > > > we do have some special fastpath for code section, executable file
> > > > > > pages are kept on active list
> > > > > > as long as they are accessed.
> > > > >
> > > > > Yes.
> > > > >
> > > > > > so all of the above concerns are actually not that correct?
> > > > >
> > > > > They are valid concerns but I don't know any popular workloads that
> > > > > care about them.
> > > >
> > > > Hi Yu,
> > > > here we can get a workload in Kim's patchset while he added workingset
> > > > protection
> > > > for anon pages:
> > > > https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/
> > >
> > > Thanks. I wouldn't call that a workload because it's not a real
> > > application. By popular workloads, I mean applications that the
> > > majority of people actually run on phones, in cloud, etc.
> > >
> > > > anon pages used to go to active rather than inactive, but kim's patchset
> > > > moved to use inactive first. then only after the anon page is accessed
> > > > second time, it can move to active.
> > >
> > > Yes. To clarify, the A-bit doesn't really mean the first or second
> > > access. It can be many accesses each time it's set.
> > >
> > > > "In current implementation, newly created or swap-in anonymous page is
> > > >
> > > > started on the active list. Growing the active list results in rebalancing
> > > > active/inactive list so old pages on the active list are demoted to the
> > > > inactive list. Hence, hot page on the active list isn't protected at all.
> > > >
> > > > Following is an example of this situation.
> > > >
> > > > Assume that 50 hot pages on active list and system can contain total
> > > > 100 pages. Numbers denote the number of pages on active/inactive
> > > > list (active | inactive). (h) stands for hot pages and (uo) stands for
> > > > used-once pages.
> > > >
> > > > 1. 50 hot pages on active list
> > > > 50(h) | 0
> > > >
> > > > 2. workload: 50 newly created (used-once) pages
> > > > 50(uo) | 50(h)
> > > >
> > > > 3. workload: another 50 newly created (used-once) pages
> > > > 50(uo) | 50(uo), swap-out 50(h)
> > > >
> > > > As we can see, hot pages are swapped-out and it would cause swap-in later."
> > > >
> > > > Is MGLRU able to avoid the swap-out of the 50 hot pages?
> > >
> > > I think the real question is why the 50 hot pages can be moved to the
> > > inactive list. If they are really hot, the A-bit should protect them.
> >
> > This is a good question.
> >
> > I guess it  is probably because the current lru is trying to maintain a balance
> > between the sizes of active and inactive lists. Thus, it can shrink active list
> > even though pages might be still "hot" but not the recently accessed ones.
> >
> > 1. 50 hot pages on active list
> > 50(h) | 0
> >
> > 2. workload: 50 newly created (used-once) pages
> > 50(uo) | 50(h)
> >
> > 3. workload: another 50 newly created (used-once) pages
> > 50(uo) | 50(uo), swap-out 50(h)
> >
> > the old kernel without anon workingset protection put workload 2 on active, so
> > pushed 50 hot pages from active to inactive. workload 3 would further contribute
> > to evict the 50 hot pages.
> >
> > it seems mglru doesn't demote pages from the youngest generation to older
> > generation only in order to balance the list size? so mglru is probably safe
> > in these cases.
> >
> > I will run some tests mentioned in Kim's patchset and report the result to you
> > afterwards.
> >
>
> Hi Yu,
> I did find putting faulted pages to the youngest generation lead to some
> regression in the case ebizzy Kim's patchset mentioned while he tried
> to support workingset protection for anon pages.
> i did a little bit modification for rand_chunk() which is probably similar
> with the modifcation() Kim mentioned in his patchset. The modification
> can be found here:
> https://github.com/21cnbao/ltp/commit/7134413d747bfa9ef
>
> The test env is a x86 machine in which I have set memory size to 2.5GB and
> set zRAM to 2GB and disabled external disk swap.
>
> with the vanilla kernel:
> \time -v ./a.out -vv -t 4 -s 209715200 -S 200000
>
> so we have 10 chunks and 4 threads, each trunk is 209715200(200MB)
>
> typical result:
>         Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
>         User time (seconds): 36.19
>         System time (seconds): 229.72
>         Percent of CPU this job got: 371%
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 1:11.59
>         Average shared text size (kbytes): 0
>         Average unshared data size (kbytes): 0
>         Average stack size (kbytes): 0
>         Average total size (kbytes): 0
>         Maximum resident set size (kbytes): 2166196
>         Average resident set size (kbytes): 0
>         Major (requiring I/O) page faults: 9990128
>         Minor (reclaiming a frame) page faults: 33315945
>         Voluntary context switches: 59144
>         Involuntary context switches: 167754
>         Swaps: 0
>         File system inputs: 2760
>         File system outputs: 8
>         Socket messages sent: 0
>         Socket messages received: 0
>         Signals delivered: 0
>         Page size (bytes): 4096
>         Exit status: 0
>
> with gen_lru and lru_gen/enabled=0x3:
> typical result:
> Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> User time (seconds): 36.34
> System time (seconds): 276.07
> Percent of CPU this job got: 378%
> Elapsed (wall clock) time (h:mm:ss or m:ss): 1:22.46
>            **** 15% time +
> Average shared text size (kbytes): 0
> Average unshared data size (kbytes): 0
> Average stack size (kbytes): 0
> Average total size (kbytes): 0
> Maximum resident set size (kbytes): 2168120
> Average resident set size (kbytes): 0
> Major (requiring I/O) page faults: 13362810
>              ***** 30% page fault +
> Minor (reclaiming a frame) page faults: 33394617
> Voluntary context switches: 55216
> Involuntary context switches: 137220
> Swaps: 0
> File system inputs: 4088
> File system outputs: 8
> Socket messages sent: 0
> Socket messages received: 0
> Signals delivered: 0
> Page size (bytes): 4096
> Exit status: 0
>
> with gen_lru and lru_gen/enabled=0x7:
> typical result:
> Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> User time (seconds): 36.13
> System time (seconds): 251.71
> Percent of CPU this job got: 378%
> Elapsed (wall clock) time (h:mm:ss or m:ss): 1:16.00
>          *****better than enabled=0x3, worse than vanilla
> Average shared text size (kbytes): 0
> Average unshared data size (kbytes): 0
> Average stack size (kbytes): 0
> Average total size (kbytes): 0
> Maximum resident set size (kbytes): 2120988
> Average resident set size (kbytes): 0
> Major (requiring I/O) page faults: 12706512
> Minor (reclaiming a frame) page faults: 33422243
> Voluntary context switches: 49485
> Involuntary context switches: 126765
> Swaps: 0
> File system inputs: 2976
> File system outputs: 8
> Socket messages sent: 0
> Socket messages received: 0
> Signals delivered: 0
> Page size (bytes): 4096
> Exit status: 0
>
> I can also reproduce the problem on arm64.
>
> I am not saying this is going to block mglru from being mainlined. But  I am
> still curious if this is an issue worth being addressed somehow in mglru.

You've missed something very important: *thoughput* :)

Dollars to doughnuts there was a large increase in throughput -- I
haven't tried this benchmark but I've seen many reports similar to
this one.
