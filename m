Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9949F575
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbiA1IlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232136AbiA1IlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643359281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZoOlUeTcIB3lde6agUIzDy5+c2Kj0vOnYJNRZPTSdL4=;
        b=akm9+BmFfw4+SymGGiuDjA//xG/hI5HvaAGQ1wr9ANlVPO1OMMqB+6Okpmk6ir0L0BwfT9
        9x2y/2cLRx0CaJ3eBbHM9pPtmb80jmby26JIE3DdAKIG3jOuQyOx2HbxY3ZEx4oHoNJDiX
        Na8eMlfYnoo39MJHVjzODzIQuV2dMlU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-nNApc-HJP5qRgbGOPvgBjA-1; Fri, 28 Jan 2022 03:41:20 -0500
X-MC-Unique: nNApc-HJP5qRgbGOPvgBjA-1
Received: by mail-wm1-f69.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so4785712wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZoOlUeTcIB3lde6agUIzDy5+c2Kj0vOnYJNRZPTSdL4=;
        b=B0ROMEYVBKFglwty45rBVPB/VNJA3PXj5a1cI47IcWp5mITGXy3hYr+unA8AI8Eblx
         uIXlCZK0AHOxGSjpaatnk3OsVjyM+ml+08RRlV38mziqS/NbwdiMo2L+almm7eMI6KsQ
         kWF05ml3z/XnFGfiqRauWdDI/OrJWBsL6X1zfT/z+M5EG9Jncgf2WL74NuvQ2BVDk6Gs
         6IhIgkp0voeFxoFFxWsupFJOkgIbx7nU1cuoJcNOZFZ9eR7z/g57OSk2ZqTgOQsyWnSX
         BxfszuW/8mZtM/sj/0YiV0ck0RhaJxQQeF0Ti8RIz1cRqnsbzh6nSjEHHMRRqGnxeo3z
         tsAw==
X-Gm-Message-State: AOAM530yBswVQ+E3wtxgsFX0g039Dfdt2i2FTNDAQxtsU3jBZ3h/2/tb
        oN7bK3wXQnNAUtJEYC+eLI7G7YIVxG7oFdffawwGWo6MrPs4BB04Jk8vDh0XuHqZg01Skh+3/oi
        vKHVGw3zWoAJfbhuvw5zADM+Z
X-Received: by 2002:a05:600c:3d10:: with SMTP id bh16mr6696129wmb.127.1643359278851;
        Fri, 28 Jan 2022 00:41:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDYshvnGcRSoQjNBBVvUbNaeHYsPPNmiz9uM5jWeFmAZDN6EGM2Es8WGNrnAHlANkpfhkOFQ==
X-Received: by 2002:a05:600c:3d10:: with SMTP id bh16mr6696103wmb.127.1643359278632;
        Fri, 28 Jan 2022 00:41:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id h127sm17207297wmh.2.2022.01.28.00.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:41:17 -0800 (PST)
Message-ID: <205231d0-2b4e-7d93-1028-2d501c1cbf74@redhat.com>
Date:   Fri, 28 Jan 2022 09:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
        Linux MM <linux-mm@kvack.org>
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-7-david@redhat.com>
 <CAHbLzkpRgeYkPHUc3KAUc_Fr-YexQxK1cH92Suueac5GrwZHsw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 6/9] mm/khugepaged: remove reuse_swap_page() usage
In-Reply-To: <CAHbLzkpRgeYkPHUc3KAUc_Fr-YexQxK1cH92Suueac5GrwZHsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 22:23, Yang Shi wrote:
> On Wed, Jan 26, 2022 at 2:00 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> reuse_swap_page() currently indicates if we can write to an anon page
>> without COW. A COW is required if the page is shared by multiple
>> processes (either already mapped or via swap entries) or if there is
>> concurrent writeback that cannot tolerate concurrent page modifications.
>>
>> reuse_swap_page() doesn't check for pending references from other
>> processes that already unmapped the page, however,
>> is_refcount_suitable() essentially does the same thing in the context of
>> khugepaged. khugepaged is the last remaining user of reuse_swap_page() and
>> we want to remove that function.
>>
>> In the context of khugepaged, we are not actually going to write to the
>> page and we don't really care about other processes mapping the page:
>> for example, without swap, we don't care about shared pages at all.
>>
>> The current logic seems to be:
>> * Writable: -> Not shared, but might be in the swapcache. Nobody can
>>   fault it in from the swapcache as there are no other swap entries.
>> * Readable and not in the swapcache: Might be shared (but nobody can
>>   fault it in from the swapcache).
>> * Readable and in the swapcache: Might be shared and someone might be
>>   able to fault it in from the swapcache. Make sure we're the exclusive
>>   owner via reuse_swap_page().
>>
>> Having to guess due to lack of comments and documentation, the current
>> logic really only wants to make sure that a page that might be shared
>> cannot be faulted in from the swapcache while khugepaged is active.
>> It's hard to guess why that is that case and if it's really still required,
>> but let's try keeping that logic unmodified.
> 
> I don't think it could be faulted in while khugepaged is active since
> khugepaged does hold mmap_lock in write mode IIUC. So page fault is
> serialized against khugepaged.

It could get faulted in by another process sharing the page, because we 
only synchronize against the current process.

> 
> My wild guess is that collapsing shared pages was not supported before
> v5.8, so we need reuse_swap_page() to tell us if the page in swap
> cache is shared or not. But it is not true anymore. And khugepaged
> just allocates a THP then copy the data from base pages to huge page
> then replace PTEs to PMD, it doesn't change the content of the page,
> so I failed to see a problem by collapsing a shared page in swap
> cache. But I'm really not entirely sure, I may miss something...


Looking more closely where this logic originates from, it was introduced in:

commit 10359213d05acf804558bda7cc9b8422a828d1cd
Author: Ebru Akagunduz <ebru.akagunduz@gmail.com>
Date:   Wed Feb 11 15:28:28 2015 -0800

    mm: incorporate read-only pages into transparent huge pages
    
    This patch aims to improve THP collapse rates, by allowing THP collapse in
    the presence of read-only ptes, like those left in place by do_swap_page
    after a read fault.
    
    Currently THP can collapse 4kB pages into a THP when there are up to
    khugepaged_max_ptes_none pte_none ptes in a 2MB range.  This patch applies
    the same limit for read-only ptes.


The change essentially results in a read-only mapped PTE page getting copied and
mapped writable via a new PMD-mapped THP.

It mentions do_swap_page(), so I assume it just tried to do what do_swap_page()
would do when trying to map a page swapped in from the page cache writable
immediately.

But we differ from do_swap_page() that we're not actually going to map the page
writable, we're going to copy the page (__collapse_huge_page_copy()) and map
the copy writable.

I assume we can remove that logic.

-- 
Thanks,

David / dhildenb

