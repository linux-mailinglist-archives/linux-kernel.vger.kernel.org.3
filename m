Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67413495552
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377594AbiATUSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbiATUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642709916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+ulNj0C+UncEzUU3lB3FXFcKi2cQR09+RDgCW05Fkg=;
        b=i/j50nJxeHbVustRuhQdtbD6km6SrmCXS1mONzrVewTzDL5MGWBJMlZwaHhX4iFCOta9Dv
        WYRz4bIBVgO8N+PVuVJed/DcGpX2FSSY7t8KOGUx2KZUPD4pZopDr3gcewbWsuNJA4BP8x
        q3RsDbnDQScIOzw56pA/XQcs8h/9IB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-15ul2eHWPze0BV7Uw-ImCg-1; Thu, 20 Jan 2022 15:18:35 -0500
X-MC-Unique: 15ul2eHWPze0BV7Uw-ImCg-1
Received: by mail-wm1-f70.google.com with SMTP id f187-20020a1c38c4000000b0034d5c66d8f5so5332710wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=f+ulNj0C+UncEzUU3lB3FXFcKi2cQR09+RDgCW05Fkg=;
        b=FFIo0mm+Qzcm0g8hIsCw58YSlHBkR2Up4c/MxhqNjrmew77FHrw/6ke5girVhsdEH/
         +ie2gBrmxe0ddRM07mNidy7lOLGviswUmuOfZxYk6UXN73BBP4depXm0iFVURSOJH7LG
         xknltddQtz51y7v4KvrvUOlfOTYyovX49WhmTT6I6vT+rxAtttzsEBHAp1vyTvP2+agM
         aqVpaTZ+gDQ3Na6wS/FZCZOoa3f0DBAecvrDcFkLIKlsgqjKWXzzG6sRJk+X/Uv+v2I2
         qah6sLSlC7qfSDbyciiY3g9mSMDSfghqSHAc+BgIcduOIu9vogbE+hRCYg/lIIp4tPEg
         D1gA==
X-Gm-Message-State: AOAM532xrsTONp3cwBAhsQzMtj4O4BGjlilGkucFWs+JR6yD3kXmReEA
        Bt2kD21bwDVBqpu/VCwSFKUI8BWafx0YDoxF8NU+HcTkD+r8pcCtk9lYE9Ai2059ikwvKEUHCPM
        B2Hhq2/WuSLLyTmupo1sTchnV
X-Received: by 2002:a5d:4301:: with SMTP id h1mr627422wrq.511.1642709914260;
        Thu, 20 Jan 2022 12:18:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJ8V2NVDzKCKd9gXtzmEPNaFiVrFo5Ga1bUGA5CfK3IpuQ1rxGzdnyQtbsRWiOfTEjy11CpQ==
X-Received: by 2002:a5d:4301:: with SMTP id h1mr627408wrq.511.1642709914038;
        Thu, 20 Jan 2022 12:18:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id bg26sm8586342wmb.48.2022.01.20.12.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 12:18:33 -0800 (PST)
Message-ID: <0c48872e-f927-d36a-b9b6-10e2e2cacb3b@redhat.com>
Date:   Thu, 20 Jan 2022 21:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
 <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
 <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
