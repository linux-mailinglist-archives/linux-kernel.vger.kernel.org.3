Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B147348D253
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiAMG2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiAMG2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:28:46 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35EAC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:28:45 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c6so12236376ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdjffI2T5RQy9Fhj4zBGCPcU9B4inFX0s175+8/fA+U=;
        b=mkc7Fx2U+lFgpGEhhkWswpNHjp6VUEmh5OfB8VaEfpWP77PTBvjXtKlkhDBwfS7zu4
         HELs1yPHLU68FOH7AZal/9wXLunwzAfhz+fW2DmaMqqT2yr5QOx6npCoi0Q4TOrRmGE0
         hP9jE5m/btPaRvL3ibgFqFqMpsP83V/ks896J+PfNE1FsbHFqoa3R6T1DK5ugrwBCXMy
         UxpaXVZ/fzQLVgP0g2WkBNAWPtUYCZoslbqjJLYfjdcd6D9zOmkiSSQvOagRLmKFuC4l
         S+yYh+d61V3V/mkM3LAoC2xesB0v1eZBELnoQazcETCoy9KjqlWqMJkOitT9GvIdGpmt
         R6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdjffI2T5RQy9Fhj4zBGCPcU9B4inFX0s175+8/fA+U=;
        b=1+Z4q0AEfjl9vdCt5NdIoCj+xux58Y2Zlwt9m6l5+tJQaZQU1vuagXlXjw/tjPKuj5
         u9yoi+0uwJF2cTrTonr8oat0GnHzG7xajet5cNaN1uu4m68un1Axo5DE+24OWUo2iBNr
         o/bg/Db3nVDrkPH1z4Vo1ZxL0pCb8KQBQCK8RGo6XXQttXxuMRNqkIwTG9LAc0byGfjW
         tRo7ocb1NEwog3WH3ghCvU1Jo+Ni3SQeykNatsWO+mHz0SFmBnM1NqM9UOI0F8a6Ir69
         q/qD/ve5/UNa+ahJsCvoIh75fJhjIGWQJbIVhwAjB3bgYcLtXkDz0RCLopDBRV4zq5oO
         lY1w==
X-Gm-Message-State: AOAM532vlrog4fvmlexIdZGuZgemQCDZCIlieSYiS5BGtACbyvrBJtdM
        jMzRaQTGzQNejUXOBUfygyH89x8+LLGs8tPPcV8mxA==
X-Google-Smtp-Source: ABdhPJyrJaJhgs/1cBvU8PqRSgRNTV6Wse4sswNuBXOO2NA8diqbz+VreoH33Ej/KjbqbW7AmkdcSkvUX57bLoTPcgU=
X-Received: by 2002:a25:6d09:: with SMTP id i9mr96060ybc.703.1642055324532;
 Wed, 12 Jan 2022 22:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20220111131652.61947-1-songmuchun@bytedance.com> <Yd7DNesaCACPndv2@FVFF77S0Q05N>
In-Reply-To: <Yd7DNesaCACPndv2@FVFF77S0Q05N>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 13 Jan 2022 14:28:08 +0800
Message-ID: <CAMZfGtUWWvxFkstCEv+wubrP0==Kob=NsxwZ-qw-953hEoZntA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 8:02 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> On Tue, Jan 11, 2022 at 09:16:52PM +0800, Muchun Song wrote:
> > The preparation of supporting freeing vmemmap associated with each
> > HugeTLB page is ready, so we can support this feature for arm64.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> It's a bit difficult to understand this commit message, as there's not much
> context here.

Hi Mark,

My bad. More infos can be found here [1].

