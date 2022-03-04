Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4324CDA52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiCDR0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCDR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:26:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97B821A906C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646414753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPOyywODPUcB/Gl9wy52x834Jjxc19V6YX/YVgiSHj0=;
        b=h5q6Nu+k9ztz1CEjXGNghy01Y5R6kIV6sv+RLX+vYOrptLEjcaPG1/wr8BrVa+1y4gjMzE
        olDdTKSmN7SCibciLMYNufmdyQ3vrJnXTZZeqRFZNmdtEbIQO6j87c/jzh8wrRwCwhr1wW
        NA5vu6v68EzTo9bh0jY8Skdt/yT6vDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-g9vjadT5PAKP9-_qbOVIKA-1; Fri, 04 Mar 2022 12:25:52 -0500
X-MC-Unique: g9vjadT5PAKP9-_qbOVIKA-1
Received: by mail-wr1-f71.google.com with SMTP id q12-20020adfbb8c000000b001ea938f79e9so3548988wrg.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 09:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZPOyywODPUcB/Gl9wy52x834Jjxc19V6YX/YVgiSHj0=;
        b=YHeFSp6UylV5XjAQnY8iPPEq8LhvXC/+TDOA7bK6eJE/GtC6UF4Svbh51w77rDRfKE
         0+F1CpMShNOiElKtEnxyXEfgYnIKR2rZUl5AJe/0gNpqAnFXuOHHHrcoppHkCAP3BUhs
         NYgIwmbZrUpd8QbMMOo8WGo3GiUh98waPocGVFvdfdWCbRuNdgrjVosQb86A8RZo9uDo
         0Sokz4YoBYK65/aVDbJVlCU/yx5EOlT9RdG7k4T0LI5GInqfiCj/7881DmUqZ5gdP5lm
         qZhaulz4JVI7a4hKFXQkcld5fyx+Q6Vrpf4t5qiBcIVzAr8DvNp4X4l2nTAiSe3takGO
         5j7Q==
X-Gm-Message-State: AOAM530GQbhEHVIV0hLFG+VzNKEaXulyOt9ut30nFXDoBqmaSBsDwWNg
        NjSqCuaebfpB3XoIArmVBaWHl5vXx8339NwWCNDNPDz8YuXXSLMpkCylsoKfw0w3L5auE3qPRWX
        LizNQQFW81oGsoVGBUU1zfNAz
X-Received: by 2002:a05:6000:1a88:b0:1f1:d8df:89d3 with SMTP id f8-20020a0560001a8800b001f1d8df89d3mr616950wry.321.1646414751381;
        Fri, 04 Mar 2022 09:25:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGy5kZMQf6JCuBlEj/Ql0LQkTBALE9clC0CFLC5pel+5apqkghxKJLoJBkpnmtZWrdAqE4Ew==
X-Received: by 2002:a05:6000:1a88:b0:1f1:d8df:89d3 with SMTP id f8-20020a0560001a8800b001f1d8df89d3mr616938wry.321.1646414751101;
        Fri, 04 Mar 2022 09:25:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:4600:7355:df2c:f6ff:94d? (p200300cbc70946007355df2cf6ff094d.dip0.t-ipconnect.de. [2003:cb:c709:4600:7355:df2c:f6ff:94d])
        by smtp.gmail.com with ESMTPSA id o204-20020a1ca5d5000000b0038331f2f951sm15188818wme.0.2022.03.04.09.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 09:25:50 -0800 (PST)
Message-ID: <90aafe84-fe7d-c70e-8e15-c222869f30fc@redhat.com>
Date:   Fri, 4 Mar 2022 18:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
 <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com>
 <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mmotm] mm: delete __ClearPageWaiters()
In-Reply-To: <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.22 23:28, Hugh Dickins wrote:
> On Thu, 3 Mar 2022, David Hildenbrand wrote:
>> On 03.03.22 02:56, Hugh Dickins wrote:
>>> The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
>>> vmscan.c's free_unref_page_list() callers rely on that not to generate
>>> bad_page() alerts.  So __page_cache_release() and release_pages() (and
>>> the presumably copy-and-pasted put_zone_device_private_or_public_page())
> 
> Hah, I'm showing my age there, or the patch's age: it's been rebranded
> frequently since then, with linux-next calling it free_zone_device_page(),
> as you kindly point out.  How long before it's free_zone_device_folio()?

:)

> 
>>> are redundant and misleading to make a special point of clearing it (as
>>> the "__" implies, it could only safely be used on the freeing path).
>>>
>>> Delete __ClearPageWaiters().  Remark on this in one of the "possible"
>>> comments in wake_up_page_bit(), and delete the superfluous comments.
>>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>> We've used this since 2018, and I see Yu Zhao posted similar in 2020:
>>> https://lore.kernel.org/linux-mm/20200818184704.3625199-3-yuzhao@google.com/
>>> I couldn't join in at that time, but think its reception was over-cautious.
>>>
>>>  include/linux/page-flags.h |  2 +-
>>>  mm/filemap.c               | 22 +++++++---------------
>>>  mm/memremap.c              |  2 --
>>>  mm/swap.c                  |  4 ----
>>>  4 files changed, 8 insertions(+), 22 deletions(-)
>>>
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -1179,24 +1179,16 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
>>>  	}
>>>  
>>>  	/*
>>> -	 * It is possible for other pages to have collided on the waitqueue
>>> -	 * hash, so in that case check for a page match. That prevents a long-
>>> -	 * term waiter
>>> +	 * It's possible to miss clearing waiters here, when we woke our page
>>> +	 * waiters, but the hashed waitqueue has waiters for other pages on it.
>>>  	 *
>>> -	 * It is still possible to miss a case here, when we woke page waiters
>>> -	 * and removed them from the waitqueue, but there are still other
>>> -	 * page waiters.
>>> +	 * That's okay, it's a rare case. The next waker will clear it. Or,
>>> +	 * it might be left set until the page is freed: when it's masked off
>>> +	 * with others in PAGE_FLAGS_CHECK_AT_PREP, by free_pages_prepare().
>>>  	 */
>>
>> Does that also apply to ZONE_DEVICE pages via free_zone_device_page()?
> 
> I'm sure you could tell me a lot more about ZONE_DEVICE pages than I
> could ever tell you.  But, if they don't ever reach the main page freer,
> then they're in the same category as other pages not freed until reboot:
> any clearing of left-behind PG_waiters will be done by the next waker,
> not by reaching free_pages_prepare().  Does that really require special
> mention of ZONE_DEVICE pages here?  Would I do better just to remove
> the comment on PAGE_FLAGS_CHECK_AT_PREP being one of the clearers?

In this context we can consider ZONE_DEVICE pages just like any other
pages that, although getting freed, are not returned to the buddy, but
instead are returned to another pool. So PAGE_FLAGS_CHECK_AT_PREP won't
apply and free_pages_prepare() won't apply.

Another example would be hugetlb pages, that are returned to the hugetlb
pool, but not back to the buddy unless the huge page pool is shrunk.


So I feel like the underlying principle here is: we don't *care* if
PG_waiter is cleared when a page gets freed, because it will simply get
cleared by the next waker if it sticks around.

Then, I agree, we can just drop the comment regarding
PAGE_FLAGS_CHECK_AT_PREP and instead have something like


"
That's okay, it's a rare case and the next waker will just clear it.
Note that, depending on the page pool (buddy, ZONE_DEVICE, hugetlb), we
might clear the flag while freeing the page, however, this is not
required for correctness.
"


-- 
Thanks,

David / dhildenb

