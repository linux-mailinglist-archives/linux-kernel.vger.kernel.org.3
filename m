Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E922F495199
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376641AbiATPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:40:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376799AbiATPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642693198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8iqaG7Lc+VchV66bNoQHn2xE3BtOzlPVk9h6F+EPx9w=;
        b=YKskQEyINhVW3d9+/KgPqSW7Em3EvYyOOyqpHfPhLQrDwFtqMztL619ZD99KMfD5BncgTo
        EBWCtL7jqNRVnWKC5/AOUl5FotaYOqEeovd0Pt1qtl8CyOGivviIirO9IakLxKjocwgdZU
        5ChpH7ko4FBmXtc28ib3aPDEKxvmPck=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-MbrpGgEJOJuT_nNLNzN1CQ-1; Thu, 20 Jan 2022 10:39:57 -0500
X-MC-Unique: MbrpGgEJOJuT_nNLNzN1CQ-1
Received: by mail-ed1-f69.google.com with SMTP id bm21-20020a0564020b1500b00402c34373f9so6283358edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8iqaG7Lc+VchV66bNoQHn2xE3BtOzlPVk9h6F+EPx9w=;
        b=p/YH54geGicDA+Bw4fCo9hriHsYTjDQ38AZ6VUs3MT2F6UQslIjWUcD9vtvj9vC+/r
         mETdcJ1LLy4yhXAEVr3/ny7mgqC2RKeFZ7d5YX2UL2DNaWpUf/pOr2RPklDgo4lMcJxS
         NW6dgty8/EIEvpunV/CWKidQXz9B+vkz+e0EJqpy970xxCxkV5FMfXViZspRrtUVFH+2
         s1+l2Vpm5EKzSwydq9oAePbzn4iXzm9ASJh6k1w75f82ZcC/JxnaF+Tviu9xnyvwLfGS
         rzvx3xTSv0ZEnAwQd1GLcZG6dX/9yijueIwGei4+zNvhgCn/QXQO11zvU5sNZd03nNVY
         i2GA==
X-Gm-Message-State: AOAM533TxZvlp9c83DSrHyldf5YQkX8psQFRL5wKH/d13o1n16vMhd3+
        c0T5kiTqlDPiaJYrTBLswkv1KBPmmBwW9c5M8bA5JFLP61TX3lsn+vVSAf6EpIyPNnO+St6A5cu
        vW4CGRS0/GbRsKYHqQOh6X8KL
X-Received: by 2002:a17:906:4453:: with SMTP id i19mr28809527ejp.305.1642693196528;
        Thu, 20 Jan 2022 07:39:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzha5k25rT2Htr7L0NG19u/lndf6crtI76bzYEx2SL35kc/iOccj2GEZbXytDaFkqL8JgLq+w==
X-Received: by 2002:a17:906:4453:: with SMTP id i19mr28809509ejp.305.1642693196269;
        Thu, 20 Jan 2022 07:39:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id k4sm1011334edo.55.2022.01.20.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:39:55 -0800 (PST)
Message-ID: <759f9bc8-0b10-7f0f-28a6-f292bed9053f@redhat.com>
Date:   Thu, 20 Jan 2022 16:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
 <YemBl4ZVtJqtAVwV@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YemBl4ZVtJqtAVwV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 16:36, Matthew Wilcox wrote:
> On Thu, Jan 20, 2022 at 04:26:22PM +0100, David Hildenbrand wrote:
>> On 20.01.22 15:39, Matthew Wilcox wrote:
>>> On Thu, Jan 20, 2022 at 03:15:37PM +0100, David Hildenbrand wrote:
>>>> On 17.01.22 14:31, zhangliang (AG) wrote:
>>>>> Sure, I will do that :)
>>>>
>>>> I'm polishing up / testing the patches and might send something out for discussion shortly.
>>>> Just a note that on my branch was a version with a wrong condition that should have been fixed now.
>>>>
>>>> I am still thinking about PTE mapped THP. For these, we'll always
>>>> have page_count() > 1, essentially corresponding to the number of still-mapped sub-pages.
>>>>
>>>> So if we end up with a R/O mapped part of a THP, we'll always have to COW and cannot reuse ever,
>>>> although it's really just a single process mapping the THP via PTEs.
>>>>
>>>> One approach would be to scan the currently locked page table for entries mapping
>>>> this same page. If page_count() corresponds to that value, we know that only we are
>>>> mapping the THP and there are no additional references. That would be a special case
>>>> if we find an anon THP in do_wp_page(). Hm.
>>>
>>> You're starting to optimise for some pretty weird cases at that point.
>>
>> So your claim is that read-only, PTE mapped pages are weird? How do you
>> come to that conclusion?
> 
> Because normally anon THP pages are PMD mapped.  That's rather
> the point of anon THPs.

For example unless we are talking about *drumroll* COW handling.

> 
>> If we adjust the THP reuse logic to split on additional references
>> (page_count() == 1) -- similarly as suggested by Linus to fix the CVE --
>> we're going to end up with exactly that more frequently.
> 
> I don't understand.  Are we talking past each other?  As I understand
> the situation we're talking about here, a process has created a THP,
> done something to cause it to be partially mapped (or mapped in a
> misaligned way) in its own address space, then forked, and we're
> trying to figure out if it's safe to reuse it?  I say that situation is
> rare enough that it's OK to always allocate an order-0 page and
> copy into it.

Yes, we are talking past each other and no, I am talking about fully
mapped THP, just mapped via PTEs.

Please refer to our THP COW logic: do_huge_pmd_wp_page()

> 
>>> Anon THP is always going to start out aligned (and can be moved by
>>> mremap()).  Arguably it should be broken up if it's moved so it can be
>>> reformed into aligned THPs by khugepaged.
>>
>> Can you elaborate, I'm missing the point where something gets moved. I
>> don't care about mremap() at all here.
>>
>>
>> 1. You have a read-only, PTE mapped THP
>> 2. Write fault on the THP
>> 3. We PTE-map the THP because we run into a false positive in our COW
>>    logic to handle COW on PTE
>> 4. Write fault on the PTE
>> 5. We always have to COW each and every sub-page and can never reuse,
>>    because page_count() > 1
>>
>> That's essentially what reuse_swap_page() tried to handle before.
>> Eventually optimizing for this is certainly the next step, but I'd like
>> to document which effect the removal of reuse_swap_page() will have to THP.
> 
> I'm talking about step 0.  How do we get a read-only, PTE-mapped THP?
> Through mremap() or perhaps through an mprotect()/mmap()/munmap() that
> failed to split the THP.

do_huge_pmd_wp_page()

-- 
Thanks,

David / dhildenb

