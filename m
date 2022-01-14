Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7554948EEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbiANQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243610AbiANQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642179088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTinIqj672rVWBI2bzwduD2LLaFLaP9MEgcSai0QIrM=;
        b=IOx+kbtG1d1mTZjPjBRHsg5pWILaNIe5xUzNrOSeX5su1A7Frwb5pjdjHtBqjijy0dGX4H
        eR+4E56Kq6hscipcvKOojBmpxJoAXb/UZlIDlqQk6JEqwqdZC+RL5HvGlev1sg5D4DJJq3
        k8PNN1T3sX5ZEuOlb0ii/oxpyz2tn60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-H1i4NaC7OXmZMo4dU5HM4Q-1; Fri, 14 Jan 2022 11:51:27 -0500
X-MC-Unique: H1i4NaC7OXmZMo4dU5HM4Q-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a056402520700b003f841380832so8636291edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=NTinIqj672rVWBI2bzwduD2LLaFLaP9MEgcSai0QIrM=;
        b=AcmUNJOmf5Z6I0oPd33TzbBgvpglbMpkI49xlMKDfKCcQS6SPn7LVBPN0nINm3BClv
         vagK+S8kN2BoPkoINjfTeEhjpEBgJnIGB55MqVCjuJKGYh7cB68SuyZ0dZnKrWRU/PgB
         Vg72C+hDIfFVlsReTpNXWsXQI7d6Ps4MooaMQkpzd1nyLAr3bfE2YUwIIJrs6qSBLUTf
         e+dOzXF62C3qFewrvOaXboYMiYh1EKOXWAtiOVMisRfeLoMRRGm5XEepWZB99Mu/DBaO
         6rGMOidpkwkQfU3c8K9NkO+KFxlrr3nAYBLMmm7nUg8RvJuFg+UgKMt/gik56Fyb8896
         OA7Q==
X-Gm-Message-State: AOAM530HVYpRkIKeWj5IusCvQf3cAEGIubkwUFyRhzcGZmN7l+mcV9xx
        8kaB2mleutLDCcb42KZWmx9oVr+h6qedifctXVgLAcdB/d/dnyXgDMSKaeB7B2GbnNGRMl/zvFq
        KFrJinYhCpXZJjtECoYHRvpUZ
X-Received: by 2002:a17:907:6e0c:: with SMTP id sd12mr8084683ejc.536.1642179086057;
        Fri, 14 Jan 2022 08:51:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5Y3VQCzdrrXi69B9FQRczjUJwIwieT4Ls4ORNDY9QKjxRD49sSUiW5Q6K2fDho+MJLg1oug==
X-Received: by 2002:a17:907:6e0c:: with SMTP id sd12mr8084668ejc.536.1642179085764;
        Fri, 14 Jan 2022 08:51:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702? (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de. [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
        by smtp.gmail.com with ESMTPSA id z16sm1962496eji.153.2022.01.14.08.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 08:51:25 -0800 (PST)
Message-ID: <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
Date:   Fri, 14 Jan 2022 17:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC v2] mm: introduce page pin owner
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
 <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
 <Yd884YERYI+UvXbj@google.com>
 <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
 <YeGnSG3BS5np9mUa@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YeGnSG3BS5np9mUa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.22 17:39, Minchan Kim wrote:
> On Fri, Jan 14, 2022 at 02:31:43PM +0100, David Hildenbrand wrote:
>> On 12.01.22 21:41, Minchan Kim wrote:
>>> On Wed, Jan 12, 2022 at 06:42:21PM +0100, David Hildenbrand wrote:
>>>>>>
>>>>>> What about something like:
>>>>>>
>>>>>> "mm: selective tracing of page reference holders on unref"
>>>>>>
>>>>>> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
>>>>>>
>>>>>> $whatever feature/user can then set the bit, for example, when migration
>>>>>> fails.
>>>>>
>>>>> I couldn't imagine put_page tracking is generally useful except
>>>>> migration failure. Do you have reasonable usecase in your mind
>>>>> to make the feature general to be used?
>>>>
>>>> HWpoison etc. purposes maybe? Trace who still held a reference a page
>>>> that was poisoned and couldn't be removed?  Or in general, tracking
>>>
>>> I am not familiar with hwpoison so here dumb question goes:
>>> Is that different one with __soft_offline_page?
>>> It uses migrate_pages so current interface supports it with filter.
>>
>> __soft_offline_page() won't kill the target and try to migrate because
>> the pages are about to be damaged and we can still access them.
>>
>> ordinary memory errors mean we kill the target because we cannot access
>> the page anymore without triggering MCEs (or worse IIUC) again.
>>
>> So in my thinking, after memory_failure(), it could eventually be
>> helpful to figure out who still has a (temporary) reference to such a
>> broken page, even after killing the process. But that's just one idea I
>> quickly came up with.
> 
> 
> Thanks for the clarification. Is the trace best fit in the case?
> Presumably you know the broken page, can't you find who owns the page
> using /proc/pid/pagemap?
> Furthermore, page_get/put operations commonly could happen in
> different contexts regardless of page's owner so the trace from
> different context is still helpful?
> 
> If it's helpful, could you tell what you want to make the interface to
> set the bit of broken page? For example, as-is case for page migration,
> report_page_pinners is called to mark failed page at unmap_and_move.
> Do you want to add something similar(maybe, set_page_ref_track under
> rename) in memory-failure.c?
> 
> It would be very helpful to design the feature's interface(surely,
> naming as well) and write description to convince others "yeah,
> sounds like so useful for the case and that's best fit than other way".

