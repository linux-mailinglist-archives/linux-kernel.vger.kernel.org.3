Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B352CB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiESFeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiESFeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:34:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE774B87C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:34:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4330415BF;
        Wed, 18 May 2022 22:34:20 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CD043F66F;
        Wed, 18 May 2022 22:34:16 -0700 (PDT)
Message-ID: <25a90892-957c-e5b4-e121-948e85d3caee@arm.com>
Date:   Thu, 19 May 2022 11:04:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 resend 4/5] arm64: mm: Convert to GENERIC_IOREMAP
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
References: <20220429103225.75121-5-wangkefeng.wang@huawei.com>
 <20220502032751.21503-1-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220502032751.21503-1-wangkefeng.wang@huawei.com>
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



On 5/2/22 08:57, Kefeng Wang wrote:
> Add hook for arm64's special operation when ioremap() and iounmap(),
> then ioremap_wc/np/cache is converted to use ioremap_prot()
> from GENERIC_IOREMAP, update the Copyright and kill the unused
> inclusions.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2 resend:
> - use IOMEM_ERR_PTR to fix sparse warning found by lkp
> 
>  arch/arm64/Kconfig          |  1 +
>  arch/arm64/include/asm/io.h | 20 ++++++---
>  arch/arm64/kernel/acpi.c    |  2 +-
>  arch/arm64/mm/ioremap.c     | 85 +++++--------------------------------
>  4 files changed, 27 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 20ea89d9ac2f..56673209fdb9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -123,6 +123,7 @@ config ARM64
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_IDLE_POLL_SETUP
> +	select GENERIC_IOREMAP
>  	select GENERIC_IRQ_IPI
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 7fd836bea7eb..042fa01940b8 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -163,13 +163,21 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>  /*
>   * I/O memory mapping functions.
>   */
> -extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot);
> -extern void iounmap(volatile void __iomem *addr);
> -extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>  
> -#define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
> -#define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
> -#define ioremap_np(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
> +void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
> +#define arch_ioremap arch_ioremap
> +
> +int arch_iounmap(void __iomem *addr);
> +#define arch_iounmap arch_iounmap
> +
> +#define _PAGE_IOREMAP PROT_DEVICE_nGnRE

Small nit, should we have a comment here for the above components i.e
PAGE_IOREMAP and callbacks arch_ioremap()/arch_iounmap() are required
because of enabling GENERIC_IOREMAP ?

> +
> +#define ioremap_wc(addr, size)		ioremap_prot((addr), (size), PROT_NORMAL_NC)
> +#define ioremap_np(addr, size)		ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
> +#define ioremap_cache(addr, size) ({							\
> +	pfn_is_map_memory(__phys_to_pfn(addr)) ?					\
> +	(void __iomem *)__phys_to_virt(addr) : ioremap_prot(addr, size, PROT_NORMAL);	\
> +})
>  
>  /*
>   * io{read,write}{16,32,64}be() macros
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e4dea8db6924..a5a256e3f9fe 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -351,7 +351,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  				prot = __acpi_get_writethrough_mem_attribute();
>  		}
>  	}
> -	return __ioremap(phys, size, prot);
> +	return ioremap_prot(phys, size, pgprot_val(prot));
>  }
>  
>  /*
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index b7c81dacabf0..08fc30eb2721 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -1,96 +1,33 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Based on arch/arm/mm/ioremap.c
> - *
> - * (C) Copyright 1995 1996 Linus Torvalds
> - * Hacked for ARM by Phil Blundell <philb@gnu.org>
> - * Hacked to allow all architectures to build, and various cleanups
> - * by Russell King
> - * Copyright (C) 2012 ARM Ltd.
> - */
>  
> -#include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/io.h>
>  
> -#include <asm/fixmap.h>
> -#include <asm/tlbflush.h>
> -
> -static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
> -				      pgprot_t prot, void *caller)
> +void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
>  {
> -	unsigned long last_addr;
> -	unsigned long offset = phys_addr & ~PAGE_MASK;
> -	int err;
> -	unsigned long addr;
> -	struct vm_struct *area;
> -
> -	/*
> -	 * Page align the mapping address and size, taking account of any
> -	 * offset.
> -	 */
> -	phys_addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(size + offset);
> +	unsigned long last_addr = phys_addr + size - 1;
> +	int ret = -EINVAL;
>  
> -	/*
> -	 * Don't allow wraparound, zero size or outside PHYS_MASK.
> -	 */
> -	last_addr = phys_addr + size - 1;
> -	if (!size || last_addr < phys_addr || (last_addr & ~PHYS_MASK))
> -		return NULL;
> +	/* Don't allow outside PHYS_MASK */
> +	if (last_addr & ~PHYS_MASK)
> +		return IOMEM_ERR_PTR(ret);
>  
> -	/*
> -	 * Don't allow RAM to be mapped.
> -	 */
> +	/* Don't allow RAM to be mapped. */
>  	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
> -		return NULL;
> +		return IOMEM_ERR_PTR(ret);
>  
> -	area = get_vm_area_caller(size, VM_IOREMAP, caller);
> -	if (!area)
> -		return NULL;
> -	addr = (unsigned long)area->addr;
> -	area->phys_addr = phys_addr;
> -
> -	err = ioremap_page_range(addr, addr + size, phys_addr, prot);
> -	if (err) {
> -		vunmap((void *)addr);
> -		return NULL;
> -	}
> -
> -	return (void __iomem *)(offset + addr);
> -}
> -
> -void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
> -{
> -	return __ioremap_caller(phys_addr, size, prot,
> -				__builtin_return_address(0));
> +	return NULL;
>  }
> -EXPORT_SYMBOL(__ioremap);
>  
> -void iounmap(volatile void __iomem *io_addr)
> +int arch_iounmap(void __iomem *addr)
>  {
> -	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
> -
>  	/*
>  	 * We could get an address outside vmalloc range in case
>  	 * of ioremap_cache() reusing a RAM mapping.
>  	 */
> -	if (is_vmalloc_addr((void *)addr))
> -		vunmap((void *)addr);
> -}
> -EXPORT_SYMBOL(iounmap);
> -
> -void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
> -{
> -	/* For normal memory we already have a cacheable mapping. */
> -	if (pfn_is_map_memory(__phys_to_pfn(phys_addr)))
> -		return (void __iomem *)__phys_to_virt(phys_addr);
> -
> -	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
> -				__builtin_return_address(0));
> +	return is_vmalloc_addr(addr) ? 0 : -EINVAL;
>  }
> -EXPORT_SYMBOL(ioremap_cache);
>  
>  /*
>   * Must be called after early_fixmap_init

Otherwise LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
