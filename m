Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498B649CC74
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiAZOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235530AbiAZOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643207811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSCdq2HiaIlQL8PtJ4qbPosx+p7d/L8aRu/9I6dFWmQ=;
        b=Kd1dWi0Iq77VwJB/pEYAX3c5lcerKFGjscHSkfpercbWVZKn8U8J+3KwbJxusaZi5lPXjd
        3HAcUYhXqDpjRZ+ZF5RapPsoW7ngUx0NHRw4nx4ZwHfIeeNr9Dk0u57Re9z4/vl5Vr51c8
        mWli/WwAIgYVgcv1zb8S7333bC7Iq3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-SaN36L_vOZKcsJWlpmuxcA-1; Wed, 26 Jan 2022 09:36:50 -0500
X-MC-Unique: SaN36L_vOZKcsJWlpmuxcA-1
Received: by mail-wm1-f72.google.com with SMTP id ay8-20020a05600c1e0800b00350de81da56so633836wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KSCdq2HiaIlQL8PtJ4qbPosx+p7d/L8aRu/9I6dFWmQ=;
        b=TLfzyvXpvE8riwCNi7RsYDahx6wu0DKup/lmNRRINpFoX5gTLI0JCEg2QH4SaX+g9q
         4eaVknJhBPRh9NGG0EBF/z8Uz3EoeAljYDfaOnX87Y6cDtqT0efT1LZ9LRwC0pntSz8d
         kBE6/aG90HAUTg06DliCssVLR1UoZASJKVTDQPEO5JyU0wCckt57Hu81QtcJNhWVbDaa
         /tcQ3zh5zRNyqAI1XBw0A9yLJVKP9r9myWksJFvdgmlsaszal4b2uwSq/iG1QKoxCfWD
         a5MgiYdBIvZOT7DXgD+kV8aV7CySgfPuaPFS8jS8cmtwXV3H+xp0DHqg1RZsVn23zzCq
         GQig==
X-Gm-Message-State: AOAM5301Bo0a5zeioAUx+yQkVcHNUXLxPjnh8Nrc1uhWPsfCJ8Xcpz3P
        jkqPHItoGyUIRvjwCAXynhdeoBzRTpimpu940Xeklpm8gjDmX2IafxAh/sCUVwP3lwxZlwJLlMb
        8RK+c3hPZJtZS6HraTj3xtF4d
X-Received: by 2002:a05:600c:3550:: with SMTP id i16mr7780944wmq.17.1643207804695;
        Wed, 26 Jan 2022 06:36:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDZQP/GItwQ2iSU2jMAigVtCfjFz0ZQfMmT1SOvbAH3coXblDd/rStpTrddHx4KFzd916moA==
X-Received: by 2002:a05:600c:3550:: with SMTP id i16mr7780918wmq.17.1643207804474;
        Wed, 26 Jan 2022 06:36:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id w8sm20054277wre.83.2022.01.26.06.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:36:43 -0800 (PST)
Message-ID: <683d7a13-70a5-6ba9-e290-9ac4db309535@redhat.com>
Date:   Wed, 26 Jan 2022 15:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v2 2/9] mm: optimize do_wp_page() for fresh pages in
 local LRU pagevecs
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-3-david@redhat.com>
 <YfFbOypqMjkeNA3q@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YfFbOypqMjkeNA3q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 15:31, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 10:55:50AM +0100, David Hildenbrand wrote:
>> diff --git a/mm/memory.c b/mm/memory.c
>> index bcd3b7c50891..61d67ceef734 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3298,7 +3298,17 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>  		 *
>>  		 * PageKsm() doesn't necessarily raise the page refcount.
>>  		 */
>> -		if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
>> +		if (PageKsm(page))
>> +			goto copy;
>> +		if (page_count(page) > 1 + PageSwapCache(page) + !PageLRU(page))
>> +			goto copy;
>> +		if (!PageLRU(page))
>> +			/*
>> +			 * Note: We cannot easily detect+handle references from
>> +			 * remote LRU pagevecs or references to PageLRU() pages.
>> +			 */
>> +			lru_add_drain();
>> +		if (page_count(page) > 1 + PageSwapCache(page))
>>  			goto copy;
> 
> I worry we're starting to get too accurate here.  How about:
> 

In that simplified case we'll essentially trylock_page() and for most
pages that are ordinarily shared by e.g., 2 processes.

> 		if (PageKsm(page) || page_count(page) > 3)
> 			goto copy;
> 		if (!PageLRU(page))
> 			lru_add_drain();
> 		if (!trylock_page(page))
> 			goto copy;
> ...
> 

I think we might at least want the

if (page_count(page) > 1 + PageSwapCache(page))
	goto copy;

check here.

>>  		if (!trylock_page(page))
>>  			goto copy;
>> -- 
>> 2.34.1
>>
> 


-- 
Thanks,

David / dhildenb

