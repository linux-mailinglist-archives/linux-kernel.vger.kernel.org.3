Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1455EB85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiF1R4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiF1R4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CD916163
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656438992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZdMrnQ9ysJNqDJMv9rjfb3HSCfo/aebLFuet1sjRts=;
        b=cZgQW2xeFeRYn0HWxCUhBx8Z1ZnDBlZZnSbq80UKqD+LWvptiBq0IY+qOEx0y7PwsB21Mk
        HjKAsR+xZdjESBJpooRSBfTF4WPeit3wNx8g/9LY3/0P4+SeqoiDlIKlhreA3ZK/6C3xbR
        PmVyMr3URrzNrYLo3CEldXMxC45GZIc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-2cNV2sDPO92ictfzUObEAQ-1; Tue, 28 Jun 2022 13:56:30 -0400
X-MC-Unique: 2cNV2sDPO92ictfzUObEAQ-1
Received: by mail-wm1-f71.google.com with SMTP id t20-20020a1c7714000000b003a032360873so8561161wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZdMrnQ9ysJNqDJMv9rjfb3HSCfo/aebLFuet1sjRts=;
        b=WCrC5OAtEzTRR5JnrAq/D48ERRUnv5gsoDRssKnwgNMDvBXzhcB6m7FKujSTUL8pNi
         ykp62SelK0TCDa0ObjfiUwYfdxeWFSPbs9geg8LbV1A2UVpjUy9Vqb4KwXB8NHyANvP3
         hhxsuQUuzaYGOVLBgVwtNt6pbd+K3nQk/lvmFhkTmbpDs+GIK0BW1HDKrF7IaxjWTnQf
         BPRpWxSiE+x2ppAn7VKt2aQNbL/sQB/xkRT5+1q36eXzuvukuUKkwBK4SJotw8S/noPE
         jAaNiANVaREw+T/2ZH6NY4U1KbQiq+PLHXbaUUTgO6BLA23WUCpvWmqYxT7ECFNZjehI
         Qq8w==
X-Gm-Message-State: AJIora/xrhcChMSruv9vT//IGsjdRNGvpTuFHJWXc2YqCzkTlCbiuTA4
        EAUWVYAIPh7cG0CKZIrwkGr7cL0zS6Ory0qilqwccmkfODPIeHk2MRJGo8d156013HyTgN2O5AY
        FRWRrN6obwSBlKEOfi8VfVDpi
X-Received: by 2002:a1c:770c:0:b0:3a0:37ec:bbb9 with SMTP id t12-20020a1c770c000000b003a037ecbbb9mr991501wmi.2.1656438989519;
        Tue, 28 Jun 2022 10:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vob3LSDcrpJFpg3VrLcrPj6GTmYSbX+cTRPnOE2uiSdgtIVOip4jMwxzLsO5dhcFsiOnR5Iw==
X-Received: by 2002:a1c:770c:0:b0:3a0:37ec:bbb9 with SMTP id t12-20020a1c770c000000b003a037ecbbb9mr991474wmi.2.1656438989271;
        Tue, 28 Jun 2022 10:56:29 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id z9-20020adfec89000000b0021b89f8662esm14059376wrn.13.2022.06.28.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:56:28 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:56:25 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <YrtAyUSbtCLwCFxC@work-vm>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com>
 <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com>
 <CAHS8izNSsEW88Q=ozcC2rbnmvcX3zOL-qkFTPgn=M6S1R5t=Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNSsEW88Q=ozcC2rbnmvcX3zOL-qkFTPgn=M6S1R5t=Yw@mail.gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mina Almasry (almasrymina@google.com) wrote:
