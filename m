Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B117512ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbiD1In7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344654AbiD1ImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 690524F442
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651135034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1E+KMue8g2Twd1f0luBts2gnotv4rv0hB9jbuWnJHk=;
        b=Y1nMONai2mgTxjUBgg+6TWtorD+l0Qv8R5hfhDeFhh6VewmCUJvBjEn3zJUYpLbsFj1aHZ
        lMsWfBphDXCt88LtZx++/9/UwTPzuh5eknXqn7VvvzfG23OFy/NgwraXouH/vcONDv08p/
        LRRgTLC10c6vgVGDtwSJhy6KHCG7WDE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-rJEzsNo8MP-3O6m1r5W8qw-1; Thu, 28 Apr 2022 04:37:13 -0400
X-MC-Unique: rJEzsNo8MP-3O6m1r5W8qw-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso3308725wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=q1E+KMue8g2Twd1f0luBts2gnotv4rv0hB9jbuWnJHk=;
        b=moIV0G+bMzTPLl5TPCKjqeMcCBK1ImVA/1WqWFaBd9secoZp6wk1OCiKSWRRtr16TB
         VV+up0ti80RKFBEc3ucRSITW/EHDQcDXr1JkfrNFjAbtFbLU0uFdFffs+r5yVCzYtJ+q
         m11GoU87lW/YH2XYgyl5Us4CAVF3k660kt0D6xK4s4ftsfiKlGLnD2h/qD5ayAzv0wO3
         G3laDyBlaxgZEErPwAMdKHKv4yvuobOe3wZU4z7hKF4H6XqRFfdES4ZXgMuydLAGYjvg
         i4kqfl+A1cqYqN7gTkgSjxAKCnYW2jSsqpuYD7+J0ByBZB+YgLd2JzJUPiBORDlWcV41
         GsJA==
X-Gm-Message-State: AOAM531QWkmfAQsm7ArHauyMXbvz0LNhvyqVektyjcz7f6dGh1EmUjuC
        7d79ixlVqwWODtyZntl6WShY+OilP/27+x7b7/wq3WFmG6+zos7uqccAxBkeI9UN4egqZMtazBF
        uXSiMSv5VSPuhizjL4qVvEsGpR5ablxaEmsgR2ednjgdMdWvGky9XRDcAWgRrzQZK/8ggG9Nz
X-Received: by 2002:a05:600c:1ca6:b0:393:eb0e:afd9 with SMTP id k38-20020a05600c1ca600b00393eb0eafd9mr18424623wms.87.1651135032259;
        Thu, 28 Apr 2022 01:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSJ0QHTwEs60aBWmopOnQJRhew2BaINvB4E9Ek8+vpssmjqmFKccDSw/5yQr2SZc63ctObjg==
X-Received: by 2002:a05:600c:1ca6:b0:393:eb0e:afd9 with SMTP id k38-20020a05600c1ca600b00393eb0eafd9mr18424571wms.87.1651135031824;
        Thu, 28 Apr 2022 01:37:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id t8-20020adfa2c8000000b0020ad7121495sm11584858wra.23.2022.04.28.01.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 01:37:11 -0700 (PDT)
Message-ID: <e5e8fdce-eea6-9926-c352-e73dfe3e2579@redhat.com>
Date:   Thu, 28 Apr 2022 10:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 00/17] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220428083441.37290-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220428083441.37290-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.22 10:34, David Hildenbrand wrote:
> This is roughly what we have in -mm and -next, however, includes one
> additional patch and some minor differences, especially minor fixes in the
> patch descriptions.
> 
> v4 is located at:
> 	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v4
> 
> Please refer to to v3 cover letter:
> 	https://lkml.kernel.org/r/20220329160440.193848-1-david@redhat.com
> 
> 

Essential diff to v3:


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
diff --git a/mm/gup.c b/mm/gup.c
index 5c17d4816441..46ffd8c51c6e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -564,8 +564,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
-		  !PageAnonExclusive(page));
+	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+		       !PageAnonExclusive(page), page);
 
 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
 	if (unlikely(!try_grab_page(page, flags))) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7ac1b462543..a2f44d8d3d47 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1392,8 +1392,8 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
 		return ERR_PTR(-EMLINK);
 
-	VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
-		  !PageAnonExclusive(page));
+	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+			!PageAnonExclusive(page), page);
 
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ee0542f77130..534747d661dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6100,8 +6100,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
 		page = pte_page(huge_ptep_get(pte));
 
-		VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
-			  !PageAnonExclusive(page));
+		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+			       !PageAnonExclusive(page), page);
 
 		/*
 		 * If subpage information not requested, update counters
diff --git a/mm/memory.c b/mm/memory.c
index 2046de391da2..1a25d28ee5d9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3132,7 +3132,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			free_swap_cache(old_page);
 		put_page(old_page);
 	}
-	return page_copied && !unshare ? VM_FAULT_WRITE : 0;
+	return (page_copied && !unshare) ? VM_FAULT_WRITE : 0;
 oom_free_new:
 	put_page(new_page);
 oom:
@@ -4557,7 +4557,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 
 	if (vma_is_anonymous(vmf->vma)) {
-		if (unlikely(unshare) &&
+		if (likely(!unshare) &&
 		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf);
diff --git a/mm/rmap.c b/mm/rmap.c
index 00418faaf4ce..12f54fbdb920 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1217,8 +1217,6 @@ void page_add_new_anon_rmap(struct page *page,
 
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	} else {
-		/* Anon THP always mapped first with PMD */
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(&page->_mapcount, 0);
 	}
@@ -1814,7 +1812,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
Thanks,

David / dhildenb

