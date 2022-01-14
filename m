Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E248F027
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiANSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:47:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236181AbiANSrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642186073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePNQFySVzOR7DMIV/biLu5uLPMp0KtJ5gJi1cXcBj6w=;
        b=U6EjmnjR1w+U/P1oWEXUqtIUZ5yg7VvdF/+GpxoJO7DAuQPHINB+89OXW5pqKJG6GFXj9O
        DIpLnvgdfGwEUYIpCD3BJMvRjsaiuqeva7sjGxlu6sDwVKDHwbrrmMVDeFt16Eu165tz0M
        9zFTvNkcKSe7QbMUNT6QTseBf9gF7BA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-Tx5BRJlzNiODir1jMgWcCQ-1; Fri, 14 Jan 2022 13:47:51 -0500
X-MC-Unique: Tx5BRJlzNiODir1jMgWcCQ-1
Received: by mail-wm1-f70.google.com with SMTP id c188-20020a1c35c5000000b00346a2160ea8so2684472wma.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=ePNQFySVzOR7DMIV/biLu5uLPMp0KtJ5gJi1cXcBj6w=;
        b=tBTYxoDRONEW2YiY0D6ZZ/dN0szCarjKAMLbwQYmxSluW0BWoQ0WgA3iptEy8ExNq6
         KJN/TeT845kTXdPmSr8kdTrmogKTaygct5DzAa4vL1FjADawfov7L0SnhBJx7WYCsGy3
         E69UuznViwpcfb01qZL8U8UR4IaxpqKARCi1FAIqr7vhnJeHFswXNtyq48cnKFnplA1A
         mzpcthzHbmGp+p0N2whfuJrJBMQEH0+sC7n3cvwIsrGkJ5hPmGISzqIl3Nr2KJcMWaaC
         rsDRo3aXU1HSGgmhgrgJis/zgY6ixIsBA7eooC6oxmXg0GseWaq4f65Lcw84y7kn2qAg
         NjKQ==
X-Gm-Message-State: AOAM531FLFFEAnFb0H8hapV19Ht+eGR5j++tSc+VwdRZoqWtMgj1MaQF
        9LDjsa2KZo0JNMeJIPrn2fi3hZziC0+0tq1849Q7slhYK297A3vTKPh+xyovnc/WvkOiHkDghAL
        iJZAtZ5x05jCKRdR4Ridelc3T
X-Received: by 2002:a05:6000:1246:: with SMTP id j6mr9519168wrx.58.1642186070653;
        Fri, 14 Jan 2022 10:47:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxoFkqrs3vhuv00CwYqlniTDEzsTN6gV5CtjgntvC3ZqefMTm6pJbKQYCFQgLJGKuJ6LZMpQ==
X-Received: by 2002:a05:6000:1246:: with SMTP id j6mr9519148wrx.58.1642186070432;
        Fri, 14 Jan 2022 10:47:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702? (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de. [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
        by smtp.gmail.com with ESMTPSA id i12sm3055057wrf.100.2022.01.14.10.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 10:47:49 -0800 (PST)
Message-ID: <51fc9dfe-1cac-69f6-0c68-46a83fd7783d@redhat.com>
Date:   Fri, 14 Jan 2022 19:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC v2] mm: introduce page pin owner
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
Organization: Red Hat
In-Reply-To: <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> Otherwise, I'd like to have feature naming more higher level>>>>>> to represent page migration failure and then tracking unref of
>>>>>> the page. In the sense, PagePinOwner John suggested was good
>>>>>> candidate(Even, my original naming PagePinner was worse) since
>>>>>
>>>>> Personally, I dislike both variants.
>>>>>
>>>>>> I was trouble to abstract the feature with short word.
>>>>>> If we approach "what feature is doing" rather than "what's
>>>>>> the feature's goal"(I feel the your suggestion would be close
>>>>>> to what feature is doing), I'd like to express "unreference on
>>>>>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
>>>>>> (However, I prefer the feature naming more "what we want to achieve")
>>>>>>
>>>>> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
>>>>> set. The functionality itself is completely independent of migration
>>>>> failures. That's just the code that sets it to enable the underlying
>>>>> tracing for that specific page.
>>>>
>>>> I agree that make something general is great but I also want to avoid
>>>> create something too big from the beginning with just imagination.
>>>> So, I'd like to hear more concrete and appealing usecases and then
>>>> we could think over this trace approach is really the best one to
>>>> achieve the goal. Once it's agreed, the naming you suggested would
>>>> make sense. 
>>>
>>> At least for me it's a lot cleaner if a feature clearly expresses what
>>> it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
>>> I was assuming we would actually track (not trace!) all active FOLL_PIN
>>> (not unref callers!). Maybe that makes it clearer why I'd prefer a
>>> clearer name.
>>
>> I totally agree PagePinOwner is not 100% straightforward. I'm open for
>> other better name. Currently we are discussing how we could generalize
>> and whether it's useful or not. Depending on the discussion, the design/
>> interface as well as naming could be changed. No problem.
> 
> PagePinOwner is just highly misleading. Because that's not what the
> feature does. Having that said, i hope we'll get other opinions as well.

FWIW, I think "page reference holder" would be clearer. PageRefHolder or
PageReferenceHolder

"Trace page reference holders on unref after migration of a page failed."

-- 
Thanks,

David / dhildenb