> On Mon, Jun 27, 2022 at 9:27 AM James Houghton <jthoughton@google.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 11:41 AM Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> > > >
> > > > [trimmed...]
> > > > ---- Userspace API ----
> > > >
> > > > This patch series introduces a single way to take advantage of
> > > > high-granularity mapping: via UFFDIO_CONTINUE. UFFDIO_CONTINUE allows
> > > > userspace to resolve MINOR page faults on shared VMAs.
> > > >
> > > > To collapse a HugeTLB address range that has been mapped with several
> > > > UFFDIO_CONTINUE operations, userspace can issue MADV_COLLAPSE. We expect
> > > > userspace to know when all pages (that they care about) have been fetched.
> > > >
> > >
> > > Thanks James! Cover letter looks good. A few questions:
> > >
> > > Why not have the kernel collapse the hugepage once all the 4K pages
> > > have been fetched automatically? It would remove the need for a new
> > > userspace API, and AFACT there aren't really any cases where it is
> > > beneficial to have a hugepage sharded into 4K mappings when those
> > > mappings can be collapsed.
> >
> > The reason that we don't automatically collapse mappings is because it
> > would take additional complexity, and it is less flexible. Consider
> > the case of 1G pages on x86: currently, userspace can collapse the
> > whole page when it's all ready, but they can also choose to collapse a
> > 2M piece of it. On architectures with more supported hugepage sizes
> > (e.g., arm64), userspace has even more possibilities for when to
> > collapse. This likely further complicates a potential
> > automatic-collapse solution. Userspace may also want to collapse the
> > mapping for an entire hugepage without completely mapping the hugepage
> > first (this would also be possible by issuing UFFDIO_CONTINUE on all
> > the holes, though).
> >
> 
> To be honest I'm don't think I'm a fan of this. I don't think this
> saves complexity, but rather pushes it to the userspace. I.e. the
> userspace now must track which regions are faulted in and which are
> not to call MADV_COLLAPSE at the right time. Also, if the userspace
> gets it wrong it may accidentally not call MADV_COLLAPSE (and not get
> any hugepages) or call MADV_COLLAPSE too early and have to deal with a
> storm of maybe hundreds of minor faults at once which may take too
> long to resolve and may impact guest stability, yes?

