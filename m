Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E394EE40C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242464AbiCaWdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242490AbiCaWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:33:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA41AF7F7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:31:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x34so913732ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xgVcu9j5c2ItfbLp0oKIvhzdP016kYM1iF4XEnr1tk=;
        b=UZzTpRaYuECj8W5XZEbEkRhUIePMuieS2Iy+/a2a+Z2AeM5s+mWJz4H8YO2iVvU2OS
         dzH6Jy32s0T08bhpyrgH7XyCGPGwRsYfoKjEghsD5gYaIfvmQYzBT710fUnT7mHLAdS5
         GZGPvZ2VeuIcv4ROLzAw+vWbRYbY3plaTIPxyi46LnA5P0EZRNyu9aQu14j5V8A9wvaA
         u7bkw0G7xv3SurTjYOXW5WWqG6e1HFsp1Chw0j+4ua8z7H7BhexF8ScWVVFsHRQ5vJ8b
         AHu4RlnqR4TglnvtecenrqwTUgYo+JbGi3Us/pzqssZIRQnOwA9yWZ3YpJXZtihw+jpM
         S1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xgVcu9j5c2ItfbLp0oKIvhzdP016kYM1iF4XEnr1tk=;
        b=gxi3woYHiEaxr+hNVeEmDpBhLjutZYkQpdGN6CQpF9UY3q3OFrjN8M3PMoEBRfWzRp
         Y8r0b3EkVjshk/eNDXqtfeAloXXqN21eaoLdnOgFfFZRUWTZymzcujKL2QEJEEQMDF2n
         W3YEoXGhJa9Mlz9NfWpovSGy4PPZiLCAWtsyZU/qr6Ppu16o/QNA1X6jYax1ZPMUtwfe
         8vU/fAJgGxGAW6mcADOeT4HZx9pEKY1RZ7yqkOBj5uqqHvhs+l3QDYE1QdsGeGXhszao
         WDkh/XoMjQ1WHCJcfsQNF1kAe0DC5xGs3TrqDIr03lPHWqSyWtVkd7DYMurNnH24R6+L
         6y1g==
X-Gm-Message-State: AOAM532hMH5KiLqtKA3wN/ZyDhFrpWmBGVScQdzD/xL3zQIXo1TheTVb
        wjQTIIaT85QcCHiTX3cPA5RB/j977I5k7hzuZqC40ti2GzM=
X-Google-Smtp-Source: ABdhPJwHmWk47Dbw9DUANoQIAHmZNV3T2NzF1RWhimAuRBiw8AKSUYv8ofXmaFIj8k8ZQ/W38Ugtam1k6xRv8dTsidM=
X-Received: by 2002:a50:f689:0:b0:418:f7bc:e8e with SMTP id
 d9-20020a50f689000000b00418f7bc0e8emr18546624edn.251.1648765873864; Thu, 31
 Mar 2022 15:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com> <20220331065640.5777-2-songmuchun@bytedance.com>
In-Reply-To: <20220331065640.5777-2-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 1 Apr 2022 11:31:02 +1300
Message-ID: <CAGsJ_4z96yj-z+d704_FQ==BXXN5wCvQnBtj+Az-nAxTKAbwfw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP
 for arm64
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

