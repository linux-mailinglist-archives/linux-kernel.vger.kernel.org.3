Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50F6566169
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiGECqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGECqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:46:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C12A1277D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 19:46:12 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LcRp22hFrzkWhL;
        Tue,  5 Jul 2022 10:44:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 10:46:09 +0800
Subject: Re: [mm-unstable PATCH v4 3/9] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-4-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <83aff2eb-7190-7f5d-d81d-3eff0f56c40e@huawei.com>
Date:   Tue, 5 Jul 2022 10:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220704013312.2415700-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/7/4 9:33, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> follow_pud_mask() does not support non-present pud entry now.  As long as
> I tested on x86_64 server, follow_pud_mask() still simply returns
> no_page_table() for non-present_pud_entry() due to pud_bad(), so no severe
> user-visible effect should happen.  But generally we should call
> follow_huge_pud() for non-present pud entry for 1GB hugetlb page.
> 
> Update pud_huge() and follow_huge_pud() to handle non-present pud entries.
> The changes are similar to previous works for pud entries commit e66f17ff7177
> ("mm/hugetlb: take page table lock in follow_huge_pmd()") and commit
> cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage").
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> v2 -> v3:
> - fixed typos in subject and description,
> - added comment on pud_huge(),
> - added comment about fallback for hwpoisoned entry,
> - updated initial check about FOLL_{PIN,GET} flags.
> ---
>  arch/x86/mm/hugetlbpage.c |  8 +++++++-
>  mm/hugetlb.c              | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 509408da0da1..6b3033845c6d 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -30,9 +30,15 @@ int pmd_huge(pmd_t pmd)
>  		(pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
>  }
>  
> +/*
> + * pud_huge() returns 1 if @pud is hugetlb related entry, that is normal
> + * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
> + * Otherwise, returns 0.
> + */
>  int pud_huge(pud_t pud)
>  {
> -	return !!(pud_val(pud) & _PAGE_PSE);
> +	return !pud_none(pud) &&
> +		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
>  }

Question: Is aarch64 supported too? It seems aarch64 version of pud_huge matches
the requirement naturally for me.

Anyway, this patch looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.

>  
>  #ifdef CONFIG_HUGETLB_PAGE
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ad621688370b..66bb39e0fce8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6994,10 +6994,38 @@ struct page * __weak
>  follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  		pud_t *pud, int flags)
>  {
> -	if (flags & (FOLL_GET | FOLL_PIN))
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t pte;
> +
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
>  		return NULL;
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
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
>  }
>  
>  struct page * __weak
> 

