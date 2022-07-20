Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611A57B937
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiGTPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiGTPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D8842BE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658329841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gza5PmGLKy1qSecZj4RWFadUQnxBcv3jx7XSNkb+j80=;
        b=ErA8s51fMufh9/SSFqetQ85erBVLkKN7Ec8RqNMTyOI/yfkYANcTjhbQ0yGYFnGpeNDUKG
        v9s6BhOJBIm5x52h45INpjmV3rnyF1DQEuAllkWzp0yqGyzF4dHe1E589z5/gnsPX3xaGy
        0SQSDF3toisFSiZsJ2h05yoDmnPWouw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-FVU7tj9bMgKwq-gir791rQ-1; Wed, 20 Jul 2022 11:10:40 -0400
X-MC-Unique: FVU7tj9bMgKwq-gir791rQ-1
Received: by mail-wr1-f71.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso3239360wrg.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Gza5PmGLKy1qSecZj4RWFadUQnxBcv3jx7XSNkb+j80=;
        b=UGOTV8JOadq4I7uzRy8tTFlagJURzl3UFDL37pNogTfIW74RmaYKU5QxS0k0Hnfcjk
         mnX+xdAeVKRI2Ot9ovqL52RrSrqIzLC8hS4P4+w9+L4a7hg+5+MCmgDqM93c0VTtD1X/
         kggojTTKaVfPZpZXbid8W93XoQkQLYHist3bCdFMTX9bHghxVD9bs6IFSUD79YRyTAPD
         VgCfcas9+HZ2qj4JAT08rYM4DECU812mrgXrJeb+l1QvTYcQmrcm+AtVRfqBeobn9Y98
         RC2vPnnqzavlzoQ41QsExaGDHV7uzsG/qRz4MA6c3KjtP4DSAtL6ltxLMwhXVbjQloK8
         4xUg==
X-Gm-Message-State: AJIora8OPGhUpVoXt2YyuYQk93/l7vCYxbKkL80wUgWLetfa4iD0uypY
        tCfSdXMFftmbgEBOk1blxRiBN5D8ka38rARzmqs8AW0/GMKJj09yLjILMu0W0Hj5tksSP4URNF2
        sQwnheOPL5Kc6idPZtvdgAGIT
X-Received: by 2002:a5d:6d86:0:b0:21d:a3ca:bad0 with SMTP id l6-20020a5d6d86000000b0021da3cabad0mr31601070wrs.12.1658329839049;
        Wed, 20 Jul 2022 08:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1visr78sAwmLgNUyShdyjWna04Tp6reUTZ5r1mIq++86IWNldc+Y4tOgDKX5dzjGAzBtAWpKA==
X-Received: by 2002:a5d:6d86:0:b0:21d:a3ca:bad0 with SMTP id l6-20020a5d6d86000000b0021da3cabad0mr31601036wrs.12.1658329838752;
        Wed, 20 Jul 2022 08:10:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003a32251c3f9sm3410885wms.5.2022.07.20.08.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 08:10:38 -0700 (PDT)