On Thu, Mar 31, 2022 at 7:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page aims to free its vmemmap pages (used as struct page) to
> save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
> In short, when a HugeTLB page is allocated or freed, the vmemmap array
> representing the range associated with the page will need to be remapped.
> When a page is allocated, vmemmap pages are freed after remapping.
> When a page is freed, previously discarded vmemmap pages must be
> allocated before remapping.  More implementations and details can be
> found here [1].
>
> The infrastructure of freeing vmemmap pages associated with each HugeTLB
> page is already there, we can easily enable HUGETLB_PAGE_FREE_VMEMMAP
> for arm64, the only thing to be fixed is flush_dcache_page() .
>
> flush_dcache_page() need to be adapted to operate on the head page's
> flags since the tail vmemmap pages are mapped with read-only after the
> feature is enabled (clear operation is not permitted).
>
> There was some discussions about this in the thread [2], but there was
> no conclusion in the end.  And I copied the concern proposed by Anshuman
> to here and explain why those concern is superfluous.  It is safe to
> enable it for x86_64 as well as arm64.
>
> 1st concern:
> '''
> But what happens when a hot remove section's vmemmap area (which is
> being teared down) is nearby another vmemmap area which is either created
> or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> HugeTLB pages inside the hot remove section might be safe. But what about
> other HugeTLB areas whose vmemmap area shares page table entries with
> vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> /use/free test cycle using memory just adjacent to a memory hotplug area,
> which is always added and removed periodically, should be able to expose
> this problem.
> '''
>
> Answer: At the time memory is removed, all HugeTLB pages either have been
> migrated away or dissolved.  So there is no race between memory hot remove
> and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> remove section is safe.  Let's talk your question "what about other
> HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> entries for a section being hot removed ?", the question is not
> established.  The minimal granularity size of hotplug memory 128MB (on
> arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> then, there is no share PTE page tables between HugeTLB in this section
> and ones in other sections and a HugeTLB page could not cross two
> sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
> than 128MB (section size) whose vmemmap pages is an integer multiple of
> 2MB (PMD-mapped).  As long as:
>
>   1) HugeTLBs are naturally aligned, power-of-two sizes
>   2) The HugeTLB size >= the section size
>   3) The HugeTLB size >= the vmemmap leaf mapping size
>
> Then a HugeTLB will not share any leaf page table entries with *anything
> else*, but will share intermediate entries.  In this case, at the time memory
> is removed, all HugeTLB pages either have been migrated away or dissolved.
> So there is also no race between memory hot remove and
> free_huge_page_vmemmap().
>
> 2nd concern:
> '''
> differently, not sure if ptdump would require any synchronization.
>
> Dumping an wrong value is probably okay but crashing because a page table
> entry is being freed after ptdump acquired the pointer is bad. On arm64,
> ptdump() is protected against hotremove via [get|put]_online_mems().
> '''
>
> Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> PTEs or splits the PMD entry (which means allocating a PTE page table).  Both
> operations do not free any page tables (PTE), so ptdump cannot run into a
> UAF on any page tables.  The worst case is just dumping an wrong value.
>
> [1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
> [2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Barry Song <baohua@kernel.org>

I ran some testing on this patchset. On a machine with 4GB memory
and I set 2GB hugepages by "hugepagesz=2m hugepages=1024",
I was seeing:

Before the patch,
/sys# cat kernel/debug/kernel_page_tables
---[ vmemmap start ]---
0xfffffc0000000000-0xfffffc1180000000          70G PUD
0xfffffc1180000000-0xfffffc1181000000          16M PMD
0xfffffc1181000000-0xfffffc1185000000          64M PMD       RW NX SHD
AF NG     BLK UXN    MEM/NORMAL
0xfffffc1185000000-0xfffffc11c0000000         944M PMD
0xfffffc11c0000000-0xfffffc8000000000         441G PUD
0xfffffc8000000000-0xfffffe0000000000        1536G PGD
---[ vmemmap end ]---

After the patch:
---[ vmemmap start ]---
...
0xfffffc27e8090000-0xfffffc27e8091000           4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e8091000-0xfffffc27e8098000          28K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e8098000-0xfffffc27e8099000           4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e8099000-0xfffffc27e80a0000          28K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80a0000-0xfffffc27e80a1000           4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80a1000-0xfffffc27e80a8000          28K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80a8000-0xfffffc27e80a9000           4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80a9000-0xfffffc27e80b0000          28K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80b0000-0xfffffc27e80b1000           4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80b1000-0xfffffc27e80b8000          28K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80b8000-0xfffffc27e80b9000           4K PTE       RW NX SHD
AF NG         UXN    MEM/NORMAL
0xfffffc27e80b9000-0xfffffc27e80c0000          28K PTE       ro NX SHD
AF NG         UXN    MEM/NORMAL
...

So it works as expected. we are seeing 7 read-only mapping after 1 RW mapping.

Then I tried to check if the patch would break 64KB hugepages by setting
"hugepagesz=64k hugepages=32768", i got:

---[ vmemmap start ]---
0xfffffc0000000000-0xfffffd8000000000        1536G PGD
0xfffffd8000000000-0xfffffd82c0000000          11G PUD
0xfffffd82c0000000-0xfffffd82c3000000          48M PMD
0xfffffd82c3000000-0xfffffd82c7000000          64M PMD       RW NX SHD
AF NG     BLK UXN    MEM/NORMAL
0xfffffd82c7000000-0xfffffd8300000000         912M PMD
0xfffffd8300000000-0xfffffe0000000000         500G PUD
---[ vmemmap end ]---

Obviously it doesn't break this corner case in which we don't need VMEMMAP_FREE.

> ---
> v4:
>  - Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP (implemented in the previous
>    patch) to enable this feature for arm64.
>
> v3:
>  - Rework patch's subject.
>  - Clarify the feature of HUGETLB_PAGE_FREE_VMEMMAP is already there in the
>    current code and easyly be enabled for arm64 into commit log.
>  - Add hugetlb_free_vmemmap_enabled() check into flush_dcache_page().
>
>  Thanks for Barry's suggestions.
>
> v2:
>  - Update commit message (Mark Rutland).
>  - Fix flush_dcache_page().
>
>  arch/arm64/Kconfig    |  1 +
>  arch/arm64/mm/flush.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c842878f8133..37f72e3a75d0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -94,6 +94,7 @@ config ARM64
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>         select ARCH_WANT_FRAME_POINTERS
>         select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> +       select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
>         select ARCH_WANT_LD_ORPHAN_WARN
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 2aaf950b906c..c67c1ca856c2 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -68,6 +68,19 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
>   */
>  void flush_dcache_page(struct page *page)
>  {
> +       /*
> +        * Only the head page's flags of HugeTLB can be cleared since the tail
> +        * vmemmap pages associated with each HugeTLB page are mapped with
> +        * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> +        * details can refer to vmemmap_remap_pte()).  Although
> +        * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> +        * page struct, some tail page structs still can be seen the flag is
> +        * set since the head vmemmap page frame is reused (more details can
> +        * refer to the comments above page_fixed_fake_head()).
> +        */
> +       if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
> +               page = compound_head(page);
> +
>         if (test_bit(PG_dcache_clean, &page->flags))
>                 clear_bit(PG_dcache_clean, &page->flags);
>  }
> --
> 2.11.0
>

Thanks
Barry
