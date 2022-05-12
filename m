Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C897524A10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352528AbiELKNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352516AbiELKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:13:09 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B166212;
        Thu, 12 May 2022 03:13:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VD-IJYp_1652350382;
Received: from 30.39.157.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VD-IJYp_1652350382)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 18:13:03 +0800
Message-ID: <6412e6c5-6e5e-aa7f-b549-64c9c43d8e98@linux.alibaba.com>
Date:   Thu, 12 May 2022 18:13:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: build failure after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220512193855.4f6ce32f@canb.auug.org.au>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220512193855.4f6ce32f@canb.auug.org.au>
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



On 5/12/2022 5:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
> arch/arm64/mm/hugetlbpage.c:493:16: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
>    493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>        |                ^~~~~~~~~~~~~~~
>        |                ptep_clear_flush
> arch/arm64/mm/hugetlbpage.c:493:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
>    493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/mm/hugetlbpage.c:494:1: error: control reaches end of non-void function [-Werror=return-type]
>    494 | }
>        | ^
> 
> Caused by commit
> 
>    00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original pte")
> 
> interacting with commit
> 
>    fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
> 
> I have applied the following merg fix patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 12 May 2022 19:33:11 +1000
> Subject: [PATCH] fixup for "mm: change huge_ptep_clear_flush() to return the original pte"
> 
> It interacts with commit
> 
>    fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
> 
> from the arm64 tree
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks. Looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/arm64/mm/hugetlbpage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 5bdf913dedc7..30f5b76aabe9 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -490,7 +490,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   		return ptep_clear_flush(vma, addr, ptep);
>   
>   	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> -	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
>   }
>   
>   static int __init hugetlbpage_init(void)
