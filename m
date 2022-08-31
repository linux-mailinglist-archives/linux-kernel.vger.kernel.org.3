Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA15A8341
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiHaQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiHaQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B026D51E7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661963488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pmEe4DRaxxJzQ4pMfZASLYe1HuEIzWuGYKBiRUg9UA=;
        b=TnJTsP9ReFqvDzpwMspFpLVWi+gEhUw7FcVMsHxc4My9+kzXMkQDIGHVkdTY/EhILxrn1s
        OLlpduwMXBOLQh5zEZJpS1K0VORFaKQJA1OJqTZ8VDIEzzThWkvHrKhB4F4XWSBsWsiiHY
        ho+fY6DLmb1xS4t8RwA8XjO+PwwZUWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-WxA9JAqzPGifzaUhecIMGg-1; Wed, 31 Aug 2022 12:31:26 -0400
X-MC-Unique: WxA9JAqzPGifzaUhecIMGg-1
Received: by mail-wm1-f72.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso11916545wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/pmEe4DRaxxJzQ4pMfZASLYe1HuEIzWuGYKBiRUg9UA=;
        b=NhmNMOVSZH3aeFGHib2w9zGcYqtnCK/j73Ddt9lGWbCWnS1VNFmhhkVFw9bDPdZ5D8
         dzNEQmtrx5J1bGWq763IUqXtY9RgNeYA/1GJIHzzy98qq80MKWi81LwlNvtjTZ3GpNWd
         movQz+J3tyRXDbtDDjMa8pL6DlR0NX1hMIdzAVRnYEZzKL2b/DF/gcPqzdtDqdmsNAMY
         5EBMWuL9EyO0NHeP1JTR9icdUN38JMNPA9S5KieONbnKWJYGpVKVFhysgONR0A8gSrvp
         K8aJjvIB/m629+MWSTiNSQYEL2lRQxM8rLbqP9MtfeACgNlHtJIMcO9zpEIY+dmupt+k
         aHxw==
X-Gm-Message-State: ACgBeo3gi9xAt0bQTlYfMVbnPZhEtpYjEy1RjnARUQ7F9GpjkfsqXgxk
        NFFmDTlu1o621tG/4yyt/ViRvPcuo0mIibHsT8lNVWCav6+rlvaIDvkUQScWtwJ4PoaCR6rs43Z
        XKS4ZPk9PkbW6YvES2iNap5N5
X-Received: by 2002:a5d:5a9a:0:b0:226:e840:c551 with SMTP id bp26-20020a5d5a9a000000b00226e840c551mr3386344wrb.679.1661963484979;
        Wed, 31 Aug 2022 09:31:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4GhqhvTHnUNFTq03uLhSghi7ZyuZ9Tj26NYwUfm6CzIdyk2zRN+Fo1MwvIvsXbKf0v1GUyow==
X-Received: by 2002:a5d:5a9a:0:b0:226:e840:c551 with SMTP id bp26-20020a5d5a9a000000b00226e840c551mr3386326wrb.679.1661963484637;
        Wed, 31 Aug 2022 09:31:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id bg15-20020a05600c3c8f00b003a4f08495b7sm2855208wmb.34.2022.08.31.09.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 09:31:24 -0700 (PDT)
Message-ID: <4d067a99-1112-3b3d-bedf-35c1124904fd@redhat.com>
Date:   Wed, 31 Aug 2022 18:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
 <Yw+KnRTrZ74qFUAA@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
