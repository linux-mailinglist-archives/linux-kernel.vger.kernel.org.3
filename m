Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E852495571
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbiATUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbiATUhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642711058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGxwqBCvgZoPCkZZ5FkImKlvcovv546VMc/LVt9w2tc=;
        b=ZvKDtGSzkWt1zH1GTudlG8LdzvJYPl4a4TZUs8+X75TdncCRIpi7wmEjelkzMCZrZqquYW
        atZAtA2Oqdnl/Ea/EPGsVaJjC3B4C3K00r07vN4IBJPCeAO3BReoSuzWkQv5+47WEOo60G
        58DwWaPKYslrUfBlexGJYmZOg3GTnA4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-FzPzYBpdP4SLgGLoARepcA-1; Thu, 20 Jan 2022 15:37:37 -0500
X-MC-Unique: FzPzYBpdP4SLgGLoARepcA-1
Received: by mail-ed1-f71.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso5821061edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=uGxwqBCvgZoPCkZZ5FkImKlvcovv546VMc/LVt9w2tc=;
        b=SjEZ9XUQY9E+3fSgU+MD7+N3vG1B+dsstAF0r0C+mESkJIiKy9oljTjR4q4auJy+Xc
         3KB+6LdNhKDqTTIw09s0JDEZ0ekJIdav0iLO9Gc4VPjiJvzxIiIndlUhGEmHmvofaIq9
         kKCeCW3nWY9CcBcm4MHTFcFc7B1seDYsJRHJk58VUsN9kwKT2JAntxfPqs2nDxODKEIq
         stn/vzjitj4612mIVieEZdQSjNyEcoJgDzY89RPraV03vrHwWeCrP1QsgacvCzZ3QRl8
         MC31NsjCd/+bIEmS5rUl0jVTisYj3vR3IBuMAMT7MzQhcd+8LefHdSFh2Wwav6h6u+vk
         MxBg==
X-Gm-Message-State: AOAM530NyIrJ73cekCn6NIh1r0icBRA/GvUtMeW2QdzTRBPA6cbxmkts
        yYlUP84XM9R6I4JbihlewgtfUs/RNYJVXi28rQox6RN1PHGPiT8P7hOxSOBZKAuDmIKea/uhDAM
        xKHz8/rfp+YKysiEPc46TFmcm
X-Received: by 2002:a05:6402:1104:: with SMTP id u4mr917723edv.24.1642711056022;
        Thu, 20 Jan 2022 12:37:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYE4Lp9kOI/G+mmLmeVOSnWXs3gIZZIBO5XD6ezueSA34Nf0afMXtekWQmU16Ku3t5x3mhlA==
X-Received: by 2002:a05:6402:1104:: with SMTP id u4mr917710edv.24.1642711055820;
        Thu, 20 Jan 2022 12:37:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id v14sm1399715ejy.77.2022.01.20.12.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 12:37:34 -0800 (PST)
Message-ID: <42a9b72d-093e-c35c-f4b5-b321a666e67d@redhat.com>
Date:   Thu, 20 Jan 2022 21:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
 <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
 <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
 <YenA7Xzd2G2OYvqz@casper.infradead.org>
 <da2846a1-f950-d330-7ada-ad3c9abfde74@redhat.com>
Organization: Red Hat
In-Reply-To: <da2846a1-f950-d330-7ada-ad3c9abfde74@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 21:09, David Hildenbrand wrote:
> On 20.01.22 21:07, Matthew Wilcox wrote:
>> On Thu, Jan 20, 2022 at 08:55:12PM +0100, David Hildenbrand wrote:
>>>>>> David, does any of it regards the lru_cache_add() reference issue that I
>>>>>> mentioned? [1]
>>
>>> +++ b/mm/memory.c
>>> @@ -3291,19 +3291,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>         if (PageAnon(vmf->page)) {
>>>                 struct page *page = vmf->page;
>>>  
>>> -               /* PageKsm() doesn't necessarily raise the page refcount */
>>> -               if (PageKsm(page) || page_count(page) != 1)
>>> +               /*
>>> +                * PageKsm() doesn't necessarily raise the page refcount.
>>> +                *
>>> +                * These checks are racy as long as we haven't locked the page;
>>> +                * they are a pure optimization to avoid trying to lock the page
>>> +                * and trying to free the swap cache when there is little hope
>>> +                * it will actually result in a refcount of 1.
>>> +                */
>>> +               if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
>>>                         goto copy;
>>>                 if (!trylock_page(page))
>>>                         goto copy;
>>> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
>>> +               if (PageSwapCache(page))
>>> +                       try_to_free_swap(page);
>>> +               if (PageKsm(page) || page_count(page) != 1) {
>>>                         unlock_page(page);
>>>                         goto copy;
>>>                 }
>>>                 /*
>>> -                * Ok, we've got the only map reference, and the only
>>> -                * page count reference, and the page is locked,
>>> -                * it's dark out, and we're wearing sunglasses. Hit it.
>>> +                * Ok, we've got the only page reference from our mapping
>>> +                * and the page is locked, it's dark out, and we're wearing
>>> +                * sunglasses. Hit it.
>>>                  */
>>>                 unlock_page(page);
>>>                 wp_page_reuse(vmf);
>>>
>>>
>>> I added some vmstats that monitor various paths. After one run of
>>> 	./forceswap 2 1000000 1
>>> I'm left with a rough delta (including some noise) of
>>> 	anon_wp_copy_count 1799
>>> 	anon_wp_copy_count_early 1
>>> 	anon_wp_copy_lock 983396
>>> 	anon_wp_reuse 0
>>>
>>> The relevant part of your reproducer is
>>>
>>> 	for (i = 0; i < nops; i++) {
>>> 		if (madvise((void *)p, PAGE_SIZE * npages, MADV_PAGEOUT)) {
>>> 			perror("madvise");
>>> 			exit(-1);
>>> 		}
>>>
>>> 		for (j = 0; j < npages; j++) {
>>> 			c = p[j * PAGE_SIZE];
>>> 			c++;
>>> 			time -= rdtscp();
>>> 			p[j * PAGE_SIZE] = c;
>>> 			time += rdtscp();
>>> 		}
>>> 	}
>>>
>>> For this specific reproducer at least, the page lock seems to be the thingy that prohibits
>>> reuse if I interpret the numbers correctly. We pass the initial page_count() check.
>>>
>>> Haven't looked into the details, and I would be curious how that performs with actual
>>> workloads, if we can reproduce similar behavior.
>>
>> I don't see how that patch addresses the lru issue.  Wouldn't we need
>> something like ...
>>
>> 	if (!PageLRU(page))
>> 		lru_add_drain_all();
>>

lru_add_drain_all() takes a mutex ... best we can do I guess is drain
the local CPU using lru_add_drain(). I'll go play with it and see what
breaks :)

-- 
Thanks,

David / dhildenb