Organization: Red Hat
In-Reply-To: <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 20:55, David Hildenbrand wrote:
> On 20.01.22 19:11, Nadav Amit wrote:
>>
>>
>>> On Jan 20, 2022, at 10:00 AM, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 20.01.22 18:48, Nadav Amit wrote:
>>>>
>>>>> On Jan 20, 2022, at 6:15 AM, David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 17.01.22 14:31, zhangliang (AG) wrote:
>>>>>> Sure, I will do that :)
>>>>>
>>>>> I'm polishing up / testing the patches and might send something out for discussion shortly.
>>>>> Just a note that on my branch was a version with a wrong condition that should have been fixed now.
>>>>>
>>>>
>>>> Sorry for being late for the discussion.
>>>>
>>>> David, does any of it regards the lru_cache_add() reference issue that I
>>>> mentioned? [1]
>>>
>>> No, unfortunately not in that part of my work. *Maybe* we could also try
>>> to handle that reference similarly to the swapcache, but the question is
>>> if we can't wait for PageAnonExclusive.
>>>
>>> Right now I have the following in mind to get most parts working as
>>> exptected:
>>>
>>> 1. Optimize reuse logic for the swapcache as it seems to be easy
>>> 2. Streamline COW logic and remove reuse_swap_page() -- fix the CVE for
>>>   THP.
>>> 3. Introduce PageAnonExclusive and allow FOLL_PIN only on
>>>   PageAnonExclusive pages.
>>> 4. Convert O_DIRECT to FOLL_PIN
>>>
>>> We will never ever have to copy a page PageAnonExclusive page in the COW
>>> handler and can immediately reuse it without even locking the page. The
>>> existing reuse logic is essentially then used to reset PageAnonExclusive
>>> on a page (thus it makes sense to work on it) where the flag is not set
>>> anymore -- or on a fresh page if we have to copy.
>>>
>>> That implies that all these additional references won't care if your app
>>> doesn't fork() or KSM isn't active. Consequently, anything that
>>> read-protects anonymous pages will work as expected and should be as
>>> fast as it gets.
>>>
>>> Sounds good? At least to me. If only swap/migration entries wouldn't be
>>> harder to handle than I'd wish, that's why it's taking a little and will
>>> take a little longer.
>>
>> Thanks for the quick response. I would have to see the logic to set/clear
>> PageAnonExclusive to fully understand how things are handled.
>>
>> BTW, I just saw this patch form PeterZ [1] that seems to be related, as
>> it deals with changing protection on pinned pages.
> 
> Hi Nadav,
> 
> I'm trying to see how effective the following patch is with your forceswap.c [1] reproducer.
> 
> commit b08d494deb319a63b7c776636b960258c48775e1
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Jan 14 09:29:52 2022 +0100
> 
>     mm: optimize do_wp_page() for exclusive pages in the swapcache
>     
>     Let's optimize for a page with a single user that has been added to the
>     swapcache. Try removing the swapcache reference if there is hope that
>     we're the exclusive user, but keep the page_count(page) == 1 check in
>     place.
>     
>     Avoid using reuse_swap_page(), we'll streamline all reuse_swap_page()
>     users next.
>     
>     While at it, remove the superfluous page_mapcount() check: it's
>     implicitly covered by the page_count() for ordinary anon pages.
>     
>     Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f306e698a1e3..d9186981662a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3291,19 +3291,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>         if (PageAnon(vmf->page)) {
>                 struct page *page = vmf->page;
>  
> -               /* PageKsm() doesn't necessarily raise the page refcount */
> -               if (PageKsm(page) || page_count(page) != 1)
> +               /*
> +                * PageKsm() doesn't necessarily raise the page refcount.
> +                *
> +                * These checks are racy as long as we haven't locked the page;
> +                * they are a pure optimization to avoid trying to lock the page
> +                * and trying to free the swap cache when there is little hope
> +                * it will actually result in a refcount of 1.
> +                */
> +               if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
>                         goto copy;
>                 if (!trylock_page(page))
>                         goto copy;
> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +               if (PageSwapCache(page))
> +                       try_to_free_swap(page);
> +               if (PageKsm(page) || page_count(page) != 1) {
>                         unlock_page(page);
>                         goto copy;
>                 }
>                 /*
> -                * Ok, we've got the only map reference, and the only
> -                * page count reference, and the page is locked,
> -                * it's dark out, and we're wearing sunglasses. Hit it.
> +                * Ok, we've got the only page reference from our mapping
> +                * and the page is locked, it's dark out, and we're wearing
> +                * sunglasses. Hit it.
>                  */
>                 unlock_page(page);
>                 wp_page_reuse(vmf);
> 
> 
> I added some vmstats that monitor various paths. After one run of
> 	./forceswap 2 1000000 1
> I'm left with a rough delta (including some noise) of
> 	anon_wp_copy_count 1799
> 	anon_wp_copy_count_early 1
> 	anon_wp_copy_lock 983396
> 	anon_wp_reuse 0
> 
> The relevant part of your reproducer is
> 
> 	for (i = 0; i < nops; i++) {
> 		if (madvise((void *)p, PAGE_SIZE * npages, MADV_PAGEOUT)) {
> 			perror("madvise");
> 			exit(-1);
> 		}
> 
> 		for (j = 0; j < npages; j++) {
> 			c = p[j * PAGE_SIZE];
> 			c++;
> 			time -= rdtscp();
> 			p[j * PAGE_SIZE] = c;
> 			time += rdtscp();
> 		}
> 	}
> 
> For this specific reproducer at least, the page lock seems to be the thingy that prohibits
> reuse if I interpret the numbers correctly. We pass the initial page_count() check.
> 
> Haven't looked into the details, and I would be curious how that performs with actual
> workloads, if we can reproduce similar behavior.

I should stop working for today, I messed up the counter names *cries in
German* :(

anon_wp_reuse 1799
anon_wp_copy_count 1
anon_wp_copy_count_early 983396
anon_wp_copy_lock 0

which makes *a lot* more sense and might indicate the PageLRU() issue.

-- 
Thanks,

David / dhildenb