Message-ID: <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
Date:   Wed, 20 Jul 2022 17:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ytf+zIxVPTVXTZdp@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 15:10, Peter Xu wrote:
> On Wed, Jul 20, 2022 at 11:39:23AM +0200, David Hildenbrand wrote:
>> On 19.07.22 22:47, Peter Xu wrote:
>>> On Mon, Jul 18, 2022 at 05:01:59AM -0700, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>>
>>>> When userfaultfd makes a PTE writable, it can now change the PTE
>>>> directly, in some cases, without going triggering a page-fault first.
>>>> Yet, doing so might leave the PTE that was write-unprotected as old and
>>>> clean. At least on x86, this would cause a >500 cycles overhead when the
>>>> PTE is first accessed.
>>>>
>>>> Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
>>>> gets a hint that the page is likely to be used. Avoid changing the PTE
>>>> to young and dirty in other cases to avoid excessive writeback and
>>>> messing with the page reclamation logic.
>>>>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Peter Xu <peterx@redhat.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Yu Zhao <yuzhao@google.com>
>>>> Cc: Nick Piggin <npiggin@gmail.com>
>>>> ---
>>>>  include/linux/mm.h | 2 ++
>>>>  mm/mprotect.c      | 9 ++++++++-
>>>>  mm/userfaultfd.c   | 8 ++++++--
>>>>  3 files changed, 16 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 9cc02a7e503b..4afd75ce5875 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>>>>  /* Whether this change is for write protecting */
>>>>  #define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
>>>>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
>>>> +/* Whether to try to mark entries as dirty as they are to be written */
>>>> +#define  MM_CP_WILL_NEED		   (1UL << 4)
>>>>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>>>>  					    MM_CP_UFFD_WP_RESOLVE)
>>>>  
>>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>>> index 996a97e213ad..34c2dfb68c42 100644
>>>> --- a/mm/mprotect.c
>>>> +++ b/mm/mprotect.c
>>>> @@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>>>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>>>>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>>>>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
>>>> +	bool will_need = cp_flags & MM_CP_WILL_NEED;
>>>>  
>>>>  	tlb_change_page_size(tlb, PAGE_SIZE);
>>>>  
>>>> @@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>>>  				ptent = pte_clear_uffd_wp(ptent);
>>>>  			}
>>>>  
>>>> +			if (will_need)
>>>> +				ptent = pte_mkyoung(ptent);
>>>
>>> For uffd path, UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY are new
>>> internal flags used with or without the new feature bit set.  It means even
>>> with !ACCESS_HINT we'll start to set young bit while we used not to?  Is
>>> that some kind of a light abi change?
>>>
>>> I'd suggest we only set will_need if ACCESS_HINT is set.
>>>
>>>> +
>>>>  			/*
>>>>  			 * In some writable, shared mappings, we might want
>>>>  			 * to catch actual write access -- see
>>>> @@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>>>  			 */
>>>>  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>>>  			    !pte_write(ptent) &&
>>>> -			    can_change_pte_writable(vma, addr, ptent))
>>>> +			    can_change_pte_writable(vma, addr, ptent)) {
>>>>  				ptent = pte_mkwrite(ptent);
>>>> +				if (will_need)
>>>> +					ptent = pte_mkdirty(ptent);
>>>
>>> Can we make this unconditional?  IOW to cover both:
>>>
>>>   (1) When will_need is not set, or
>>>   (2) mprotect() too
>>>
>>> David's patch is good in that we merged the unprotect and CoW.  However
>>> that's not complete because the dirty bit ops are missing.
>>>
>>> Here IMHO we should have a standalone patch to just add the dirty bit into
>>> this logic when we'll grant write bit.  IMHO it'll make the write+dirty
>>> bits coherent again in all paths.
>>
>> I'm not sure I follow.
>>
>> We *surely* don't want to dirty random pages (especially once in the
>> pagecache/swapcache) simply because we change protection.
>>
>> Just like we don't set all pages write+dirty in a writable VMA on a read
>> fault.
> 
> IMO unmprotect (in generic mprotect form or uffd form) has a stronger sign
> of page being written, unlike read faults, as many of them happen because
> page being written and message generated.

I'm sorry, but I am very skeptical about such statements. I don't buy it.

> 
> But yeah you have a point too, maybe we shouldn't assume such a condition.
> Especially as long as we won't set write=1 without soft-dirty tracking
> enabled, I think it should be safe.

For pagecache pages it may as well be *plain wrong* to bypass the write
fault handler and simply mark pages dirty+map them writable.

Please, let's keep this protection change handler here as simple as
possible and *not* try to replicate the whole write fault handler logic
in here by relying on statements as above.

If we try optimizing for corner cases by making the implementation here
overly complicated, then we are clearly doing something wrong.

-- 
Thanks,

David / dhildenb

