Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A47524B18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352996AbiELLMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352988AbiELLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:12:45 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED7527EC;
        Thu, 12 May 2022 04:12:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VD-YkUJ_1652353959;
Received: from 30.39.157.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VD-YkUJ_1652353959)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 19:12:40 +0800
Message-ID: <188f7cb2-ba21-a53a-828d-7242b17b0c72@linux.alibaba.com>
Date:   Thu, 12 May 2022 19:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: build failure after merge of the mm tree
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220512193855.4f6ce32f@canb.auug.org.au>
 <YnzqffV7STYS24Yn@arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YnzqffV7STYS24Yn@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2022 7:07 PM, Catalin Marinas wrote:
> On Thu, May 12, 2022 at 07:38:55PM +1000, Stephen Rothwell wrote:
>> After merging the mm tree, today's linux-next build (arm64 defconfig)
>> failed like this:
>>
>> arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
>> arch/arm64/mm/hugetlbpage.c:493:16: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
>>    493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>>        |                ^~~~~~~~~~~~~~~
>>        |                ptep_clear_flush
>> arch/arm64/mm/hugetlbpage.c:493:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
>>    493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/mm/hugetlbpage.c:494:1: error: control reaches end of non-void function [-Werror=return-type]
>>    494 | }
>>        | ^
>>
>> Caused by commit
>>
>>    00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original pte")
>>
>> interacting with commit
>>
>>    fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
>>
>> I have applied the following merg fix patch for today.
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Thu, 12 May 2022 19:33:11 +1000
>> Subject: [PATCH] fixup for "mm: change huge_ptep_clear_flush() to return the original pte"
>>
>> It interacts with commit
>>
>>    fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
>>
>> from the arm64 tree
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>   arch/arm64/mm/hugetlbpage.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 5bdf913dedc7..30f5b76aabe9 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -490,7 +490,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>   		return ptep_clear_flush(vma, addr, ptep);
>>   
>>   	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
>> -	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>> +	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
>>   }
> 
> Note that after the arm64 commit, get_clear_contig() no longer flushes
> the TLB. So maybe something like:
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 30f5b76aabe9..9a999550df8e 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -485,12 +485,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   	size_t pgsize;
>   	int ncontig;
> +	pte_t orig_pte;
> 
>   	if (!pte_cont(READ_ONCE(*ptep)))
>   		return ptep_clear_flush(vma, addr, ptep);
> 
>   	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> -	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
> +	return orig_pte;
>   }

Yes, after checking this fb396bb459c1 ("arm64/hugetlb: Drop TLB flush 
from get_clear_flush()"), I also realized it will miss TLB flush.

So I am not sure I need send a incremental patch to fix this issue? Or 
resend my patch set [1] with rebasing on the arm64 changes?

Catalin and Andrew, how do you think? Thanks.

[1] 
https://lore.kernel.org/all/cover.1652270205.git.baolin.wang@linux.alibaba.com/
