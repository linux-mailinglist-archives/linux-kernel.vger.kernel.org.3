Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29B7495892
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiAUDhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 22:37:31 -0500
Received: from foss.arm.com ([217.140.110.172]:35536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbiAUDha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:37:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FEC1101E;
        Thu, 20 Jan 2022 19:37:30 -0800 (PST)
Received: from [10.163.74.170] (unknown [10.163.74.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE793F766;
        Thu, 20 Jan 2022 19:37:21 -0800 (PST)
Subject: Re: [PATCH v2 1/3] mm/debug_vm_pgtable: remove pte entry from the
 page table
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        will@kernel.org, rppt@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com
References: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
 <20220120191250.2671557-2-pasha.tatashin@soleen.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <406f41ab-5ed9-7c2e-6bc8-afcae32164c5@arm.com>
Date:   Fri, 21 Jan 2022 09:07:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220120191250.2671557-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/22 12:42 AM, Pasha Tatashin wrote:
> The pte entry that is used in pte_advanced_tests() is never removed from
> the page table at the end of the test.
> 
> The issue is detected by page_table_check, to repro compile kernel with
> the following configs:
> 
> CONFIG_DEBUG_VM_PGTABLE=y
> CONFIG_PAGE_TABLE_CHECK=y
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=y

Assuming this is on latest mainline.

I could enable PAGE_TABLE_CHECK on arm64 after some hacks. It did not build
on the platform otherwise. But enabling DEBUG_VM_PGTABLE afterwards did not
create below mentioned problems. Is the problem x86 specific ?

> 
> During the boot the following BUG is printed:
> 
> [    7.483050][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]:
> Validating architecture page tabs
> [    7.490930][    T1] ------------[ cut here ]------------
> [    7.494926][    T1] kernel BUG at mm/page_table_check.c:194!

Which BUG() is this ? mm/page_table_check.c:194 on latest mainline ..

void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
                                  pud_t pud) <----

> [    7.499172][    T1] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [    7.503610][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0+
> [    7.508600][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
> ...
> 
> The entry should be properly removed from the page table before the page
> is released to the free list.
> 
> Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")
I am not sure whether this really fixes an existing problem.

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/debug_vm_pgtable.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index a7ac97c76762..db2abd9e415b 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -171,6 +171,8 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>  	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
>  	pte = ptep_get(args->ptep);
>  	WARN_ON(pte_young(pte));
> +
> +	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
>  }

Although I dont see any problem on arm64 after this change.

>  
>  static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
>
