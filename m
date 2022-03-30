Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880644EBD90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiC3JYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244752AbiC3JYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:24:17 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387F2AE0B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:22:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f23so5485746ybj.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRrIK5N+Q+AEGW6Tu4MvidUz4zKwJfjQy08AHRYU2uA=;
        b=guxZSIk3deqDwqfmjze7NFNDyeJrJ/ZozEHF0+SfBuGei107YDjc55k6Mln4WLzhUw
         +zdqvGuLAwhmYyZRL13dnQrZJcf9VVaTlAvP8hl9H4/CznxZXgOQB1qPh9//btBrLgFD
         aibvMYJlktyIS0j6E12OFJ2yUCw1K1gdIHwUULWoJjOsW4nVQ53eUHNEhKEY2uHGGQVp
         vLeKNcAIUNtukg9olmdxE3CGjo9N1/OedVkNddCvQwGUvJzO+kHVt7Mrjrvj1ftpGU4P
         iRgV6Yjo3Ck0U1hWy36N+xMoETZx+CbkwRjsmLLuABs6zUhMN3qGOBvQrWHqonCcuJME
         u+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRrIK5N+Q+AEGW6Tu4MvidUz4zKwJfjQy08AHRYU2uA=;
        b=AUyOdUdfavc0kzgy5NI/4TZOd2BW6HWy+t8dNIVX9ZUFF0NvBazgWFG4Pvfy6MJXPu
         6B+5RAKoEmk0VVfMU31PGLnnwQ0njmTzB9YjxV0M/dSV7tRvijtzQWeq9oFYVpd/Iart
         7aZDhMM7L3J+mNLcc3cxTRoRGcMo+DRvV37gP4Ohhtak3YZaVNwFkMUhyfU8ZbGE4/1w
         ni0XtXZXWxCOQ37rifMJzzjZnGjy6ijn8H94PDI4Dsv46p1do8wXTZ03BiUQufUcKDKJ
         cRWO9FZc9b/ZBvfuaBa5UiUYRLNUGb7t1/EU+Zl2seWjGnMisTKXr7bCHwrnG7AZG3Sg
         p6jA==
X-Gm-Message-State: AOAM532qR5ECi9Loys1hd6ME5FMKFX+bDwKXZU4WF5LdOd+X1pTUzqS5
        lmbyU81t8QiksaaMun/ymMJaXiQueUW/xqcbo7sH1w==
X-Google-Smtp-Source: ABdhPJyXXERRRSl4GtKPMWC/uxX947XRiztsO+zmxI2F4O1P9HxxViHz9Sox7plqehvtLWCDlCL9nlFM9s+om+S/DSU=
X-Received: by 2002:a05:6902:70c:b0:634:73ef:e663 with SMTP id
 k12-20020a056902070c00b0063473efe663mr33181480ybt.246.1648632151425; Wed, 30
 Mar 2022 02:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220329045535.45641-1-songmuchun@bytedance.com>
 <CAGsJ_4w0N9GiKfZe6t+XxVUHvBOoF2Fk8tfuy5gD6Lg2s_q5iw@mail.gmail.com>
 <CAMZfGtVOXx+tuGCtHzjnT+EXkswy1hzqwxe=W+pxZaHC5CrbmQ@mail.gmail.com> <CAGsJ_4zBJDCPEFA9TOSFBfOFYmohiJo5cJZ3=9e+5OZjnZ0eWg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zBJDCPEFA9TOSFBfOFYmohiJo5cJZ3=9e+5OZjnZ0eWg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 30 Mar 2022 17:21:55 +0800
Message-ID: <CAMZfGtV6PbMahwNTKQeDWAwGeb+K0fr8gpL7Ys7SBO0yv+OdQw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] arm64: mm: hugetlb: add support for free
 vmemmap pages of HugeTLB
