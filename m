Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002814FFB78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiDMQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiDMQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94711377FB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649867999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0aXMnUhveJJccTOKVcvOAmJYVv7ZueT3l37YMI4RmU=;
        b=aFr9aWKKcSU2elTZdeVg8ctO4mAzkrvjiSpxqK6X6VubcSVmDLsja8fdcdhFEIk6UUBBRs
        qgf2FaXoAeBkpQVoVzkwMmHTvkNA7MTyQ7mi/rpXz9TafSHScoVyCHMsgnCcwLZxh/WE/b
        YmpratRNMhKPOiVrZWJQVxORyTAtErQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-2FOfBH8HOn6kPAOK2hOVZA-1; Wed, 13 Apr 2022 12:39:50 -0400
X-MC-Unique: 2FOfBH8HOn6kPAOK2hOVZA-1
Received: by mail-wm1-f71.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso993422wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=p0aXMnUhveJJccTOKVcvOAmJYVv7ZueT3l37YMI4RmU=;
        b=34nuzf4crH6cPFQmtmpTLtczb+G9AIpRfw1HWFvOPCe7tORc6R5kAOYfXq787QkPKN
         tS75m2pH36/qniqIW/dsPm3j9Lr7W/SVv7Ym14N5/HAORulogQv1nndnExG1r/s20tt5
         QsxPyoBusEBzh1nD8/x7iF+bzGGR1mQs0UEpDiF2aCoD2FeeFRlLQD7SHJNoV+R5BMeC
         FNa8MeLWas1OLFemcwc5v3kwTx2Y3I8oLsM8NAm+Sj4wQKasHDUaUxmKjjVLskq1vfaO
         C8lNnuSKlsJSfVieEGV50NgueG5K1X1XvogF1oZyECeoCRQrEK/Zi+y5S8qtLlO0hQPk
         XEuA==
X-Gm-Message-State: AOAM532YKsSjMw1T+qT+oKwrK+TsnidaTiIjBF/U7Qw2ev+6O7CWVqc9
        XR5SGe88bhSro9MG2YPsjumy6osETuiKrfsBeAxqOzB5QEOHQe1DY1Fu3K5cqCOw22S43UWdb3n
        2lpsHu0GlReG1dx1yT1ra2TsU
X-Received: by 2002:a5d:5846:0:b0:204:1a79:f1ab with SMTP id i6-20020a5d5846000000b002041a79f1abmr32829243wrf.520.1649867989523;
        Wed, 13 Apr 2022 09:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykcbG+BeznZ7c5fNBOejCki5gd90EzDQrV7Yc5yjD4w6+BWn7lmQ7xpzBTxuZ+oGxzZQBwbg==
X-Received: by 2002:a5d:5846:0:b0:204:1a79:f1ab with SMTP id i6-20020a5d5846000000b002041a79f1abmr32829210wrf.520.1649867989192;
        Wed, 13 Apr 2022 09:39:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm3143976wmq.23.2022.04.13.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:39:48 -0700 (PDT)
Message-ID: <2ae0a409-3d6d-9f6a-09e8-2f6867a4069a@redhat.com>
Date:   Wed, 13 Apr 2022 18:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
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
 <20220329160440.193848-13-david@redhat.com>
 <012e3889-563b-e7fc-c2e3-e7a6373a55ac@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 12/16] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
In-Reply-To: <012e3889-563b-e7fc-c2e3-e7a6373a55ac@suse.cz>
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

On 13.04.22 18:28, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
>> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
>> exclusive, and use that information to make GUP pins reliable and stay
>> consistent with the page mapped into the page table even if the
>> page table entry gets write-protected.
>>
>> With that information at hand, we can extend our COW logic to always
>> reuse anonymous pages that are exclusive. For anonymous pages that
>> might be shared, the existing logic applies.
>>
>> As already documented, PG_anon_exclusive is usually only expressive in
>> combination with a page table entry. Especially PTE vs. PMD-mapped
>> anonymous pages require more thought, some examples: due to mremap() we
>> can easily have a single compound page PTE-mapped into multiple page tables
>> exclusively in a single process -- multiple page table locks apply.
>> Further, due to MADV_WIPEONFORK we might not necessarily write-protect
>> all PTEs, and only some subpages might be pinned. Long story short: once
>> PTE-mapped, we have to track information about exclusivity per sub-page,
>> but until then, we can just track it for the compound page in the head
>> page and not having to update a whole bunch of subpages all of the time
>> for a simple PMD mapping of a THP.
>>
>> For simplicity, this commit mostly talks about "anonymous pages", while
>> it's for THP actually "the part of an anonymous folio referenced via
>> a page table entry".
>>
>> To not spill PG_anon_exclusive code all over the mm code-base, we let
>> the anon rmap code to handle all PG_anon_exclusive logic it can easily
>> handle.
>>
>> If a writable, present page table entry points at an anonymous (sub)page,
>> that (sub)page must be PG_anon_exclusive. If GUP wants to take a reliably
>> pin (FOLL_PIN) on an anonymous page references via a present
>> page table entry, it must only pin if PG_anon_exclusive is set for the
>> mapped (sub)page.
>>
>> This commit doesn't adjust GUP, so this is only implicitly handled for
>> FOLL_WRITE, follow-up commits will teach GUP to also respect it for
>> FOLL_PIN without !FOLL_WRITE, to make all GUP pins of anonymous pages
> 
> 	   without FOLL_WRITE ?

Indeed, thanks.

> 
>> fully reliable.
> 
> <snip>
> 
>> @@ -202,11 +203,26 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
>>  	return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
>>  }
>>  
>> +static inline int is_readable_migration_entry(swp_entry_t entry)
>> +{
>> +	return unlikely(swp_type(entry) == SWP_MIGRATION_READ);
>> +}
>> +
>> +static inline int is_readable_exclusive_migration_entry(swp_entry_t entry)
>> +{
>> +	return unlikely(swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE);
>> +}
> 
> This one seems to be missing a !CONFIG_MIGRATION counterpart. Although the
> only caller __split_huge_pmd_locked() probably indirectly only exists with
> CONFIG_MIGRATION so it's not an immediate issue.  (THP selects COMPACTION
> selects MIGRATION)

So far no builds bailed out. And yes, I think it's for the reason
stated. THP without compaction would be a lost bet.

> 
> <snip>
> 
>> @@ -3035,10 +3083,19 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>  
>>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>> +
>> +	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>> +	if (anon_exclusive && page_try_share_anon_rmap(page)) {
>> +		set_pmd_at(mm, address, pvmw->pmd, pmdval);
>> +		return;
> 
> I am admittedly not too familiar with this code, but looks like this means
> we fail to migrate the THP, right? But we don't seem to be telling the
> caller, which is try_to_migrate_one(), so it will continue and not terminate
> the walk and return false?

Right, we're not returning "false". Returning "false" would be an
optimization to make rmap_walk_anon() fail faster.

But, after all, the THP is exclusive (-> single mapping), so
anon_vma_interval_tree_foreach() would most probably not have a lot work
to do either way I'd assume?

In  any case, once we return from try_to_migrate(), the page will still
be mapped.

-- 
Thanks,

David / dhildenb

