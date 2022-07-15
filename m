Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81799576531
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGOQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D58576EEAA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657902086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ta6SFTUOQ5fscE7D9FWP+OCFPFI+O7rZjNngF0QlJQ=;
        b=LNbLbayRsnQGNJB3jnpslEZgsoBYggbN0v+Yg2wtvhTDKaleFYy5PKgtf9IKa3fSfqBDIM
        J7t0GdlDkqB+RCNMkYJBG//GANAQ4IkH4gaAssMh9u0lkGYZwCT6je5XPybfSbeHgiW2a0
        IeLNBtTxnrd+CXae5kgZdOXGZ/X85M0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-H0mV8UYpNmiq1ZVdjEdxVA-1; Fri, 15 Jul 2022 12:21:25 -0400
X-MC-Unique: H0mV8UYpNmiq1ZVdjEdxVA-1
Received: by mail-qt1-f199.google.com with SMTP id c22-20020ac81116000000b0031d25923ea8so3906654qtj.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ta6SFTUOQ5fscE7D9FWP+OCFPFI+O7rZjNngF0QlJQ=;
        b=z4upVJRyrNCyAEMjr35JpZVkN8ihcIjzM7wZl8eY67/0GDSHZ2s1QsH0y9doe5QNr6
         hu65DToo8TK9AazR1TRRhmVvAN2nDPtDTm4cbF/WTtdL9sRTMp6Q3WP18OhY2/UVjbCR
         f5PuNccAfu6A1IgXR3k2m0wwd4REnnPKTeHROl9XD7jQvS0EMldFU3Zn3jf3KjglhZ+G
         tNRdR7PEnxPDYJV1kRY+7Y1TgT3TE7VPgWn4TopVNJ0JPAb1ReykMZmtx7BYgH5C32xT
         bOvuWfqjN35dE5qPg7/8lE8Y/Jtd1KJd7B661eSPALq3vQ4dGv26Bbdab6opGPcFQj+G
         l6Eg==
X-Gm-Message-State: AJIora9c9LzKD8SS8bO8Gj9EzCx1hv8g5CO8pFkxcmHFJsKOnpT5YuKv
        Pv48dGRuXZK01COjWHUafvz2oXXAwRKdI3X3tdzEsT0+bLi/b6El+ecMYtSmNLnmd4KWZD0tqOQ
        DVY+MlDhVqg2OUbrwTc3qIW1R
X-Received: by 2002:ac8:5c8d:0:b0:31e:cf54:5ede with SMTP id r13-20020ac85c8d000000b0031ecf545edemr9431382qta.531.1657902084275;
        Fri, 15 Jul 2022 09:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vDkpiARpf3qb2u7fB33Q1lc3Ez9pdIUWOGD9c20OQYIcQE4Qb+pqupDAmAFsLHAVZZOvqQoQ==
X-Received: by 2002:ac8:5c8d:0:b0:31e:cf54:5ede with SMTP id r13-20020ac85c8d000000b0031ecf545edemr9431346qta.531.1657902083854;
        Fri, 15 Jul 2022 09:21:23 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a204700b006a34a22bc60sm3975621qka.9.2022.07.15.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:21:23 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:21:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 20/26] hugetlb: add support for high-granularity
 UFFDIO_CONTINUE
Message-ID: <YtGUARcBHxLU0axU@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-21-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-21-jthoughton@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:36:50PM +0000, James Houghton wrote:
> The changes here are very similar to the changes made to
> hugetlb_no_page, where we do a high-granularity page table walk and
> do accounting slightly differently because we are mapping only a piece
> of a page.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  fs/userfaultfd.c        |  3 +++
>  include/linux/hugetlb.h |  6 +++--
>  mm/hugetlb.c            | 54 +++++++++++++++++++++-----------------
>  mm/userfaultfd.c        | 57 +++++++++++++++++++++++++++++++----------
>  4 files changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e943370107d0..77c1b8a7d0b9 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -245,6 +245,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  	if (!ptep)
>  		goto out;
>  
> +	if (hugetlb_hgm_enabled(vma))
> +		goto out;
> +

