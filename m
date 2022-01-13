Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F118C48DA65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiAMPE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:04:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbiAMPE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642086266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRTsijcpTTyHraoR+V3O1Mi16FiVJpK3PKf++RerMpw=;
        b=Zk1KP2duy8hLUAqFuOLaXE5CcRc7FdYbGsUUXGVKO5HPs4GLrRmZdRptupinvXLyUjejwX
        6razHT8L/zC1AslnAeMYQ+6EmW8m9VuevU+wEKgudRQxT51ZV30sLpumdfVrB32q6itgvR
        sMEWSOOv0bqoFhXRMw30vWmGaKAobH4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-SXOjhBofNNGntp7JKul0JQ-1; Thu, 13 Jan 2022 10:04:24 -0500
X-MC-Unique: SXOjhBofNNGntp7JKul0JQ-1
Received: by mail-ed1-f69.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso5593096edd.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cRTsijcpTTyHraoR+V3O1Mi16FiVJpK3PKf++RerMpw=;
        b=hvSTflwYkjGty6G1xfyVWYcdX+8JjeX0gkgaIHBfz/8F+A81vOnnzySoa4y4vH4RW8
         vA5U189U/21RqgyTo2kvOe3UhD+rrgPbkOU9hmq+t3Czi+Y4sw3HjhtI9xvmbYwVQ7fp
         0nyMteFyCOpVqu5OOE3QyMY4UwT8e99QD4+qoP5FqwpYiqml71GHsWrd9P20tHK0Mj9E
         8Kie9SXy5tHzlGlliwc+i9AfJV9Aj66KJ4Uvjz7QE8CnmD3aVLMvLGxRuuRqsbtzXko6
         DvAM26HadmVBcZLL+EaZjstAqqpbD2S/P4sZeWj27uprqScCHGoAntFFBNpYdutkAcqc
         20DA==
X-Gm-Message-State: AOAM530JfQSv1aTPgjGWJL7c26asKd7UcZgoapVkJ8j64qX9vaKihyJW
        USZBzDcfQQ76jfNltyO57W+0xlXi3PuHSpoDIqQ9YEYLSYBJHXq9uVedUsHjbr11eK+z9cd+eXi
        v80FQl3zSB0Cxmt4+SXKX4/m0
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr3970383ejc.386.1642086263415;
        Thu, 13 Jan 2022 07:04:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjs3sI3lBKoJfQelsLOUNn03wgAPiabACCHXkb0MaN1/2AMIGOdqbV88alKCvlLM5aoh0wdg==
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr3970358ejc.386.1642086263121;
        Thu, 13 Jan 2022 07:04:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id d27sm953104ejd.117.2022.01.13.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 07:04:22 -0800 (PST)
Message-ID: <79e04824-73d5-c69f-64fb-f67051f4e124@redhat.com>
Date:   Thu, 13 Jan 2022 16:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liang Zhang <zhangliang5@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <ec0f57e6-f1f6-b9d9-b507-20e845fe7f17@redhat.com>
 <YeA/DQptAz3fl6ym@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YeA/DQptAz3fl6ym@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 16:02, Matthew Wilcox wrote:
> On Thu, Jan 13, 2022 at 03:46:54PM +0100, David Hildenbrand wrote:
>> On 13.01.22 15:39, Matthew Wilcox wrote:
>>> On Thu, Jan 13, 2022 at 10:03:18PM +0800, Liang Zhang wrote:
>>>> In current implementation, process's read requestions will fault in pages
>>>> with WP flags in PTEs. Next, if process emit a write requestion will go
>>>> into do_wp_page() and copy data to a new allocated page from the old one
>>>> due to refcount > 1 (page table mapped and swapcache), which could be
>>>> result in performance degradation. In fact, this page is exclusively owned
>>>> by this process and the duplication from old to a new allocated page is
>>>> really unnecessary.
>>>>
>>>> So In this situation, these unshared pages can be reused by its process.
>>>
>>> Let's bring Linus in on this, but I think this reintroduces all of the
>>> mapcount problems that we've been discussing recently.
>>>
>>> How about this as an alternative?
>>>
>>> +++ b/mm/memory.c
>>> @@ -3291,11 +3291,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>                 struct page *page = vmf->page;
>>>
>>>                 /* PageKsm() doesn't necessarily raise the page refcount */
>>> -               if (PageKsm(page) || page_count(page) != 1)
>>> +               if (PageKsm(page) || page_count(page) != 1 + PageSwapCache(page))
>>>                         goto copy;
>>>                 if (!trylock_page(page))
>>>                         goto copy;
>>> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
>>> +               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1 + PageSwapCache(page)) {
>>>                         unlock_page(page);
>>>                         goto copy;
>>>                 }
>>
>> Funny, I was staring at swap reuse code as I received this mail ...
>> because if we're not using reuse_swap_page() here anymore, we shouldn't
>> really be reusing it anywhere for consistency, most prominently in
>> do_swap_page() when we handle vmf->flags & FAULT_FLAG_WRITE just
>> similarly as we do here ...
>>
>> And that's where things get hairy and I am still trying to figure out
>> all of the details.
>>
>> Regarding above: If the page is swapped out in multiple processes but
>> was only faulted into the current process R/O, and then we try to write:
>>
>> 1. Still in the swapcache: PageSwapCache()
>> 2. Mapped only by one process: page_mapcount(page) == 1
>> 3. Reference from one page table and the swap cache: page_count(page) ==
>>
>> But other processes could read-fault on the swapcache page, no?
>>
>> I think we'd really have to check against the swapcount as well ...
>> essentially reuse_swap_page(), no?
> 
> Unfortunately the last digit is missing from your "3.", but I

Sorry, == 2.

> think you're absolutely right; we need to check swapcount.  So
> once reuse_swap_page() checks page_count instead of mapcount, we'll
> be good?
> 

That's something I've been thinking of. Either get rid of
reuse_swap_page() completely or make it obey the same rules everywhere.

It's highly inconsistent how we handle COW.

-- 
Thanks,

David / dhildenb

