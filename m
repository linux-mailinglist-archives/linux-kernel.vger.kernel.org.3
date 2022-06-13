Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC954A030
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiFMUwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346417AbiFMUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 357C215FC7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655151022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rR7JaD3q8qTUeYECk93qYjKc7dif3t1p4wuEQFyTh6k=;
        b=GkHJIfSfRIWTUiqPnHFGyBMTvkXxQWIqFfJk+k8TTwedUcdaxttYDTOLAcv4YT5uO2Jikk
        S/46GrupC0vuoNd9fIgKHF1VzUHjOUFiY6Z3PGtN+F4qjTwuK3HPXDXJCyWdV4+y0FCdAU
        nRj3wbE7h+oS0denIUOeZP0BQomQqno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-E4o7wv3bPrWE-ZGmoXX9VQ-1; Mon, 13 Jun 2022 16:10:20 -0400
X-MC-Unique: E4o7wv3bPrWE-ZGmoXX9VQ-1
Received: by mail-wm1-f70.google.com with SMTP id z13-20020a7bc7cd000000b0039c4a238eadso2949814wmk.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=rR7JaD3q8qTUeYECk93qYjKc7dif3t1p4wuEQFyTh6k=;
        b=N8h/L8f4kEE0Codxmdc9VdlJDwDIRJXYT9Bc//lPJh6UWhlQvA4DUlLbKZFqWe1nF9
         qyv3llwRjhXeCSegeC/Ks1wV61i7vDzvcw1xEJ1Ept39npQMeBbfM0YuWIJ9Oj8v+szw
         VJxfBHiVxS0EBDSfHpHYtZYk37JIiNZjJXOKUlIzp1kIY5mADDMuA4HMIrtQDBX/2LZ/
         2G9/rMC1btOVCCPMSs/N2/aubbvZKSssuDpB+ey1QQfgXMTQdsxQDwelCmyOfqBtd7pi
         +OEEAYbHjrqgmd1By4U6yb5Ps7L2/PdVs9wDttXLwKn9hbiNv5nHxPfNt8mCzeD5cHFD
         1YNA==
X-Gm-Message-State: AJIora+4azRw2jiAZ90az+bGC2i53fsFohSQh92G8gkzMc81ll+24wmU
        6Q0RIsSLlx4LD3YA0niI8L1xl7GN1BAKMYj92Oo9LxfeSJPTLwDPS3DkMKxCPEsVFINidkXI3pF
        nKn7B4OL2JJ+x04IDyLuryCra
X-Received: by 2002:adf:ae09:0:b0:20e:e4f0:2133 with SMTP id x9-20020adfae09000000b0020ee4f02133mr1429651wrc.104.1655151018013;
        Mon, 13 Jun 2022 13:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tEBfGYzbRoGtpWCbNt96IUnAi4iF5SlIbS1OLPQdVbI1Q9kTbvPd7uMfJeVRnhpsdg5LvrYQ==
X-Received: by 2002:adf:ae09:0:b0:20e:e4f0:2133 with SMTP id x9-20020adfae09000000b0020ee4f02133mr1429633wrc.104.1655151017734;
        Mon, 13 Jun 2022 13:10:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:bd00:963c:5455:c10e:fa6f? (p200300cbc706bd00963c5455c10efa6f.dip0.t-ipconnect.de. [2003:cb:c706:bd00:963c:5455:c10e:fa6f])
        by smtp.gmail.com with ESMTPSA id x20-20020a1c7c14000000b0039c506de087sm10670867wmc.6.2022.06.13.13.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:10:17 -0700 (PDT)
Message-ID: <9b38302c-ed93-8825-f543-6ce8878748f9@redhat.com>
Date:   Mon, 13 Jun 2022 22:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Collingbourne <pcc@google.com>
References: <20220610181436.84713-1-david@redhat.com>
 <5DFB7262-6E32-4984-A346-B7DE5040B12F@gmail.com>
 <YqeTSj98t/KfOAJ9@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