[1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/T/#u

>
> What is HUGETLB_PAGE_FREE_VMEMMAP intended to achieve? Is this intended to save
> memory, find bugs, or some other goal? If this is a memory saving or
> performance improvement, can we quantify that benefit?

It is for memory saving. It can save about 12GB or 16GB per 1TB HugeTLB
pages (2MB or 1GB type).

>
> Does the alloc/free happen dynamically, or does this happen once during kernel
> boot? IIUC it's the former, which sounds pretty scary. Especially if we need to
> re-allocate the vmmemmap pages later -- can't we run out of memory, and then
> fail to free a HugeTLB page?

Right. The implementations about this can found in commit:

  ad2fa3717b74994 ("mm: hugetlb: alloc the vmemmap pages associated
with each HugeTLB page")

>
> Are there any requirements upon arch code, e.g. mutual exclusion?

No. The implementation is generic. There is no architecture specific code
needed to be implemented.

>
> Below there are a bunch of comments trying to explain that this is safe. Having
> some of that rationale in the commit message itself would be helpful.
>
> I see that commit:
>
>   6be24bed9da367c2 ("mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP")
>
> ... has a much more complete description, and cribbing some of that wording
> would be helpful.

Will do in the next version once we are on the same page about this feature.

>
>
> > ---
> > There is already some discussions about this in [1], but there was no
> > conclusion in the end. I copied the concern proposed by Anshuman to here.
> >
> > 1st concern:
> > "
> >   But what happens when a hot remove section's vmemmap area (which is being
> >   teared down) is nearby another vmemmap area which is either created or
> >   being destroyed for HugeTLB alloc/free purpose. As you mentioned HugeTLB
> >   pages inside the hot remove section might be safe. But what about other
> >   HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> >   entries for a section being hot removed ? Massive HugeTLB alloc/use/free
> >   test cycle using memory just adjacent to a memory hotplug area, which is
> >   always added and removed periodically, should be able to expose this problem.
> > "
> > My Answer: As you already know HugeTLB pages inside the hot remove section
> > is safe.
>
> It would be helpful if you could explain *why* that's safe, since those of us
> coming at this cold have no idea whether this is the case.

At the time memory is removed, all huge pages either have been migrated
away or dissolved. So there is no race between memory hot remove and
free_huge_page_vmemmap().

>
> > Let's talk your question "what about other HugeTLB areas whose
> > vmemmap area shares page table entries with vmemmap entries for a section
> > being hot removed ?", the question is not established. Why? The minimal
> > granularity size of hotplug memory 128MB (on arm64, 4k base page), so any
> > HugeTLB smaller than 128MB is within a section, then, there is no share
> > (PTE) page tables between HugeTLB in this section and ones in other
> > sections and a HugeTLB could not cross two sections.
>
> Am I correct in assuming that in this case we never free the section?

Right. So there is no race between memory hot remove and
free_huge_page_vmemmap() as well.

>
> > Any HugeTLB bigger than 128MB (e.g. 1GB) whose size is an integer multible of
> > a section and vmemmap area is also an integer multiple of 2MB. At the time
> > memory is removed, all huge pages either have been migrated away or
> > dissolved. The vmemmap is stable. So there is no problem in this case as
> > well.
>
> Are you mention 2MB here because we PMD-map the vmemmap with 4K pages?

Right.

>
> IIUC, so long as:
>
> 1) HugeTLBs are naturally aligned, power-of-two sizes
> 2) The HugeTLB size >= the section size
> 3) The HugeTLB size >= the vmemmap leaf mapping size
>
> ... then a HugeTLB will not share any leaf page table entries with *anything
> else*, but will share intermediate entries.

Right.

>
> Perhaps that's a clearer line of argument?
>
> Regardless, this should be in the commit message.

Will do.

>
> > 2nd concern:
> > "
> >   differently, not sure if ptdump would require any synchronization.
> >
> >   Dumping an wrong value is probably okay but crashing because a page table
> >   entry is being freed after ptdump acquired the pointer is bad. On arm64,
> >   ptdump() is protected against hotremove via [get|put]_online_mems().
> > "
> > My Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> > PTEs or split the PMD entry (which means allocating a PTE page table). Both
> > operations do not free any page tables, so ptdump cannot run into a UAF on
> > any page tables. The wrost case is just dumping an wrong value.
>
> This should be in the commit message.
>

Will do.

Thanks.
