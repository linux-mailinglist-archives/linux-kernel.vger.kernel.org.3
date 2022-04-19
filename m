Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385FB5075CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355263AbiDSQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352787AbiDSQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C41015A28
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650386807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kufMCAz2neGn2snaxjHP25oQFrCvrJLIg2rPe9CbRw=;
        b=gcV6GFrgVzchiRJkfobT3lJxCkXeDZEPYDXCAFuUi8ygYaNgXm3KPlfpPFy3MuRvMsBGo/
        U2k6vw4a67pa1g6MrMRIaO4P6yDZ3VaLGXOXL6ujqKa49zNgN/alAA4AfcXmixb8RC3tM8
        IvFG7hJA/CxvBeBLirEeIZL2dkyPbWk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-NlzJfvUoORqb05sFYPXajg-1; Tue, 19 Apr 2022 12:46:46 -0400
X-MC-Unique: NlzJfvUoORqb05sFYPXajg-1
Received: by mail-wr1-f71.google.com with SMTP id j30-20020adfb31e000000b0020a9043abd7so822074wrd.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9kufMCAz2neGn2snaxjHP25oQFrCvrJLIg2rPe9CbRw=;
        b=p7hFCLDN00cni8juM0aVnT9fXVlQclZ44pKKnaC4NpsFZL8jwAE77gXVBjMh14rCkt
         pqeFyJuAXmHhUbAIMbvFjMYiZaescuiLA3T6Sb//dcUuufRppu19I6uxRPDjHws6AYRi
         8z1eNFR4QXUHjxoCK3o7zC1IxDsRLUNof+hVfEhUK2ZM0R+pFv4nZLSegpQcWZu+I7/y
         e3ArIWEHvdwyUn3ib/jhf7HPDEZQDBwvjJCg3DtjWb71d5T9CH+KYPuBhkC0knbrIt6m
         eEc2wnLmke0EVAcejglEtcLdGJt6PotpskjiXzR98lzmqcS0e/7AGgQfukZpliLCDPw/
         h5+g==
X-Gm-Message-State: AOAM5306Va0plD+fjI18BqSYGQgZptXII6G2M+dtzpy/sR51wIbLLBFg
        yQn6cOdAYIFwd0Oja505zr5TAQUXX3+IHxgeuwRbyuH+jYaHPgHfAAgEQhCykD8LFLVcPaC0ouI
        LvpufwCIxN6gLisYfJGgG4auF
X-Received: by 2002:adf:fb01:0:b0:205:c3e1:7980 with SMTP id c1-20020adffb01000000b00205c3e17980mr12252665wrr.639.1650386805294;
        Tue, 19 Apr 2022 09:46:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkjqO1nXwxthbwDxhp+J+nndk7TRLfFjKIKBZaN7QLJXPFINKCDtSEwUKtO4M09QieboCRIQ==
X-Received: by 2002:adf:fb01:0:b0:205:c3e1:7980 with SMTP id c1-20020adffb01000000b00205c3e17980mr12252630wrr.639.1650386805064;
        Tue, 19 Apr 2022 09:46:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b00391ca5976c8sm14672796wmi.0.2022.04.19.09.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 09:46:44 -0700 (PDT)
Message-ID: <219bd2d0-92ef-bcac-458a-0df6190fa387@redhat.com>
Date:   Tue, 19 Apr 2022 18:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 12/16] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
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
 <2ae0a409-3d6d-9f6a-09e8-2f6867a4069a@redhat.com>
 <5fc7d007-e59b-de8d-4d88-3f1b5adfa95b@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5fc7d007-e59b-de8d-4d88-3f1b5adfa95b@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 20:28, Vlastimil Babka wrote:
> On 4/13/22 18:39, David Hildenbrand wrote:
>>>> @@ -3035,10 +3083,19 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>>>  
>>>>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>>>>  	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>>>> +
>>>> +	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>>>> +	if (anon_exclusive && page_try_share_anon_rmap(page)) {
>>>> +		set_pmd_at(mm, address, pvmw->pmd, pmdval);
>>>> +		return;
>>>
>>> I am admittedly not too familiar with this code, but looks like this means
>>> we fail to migrate the THP, right? But we don't seem to be telling the
>>> caller, which is try_to_migrate_one(), so it will continue and not terminate
>>> the walk and return false?
>>
>> Right, we're not returning "false". Returning "false" would be an
>> optimization to make rmap_walk_anon() fail faster.
> 
> Ah right, that's what I missed, it's an optimization and we will realize
> elsewhere afterwards that the page has still mappings and we can't migrate...

I'll include that patch in v4 (to be tested):


From 08fb0e45404e3d0f85c2ad23a473e95053396376 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Apr 2022 18:39:23 +0200
Subject: [PATCH] mm/rmap: fail try_to_migrate() early when setting a PMD
 migration entry fails

Let's fail right away in case we cannot clear PG_anon_exclusive because
the anon THP may be pinned. Right now, we continue trying to
install migration entries and the caller of try_to_migrate() will
realize that the page is still mapped and has to restore the migration
entries. Let's just fail fast just like for PTE migration entries.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swapops.h | 4 ++--
 mm/huge_memory.c        | 8 +++++---
 mm/rmap.c               | 6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 06280fc1c99b..8b6e4cd1fab8 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -299,7 +299,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 struct page_vma_mapped_walk;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-extern void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+extern int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page);
 
 extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
@@ -332,7 +332,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 	return !pmd_present(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
 }
 #else
-static inline void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
 	BUILD_BUG();
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7ac1b462543..390f22334ee9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3080,7 +3080,7 @@ late_initcall(split_huge_pages_debugfs);
 #endif
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
 	struct vm_area_struct *vma = pvmw->vma;
@@ -3092,7 +3092,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	pmd_t pmdswp;
 
 	if (!(pvmw->pmd && !pvmw->pte))
-		return;
+		return 0;
 
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
 	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
@@ -3100,7 +3100,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
 	if (anon_exclusive && page_try_share_anon_rmap(page)) {
 		set_pmd_at(mm, address, pvmw->pmd, pmdval);
-		return;
+		return -EBUSY;
 	}
 
 	if (pmd_dirty(pmdval))
@@ -3118,6 +3118,8 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	page_remove_rmap(page, vma, true);
 	put_page(page);
 	trace_set_migration_pmd(address, pmd_val(pmdswp));
+
+	return 0;
 }
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
diff --git a/mm/rmap.c b/mm/rmap.c
index 00418faaf4ce..68c2f61bf212 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1814,7 +1814,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
 					!folio_test_pmd_mappable(folio), folio);
 
-			set_pmd_migration_entry(&pvmw, subpage);
+			if (set_pmd_migration_entry(&pvmw, subpage)) {
+				ret = false;
+				page_vma_mapped_walk_done(&pvmw);
+				break;
+			}
 			continue;
 		}
 #endif
-- 
2.35.1



-- 
Thanks,

David / dhildenb

