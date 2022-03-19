Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539C4DE76D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiCSKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiCSKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22ECF7B123
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647685353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYzCtz1CNfRKahEjWPEJ8iTJHu5ovNDwPIFtJOiY5m4=;
        b=Y+TNcU86pPl1RyVzSzYJ5YGhbPOowTHIzjGWZ78D3wQ9LqRxvgUtvCcK0VoicFLqUhGH2B
        4Koekf6nki1Kni/TEvLcaimcDd423YLgUe9j6m/e3WrO+pRthaeYi7CeGngeNzH28HiFZk
        f7M5JDUHmqBGKlxF0/coxSiVyEwLWfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-cn87F-O3OvmjSGXDJWUysg-1; Sat, 19 Mar 2022 06:22:31 -0400
X-MC-Unique: cn87F-O3OvmjSGXDJWUysg-1
Received: by mail-wm1-f70.google.com with SMTP id i6-20020a1c5406000000b0038c97ed0db5so290731wmb.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eYzCtz1CNfRKahEjWPEJ8iTJHu5ovNDwPIFtJOiY5m4=;
        b=CND5YNla8NM3M8D6XxDGpRAHCKQX2eSUmSQw4Bxn0CU0eOjFzqtUJJFMJoD+Rk72CH
         MEQrXEHPMYAu4K1yXIzEJB5dFol6cXLdii2vtdGpQ09K7xSqxqdCM9lR39YoIopPPdZP
         AnFtqzWrEWfn014pGxMjGVTyj4D6zAB0MrA0+RVyGksSzwC1FfteRKjfHR2Q/zZg9pGX
         gPzawnMJW0JPuMbdkAoJv+or1KXHoOPZ8LAa2GcKQJd0bDJ8dy19/aHxoGhtvxiXPpX3
         5cvh57WsCZfYRSvbqbMOtnt0R08lYPlvK1JIe4PvlqMEC9YjdnBOpjfvEBP4+4J6Qvsb
         BYyg==
X-Gm-Message-State: AOAM533If9cmRhSgpPzih66cdqPrH1z057SaWPRyF+lcZd8kZeVFmIEI
        ZLC2f6M74nsSHWLpAGGzdaurO7Sxla+bxGU30IJlcPbmli+3wvQF0g4cali8PbSw9qgCEuIxbpf
        YKdMskjPfX65L1gIGWuAyFA1+
X-Received: by 2002:adf:fd02:0:b0:203:f2aa:37f2 with SMTP id e2-20020adffd02000000b00203f2aa37f2mr7569839wrr.396.1647685350472;
        Sat, 19 Mar 2022 03:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfG/V414ObjvO0GfXKiNYm84GOq5X2QUhUrz5EcUsvg2AQ/ehs8iwkMJnK9/RAUcodn+cBtg==
X-Received: by 2002:adf:fd02:0:b0:203:f2aa:37f2 with SMTP id e2-20020adffd02000000b00203f2aa37f2mr7569816wrr.396.1647685350211;
        Sat, 19 Mar 2022 03:22:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm12327769wmj.5.2022.03.19.03.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 03:22:29 -0700 (PDT)
Message-ID: <0178ec26-f957-159d-a163-a98557de7156@redhat.com>
Date:   Sat, 19 Mar 2022 11:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 15/15] mm/gup: sanity-check with CONFIG_DEBUG_VM that
 anonymous pages are exclusive when (un)pinning
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-16-david@redhat.com>
 <20220318233527.GB11336@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220318233527.GB11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.22 00:35, Jason Gunthorpe wrote:
> On Tue, Mar 15, 2022 at 11:47:41AM +0100, David Hildenbrand wrote:
>> Let's verify when (un)pinning anonymous pages that we always deal with
>> exclusive anonymous pages, which guarantees that we'll have a reliable
>> PIN, meaning that we cannot end up with the GUP pin being inconsistent
>> with he pages mapped into the page tables due to a COW triggered
>> by a write fault.
>>
>> When pinning pages, after conditionally triggering GUP unsharing of
>> possibly shared anonymous pages, we should always only see exclusive
>> anonymous pages. Note that anonymous pages that are mapped writable
>> must be marked exclusive, otherwise we'd have a BUG.
>>
>> When pinning during ordinary GUP, simply add a check after our
>> conditional GUP-triggered unsharing checks. As we know exactly how the
>> page is mapped, we know exactly in which page we have to check for
>> PageAnonExclusive().
>>
>> When pinning via GUP-fast we have to be careful, because we can race with
>> fork(): verify only after we made sure via the seqcount that we didn't
>> race with concurrent fork() that we didn't end up pinning a possibly
>> shared anonymous page.
>>
>> Similarly, when unpinning, verify that the pages are still marked as
>> exclusive: otherwise something turned the pages possibly shared, which
>> can result in random memory corruptions, which we really want to catch.
>>
>> With only the pinned pages at hand and not the actual page table entries
>> we have to be a bit careful: hugetlb pages are always mapped via a
>> single logical page table entry referencing the head page and
>> PG_anon_exclusive of the head page applies. Anon THP are a bit more
>> complicated, because we might have obtained the page reference either via
>> a PMD or a PTE -- depending on the mapping type we either have to check
>> PageAnonExclusive of the head page (PMD-mapped THP) or the tail page
>> (PTE-mapped THP) applies: as we don't know and to make our life easier,
>> check that either is set.
>>
>> Take care to not verify in case we're unpinning during GUP-fast because
>> we detected concurrent fork(): we might stumble over an anonymous page
>> that is now shared.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>  mm/gup.c         | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  mm/huge_memory.c |  3 +++
>>  mm/hugetlb.c     |  3 +++
>>  3 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 92dcd92f9d67..72e39b77da10 100644
>> +++ b/mm/gup.c
>> @@ -45,6 +45,38 @@ static void hpage_pincount_sub(struct page *page, int refs)
>>  	atomic_sub(refs, compound_pincount_ptr(page));
>>  }
>>  
>> +static inline void sanity_check_pinned_pages(struct page **pages,
>> +					     unsigned long npages)
>> +{
>> +#ifdef CONFIG_DEBUG_VM
> 
> Perhaps:
> 
> if (!IS_ENABLED(CONFIG_DEBUG_VM))
>    return;
> 
> So this gets compilation coverage

Makes sense, that code should compile just fine without CONFIG_DEBUG_VM.
Thanks!

-- 
Thanks,

David / dhildenb

