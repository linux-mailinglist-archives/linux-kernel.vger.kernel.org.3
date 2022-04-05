Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F474F3905
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377485AbiDEL30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbiDEIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BACCA0D7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:39:27 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2eb888cf7e7so39614977b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7F9tc9U7ODWDy1kAzf4zi/DKP2a+QyrxECa1zuE41o=;
        b=QUTlJqWGEJ/UKdADlSQrRRdY30NpO4KChs1YK7qmndWac2mhd+Ig5mC6Q7ZrOcW/gd
         zW6RLpfaLEUA3MTkZyZLM10EDrIuMjKQUEDj58qSpjWeLRbWjDmEppRcEmc5cVDrPYGS
         +e1g7k5kXmHeqCIs5Xn2lzD7g2xL9NVWgTRVvFuVGpqV1s4BgyjTbyh1uMYa3pP+ytvY
         Eq6KEH1UGAPxE9MaVTsizISqlWJBHHhGpTnkUKfgiOrfJNqzd3+Fo5VnorC+FSJNoIlI
         cN3cb3bgV1KXgxIPBoIuyiK/RMr0D7zXc2depVFxO2Qt60epS92OZCbcg78emxn6I3X4
         Ps8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7F9tc9U7ODWDy1kAzf4zi/DKP2a+QyrxECa1zuE41o=;
        b=TFZTASGb4ithFtSdfT/iLfivuwW9Jis2E2lLnhU+f51SwY9FLx1ot1BzoxWvHfZXH1
         D/nkN1pMF57X2RhrwnbUJGWYfhE+PsAH0073Fh3CiA8NoRIgvNMqPelp7MeZD8tBZ6ll
         qJwbEImWLdqS8li9E7PFbn1j3bdTqYlLRtMuVmkZVM9tcbpXcX+roGUqmGoooD8IWoMZ
         CeoWbghbLXIWsEdfZm+Ucigc3p/JTtAhHRTK9zUKEWb1FfSqUBg4M0mEU+WaUuPogYGI
         uAmXesmewGjnUkhgYVsqw1PEsaoVWM19OzIyAo13Hm1Djys7xQFPejEYvQtpYDG60rsZ
         7hfw==
X-Gm-Message-State: AOAM53133Uw5QGwxawZUdEK9KZLT6mUW6cSMB6yi9rv8xYqguCjEI505
        2AQNT7N/hKoYGWgNKGMSWAN5TldHNwHTGc4lcGLfrN85VyAesg==
X-Google-Smtp-Source: ABdhPJwd1xIsih8zdvSLhAEN6Bd/INuwdLnntyWYrppF0Q0nOKUpEivHs1rAG8A5FTR9XOqtPR8PkNd6zg/CMdDtISU=
X-Received: by 2002:a81:1196:0:b0:2eb:897a:7b5 with SMTP id
 144-20020a811196000000b002eb897a07b5mr1636637ywr.31.1649147936453; Tue, 05
 Apr 2022 01:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com> <d6e2581e-a8ac-4848-2c64-4a221bd03bca@arm.com>
In-Reply-To: <d6e2581e-a8ac-4848-2c64-4a221bd03bca@arm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Apr 2022 16:38:20 +0800
Message-ID: <CAMZfGtWyXmPwZWsH_pP_M7p30uBww8BdP0DRXQRjBkT_VP=uUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP
 for arm64
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
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

On Tue, Apr 5, 2022 at 12:44 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 3/31/22 12:26, Muchun Song wrote:
> > 1st concern:
> > '''
> > But what happens when a hot remove section's vmemmap area (which is
> > being teared down) is nearby another vmemmap area which is either created
> > or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> > HugeTLB pages inside the hot remove section might be safe. But what about
> > other HugeTLB areas whose vmemmap area shares page table entries with
> > vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> > /use/free test cycle using memory just adjacent to a memory hotplug area,
> > which is always added and removed periodically, should be able to expose
> > this problem.
> > '''
> >
> > Answer: At the time memory is removed, all HugeTLB pages either have been
> > migrated away or dissolved.  So there is no race between memory hot remove
> > and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> > remove section is safe.  Let's talk your question "what about other
>
> HugeTLB pages inside the memory range is safe but concern is about the
> vmemmap mapping for the HugeTLB which might share intermediate entries
> with vmemmap mapping for the memory range/section being removed.

The shared page table level only could be PMD, PUD and PGD, the PTE
page table cannot be shared with other sections, and we only exchange
PTEs for vmemmap mapping.

>
> > HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> > entries for a section being hot removed ?", the question is not
>
> Right.
>
> > established.  The minimal granularity size of hotplug memory 128MB (on
> > arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> > then, there is no share PTE page tables between HugeTLB in this section
>
> 128MB is the hot removable granularity but, its corresponding vmemmap
> range is smaller i.e (128MB/4K) * sizeof(struct page). Memory section
> getting hot removed (its vmemmap mapping being teared down) along with
> HugeTLB (on another section) vmemmap remap operation, could not collide
> while inside vmemmap mapping areas on init_mm ?

The boundary address of a section is aligned with 128MB and its
corresponding vmemmap boundary address is aligned with 2MB
which is mapped with a separated PTE page table (or a PMD entry).
Different sections do not share the same PTE, there are no conflicts
between a hot removed section and a remapping vmemmap section
since we are operating on different PTE. Right?

>
> > and ones in other sections and a HugeTLB page could not cross two
> > sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
>
> Right, they dont cross into two different sections.
>
> > than 128MB (section size) whose vmemmap pages is an integer multiple of
> > 2MB (PMD-mapped).  As long as:
> >
> >   1) HugeTLBs are naturally aligned, power-of-two sizes
> >   2) The HugeTLB size >= the section size
> >   3) The HugeTLB size >= the vmemmap leaf mapping size
> >
> > Then a HugeTLB will not share any leaf page table entries with *anything
> > else*, but will share intermediate entries.  In this case, at the time memory
> > is removed, all HugeTLB pages either have been migrated away or dissolved.
> > So there is also no race between memory hot remove and
> > free_huge_page_vmemmap().
>
> If they just share intermediate entries, free_empty_tables() will not free
> up page table pages, as there will be valid non-zero entries in them. But

Right.

> the problem here is not UAF, its accessing wrong entries and crashing while
> de-referncing the pointer. Hence I am wondering if no such scenario can be
> possible.
>

What's the wrong entries? You mean the reused vmemmap page entries?
If so, I think free_empty_tables() will not cause any crash.  The hot removed
operation couldn't reach those entries since those addresses mapped with
those reused entries are not included in the range of the hot removed section.

Thanks.
