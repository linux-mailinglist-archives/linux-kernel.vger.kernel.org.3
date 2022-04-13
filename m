Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE04FF4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiDMKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiDMKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D087F483B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649845700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cvessJekG7n0XRzYWC8tIHQh00KK0c1sN5UMgfc5VQ=;
        b=ahzt2YcY3ae82eZsYPB9zjeHSNsms0T3GEpRgocyWsxDlK2FNP8oqhEt+pd2tTQ61Vzqcg
        6S01L0hjVmPibGG8zPNkCY/4ZEGJjua3pizhF2B8I8EpkWftjCkQrlh+XgEiU+zeuJbRk6
        zjxKf9WAwfZkdAlLQsLYbDXZUzYOtws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-_DdIHpkaOS-eh7ocPApebA-1; Wed, 13 Apr 2022 06:28:19 -0400
X-MC-Unique: _DdIHpkaOS-eh7ocPApebA-1
Received: by mail-wm1-f71.google.com with SMTP id l19-20020a05600c1d1300b0038e736f98faso711520wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9cvessJekG7n0XRzYWC8tIHQh00KK0c1sN5UMgfc5VQ=;
        b=WKBK5KvoYSyF8DOz0DZcv5V15G4O5W3auyHKXQ+ny/C9jG1FnXHOI2ynmXGEbuRSDG
         6J8dZAmBK7XdBfFxddn7Oq6UivTslRc7wWkY1/RRr3u6CxUD+gxOry/hlef2ewe2k6sd
         D73GFi+XdYodN9Ft2zzb7mTwsqclb5Pxq5dBgqJj0nRFohJkB3z25OAKOIM5IHnc36SM
         aly+phamc3Txe5DhAw25SSIimVQg9GnLff0xQ9hbUuhaBiypUCheJ2+jmOQ58LHcl7tv
         Wa3CgQ64AeSdJ2X3JxXIdo8jdsty8lgv5MRbSRuaN85tHtw76GyxrEyfws70IDidVChw
         bVXg==
X-Gm-Message-State: AOAM531s8frNjgRzOC3yrHU/hHxE9q8cMJQ/gxnmL/GOF86ejbS8FvU8
        aiXNz9f/XqqCYvK1aRKuKzWtxkrWD6x/9nXpvFl8ECaJcT8gLaQUOI6fmryeJBlIjfS7npTMAV5
        dbw7gA57P+JPQn0EQZ2TrPqtB
X-Received: by 2002:adf:fb48:0:b0:203:f986:874a with SMTP id c8-20020adffb48000000b00203f986874amr31815052wrs.614.1649845698380;
        Wed, 13 Apr 2022 03:28:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDjAyzY9+bbZ4QmogJ/ZGciXVpxXUjcRfRJYBteQAreyavACUuv0Zv0uFkHtPAw+KcIuCsvw==
X-Received: by 2002:adf:fb48:0:b0:203:f986:874a with SMTP id c8-20020adffb48000000b00203f986874amr31815021wrs.614.1649845697983;
        Wed, 13 Apr 2022 03:28:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c320900b0038f0894d80csm866511wmp.7.2022.04.13.03.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:28:17 -0700 (PDT)
Message-ID: <e015a477-89df-5eb1-5fec-b1108c18e4a4@redhat.com>
Date:   Wed, 13 Apr 2022 12:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 11/16] mm/page-flags: reuse PG_mappedtodisk as
 PG_anon_exclusive for PageAnon() pages
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
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
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-12-david@redhat.com>
 <84c0bcbb-5c8f-d3b2-2a8c-d68462d0bc04@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <84c0bcbb-5c8f-d3b2-2a8c-d68462d0bc04@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 10:25, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
