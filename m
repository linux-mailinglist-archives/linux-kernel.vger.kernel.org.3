Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72ED4729A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhLMKXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:23:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239528AbhLMKQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:16:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E945F1FB;
        Mon, 13 Dec 2021 02:16:37 -0800 (PST)
Received: from [10.163.67.80] (unknown [10.163.67.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5325E3F793;
        Mon, 13 Dec 2021 02:16:34 -0800 (PST)
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
To:     Jianyong Wu <jianyong.wu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org
Cc:     ardb@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@redhat.com,
        gshan@redhat.com, justin.he@arm.com, nd@arm.com
References: <20211210095432.51798-1-jianyong.wu@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1e63e2f7-0563-2866-4665-84fe220b615f@arm.com>
Date:   Mon, 13 Dec 2021 15:46:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211210095432.51798-1-jianyong.wu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/21 3:24 PM, Jianyong Wu wrote:
> fixmap is a global resource and is used recursively in create pud mapping.
> It may lead to race condition when alloc_init_pud is called concurrently.
> 
> Fox example:
> alloc_init_pud is called when kernel_init. If memory hotplug
> thread, which will also call alloc_init_pud, happens during
> kernel_init, the race for fixmap occurs.
> 
> The race condition flow can be:
> 
> *************** begin **************
> 
> kerenl_init thread                          virtio-mem workqueue thread
> ==================                          ======== ==================
> alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
> ...                                         ...
>     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
> ...                                         ...
>   pud_clear_fixmap() //fixmap break
>                                               READ_ONCE(*pudp) //CRASH!
> 
> **************** end ***************
> 
> Hence, a spin lock is introduced to protect the fixmap during create pdg
> mapping.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b41cc8..98ac09ae9588 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> +static DEFINE_SPINLOCK(fixmap_lock);
>  
>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	}
>  	BUG_ON(p4d_bad(p4d));
>  
> +	/*
> +	 * fixmap is global resource, thus it needs to be protected by a lock
> +	 * in case of race condition.
> +	 */

Small nit, format and align this comment block. I guess
could also be done while merging this patch as well.

> +	spin_lock(&fixmap_lock);
>  	pudp = pud_set_fixmap_offset(p4dp, addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
> @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	} while (pudp++, addr = next, addr != end);
>  
>  	pud_clear_fixmap();
> +	spin_unlock(&fixmap_lock);
>  }
>  
>  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
