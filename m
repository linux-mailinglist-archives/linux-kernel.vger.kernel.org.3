Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85D84A4CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380677AbiAaRAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380092AbiAaRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:00:31 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059E5C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:00:31 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v186so42545010ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+p5607n/Qx4OeoWA5j6F3HYoZ+CHzgiXbMB9onprQMM=;
        b=mwYPZ1BMvQtpU/lT+ig4svLbDDEM3EWqZoJWXBwHw2x8FEVno2OxtLeLT5LI0hpqMZ
         dBA3NO8lXFTC5aEsEDU8DCw1LUTxpu8afkxWBsUMl2VNUnVoABysCxd6/DgsGrKdTpTg
         ZN2ellZYbqRashei1zRvlzAkIZS0XeCM8iqnkYNX3l4Q+9U6BT7IEkL9Azp8RuOqJmPE
         shhv3xCrL3PB8h8l/GWKSW+wULb8uDHhXcRuYX+Ad3k2cbFalNw/QfH4srw4wEMghoBG
         bhjuONHrlE63ulRkkeHtHiViYUYUmQqoneBBWZwR0/uBwIdXCM55X9Z9N1pjDtSeBouR
         cxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+p5607n/Qx4OeoWA5j6F3HYoZ+CHzgiXbMB9onprQMM=;
        b=OI8pBaROU3CQPlKF1j/rqILy4+pLKS0R3q4XsSiNM52Ay0XA+D2Gd/RopjGsGCRG0Z
         m238k9wSnooo5cJpaneYuNoxRYKIR7HCV3zS3Ioi4LfBvIoQu8aDwtwZEzTq4Ua4L74U
         y0SZ/LaZ/qkxMxtRDQ0h/uT1WnlOfbItg6ecnw+Fwt4sgNrAHuzVLeQ4G1GFTyknZglj
         3XQsKT+A4PXOtJmNWAtrg/fnPXL+RxU9fSs21mnBEecFGWirKDeM3QzfC84W79SSqJeP
         Jc7TWopIpeUIaCHWp8xK9Zk3DkJoz+tce1PETC39Hx+swF7nGz/rDyrePdXddCrkCoDc
         ZZZA==
X-Gm-Message-State: AOAM5307XuL7R3M01OamvwaXlDUg9nywXJnA+KMStYdNqEbxWs8gSKvW
        YwleZ3/G7IzB5vN3BRhv40/3Ti0JwTiRU4NtUCBtwQ==
X-Google-Smtp-Source: ABdhPJz62xJE53ArhJNczOWBtzrWjKaoaUklQ+/ZGbMvTPzwCiMQTfr/SixemAmy2d1KXVzrjs3BWUtVmnQ/sSFzCSA=
X-Received: by 2002:a25:86d1:: with SMTP id y17mr31980173ybm.243.1643648429801;
 Mon, 31 Jan 2022 09:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20220128131006.67712-1-michel@lespinasse.org> <1bfec16f-76c6-9beb-26b2-ca508baa76a3@redhat.com>
In-Reply-To: <1bfec16f-76c6-9beb-26b2-ca508baa76a3@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jan 2022 09:00:18 -0800
Message-ID: <CAJuCfpH+emfOg55Fh6hO90+MeGmg2r5FKR7BeuzPJtsu1ArtZA@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] Speculative page faults
To:     David Hildenbrand <david@redhat.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 1:56 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 28.01.22 14:09, Michel Lespinasse wrote:
>
> Hi Michel,
>
> > This patchset is my take on speculative page faults (spf).
> > It builds on ideas that have been previously proposed by Laurent Dufour,
> > Peter Zijlstra and others before. While Laurent's previous proposal
> > was rejected around the time of LSF/MM 2019, I am hoping we can revisit
> > this now based on what I think is a simpler and more bisectable approach,
> > much improved scaling numbers in the anonymous vma case, and the Android
> > use case that has since emerged. I will expand on these points towards
> > the end of this message.
> >
> > The patch series applies on top of linux v5.17-rc1;
> > a git tree is also available:
> > git fetch https://github.com/lespinasse/linux.git v5.17-rc1-spf-anon
> >
> > I would like these patches to be considered for inclusion into v5.18.
>
> Just a general note: we certainly need (much more) review. And I think
> we'll have to make a decision if the maintenance effort +  complexity
> will be worth the benefit.
>
> > Several android vendors are using Laurent Dufour's previous SPF work into
> > their kernel tree in order to improve application startup performance,
> > want to converge to an upstream accepted solution, and have reported good
> > numbers with previous versions of this patchset. Also, there is a broader
> > interest into reducing mmap lock dependencies in critical MM paths,
> > and I think this patchset would be a good first step in that direction.
> >
> >
> > This patchset follows the same overall structure as the v1 proposal,
> > with the following differences:
> > - Commit 12 (mm: separate mmap locked assertion from find_vma) is new.
> > - The mmu notifier lock is new; this fixes a race in v1 patchset
> >   between speculative COW faults and registering new MMU notifiers.
> > - Speculative handling of swap-cache pages has been removed.
> > - Commit 30 is new; this fixes build issues that showed in some configs.
> >
> >
> > In principle it would also be possible to extend this work for handling
> > file mapped vmas; I have pending work on such patches too but they are
> > not mature enough to be submitted for inclusion at this point.
> >
>
> I'd have expected a performance evaluation at this point, to highlight
> the possible benefit and eventually also downsides, if any.

