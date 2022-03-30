Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B24EBD47
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbiC3JLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbiC3JLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:11:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94A51D8331
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:09:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so21751027ejs.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2B7F41ws4olLWAaIXnAdGV8fIlHulrUokTuiMGzfmnw=;
        b=FzR/KbCmNwWMlmFy0d61cIFF+xES/VqpAoijU7PVL0MLqCr1pxhjRNBHkzDXqLFPmg
         +1QNSshW5SfY2XhlByHFG0ssVgSe6NrL6oTVRg+bPuyio9MRaa2zvcRXmWWJCP0O/UUQ
         tdsEbVr2VVNavvm+lFcBGmAP5N0ZJo6v35B/Rb9rjHvZ428TE55cxXdysaG6B9t3dzqc
         RlBCsc3o/ermfPND5HrwBtKVCX6eu7/nWynDLaMAaLmTT3JboNjgENtMxlsPYNxIcfpz
         jO3q5VKHK+dFj/7MJnys7XgwnxgGU/qaBGjjP2L9FVWFPHIGCLqrVttfx+AbckPIbeKX
         u/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2B7F41ws4olLWAaIXnAdGV8fIlHulrUokTuiMGzfmnw=;
        b=qp3t5E/eKMr/zYoDjn4fWyZas90SA2mNElWapnjEzOJ9isSih/AHhgsxjP1CdlejgP
         SNF8tIbDN3Kzs5NQA1BfaCc/5yB7X2iA21Rk6uOiyzx7ASEAeYGzcCitgK6YkHc4Z+q5
         99b/IvpV+4nV0+ieKN3xYn0SAf5z0gSq0ACttVwCZR95koyz5MfTuysvOSZMc9tNgW9+
         fPJIZa9vX9H8Hg3mPvd2tJ9lpUpBJNX5YV5QeGz8RmFnMWvUGcnMIu5YqVqJTYXX0MqE
         EY/665uBJSLNClf2VEdXhKhtSB4ThAfEdhHb5kkVYXiHbjrqLeAY28hW1Xx7npvggSUk
         exWQ==
X-Gm-Message-State: AOAM5336PSHt4XV36Ii+MtT9vk962CFhjUaPyoSjDpZ5463lUTczoRK5
        kvo+DzbFDH6M8GwI3BPDgPJu8IHDkeXKA71dWs8=
X-Google-Smtp-Source: ABdhPJzOqkMoif51zT1EA5s03BklIZ8II21tK0zwJ6ibs0HOvImhSlTORDyrO6i0FZkvJUebj2vqYqjnZf2rBRTbh50=
X-Received: by 2002:a17:907:94d5:b0:6e0:2924:bd54 with SMTP id
 dn21-20020a17090794d500b006e02924bd54mr37982877ejc.170.1648631373078; Wed, 30
 Mar 2022 02:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220329045535.45641-1-songmuchun@bytedance.com>
 <CAGsJ_4w0N9GiKfZe6t+XxVUHvBOoF2Fk8tfuy5gD6Lg2s_q5iw@mail.gmail.com> <CAMZfGtVOXx+tuGCtHzjnT+EXkswy1hzqwxe=W+pxZaHC5CrbmQ@mail.gmail.com>
In-Reply-To: <CAMZfGtVOXx+tuGCtHzjnT+EXkswy1hzqwxe=W+pxZaHC5CrbmQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 30 Mar 2022 22:09:21 +1300
Message-ID: <CAGsJ_4zBJDCPEFA9TOSFBfOFYmohiJo5cJZ3=9e+5OZjnZ0eWg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] arm64: mm: hugetlb: add support for free
 vmemmap pages of HugeTLB
