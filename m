Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13B7560B34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiF2Ukb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF2Uk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA413FB0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:40:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v185so10520783ioe.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdQc/+pvX0Ez6ThzRWwYX4tiq5+lvh77fHXPCW5ViFg=;
        b=tSZPfUTI2Q4qJBJY8l5q3RRCGc/e12Fgqv/3f6RLf+pu554zzeswbPXiGYc0LYtY9i
         mjkh2wFNsMtlkhuciqedn2JCildOGDlhBTKPYYDygnES2LQZgLLCBxvx+YAL4osxpToQ
         rIdV+hKHzCwG969IyhwyiT+L7dG4l9C8PwLxPgukSs3NLTSmasy2J0Ah9+DLONWo/ER2
         MdGC1cUT5jWZD2cVKBPfhURl1tOwLd9vVtEcpr4jqW7Vt/4nWbFicPCTKUjsPeWku4LU
         SFuU6MpGB7qVBKWUlzMsDR1N0HWupVWekhktQTvaHZ+ouUvZGoTBkfUyIdRV8fYeNTMf
         lBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdQc/+pvX0Ez6ThzRWwYX4tiq5+lvh77fHXPCW5ViFg=;
        b=M3xDXfSoluep/G1JEHk+o687gjcAdZNnyALSIeEpm8E1UGJp9qjwBWqjwg0ML/e3rO
         qvIe/tXTcxu2Gj/jO1J6RM8n9L78G4rFozJzp5r/Mc/U+jnBlikf8BwFfda9qzB5+XyI
         eCeR91CDlkHKuMSKc/5qnaSaxRnjq2cIzvyobawugHLxvAYc5Og6gAL1CuUqJ0TMNXYB
         ne4OjPvjuAm3J8thAiYlKODPzAma1/lerncwYOoRfkAPp0E0pHRoxRf7l+ZeV5v3EWn+
         ynwGLHXFOA1EsjFPJFWGlem991FJbAuw0yID5rE4q3KqgSa+klftNWvziDliGE4qxjti
         +8LQ==
X-Gm-Message-State: AJIora+mnqqx86PfHY8bkO8gobu8nIkUvW1D1id94m/uBh7anwd+ulZb
        qsQB4u/9zGXkV2oPrAHZyvSDeOIsUBc0KUdMWvT0yvYuW9o=
X-Google-Smtp-Source: AGRyM1ujwHVJlDAVVJfEnDGfO4HUWlmZ3lfPjr15HW2EbgBdiY7L3E78IQtFqzTWBb8hDGhUFjtfuRBJR4rRFIaJJeo=
X-Received: by 2002:a02:2305:0:b0:331:a026:b650 with SMTP id
 u5-20020a022305000000b00331a026b650mr2942039jau.314.1656535226408; Wed, 29
 Jun 2022 13:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com>
 <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com> <CAHS8izNSsEW88Q=ozcC2rbnmvcX3zOL-qkFTPgn=M6S1R5t=Yw@mail.gmail.com>
In-Reply-To: <CAHS8izNSsEW88Q=ozcC2rbnmvcX3zOL-qkFTPgn=M6S1R5t=Yw@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 29 Jun 2022 13:39:50 -0700
Message-ID: <CAJHvVcik+vpouWyOrM7LfEHTH-yhjUHjm=KsXN0VrQ+t=pNcGw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     Mina Almasry <almasrymina@google.com>
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 10:27 AM Mina Almasry <almasrymina@google.com> wrote:
>
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

I disagree, I think this is state userspace needs to maintain anyway,
even if we ignore the use case James' series is about.

One example: today, you can't UFFDIO_CONTINUE a region which is
already mapped - you'll get -EEXIST. So, userspace needs to be sure
not to double-continue an area. We could think about relaxing this,
but there's a tradeoff - being more permissive means it's "easier to
use", but, it also means we're less strict about catching potentially
buggy userspaces.

There's another case that I don't see any way to get rid of. The way
live migration at least for GCE works is, we have two things
installing new pages: the on-demand fetcher, which reacts to UFFD
events and resolves them. And then we have the background fetcher,
which goes along and fetches pages which haven't been touched /
requested yet (and which may never be, it's not uncommon for a guest
to have at least *some* pages which are very infrequently / never
touched). In order for the background fetcher to know what pages to
transfer over the network, or not, userspace has to remember which
ones it's already installed.

Another point is, consider the use case of UFFDIO_CONTINUE over
UFFDIO_COPY. When userspace gets a UFFD event for a page, the
assumption is that it's somewhat likely the page is already up to
date, because we already copied it over from the source machine before
we stopped the guest and restarted it running on the target machine
("precopy"). So, we want to maintain a dirty bitmap, which tells us
which pages are clean or not - when we get a UFFD event, we check the
bitmap, and only if the page is dirty do we actually go fetch it over
the network - otherwise we just UFFDIO_CONTINUE and we're done.

>
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

I'm not sure I agree this is likely.

Two problems:

One is, say you UFFDIO_CONTINUE a 4k PTE. If we wanted collapsing to
happen automatically, we'd need to answer the question: is this the
last 4k PTE in a 2M region, so now it can be collapsed? Today the only
way to know is to go check - walk the PTEs. This is expensive, and
it's something we'd have to do on each and every UFFDIO_CONTINUE
operation -- this sucks because we're incurring the cost on every
operation, even though most of them (only 1 / 512, say) the answer
will be "no it wasn't the last one, we can't collapse yet". For
on-demand paging, it's really critical installing the page is as fast
as possible -- in an ideal world it would be exactly as fast as a
"normal" minor fault and the guest would not even be able to tell at
all that it was in the process of being migrated.

Now, as you pointed out, we can just store a mapcount somewhere which
keeps track of how many PTEs in each 2M region are installed or not.
So, then we can more quickly check in UFFDIO_CONTINUE. But, we have
the memory overhead and CPU time overhead of maintaining this
metadata. And, it's not like having the kernel do this means userspace
doesn't have to - like I described above, I think userspace would
*also* need to keep track of this same thing anyway, so now we're
doing it 2x.

Another problem I see is, it seems like collapsing automatically would
involve letting UFFD know a bit too much for my liking about hugetlbfs
internals. It seems to me more ideal to have it know as little as
possible about how hugetlbfs works internally.



Also, there are some benefits to letting userspace decide when / if to
collapse.

For example, userspace might decide it prefers to MADV_COLLAPSE
immediately, in the demand paging thread. Or, it might decide it's
okay to let it be collapsed a bit later, and leave that up to some
other background thread. It might MADV_COLLAPSE as soon as it sees a
complete 2M region, or maybe it wants to batch things up and waits
until it has a full 1G region to collapse. It might also do different
things for different regions, e.g. depending on if they were hot or
cold (demand paged vs. background fetched). I don't see any single
"right way" to do things here, I just see tradeoffs, which userspace
is in a good position to decide on.

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
