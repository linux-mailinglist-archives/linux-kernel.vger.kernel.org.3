Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A64FF2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiDMJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDMJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:00:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775E4EDEC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:58:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kdc0D3kxhzgYnK;
        Wed, 13 Apr 2022 16:56:44 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 16:58:33 +0800
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
To:     David Hildenbrand <david@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-2-david@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <28142e3e-2556-0ca2-7ac5-7420ef862259@huawei.com>
Date:   Wed, 13 Apr 2022 16:58:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220329164329.208407-2-david@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/30 0:43, David Hildenbrand wrote:
> Currently, we clear PG_anon_exclusive in try_to_unmap() and forget about
...
> diff --git a/mm/memory.c b/mm/memory.c
> index 14618f446139..9060cc7f2123 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -792,6 +792,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  						&src_mm->mmlist);
>  			spin_unlock(&mmlist_lock);
>  		}
> +		/* Mark the swap entry as shared. */
> +		if (pte_swp_exclusive(*src_pte)) {
> +			pte = pte_swp_clear_exclusive(*src_pte);
> +			set_pte_at(src_mm, addr, src_pte, pte);
> +		}
>  		rss[MM_SWAPENTS]++;
>  	} else if (is_migration_entry(entry)) {
>  		page = pfn_swap_entry_to_page(entry);
> @@ -3559,6 +3564,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	struct page *page = NULL, *swapcache;
>  	struct swap_info_struct *si = NULL;
>  	rmap_t rmap_flags = RMAP_NONE;
> +	bool exclusive = false;
>  	swp_entry_t entry;
>  	pte_t pte;
>  	int locked;
> @@ -3724,6 +3730,46 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
>  
> +	/*
> +	 * Check under PT lock (to protect against concurrent fork() sharing
> +	 * the swap entry concurrently) for certainly exclusive pages.
> +	 */
> +	if (!PageKsm(page)) {
> +		/*
> +		 * Note that pte_swp_exclusive() == false for architectures
> +		 * without __HAVE_ARCH_PTE_SWP_EXCLUSIVE.
> +		 */
> +		exclusive = pte_swp_exclusive(vmf->orig_pte);
> +		if (page != swapcache) {
> +			/*
> +			 * We have a fresh page that is not exposed to the
> +			 * swapcache -> certainly exclusive.
> +			 */
> +			exclusive = true;
> +		} else if (exclusive && PageWriteback(page) &&
> +			   !(swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {

Really sorry for late respond and a newbie question. IIUC, if SWP_STABLE_WRITES is set,
it means concurrent page modifications while under writeback is not supported. For these
problematic swap backends, exclusive marker is dropped. So the above if statement is to
filter out these problematic swap backends which have SWP_STABLE_WRITES set. If so, the
above check should be && (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)), i.e. no "!".
Or am I miss something?

It's very kind of you if you can answer this question. Many thanks!

> +			/*
> +			 * This is tricky: not all swap backends support
> +			 * concurrent page modifications while under writeback.
> +			 *
> +			 * So if we stumble over such a page in the swapcache
> +			 * we must not set the page exclusive, otherwise we can
> +			 * map it writable without further checks and modify it
> +			 * while still under writeback.
> +			 *
> +			 * For these problematic swap backends, simply drop the
> +			 * exclusive marker: this is perfectly fine as we start
> +			 * writeback only if we fully unmapped the page and
> +			 * there are no unexpected references on the page after
> +			 * unmapping succeeded. After fully unmapped, no
> +			 * further GUP references (FOLL_GET and FOLL_PIN) can
> +			 * appear, so dropping the exclusive marker and mapping
> +			 * it only R/O is fine.
> +			 */
> +			exclusive = false;
> +		}
> +	}
> +
>  	/*
>  	 * Remove the swap entry and conditionally try to free up the swapcache.
>  	 * We're already holding a reference on the page but haven't mapped it
> @@ -3738,11 +3784,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	pte = mk_pte(page, vma->vm_page_prot);
>  
>  	/*
> -	 * Same logic as in do_wp_page(); however, optimize for fresh pages
> -	 * that are certainly not shared because we just allocated them without
> -	 * exposing them to the swapcache.
> +	 * Same logic as in do_wp_page(); however, optimize for pages that are
> +	 * certainly not shared either because we just allocated them without
> +	 * exposing them to the swapcache or because the swap entry indicates
> +	 * exclusivity.
>  	 */
> -	if (!PageKsm(page) && (page != swapcache || page_count(page) == 1)) {
> +	if (!PageKsm(page) && (exclusive || page_count(page) == 1)) {
>  		if (vmf->flags & FAULT_FLAG_WRITE) {
>  			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  			vmf->flags &= ~FAULT_FLAG_WRITE;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4de07234cbcf..c8c257d94962 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1656,14 +1656,15 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  				break;
>  			}
>  			/*
> -			 * Note: We *don't* remember yet if the page was mapped
> -			 * exclusively in the swap entry, so swapin code has
> -			 * to re-determine that manually and might detect the
> -			 * page as possibly shared, for example, if there are
> -			 * other references on the page or if the page is under
> -			 * writeback. We made sure that there are no GUP pins
> -			 * on the page that would rely on it, so for GUP pins
> -			 * this is fine.
> +			 * Note: We *don't* remember if the page was mapped
> +			 * exclusively in the swap pte if the architecture
> +			 * doesn't support __HAVE_ARCH_PTE_SWP_EXCLUSIVE. In
> +			 * that case, swapin code has to re-determine that
> +			 * manually and might detect the page as possibly
> +			 * shared, for example, if there are other references on
> +			 * the page or if the page is under writeback. We made
> +			 * sure that there are no GUP pins on the page that
> +			 * would rely on it, so for GUP pins this is fine.
>  			 */
>  			if (list_empty(&mm->mmlist)) {
>  				spin_lock(&mmlist_lock);
> @@ -1674,6 +1675,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			dec_mm_counter(mm, MM_ANONPAGES);
>  			inc_mm_counter(mm, MM_SWAPENTS);
>  			swp_pte = swp_entry_to_pte(entry);
> +			if (anon_exclusive)
> +				swp_pte = pte_swp_mkexclusive(swp_pte);
>  			if (pte_soft_dirty(pteval))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
>  			if (pte_uffd_wp(pteval))
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a7847324d476..7279b2d2d71d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1804,7 +1804,18 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>  	get_page(page);
>  	if (page == swapcache) {
> -		page_add_anon_rmap(page, vma, addr, RMAP_NONE);
> +		rmap_t rmap_flags = RMAP_NONE;
> +
> +		/*
> +		 * See do_swap_page(): PageWriteback() would be problematic.
> +		 * However, we do a wait_on_page_writeback() just before this
> +		 * call and have the page locked.
> +		 */
> +		VM_BUG_ON_PAGE(PageWriteback(page), page);
> +		if (pte_swp_exclusive(*pte))
> +			rmap_flags |= RMAP_EXCLUSIVE;
> +
> +		page_add_anon_rmap(page, vma, addr, rmap_flags);
>  	} else { /* ksm created a completely new copy */
>  		page_add_new_anon_rmap(page, vma, addr);
>  		lru_cache_add_inactive_or_unevictable(page, vma);
> 

