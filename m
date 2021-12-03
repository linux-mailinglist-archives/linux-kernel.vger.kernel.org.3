Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE8546735D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379248AbhLCIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:45:16 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35913 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244591AbhLCIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:45:15 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CAFF66000E;
        Fri,  3 Dec 2021 08:41:49 +0000 (UTC)
Message-ID: <d7238da5-6a47-dcf6-9615-050856fc2dc9@ghiti.fr>
Date:   Fri, 3 Dec 2021 09:41:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 5/5] riscv: mm: init: try best to remove #ifdef
 CONFIG_XIP_KERNEL usage
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211203050317.2102-1-jszhang@kernel.org>
 <20211203050317.2102-6-jszhang@kernel.org>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211203050317.2102-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 06:03, Jisheng Zhang wrote:
> Currently, the #ifdef CONFIG_XIP_KERNEL usage can be divided into the
> following three types:
>
> The first one is for functions/declarations only used in XIP case.
>
> The second one is for XIP_FIXUP case. Something as below:
> |foo_type foo;
> |#ifdef CONFIG_XIP_KERNEL
> |#define foo    (*(foo_type *)XIP_FIXUP(&foo))
> |#endif
>
> Usually, it's better to let the foo macro sit with the foo var
> together. But if various foos are defined adjacently, we can
> save some #ifdef CONFIG_XIP_KERNEL usage by grouping them together.
>
> The third one is for different implementations for XIP, usually, this
> is a #ifdef...#else...#endif case.
>
> This patch moves the pt_ops macro to adjacent #ifdef CONFIG_XIP_KERNEL
> and group first usage case into one.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4a9e3f429042..aeae7d6b2fee 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -40,10 +40,6 @@ EXPORT_SYMBOL(kernel_map);
>   phys_addr_t phys_ram_base __ro_after_init;
>   EXPORT_SYMBOL(phys_ram_base);
>   
> -#ifdef CONFIG_XIP_KERNEL
> -extern char _xiprom[], _exiprom[], __data_loc;
> -#endif
> -
>   unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>   							__page_aligned_bss;
>   EXPORT_SYMBOL(empty_zero_page);
> @@ -227,10 +223,6 @@ static void __init setup_bootmem(void)
>   #ifdef CONFIG_MMU
>   static struct pt_alloc_ops pt_ops __initdata;
>   
> -#ifdef CONFIG_XIP_KERNEL
> -#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
> -#endif
> -
>   unsigned long riscv_pfn_base __ro_after_init;
>   EXPORT_SYMBOL(riscv_pfn_base);
>   
> @@ -242,6 +234,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>   static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>   
>   #ifdef CONFIG_XIP_KERNEL
> +#define pt_ops			(*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
>   #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
>   #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
>   #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
> @@ -445,6 +438,8 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>   }
>   
>   #ifdef CONFIG_XIP_KERNEL
> +extern char _xiprom[], _exiprom[], __data_loc;
> +
>   /* called from head.S with MMU off */
>   asmlinkage void __init __copy_data(void)
>   {


Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex

