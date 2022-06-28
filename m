Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B53855E959
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbiF1ORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345961AbiF1ORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:17:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725EB2EA1B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:17:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d14so12725192pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dsdJAZGMU86DRVBeneY3mM/jA9/FuyyN3hzFaqyDicg=;
        b=nyHdWDKz+JUVQGY+RpZ+evo4B+BP7bogCl/7Bxg6RgTsYeWsEtmQfcL2uzO2sAVLhp
         KMluGL+xWxhTiJWzKOECH7su0ssGe3M51J1MbnbCDCV+8we0uJY1a69XkcBhSghf98v1
         luZ2Z1x2f9lFOy71eyJEsRmgz0O+NyYB4y+3kcinbJy0P87uwcpCAiDNg5vJKpVNoQI0
         grKby+ch8a+Rt48BkwT29mfCmCWnf3DhkwVSscQ/qzschIVq+qWifMTJhzrHjqlJGQUP
         G9rmYh00uwCVQyaIgJiWW00rULLWqlpX6PTmS2q7FugnoGPfQTo3NjNBH8IGGcYtRmNo
         HPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dsdJAZGMU86DRVBeneY3mM/jA9/FuyyN3hzFaqyDicg=;
        b=7c0mznnLAhYPJ9jweEterCvtISjQIh0Xvk5aNxw8ITY077+iRraJcjdu3GeHrYpE3G
         Ns+jJpsPbVTh5pgMSMdaWmqokoYNzjSZERlTH/PVDuGSyvInD/qBvSVjuKDRPgRsnAzw
         V2+S1DxmpEG0OBJ0jkjwwuDFCj3oU9ANmvVeYsLfGGfYJKaXMBbY3XoAKAf0KFAS/3wA
         BP28lVDIhs5OB9cL5GsIQWqUaWVURG945UGkeJ3+q0AQIUbDheFpOWxpkrqfeNVwiIeW
         np8iDEAYT5XZicHU2swmvlnUE5BovBJ73t/zJHOtn3bUKqPt+TDdqaicNJV7ICGetHda
         K21Q==
X-Gm-Message-State: AJIora+sJGpxiFX9DQ9t+pNeVkUyvoXYPOz9uh/7JS7U4Jck9d1Tnr4F
        4Lj1MbUNhvatr8Skmcy0egBpFA==
X-Google-Smtp-Source: AGRyM1sMmomGX/L3/p59uYhsnJwv5HPrcu9SmmgqfQ8O0pGZjvE5nMm0EL8KXv9eGmkAFUb2aZuhdg==
X-Received: by 2002:a17:90a:fa8c:b0:1ec:9f5c:846d with SMTP id cu12-20020a17090afa8c00b001ec9f5c846dmr22319832pjb.73.1656425858807;
        Tue, 28 Jun 2022 07:17:38 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:e153:cfbc:e790:5935])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b00524f29903e0sm9483622pfu.56.2022.06.28.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:17:38 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:17:34 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <YrsNfjm+S0KIKn2k@FVFYT0MHHV2J>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com>
 <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:27:38AM -0700, James Houghton wrote:
> On Fri, Jun 24, 2022 at 11:41 AM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> > >
> > > [trimmed...]
> > > ---- Userspace API ----
> > >
> > > This patch series introduces a single way to take advantage of
> > > high-granularity mapping: via UFFDIO_CONTINUE. UFFDIO_CONTINUE allows
> > > userspace to resolve MINOR page faults on shared VMAs.
> > >
> > > To collapse a HugeTLB address range that has been mapped with several
> > > UFFDIO_CONTINUE operations, userspace can issue MADV_COLLAPSE. We expect
> > > userspace to know when all pages (that they care about) have been fetched.
> > >
> >
> > Thanks James! Cover letter looks good. A few questions:
> >
> > Why not have the kernel collapse the hugepage once all the 4K pages
> > have been fetched automatically? It would remove the need for a new
> > userspace API, and AFACT there aren't really any cases where it is
> > beneficial to have a hugepage sharded into 4K mappings when those
> > mappings can be collapsed.
> 
> The reason that we don't automatically collapse mappings is because it
> would take additional complexity, and it is less flexible. Consider
> the case of 1G pages on x86: currently, userspace can collapse the
> whole page when it's all ready, but they can also choose to collapse a
> 2M piece of it. On architectures with more supported hugepage sizes
> (e.g., arm64), userspace has even more possibilities for when to
> collapse. This likely further complicates a potential
> automatic-collapse solution. Userspace may also want to collapse the
> mapping for an entire hugepage without completely mapping the hugepage
> first (this would also be possible by issuing UFFDIO_CONTINUE on all
> the holes, though).
> 
> >
> > > ---- HugeTLB Changes ----
> > >
> > > - Mapcount
> > > The way mapcount is handled is different from the way that it was handled
> > > before. If the PUD for a hugepage is not none, a hugepage's mapcount will
> > > be increased. This scheme means that, for hugepages that aren't mapped at
> > > high granularity, their mapcounts will remain the same as what they would
> > > have been pre-HGM.
> > >
> >
> > Sorry, I didn't quite follow this. It says mapcount is handled

+1

> > differently, but the same if the page is not mapped at high
> > granularity. Can you elaborate on how the mapcount handling will be
> > different when the page is mapped at high granularity?
> 
> I guess I didn't phrase this very well. For the sake of simplicity,
> consider 1G pages on x86, typically mapped with leaf-level PUDs.
> Previously, there were two possibilities for how a hugepage was
> mapped, either it was (1) completely mapped (PUD is present and a
> leaf), or (2) it wasn't mapped (PUD is none). Now we have a third
> case, where the PUD is not none but also not a leaf (this usually
> means that the page is partially mapped). We handle this case as if
> the whole page was mapped. That is, if we partially map a hugepage
> that was previously unmapped (making the PUD point to PMDs), we
> increment its mapcount, and if we completely unmap a partially mapped
> hugepage (making the PUD none), we decrement its mapcount. If we
> collapse a non-leaf PUD to a leaf PUD, we don't change mapcount.
> 
> It is possible for a PUD to be present and not a leaf (mapcount has
> been incremented) but for the page to still be unmapped: if the PMDs
> (or PTEs) underneath are all none. This case is atypical, and as of
> this RFC (without bestowing MADV_DONTNEED with HGM flexibility), I
> think it would be very difficult to get this to happen.
> 

It is a good explanation. I think it is better to go to cover letter.

Thanks.

> >
> > > - Page table walking and manipulation
> > > A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> > > high-granularity mappings. Eventually, it's possible to merge
> > > hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
> > >
> > > We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> > > This is because we generally need to know the "size" of a PTE (previously
> > > always just huge_page_size(hstate)).
> > >
> > > For every page table manipulation function that has a huge version (e.g.
> > > huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> > > hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> > > PTE really is "huge".
> > >
> > > - Synchronization
> > > For existing bits of HugeTLB, synchronization is unchanged. For splitting
> > > and collapsing HugeTLB PTEs, we require that the i_mmap_rw_sem is held for
> > > writing, and for doing high-granularity page table walks, we require it to
> > > be held for reading.
> > >
> > > ---- Limitations & Future Changes ----
> > >
> > > This patch series only implements high-granularity mapping for VM_SHARED
> > > VMAs.  I intend to implement enough HGM to support 4K unmapping for memory
> > > failure recovery for both shared and private mappings.
> > >
> > > The memory failure use case poses its own challenges that can be
> > > addressed, but I will do so in a separate RFC.
> > >
> > > Performance has not been heavily scrutinized with this patch series. There
> > > are places where lock contention can significantly reduce performance. This
> > > will be addressed later.
> > >
> > > The patch series, as it stands right now, is compatible with the VMEMMAP
> > > page struct optimization[3], as we do not need to modify data contained
> > > in the subpage page structs.
> > >
> > > Other omissions:
> > >  - Compatibility with userfaultfd write-protect (will be included in v1).
> > >  - Support for mremap() (will be included in v1). This looks a lot like
> > >    the support we have for fork().
> > >  - Documentation changes (will be included in v1).
> > >  - Completely ignores PMD sharing and hugepage migration (will be included
> > >    in v1).
> > >  - Implementations for architectures that don't use GENERAL_HUGETLB other
> > >    than arm64.
> > >
> > > ---- Patch Breakdown ----
> > >
> > > Patch 1     - Preliminary changes
> > > Patch 2-10  - HugeTLB HGM core changes
> > > Patch 11-13 - HugeTLB HGM page table walking functionality
> > > Patch 14-19 - HugeTLB HGM compatibility with other bits
> > > Patch 20-23 - Userfaultfd and collapse changes
> > > Patch 24-26 - arm64 support and selftests
> > >
> > > [1] This used to be called HugeTLB double mapping, a bad and confusing
> > >     name. "High-granularity mapping" is not a great name either. I am open
> > >     to better names.
> >
> > I would drop 1 extra word and do "granular mapping", as in the mapping
> > is more granular than what it normally is (2MB/1G, etc).
> 
> Noted. :)
> 
