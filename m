Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38DA55D131
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiF0Q1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiF0Q1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:27:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483D15739
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:27:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m14so8638703plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/6bDTOr6s2jDltP+JN9TCz9GVlONUi+KfBRN9dX8fA=;
        b=D6/QQ53Bi3VjonrgoT74XaObZQeHIaX1QRgVMih/yBKvig4gtR2PQz7O6OSAT5ySSY
         ngq6//CpeG4hv6Madt/uqOZfktppAZ6bIum02Fhr83H/LvkeN3pOShAfTt7M4ApzxEpg
         A+d68gHFl2nXf7TnAwnzQSj3mOg0dhBAsH3r5x22XucRxwVsF+AHmpXJznFygQnRxut6
         dfyJafbuZw8SlS1Py/Mnmcc2fgeys+2ISa+vewcS/dDfkGqfq9DO5Dm7SzPzW+UqKeLP
         G+VgbxOsCXzP8tsZldoFnmpfrkEgHzcYsupL/DLzlOcUrswArdZC03BcE6k+DhACu09h
         jABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/6bDTOr6s2jDltP+JN9TCz9GVlONUi+KfBRN9dX8fA=;
        b=4wdzCz87ytES8OLnUn7x5nVfkV2rdIFmp0k+p8oUm0+B68BvcnZs1hCAMGZ5ns2eho
         KZwW58D7ZZv9zA++J02k2WtZYqzBOGENzDZlN6P9aOnqsrbbS8Sr5bCPwwlj6jrTPp4x
         kqITVaw6KxdWwwP8gomN+xsFUJMUsznp0B/9wp1SexVMfnohwFKXTOrCtJLd7EDJAHYF
         6jWouJWPdLUFrfX5e+VH2BW4/Ep3jb/+JnhhOZMi6jLL6VtzmilwIMyFc0ecZCdoV6Kc
         1gAN8Zk7t1pD0xW2Al0pDmXmA62cycNjexJuZouHRgltPU/qripc3vK2J9+hRPsG1X5k
         ncnw==
X-Gm-Message-State: AJIora+E33js335uU2F2qOSXV7S5MYz3oxWPQ+iCdAcEVI1U9HsGo8mf
        oTOrDgUDzxzRO/Rz6A8dyjEzn29qPLapQ+6bu0aD0Q==
X-Google-Smtp-Source: AGRyM1u44EI+cRVv99T+1xao+WoQpy9Oj/hL6+KeXPghb5GMu6W8P26EVab6FmVEHEDAHE9c4928+UnrMfCPP5A+HDs=
X-Received: by 2002:a17:902:e94f:b0:16a:214e:46c1 with SMTP id
 b15-20020a170902e94f00b0016a214e46c1mr15580760pll.89.1656347269135; Mon, 27
 Jun 2022 09:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com>
In-Reply-To: <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 27 Jun 2022 09:27:38 -0700
Message-ID: <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 24, 2022 at 11:41 AM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> >
> > [trimmed...]
> > ---- Userspace API ----
> >
> > This patch series introduces a single way to take advantage of
> > high-granularity mapping: via UFFDIO_CONTINUE. UFFDIO_CONTINUE allows
> > userspace to resolve MINOR page faults on shared VMAs.
> >
> > To collapse a HugeTLB address range that has been mapped with several
> > UFFDIO_CONTINUE operations, userspace can issue MADV_COLLAPSE. We expect
> > userspace to know when all pages (that they care about) have been fetched.
> >
>
> Thanks James! Cover letter looks good. A few questions:
>
> Why not have the kernel collapse the hugepage once all the 4K pages
> have been fetched automatically? It would remove the need for a new
> userspace API, and AFACT there aren't really any cases where it is
> beneficial to have a hugepage sharded into 4K mappings when those
> mappings can be collapsed.

The reason that we don't automatically collapse mappings is because it
would take additional complexity, and it is less flexible. Consider
the case of 1G pages on x86: currently, userspace can collapse the
whole page when it's all ready, but they can also choose to collapse a
2M piece of it. On architectures with more supported hugepage sizes
(e.g., arm64), userspace has even more possibilities for when to
collapse. This likely further complicates a potential
automatic-collapse solution. Userspace may also want to collapse the
mapping for an entire hugepage without completely mapping the hugepage
first (this would also be possible by issuing UFFDIO_CONTINUE on all
the holes, though).

