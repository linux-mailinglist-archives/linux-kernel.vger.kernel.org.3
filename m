Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655D25081D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359628AbiDTHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiDTHPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DBED393ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650438786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CllaqjnMUnq824vrSpuFbjqJCzo9SIG4gCoc2+ENZg=;
        b=OrJln5UCVduu07DjDFQ+TymngX3xb31V9QyY0qCPJq2oahAPqxqO6Vgodq9mRtVO4h38ME
        sLdxjeL6WNeET8rgit6JRDAzhsLUpFsHkmQoaRDTooBIz4KSZtFdFu3bZBfuUogvXyZS78
        Tf2B0B5qATXK3dQRRSfsQE+au2rzjU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-58o3NoTJMwOnIInaC3CuBw-1; Wed, 20 Apr 2022 03:12:46 -0400
X-MC-Unique: 58o3NoTJMwOnIInaC3CuBw-1
Received: by mail-wm1-f69.google.com with SMTP id r64-20020a1c2b43000000b0038b59eb1940so1724779wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8CllaqjnMUnq824vrSpuFbjqJCzo9SIG4gCoc2+ENZg=;
        b=uAHb3cEh3y08ceNYuIdHSWiWCKqzW6SjNOIzJpA944vcwwj8xooHHEXN5w4depTTgh
         EVw3Yn3uYNK3yw6Ziu6uVY2jFanm1AzAItVOrtUtXr3KMrHIltOaOHipbqEJxiNnVuvT
         PbNvc8K0znF9DelST5ddnakeX7knCz0b7OFdbEtCrUlO9kLNJjHyfVGqwnvZ1hmJyEGm
         INe2Go1kQuuZ1192cw9mUwmpKT2ZADmkgfwt9y2jhwg/XXrxnP7uJEeRH3f8m3X9SyOt
         eMuzt7hbEfrbb3BiAGPX/RRQocg6boKjQBbl2byQK9xKmjrxZaeUCKXrhEQOUvBnp6Ex
         jveQ==
X-Gm-Message-State: AOAM533FKCvNKKsPX1cwdG9v+qBjcbDTZUdh2+xODwm5YPA4Q78iHjqg
        ao8wilRHacO/3PQ7Y5Al/1Jcg44cn0/414O3KxoPbXPTdeKiON5h86IAdPtiuSiH1t/L68oyp6u
        hcLXruTVfqORTCg5AYBjDYtoo
X-Received: by 2002:a05:6000:2a1:b0:20a:7c6a:d43e with SMTP id l1-20020a05600002a100b0020a7c6ad43emr14975833wry.417.1650438765038;
        Wed, 20 Apr 2022 00:12:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjsoEwJbdoCw8ims1vlhe9PqhEFnN/T+0MWwr03ugC0oOKkPFqWAydu5igC8slB5R0RsqH3Q==
X-Received: by 2002:a05:6000:2a1:b0:20a:7c6a:d43e with SMTP id l1-20020a05600002a100b0020a7c6ad43emr14975810wry.417.1650438764782;
        Wed, 20 Apr 2022 00:12:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:3d00:23e4:4c84:67a5:3ccf? (p200300cbc7023d0023e44c8467a53ccf.dip0.t-ipconnect.de. [2003:cb:c702:3d00:23e4:4c84:67a5:3ccf])
        by smtp.gmail.com with ESMTPSA id 100-20020adf806d000000b00205ba671b25sm14277951wrk.56.2022.04.20.00.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 00:12:44 -0700 (PDT)
Message-ID: <592aaae5-2aa6-22a8-29e3-ec20f75945db@redhat.com>
Date:   Wed, 20 Apr 2022 09:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH 0/5] hugetlb: Change huge pmd sharing
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
 <045a59a1-0929-a969-b184-1311f81504b8@redhat.com>
 <4ddf7d53-db45-4201-8ae0-095698ec7e1a@oracle.com>
 <dcda550d-a92a-c95e-bd08-c578924d7f8d@redhat.com>
 <ec97313f-c7ce-ab23-3934-faddbb782336@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ec97313f-c7ce-ab23-3934-faddbb782336@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 00:50, Mike Kravetz wrote:
