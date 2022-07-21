Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056257C57E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiGUHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGUHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2ABDFD0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658389564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16t32vV12xwBpAcbt3NrjlFAHE0uEzXQweHiCxuyK+s=;
        b=OAQKGLGGQt1zqTvoFeUSRI3U28DWXhR1IkYc4j6v55Rq8pcWxsvE9+l9Gq5Hww4/m2vpIO
        i8ZzK4suTqewiVJqfN/wrrU+SDZNGeAR5ZhTxaqUSyw3Zn0UnnfE4nQXAMRxPmO/VeYZb5
        ZmkpqXyz0tgekrY4zj0M9rfwokGBIvg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-KQG4g_yNOd25LB1ocWIafA-1; Thu, 21 Jul 2022 03:46:02 -0400
X-MC-Unique: KQG4g_yNOd25LB1ocWIafA-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so341785wmp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=16t32vV12xwBpAcbt3NrjlFAHE0uEzXQweHiCxuyK+s=;
        b=eOZnHhsM23HDMxU2z9NxysEoVeC87PnIzFBuY+qmGRURDrBeS39ai+kZSUjK8JxMYf
         Fgec0Il+d/FsrLCXMaokVJb7G6iWfULTd62mkFqPNPz8ABug/iOpdHqPLm8CvCzRacSQ
         KvCYmh+Z+Jc7Q18CcFYXGP8e8fcseUk0Pt8/0IsrlTjjnqB3nqwVRrfr/J2qeONZAAmr
         KfxXNBt2uM/TAQP608JQ1coFmnvzd16ikRf4KEivt24BQ8G+bAHaPQsUiXFWDXCrmsN1
         iKDXI5KsRx0S7J4eJVZS2d1HzqND2tYEyZHkosTecA/GJPWslw0itTmgBzYLuyct+bSz
         Fbsg==
X-Gm-Message-State: AJIora8249IgGcfscUrNfhidrl590sX9MPdW668G6F25T6dNxRhtK5f0
        1MfAHHLYdOMXVZutvQ04Gxf/Wmm2exGiUpamdVjswk0GmBfD7pR77UphLdbmGPoiRVrDLuwP0g+
        2hw6huHOujyql3MJ+X/b5Mvwm
X-Received: by 2002:a5d:47a1:0:b0:21d:a50e:b2d7 with SMTP id 1-20020a5d47a1000000b0021da50eb2d7mr34599041wrb.58.1658389561116;
        Thu, 21 Jul 2022 00:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vAviz4+n+ekfx1YTmywN135cIVAx52CImT2vFjv9x9M2WJivSkHASe1fQ3OazcUhsDnEKhmA==
X-Received: by 2002:a5d:47a1:0:b0:21d:a50e:b2d7 with SMTP id 1-20020a5d47a1000000b0021da50eb2d7mr34599015wrb.58.1658389560772;
        Thu, 21 Jul 2022 00:46:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:e000:25d3:15fa:4c8b:7e8d? (p200300cbc707e00025d315fa4c8b7e8d.dip0.t-ipconnect.de. [2003:cb:c707:e000:25d3:15fa:4c8b:7e8d])
        by smtp.gmail.com with ESMTPSA id k22-20020a5d5256000000b0021d6a520ce9sm1095513wrc.47.2022.07.21.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:46:00 -0700 (PDT)
Message-ID: <7a7377c8-1852-88d3-a768-ed1a6eac0c0c@redhat.com>
Date:   Thu, 21 Jul 2022 09:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-4-namit@vmware.com>
 <23a9d678-487e-5940-4cde-dc53d920fb48@redhat.com>
 <A6EB667E-590C-4B6C-A932-EF7C5F711755@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 03/14] mm/mprotect: allow exclusive anon pages to be
 writable
