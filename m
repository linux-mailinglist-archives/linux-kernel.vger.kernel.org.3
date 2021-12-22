Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B515847CF48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbhLVJcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:32:11 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35365 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243935AbhLVJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:32:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V.Pguqk_1640165527;
Received: from 30.21.164.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.Pguqk_1640165527)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 17:32:08 +0800
Message-ID: <17421c73-2124-63c2-1925-dcea5c976711@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 17:32:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] mm/damon: Add access checking for hugetlb pages
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211222091007.16495-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211222091007.16495-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2021 5:10 PM, SeongJae Park wrote:
> Hi Baolin,
> 
> 
> Basically, the code looks ok to me.  I left so trivial cosmetic nitpicks below,
> though.
> 
> On Thu, 16 Dec 2021 18:38:03 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> The process's VMAs can be mapped by hugetlb page, but now the DAMON
>> did not implement the access checking for hugetlb pte, so we can not
>> get the actual access count like below if a process VMAs were mapped
>> by hugetlb.
>>
>> damon_aggregated: target_id=18446614368406014464
>> nr_regions=12 4194304-5476352: 0 545
>> damon_aggregated: target_id=18446614368406014464
>> nr_regions=12 140662370467840-140662372970496: 0 545
>> damon_aggregated: target_id=18446614368406014464
>> nr_regions=12 140662372970496-140662375460864: 0 545
>> damon_aggregated: target_id=18446614368406014464
>> nr_regions=12 140662375460864-140662377951232: 0 545
>> damon_aggregated: target_id=18446614368406014464
>> nr_regions=12 140662377951232-140662380449792: 0 545
>> damon_aggregated: target_id=18446614368406014464
>> nr_regions=12 140662380449792-140662382944256: 0 545
>> ......
> 
> I'd prefer indenting the program output with 4 spaces and not wrapping it.
> e.g.,
> 
>      damon_aggregated: target_id=18446614368406014464 nr_regions=12 4194304-5476352: 0 545
>      damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662370467840-140662372970496: 0 545

Sure.

>>
>> Thus this patch adds hugetlb access checking support, with this patch
>> we can see below VMA mapped by hugetlb access count.
>>
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296486649856-140296489914368: 1 3
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296489914368-140296492978176: 1 3
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296492978176-140296495439872: 1 3
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296495439872-140296498311168: 1 3
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296498311168-140296501198848: 1 3
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296501198848-140296504320000: 1 3
>> damon_aggregated: target_id=18446613056935405824
>> nr_regions=12 140296504320000-140296507568128: 1 2
>> ......
> 
> ditto.

Sure.

>> +static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
>> +				     unsigned long addr, unsigned long end,
>> +				     struct mm_walk *walk)
>> +{
>> +	struct hstate *h = hstate_vma(walk->vma);
>> +	spinlock_t *ptl;
>> +	pte_t entry;
>> +
>> +	ptl = huge_pte_lock(h, walk->mm, pte);
>> +	entry = huge_ptep_get(pte);
>> +	if (!pte_present(entry))
>> +		goto out;
>> +
>> +	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
>> +
>> +out:
>> +	spin_unlock(ptl);
>> +	return 0;
>> +}
>> +#else
>> +#define damon_mkold_hugetlb_entry NULL
>> +#endif
> 
> Could we append a comment saying this #endif is for #ifdef CONFIG_HUGETLB_PAGE,
> like below?
> 
>      #endif	/* CONFIG_HUGETLB_PAGE */

Sure.

>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
>> +				     unsigned long addr, unsigned long end,
>> +				     struct mm_walk *walk)
>> +{
>> +	struct damon_young_walk_private *priv = walk->private;
>> +	struct hstate *h = hstate_vma(walk->vma);
>> +	struct page *page;
>> +	spinlock_t *ptl;
>> +	pte_t entry;
>> +
>> +	ptl = huge_pte_lock(h, walk->mm, pte);
>> +	entry = huge_ptep_get(pte);
>> +	if (!pte_present(entry))
>> +		goto out;
>> +
>> +	page = pte_page(entry);
>> +	if (!page)
>> +		goto out;
>> +
>> +	get_page(page);
>> +
>> +	if (pte_young(entry) || !page_is_idle(page) ||
>> +	    mmu_notifier_test_young(walk->mm, addr)) {
>> +		*priv->page_sz = huge_page_size(h);
>> +		priv->young = true;
>> +	}
>> +
>> +	put_page(page);
>> +
>> +out:
>> +	spin_unlock(ptl);
>> +	return 0;
>> +}
>> +#else
>> +#define damon_young_hugetlb_entry NULL
>> +#endif
> 
> ditto.

Sure.

But I saw Andrew had applied this version into his branch.

Andrew, would you like me to send a new version? or an increment patch 
to fix the coding style issue? Thanks.
