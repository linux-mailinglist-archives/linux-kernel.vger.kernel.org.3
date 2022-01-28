Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F350149F619
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiA1JSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238113AbiA1JST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643361498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cl9YxSJoJAn9Ygo3if5xmN7enj0GaqFfUdm9RTQ4RmQ=;
        b=UD67Dszo30yLqyu/2MWthj/m+6taTz3RHmhneDORtvuQy0UU8D5TjwXLTB6TR2Mf94x1Oy
        91LkXgJI6q5EnzXjFytGWAL5+K6iyoYhIGT4K+PVyrI273OLTkpd7z5uO003+FDgtYikSy
        1R2+I6SYDBmi6Oi1gTx4gcyjaNPVFiI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-Qn-MtDr7M1KKeCq3s4-kUA-1; Fri, 28 Jan 2022 04:18:17 -0500
X-MC-Unique: Qn-MtDr7M1KKeCq3s4-kUA-1
Received: by mail-ej1-f71.google.com with SMTP id d18-20020a1709063ed200b006a5eeb2ee4dso2596282ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cl9YxSJoJAn9Ygo3if5xmN7enj0GaqFfUdm9RTQ4RmQ=;
        b=tvWODha8r95lIabeKxc6C6kktA0LftdcuoC3yu8MOaXd80SOnA18dl8sx5id6/2uU2
         u8mVmH/yutJhhTlXae9yjIatYD2KEUMzybwwLjG4qjzS6k7McKqNBhu7AmFZDqoSFP+e
         xz0HTPy/qCR+XqeaNmD93gcVKsG/AuQqtxfiVZCJgHPpVAkB5bs79w0gPho0dX/yZXHS
         ChhTSIRl4vOD4vZedMLG5OT69YYWec/7Lkamhaw1YhGcQqKLkgmvZvz6gqerUX56Lfq5
         EogWXY4/LofmhNRZtOHtyYo969b0YTC+xuwh1MLlpgIbJWDpW6CbZjVvUzlEhpkhVTQb
         qCmA==
X-Gm-Message-State: AOAM530zmeGeVKt+t0AH/3jFDeTeEbL7GOhLZnwMIfTqamqHQmqT4lrP
        w+H+jQHJfzcsvJLbbm+lUpZ1eHgEmSqetszzMANcLEYjF3dalknku4HMHddRCHi/4h3w6Tb+i+D
        VmvrCiLN/oe7143upSTWJqJqY
X-Received: by 2002:a17:907:7203:: with SMTP id dr3mr5910087ejc.185.1643361496142;
        Fri, 28 Jan 2022 01:18:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr5ccOaMCWa/+OUIGe1qydBvxUnkxiNemUkFi8NS0fzpW+g89gKF2x+gDoRkyWRswHU+fmCg==
X-Received: by 2002:a17:907:7203:: with SMTP id dr3mr5910068ejc.185.1643361495795;
        Fri, 28 Jan 2022 01:18:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id qf6sm9733468ejc.49.2022.01.28.01.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:18:15 -0800 (PST)
Message-ID: <ef155e64-547b-996b-ece2-212feaabf1cf@redhat.com>
Date:   Fri, 28 Jan 2022 10:18:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/4] mm: Change zap_details.zap_mapping into even_cows
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20220128045412.18695-1-peterx@redhat.com>
 <20220128045412.18695-4-peterx@redhat.com>
 <847ceb80-d379-b704-8b47-0d662468370b@redhat.com>
 <YfO0oRm3I+8We6u1@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YfO0oRm3I+8We6u1@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.22 10:17, Peter Xu wrote:
> On Fri, Jan 28, 2022 at 10:03:20AM +0100, David Hildenbrand wrote:
>> On 28.01.22 05:54, Peter Xu wrote:
>>> Currently we have a zap_mapping pointer maintained in zap_details, when it is
>>> specified we only want to zap the pages that has the same mapping with what the
>>> caller has specified.
>>>
>>> But what we want to do is actually simpler: we want to skip zapping
>>> private (COW-ed) pages in some cases.  We can refer to unmap_mapping_pages()
>>> callers where we could have passed in different even_cows values.  The other
>>> user is unmap_mapping_folio() where we always want to skip private pages.
>>>
>>> According to Hugh, we used a mapping pointer for historical reason, as
>>> explained here:
>>>
>>>   https://lore.kernel.org/lkml/391aa58d-ce84-9d4-d68d-d98a9c533255@google.com/
>>>
>>> Quotting partly from Hugh:
>>
>> s/Quotting/Quoting/
> 
> Will fix.
> 
>>
>>>
>>>   Which raises the question again of why I did not just use a boolean flag
>>>   there originally: aah, I think I've found why.  In those days there was a
>>>   horrible "optimization", for better performance on some benchmark I guess,
>>>   which when you read from /dev/zero into a private mapping, would map the zero
>>>   page there (look up read_zero_pagealigned() and zeromap_page_range() if you
>>>   dare).  So there was another category of page to be skipped along with the
>>>   anon COWs, and I didn't want multiple tests in the zap loop, so checking
>>>   check_mapping against page->mapping did both.  I think nowadays you could do
>>>   it by checking for PageAnon page (or genuine swap entry) instead.
>>>
>>> This patch replaced the zap_details.zap_mapping pointer into the even_cows
>>> boolean, then we check it against PageAnon.
>>>
>>> Suggested-by: Hugh Dickins <hughd@google.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  mm/memory.c | 16 +++++++---------
>>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 14d8428ff4db..ffa8c7dfe9ad 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1309,8 +1309,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>>   * Parameter block passed down to zap_pte_range in exceptional cases.
>>>   */
>>>  struct zap_details {
>>> -	struct address_space *zap_mapping;	/* Check page->mapping if set */
>>>  	struct folio *single_folio;	/* Locked folio to be unmapped */
>>> +	bool even_cows;			/* Zap COWed private pages too? */
>>>  };
>>>  
>>>  /* Whether we should zap all COWed (private) pages too */
>>> @@ -1321,13 +1321,10 @@ static inline bool should_zap_cows(struct zap_details *details)
>>>  		return true;
>>>  
>>>  	/* Or, we zap COWed pages only if the caller wants to */
>>> -	return !details->zap_mapping;
>>> +	return details->even_cows;
>>>  }
>>>  
>>> -/*
>>> - * We set details->zap_mapping when we want to unmap shared but keep private
>>> - * pages. Return true if we should zap this page, false otherwise.
>>> - */
>>> +/* Decides whether we should zap this page with the page pointer specified */
>>>  static inline bool should_zap_page(struct zap_details *details, struct page *page)
>>>  {
>>>  	/* If we can make a decision without *page.. */
>>> @@ -1338,7 +1335,8 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
>>>  	if (!page)
>>>  		return true;
>>>  
>>> -	return details->zap_mapping == page_rmapping(page);
>>> +	/* Otherwise we should only zap non-anon pages */
>>> +	return !PageAnon(page);
>>>  }
>>>  
>>>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>> @@ -3403,7 +3401,7 @@ void unmap_mapping_folio(struct folio *folio)
>>>  	first_index = folio->index;
>>>  	last_index = folio->index + folio_nr_pages(folio) - 1;
>>>  
>>> -	details.zap_mapping = mapping;
>>> +	details.even_cows = false;
>>
>> Already initialized to 0 via struct zap_details details = { };
>>
>> We could think about
>>
>> struct zap_details details = {
>> 	.single_folio = folio,
>> };
>>
>>>  	details.single_folio = folio;
>>>  
>>>  	i_mmap_lock_write(mapping);
>>> @@ -3432,7 +3430,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>>>  	pgoff_t	first_index = start;
>>>  	pgoff_t	last_index = start + nr - 1;
>>>  
>>> -	details.zap_mapping = even_cows ? NULL : mapping;
>>> +	details.even_cows = even_cows;
>>>  	if (last_index < first_index)
>>>  		last_index = ULONG_MAX;
>>>  
>>
>> Eventually
>>
>> struct zap_details details = {
>> 	.even_cows = even_cows,
>> };
> 
> I think in the very initial version I have had that C99 init format but I
> dropped it for some reason, perhaps when rebasing to the single_page work to
> avoid touching the existing code.
> 
> Since as you mentioned single_folio is another.. let's do the cleanup on top?

Sure, why not.


-- 
Thanks,

David / dhildenb