To:     Barry Song <21cnbao@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 5:09 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Mar 30, 2022 at 7:53 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 7:44 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Tue, Mar 29, 2022 at 5:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > The feature of minimizing overhead of struct page associated with each
> > > > HugeTLB page aims to free its vmemmap pages (used as struct page) to
> > > > save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
> > > > In short, when a HugeTLB page is allocated or freed, the vmemmap array
> > > > representing the range associated with the page will need to be remapped.
> > > > When a page is allocated, vmemmap pages are freed after remapping.
> > > > When a page is freed, previously discarded vmemmap pages must be
> > > > allocated before remapping.  More implementations and details can be
> > > > found here [1].
> > > >
> > > > The preparation of freeing vmemmap pages associated with each HugeTLB
> > > > page is ready, so we can support this feature for arm64 now.  The
> > > > flush_dcache_page() need to be adapted to operate on the head page's
> > > > flags since the tail vmemmap pages are mapped with read-only after
> > > > the feature is enabled (clear operation is not permitted).
> > > >
> > > > There was some discussions about this in the thread [2], but there was
> > > > no conclusion in the end.  And I copied the concern proposed by Anshuman
> > > > to here.
> > > >
> > > > 1st concern:
> > > > '''
> > > > But what happens when a hot remove section's vmemmap area (which is
> > > > being teared down) is nearby another vmemmap area which is either created
> > > > or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> > > > HugeTLB pages inside the hot remove section might be safe. But what about
> > > > other HugeTLB areas whose vmemmap area shares page table entries with
> > > > vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> > > > /use/free test cycle using memory just adjacent to a memory hotplug area,
> > > > which is always added and removed periodically, should be able to expose
> > > > this problem.
> > > > '''
> > > >
> > > > Answer: At the time memory is removed, all HugeTLB pages either have been
> > > > migrated away or dissolved.  So there is no race between memory hot remove
> > > > and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> > > > remove section is safe.  Let's talk your question "what about other
> > > > HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> > > > entries for a section being hot removed ?", the question is not
> > > > established.  The minimal granularity size of hotplug memory 128MB (on
> > > > arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> > > > then, there is no share PTE page tables between HugeTLB in this section
> > > > and ones in other sections and a HugeTLB page could not cross two
> > > > sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
> > > > than 128MB (section size) whose vmemmap pages is an integer multiple of
> > > > 2MB (PMD-mapped).  As long as:
> > > >
> > > >   1) HugeTLBs are naturally aligned, power-of-two sizes
> > > >   2) The HugeTLB size >= the section size
> > > >   3) The HugeTLB size >= the vmemmap leaf mapping size
> > > >
> > > > Then a HugeTLB will not share any leaf page table entries with *anything
> > > > else*, but will share intermediate entries.  In this case, at the time memory
> > > > is removed, all HugeTLB pages either have been migrated away or dissolved.
> > > > So there is also no race between memory hot remove and
> > > > free_huge_page_vmemmap().
> > > >
> > > > 2nd concern:
> > > > '''
> > > > differently, not sure if ptdump would require any synchronization.
> > > >
> > > > Dumping an wrong value is probably okay but crashing because a page table
> > > > entry is being freed after ptdump acquired the pointer is bad. On arm64,
> > > > ptdump() is protected against hotremove via [get|put]_online_mems().
> > > > '''
> > > >
> > > > Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> > > > PTEs or split the PMD entry (which means allocating a PTE page table).  Both
> > > > operations do not free any page tables (PTE), so ptdump cannot run into a
> > > > UAF on any page tables.  The wrost case is just dumping an wrong value.
> > > >
> > > > [1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
> > > > [2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > > Changes in v2:
> > > >  - Update commit message (Mark Rutland).
> > > >  - Fix flush_dcache_page().
> > > >
> > > >  arch/arm64/mm/flush.c | 14 ++++++++++++++
> > > >  fs/Kconfig            |  2 +-
> > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> > > > index a06c6ac770d4..705484a9b9df 100644
> > > > --- a/arch/arm64/mm/flush.c
> > > > +++ b/arch/arm64/mm/flush.c
> > > > @@ -75,6 +75,20 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
> > > >   */
> > > >  void flush_dcache_page(struct page *page)
> > > >  {
> > > > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > +       /*
> > > > +        * Only the head page's flags of HugeTLB can be cleared since the tail
> > > > +        * vmemmap pages associated with each HugeTLB page are mapped with
> > > > +        * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> > > > +        * details can refer to vmemmap_remap_pte()).  Although
> > > > +        * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> > > > +        * page struct, some tail page structs still can see the flag since
> > > > +        * the head vmemmap page frame is reused (more details can refer to
> > > > +        * the comments above page_fixed_fake_head()).
> > >
> > > Is this still true if hugetlb_free_vmemmap_enabled() is false?
> >
> > No.  Do you think it is better to add hugetlb_free_vmemmap_enabled()
> > into the if block? Something like the following?
>
> yep, with if (hugetlb_free_vmemmap_enabled() && PageHuge(page)), i guess
> we won't need the "ifdef" any more?

Right. Will do.