In-Reply-To: <Yw+KnRTrZ74qFUAA@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>> +	/*
>> +	 * We have to make sure that while we clear PageAnonExclusive, that
>> +	 * the page is not pinned and that concurrent GUP-fast won't succeed in
>> +	 * concurrently pinning the page.
>> +	 *
>> +	 * Conceptually, GUP-fast pinning code of anon pages consists of:
>> +	 * (1) Read the PTE
>> +	 * (2) Pin the mapped page
>> +	 * (3) Check if the PTE changed by re-reading it; back off if so.
>> +	 * (4) Check if PageAnonExclusive is not set; back off if so.
>> +	 *
>> +	 * Conceptually, PageAnonExclusive clearing code consists of:
>> +	 * (1) Clear PTE
>> +	 * (2) Check if the page is pinned; back off if so.
>> +	 * (3) Clear PageAnonExclusive
>> +	 * (4) Restore PTE (optional)
>> +	 *
>> +	 * In GUP-fast, we have to make sure that (2),(3) and (4) happen in
>> +	 * the right order. Memory order between (2) and (3) is handled by
>> +	 * GUP-fast, independent of PageAnonExclusive.
>> +	 *
>> +	 * When clearing PageAnonExclusive(), we have to make sure that (1),
>> +	 * (2), (3) and (4) happen in the right order.
>> +	 *
>> +	 * Note that (4) has to happen after (3) in both cases to handle the
>> +	 * corner case whereby the PTE is restored to the original value after
>> +	 * clearing PageAnonExclusive and while GUP-fast might not detect the
>> +	 * PTE change, it will detect the PageAnonExclusive change.
>> +	 *
>> +	 * We assume that there might not be a memory barrier after
>> +	 * clearing/invalidating the PTE (1) and before restoring the PTE (4),
>> +	 * so we use explicit ones here.
>> +	 *
>> +	 * These memory barriers are paired with memory barriers in GUP-fast
>> +	 * code, including gup_must_unshare().
>> +	 */
>> +
>> +	/* Clear/invalidate the PTE before checking for PINs. */
>> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
>> +		smp_mb();
> 
> Wondering whether this could be smp_mb__before_atomic().

We'll read via atomic_read().

That's a non-RMW operation. smp_mb__before_atomic() only applies to
RMW (Read Modify Write) operations.



I have an updated patch with improved description/comments, that includes the
following explanation/example and showcases how the two barrier pairs
interact:


    
            Thread 0 (KSM)                  Thread 1 (GUP-fast)
    
                                            (B1) Read the PTE
                                            # (B2) skipped without FOLL_WRITE
            (A1) Clear PTE
            smb_mb()
            (A2) Check pinned
                                            (B3) Pin the mapped page
                                            smb_mb()
            (A3) Clear PageAnonExclusive
            smb_wmb()
            (A4) Restore PTE
                                            (B4) Check if the PTE changed
                                            smb_rmb()
                                            (B5) Check PageAnonExclusive


> 
>> +
>> +	if (unlikely(page_maybe_dma_pinned(page)))
>> +		return -EBUSY;
>>  	ClearPageAnonExclusive(page);
>> +
>> +	/* Clear PageAnonExclusive() before eventually restoring the PTE. */
>> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
>> +		smp_mb__after_atomic();
>>  	return 0;
>>  }
>>  
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index e9414ee57c5b..2aef8d76fcf2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2140,6 +2140,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  		 *
>>  		 * In case we cannot clear PageAnonExclusive(), split the PMD
>>  		 * only and let try_to_migrate_one() fail later.
>> +		 *
>> +		 * See page_try_share_anon_rmap(): invalidate PMD first.
>>  		 */
>>  		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>>  		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
>> @@ -3177,6 +3179,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>>  
>> +	/* See page_try_share_anon_rmap(): invalidate PMD first. */
>>  	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>>  	if (anon_exclusive && page_try_share_anon_rmap(page)) {
>>  		set_pmd_at(mm, address, pvmw->pmd, pmdval);
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index d7526c705081..971cf923c0eb 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1091,6 +1091,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>>  			goto out_unlock;
>>  		}
>>  
>> +		/* See page_try_share_anon_rmap(): clear PTE first. */
>>  		if (anon_exclusive && page_try_share_anon_rmap(page)) {
>>  			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>>  			goto out_unlock;
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 27fb37d65476..47e955212f15 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -193,20 +193,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>  			bool anon_exclusive;
>>  			pte_t swp_pte;
>>  
> 
> flush_cache_page() missing here?

Hmm, wouldn't that already be missing on the !anon path right now?

> 
> Better copy Alistair too when post formally since this will have a slight
> conflict with the other thread.

Yes, I'll give him a heads-up right away: full patch in
https://lkml.kernel.org/r/68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com


Thanks for having a look Peter1

-- 
Thanks,

David / dhildenb