I think it depends on whether the userspace is already holding bitmaps
and data structures to let it know when the right time to call collapse
is; if it already has to do all that book keeping for it's own postcopy
or whatever process, then getting userspace to call it is easy.
(I don't know the answer to whether it does have!)

Dave

> For these reasons I think automatic collapsing is something that will
> eventually be implemented by us or someone else, and at that point
> MADV_COLLAPSE for hugetlb memory will become obsolete; i.e. this patch
> is adding a userspace API that will probably need to be maintained for
> perpetuity but actually is likely going to be going obsolete "soon".
> For this reason I had hoped that automatic collapsing would come with
> V1.
> 
> I wonder if we can have a very simple first try at automatic
> collapsing for V1? I.e., can we support collapsing to the hstate size
> and only that? So 4K pages can only be either collapsed to 2MB or 1G
> on x86 depending on the hstate size. I think this may be not too
> difficult to implement: we can have a counter similar to mapcount that
> tracks how many of the subpages are mapped (subpage_mapcount). Once
> all the subpages are mapped (the counter reaches a certain value),
> trigger collapsing similar to hstate size MADV_COLLAPSE.
> 
> I gather that no one else reviewing this has raised this issue thus
> far so it might not be a big deal and I will continue to review the
> RFC, but I had hoped for automatic collapsing myself for the reasons
> above.
> 
> > >
> > > > ---- HugeTLB Changes ----
> > > >
> > > > - Mapcount
> > > > The way mapcount is handled is different from the way that it was handled
> > > > before. If the PUD for a hugepage is not none, a hugepage's mapcount will
> > > > be increased. This scheme means that, for hugepages that aren't mapped at
> > > > high granularity, their mapcounts will remain the same as what they would
> > > > have been pre-HGM.
> > > >
> > >
> > > Sorry, I didn't quite follow this. It says mapcount is handled
> > > differently, but the same if the page is not mapped at high
> > > granularity. Can you elaborate on how the mapcount handling will be
> > > different when the page is mapped at high granularity?
> >
> > I guess I didn't phrase this very well. For the sake of simplicity,
> > consider 1G pages on x86, typically mapped with leaf-level PUDs.
> > Previously, there were two possibilities for how a hugepage was
> > mapped, either it was (1) completely mapped (PUD is present and a
> > leaf), or (2) it wasn't mapped (PUD is none). Now we have a third
> > case, where the PUD is not none but also not a leaf (this usually
> > means that the page is partially mapped). We handle this case as if
> > the whole page was mapped. That is, if we partially map a hugepage
> > that was previously unmapped (making the PUD point to PMDs), we
> > increment its mapcount, and if we completely unmap a partially mapped
> > hugepage (making the PUD none), we decrement its mapcount. If we
> > collapse a non-leaf PUD to a leaf PUD, we don't change mapcount.
> >
> > It is possible for a PUD to be present and not a leaf (mapcount has
> > been incremented) but for the page to still be unmapped: if the PMDs
> > (or PTEs) underneath are all none. This case is atypical, and as of
> > this RFC (without bestowing MADV_DONTNEED with HGM flexibility), I
> > think it would be very difficult to get this to happen.
> >
> 
> Thank you for the detailed explanation. Please add it to the cover letter.
> 
> I wonder the case "PUD present but all the PMD are none": is that a
> bug? I don't understand the usefulness of that. Not a comment on this
> patch but rather a curiosity.
> 
> > >
> > > > - Page table walking and manipulation
> > > > A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> > > > high-granularity mappings. Eventually, it's possible to merge
> > > > hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
> > > >
> > > > We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> > > > This is because we generally need to know the "size" of a PTE (previously
> > > > always just huge_page_size(hstate)).
> > > >
> > > > For every page table manipulation function that has a huge version (e.g.
> > > > huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> > > > hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> > > > PTE really is "huge".
> > > >
> > > > - Synchronization
> > > > For existing bits of HugeTLB, synchronization is unchanged. For splitting
> > > > and collapsing HugeTLB PTEs, we require that the i_mmap_rw_sem is held for
> > > > writing, and for doing high-granularity page table walks, we require it to
> > > > be held for reading.
> > > >
> > > > ---- Limitations & Future Changes ----
> > > >
> > > > This patch series only implements high-granularity mapping for VM_SHARED
> > > > VMAs.  I intend to implement enough HGM to support 4K unmapping for memory
> > > > failure recovery for both shared and private mappings.
> > > >
> > > > The memory failure use case poses its own challenges that can be
> > > > addressed, but I will do so in a separate RFC.
> > > >
> > > > Performance has not been heavily scrutinized with this patch series. There
> > > > are places where lock contention can significantly reduce performance. This
> > > > will be addressed later.
> > > >
> > > > The patch series, as it stands right now, is compatible with the VMEMMAP
> > > > page struct optimization[3], as we do not need to modify data contained
> > > > in the subpage page structs.
> > > >
> > > > Other omissions:
> > > >  - Compatibility with userfaultfd write-protect (will be included in v1).
> > > >  - Support for mremap() (will be included in v1). This looks a lot like
> > > >    the support we have for fork().
> > > >  - Documentation changes (will be included in v1).
> > > >  - Completely ignores PMD sharing and hugepage migration (will be included
> > > >    in v1).
> > > >  - Implementations for architectures that don't use GENERAL_HUGETLB other
> > > >    than arm64.
> > > >
> > > > ---- Patch Breakdown ----
> > > >
> > > > Patch 1     - Preliminary changes
> > > > Patch 2-10  - HugeTLB HGM core changes
> > > > Patch 11-13 - HugeTLB HGM page table walking functionality
> > > > Patch 14-19 - HugeTLB HGM compatibility with other bits
> > > > Patch 20-23 - Userfaultfd and collapse changes
> > > > Patch 24-26 - arm64 support and selftests
> > > >
> > > > [1] This used to be called HugeTLB double mapping, a bad and confusing
> > > >     name. "High-granularity mapping" is not a great name either. I am open
> > > >     to better names.
> > >
> > > I would drop 1 extra word and do "granular mapping", as in the mapping
> > > is more granular than what it normally is (2MB/1G, etc).
> >
> > Noted. :)
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

