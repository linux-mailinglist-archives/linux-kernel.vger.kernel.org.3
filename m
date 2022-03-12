Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8597D4D6D89
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiCLI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCLI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E924B19259C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647073610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOmlxQFnd+zuYEnurfNJceNYzy+E5RZ8J3vmwLJAIl0=;
        b=AP7S5dZVXmOAY1+pNdVzF5NfT3IMMo5bjg4IWA6+BAFIp3PmGOrfLQv/PSqsgYw6zYqGeD
        7T5aHZNDREYEpfZuM6jD96eOwdThYYiZD1SWCrStDOe4uU5ssHzfea0OOF7lMvUGiJ2220
        SW+rwzr5Gig99OCII8b7CKC1309ezBA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-ndcGWc9zNamGHy9AGy_Y1w-1; Sat, 12 Mar 2022 03:26:49 -0500
X-MC-Unique: ndcGWc9zNamGHy9AGy_Y1w-1
Received: by mail-wm1-f71.google.com with SMTP id r133-20020a1c448b000000b00385c3f3defaso3439018wma.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bOmlxQFnd+zuYEnurfNJceNYzy+E5RZ8J3vmwLJAIl0=;
        b=1Zm+2iQO1WgyUgHGA5DFVezdCR6JADzMx7uA6NRJ9GoRC+/a8jQTYqLCj8B5RH84F0
         vD7dXnthfhDoxwUv8INA8xJgEIY+pyNJ0POg2txkWIyVEcMDyhsSI+1d92UeGoGky/7u
         azehdbvlFbn1lCY7m4ZzOvPwAEu9d37Ad/LsBF2xL7PAef+kjoTEbPsNtDfxLRyfFSlJ
         Ol6dzHqOtP83d0+k+bcZbFuVcDXT70P6P31/1iSdS+wU6NrAdJnGBqWHHcMJAOYKGsfZ
         ZBDqZf5KXU97WHOCc9wKOwTWAvcwqELUjAdfl01u9n35anCD/a5N1aN1gwDX6TSms3LC
         B5nQ==
X-Gm-Message-State: AOAM5319P63YQma0sZc//ko76sON+aSSUSw0jFiaYr2w30iR4AgN5iPl
        hHHLFLD0O7t2cYS6VOozFWiD6kX/wTl4wa+0rDQBjnq4ZbnBWpTLMZcP/OzOGCoWfwcnwWvE+pW
        muioDb2i2iz7eiQ0QrY0gzwi8
X-Received: by 2002:adf:fb4e:0:b0:1e3:3e66:d5f6 with SMTP id c14-20020adffb4e000000b001e33e66d5f6mr10234160wrs.615.1647073608154;
        Sat, 12 Mar 2022 00:26:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6pCNrzBS5gHuwSLg45uz9evRExxAsiY3uVCgQXVOVBmSNztNJlOD1/5qe+WlsOx00+9Y93w==
X-Received: by 2002:adf:fb4e:0:b0:1e3:3e66:d5f6 with SMTP id c14-20020adffb4e000000b001e33e66d5f6mr10234131wrs.615.1647073607842;
        Sat, 12 Mar 2022 00:26:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c71e:1600:ad89:c64e:8371:c9c4? (p200300cbc71e1600ad89c64e8371c9c4.dip0.t-ipconnect.de. [2003:cb:c71e:1600:ad89:c64e:8371:c9c4])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm8808771wmb.22.2022.03.12.00.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 00:26:47 -0800 (PST)
Message-ID: <2bbe2f37-37af-664d-181f-034917b6bb93@redhat.com>
Date:   Sat, 12 Mar 2022 09:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
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
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
 <Yiu400H9JNtC03Co@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
In-Reply-To: <Yiu400H9JNtC03Co@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 22:02, Matthew Wilcox wrote:
> On Fri, Mar 11, 2022 at 07:46:39PM +0100, David Hildenbrand wrote:
>> I'm currently testing with the following. My tests so far with a swapfile on
>> all different kinds of weird filesystems (excluding networking fs, though)
>> revealed no surprises so far:
> 
> I like this a lot better than reusing PG_swap.  Thanks!
> 
> I'm somewhat reluctant to introduce a new flag that can be set on tail
> pages.  Do we lose much if it's always set only on the head page?
After spending one month on getting THP to work without PF_ANY, I can
say with confidence that the whole thing won't fly with THP when not
tracking it on the minimum-mapping granularity. For a PTE-mapped THP,
that's on the subpage level.

