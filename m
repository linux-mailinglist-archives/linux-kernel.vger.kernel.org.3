Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EDC4A6C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244734AbiBBHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:03:23 -0500
Received: from foss.arm.com ([217.140.110.172]:39664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239384AbiBBHDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:03:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 583E6ED1;
        Tue,  1 Feb 2022 22:25:42 -0800 (PST)
Received: from [10.163.43.221] (unknown [10.163.43.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A167A3F718;
        Tue,  1 Feb 2022 22:25:36 -0800 (PST)
Subject: Re: [PATCH v5 1/4] mm/debug_vm_pgtable: remove pte entry from the
 page table
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        will@kernel.org, rppt@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com
References: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
 <20220131203249.2832273-2-pasha.tatashin@soleen.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2b3bddd8-e869-a717-b849-d03f30e583c5@arm.com>
Date:   Wed, 2 Feb 2022 11:55:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220131203249.2832273-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/22 2:02 AM, Pasha Tatashin wrote:
> The pte entry that is used in pte_advanced_tests() is never removed from
> the page table at the end of the test.
> 
> The issue is detected by page_table_check, to repro compile kernel with
> the following configs:
> 
> CONFIG_DEBUG_VM_PGTABLE=y
> CONFIG_PAGE_TABLE_CHECK=y
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
> 
> During the boot the following BUG is printed:
> 
> [    2.262821] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating
>                architecture page table helpers
> [    2.276826] ------------[ cut here ]------------
> [    2.280426] kernel BUG at mm/page_table_check.c:162!
> [    2.284118] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [    2.287787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>                5.16.0-11413-g2c271fe77d52 #3
> [    2.293226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>                BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org
>                04/01/2014
> ...
> 
> The entry should be properly removed from the page table before the page
> is released to the free list.
> 
> Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")
> Cc: stable@vger.kernel.org # 5.9+

Not sure marking stable is necessary here.

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Rientjes <rientjes@google.com>

Dont see any problems on arm64. Although it would be great to run this
on all enabled platforms.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

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
>  
>  static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
> 
