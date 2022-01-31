Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191644A3F94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbiAaJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242276AbiAaJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643622993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPL0O3OZO2sBp8q3pVdBULkt4CER16uFRA3OEMRNQsE=;
        b=Z4pOULxsH5PAz6nm2AseC9ShAuJKPboSVc3ICKmHhTOay3UT0QQU+wxtj7piP7DhNb81n6
        7T087RZ/lQnLLYgwssnL2KJTw5pcQ2YpvtvnZWCqwxWO+0VFdCCOrnUPC1RJV5dDHTT4iU
        hX5mQ8UIgu/Tv0UGZWTYQ6vBjpUifbo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-aayczqJANiSS34Ysn-NHdA-1; Mon, 31 Jan 2022 04:56:32 -0500
X-MC-Unique: aayczqJANiSS34Ysn-NHdA-1
Received: by mail-ej1-f69.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so4752564ejc.15
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 01:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=uPL0O3OZO2sBp8q3pVdBULkt4CER16uFRA3OEMRNQsE=;
        b=A8Q2JMjNkxXJYrP8ASlhsixmW7pQ8UE4ZeivgDfBaOIMrTay1IY+dYgen6uXjgo9zU
         w14HN9AULFVfvGiy5AWam8r8QXEyAOdUKf9RNZ+TaKrhqWOg6jrXKGirxQzVOgpCRVe1
         WG/pwtV6IDA0OcVyydQ/IEObFs51DDqS0I214457dzPnvg7us8Eg3S+BGgTP33QHwB0O
         DkQEslAtu5IszGS3GGqBadmiXt7vW2aoDAFYnwPMzUFtNTqNfU81DsiajcY/f9tcoTBW
         q8XQ2HBW7HJvrs9LsOX8MFEf/ilEwjEgumVLBYRGDTYW5e/XUWXpgFpmITpDbxTgHgEL
         hTSw==
X-Gm-Message-State: AOAM530DhYlodEj4zPA5aUQ1sIHcMCImfFrGpFyQ79g/hA3xQ9f9FqG2
        p9A4BQ3mlx3Tjf0+caurJU2AV6CLXa6UlEfK1QvFffU3BR9EQ3lKl7y+f7rS9PROHlVFSCil9fj
        2w1Rqh7Dvb6QHETwNiCPwTo1g
X-Received: by 2002:a05:6402:50d1:: with SMTP id h17mr19922681edb.286.1643622991187;
        Mon, 31 Jan 2022 01:56:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzq1PRljbEQ1jgD+hGkNrud6dVoVqmVaeoZYcw4UWtEg/8O0R5QuzTpTq6+DoDNO8YqMSRgbg==
X-Received: by 2002:a05:6402:50d1:: with SMTP id h17mr19922653edb.286.1643622990875;
        Mon, 31 Jan 2022 01:56:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id d25sm13272169ejz.4.2022.01.31.01.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:56:30 -0800 (PST)
Message-ID: <1bfec16f-76c6-9beb-26b2-ca508baa76a3@redhat.com>
Date:   Mon, 31 Jan 2022 10:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
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
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 00/35] Speculative page faults
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.22 14:09, Michel Lespinasse wrote:

Hi Michel,

> This patchset is my take on speculative page faults (spf).
> It builds on ideas that have been previously proposed by Laurent Dufour,
> Peter Zijlstra and others before. While Laurent's previous proposal
> was rejected around the time of LSF/MM 2019, I am hoping we can revisit
> this now based on what I think is a simpler and more bisectable approach,
> much improved scaling numbers in the anonymous vma case, and the Android
> use case that has since emerged. I will expand on these points towards
> the end of this message.
> 
> The patch series applies on top of linux v5.17-rc1;
> a git tree is also available:
> git fetch https://github.com/lespinasse/linux.git v5.17-rc1-spf-anon
> 
> I would like these patches to be considered for inclusion into v5.18.

Just a general note: we certainly need (much more) review. And I think
we'll have to make a decision if the maintenance effort +  complexity
will be worth the benefit.

> Several android vendors are using Laurent Dufour's previous SPF work into
> their kernel tree in order to improve application startup performance,
> want to converge to an upstream accepted solution, and have reported good
> numbers with previous versions of this patchset. Also, there is a broader
> interest into reducing mmap lock dependencies in critical MM paths,
> and I think this patchset would be a good first step in that direction.
> 
> 
> This patchset follows the same overall structure as the v1 proposal,
> with the following differences:
> - Commit 12 (mm: separate mmap locked assertion from find_vma) is new.
> - The mmu notifier lock is new; this fixes a race in v1 patchset
>   between speculative COW faults and registering new MMU notifiers.
> - Speculative handling of swap-cache pages has been removed.
> - Commit 30 is new; this fixes build issues that showed in some configs.
> 
> 
> In principle it would also be possible to extend this work for handling
> file mapped vmas; I have pending work on such patches too but they are
> not mature enough to be submitted for inclusion at this point.
> 