Hi David,
In Android we and several Android vendors reported application start
time improvements (a critical metric in Android world) on the previous
SPF posting.
My test results were included in the cover letter:
  https://lore.kernel.org/lkml/eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org/T/#m23c5cb33b1a04979c792db6ddd7e3245e5f86bcb
Android vendors reported their results on the same thread:
  https://lore.kernel.org/lkml/eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org/T/#m8eb304b67c9a33388e2fe4448a04a74879120b34
  https://lore.kernel.org/lkml/eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org/T/#maaa58f7072732e5a2a77fe9f65dd3e444c2aed04
And Axel ran pft (pagefault test) benchmarks on server class machines
with results reported here:
  https://lore.kernel.org/lkml/eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org/T/#mc3965e87a702c67909a078a67f8f7964d707b2e0
The Android performance team had recently reported a case when a
low-end device was having visible performance issues and after
applying SPF the device became usable. I'm CC'ing Tim Murray from that
team to provide more information if possible.
As a side-note, an older version of SPF has been used for several
years on Android and many vendors specifically requested us to include
it in our kernels. It is currently maintained in Android Common Kernel
as an out-of-tree patchset and getting it upstream would be huge for
us in terms of getting more testing in a wider ecosystem and
maintenance efforts.
Thanks,
Suren.




>
> >
> > Patchset summary:
> >
> > Classical page fault processing takes the mmap read lock in order to
> > prevent races with mmap writers. In contrast, speculative fault
> > processing does not take the mmap read lock, and instead verifies,
> > when the results of the page fault are about to get committed and
> > become visible to other threads, that no mmap writers have been
> > running concurrently with the page fault. If the check fails,
> > speculative updates do not get committed and the fault is retried
> > in the usual, non-speculative way (with the mmap read lock held).
> >
> > The concurrency check is implemented using a per-mm mmap sequence count.
> > The counter is incremented at the beginning and end of each mmap write
> > operation. If the counter is initially observed to have an even value,
> > and has the same value later on, the observer can deduce that no mmap
> > writers have been running concurrently with it between those two times.
> > This is similar to a seqlock, except that readers never spin on the
> > counter value (they would instead revert to taking the mmap read lock),
> > and writers are allowed to sleep. One benefit of this approach is that
> > it requires no writer side changes, just some hooks in the mmap write
> > lock APIs that writers already use.
> >
> > The first step of a speculative page fault is to look up the vma and
> > read its contents (currently by making a copy of the vma, though in
> > principle it would be sufficient to only read the vma attributes that
> > are used in page faults). The mmap sequence count is used to verify
> > that there were no mmap writers concurrent to the lookup and copy steps.
> > Note that walking rbtrees while there may potentially be concurrent
> > writers is not an entirely new idea in linux, as latched rbtrees
> > are already doing this. This is safe as long as the lookup is
> > followed by a sequence check to verify that concurrency did not
> > actually occur (and abort the speculative fault if it did).
> >
> > The next step is to walk down the existing page table tree to find the
> > current pte entry. This is done with interrupts disabled to avoid
> > races with munmap(). Again, not an entirely new idea, as this repeats
> > a pattern already present in fast GUP. Similar precautions are also
> > taken when taking the page table lock.
> >
> > Breaking COW on an existing mapping may require firing MMU notifiers.
> > Some care is required to avoid racing with registering new notifiers.
> > This patchset adds a new per-cpu rwsem to handle this situation.
>
> I have to admit that this sounds complicated and possibly dangerous to me.
>
>
> Here is one of my concerns, I hope you can clarify:
>
> GUP-fast only ever walks page tables and doesn't actually modify any
> page table state, including, not taking page table locks which might not
> reside in the memmap directly but in auxiliary data. It works because we
> only ever drop the last reference to a page table (to free it) after we
> synchronized against GUP-fast either via an IPI or synchronize_rcu(), as
> GUP=fast disables interrupts.
>
>
> I'd assume that taking page table locks on page tables that might no
> longer be spanned by a VMA because of concurrent page table
> deconstruction  is dangerous:
>
>
> On munmap(), we do the VMA update under mmap_lock in write mode, to the
> remove the page tables under mmap_lock in read mode.
>
> Let's take a look at free_pte_range() on x86:
>
> free_pte_range()
> -> pte_free_tlb()
>  -> tlb_flush_pmd_range()
>   -> __tlb_adjust_range()
>    /* Doesn't actually flush but only updates the tlb range */
>  -> __pte_free_tlb()
>   -> ___pte_free_tlb()
>    -> pgtable_pte_page_dtor()
>     -> ptlock_free()
>     /* page table lock was freed */
>    -> paravirt_tlb_remove_table()
>     -> tlb_remove_page()
>      -> tlb_remove_page_size()
>       -> __tlb_remove_page_size()
>        /* Page added to TLB batch flushing+freeing */
>
> The later tlb_flush_mmu() via tlb_flush_mmu_free()->tlb_table_flush()
> will the free the page tables, after synchronizing against GUP-fast. But
> at that point we already deconstructed the page tables.
>
> So just reading your summary here, what prevents in your approach taking
> a page table lock with racing against page table lock freeing? I cannot
> see how a seqcount would help.
>
>
> IIUC, with what you propose we cannot easily have auxiliary data for a
> page table, at least not via current pgtable_pte_page_dtor(), including
> page locks, which is a drawback (and currently eventually a BUG in your
> code?) at least for me. But I only read the cover letter, so I might be
> missing something important :)
>
> --
> Thanks,
>
> David / dhildenb
>
