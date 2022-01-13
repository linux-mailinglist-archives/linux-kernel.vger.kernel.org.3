Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8348D9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiAMOrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233723AbiAMOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642085221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSDQWCPWVjF9NlavrTbv8hqhD4ANM1MfQ/emEeuv7nY=;
        b=ZfAu+WpJPiV0n9F3HdvgUenvus3nwYeYHVqpcxH5uvMAMiEDmWNREHufQu+KCJJhtYOlHb
        L/CUu0qoYBOZUEiB9j/690i0BG0SAZ0/2LL4emPyMxHHqdkt4gnnAjsUF2H5L7afWKmClF
        C5oag0Q6GYl9aC6IMnSLcgeSJ0B1raI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-fTbcgoGpNk2zE4YutVutUg-1; Thu, 13 Jan 2022 09:46:58 -0500
X-MC-Unique: fTbcgoGpNk2zE4YutVutUg-1
Received: by mail-ed1-f71.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso5557705edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 06:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=lSDQWCPWVjF9NlavrTbv8hqhD4ANM1MfQ/emEeuv7nY=;
        b=f+1NJVl8bYwAB6vEnGcg3vINf7bIwqKVQbyxxxjgZzhNVT7CE2rnIuuSAuolpI2t9P
         bXbL0OGbD9m8mXvlsQzRw++/bACi6R7DHmlejnVD0VWW5yJIm1YFpJAzaW8VkDJA8HRB
         meq2fmQitEubYYNIXLFnloMKiDIfO7/EOBbuNKyk91N/4/usi1vFH0O3Q8/sikfxDaOw
         SzYbY/PQLEqZtDkjm6MH/aPqM4lXYlTsuxkhzm1pIpenQqv6Bt9UQmDRxLJj9TW7SCe2
         0L/Q4lMdN6v5ziteNycJ8GdxV3svmcOuMST6SLtjUr5RvE7oV+VLz8TSQ4rdl7lk8XjK
         EVGA==
X-Gm-Message-State: AOAM5300S5vjA0K2MIbKZQJpdjiDh0ic4SfLEeyKhAT0ehGZLyEJGBGw
        vBgqeDv7m0AdZPoSncSIdqM9K3XHdOkYjovRQ9FGrIUS2m0wW3UVAICs5EBCRvfxuo5BAvcKuk+
        TNF/alpnElubWATF++I1Rky1n
X-Received: by 2002:a17:906:36da:: with SMTP id b26mr3560777ejc.213.1642085217038;
        Thu, 13 Jan 2022 06:46:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/38BHGBrb6Tyf8n/r/vXXRORwnLjRqkhkzTt2dZhCdq1sN4eIg2NQzE+YI3p2tvbF891lHA==
X-Received: by 2002:a17:906:36da:: with SMTP id b26mr3560766ejc.213.1642085216813;
        Thu, 13 Jan 2022 06:46:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id g9sm938257ejo.222.2022.01.13.06.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 06:46:56 -0800 (PST)
Message-ID: <ec0f57e6-f1f6-b9d9-b507-20e845fe7f17@redhat.com>
Date:   Thu, 13 Jan 2022 15:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Liang Zhang <zhangliang5@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <YeA5oP/iaxtVPHb3@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 15:39, Matthew Wilcox wrote:
> On Thu, Jan 13, 2022 at 10:03:18PM +0800, Liang Zhang wrote:
>> In current implementation, process's read requestions will fault in pages
>> with WP flags in PTEs. Next, if process emit a write requestion will go
>> into do_wp_page() and copy data to a new allocated page from the old one
>> due to refcount > 1 (page table mapped and swapcache), which could be
>> result in performance degradation. In fact, this page is exclusively owned
>> by this process and the duplication from old to a new allocated page is
>> really unnecessary.
>>
>> So In this situation, these unshared pages can be reused by its process.
> 
> Let's bring Linus in on this, but I think this reintroduces all of the
> mapcount problems that we've been discussing recently.
> 
> How about this as an alternative?
> 
> +++ b/mm/memory.c
> @@ -3291,11 +3291,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>                 struct page *page = vmf->page;
> 
>                 /* PageKsm() doesn't necessarily raise the page refcount */
> -               if (PageKsm(page) || page_count(page) != 1)
> +               if (PageKsm(page) || page_count(page) != 1 + PageSwapCache(page))
>                         goto copy;
>                 if (!trylock_page(page))
>                         goto copy;
> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1 + PageSwapCache(page)) {
>                         unlock_page(page);
>                         goto copy;
>                 }

Funny, I was staring at swap reuse code as I received this mail ...
because if we're not using reuse_swap_page() here anymore, we shouldn't
really be reusing it anywhere for consistency, most prominently in
do_swap_page() when we handle vmf->flags & FAULT_FLAG_WRITE just
similarly as we do here ...

And that's where things get hairy and I am still trying to figure out
all of the details.

Regarding above: If the page is swapped out in multiple processes but
was only faulted into the current process R/O, and then we try to write:

1. Still in the swapcache: PageSwapCache()
2. Mapped only by one process: page_mapcount(page) == 1
3. Reference from one page table and the swap cache: page_count(page) ==

But other processes could read-fault on the swapcache page, no?

I think we'd really have to check against the swapcount as well ...
essentially reuse_swap_page(), no?

-- 
Thanks,

David / dhildenb

