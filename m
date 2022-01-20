Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB28495167
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376653AbiATP0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376686AbiATP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642692386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcFuUx6JnIuoyTsFkMKn2U/95+8ifvkCP1zZpo98AmA=;
        b=EW4VcAlknIDCc3AD6qlmFJNmw9e8SMaHXop1M+QPNpH1DJKY3+NlNcBCwV3JtAyxMwdXIP
        W2Uin48XiwK6fQyKonmBwq5FAzr0DO/G+SAkyzrIi0cIlBWlAa+oiNZpFW8J26wRgmTNth
        6XqxnXKR0Z14hCOoEv9d+FAXhDmRadQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-lFGzwTswPgKdWNsJ7IYQww-1; Thu, 20 Jan 2022 10:26:25 -0500
X-MC-Unique: lFGzwTswPgKdWNsJ7IYQww-1
Received: by mail-ed1-f69.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso6204710edb.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=JcFuUx6JnIuoyTsFkMKn2U/95+8ifvkCP1zZpo98AmA=;
        b=lr3YemTaUC+ik2Yu3cMJwOTxZGOMjyWQLvNS+FoYkVwoaa90SPvd3ut0BCW6loOgBj
         hqO7pmFzG4DQZHumdKmjbHNI33SET7MReUzpUstDlwy9NCYkklBdK7ADzXDaZvfwU+Sg
         x/aSqwQGsiFGloUXNRQ8eb5D7ATjyoDvOfZHA4dAL0nDKnYfaqMVnSuonpyPQhZh5jkj
         OEZ2ygMhaba0KeO4lHMEsST9TXFV7VTzY3c1cL1Bzg9a/nVM2hnnHMgdMWukrUcOYnVt
         4nhI06kXxTABvzSnmDO+TnFturHp4ZVehNIaNqcGqA64KCtoAbMhrlt4e6VS5QPmZMD2
         CSTw==
X-Gm-Message-State: AOAM5336OIaotzt4n6Q7TW214CBsOvUBEFsYKGzDytL0Z03BMV5QaSWF
        y8IkCnZTQGvA6ZLOYCMFX+UPgKDJEfR+eVqhOKa8VPqY7hGEp5ZAZBLbDJWIIr3KZg320yeurFP
        dBzUPSg0WDRbthSLw8io4sgqs
X-Received: by 2002:a17:906:4795:: with SMTP id cw21mr10414542ejc.39.1642692383922;
        Thu, 20 Jan 2022 07:26:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4ABnzPg+275IpNEeFqOv2Bl3qkyZQ/tUMXHw6wdfpQpRGOsWTlX1Ux9PRNpnvv2mEvqAvqA==
X-Received: by 2002:a17:906:4795:: with SMTP id cw21mr10414523ejc.39.1642692383651;
        Thu, 20 Jan 2022 07:26:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id gr24sm1107372ejb.185.2022.01.20.07.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:26:23 -0800 (PST)
Message-ID: <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
Date:   Thu, 20 Jan 2022 16:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
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
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <Yel0BXVyj8uvsWJX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 15:39, Matthew Wilcox wrote:
> On Thu, Jan 20, 2022 at 03:15:37PM +0100, David Hildenbrand wrote:
>> On 17.01.22 14:31, zhangliang (AG) wrote:
>>> Sure, I will do that :)
>>
>> I'm polishing up / testing the patches and might send something out for discussion shortly.
>> Just a note that on my branch was a version with a wrong condition that should have been fixed now.
>>
>> I am still thinking about PTE mapped THP. For these, we'll always
>> have page_count() > 1, essentially corresponding to the number of still-mapped sub-pages.
>>
>> So if we end up with a R/O mapped part of a THP, we'll always have to COW and cannot reuse ever,
>> although it's really just a single process mapping the THP via PTEs.
>>
>> One approach would be to scan the currently locked page table for entries mapping
>> this same page. If page_count() corresponds to that value, we know that only we are
>> mapping the THP and there are no additional references. That would be a special case
>> if we find an anon THP in do_wp_page(). Hm.
> 
> You're starting to optimise for some pretty weird cases at that point.

So your claim is that read-only, PTE mapped pages are weird? How do you
come to that conclusion?

If we adjust the THP reuse logic to split on additional references
(page_count() == 1) -- similarly as suggested by Linus to fix the CVE --
we're going to end up with exactly that more frequently.

> Anon THP is always going to start out aligned (and can be moved by
> mremap()).  Arguably it should be broken up if it's moved so it can be
> reformed into aligned THPs by khugepaged.

Can you elaborate, I'm missing the point where something gets moved. I
don't care about mremap() at all here.


1. You have a read-only, PTE mapped THP
2. Write fault on the THP
3. We PTE-map the THP because we run into a false positive in our COW
   logic to handle COW on PTE
4. Write fault on the PTE
5. We always have to COW each and every sub-page and can never reuse,
   because page_count() > 1

That's essentially what reuse_swap_page() tried to handle before.
Eventually optimizing for this is certainly the next step, but I'd like
to document which effect the removal of reuse_swap_page() will have to THP.

-- 
Thanks,

David / dhildenb