The next patch in the series documents some details. Intuitively, if we
could replace the pageflag by a PTE/PMD bit, we'd get roughly the same
result.

> 
>> +++ b/include/linux/page-flags.h
>> @@ -142,6 +142,60 @@ enum pageflags {
>>  
>>  	PG_readahead = PG_reclaim,
>>  
>> +	/*
>> +	 * Depending on the way an anonymous folio can be mapped into a page
>> +	 * table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
>> +	 * THP), PG_anon_exclusive may be set only for the head page or for
>> +	 * subpages of an anonymous folio.
>> +	 *
>> +	 * PG_anon_exclusive is *usually* only expressive in combination with a
>> +	 * page table entry. Depending on the page table entry type it might
>> +	 * store the following information:
>> +	 *
>> +	 *	Is what's mapped via this page table entry exclusive to the
>> +	 *	single process and can be mapped writable without further
>> +	 *	checks? If not, it might be shared and we might have to COW.
>> +	 *
>> +	 * For now, we only expect PTE-mapped THPs to make use of
>> +	 * PG_anon_exclusive in subpages. For other anonymous compound
>> +	 * folios (i.e., hugetlb), only the head page is logically mapped and
>> +	 * holds this information.
>> +	 *
>> +	 * For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
>> +	 * set on the head page. When replacing the PMD by a page table full
>> +	 * of PTEs, PG_anon_exclusive, if set on the head page, will be set on
>> +	 * all tail pages accordingly. Note that converting from a PTE-mapping
>> +	 * to a PMD mapping using the same compound page is currently not
>> +	 * possible and consequently doesn't require care.
>> +	 *
>> +	 * If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
>> +	 * it should only pin if the relevant PG_anon_bit is set. In that case,
>> +	 * the pin will be fully reliable and stay consistent with the pages
>> +	 * mapped into the page table, as the bit cannot get cleared (e.g., by
>> +	 * fork(), KSM) while the page is pinned. For anonymous pages that
>> +	 * are mapped R/W, PG_anon_exclusive can be assumed to always be set
>> +	 * because such pages cannot possibly be shared.
>> +	 *
>> +	 * The page table lock protecting the page table entry is the primary
>> +	 * synchronization mechanism for PG_anon_exclusive; GUP-fast that does
>> +	 * not take the PT lock needs special care when trying to clear the
>> +	 * flag.
>> +	 *
>> +	 * Page table entry types and PG_anon_exclusive:
>> +	 * * Present: PG_anon_exclusive applies.
>> +	 * * Swap: the information is lost. PG_anon_exclusive was cleared.
>> +	 * * Migration: the entry holds this information instead.
>> +	 *		PG_anon_exclusive was cleared.
>> +	 * * Device private: PG_anon_exclusive applies.
>> +	 * * Device exclusive: PG_anon_exclusive applies.
>> +	 * * HW Poison: PG_anon_exclusive is stale and not changed.
>> +	 *
>> +	 * If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
>> +	 * not allowed and the flag will stick around until the page is freed
>> +	 * and folio->mapping is cleared.
>> +	 */
> 
> ... I also don't think this is the right place for this comment.  Not
> sure where it should go.

I went for "rather have some documentation at a sub-optimal place then
no documentation at all". I'm thinking about writing a proper
documentation once everything is in place, and moving some details from
there into that document then.

> 
>> +static __always_inline void SetPageAnonExclusive(struct page *page)
>> +{
>> +	VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);
> 
> hm.  seems to me like we should have a PageAnonNotKsm which just
> does
> 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
> 			PAGE_MAPPING_ANON;
> because that's "a bit" inefficient.  OK, that's just a VM_BUG_ON,
> but we have other users in real code:
> 
> mm/migrate.c:   if (PageAnon(page) && !PageKsm(page))
> mm/page_idle.c: need_lock = !PageAnon(page) || PageKsm(page);
> mm/rmap.c:      if (!is_locked && (!PageAnon(page) || PageKsm(page))) {
> 

I'm wondering if the compiler won't be able to optimize that. Having
that said, I can look into adding that outside of this series.

Thanks!

-- 
Thanks,

David / dhildenb

