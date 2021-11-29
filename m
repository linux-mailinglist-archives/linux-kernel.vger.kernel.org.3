Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D946278B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhK2XHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbhK2XG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:06:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED6C0619F6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:00:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so77910323edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDj0nzcuRDly52WMkwodqc8P+jjNvobWA2uTqdrNv5o=;
        b=qKAi0Ch5nKEinDNsEEUwAjViyY/6TLgk9gXpCC4hanJJoxnC8Y3mJs3NqYidCVGQC3
         TW8j/ZsGOk1AMgrevtGrxG4XEeuthvsHEL+6lSOl/V2mbJ/ti0Bd9qGNOND6ygTbE+Hj
         t6JbS9poPcQ0vhsPoQx7EdVAYi5Q66/EJRS3iStI1qpmudeah7pe0VYOpzVZhHJanp0u
         v4fAJPT8C1KmWwJwfvMAhJekM4uj+ejh3qqdvVKYKVzpNlMUPUJHZ8LStWD2VXhj0pyZ
         rPpJFMjbMiAdtFdpkwJ+Oaspp/GGv83eV08/yz8zxSe0MPgLssiP1aEx/AwOHEfMyQRL
         9/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDj0nzcuRDly52WMkwodqc8P+jjNvobWA2uTqdrNv5o=;
        b=rhU/7ZhlFV5HLiHqLrWXGIWlGgrPeznWFg/6MNODr0CbV6Wb8B+BHnlR3u/KQr7Slt
         ZHaBiC188LCCF3PeIAtRvBg9EIZCifLm61VEKSfxSJZ7GMX1vjEDSNng7h5Qe/ZDlI8w
         FYVyc/CGroNqfxziJ0eeiPLtxjjyXFDSCGIr3R1YIRaRXFoTYZ0q2yHS6a5lo4Ojitf7
         H45TLwpfi4Wz3oFmOF5ox0IodQPPKUty96lfsGNbLBU/3VNEEtYaUzLqRUJOLsYUQ+Qw
         gxvlpa6NXNTUt9E+RJs7jqzHuVslBOfuk/GPKEw8XsA5h7X3y0/g5ixot6hi4CNQeA82
         GNqA==
X-Gm-Message-State: AOAM532+ZJevwROmlI9en4Fngpe33VIXK/1WmR9DCWC0V6Yw04sjkzgD
        C9xBmjWvs2KN8LovzvFsBZuzFcAK17E2agtJQc+bunq5
X-Google-Smtp-Source: ABdhPJxxF18HfZMLiBVrEspxeELYHKKpBevRYheN+hp0gZlQqJQeH9uIr/seIMC7Pq5MvzKqq1ov6hx92Z9ejb89LVo=
X-Received: by 2002:a05:6402:35d2:: with SMTP id z18mr77230706edc.188.1638223253558;
 Mon, 29 Nov 2021 14:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local> <57d649c8-fe13-17cd-8819-2cd93500a79c@redhat.com>
 <YaBL1Ti+XnzG+fdK@xz-m1.local> <d068c48d-897d-238b-010c-056951c9e3f1@redhat.com>
