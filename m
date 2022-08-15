Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10546592794
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiHOBkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:40:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C6010A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660527615; x=1692063615;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=aSAI38280sAdYFjY8JRMFFvIv1OTYOVqedJJav6rXec=;
  b=eFy0i1B1fX4Rxobk67kaxS/2mGRe2k31nBd/5EmT5Oxme6H6mMhnFzGM
   XqIhkFhdeQbSffnJ8ez7fH2b4bczEH66ogGWnFhxDrknEojuWMl2Gmbk9
   cAo6IHanAhSluEeuJrePF/1scxIUWHwemhp4YiQfQnV6HGCmaGCtL57Ec
   K+Tfw7+1QmlewHmhw5CWeO+ilxawxf+g73LNjWGYpIVVFtrnv/kwYo/E9
   r+7usA53fxCnXiXymHHo7QI0ai05GRZlZM/IB8k6+5Rc8+TuBFIYndqS9
   ZyFLvk1IGbFwrTfQ4LhiLM5KOkeAqpy5kAPFW94KKEp3GQJ4spp0QQdnX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278827529"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="278827529"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:40:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674686959"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:40:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <david@redhat.com>,
        <linmiaohe@huawei.com>, <songmuchun@bytedance.com>,
        <naoya.horiguchi@linux.dev>, <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>
Subject: Re: [PATCH v3 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815010349.432313-1-haiyue.wang@intel.com>
        <20220815010349.432313-3-haiyue.wang@intel.com>
Date:   Mon, 15 Aug 2022 09:39:59 +0800
In-Reply-To: <20220815010349.432313-3-haiyue.wang@intel.com> (Haiyue Wang's
        message of "Mon, 15 Aug 2022 09:03:49 +0800")
Message-ID: <87czd2e13k.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiyue Wang <haiyue.wang@intel.com> writes:

> The page returned by follow_page with 'FOLL_GET' has get_page called, so

Better to add "()" after function name to improve the readability, for
example, "follow_page()".

> it needs to call put_page for handling the reference count correctly.
>
> And as David reviewed, "device pages are never PageKsm pages". Drop this
> zone device page check for break_ksm.
>
> Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")

In your patch description, I cannot find how the above commit is related
to the bug you fixed.  Add some words about that?

Best Regards,
Huang, Ying

> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  mm/huge_memory.c |  4 ++--
>  mm/ksm.c         | 12 +++++++++---
>  mm/migrate.c     | 10 +++++++---
>  3 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8a7c1b344abe..b2ba17c3dcd7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		/* FOLL_DUMP to ignore special (like zero) pages */
>  		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>  
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>  			continue;
>  
> -		if (!is_transparent_hugepage(page))
> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
>  			goto next;
>  
>  		total++;
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 42ab153335a2..e26f57fc1f0e 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>  		cond_resched();
>  		page = follow_page(vma, addr,
>  				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>  			break;
>  		if (PageKsm(page))
>  			ret = handle_mm_fault(vma, addr,
> @@ -560,12 +560,15 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
>  		goto out;
>  
>  	page = follow_page(vma, addr, FOLL_GET);
> -	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +	if (IS_ERR_OR_NULL(page))
>  		goto out;
> +	if (is_zone_device_page(page))
> +		goto out_putpage;
>  	if (PageAnon(page)) {
>  		flush_anon_page(vma, page, addr);
>  		flush_dcache_page(page);
>  	} else {
> +out_putpage:
>  		put_page(page);
>  out:
>  		page = NULL;
> @@ -2308,11 +2311,13 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  			if (ksm_test_exit(mm))
>  				break;
>  			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
> -			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
> +			if (IS_ERR_OR_NULL(*page)) {
>  				ksm_scan.address += PAGE_SIZE;
>  				cond_resched();
>  				continue;
>  			}
> +			if (is_zone_device_page(*page))
> +				goto next_page;
>  			if (PageAnon(*page)) {
>  				flush_anon_page(vma, *page, ksm_scan.address);
>  				flush_dcache_page(*page);
> @@ -2327,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  				mmap_read_unlock(mm);
>  				return rmap_item;
>  			}
> +next_page:
>  			put_page(*page);
>  			ksm_scan.address += PAGE_SIZE;
>  			cond_resched();
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 581dfaad9257..fee12cd2f294 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1672,9 +1672,12 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		goto out;
>  
>  	err = -ENOENT;
> -	if (!page || is_zone_device_page(page))
> +	if (!page)
>  		goto out;
>  
> +	if (is_zone_device_page(page))
> +		goto out_putpage;
> +
>  	err = 0;
>  	if (page_to_nid(page) == node)
>  		goto out_putpage;
> @@ -1868,8 +1871,9 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  		if (IS_ERR(page))
>  			goto set_status;
>  
> -		if (page && !is_zone_device_page(page)) {
> -			err = page_to_nid(page);
> +		if (page) {
> +			err = !is_zone_device_page(page) ? page_to_nid(page)
> +							 : -ENOENT;
>  			if (foll_flags & FOLL_GET)
>  				put_page(page);
>  		} else {