In-Reply-To: <YqeTSj98t/KfOAJ9@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.22 21:43, Peter Xu wrote:
> Hi, David,
> 
> On Fri, Jun 10, 2022 at 11:42:06AM -0700, Nadav Amit wrote:
>> On Jun 10, 2022, at 11:14 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>>> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
>>> can try mapping anonymous pages writable if they are exclusive,
>>> the PTE is already dirty, and no special handling applies. Mapping the
>>> PTE writable is essentially the same thing the write fault handler would do
>>> in this case.
>>>
>>> Special handling is required for uffd-wp and softdirty tracking, so take
>>> care of that properly. Also, leave PROT_NONE handling alone for now;
>>> in the future, we could similarly extend the logic in do_numa_page() or
>>> use pte_mk_savedwrite() here. Note that we'll now also check for uffd-wp in
>>> case of VM_SHARED -- which is harmless and prepares for uffd-wp support for
>>> shmem.
>>>
>>> While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
>>> performance, it should also be a valuable optimization for uffd-wp, when
>>> un-protecting.
>>>
>>> Applying the same logic to PMDs (anonymous THP, anonymous hugetlb) is
>>> probably not worth the trouble, but could similarly be added if there is
>>> demand.
> 
> My memory was that Andrea had a version that used to have thp optimized
> too.  It'll be a slight pity to lose it if still possible, then we treat
> thp and small pages the same logic and be all fair.  Or is there any other
> challenge that we're facing?

Not really, but I assume performance gain will be minimal and might not
be worth the trouble.

I'm fairly busy (and not aware of Andreas version), so I can look at
this, but it will be part of a separate patch because it will go on my
TODO list. Not mad if someone beats me to it ;)

> 
>>>
>>> Results of a simple microbenchmark on my Ryzen 9 3900X, comparing the new
>>> optimization (avoiding write faults) during mprotect() with softdirty
>>> tracking, where we require a write fault.
> 
> Are we comparing the mprotect() sequence operations against softdirty
> clearing operation?  Would it make more sense if we compare the same
> mprotect() sequence to kernels that are before/after this patch applied?

For simplicity I compared on the same kernel, one time exploting the
optimization and one time disabling the optimization via softdirty.

I can also simply measure without+with. Extra work for me to combine
outputs :P

> 
>>>
>>>  Running 1000 iterations each
>>>
>>>  ==========================================================
>>>  Measuring memset() of 4096 bytes
>>>   First write access:
>>>    Min: 169 ns, Max: 8997 ns, Avg: 830 ns
>>>   Second write access:
>>>    Min: 80 ns, Max: 251 ns, Avg: 168 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 180 ns, Max: 290 ns, Avg: 190 ns
>>>   Write access after clearing softdirty:
>>>    Min: 451 ns, Max: 1774 ns, Avg: 470 ns
>>>  -> mprotect = 1.131 * second [avg]
>>>  -> mprotect = 0.404 * softdirty [avg]
> 
> (I don't understand these two lines.. but maybe I'm the only one?)

Most probably not.

"mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)" needs 113,1% the
runtime compared with the "second write" access.

"mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)" needs 40% of the
runtime compared with disabling the optimization via softdirty tracking.

I may find time to clean that up a bit more to make it easier to consume
for humans.