>> The basic question we would like to have a reliable and efficient answer
>> to is: is this anonymous page exclusive to a single process or might it
>> be shared? We need that information for ordinary/single pages, hugetlb
>> pages, and possibly each subpage of a THP.
>>
>> Introduce a way to mark an anonymous page as exclusive, with the
>> ultimate goal of teaching our COW logic to not do "wrong COWs", whereby
>> GUP pins lose consistency with the pages mapped into the page table,
>> resulting in reported memory corruptions.
>>
>> Most pageflags already have semantics for anonymous pages, however,
>> PG_mappedtodisk should never apply to pages in the swapcache, so let's
>> reuse that flag.
>>
>> As PG_has_hwpoisoned also uses that flag on the second tail page of a
>> compound page, convert it to PG_error instead, which is marked as
>> PF_NO_TAIL, so never used for tail pages.
>>
>> Use custom page flag modification functions such that we can do
>> additional sanity checks. The semantics we'll put into some kernel doc
>> in the future are:
>>
>> "
>>   PG_anon_exclusive is *usually* only expressive in combination with a
>>   page table entry. Depending on the page table entry type it might
>>   store the following information:
>>
>>        Is what's mapped via this page table entry exclusive to the
>>        single process and can be mapped writable without further
>>        checks? If not, it might be shared and we might have to COW.
>>
>>   For now, we only expect PTE-mapped THPs to make use of
>>   PG_anon_exclusive in subpages. For other anonymous compound
>>   folios (i.e., hugetlb), only the head page is logically mapped and
>>   holds this information.
>>
>>   For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
>>   set on the head page. When replacing the PMD by a page table full
>>   of PTEs, PG_anon_exclusive, if set on the head page, will be set on
>>   all tail pages accordingly. Note that converting from a PTE-mapping
>>   to a PMD mapping using the same compound page is currently not
>>   possible and consequently doesn't require care.
>>
>>   If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
>>   it should only pin if the relevant PG_anon_bit is set. In that case,
> 
> 					^ PG_anon_exclusive bit ?
> 
>>   the pin will be fully reliable and stay consistent with the pages
>>   mapped into the page table, as the bit cannot get cleared (e.g., by
>>   fork(), KSM) while the page is pinned. For anonymous pages that
>>   are mapped R/W, PG_anon_exclusive can be assumed to always be set
>>   because such pages cannot possibly be shared.
>>
>>   The page table lock protecting the page table entry is the primary
>>   synchronization mechanism for PG_anon_exclusive; GUP-fast that does
>>   not take the PT lock needs special care when trying to clear the
>>   flag.
>>
>>   Page table entry types and PG_anon_exclusive:
>>   * Present: PG_anon_exclusive applies.
>>   * Swap: the information is lost. PG_anon_exclusive was cleared.
>>   * Migration: the entry holds this information instead.
>>                PG_anon_exclusive was cleared.
>>   * Device private: PG_anon_exclusive applies.
>>   * Device exclusive: PG_anon_exclusive applies.
>>   * HW Poison: PG_anon_exclusive is stale and not changed.
>>
>>   If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
>>   not allowed and the flag will stick around until the page is freed
>>   and folio->mapping is cleared.
> 
> Or also if it's unpinned?

I'm afraid I didn't get your question. Once the page is no longer
pinned, we can succeed in clearing PG_anon_exclusive (just like pinning
never happened). Does that answer your question?

> 
>> "
>>
>> We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
>> zapping) of page table entries, page freeing code will handle that when
>> also invalidate page->mapping to not indicate PageAnon() anymore.
>> Letting information about exclusivity stick around will be an important
>> property when adding sanity checks to unpinning code.
>>
>> Note that we properly clear the flag in free_pages_prepare() via
>> PAGE_FLAGS_CHECK_AT_PREP for each individual subpage of a compound page,
>> so there is no need to manually clear the flag.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> 
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3663,6 +3663,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  		goto out_nomap;
>>  	}
>>  
>> +	/*
>> +	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>> +	 * must never point at an anonymous page in the swapcache that is
>> +	 * PG_anon_exclusive. Sanity check that this holds and especially, that
>> +	 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
>> +	 * check after taking the PT lock and making sure that nobody
>> +	 * concurrently faulted in this page and set PG_anon_exclusive.
>> +	 */
>> +	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>> +	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
>> +
> 
> Hmm, dunno why not VM_BUG_ON?

Getting PageAnonExclusive accidentally set by a file system would result
in an extremely unpleasant security issue. I most surely want to catch
something like that in any case, especially in the foreseeable future.

-- 
Thanks,

David / dhildenb

