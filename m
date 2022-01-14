Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730E448EABA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiANNbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbiANNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642167107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxr/XstrAzeQLi8uDC+TRq+V7XRk5DwwZZtj12iW9lk=;
        b=WHVR2Prg04v7Zhb1pBDeaQo6n+unUWqD6CPmjgiOoWURM9On674U728+tsro8Hjz5+pzbu
        J1cKOMTwyrjVO7eOdFjKZFBw5ZZMKIjQX7t/fpsMznvSI1CtNoWGlxOWBqyUcw/W0o9nJa
        6qdCMmjcXilcY+hQ+/XxTQ8tEiEVndg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-N0bMTf_SMiGLh-nqeDctig-1; Fri, 14 Jan 2022 08:31:46 -0500
X-MC-Unique: N0bMTf_SMiGLh-nqeDctig-1
Received: by mail-ed1-f72.google.com with SMTP id h1-20020aa7cdc1000000b0040042dd2fe4so7090706edw.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=yxr/XstrAzeQLi8uDC+TRq+V7XRk5DwwZZtj12iW9lk=;
        b=q+vpGn/bEVo5J9fJuOwHYsQ1zUd14OTv72JPn8Ee/eBEQwFZxW+wF9nTsdh+r6rnMm
         c8Pe+538gEIcCIYhc+2OLCEY2g0v9DMwz19/JY6hpXsQeQI3Thjb2ILv9NrSZzH2kxQB
         IMs32Dr12DHhukI4aLnmFcR7RD9ZdwQntz7BVLl3dMvMk/LOpCLRNKJkXciQaMHdxF2D
         J0WZbBzf0mTaUn8HbRNtgJdv7P3Wc3WGU1xCYdEChuEX1REeeMHL9PuwDlCM6TadbBQf
         EoyWi0xpkNeZoicAcMUsDSQpoq2nY80tshfPbnBdGoUve9Y9KdZeZeG+4XwWNRge4hdi
         HepA==
X-Gm-Message-State: AOAM530liWbNnJBrDiS/8r37CvcYqV2MIDZNWwwQ8oPtJAcQf73sOqu5
        a+3uA/o1ihFc5Q5V4qiLsipyMpCKkDNBdR4fOpVufIJNOlImMATL2DupqjWXV0c2pUlafB80Y5z
        mmgayDF3zo7eZ1YaqxWcY0Oci
X-Received: by 2002:aa7:de82:: with SMTP id j2mr8655127edv.389.1642167105073;
        Fri, 14 Jan 2022 05:31:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzakzeesCkpJ7UV6aJeTYrmBFV3QBHlRzQjOzKBk+Co/dc44VgV0Gf3BNT0wJjq7R6B2iKmyg==
X-Received: by 2002:aa7:de82:: with SMTP id j2mr8655111edv.389.1642167104861;
        Fri, 14 Jan 2022 05:31:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702? (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de. [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
        by smtp.gmail.com with ESMTPSA id g21sm2356765edt.12.2022.01.14.05.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 05:31:44 -0800 (PST)
Message-ID: <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
Date:   Fri, 14 Jan 2022 14:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC v2] mm: introduce page pin owner
In-Reply-To: <Yd884YERYI+UvXbj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.22 21:41, Minchan Kim wrote:
> On Wed, Jan 12, 2022 at 06:42:21PM +0100, David Hildenbrand wrote:
>>>>
>>>> What about something like:
>>>>
>>>> "mm: selective tracing of page reference holders on unref"
>>>>
>>>> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
>>>>
>>>> $whatever feature/user can then set the bit, for example, when migration
>>>> fails.
>>>
>>> I couldn't imagine put_page tracking is generally useful except
>>> migration failure. Do you have reasonable usecase in your mind
>>> to make the feature general to be used?
>>
>> HWpoison etc. purposes maybe? Trace who still held a reference a page
>> that was poisoned and couldn't be removed?  Or in general, tracking
> 
> I am not familiar with hwpoison so here dumb question goes:
> Is that different one with __soft_offline_page?
> It uses migrate_pages so current interface supports it with filter.

__soft_offline_page() won't kill the target and try to migrate because
the pages are about to be damaged and we can still access them.

ordinary memory errors mean we kill the target because we cannot access
the page anymore without triggering MCEs (or worse IIUC) again.

So in my thinking, after memory_failure(), it could eventually be
helpful to figure out who still has a (temporary) reference to such a
broken page, even after killing the process. But that's just one idea I
quickly came up with.

> 
> echo "memory_failure" > $trace_dir/events/page_pin_owner/report_page_pinners/filter
> 
>> references to something that should have a refcount of 0 because it
>> should have been freed, but for some reason there are still references
>> around?
> 
> Sounds like you are talking about memory leak? What's the purpose
> with trace, not using other existing tool to find memory leak?
> 

IIRC, kmemleak can find objects that are no longer referenced, and we
cannot track buddy allocations, but only kmalloc and friends.

>>
>>> Otherwise, I'd like to have feature naming more higher level
>>> to represent page migration failure and then tracking unref of
>>> the page. In the sense, PagePinOwner John suggested was good
>>> candidate(Even, my original naming PagePinner was worse) since
>>
>> Personally, I dislike both variants.
>>
>>> I was trouble to abstract the feature with short word.
>>> If we approach "what feature is doing" rather than "what's
>>> the feature's goal"(I feel the your suggestion would be close
>>> to what feature is doing), I'd like to express "unreference on
>>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
>>> (However, I prefer the feature naming more "what we want to achieve")
>>>
>> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
>> set. The functionality itself is completely independent of migration
>> failures. That's just the code that sets it to enable the underlying
>> tracing for that specific page.
> 
> I agree that make something general is great but I also want to avoid
> create something too big from the beginning with just imagination.
> So, I'd like to hear more concrete and appealing usecases and then
> we could think over this trace approach is really the best one to
> achieve the goal. Once it's agreed, the naming you suggested would
> make sense. 

At least for me it's a lot cleaner if a feature clearly expresses what
it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
I was assuming we would actually track (not trace!) all active FOLL_PIN
(not unref callers!). Maybe that makes it clearer why I'd prefer a
clearer name.

>>
>> Makes sense, I was expecting the output to be large, but possible it's
>> going to be way too large.
>>
>> Would it also make sense to track for a flagged page new taken
>> references, such that you can differentiate between new (e.g.,
>> temporary) ones and previous ones? Feels like a reasonable addition.
> 
> I actually tried it and it showed 2x times bigger output.

Is 2x that bad? Or would it be worth making it configurable?

> For me to debug CMA alloation failure, the new get_page callstack
> after migration failure were waste since they repeated from lru
> adding, isolate from the LRU something. Rather than get callsite,
> I needed only put call sites since I could deduce where the pair-get
> came from.

Could maybe some filters help that exclude such LRU activity?

-- 
Thanks,

David / dhildenb

