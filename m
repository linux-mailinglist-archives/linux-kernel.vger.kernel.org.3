Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AE50AF35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443970AbiDVEnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiDVEn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:43:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B85312DD70
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:40:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 476D31570;
        Thu, 21 Apr 2022 21:40:34 -0700 (PDT)
Received: from [10.163.40.48] (unknown [10.163.40.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AA053F5A1;
        Thu, 21 Apr 2022 21:40:26 -0700 (PDT)
Message-ID: <e9faaec1-0ddd-5691-7996-aff6f54ab160@arm.com>
Date:   Fri, 22 Apr 2022 10:11:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v5 1/5] mm: page_table_check: using PxD_SIZE instead
 of PxD_PAGE_SIZE
Content-Language: en-US
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-2-tongtiangen@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220421082042.1167967-2-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 13:50, Tong Tiangen wrote:
> Macro PUD_SIZE/PMD_SIZE is more general in various architectures. Using
> PUD_SIZE/PMD_SIZE instead of PUD_PAGE_SIZE/PMD_PAGE_SIZE can better
> support page table check in architectures other than x86 and it is no
> functional impact on x86.> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

There are multiple structural problems in the commit message wording
but will leave them upto Andrew, if he could fix while merging.

Otherwise LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/page_table_check.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 2458281bff89..eb0d0b71cdf6 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -177,7 +177,7 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>  
>  	if (pmd_user_accessible_page(pmd)) {
>  		page_table_check_clear(mm, addr, pmd_pfn(pmd),
> -				       PMD_PAGE_SIZE >> PAGE_SHIFT);
> +				       PMD_SIZE >> PAGE_SHIFT);
>  	}
>  }
>  EXPORT_SYMBOL(__page_table_check_pmd_clear);
> @@ -190,7 +190,7 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>  
>  	if (pud_user_accessible_page(pud)) {
>  		page_table_check_clear(mm, addr, pud_pfn(pud),
> -				       PUD_PAGE_SIZE >> PAGE_SHIFT);
> +				       PUD_SIZE >> PAGE_SHIFT);
>  	}
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_clear);
> @@ -219,7 +219,7 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>  	__page_table_check_pmd_clear(mm, addr, *pmdp);
>  	if (pmd_user_accessible_page(pmd)) {
>  		page_table_check_set(mm, addr, pmd_pfn(pmd),
> -				     PMD_PAGE_SIZE >> PAGE_SHIFT,
> +				     PMD_SIZE >> PAGE_SHIFT,
>  				     pmd_write(pmd));
>  	}
>  }
> @@ -234,7 +234,7 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>  	__page_table_check_pud_clear(mm, addr, *pudp);
>  	if (pud_user_accessible_page(pud)) {
>  		page_table_check_set(mm, addr, pud_pfn(pud),
> -				     PUD_PAGE_SIZE >> PAGE_SHIFT,
> +				     PUD_SIZE >> PAGE_SHIFT,
>  				     pud_write(pud));
>  	}
>  }
