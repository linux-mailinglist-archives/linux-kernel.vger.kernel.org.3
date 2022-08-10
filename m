Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1616A58E745
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiHJGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiHJGVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:21:13 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1EC6D55D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:21:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660112469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy+nr+SHc7URxYD6Oc6FejCwJasYxNbjGCIxsgW4ixU=;
        b=iImfyMljvW1iWCWlXoVkaFT8tlMUmmkv5dgXSFqjDGe1WpbPh7sX9DjnzXuUxpDsWbbF8s
        A61rzriW02h9RZoPsTozVk+62FKt3IZzSCaPT9TH5JZGkEUckSRyvvm9rtqIZP6V8rj9nc
        C172zIF5QnJxH343JUGhh5EHfSERj2c=
MIME-Version: 1.0
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220808212836.111749-1-mike.kravetz@oracle.com>
Date:   Wed, 10 Aug 2022 14:20:50 +0800
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 9, 2022, at 05:28, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> When creating hugetlb pages, the hugetlb code must first allocate
> contiguous pages from a low level allocator such as buddy, cma or
> memblock.  The pages returned from these low level allocators are
> ref counted.  This creates potential issues with other code taking
> speculative references on these pages before they can be transformed =
to
> a hugetlb page.  This issue has been addressed with methods and code
> such as that provided in [1].
>=20
> Recent discussions about vmemmap freeing [2] have indicated that it
> would be beneficial to freeze all sub pages, including the head page
> of pages returned from low level allocators before converting to a
> hugetlb page.  This helps avoid races if want to replace the page
> containing vmemmap for the head page.
>=20
> There have been proposals to change at least the buddy allocator to
> return frozen pages as described at [3].  If such a change is made, it
> can be employed by the hugetlb code.  However, as mentioned above
> hugetlb uses several low level allocators so each would need to be
> modified to return frozen pages.  For now, we can manually freeze the
> returned pages.  This is done in two places:
> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
>   We freeze the head page, retrying once in the VERY rare case where
>   there may be an inflated ref count.
> 2) prep_compound_gigantic_page, for gigantic pages the current code
>   freezes all pages except the head page.  New code will simply freeze
>   the head page as well.
>=20
> In a few other places, code checks for inflated ref counts on newly
> allocated hugetlb pages.  With the modifications to freeze after
> allocating, this code can be removed.
>=20
> After hugetlb pages are freshly allocated, they are often added to the
> hugetlb free lists.  Since these pages were previously ref counted, =
this
> was done via put_page() which would end up calling the hugetlb
> destructor: free_huge_page.  With changes to freeze pages, we simply
> call free_huge_page directly to add the pages to the free list.
>=20
> In a few other places, freshly allocated hugetlb pages were =
immediately
> put into use, and the expectation was they were already ref counted.  =
In
> these cases, we must manually ref count the page.
>=20
> [1] =
https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@orac=
le.com/
> [2] =
https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@ora=
cle.com/
> [3] =
https://lore.kernel.org/linux-mm/20220531150611.1303156-1-willy@infradead.=
org/
>=20
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> mm/hugetlb.c | 97 +++++++++++++++++++---------------------------------
> 1 file changed, 35 insertions(+), 62 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 28516881a1b2..6b90d85d545b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1769,13 +1769,12 @@ static bool =
__prep_compound_gigantic_page(struct page *page, unsigned int order,
> {
> 	int i, j;
> 	int nr_pages =3D 1 << order;
> -	struct page *p =3D page + 1;
> +	struct page *p =3D page;
>=20
> 	/* we rely on prep_new_huge_page to set the destructor */
> 	set_compound_order(page, order);
> -	__ClearPageReserved(page);
> 	__SetPageHead(page);
> -	for (i =3D 1; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) =
{
> +	for (i =3D 0; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) =
{
> 		/*
> 		 * For gigantic hugepages allocated through bootmem at
> 		 * boot, it's safer to be consistent with the =
not-gigantic
> @@ -1814,7 +1813,8 @@ static bool __prep_compound_gigantic_page(struct =
page *page, unsigned int order,
> 		} else {
> 			VM_BUG_ON_PAGE(page_count(p), p);
> 		}
> -		set_compound_head(p, page);
> +		if (i !=3D 0)
> +			set_compound_head(p, page);
> 	}
> 	atomic_set(compound_mapcount_ptr(page), -1);
> 	atomic_set(compound_pincount_ptr(page), 0);
> @@ -1918,6 +1918,7 @@ static struct page *alloc_buddy_huge_page(struct =
hstate *h,
> 	int order =3D huge_page_order(h);
> 	struct page *page;
> 	bool alloc_try_hard =3D true;
> +	bool retry =3D true;
>=20
> 	/*
> 	 * By default we always try hard to allocate the page with
> @@ -1933,7 +1934,21 @@ static struct page =
*alloc_buddy_huge_page(struct hstate *h,
> 		gfp_mask |=3D __GFP_RETRY_MAYFAIL;
> 	if (nid =3D=3D NUMA_NO_NODE)
> 		nid =3D numa_mem_id();
> +retry:
> 	page =3D __alloc_pages(gfp_mask, order, nid, nmask);
> +
> +	/* Freeze head page */
> +	if (!page_ref_freeze(page, 1)) {

Hi Mike,

I saw Mattew has introduced a new helper alloc_frozen_pages() in thread =
[1] to allocate a
frozen page. Then we do not need to handle an unexpected refcount case, =
which
should be easy. Is there any consideration why we do not choose =
alloc_frozen_pages()?

[1] =
https://lore.kernel.org/linux-mm/20220809171854.3725722-15-willy@infradead=
.org/T/#u

Muchun,
Thanks.

> +		__free_pages(page, order);
> +		if (retry) {	/* retry once */
> +			retry =3D false;
> +			goto retry;
> +		}
> +		/* WOW!  twice in a row. */
> +		pr_warn("HugeTLB head page unexpected inflated ref =
count\n");
> +		page =3D NULL;
> +	}
> +
> 	if (page)
> 		__count_vm_event(HTLB_BUDDY_PGALLOC);
> 	else
> @@ -1961,6 +1976,9 @@ static struct page *alloc_buddy_huge_page(struct =
hstate *h,
> /*
>  * Common helper to allocate a fresh hugetlb page. All specific =
allocators
>  * should use this function to get new hugetlb pages
> + *
> + * Note that returned page is 'frozen':  ref count of head page and =
all tail
> + * pages is zero.
>  */
> static struct page *alloc_fresh_huge_page(struct hstate *h,
> 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
> @@ -2018,7 +2036,7 @@ static int alloc_pool_huge_page(struct hstate =
*h, nodemask_t *nodes_allowed,
> 	if (!page)
> 		return 0;
>=20
> -	put_page(page); /* free it into the hugepage allocator */
> +	free_huge_page(page); /* free it into the hugepage allocator */
>=20
> 	return 1;
> }
> @@ -2175,10 +2193,9 @@ int dissolve_free_huge_pages(unsigned long =
start_pfn, unsigned long end_pfn)
>  * Allocates a fresh surplus page from the page allocator.
>  */
> static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t =
gfp_mask,
> -		int nid, nodemask_t *nmask, bool zero_ref)
> +						int nid, nodemask_t =
*nmask)
> {
> 	struct page *page =3D NULL;
> -	bool retry =3D false;
>=20
> 	if (hstate_is_gigantic(h))
> 		return NULL;
> @@ -2188,7 +2205,6 @@ static struct page =
*alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> 		goto out_unlock;
> 	spin_unlock_irq(&hugetlb_lock);
>=20
> -retry:
> 	page =3D alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
> 	if (!page)
> 		return NULL;
> @@ -2204,34 +2220,10 @@ static struct page =
*alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> 	if (h->surplus_huge_pages >=3D h->nr_overcommit_huge_pages) {
> 		SetHPageTemporary(page);
> 		spin_unlock_irq(&hugetlb_lock);
> -		put_page(page);
> +		free_huge_page(page);
> 		return NULL;
> 	}
>=20
> -	if (zero_ref) {
> -		/*
> -		 * Caller requires a page with zero ref count.
> -		 * We will drop ref count here.  If someone else is =
holding
> -		 * a ref, the page will be freed when they drop it.  =
Abuse
> -		 * temporary page flag to accomplish this.
> -		 */
> -		SetHPageTemporary(page);
> -		if (!put_page_testzero(page)) {
> -			/*
> -			 * Unexpected inflated ref count on freshly =
allocated
> -			 * huge.  Retry once.
> -			 */
> -			pr_info("HugeTLB unexpected inflated ref count =
on freshly allocated page\n");
> -			spin_unlock_irq(&hugetlb_lock);
> -			if (retry)
> -				return NULL;
> -
> -			retry =3D true;
> -			goto retry;
> -		}
> -		ClearHPageTemporary(page);
> -	}
> -
> 	h->surplus_huge_pages++;
> 	h->surplus_huge_pages_node[page_to_nid(page)]++;
>=20
> @@ -2253,6 +2245,9 @@ static struct page =
*alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> 	if (!page)
> 		return NULL;
>=20
> +	/* fresh huge pages are frozen */
> +	set_page_refcounted(page);
> +
> 	/*
> 	 * We do not account these pages as surplus because they are =
only
> 	 * temporary and will be released properly on the last reference
> @@ -2280,14 +2275,14 @@ struct page =
*alloc_buddy_huge_page_with_mpol(struct hstate *h,
> 		gfp_t gfp =3D gfp_mask | __GFP_NOWARN;
>=20
> 		gfp &=3D  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> -		page =3D alloc_surplus_huge_page(h, gfp, nid, nodemask, =
false);
> +		page =3D alloc_surplus_huge_page(h, gfp, nid, nodemask);
>=20
> 		/* Fallback to all nodes if page=3D=3DNULL */
> 		nodemask =3D NULL;
> 	}
>=20
> 	if (!page)
> -		page =3D alloc_surplus_huge_page(h, gfp_mask, nid, =
nodemask, false);
> +		page =3D alloc_surplus_huge_page(h, gfp_mask, nid, =
nodemask);
> 	mpol_cond_put(mpol);
> 	return page;
> }
> @@ -2358,7 +2353,7 @@ static int gather_surplus_pages(struct hstate =
*h, long delta)
> 	spin_unlock_irq(&hugetlb_lock);
> 	for (i =3D 0; i < needed; i++) {
> 		page =3D alloc_surplus_huge_page(h, htlb_alloc_mask(h),
> -				NUMA_NO_NODE, NULL, true);
> +				NUMA_NO_NODE, NULL);
> 		if (!page) {
> 			alloc_ok =3D false;
> 			break;
> @@ -2720,7 +2715,6 @@ static int alloc_and_dissolve_huge_page(struct =
hstate *h, struct page *old_page,
> {
> 	gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THISNODE;
> 	int nid =3D page_to_nid(old_page);
> -	bool alloc_retry =3D false;
> 	struct page *new_page;
> 	int ret =3D 0;
>=20
> @@ -2731,30 +2725,9 @@ static int alloc_and_dissolve_huge_page(struct =
hstate *h, struct page *old_page,
> 	 * the pool.  This simplifies and let us do most of the =
processing
> 	 * under the lock.
> 	 */
> -alloc_retry:
> 	new_page =3D alloc_buddy_huge_page(h, gfp_mask, nid, NULL, =
NULL);
> 	if (!new_page)
> 		return -ENOMEM;
> -	/*
> -	 * If all goes well, this page will be directly added to the =
free
> -	 * list in the pool.  For this the ref count needs to be zero.
> -	 * Attempt to drop now, and retry once if needed.  It is VERY
> -	 * unlikely there is another ref on the page.
> -	 *
> -	 * If someone else has a reference to the page, it will be freed
> -	 * when they drop their ref.  Abuse temporary page flag to =
accomplish
> -	 * this.  Retry once if there is an inflated ref count.
> -	 */
> -	SetHPageTemporary(new_page);
> -	if (!put_page_testzero(new_page)) {
> -		if (alloc_retry)
> -			return -EBUSY;
> -
> -		alloc_retry =3D true;
> -		goto alloc_retry;
> -	}
> -	ClearHPageTemporary(new_page);
> -
> 	__prep_new_huge_page(h, new_page);
>=20
> retry:
> @@ -2934,6 +2907,7 @@ struct page *alloc_huge_page(struct =
vm_area_struct *vma,
> 		}
> 		spin_lock_irq(&hugetlb_lock);
> 		list_add(&page->lru, &h->hugepage_activelist);
> +		set_page_refcounted(page);
> 		/* Fall through */
> 	}
> 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, =
page);
> @@ -3038,7 +3012,7 @@ static void __init gather_bootmem_prealloc(void)
> 		if (prep_compound_gigantic_page(page, =
huge_page_order(h))) {
> 			WARN_ON(PageReserved(page));
> 			prep_new_huge_page(h, page, page_to_nid(page));
> -			put_page(page); /* add to the hugepage allocator =
*/
> +			free_huge_page(page); /* add to the hugepage =
allocator */
> 		} else {
> 			/* VERY unlikely inflated ref count on a tail =
page */
> 			free_gigantic_page(page, huge_page_order(h));
> @@ -3070,7 +3044,7 @@ static void __init =
hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> 					&node_states[N_MEMORY], NULL);
> 			if (!page)
> 				break;
> -			put_page(page); /* free it into the hugepage =
allocator */
> +			free_huge_page(page); /* free it into the =
hugepage allocator */
> 		}
> 		cond_resched();
> 	}
> @@ -3459,9 +3433,8 @@ static int demote_free_huge_page(struct hstate =
*h, struct page *page)
> 		else
> 			prep_compound_page(page + i, =
target_hstate->order);
> 		set_page_private(page + i, 0);
> -		set_page_refcounted(page + i);
> 		prep_new_huge_page(target_hstate, page + i, nid);
> -		put_page(page + i);
> +		free_huge_page(page + i);
> 	}
> 	mutex_unlock(&target_hstate->resize_lock);
>=20
> --=20
> 2.37.1
>=20
>=20