I currently don't have time to explore this further, it was just a
random thought how else this might be useful.


>>
>>>
>>> echo "memory_failure" > $trace_dir/events/page_pin_owner/report_page_pinners/filter
>>>
>>>> references to something that should have a refcount of 0 because it
>>>> should have been freed, but for some reason there are still references
>>>> around?
>>>
>>> Sounds like you are talking about memory leak? What's the purpose
>>> with trace, not using other existing tool to find memory leak?
>>>
>>
>> IIRC, kmemleak can find objects that are no longer referenced, and we
>> cannot track buddy allocations, but only kmalloc and friends.
> 
> PageOwner is your good buddy.

Page owner tracks who owns a page but not who else holds a reference
(some buffer, gup, whatsoever), right?

> 
>>
>>>>
>>>>> Otherwise, I'd like to have feature naming more higher level
>>>>> to represent page migration failure and then tracking unref of
>>>>> the page. In the sense, PagePinOwner John suggested was good
>>>>> candidate(Even, my original naming PagePinner was worse) since
>>>>
>>>> Personally, I dislike both variants.
>>>>
>>>>> I was trouble to abstract the feature with short word.
>>>>> If we approach "what feature is doing" rather than "what's
>>>>> the feature's goal"(I feel the your suggestion would be close
>>>>> to what feature is doing), I'd like to express "unreference on
>>>>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
>>>>> (However, I prefer the feature naming more "what we want to achieve")
>>>>>
>>>> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
>>>> set. The functionality itself is completely independent of migration
>>>> failures. That's just the code that sets it to enable the underlying
>>>> tracing for that specific page.
>>>
>>> I agree that make something general is great but I also want to avoid
>>> create something too big from the beginning with just imagination.
>>> So, I'd like to hear more concrete and appealing usecases and then
>>> we could think over this trace approach is really the best one to
>>> achieve the goal. Once it's agreed, the naming you suggested would
>>> make sense. 
>>
>> At least for me it's a lot cleaner if a feature clearly expresses what
>> it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
>> I was assuming we would actually track (not trace!) all active FOLL_PIN
>> (not unref callers!). Maybe that makes it clearer why I'd prefer a
>> clearer name.
> 
> I totally agree PagePinOwner is not 100% straightforward. I'm open for
> other better name. Currently we are discussing how we could generalize
> and whether it's useful or not. Depending on the discussion, the design/
> interface as well as naming could be changed. No problem.

PagePinOwner is just highly misleading. Because that's not what the
feature does. Having that said, i hope we'll get other opinions as well.

>>
>>>>
>>>> Makes sense, I was expecting the output to be large, but possible it's
>>>> going to be way too large.
>>>>
>>>> Would it also make sense to track for a flagged page new taken
>>>> references, such that you can differentiate between new (e.g.,
>>>> temporary) ones and previous ones? Feels like a reasonable addition.
>>>
>>> I actually tried it and it showed 2x times bigger output.
>>
>> Is 2x that bad? Or would it be worth making it configurable?
> 
> For my goal, 2x was bad because I need to minimize the trace buffer.
> Furthermore, the new get operation was not helpful but just noisy.
> If some usecase is not enough with only put callsite, we add get
> easily. Implementation is not hard. The matter is how it's useful
> in real practice since we would expose the interface to the user,
> I guess.

Right. but it's a debugging feature after all, so I asume we care little
about KABI. We can always add it on top, I agree.

> 
>>
>>> For me to debug CMA alloation failure, the new get_page callstack
>>> after migration failure were waste since they repeated from lru
>>> adding, isolate from the LRU something. Rather than get callsite,
>>> I needed only put call sites since I could deduce where the pair-get
>>> came from.
>>
>> Could maybe some filters help that exclude such LRU activity?
> 
> For my case, the filter wouldn't be helpful because I shouldn't
> miss the LRU activity since sometime they makes the allocation
> failure. Thus, I could deduce the lru's get site from put callback.
> get callsite is not helpful for my case but just wasted memory
> and perf.
> 

Makes sense.

-- 
Thanks,

David / dhildenb