In-Reply-To: <d068c48d-897d-238b-010c-056951c9e3f1@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 29 Nov 2021 14:00:40 -0800
Message-ID: <CAHbLzkpT3cU0PfmD2LeM9LuYjUhZhArRHxaP7JAU0koeDSXHvw@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "George G. Davis" <davis.george@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 26.11.21 03:52, Peter Xu wrote:
> > On Thu, Nov 25, 2021 at 11:32:08AM +0100, David Hildenbrand wrote:
> >> On 25.11.21 11:24, Peter Xu wrote:
> >>> On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
> >>>>> Do we have a performance evaluation how much overhead is added e.g., for
> >>>>> a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
> >>>>> covers the whole THP?
> >>>>
> >>>> I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> >>>> x86 for both settings you suggested. I don't see any statistically
> >>>> significant difference with and without the patch. Let me know if you
> >>>> want me to try something else.
> >>>
> >>> I'm a bit surprised that sync split thp didn't bring any extra overhead.
> >>>
> >>> "unmap whole thp" is understandable from that pov, because afaict that won't
> >>> even trigger any thp split anyway even delayed, if this is the simplest case
> >>> that only this process mapped this thp, and it mapped once.
> >>>
> >>> For "unmap 4k upon thp" IIUC that's the worst case and zapping 4k should be
> >>> fast; while what I don't understand since thp split requires all hand-made work
> >>> for copying thp flags into small pages and so on, so I thought there should at
> >>> least be some overhead measured.  Shakeel, could there be something overlooked
> >>> in the test, or maybe it's me that overlooked?
> >>>
> >>> I had the same concern as what Kirill/Matthew raised in the other thread - I'm
> >>> worried proactively splitting simply because any 4k page is zapped might
> >>> quickly free up 2m thps in the system and I'm not sure whether it'll exaggerate
> >>> the defragmentation of the system memory in general.  I'm also not sure whether
> >>> that's ideal for some very common workload that frequently uses DONTNEED to
> >>> proactively drop some pages.
> >>
> >> The pageblock corresponding to the THP is movable. So (unless we start
> >> spilling unmovable allocations into movable pageblocks) we'd only place
> >> movable allocations in there. Compaction will be able to migrate to
> >> re-create a free THP.
> >>
> >> In contrast I think, compaction will happily skip over the THP and
> >> ignore it, because it has no clue that the THP could be repurposed by
> >> split+migrate (at least I am not aware of code that does it).
> >>
> >> Unless I am missing something, with the above in mind it could make
> >> sense to split as soon as possible, even before we're under memory
> >> pressure -- for example, for proactive compaction.
> >>
> >> [proactive compaction could try splitting first as well I think]
> >
> > But we can't rely on proactive compaction for rapid operations, because it's
> > still adding overhead to the overall system by split+merge, right?
>
> Yes, but there is also direct compaction that can be triggered without
> the shrinker getting involved. I think we can summarize as "there might
> not be a right or wrong when to split". An application that
> MADV_DONTNEEDs/munmap sub-THP memory told us that it doesn't want to
> consume memory, yet it looks like it's still consuming that memory.
>
> I do wonder how THP on the deferred split queue behave in respect to
> page migration -- memory offlining, alloc_contig_range(). I saw reports

IIUC the old page that is on deferred split queue would be freed and
off the list once the migration is done. But the new page is *NOT*
added to the deferred split list at all. This would not cause any
severe bugs but the partial unmapped pages can no longer be shrunk
under memory pressure.

> that there are some cases where THP can be problematic when
> stress-testing THP:
> https://lkml.kernel.org/r/20210903162102.GA10039@mam-gdavis-dt
>
> But not sure if that's related to deferred splitting. Most probably not.
>
> >
> > +compaction_proactiveness
> > +========================
> > + ...
> > +Note that compaction has a non-trivial system-wide impact as pages
> > +belonging to different processes are moved around, which could also lead
> > +to latency spikes in unsuspecting applications. The kernel employs
> > +various heuristics to avoid wasting CPU cycles if it detects that
> > +proactive compaction is not being effective.
> >
> > Delaying split makes sense to me because after all the kernel is not aware of
> > the userspace's preference, so the best thing is to do nothing until necessary.
> >
> > Proactively split thps in dontneed/unmap added an assumption that the userspace
> > wants to break the pages by default.  It's 100% true for Shakeel's use case,
> > but I'm not sure whether it may always be true.  That's why I thought maybe a
> > new interface is more proper, so we at least won't break anyone by accident.
>
> Well, we already broke the PMD into PTEs. So the performance gain at
> least for that user is really gone until we "fix that" again via
> khugepaged -- which might just be configured to not "fix" if there are
> empty PTEs.
>
> It for sure is interesting if you have a COW huge page and only one
> party zaps/unmaps some part.
>
>
> --
> Thanks,
>
> David / dhildenb
>
