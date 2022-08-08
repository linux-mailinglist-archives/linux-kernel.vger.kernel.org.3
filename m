Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4758C2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiHHFYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiHHFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:24:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3065AE67
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659936245; x=1691472245;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=A8AMhdzyFGyzF5sZZ4XtrkVx5HlQTxNClfG8v5ChcdM=;
  b=jd3Uc8l2vqpdGQQtzW5sIlLY32T6i95ngl9BD3jOvrwFdBK3W+y/eZjK
   RkgsCxI4vtfjeUntTvhQBSj7Mt+TbtiQnEyd/TB8KzUCzf9BLv2MhEUbP
   1urXz+GzX6SZ+vjQL93Cu6fcv4lfyACV4sy0Tm6moKoi+fNUaI+0a88zj
   foZqTZlYlf0J5khhd6PYvXv/KVOIZITd3g1AGXh9WlyGqg+dVWHdmPY0L
   2qTLy2ikV0ih/Vr9p4LE9FXwCJe6Xi+2wNyi8QHztBvq5qNAvjF6gtA9C
   RxwJ+8Q1PiHRp6ITmlF+/dPQCFXQ7pdZxinruPQrjHfJ/iRCeUFSDdvqV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="277436011"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="277436011"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 22:24:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931896888"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 22:24:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm/smaps: Don't access young/dirty bit if pte unpresent
References: <20220805160003.58929-1-peterx@redhat.com>
Date:   Mon, 08 Aug 2022 13:23:46 +0800
In-Reply-To: <20220805160003.58929-1-peterx@redhat.com> (Peter Xu's message of
        "Fri, 5 Aug 2022 12:00:03 -0400")
Message-ID: <87wnbjgvfh.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> These bits should only be valid when the ptes are present.  Introducing two
> booleans for it and set it to false when !pte_present() for both pte and
> pmd accountings.
>
> The bug is found during code reading and no real world issue reported, but
> logically such an error can cause incorrect readings for either smaps or
> smaps_rollup output on quite a few fields.
>
> For example, it could cause over-estimate on values like Shared_Dirty,
> Private_Dirty, Referenced.  Or it could also cause under-estimate on values
> like LazyFree, Shared_Clean, Private_Clean.
>
> Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries")
> Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  fs/proc/task_mmu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9913f3be9fd2..d56c65f98d00 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool migration = false;
> +	bool migration = false, young = false, dirty = false;
>  
>  	if (pte_present(*pte)) {
>  		page = vm_normal_page(vma, addr, *pte);
> +		young = pte_young(*pte);
> +		dirty = pte_dirty(*pte);
>  	} else if (is_swap_pte(*pte)) {
>  		swp_entry_t swpent = pte_to_swp_entry(*pte);
>  
> @@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	if (!page)
>  		return;
>  
> -	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
> -		      locked, migration);
> +	smaps_account(mss, page, false, young, dirty, locked, migration);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -572,11 +573,13 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool migration = false;
> +	bool migration = false, young = false, dirty = false;
>  
>  	if (pmd_present(*pmd)) {
>  		/* FOLL_DUMP will return -EFAULT on huge zero page */
>  		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +		young = pmd_young(*pmd);
> +		dirty = pmd_dirty(*pmd);
>  	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>  		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>  
> @@ -596,8 +599,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	else
>  		mss->file_thp += HPAGE_PMD_SIZE;
>  
> -	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
> -		      locked, migration);
> +	smaps_account(mss, page, true, young, dirty, locked, migration);
>  }
>  #else
>  static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