This is weird.  It means we'll never wait for sub-page mapping enabled
vmas.  Why?

Not to mention hugetlb_hgm_enabled() currently is simply VM_SHARED, so it
means we'll stop waiting for all shared hugetlbfs uffd page faults..

I'd expect in the in-house postcopy tests you should see vcpu threads
spinning on the page faults until it's serviced.

IMO we still need to properly wait when the pgtable doesn't have the
faulted address covered.  For sub-page mapping it'll probably need to walk
into sub-page levels.

>  	ret = false;
>  	pte = huge_ptep_get(ptep);
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ac4ac8fbd901..c207b1ac6195 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -221,13 +221,15 @@ unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
>  #ifdef CONFIG_USERFAULTFD
> -int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
> +int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> +				struct hugetlb_pte *dst_hpte,
>  				struct vm_area_struct *dst_vma,
>  				unsigned long dst_addr,
>  				unsigned long src_addr,
>  				enum mcopy_atomic_mode mode,
>  				struct page **pagep,
> -				bool wp_copy);
> +				bool wp_copy,
> +				bool new_mapping);
>  #endif /* CONFIG_USERFAULTFD */
>  bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0ec2f231524e..09fa57599233 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5808,6 +5808,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		vma_end_reservation(h, vma, haddr);
>  	}
>  
> +	/* This lock will get pretty expensive at 4K. */
>  	ptl = hugetlb_pte_lock(mm, hpte);
>  	ret = 0;
>  	/* If pte changed from under us, retry */
> @@ -6098,24 +6099,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   * modifications for huge pages.
>   */
>  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> -			    pte_t *dst_pte,
> +			    struct hugetlb_pte *dst_hpte,
>  			    struct vm_area_struct *dst_vma,
>  			    unsigned long dst_addr,
>  			    unsigned long src_addr,
>  			    enum mcopy_atomic_mode mode,
>  			    struct page **pagep,
> -			    bool wp_copy)
> +			    bool wp_copy,
> +			    bool new_mapping)
>  {
>  	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
>  	struct hstate *h = hstate_vma(dst_vma);
>  	struct address_space *mapping = dst_vma->vm_file->f_mapping;
> +	unsigned long haddr = dst_addr & huge_page_mask(h);
>  	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
>  	unsigned long size;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	pte_t _dst_pte;
>  	spinlock_t *ptl;
>  	int ret = -ENOMEM;
> -	struct page *page;
> +	struct page *page, *subpage;
>  	int writable;
>  	bool page_in_pagecache = false;
>  
> @@ -6130,12 +6133,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		 * a non-missing case. Return -EEXIST.
>  		 */
>  		if (vm_shared &&
> -		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
>  			ret = -EEXIST;
>  			goto out;
>  		}
>  
> -		page = alloc_huge_page(dst_vma, dst_addr, 0);
> +		page = alloc_huge_page(dst_vma, haddr, 0);
>  		if (IS_ERR(page)) {
>  			ret = -ENOMEM;
>  			goto out;
> @@ -6151,13 +6154,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			/* Free the allocated page which may have
>  			 * consumed a reservation.
>  			 */
> -			restore_reserve_on_error(h, dst_vma, dst_addr, page);
> +			restore_reserve_on_error(h, dst_vma, haddr, page);
>  			put_page(page);
>  
>  			/* Allocate a temporary page to hold the copied
>  			 * contents.
>  			 */
> -			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
> +			page = alloc_huge_page_vma(h, dst_vma, haddr);
>  			if (!page) {
>  				ret = -ENOMEM;
>  				goto out;
> @@ -6171,14 +6174,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		}
>  	} else {
>  		if (vm_shared &&
> -		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
>  			put_page(*pagep);
>  			ret = -EEXIST;
>  			*pagep = NULL;
>  			goto out;
>  		}
>  
> -		page = alloc_huge_page(dst_vma, dst_addr, 0);
> +		page = alloc_huge_page(dst_vma, haddr, 0);
>  		if (IS_ERR(page)) {
>  			ret = -ENOMEM;
>  			*pagep = NULL;
> @@ -6216,8 +6219,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		page_in_pagecache = true;
>  	}
>  
> -	ptl = huge_pte_lockptr(huge_page_shift(h), dst_mm, dst_pte);
> -	spin_lock(ptl);
> +	ptl = hugetlb_pte_lock(dst_mm, dst_hpte);
>  
>  	/*
>  	 * Recheck the i_size after holding PT lock to make sure not
> @@ -6239,14 +6241,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	 * registered, we firstly wr-protect a none pte which has no page cache
>  	 * page backing it, then access the page.
>  	 */
> -	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
> +	if (!hugetlb_pte_none_mostly(dst_hpte))
>  		goto out_release_unlock;
>  
> -	if (vm_shared) {
> -		page_dup_file_rmap(page, true);
> -	} else {
> -		ClearHPageRestoreReserve(page);
> -		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
> +	if (new_mapping) {

IIUC you wanted to avoid the mapcount accountings when it's the sub-page
that was going to be mapped.

Is it a must we get this only from the caller?  Can we know we're doing
sub-page mapping already here and make a decision with e.g. dst_hpte?

It looks weird to me to pass this explicitly from the caller, especially
that's when we don't really have the pgtable lock so I'm wondering about
possible race conditions too on having stale new_mapping values.

> +		if (vm_shared) {
> +			page_dup_file_rmap(page, true);
> +		} else {
> +			ClearHPageRestoreReserve(page);
> +			hugepage_add_new_anon_rmap(page, dst_vma, haddr);
> +		}
>  	}
>  
>  	/*
> @@ -6258,7 +6262,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	else
>  		writable = dst_vma->vm_flags & VM_WRITE;
>  
> -	_dst_pte = make_huge_pte(dst_vma, page, writable);
> +	subpage = hugetlb_find_subpage(h, page, dst_addr);
> +	if (subpage != page)
> +		BUG_ON(!hugetlb_hgm_enabled(dst_vma));
> +
> +	_dst_pte = make_huge_pte(dst_vma, subpage, writable);
>  	/*
>  	 * Always mark UFFDIO_COPY page dirty; note that this may not be
>  	 * extremely important for hugetlbfs for now since swapping is not
> @@ -6271,14 +6279,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (wp_copy)
>  		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
>  
> -	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +	set_huge_pte_at(dst_mm, dst_addr, dst_hpte->ptep, _dst_pte);
>  
> -	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
> -					dst_vma->vm_flags & VM_WRITE);
> -	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
> +	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_hpte->ptep,
> +			_dst_pte, dst_vma->vm_flags & VM_WRITE);
> +	hugetlb_count_add(hugetlb_pte_size(dst_hpte) / PAGE_SIZE, dst_mm);
>  
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +	update_mmu_cache(dst_vma, dst_addr, dst_hpte->ptep);
>  
>  	spin_unlock(ptl);
>  	if (!is_continue)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 4f4892a5f767..ee40d98068bf 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -310,14 +310,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  {
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	ssize_t err;
> -	pte_t *dst_pte;
>  	unsigned long src_addr, dst_addr;
>  	long copied;
>  	struct page *page;
> -	unsigned long vma_hpagesize;
> +	unsigned long vma_hpagesize, vma_altpagesize;
>  	pgoff_t idx;
>  	u32 hash;
>  	struct address_space *mapping;
> +	bool use_hgm = hugetlb_hgm_enabled(dst_vma) &&
> +		mode == MCOPY_ATOMIC_CONTINUE;
> +	struct hstate *h = hstate_vma(dst_vma);
>  
>  	/*
>  	 * There is no default zero huge page for all huge page sizes as
> @@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	copied = 0;
>  	page = NULL;
>  	vma_hpagesize = vma_kernel_pagesize(dst_vma);
> +	if (use_hgm)
> +		vma_altpagesize = PAGE_SIZE;

Do we need to check the "len" to know whether we should use sub-page
mapping or original hpage size?  E.g. any old UFFDIO_CONTINUE code will
still want the old behavior I think.

> +	else
> +		vma_altpagesize = vma_hpagesize;
>  
>  	/*
>  	 * Validate alignment based on huge page size
>  	 */
>  	err = -EINVAL;
> -	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
> +	if (dst_start & (vma_altpagesize - 1) || len & (vma_altpagesize - 1))
>  		goto out_unlock;
>  
>  retry:
> @@ -361,6 +367,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	}
>  
> +	BUG_ON(!vm_shared && use_hgm);
> +
>  	/*
>  	 * If not shared, ensure the dst_vma has a anon_vma.
>  	 */
> @@ -371,11 +379,13 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	}
>  
>  	while (src_addr < src_start + len) {
> +		struct hugetlb_pte hpte;
> +		bool new_mapping;
>  		BUG_ON(dst_addr >= dst_start + len);
>  
>  		/*
>  		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
> -		 * i_mmap_rwsem ensures the dst_pte remains valid even
> +		 * i_mmap_rwsem ensures the hpte.ptep remains valid even
>  		 * in the case of shared pmds.  fault mutex prevents
>  		 * races with other faulting threads.
>  		 */
> @@ -383,27 +393,47 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		i_mmap_lock_read(mapping);
>  		idx = linear_page_index(dst_vma, dst_addr);
>  		hash = hugetlb_fault_mutex_hash(mapping, idx);
> +		/* This lock will get expensive at 4K. */
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
> -		err = -ENOMEM;
> -		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
> -		if (!dst_pte) {
> +		err = 0;
> +
> +		pte_t *ptep = huge_pte_alloc(dst_mm, dst_vma, dst_addr,
> +					     vma_hpagesize);
> +		if (!ptep)
> +			err = -ENOMEM;
> +		else {
> +			hugetlb_pte_populate(&hpte, ptep,
> +					huge_page_shift(h));
> +			/*
> +			 * If the hstate-level PTE is not none, then a mapping
> +			 * was previously established.
> +			 * The per-hpage mutex prevents double-counting.
> +			 */
> +			new_mapping = hugetlb_pte_none(&hpte);
> +			if (use_hgm)
> +				err = hugetlb_alloc_largest_pte(&hpte, dst_mm, dst_vma,
> +								dst_addr,
> +								dst_start + len);
> +		}
> +
> +		if (err) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			i_mmap_unlock_read(mapping);
>  			goto out_unlock;
>  		}
>  
>  		if (mode != MCOPY_ATOMIC_CONTINUE &&
> -		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
> +		    !hugetlb_pte_none_mostly(&hpte)) {
>  			err = -EEXIST;
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			i_mmap_unlock_read(mapping);
>  			goto out_unlock;
>  		}
>  
> -		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
> +		err = hugetlb_mcopy_atomic_pte(dst_mm, &hpte, dst_vma,
>  					       dst_addr, src_addr, mode, &page,
> -					       wp_copy);
> +					       wp_copy, new_mapping);
>  
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		i_mmap_unlock_read(mapping);
> @@ -413,6 +443,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		if (unlikely(err == -ENOENT)) {
>  			mmap_read_unlock(dst_mm);
>  			BUG_ON(!page);
> +			BUG_ON(hpte.shift != huge_page_shift(h));
>  
>  			err = copy_huge_page_from_user(page,
>  						(const void __user *)src_addr,
> @@ -430,9 +461,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  			BUG_ON(page);
>  
>  		if (!err) {
> -			dst_addr += vma_hpagesize;
> -			src_addr += vma_hpagesize;
> -			copied += vma_hpagesize;
> +			dst_addr += hugetlb_pte_size(&hpte);
> +			src_addr += hugetlb_pte_size(&hpte);
> +			copied += hugetlb_pte_size(&hpte);
>  
>  			if (fatal_signal_pending(current))
>  				err = -EINTR;
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 

-- 
Peter Xu