> 
>>>  ----------------------------------------------------------
>>>  Measuring single byte access per page of 4096 bytes
>>>   First write access:
>>>    Min: 761 ns, Max: 1152 ns, Avg: 784 ns
>>>   Second write access:
>>>    Min: 130 ns, Max: 181 ns, Avg: 137 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 150 ns, Max: 1553 ns, Avg: 155 ns
>>>   Write access after clearing softdirty:
>>>    Min: 169 ns, Max: 1783 ns, Avg: 432 ns
>>>  -> mprotect = 1.131 * second [avg]
>>>  -> mprotect = 0.359 * softdirty [avg]
>>>  ==========================================================
>>>  Measuring memset() of 16384 bytes
>>>   First write access:
>>>    Min: 1594 ns, Max: 3497 ns, Avg: 2143 ns
>>>   Second write access:
>>>    Min: 250 ns, Max: 381 ns, Avg: 260 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 290 ns, Max: 1643 ns, Avg: 300 ns
>>>   Write access after clearing softdirty:
>>>    Min: 1242 ns, Max: 8987 ns, Avg: 1297 ns
>>>  -> mprotect = 1.154 * second [avg]
>>>  -> mprotect = 0.231 * softdirty [avg]
>>>  ----------------------------------------------------------
>>>  Measuring single byte access per page of 16384 bytes
>>>   First write access:
>>>    Min: 1953 ns, Max: 2945 ns, Avg: 2008 ns
>>>   Second write access:
>>>    Min: 130 ns, Max: 912 ns, Avg: 142 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 160 ns, Max: 240 ns, Avg: 166 ns
>>>   Write access after clearing softdirty:
>>>    Min: 1112 ns, Max: 1513 ns, Avg: 1126 ns
>>>  -> mprotect = 1.169 * second [avg]
>>>  -> mprotect = 0.147 * softdirty [avg]
>>>  ==========================================================
>>>  Measuring memset() of 65536 bytes
>>>   First write access:
>>>    Min: 7524 ns, Max: 15650 ns, Avg: 7680 ns
>>>   Second write access:
>>>    Min: 251 ns, Max: 1323 ns, Avg: 648 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 270 ns, Max: 1282 ns, Avg: 736 ns
>>>   Write access after clearing softdirty:
>>>    Min: 4558 ns, Max: 12524 ns, Avg: 4623 ns
>>>  -> mprotect = 1.136 * second [avg]
>>>  -> mprotect = 0.159 * softdirty [avg]
>>>  ----------------------------------------------------------
>>>  Measuring single byte access per page of 65536 bytes
>>>   First write access:
>>>    Min: 7083 ns, Max: 9027 ns, Avg: 7241 ns
>>>   Second write access:
>>>    Min: 140 ns, Max: 201 ns, Avg: 156 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 190 ns, Max: 451 ns, Avg: 197 ns
>>>   Write access after clearing softdirty:
>>>    Min: 3707 ns, Max: 5119 ns, Avg: 3958 ns
>>>  -> mprotect = 1.263 * second [avg]
>>>  -> mprotect = 0.050 * softdirty [avg]
>>>  ==========================================================
>>>  Measuring memset() of 524288 bytes
>>>   First write access:
>>>    Min: 58470 ns, Max: 87754 ns, Avg: 59353 ns
>>>   Second write access:
>>>    Min: 5180 ns, Max: 6863 ns, Avg: 5318 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 5871 ns, Max: 9358 ns, Avg: 6028 ns
>>>   Write access after clearing softdirty:
>>>    Min: 35797 ns, Max: 41338 ns, Avg: 36710 ns
>>>  -> mprotect = 1.134 * second [avg]
>>>  -> mprotect = 0.164 * softdirty [avg]
>>>  ----------------------------------------------------------
>>>  Measuring single byte access per page of 524288 bytes
>>>   First write access:
>>>    Min: 53751 ns, Max: 59431 ns, Avg: 54506 ns
>>>   Second write access:
>>>    Min: 781 ns, Max: 2194 ns, Avg: 1123 ns
>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>    Min: 161 ns, Max: 1282 ns, Avg: 622 ns
>>>   Write access after clearing softdirty:
>>>    Min: 30888 ns, Max: 34565 ns, Avg: 31229 ns
>>>  -> mprotect = 0.554 * second [avg]
>>>  -> mprotect = 0.020 * softdirty [avg]
>>>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Nadav Amit <nadav.amit@gmail.com>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>
>>> v1 -> v2:
>>> * Rebased on v5.19-rc1
>>> * Rerun benchmark
>>> * Fix minor spelling issues in subject+description
>>> * Drop IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) check
>>> * Move pte_write() check into caller
>>>
>>> ---
>>> mm/mprotect.c | 67 ++++++++++++++++++++++++++++++++++++++++++---------
>>> 1 file changed, 55 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index ba5592655ee3..728772bf41c7 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -38,6 +38,45 @@
>>>
>>> #include "internal.h"
>>>
>>> +static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>>> +					   unsigned long addr, pte_t pte,
>>> +					   unsigned long cp_flags)
>>> +{
>>> +	struct page *page;
>>> +
>>> +	if ((vma->vm_flags & VM_SHARED) && !(cp_flags & MM_CP_DIRTY_ACCT))
>>> +		/*
>>> +		 * MM_CP_DIRTY_ACCT is only expressive for shared mappings;
>>> +		 * without MM_CP_DIRTY_ACCT, there is nothing to do.
>>> +		 */
>>> +		return false;
>>> +
>>> +	if (pte_protnone(pte) || !pte_dirty(pte))
>>> +		return false;
>>> +
>>> +	/* Do we need write faults for softdirty tracking? */
>>> +	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
>>> +		return false;
>>> +
>>> +	/* Do we need write faults for uffd-wp tracking? */
>>> +	if (userfaultfd_pte_wp(vma, pte))
>>> +		return false;
>>> +
>>> +	if (!(vma->vm_flags & VM_SHARED)) {
>>> +		/*
>>> +		 * We can only special-case on exclusive anonymous pages,
>>> +		 * because we know that our write-fault handler similarly would
>>> +		 * map them writable without any additional checks while holding
>>> +		 * the PT lock.
>>> +		 */
>>> +		page = vm_normal_page(vma, addr, pte);
>>> +		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
>>> +			return false;
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>
>> Looks good in general. Just wondering (out loud) whether it makes more sense
>> to do all the vm_flags and cp_flags related checks in one of the callers
>> (mprotect_fixup()?) and propagate whether to try to write-unprotect in
>> cp_flags (e.g., by introducing new MM_CP_TRY_WRITE_UNPROTECT).
> 
> I can see why David put it like that, because most of the checks are on
> ptes not vm_flags.
> 
> But I also agree on this point, especially if to put it in another way:
> IMHO it'll be confusing if we keey MM_CP_DIRTY_ACCT==false for all private
> pages even if we're going to take them into account and do smart unprotect
> operations.
> 
> So I'm wondering whether we could still at least move vm_flags check into
> the mprotect_fixup() as suggested by Nadav, perhaps something like:
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..aefd5fe982af 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -583,7 +583,11 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
>          * held in write mode.
>          */
>         vma->vm_flags = newflags;
> -       dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
> +       if (vma->vm_flags & VM_SHARED)
> +               dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
> +       else
> +               /* For private mappings, only if it's writable */
> +               dirty_accountable = vma->vm_flags & VM_WRITE;
>         vma_set_page_prot(vma);
>  
>         change_protection(tlb, vma, start, end, vma->vm_page_prot,
> 
> Then IIUC we could drop both the VM_WRITE check in change_pte_range(), and
> also the VM_SHARED check above in can_change_pte_writable().  Not sure
> whether that'll look slightly cleaner.

I'll give it a shot and most probably rename dirty_accountable to
something more expressive -- like Nadav proposed, for example.

> 
> I'm also copying Peter Collingbourne <pcc@google.com> because afaict he
> proposed the initial idea (maybe worth some credit in the commit message?),

Do you have a link to that conversation? Either my memory is messing
with me or I did this without reading that mail (which I think, because
it simply made sense with PageAnonExclusive at hand). Still, I can add a
reference to that mail and mention that this was suggested earlier by
Peter C..


Thanks!

-- 
Thanks,

David / dhildenb

