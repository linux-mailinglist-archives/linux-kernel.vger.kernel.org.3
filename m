Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB855A8A3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiFYJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiFYJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:42:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F336148
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:42:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LVTXQ3Ym2zDsSD;
        Sat, 25 Jun 2022 17:41:42 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 17:42:18 +0800
Subject: Re: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <098b5a5c-2c05-4e22-b1ba-81f858391cd6@huawei.com>
Date:   Sat, 25 Jun 2022 17:42:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/24 7:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> follow_pud_mask() does not support non-present pud entry now.  As long as
> I tested on x86_64 server, follow_pud_mask() still simply returns
> no_page_table() for non-present_pud_entry() due to pud_bad(), so no severe
> user-visible effect should happen.  But generally we should call
> follow_huge_pud() for non-present pud entry for 1GB hugetlb page.
> 
> Update pud_huge() and huge_pud() to handle non-present pud entries.  The
> changes are similar to previous works for pud entries commit e66f17ff7177
> ("mm/hugetlb: take page table lock in follow_huge_pmd()") and commit
> cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage").
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  arch/x86/mm/hugetlbpage.c |  3 ++-
>  mm/hugetlb.c              | 26 +++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index a0d023cb4292..5fb86fb49ba8 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -70,7 +70,8 @@ int pmd_huge(pmd_t pmd)
>  

No strong opinion but a comment similar to pmd_huge might be better?

/*
 * pmd_huge() returns 1 if @pmd is hugetlb related entry, that is normal
 * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
 * Otherwise, returns 0.
 */

>  int pud_huge(pud_t pud)
>  {
> -	return !!(pud_val(pud) & _PAGE_PSE);
> +	return !pud_none(pud) &&
> +		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
>  }
>  #endif
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f59f43c06601..b7ae5f73f3b2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6946,10 +6946,34 @@ struct page * __weak
>  follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  		pud_t *pud, int flags)
>  {
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t pte;
> +
>  	if (flags & (FOLL_GET | FOLL_PIN))
>  		return NULL;

Should the above check be modified? It seems the below try_grab_page might not grab the page as
expected (as Mike pointed out). Or the extra page refcnt is unneeded?

>  
> -	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> +retry:
> +	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
> +	if (!pud_huge(*pud))
> +		goto out;
> +	pte = huge_ptep_get((pte_t *)pud);
> +	if (pte_present(pte)) {
> +		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (is_hugetlb_entry_migration(pte)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait(mm, (pte_t *)pud, ptl);
> +			goto retry;
> +		}

Again. No strong opinion but a comment similar to follow_huge_pmd might be better?

/*
 * hwpoisoned entry is treated as no_page_table in
 * follow_page_mask().
 */

Thanks!

> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
>  }
>  
>  struct page * __weak
> 

