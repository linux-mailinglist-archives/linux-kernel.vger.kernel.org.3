Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D0550E69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiFTBhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiFTBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:37:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FC109
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:37:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LRBzz2Kcrz1KC2d;
        Mon, 20 Jun 2022 09:35:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 09:37:47 +0800
Subject: Re: [PATCH] mm/madvise: minor cleanup for swapin_walk_pmd_entry()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220618090527.37843-1-linmiaohe@huawei.com>
 <20220618115909.5f2d1a4da68cc4115e73d14a@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ac31de7c-4473-5479-b276-9602f0b7dd84@huawei.com>
Date:   Mon, 20 Jun 2022 09:37:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220618115909.5f2d1a4da68cc4115e73d14a@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/6/19 2:59, Andrew Morton wrote:
> On Sat, 18 Jun 2022 17:05:27 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Passing index to pte_offset_map_lock() directly so the below calculation
>> can be avoided. Rename orig_pte to ptep as it's not changed. Also use
>> helper is_swap_pte() to improve the readability. No functional change
>> intended.
>>
>> ...
>>
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -195,7 +195,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>>  static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>>  	unsigned long end, struct mm_walk *walk)
>>  {
>> -	pte_t *orig_pte;
>> +	pte_t *ptep;
>>  	struct vm_area_struct *vma = walk->private;
>>  	unsigned long index;
>>  	struct swap_iocb *splug = NULL;
>> @@ -209,11 +209,11 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>>  		struct page *page;
>>  		spinlock_t *ptl;
>>  
>> -		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
>> -		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
>> -		pte_unmap_unlock(orig_pte, ptl);
>> +		ptep = pte_offset_map_lock(vma->vm_mm, pmd, index, &ptl);
>> +		pte = *ptep;
>> +		pte_unmap_unlock(ptep, ptl);
>>  
>> -		if (pte_present(pte) || pte_none(pte))
>> +		if (!is_swap_pte(pte))
>>  			continue;
>>  		entry = pte_to_swp_entry(pte);
>>  		if (unlikely(non_swap_entry(entry)))
> 
> Also...
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-madvise-minor-cleanup-for-swapin_walk_pmd_entry-fix
> Date: Sat Jun 18 11:58:03 AM PDT 2022
> 
> reduce scope of `ptep'

Looks good to me. Thanks for doing this. :)

> 
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/madvise.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/mm/madvise.c~mm-madvise-minor-cleanup-for-swapin_walk_pmd_entry-fix
> +++ a/mm/madvise.c
> @@ -195,7 +195,6 @@ success:
>  static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>  	unsigned long end, struct mm_walk *walk)
>  {
> -	pte_t *ptep;
>  	struct vm_area_struct *vma = walk->private;
>  	unsigned long index;
>  	struct swap_iocb *splug = NULL;
> @@ -208,6 +207,7 @@ static int swapin_walk_pmd_entry(pmd_t *
>  		swp_entry_t entry;
>  		struct page *page;
>  		spinlock_t *ptl;
> +		pte_t *ptep;
>  
>  		ptep = pte_offset_map_lock(vma->vm_mm, pmd, index, &ptl);
>  		pte = *ptep;
> _
> 
> .
> 