>
> > ---- HugeTLB Changes ----
> >
> > - Mapcount
> > The way mapcount is handled is different from the way that it was handled
> > before. If the PUD for a hugepage is not none, a hugepage's mapcount will
> > be increased. This scheme means that, for hugepages that aren't mapped at
> > high granularity, their mapcounts will remain the same as what they would
> > have been pre-HGM.
> >
>
> Sorry, I didn't quite follow this. It says mapcount is handled
> differently, but the same if the page is not mapped at high
> granularity. Can you elaborate on how the mapcount handling will be
> different when the page is mapped at high granularity?

I guess I didn't phrase this very well. For the sake of simplicity,
consider 1G pages on x86, typically mapped with leaf-level PUDs.
Previously, there were two possibilities for how a hugepage was
mapped, either it was (1) completely mapped (PUD is present and a
leaf), or (2) it wasn't mapped (PUD is none). Now we have a third
case, where the PUD is not none but also not a leaf (this usually
means that the page is partially mapped). We handle this case as if
the whole page was mapped. That is, if we partially map a hugepage
that was previously unmapped (making the PUD point to PMDs), we
increment its mapcount, and if we completely unmap a partially mapped
hugepage (making the PUD none), we decrement its mapcount. If we
collapse a non-leaf PUD to a leaf PUD, we don't change mapcount.

It is possible for a PUD to be present and not a leaf (mapcount has
been incremented) but for the page to still be unmapped: if the PMDs
(or PTEs) underneath are all none. This case is atypical, and as of
this RFC (without bestowing MADV_DONTNEED with HGM flexibility), I
think it would be very difficult to get this to happen.

>
> > - Page table walking and manipulation
> > A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> > high-granularity mappings. Eventually, it's possible to merge
> > hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
> >
> > We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> > This is because we generally need to know the "size" of a PTE (previously
> > always just huge_page_size(hstate)).
> >
> > For every page table manipulation function that has a huge version (e.g.
> > huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> > hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> > PTE really is "huge".
> >
> > - Synchronization
> > For existing bits of HugeTLB, synchronization is unchanged. For splitting
> > and collapsing HugeTLB PTEs, we require that the i_mmap_rw_sem is held for
> > writing, and for doing high-granularity page table walks, we require it to
> > be held for reading.
> >
> > ---- Limitations & Future Changes ----
> >
> > This patch series only implements high-granularity mapping for VM_SHARED
> > VMAs.  I intend to implement enough HGM to support 4K unmapping for memory
> > failure recovery for both shared and private mappings.
> >
> > The memory failure use case poses its own challenges that can be
> > addressed, but I will do so in a separate RFC.
> >
> > Performance has not been heavily scrutinized with this patch series. There
> > are places where lock contention can significantly reduce performance. This
> > will be addressed later.
> >
> > The patch series, as it stands right now, is compatible with the VMEMMAP
> > page struct optimization[3], as we do not need to modify data contained
> > in the subpage page structs.
> >
> > Other omissions:
> >  - Compatibility with userfaultfd write-protect (will be included in v1).
> >  - Support for mremap() (will be included in v1). This looks a lot like
> >    the support we have for fork().
> >  - Documentation changes (will be included in v1).
> >  - Completely ignores PMD sharing and hugepage migration (will be included
> >    in v1).
> >  - Implementations for architectures that don't use GENERAL_HUGETLB other
> >    than arm64.
> >
> > ---- Patch Breakdown ----
> >
> > Patch 1     - Preliminary changes
> > Patch 2-10  - HugeTLB HGM core changes
> > Patch 11-13 - HugeTLB HGM page table walking functionality
> > Patch 14-19 - HugeTLB HGM compatibility with other bits
> > Patch 20-23 - Userfaultfd and collapse changes
> > Patch 24-26 - arm64 support and selftests
> >
> > [1] This used to be called HugeTLB double mapping, a bad and confusing
> >     name. "High-granularity mapping" is not a great name either. I am open
> >     to better names.
>
> I would drop 1 extra word and do "granular mapping", as in the mapping
> is more granular than what it normally is (2MB/1G, etc).

Noted. :)
