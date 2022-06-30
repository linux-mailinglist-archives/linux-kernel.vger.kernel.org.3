Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7729561BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiF3Nrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiF3NrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F82A259
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EAC961FF8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336A8C3411E;
        Thu, 30 Jun 2022 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656596833;
        bh=vI/AUt/uyOdN66LwqebDxg7Xme7QwqdUUsoL+9G6xI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFgd5VtNN9LGfIXfWD0uTQXM1Ocq2WfLCMyyn95xRcQW06dNNIxlkRduyfvzQszyL
         kT0w8VnEG9t0E4EA0ekRLY8/9k6nA2pEiilmQLmOCgUp54JFjeviO/flyW+JB9wwWN
         fiZhROuBoTBaE+lk1TFFIxsO8G8tsk5jz1wE6NU8La6yPUuRwG+f3wimwe4sGUUk+K
         irRN6qXYgthUcktJjdoukxjEmOzNPh3tgc+RLzPHLgLocNwBngBHuGIFRZvF6AFvKE
         SgpWABXdy5Xk7rbNeVnzRHF5pC3WMNrQAwPhVRwFVpCoDsz/0ESd+qeF5vnWjBqCuE
         E8YjI9qnHOldQ==
Date:   Thu, 30 Jun 2022 16:46:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        ardb@kernel.org, linux-mm@kvack.org, yaohongbo@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
Message-ID: <Yr2pT8SLznI6beqS@kernel.org>
References: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
> The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
> (enable crashkernel, disable rodata full, disable kfence), the mem_map will
> use non block/section mapping(for crashkernel requires to shrink the region
> in page granularity). But it will degrade performance when doing larging
> continuous mem access in kernel(memcpy/memmove, etc).
> 
> There are many changes and discussions:
> commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones")
> commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into
> mem_init()")
> commit 2687275a5843 ("arm64: Force NO_BLOCK_MAPPINGS if crashkernel
> reservation is required")
> 
> This patch changes mem_map to use block/section mapping with crashkernel.
> Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
> mem_map, reserve crashkernel memory. And then walking pagetable to split
> block/section mapping to non block/section mapping(normally 4K) [[[only]]]
> for crashkernel mem. So the linear mem mapping use block/section mapping
> as more as possible. We will reduce the cpu dTLB miss conspicuously, and
> accelerate mem access about 10-20% performance improvement.

...
 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/mmu.h |   1 +
>  arch/arm64/mm/init.c         |   8 +-
>  arch/arm64/mm/mmu.c          | 231 ++++++++++++++++++++++++++++++-------------
>  3 files changed, 168 insertions(+), 72 deletions(-)

...

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 626ec32..4b779cf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,6 +42,7 @@
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
> +#define NO_SEC_REMAPPINGS	BIT(3)	/* rebuild with non block/sec mapping*/
>  
>  u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
>  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
> @@ -156,11 +157,12 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>  }
>  
>  static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -		     phys_addr_t phys, pgprot_t prot)
> +		     phys_addr_t phys, pgprot_t prot, int flags)
>  {
>  	pte_t *ptep;
>  
> -	ptep = pte_set_fixmap_offset(pmdp, addr);
> +	ptep = (flags & NO_SEC_REMAPPINGS) ? pte_offset_kernel(pmdp, addr) :
> +		pte_set_fixmap_offset(pmdp, addr);
>  	do {
>  		pte_t old_pte = READ_ONCE(*ptep);
>  
> @@ -176,7 +178,8 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		phys += PAGE_SIZE;
>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
>  
> -	pte_clear_fixmap();
> +	if (!(flags & NO_SEC_REMAPPINGS))
> +		pte_clear_fixmap();
>  }
>  
>  static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> @@ -208,16 +211,59 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  		next = pte_cont_addr_end(addr, end);
>  
>  		/* use a contiguous mapping if the range is suitably aligned */
> -		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> +		if (!(flags & NO_SEC_REMAPPINGS) &&
> +		   (((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
>  		    (flags & NO_CONT_MAPPINGS) == 0)
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> -		init_pte(pmdp, addr, next, phys, __prot);
> +		init_pte(pmdp, addr, next, phys, __prot, flags);
>  
>  		phys += next - addr;
>  	} while (addr = next, addr != end);
>  }
>  
> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
> +			   phys_addr_t phys, pgprot_t prot,
> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +	phys_addr_t map_offset;
> +	pmdval_t pmdval;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
> +			pmd_clear(pmdp);
> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> +			if (flags & NO_EXEC_MAPPINGS)
> +				pmdval |= PMD_TABLE_PXN;
> +			__pmd_populate(pmdp, pte_phys, pmdval);
> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +			map_offset = addr - (addr & PMD_MASK);
> +			if (map_offset)
> +			    alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
> +						phys - map_offset, prot,
> +						pgtable_alloc,
> +						flags & (~NO_SEC_REMAPPINGS));
> +
> +			if (next < (addr & PMD_MASK) + PMD_SIZE)
> +			    alloc_init_cont_pte(pmdp, next,
> +					       (addr & PUD_MASK) + PUD_SIZE,
> +					        next - addr + phys,
> +						prot, pgtable_alloc,
> +						flags & (~NO_SEC_REMAPPINGS));
> +		}
> +		alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> +				    pgtable_alloc, flags);
> +		phys += next - addr;
> +	} while (pmdp++, addr = next, addr != end);
> +}

There is still to much duplicated code here and in init_pud_remap().

Did you consider something like this:

void __init map_crashkernel(void)
{
	int flags = NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
	u64 size;

	/*
	 * check if crash kernel supported, reserved etc
	 */


	size = crashk_res.end + 1 - crashk_res.start;

	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
	__create_pgd_mapping(swapper_pg_dir, crashk_res.start,
			     __phys_to_virt(crashk_res.start), size,
			     PAGE_KERNEL, early_pgtable_alloc, flags);
}

...

-- 
Sincerely yours,
Mike.
