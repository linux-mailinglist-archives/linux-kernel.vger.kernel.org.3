Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9758E469
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiHJBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHJBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:19:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA796716C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660094377; x=1691630377;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HJUr0cpq2k0Fdw1RYMsCCP+3t05b3N8dkraf9iPYaxY=;
  b=N/qoMfJ0DyDJyAwj03A5q6kQ5mXWomulOAMk6VgvL2YItVIPwueqy7Dx
   B3JL3m6MQBPqt7arUTXtS2NDaoRBsA3UenoSFVjqEkD9Ix0vYDa/sBQet
   3m9ADsWD8v8PLXmxZMWdaZ0sPs+QkniZcNG6t1ePjMlY6h208ppwRnZKp
   u1taHczti8EsCrKT8oAsv7o4ev/kSzi63eB/vrJlvJdAItcMK0mO0C6nX
   5OOA8ck6VRbUFF7ME8WxvlLX+ectY/Vp68HYIlpRCzrXD+AnUuy7x1oZj
   6c736oTrlSXNS4+cv5kBd16lzOoeDtKS2yvykoDwUNMgAp7VNiZRZX4M5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="277908504"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="277908504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:19:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="673106026"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:19:34 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/7] mm/swap: Comment all the ifdef in swapops.h
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-3-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 09:19:31 +0800
In-Reply-To: <20220809220100.20033-3-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:00:55 -0400")
Message-ID: <87fsi4gajg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> swapops.h contains quite a few layers of ifdef, some of the "else" and
> "endif" doesn't get proper comment on the macro so it's hard to follow on
> what are they referring to.  Add the comments.
>
> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  include/linux/swapops.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index a3d435bf9f97..3a2901ff4f1e 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -247,8 +247,8 @@ extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  #ifdef CONFIG_HUGETLB_PAGE
>  extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
>  extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
> -#endif
> -#else
> +#endif	/* CONFIG_HUGETLB_PAGE */
> +#else  /* CONFIG_MIGRATION */
>  static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>  {
>  	return swp_entry(0, 0);
> @@ -276,7 +276,7 @@ static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  #ifdef CONFIG_HUGETLB_PAGE
>  static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
>  static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
> -#endif
> +#endif	/* CONFIG_HUGETLB_PAGE */
>  static inline int is_writable_migration_entry(swp_entry_t entry)
>  {
>  	return 0;
> @@ -286,7 +286,7 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
>  	return 0;
>  }
>  
> -#endif
> +#endif	/* CONFIG_MIGRATION */
>  
>  typedef unsigned long pte_marker;
>  
> @@ -426,7 +426,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
>  	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>  }
> -#else
> +#else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  		struct page *page)
>  {
> @@ -455,7 +455,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
>  	return 0;
>  }
> -#endif
> +#endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  
> @@ -495,7 +495,7 @@ static inline void num_poisoned_pages_sub(long i)
>  	atomic_long_sub(i, &num_poisoned_pages);
>  }
>  
> -#else
> +#else  /* CONFIG_MEMORY_FAILURE */
>  
>  static inline swp_entry_t make_hwpoison_entry(struct page *page)
>  {
> @@ -514,7 +514,7 @@ static inline void num_poisoned_pages_inc(void)
>  static inline void num_poisoned_pages_sub(long i)
>  {
>  }
> -#endif
> +#endif  /* CONFIG_MEMORY_FAILURE */
>  
>  static inline int non_swap_entry(swp_entry_t entry)
>  {