In-Reply-To: <A6EB667E-590C-4B6C-A932-EF7C5F711755@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 19:25, Nadav Amit wrote:
> On Jul 20, 2022, at 8:19 AM, David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.07.22 14:02, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>>
>>> Anonymous pages might have the dirty bit clear, but this should not
>>> prevent mprotect from making them writable if they are exclusive.
>>> Therefore, skip the test whether the page is dirty in this case.
>>>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Yu Zhao <yuzhao@google.com>
>>> Cc: Nick Piggin <npiggin@gmail.com>
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>> mm/mprotect.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index 34c2dfb68c42..da5b9bf8204f 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -45,7 +45,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>>>
>>> 	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
>>>
>>> -	if (pte_protnone(pte) || !pte_dirty(pte))
>>> +	if (pte_protnone(pte))
>>> 		return false;
>>>
>>> 	/* Do we need write faults for softdirty tracking? */
>>> @@ -66,7 +66,8 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>>> 		page = vm_normal_page(vma, addr, pte);
>>> 		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
>>> 			return false;
>>> -	}
>>> +	} else if (!pte_dirty(pte))
>>> +		return false;
>>>
>>> 	return true;
>>> }
>>
>> When I wrote that code, I was wondering how often that would actually
>> happen in practice -- and if we care about optimizing that. Do you have
>> a gut feeling in which scenarios this would happen and if we care?
>>
>> If the page is in the swapcache and was swapped out, you'd be requiring
>> a writeback even though nobody modified the page and possibly isn't
>> going to do so in the near future.
> 
> So here is my due diligence: I did not really encounter a scenario in which
> it showed up. When I looked at your code, I assumed this was an oversight
> and not a thoughtful decision. For me the issue is more of the discrepancy
> between how a certain page is handled before and after it was pages out.
> 
> The way that I see it, there is a tradeoff in the way dirty-bit should
> be handled:
> (1) Writable-clean PTEs introduce some non-negligible overhead.
> (2) Marking a PTE dirty speculatively would require a write back.
> 
> … But this tradeoff should not affect whether a PTE is writable, i.e.,
> mapping the PTE as writable-clean should not cause a writeback. In other
> words, if you are concerned about unnecessary writebacks, which I think is a
> fair concern, then do not set the dirty-bit. In a later patch I try to avoid
> TLB flushes on clean-writable entries that are write-protected.
> 
> So I do not think that the writeback you mentioned should be a real issue.
> Yet if you think that using the fact that the page is not-dirty is a good
> hueristics to avoid future TLB flushes (for P->NP; as I said there is a
> solution for RW->RO), or if you are concerned about the cost of
> vm_normal_page(), perhaps those are valid concerned (although I do not think
> so).

I think I now understand what you mean. I somehow remembered that some
architectures set a PTE dirty when marking it writable, but I guess this
is not true -- and setting it writable will keep it !dirty until really
accessed (either by the HW or by a fault). [I'll do some more digging
just to confirm]

With that in mind, your patch makes sense, and I guess you'd want that
as patch #1, because otherwise I fail to see how current patch #1 would
even succeed in reaching the "pte_mkdirty" call -- if !pte_dirty()
protects the code from running.

> 
> --
> 
> [ Regarding (1): After some discussions with Peter and reading more code, I
> thought at some point that perhaps avoiding having writable-clean PTE as
> much as possible makes sense [*], since setting the dirty-bit costs ~550
> cycles and a page fault is not a lot more than 1000. But with all the
> mitigations (and after adding IBRS for retbless) page-fault entry is kind of
> expensive. 

I understand the reasoning for anonymous memory, but not for page cache
pages. And for anonymous memory I think there are still cases where we
don't want to do that (swapcache and MADV_FREE comes to mind) -- and
IMHO some of the scenarios where we have clean anonymous memory at all,
we just don't care about optimizing for setting the dirty bit faster on
x86 ;) .

So my gut feeling is to keep it as simple as possible. To me, it
translates to setting the dirty bit only if we have clear indication
that write access is likely next.

Thanks Nadav for refreshing my memory :) !

-- 
Thanks,

David / dhildenb