> On 4/8/22 02:26, David Hildenbrand wrote:
>>>>
>>>> Let's assume a 4 TiB device and 2 MiB hugepage size. That's 2097152 huge
>>>> pages. Each such PMD entry consumes 8 bytes. That's 16 MiB.
>>>>
>>>> Sure, with thousands of processes sharing that memory, the size of page
>>>> tables required would increase with each and every process. But TBH,
>>>> that's in no way different to other file systems where we're even
>>>> dealing with PTE tables.
>>>
>>> The numbers for a real use case I am frequently quoted are something like:
>>> 1TB shared mapping, 10,000 processes sharing the mapping
>>> 4K PMD Page per 1GB of shared mapping
>>> 4M saving for each shared process
>>> 9,999 * 4M ~= 39GB savings
>>
>> 3.7 % of all memory. Noticeable if the feature is removed? yes. Do we
>> care about supporting such corner cases that result in a maintenance
>> burden? My take is a clear no.
>>
>>>
>>> However, if you look at commit 39dde65c9940c which introduced huge pmd sharing
>>> it states that performance rather than memory savings was the primary
>>> objective.
>>>
>>> "For hugetlb, the saving on page table memory is not the primary
>>>  objective (as hugetlb itself already cuts down page table overhead
>>>  significantly), instead, the purpose of using shared page table on hugetlb is
>>>  to allow faster TLB refill and smaller cache pollution upon TLB miss.
>>>     
>>>  With PT sharing, pte entries are shared among hundreds of processes, the
>>>  cache consumption used by all the page table is smaller and in return,
>>>  application gets much higher cache hit ratio.  One other effect is that
>>>  cache hit ratio with hardware page walker hitting on pte in cache will be
>>>  higher and this helps to reduce tlb miss latency.  These two effects
>>>  contribute to higher application performance."
>>>
>>> That 'makes sense', but I have never tried to measure any such performance
>>> benefit.  It is easier to calculate the memory savings.
>>
>> It does makes sense; but then, again, what's specific here about hugetlb?
>>
>> Most probably it was just easy to add to hugetlb in contrast to other
>> types of shared memory.
>>
>>>
>>>>
>>>> Which results in me wondering if
>>>>
>>>> a) We should simply use gigantic pages for such extreme use case. Allows
>>>>    for freeing up more memory via vmemmap either way.
>>>
>>> The only problem with this is that many processors in use today have
>>> limited TLB entries for gigantic pages.
>>>
>>>> b) We should instead look into reclaiming reconstruct-able page table.
>>>>    It's hard to imagine that each and every process accesses each and
>>>>    every part of the gigantic file all of the time.
>>>> c) We should instead establish a more generic page table sharing
>>>>    mechanism.
>>>
>>> Yes.  I think that is the direction taken by mshare() proposal.  If we have
>>> a more generic approach we can certainly start deprecating hugetlb pmd
>>> sharing.
>>
>> My strong opinion is to remove it ASAP and get something proper into place.
>>
> 
> No arguments about the complexity of this code.  However, there will be some
> people who will notice if it is removed.

Yes, it should never have been added that way -- unfortunately.

> 
> Whether or not we remove huge pmd sharing support, I would still like to
> address the scalability issue.  To do so, taking i_mmap_rwsem in read mode
> for fault processing needs to go away.  With this gone, the issue of faults
> racing with truncation needs to be addressed as it depended on fault code
> taking the mutex.  At a high level, this is fairly simple but hugetlb
> reservations add to the complexity.  This was not completely addressed in
> this series.

Okay.

> 
> I will be sending out another RFC that more correctly address all the issues
> this series attempted to address.  I am not discounting your opinion that we
> should get rid of huge pmd sharing.  Rather, I would at least like to get
> some eyes on my approach to addressing the issue with reservations during
> fault and truncate races.

Makes sense to me. I agree that we should fix all that. What I
experienced is that the pmd sharing over-complicates the situation quite
a lot and makes the code hard to follow

[huge page reservation is another thing I dislike, especially because
it's no good in NUMA setups and we still have to preallocate huge pages
to make it work reliably]

-- 
Thanks,

David / dhildenb

