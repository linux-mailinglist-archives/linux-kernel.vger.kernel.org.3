Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14281534A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiEZHBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiEZHBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:01:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88271255AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:01:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C76D31474;
        Thu, 26 May 2022 00:01:47 -0700 (PDT)
Received: from [10.162.43.8] (unknown [10.162.43.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236A63F73D;
        Thu, 26 May 2022 00:01:44 -0700 (PDT)
Message-ID: <428c7c69-6ac1-51d5-7c26-5f31de61a909@arm.com>
Date:   Thu, 26 May 2022 12:31:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/hugetlb: Remove unnecessary
 huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 15:56, Baolin Wang wrote:
> There is no need to update the hugetlb access flags after just setting the
> hugetlb page table entry by set_huge_pte_at(), since the page table entry
> value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#9: 
value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()

total: 0 errors, 1 warnings, 8 lines checked

> in hugetlb_mcopy_atomic_pte().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Otherwise LGTM,

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/hugetlb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7c468ac..3ad49bf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6032,8 +6032,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
>  
> -	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
> -					dst_vma->vm_flags & VM_WRITE);
>  	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
>  
>  	/* No need to invalidate - it was non-present before */