To:     Muchun Song <songmuchun@bytedance.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 7:53 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Mar 29, 2022 at 7:44 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 5:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The feature of minimizing overhead of struct page associated with each
> > > HugeTLB page aims to free its vmemmap pages (used as struct page) to
> > > save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
> > > In short, when a HugeTLB page is allocated or freed, the vmemmap array
> > > representing the range associated with the page will need to be remapped.
> > > When a page is allocated, vmemmap pages are freed after remapping.
> > > When a page is freed, previously discarded vmemmap pages must be
> > > allocated before remapping.  More implementations and details can be
> > > found here [1].
> > >
> > > The preparation of freeing vmemmap pages associated with each HugeTLB
> > > page is ready, so we can support this feature for arm64 now.  The
> > > flush_dcache_page() need to be adapted to operate on the head page's
> > > flags since the tail vmemmap pages are mapped with read-only after
> > > the feature is enabled (clear operation is not permitted).
> > >
> > > There was some discussions about this in the thread [2], but there was
> > > no conclusion in the end.  And I copied the concern proposed by Anshuman
> > > to here.
> > >
> > > 1st concern:
> > > '''
> > > But what happens when a hot remove section's vmemmap area (which is
> > > being teared down) is nearby another vmemmap area which is either created
> > > or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> > > HugeTLB pages inside the hot remove section might be safe. But what about
> > > other HugeTLB areas whose vmemmap area shares page table entries with
> > > vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> > > /use/free test cycle using memory just adjacent to a memory hotplug area,
> > > which is always added and removed periodically, should be able to expose
> > > this problem.
> > > '''
> > >
> > > Answer: At the time memory is removed, all HugeTLB pages either have been
> > > migrated away or dissolved.  So there is no race between memory hot remove
> > > and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> > > remove section is safe.  Let's talk your question "what about other
> > > HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> > > entries for a section being hot removed ?", the question is not
> > > established.  The minimal granularity size of hotplug memory 128MB (on
> > > arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> > > then, there is no share PTE page tables between HugeTLB in this section
> > > and ones in other sections and a HugeTLB page could not cross two
> > > sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
> > > than 128MB (section size) whose vmemmap pages is an integer multiple of
> > > 2MB (PMD-mapped).  As long as:
> > >
> > >   1) HugeTLBs are naturally aligned, power-of-two sizes
> > >   2) The HugeTLB size >= the section size
> > >   3) The HugeTLB size >= the vmemmap leaf mapping size
> > >
> > > Then a HugeTLB will not share any leaf page table entries with *anything
> > > else*, but will share intermediate entries.  In this case, at the time memory
> > > is removed, all HugeTLB pages either have been migrated away or dissolved.
> > > So there is also no race between memory hot remove and
> > > free_huge_page_vmemmap().
> > >
> > > 2nd concern:
> > > '''
> > > differently, not sure if ptdump would require any synchronization.
> > >
> > > Dumping an wrong value is probably okay but crashing because a page table
> > > entry is being freed after ptdump acquired the pointer is bad. On arm64,
> > > ptdump() is protected against hotremove via [get|put]_online_mems().
> > > '''
> > >
> > > Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> > > PTEs or split the PMD entry (which means allocating a PTE page table).  Both
> > > operations do not free any page tables (PTE), so ptdump cannot run into a
> > > UAF on any page tables.  The wrost case is just dumping an wrong value.
> > >
> > > [1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
> > > [2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > > Changes in v2:
> > >  - Update commit message (Mark Rutland).
> > >  - Fix flush_dcache_page().
> > >
> > >  arch/arm64/mm/flush.c | 14 ++++++++++++++
> > >  fs/Kconfig            |  2 +-
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> > > index a06c6ac770d4..705484a9b9df 100644
> > > --- a/arch/arm64/mm/flush.c
> > > +++ b/arch/arm64/mm/flush.c
> > > @@ -75,6 +75,20 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
> > >   */
> > >  void flush_dcache_page(struct page *page)
> > >  {
> > > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > +       /*
> > > +        * Only the head page's flags of HugeTLB can be cleared since the tail
> > > +        * vmemmap pages associated with each HugeTLB page are mapped with
> > > +        * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> > > +        * details can refer to vmemmap_remap_pte()).  Although
> > > +        * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> > > +        * page struct, some tail page structs still can see the flag since
> > > +        * the head vmemmap page frame is reused (more details can refer to
> > > +        * the comments above page_fixed_fake_head()).
> >
> > Is this still true if hugetlb_free_vmemmap_enabled() is false?
>
> No.  Do you think it is better to add hugetlb_free_vmemmap_enabled()
> into the if block? Something like the following?

yep, with if (hugetlb_free_vmemmap_enabled() && PageHuge(page)), i guess
we won't need the "ifdef" any more?

>
> +       if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
> +               page = compound_head(page);
>
> >
> > btw, the subject is a bit confusing as it seems it is not bringing up
> > HUGETLB_PAGE_FREE_VMEMMAP and it seems the feature
> > has been already there, but we are lacking some fixes for some
> > functions to make it work.
>
> Right.
>
> > could we explain this clear in commit
> > log? maybe we need a better subject for the commit as well.
>
> Will do.

Thanks
Barry
