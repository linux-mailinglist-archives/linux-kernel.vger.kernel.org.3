Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A614B82AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiBPIF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:05:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiBPIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:05:57 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02951235857
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:05:45 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v186so3697541ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKNzKBb19Do3NGmL01/2ZoAEl367WiU5/pzUcTTd170=;
        b=Vs36gc3ftF5yVkEl7PjXZQrnqiSL9oAPR1PmipoQVMOA0w+rD3oBNP6pQzK/rZADH3
         Bk0A7vPTVpmr8Y4S9uEOpwGDZq232z+e9v18C7bAy3SCoHzi1r8E2pOBBowACqQN7WpN
         0XMs0LATWPNEfJLFqeXftM4qgZuHS7FFtVMrmX2qh1QW8tiTUI44Xss5hoSv7Soh3Lwd
         /lLqcu/xYrF8Cibm41ZPRqiFjCTo+nTNjDBERw0A9pfK0q7tc0mIoqySOZY0fndicvvg
         mMWRM/YLGdaGuoNgpfmeYVdC1jDck29WGCmOcojgFIIda8arRXJlNWgBtki73KRdDHCU
         KkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKNzKBb19Do3NGmL01/2ZoAEl367WiU5/pzUcTTd170=;
        b=XakLawoxlPx6vrAFB6mz14KDBqnsX368JDkxHxl48TgkF/KmjBBC6ObqBu6qJMrX3w
         eKKw506FlD5rvtL17mBzsoyKwtYb9+vn+faQETV5u6YpiO24FFQPJXCxa9BE5aW+nkwK
         yVLZHw7zIPKIVnl1xCCshQdxv3WK5Cf0G7I7zxD/j4WC4zBUtY/WqIG7YZjbIbUN/PWc
         alu073ohH3jSyQJ3O4qj16wxw39hKLrDF/NlNikKAXogpdB50ug6CxD9OSWlA8YJXdIn
         P4Ei9Q3FZZS5p5DkcpYZjoDsKAx+uLWjppneWgNNsVWJtcbP6PL5fLFEMkNMGFmQufzi
         i1Yw==
X-Gm-Message-State: AOAM533rG3k0xi+Yie5WcaWWnlDAHYq790t22t6aj6vMpkUoxQlyinb4
        HvISvjHS2VCwEjhawIjvUotf7QoGcHQ6zcMiHvCyPg==
X-Google-Smtp-Source: ABdhPJzjoYb2AkrlJR467OpvCCj/z0HN/EHTUaZqEyMMZ5g5FOHNWEVK5sQaZOhyqd9wQ93nQtdnJNLkwUGeFyk6AHg=
X-Received: by 2002:a25:e0d0:0:b0:613:e5b1:277e with SMTP id
 x199-20020a25e0d0000000b00613e5b1277emr1198675ybg.132.1644998744242; Wed, 16
 Feb 2022 00:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20220208054632.66534-1-songmuchun@bytedance.com> <20220208054632.66534-2-songmuchun@bytedance.com>
In-Reply-To: <20220208054632.66534-2-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Feb 2022 16:05:07 +0800
Message-ID: <CAMZfGtWzaesaWH7WypRJ+YOmChWh94NU6RzfX86jX9TFOyF0_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: mm: hugetlb: add support for free vmemmap
 pages of HugeTLB
To:     mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 1:46 PM Muchun Song <songmuchun@bytedance.com> wrote:
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
> The preparation of freeing vmemmap pages associated with each HugeTLB
> page is ready, so we can support this feature for arm64 now.  The
> flush_dcache_page() need to be adapted to operate on the head page's
> flags since the tail vmemmap pages are mapped with read-only after
> the feature is enabled (clear operation is not permitted).
>
> There was some discussions about this in the thread [2], but there was
> no conclusion in the end.  And I copied the concern proposed by Anshuman
> to here.
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
> PTEs or split the PMD entry (which means allocating a PTE page table).  Both
> operations do not free any page tables (PTE), so ptdump cannot run into a
> UAF on any page tables.  The wrost case is just dumping an wrong value.
>
> [1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
> [2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Hi Mark,

I have updated the commit suggested from you in the previous version,
do you (or other maintainers) have any comments on this?

Thanks.
