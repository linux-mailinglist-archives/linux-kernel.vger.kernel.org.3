Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8752CB71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiESFQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiESFQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:16:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A55479E9F1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:16:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B2F150C;
        Wed, 18 May 2022 22:06:38 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF64F3F66F;
        Wed, 18 May 2022 22:06:35 -0700 (PDT)
Message-ID: <381ed251-ecd0-4047-6ba3-793f23904b2c@arm.com>
Date:   Thu, 19 May 2022 10:36:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] arm64: Add HAVE_IOREMAP_PROT support
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <20220429103225.75121-6-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220429103225.75121-6-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/22 16:02, Kefeng Wang wrote:
> With ioremap_prot() defination from generic ioremap, also move

s/defination/definition  ^^^^

> pte_pgprot() from hugetlbpage.c into pgtable.h, then arm64 could
> have HAVE_IOREMAP_PROT, which will enable generic_access_phys()
> code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  .../features/vm/ioremap_prot/arch-support.txt          |  2 +-
>  arch/arm64/Kconfig                                     |  1 +
>  arch/arm64/include/asm/pgtable.h                       | 10 ++++++++++
>  arch/arm64/mm/hugetlbpage.c                            | 10 ----------
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
> index a6dcbe5f47b6..b39ad5d61216 100644
> --- a/Documentation/features/vm/ioremap_prot/arch-support.txt
> +++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: |  ok  |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: |  ok  |
>      |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 56673209fdb9..5e5889049af0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -186,6 +186,7 @@ config ARM64
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
> +	select HAVE_IOREMAP_PROT
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KVM
>  	select HAVE_NMI
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index dff2b483ea50..1402a2739024 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -402,6 +402,16 @@ static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
>  	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
>  }
>  
> +/*
> + * Select all bits except the pfn
> + */
> +static inline pgprot_t pte_pgprot(pte_t pte)
> +{
> +	unsigned long pfn = pte_pfn(pte);
> +
> +	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
> +}
> +
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * See the comment in include/linux/pgtable.h
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index cbace1c9e137..38d03406f6aa 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -100,16 +100,6 @@ int pud_huge(pud_t pud)
>  #endif
>  }
>  
> -/*
> - * Select all bits except the pfn
> - */
> -static inline pgprot_t pte_pgprot(pte_t pte)
> -{
> -	unsigned long pfn = pte_pfn(pte);
> -
> -	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
> -}
> -
>  static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>  			   pte_t *ptep, size_t *pgsize)
>  {
