Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40C6509C00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387522AbiDUJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387454AbiDUJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1372A2316F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650532543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FjbrFR2rd1qLIkWt8BR0K+aE+G8bE2tFsHPUNoUm3Lc=;
        b=hmSaCi6DwQQY067bXu94TH9vyWHG9tadoQgkTmd9mBTWJoCf2g5D8hkhfBzARygYIgYNhE
        bHq7sUdrzwnnb5fPYwVCbZBcvw2kCkYxCgoFkZaE6JQyppli+VbUJJrYO2oE85xOAS0AQp
        Z3OQXjJf2pi6f9r2oPeOOToRfZYRUFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-jZZ2xSoCOKG4r1iW8E6ZBQ-1; Thu, 21 Apr 2022 05:15:42 -0400
X-MC-Unique: jZZ2xSoCOKG4r1iW8E6ZBQ-1
Received: by mail-wm1-f72.google.com with SMTP id b12-20020a05600c4e0c00b003914432b970so2156868wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=FjbrFR2rd1qLIkWt8BR0K+aE+G8bE2tFsHPUNoUm3Lc=;
        b=HEyXDaoB3ND5qRllYHMC+8bCSHGxLeI2CgEfM52OnZBQEuJ1ndrLNy90AAcSZ865mp
         BPSoDGrDFgmJMv7lFxOPmgSk2ox9YX5lQzwfoHEBGv9yYtHav5/XGvd0g4kEzES0Rt+T
         svB0RdJ2iksRZ3I2+dpB8Fc9yA+OXNsSTn+ZXpTFNrZ2rK+QHtkkjZ+ruX8utYM131Wx
         h9GFv2DfrDOlFn57C1lOIOZdUSJZ8kTIpySGOUD6NRL866AFs1eYBX4lMKMqDgZ5uIRm
         jNuy1R2HZ2ZQYMpsBwmCVa1MlsLEfx2ey86xSCYqFZa+6eaOOZs2K11XKQ14N49s3eo8
         H7Zw==
X-Gm-Message-State: AOAM532+vdU14HjZ4d3J8m2vH8ICL5IEUfIFfu5D8gmlZ5y7yAipbyq/
        oKoISLesUjVIkfMNbiXfPbfYCgPmrMokBfrkQugkRzvckmID8JtMQ1x7vLZdan0edekCvoo9CBd
        A/DqtiTB87dJACKrZyMuzq0oz
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr7420574wmk.109.1650532541081;
        Thu, 21 Apr 2022 02:15:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybhViWdGUkp8BlFKuS91mClSpg6lIAaDSHqaAhU8UVIOCqoiWdlZ9Z1I212vYDASNuQITD4g==
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr7420518wmk.109.1650532540774;
        Thu, 21 Apr 2022 02:15:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id r17-20020a0560001b9100b00207afaa8987sm2160122wru.27.2022.04.21.02.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 02:15:40 -0700 (PDT)
Message-ID: <31b37b7c-a969-eec2-bdff-a7e4dca9b770@redhat.com>
Date:   Thu, 21 Apr 2022 11:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 16/16] mm/gup: sanity-check with CONFIG_DEBUG_VM that
 anonymous pages are exclusive when (un)pinning
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
 <20220329160440.193848-17-david@redhat.com>
 <be2c1ad4-1557-677e-dfd8-2089c98fe85d@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <be2c1ad4-1557-677e-dfd8-2089c98fe85d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 19:40, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
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
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nits:
> 
>> @@ -510,6 +563,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>  		page = ERR_PTR(-EMLINK);
>>  		goto out;
>>  	}
>> +
>> +	VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
>> +		  !PageAnonExclusive(page));
> 
> Do we rather want VM_BUG_ON_PAGE? Also for the same tests in mm/huge*.c below.

Make sense, thanks:

diff --git a/mm/gup.c b/mm/gup.c
index 5c17d4816441..46ffd8c51c6e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -564,8 +564,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
                goto out;
        }
 
-       VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
-                 !PageAnonExclusive(page));
+       VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+                      !PageAnonExclusive(page), page);
 
        /* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
        if (unlikely(!try_grab_page(page, flags))) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 390f22334ee9..a2f44d8d3d47 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1392,8 +1392,8 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
        if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
                return ERR_PTR(-EMLINK);
 
-       VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
-                 !PageAnonExclusive(page));
+       VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+                       !PageAnonExclusive(page), page);
 
        if (!try_grab_page(page, flags))
                return ERR_PTR(-ENOMEM);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8a635b5b5270..0ba2b1930b21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6100,8 +6100,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
                pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
                page = pte_page(huge_ptep_get(pte));
 
-               VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
-                         !PageAnonExclusive(page));
+               VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+                              !PageAnonExclusive(page), page);
 
                /*
                 * If subpage information not requested, update counters



-- 
Thanks,

David / dhildenb