I'd have expected a performance evaluation at this point, to highlight
the possible benefit and eventually also downsides, if any.

> 
> Patchset summary:
> 
> Classical page fault processing takes the mmap read lock in order to
> prevent races with mmap writers. In contrast, speculative fault
> processing does not take the mmap read lock, and instead verifies,
> when the results of the page fault are about to get committed and
> become visible to other threads, that no mmap writers have been
> running concurrently with the page fault. If the check fails,
> speculative updates do not get committed and the fault is retried
> in the usual, non-speculative way (with the mmap read lock held).
> 
> The concurrency check is implemented using a per-mm mmap sequence count.
> The counter is incremented at the beginning and end of each mmap write
> operation. If the counter is initially observed to have an even value,
> and has the same value later on, the observer can deduce that no mmap
> writers have been running concurrently with it between those two times.
> This is similar to a seqlock, except that readers never spin on the
> counter value (they would instead revert to taking the mmap read lock),
> and writers are allowed to sleep. One benefit of this approach is that
> it requires no writer side changes, just some hooks in the mmap write
> lock APIs that writers already use.
> 
> The first step of a speculative page fault is to look up the vma and
> read its contents (currently by making a copy of the vma, though in
> principle it would be sufficient to only read the vma attributes that
> are used in page faults). The mmap sequence count is used to verify
> that there were no mmap writers concurrent to the lookup and copy steps.
> Note that walking rbtrees while there may potentially be concurrent
> writers is not an entirely new idea in linux, as latched rbtrees
> are already doing this. This is safe as long as the lookup is
> followed by a sequence check to verify that concurrency did not
> actually occur (and abort the speculative fault if it did).
> 
> The next step is to walk down the existing page table tree to find the
> current pte entry. This is done with interrupts disabled to avoid
> races with munmap(). Again, not an entirely new idea, as this repeats
> a pattern already present in fast GUP. Similar precautions are also
> taken when taking the page table lock.
> 
> Breaking COW on an existing mapping may require firing MMU notifiers.
> Some care is required to avoid racing with registering new notifiers.
> This patchset adds a new per-cpu rwsem to handle this situation.

I have to admit that this sounds complicated and possibly dangerous to me.


Here is one of my concerns, I hope you can clarify:

GUP-fast only ever walks page tables and doesn't actually modify any
page table state, including, not taking page table locks which might not
reside in the memmap directly but in auxiliary data. It works because we
only ever drop the last reference to a page table (to free it) after we
synchronized against GUP-fast either via an IPI or synchronize_rcu(), as
GUP=fast disables interrupts.


I'd assume that taking page table locks on page tables that might no
longer be spanned by a VMA because of concurrent page table
deconstruction  is dangerous:


On munmap(), we do the VMA update under mmap_lock in write mode, to the
remove the page tables under mmap_lock in read mode.

Let's take a look at free_pte_range() on x86:

free_pte_range()
-> pte_free_tlb()
 -> tlb_flush_pmd_range()
  -> __tlb_adjust_range()
   /* Doesn't actually flush but only updates the tlb range */
 -> __pte_free_tlb()
  -> ___pte_free_tlb()
   -> pgtable_pte_page_dtor()
    -> ptlock_free()
    /* page table lock was freed */
   -> paravirt_tlb_remove_table()
    -> tlb_remove_page()
     -> tlb_remove_page_size()
      -> __tlb_remove_page_size()
       /* Page added to TLB batch flushing+freeing */

The later tlb_flush_mmu() via tlb_flush_mmu_free()->tlb_table_flush()
will the free the page tables, after synchronizing against GUP-fast. But
at that point we already deconstructed the page tables.

So just reading your summary here, what prevents in your approach taking
a page table lock with racing against page table lock freeing? I cannot
see how a seqcount would help.


IIUC, with what you propose we cannot easily have auxiliary data for a
page table, at least not via current pgtable_pte_page_dtor(), including
page locks, which is a drawback (and currently eventually a BUG in your
code?) at least for me. But I only read the cover letter, so I might be
missing something important :)

-- 
Thanks,

David / dhildenb

