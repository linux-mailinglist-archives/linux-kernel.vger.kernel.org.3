Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A55A86D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiHaTgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiHaTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C14C696D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661974601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxzVUHNaqjzajgQOML3hm8V8CKnGAzf1ViuWb5adgrs=;
        b=LR23wkQ25Xe/cIPxZ535LOQj3ySbgp+OZYxtEv5T/pd+itWktADZaI23S4OT2O8N7rVAHk
        r7ENQjnxexXnUbbWE9F/aOf9xzMO/oN8PDLIC03r23Lce3uifvxs/EXHMWvwGfw1HF7Kft
        d6SsUfbugzOO9OnBghr6w91XS2GgC+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-230-QYxk7ijJODyjuNwgNTB8Ow-1; Wed, 31 Aug 2022 15:36:38 -0400
X-MC-Unique: QYxk7ijJODyjuNwgNTB8Ow-1
Received: by mail-wm1-f71.google.com with SMTP id r10-20020a1c440a000000b003a538a648a9so8703851wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=KxzVUHNaqjzajgQOML3hm8V8CKnGAzf1ViuWb5adgrs=;
        b=2S0dRT3hzQ2N7mwd0e4rWx+iMeE3B+CUbJVrRsn6tt8Hmr7TzEturtnCGVccPZlUHn
         j40IwO0rqw6hqAQeKSVHfTKoaHmClcng72PHZqtDXb5qiO7adsiWrwrma0wkoK6DnrW0
         jIHOywndaWv+pUmRgjA5ApT6BXpLvAMtPUseTbHMwuPWBNU1dhSQwWYI/+9CGY3u341d
         Qfw29669fSqdup7+yj5z+VHYUpAbSts0UU/YpjapsuIphojE8qoU6c37vmRSQQyLLvgL
         GMMRPFBjmmIvH9JGCKL7ZLJbgCe3A4hacV1VObkio8Wb8zntk84dzHXHVCoqNWGvglIM
         gCsA==
X-Gm-Message-State: ACgBeo2H52sMQUVTUhFRwEUU8LB0KLfwOdN6WkDnkaiKQC/VNG9V8My8
        WMvpUT+fChxxBhKB+nsqHiOxk+lydzl2ePmmuk2akl9SvWF0A+oGXVfPUyjn23ZK8JV7tqdAm6i
        JAPswEfDH4X+3TjAz9Jxs2QBT
X-Received: by 2002:a05:600c:4e04:b0:3a5:a34e:ae81 with SMTP id b4-20020a05600c4e0400b003a5a34eae81mr2860050wmq.147.1661974595567;
        Wed, 31 Aug 2022 12:36:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7B/zLJcwKJ2G4azHjhFK7bo/QfmH+ZS5YUgsxbS+hYfWaxG8gDfRoY5pKTGEhmNyF32r7tdA==
X-Received: by 2002:a05:600c:4e04:b0:3a5:a34e:ae81 with SMTP id b4-20020a05600c4e0400b003a5a34eae81mr2860035wmq.147.1661974595255;
        Wed, 31 Aug 2022 12:36:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003a3442f1229sm2889493wmc.29.2022.08.31.12.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 12:36:34 -0700 (PDT)
Message-ID: <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com>
Date:   Wed, 31 Aug 2022 21:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220831083024.37138-1-david@redhat.com>
 <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
 <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
 <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 21:34, Yang Shi wrote:
> On Wed, Aug 31, 2022 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.08.22 21:08, Yang Shi wrote:
>>> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 31.08.22 19:55, Yang Shi wrote:
>>>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> The comment is stale, because a TLB flush is no longer sufficient and
>>>>>> required to synchronize against concurrent GUP-fast. This used to be true
>>>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
>>>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
>>>>>> from completing before completing the flush.
>>>>>
>>>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
>>>>> collapse clears and flushes pmd before doing anything on pte and
>>>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
>>>>> But if TLB flush is no longer sufficient, then we may run into the
>>>>> below race IIUC:
>>>>>
>>>>>          CPU A                                                CPU B
>>>>> THP collapse                                             fast GUP
>>>>>
>>>>> gup_pmd_range() <-- see valid pmd
>>>>>
>>>>> gup_pte_range() <-- work on pte
>>>>> clear pmd and flush TLB
>>>>> __collapse_huge_page_isolate()
>>>>>     isolate page <-- before GUP bump refcount
>>>>>
>>>>>    pin the page
>>>>> __collapse_huge_page_copy()
>>>>>     copy data to huge page
>>>>>     clear pte (don't flush TLB)
>>>>> Install huge pmd for huge page
>>>>>
>>>>> return the obsolete page
>>>>
>>>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
>>>> cleared yet. And we don't check if the PMD changed once we're in
>>>> gup_pte_range().
>>>
>>> Yes
>>>
>>>>
>>>> The comment most certainly should be stale as well -- unless there is
>>>> some kind of an implicit IPI broadcast being done.
>>>>
>>>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
>>>> IPI broadcast on THP split (which is a rare event), allows one to
>>>> protect a page table walker by merely disabling the interrupts during
>>>> the walk."
>>>>
>>>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
>>>> being done here (in collapse) as well?
>>>
>>> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
>>> Some do use IPI, some may not.
>>
>> Right, and the whole idea of the RCU GUP-fast was to support
>> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
>> it -- but maybe it does so for PMDs?
> 
> It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
> 
> So maybe we should implement pmdp_collapse_flush() for those arches to
> issue IPI.

... or find another way to detect and handle this in GUP-fast?

Not sure if, for handling PMDs, it could be sufficient to propagate the
pmdp pointer + value and double check that the values didn't change.

-- 
Thanks,

David / dhildenb

