Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4747495C82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379660AbiAUJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:04:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379708AbiAUJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642755889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+c0Hr1BXH8XrdbKwPEYPBmPMm2W8e8zS+mQCFP2tguU=;
        b=USrZsOJ4k6Uez2snjUq96mQCthHiHYOzm1MdNwIOHODSD6IZpGpcDvxTXXC6SfBWA4cnbI
        OeIaPeDkiBork2w6Njg7IF50w2secS7TPc146onNQD1Lve/m+vc7G9ZjXMjHu6i219LoZC
        sOn61uaftoSlrtfKSpoEFj1oMdkgd6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-Bge_Qq80MS6YEpllfnHKzQ-1; Fri, 21 Jan 2022 04:04:48 -0500
X-MC-Unique: Bge_Qq80MS6YEpllfnHKzQ-1
Received: by mail-wm1-f72.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso9023286wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+c0Hr1BXH8XrdbKwPEYPBmPMm2W8e8zS+mQCFP2tguU=;
        b=0F3JEwd6Ob30wBE2CEVbfHgk48H/Rme/ZAC1P+HVHAQYcugNCPnnY35H8jII3EijoN
         tCg08NhB6DFc3BmpkO8qxYTeBfRubKn3rLPme44hG5izoaDZKBsY67k5cbrC9b4vZm8C
         GBNHJnXiyI0uUr45llkP7yZVrxcoC55SU4dl/IoxEp8UUMTaAeVIaUVw95C9iP/Fowv/
         KYshNyvmJpQYpiDqJlxDGuJgT/VKTarvmANWoUrGuaax5G3v2IS41CK213pHgUuIendX
         kS/yxhwbZqyMuTO1s6Ak0Tvf+WTpXBUd51osAwe43DA0o3ylb2sV4kCEJg3y4zz1DCfO
         mBDg==
X-Gm-Message-State: AOAM530WnNGr2HJ67rfohTHowm5DYU8qdFR10KxV2DlxOsAADzjUQbdd
        JDnHxhCc+kDsGfnAfimv+eBnLXQ6IYqvzdQKcz1ZBKOrFyvBXZM4k2CCpUEVcObGDYXjPBF0QIY
        H8Q1ogB7w0MCZyAR4dLGzQixb
X-Received: by 2002:adf:a4ce:: with SMTP id h14mr1576157wrb.288.1642755887096;
        Fri, 21 Jan 2022 01:04:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdgiw9tNUWZf4zeO18OZiz9Pv+iCknM6BD1GaKXlLx1BBybJPxgu+zGSIb4lszILqZ/4F+Yg==
X-Received: by 2002:adf:a4ce:: with SMTP id h14mr1576130wrb.288.1642755886871;
        Fri, 21 Jan 2022 01:04:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a200:adf9:611a:39a8:435a? (p200300cbc709a200adf9611a39a8435a.dip0.t-ipconnect.de. [2003:cb:c709:a200:adf9:611a:39a8:435a])
        by smtp.gmail.com with ESMTPSA id w15sm6031182wmk.17.2022.01.21.01.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 01:04:46 -0800 (PST)
Message-ID: <10d6cc13-b96b-e1b6-8751-1b245b242738@redhat.com>
Date:   Fri, 21 Jan 2022 10:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
 <ffb88819-a392-84f3-d40f-7406be8e3165@redhat.com>
 <20220121075157.GA20638@worktop.programming.kicks-ass.net>
 <20220121085917.GA22849@worktop.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220121085917.GA22849@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.22 09:59, Peter Zijlstra wrote:
> On Fri, Jan 21, 2022 at 08:51:57AM +0100, Peter Zijlstra wrote:
>> On Thu, Jan 20, 2022 at 07:25:08PM +0100, David Hildenbrand wrote:
>>> On 20.01.22 16:55, Peter Zijlstra wrote:
>>>> Add a guarantee for Anon pages that pin_user_page*() ensures the
>>>> user-mapping of these pages stay preserved. In order to ensure this
>>>> all rmap users have been audited:
>>>>
>>>>  vmscan:	already fails eviction due to page_maybe_dma_pinned()
>>>>
>>>>  migrate:	migration will fail on pinned pages due to
>>>> 		expected_page_refs() not matching, however that is
>>>> 		*after* try_to_migrate() has already destroyed the
>>>> 		user mapping of these pages. Add an early exit for
>>>> 		this case.
>>>>
>>>>  numa-balance:	as per the above, pinned pages cannot be migrated,
>>>> 		however numa balancing scanning will happily PROT_NONE
>>>> 		them to get usage information on these pages. Avoid
>>>> 		this for pinned pages.
>>>
>>> page_maybe_dma_pinned() can race with GUP-fast without
>>> mm->write_protect_seq. This is a real problem for vmscan() with
>>> concurrent GUP-fast as it can result in R/O mappings of pinned pages and
>>> GUP will lose synchronicity to the page table on write faults due to
>>> wrong COW.
>>
>> Urgh, so yeah, that might be a problem. Follow up code uses it like
>> this:
>>
>> +/*
>> + * Pinning a page inhibits rmap based unmap for Anon pages. Doing a load
>> + * through the user mapping ensures the user mapping exists.
>> + */
>> +#define umcg_pin_and_load(_self, _pagep, _member)                              \
>> +({                                                                             \
>> +       __label__ __out;                                                        \
>> +       int __ret = -EFAULT;                                                    \
>> +                                                                               \
>> +       if (pin_user_pages_fast((unsigned long)(_self), 1, 0, &(_pagep)) != 1)  \
>> +               goto __out;                                                     \
>> +                                                                               \
>> +       if (!PageAnon(_pagep) ||                                                \
>> +           get_user(_member, &(_self)->_member)) {                             \
>> +               unpin_user_page(_pagep);                                        \
>> +               goto __out;                                                     \
>> +       }                                                                       \
>> +       __ret = 0;                                                              \
>> +__out: __ret;                                                                  \
>> +})
>>
>> And after that hard assumes (on the penalty of SIGKILL) that direct user
>> access works. Specifically it does RmW ops on it. So I suppose I'd
>> better upgrade that load to a RmW at the very least.
>>
>> But is that sufficient? Let me go find that race you mention...
> 
> OK, so copy_page_range() vs lockless_pages_from_mm(). Since I use
> FOLL_PIN that should be sorted, it'll fall back the slow path and use
> mmap_sem and serialize against the fork().
> 
> (Also, can I express my hate for __gup_longterm_unlocked(), that
> function name is utter garbage)

Absolutely, the "_unlocked_ also caused a lot of confusion on my end in
the past.

> 
> However, I'm not quite sure what fork() does with pages that have a pin.

We COW the anon pages always, and we protect against concurrent GUP
using the
* mmap_lock in exclusive mode for ordinary GUP
* mm->write_protect_seq for GUP-fast

> 
> Naively, a page that has async DMA activity should not be CoW'ed, or if
> it is, care must be taken to ensure the original pages stays in the
> original process, but I realize that's somewhat hard.

That's precisely what I'm working on fixing ... and yes, it's hard.

Let me know if you need any other information, I've spent way too much
time on this than I ever panned.

-- 
Thanks,

David / dhildenb

