Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F613545D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbiFJHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbiFJHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:20:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51F368FAB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:20:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKC4p28G8zjXS8;
        Fri, 10 Jun 2022 15:19:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 15:20:05 +0800
Subject: Re: [v3 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <vbabka@suse.cz>, <kirill.shutemov@linux.intel.com>,
        <willy@infradead.org>, <akpm@linux-foundation.org>
References: <20220606214414.736109-1-shy828301@gmail.com>
 <20220606214414.736109-3-shy828301@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8ba0f470-af80-1087-4361-eacbcbc52d90@huawei.com>
Date:   Fri, 10 Jun 2022 15:20:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220606214414.736109-3-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/7 5:44, Yang Shi wrote:
> There are couple of places that check whether the vma size is ok for
> THP or not, they are open coded and duplicate, introduce
> transhuge_vma_size_ok() helper to do the job.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/huge_mm.h | 17 +++++++++++++++++
>  mm/huge_memory.c        |  5 +----
>  mm/khugepaged.c         | 12 ++++++------
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 648cb3ce7099..a8f61db47f2a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
>  
>  extern unsigned long transparent_hugepage_flags;
>  
> +/*
> + * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
> + */
> +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> +{
> +	if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
> +	    (vma->vm_end & HPAGE_PMD_MASK))
> +		return true;
> +
> +	return false;
> +}
> +
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  		unsigned long addr)
>  {
> @@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  		unsigned long addr)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48182c8fe151..36ada544e494 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>  
>  bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
> -	/* The addr is used to check if the vma size fits */
> -	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> -
> -	if (!transhuge_vma_suitable(vma, addr))

There is also pgoff check for file page in transhuge_vma_suitable. Is it ignored
deliberately?

> +	if (!transhuge_vma_size_ok(vma))
>  		return false;
>  	if (vma_is_anonymous(vma))
>  		return __transparent_hugepage_enabled(vma);
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 84b9cf4b9be9..d0f8020164fc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -454,6 +454,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>  				vma->vm_pgoff, HPAGE_PMD_NR))
>  		return false;
>  
> +	if (!transhuge_vma_size_ok(vma))
> +		return false;
> +
>  	/* Enabled via shmem mount options or sysfs settings. */
>  	if (shmem_file(vma->vm_file))
>  		return shmem_huge_enabled(vma);
> @@ -512,9 +515,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  unsigned long vm_flags)
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> -	    khugepaged_enabled() &&
> -	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> -	     (vma->vm_end & HPAGE_PMD_MASK))) {
> +	    khugepaged_enabled()) {
>  		if (hugepage_vma_check(vma, vm_flags))
>  			__khugepaged_enter(vma->vm_mm);
>  	}

After this change, khugepaged_enter_vma is identical to khugepaged_enter. Should one of
them be removed?

Thanks!

> @@ -2142,10 +2143,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  			progress++;
>  			continue;
>  		}
> -		hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> +
> +		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
>  		hend = vma->vm_end & HPAGE_PMD_MASK;
> -		if (hstart >= hend)
> -			goto skip;
>  		if (khugepaged_scan.address > hend)
>  			goto skip;
>  		if (khugepaged_scan.address < hstart)
> 

