Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4384CCBBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiCDC00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiCDC0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:26:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFA1704FB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:25:37 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8s5x3gxNzZdbj;
        Fri,  4 Mar 2022 10:20:53 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:25:35 +0800
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <aarcange@redhat.com>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>
References: <20220303222014.517033-1-shy828301@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <78dab4e0-1d68-c54b-2463-c0a5420b07d9@huawei.com>
Date:   Fri, 4 Mar 2022 10:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220303222014.517033-1-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/4 6:20, Yang Shi wrote:
> The commit c444eb564fb1 ("mm: thp: make the THP mapcount atomic against
> __split_huge_pmd_locked()") locked the page for PMD split to make
> mapcount stable for reuse_swap_page(), then commit 1c2f67308af4 ("mm:
> thp: fix MADV_REMOVE deadlock on shmem THP") reduce the scope to
> anonymous page only.
> 
> However COW has not used mapcount to determine if the page is shared or
> not anymore due to the COW fixes [1] from David Hildenbrand and the
> reuse_swap_page() was removed as well.  So PMD split doesn't have to
> lock the page anymore.  This patch basically reverted the above two
> commits.
> 

Sounds reasonable. Since mapcount is not used to determine if we need to COW
the page, PMD split doesn't have to lock the page anymore.

> [1] https://lore.kernel.org/linux-mm/20220131162940.210846-1-david@redhat.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/huge_memory.c | 44 +++++---------------------------------------
>  1 file changed, 5 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b49e1a11df2e..daaa698bd273 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2134,8 +2134,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  {
>  	spinlock_t *ptl;
>  	struct mmu_notifier_range range;
> -	bool do_unlock_folio = false;
> -	pmd_t _pmd;
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
>  				address & HPAGE_PMD_MASK,
> @@ -2148,48 +2146,16 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * pmd against. Otherwise we can end up replacing wrong folio.
>  	 */
>  	VM_BUG_ON(freeze && !folio);
> -	if (folio) {
> -		VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -		if (folio != page_folio(pmd_page(*pmd)))
> -			goto out;
> -	}
> +	if (folio && folio != page_folio(pmd_page(*pmd)))
> +		goto out;
>  
> -repeat:
> -	if (pmd_trans_huge(*pmd)) {
> -		if (!folio) {
> -			folio = page_folio(pmd_page(*pmd));
> -			/*
> -			 * An anonymous page must be locked, to ensure that a
> -			 * concurrent reuse_swap_page() sees stable mapcount;
> -			 * but reuse_swap_page() is not used on shmem or file,
> -			 * and page lock must not be taken when zap_pmd_range()
> -			 * calls __split_huge_pmd() while i_mmap_lock is held.
> -			 */
> -			if (folio_test_anon(folio)) {
> -				if (unlikely(!folio_trylock(folio))) {
> -					folio_get(folio);
> -					_pmd = *pmd;
> -					spin_unlock(ptl);
> -					folio_lock(folio);
> -					spin_lock(ptl);
> -					if (unlikely(!pmd_same(*pmd, _pmd))) {
> -						folio_unlock(folio);
> -						folio_put(folio);
> -						folio = NULL;
> -						goto repeat;
> -					}
> -					folio_put(folio);
> -				}
> -				do_unlock_folio = true;
> -			}
> -		}
> -	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> +	if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>  		goto out;
> +
>  	__split_huge_pmd_locked(vma, pmd, range.start, freeze);

IUUC, here should be something like below:
if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd))
        __split_huge_pmd_locked(vma, pmd, range.start, freeze);

i.e. the pmd_trans_huge case is missing in the above change. Or am I miss something ?

Thanks for the patch. This really simplify the code and avoid the unneeded overhead.

>  out:
>  	spin_unlock(ptl);
> -	if (do_unlock_folio)
> -		folio_unlock(folio);
> +
>  	/*
>  	 * No need to double call mmu_notifier->invalidate_range() callback.
>  	 * They are 3 cases to consider inside __split_huge_pmd_locked():
> 

