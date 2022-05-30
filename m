Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E25374E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiE3HH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiE3HHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:07:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A03356392
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:07:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7898113E;
        Mon, 30 May 2022 00:07:10 -0700 (PDT)
Received: from [10.163.36.153] (unknown [10.163.36.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 095A03F73D;
        Mon, 30 May 2022 00:07:04 -0700 (PDT)
Message-ID: <b2694573-a696-8435-70eb-ebc9c06500a0@arm.com>
Date:   Mon, 30 May 2022 12:37:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: enable THP_SWAP for arm64
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, linux-mm@kvack.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshiming@oppo.com, guojian@oppo.com, hanchuanhua@oppo.com,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220527100644.293717-1-21cnbao@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220527100644.293717-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Barry,

On 5/27/22 15:36, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> THP_SWAP has been proved to improve the swap throughput significantly
> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> splitting THP after swapped out").
It will be useful to run similar experiments on arm64 platform to
demonstrate tangible benefit, else we might be just enabling this
feature just because x86 has it. Do you have some data points ?

> As long as arm64 uses 4K page size, it is quite similar with x86_64
> by having 2MB PMD THP. So we are going to get similar improvement.

This is an assumption without any data points (until now). Please
do provide some results.

> For other page sizes such as 16KB and 64KB, PMD might be too large.
> Negative side effects such as IO latency might be a problem. Thus,
> we can only safely enable the counterpart of X86_64.

Incorrect reasoning. Although sometimes it might be okay to enable
a feature on platforms with possible assumptions about its benefits,
but to claim 'similar improvement, safely, .. etc' while comparing
against x86 4K page config without data points, is not very helpful.

> A corner case is that MTE has an assumption that only base pages
> can be swapped. We won't enable THP_SWP for ARM64 hardware with
> MTE support until MTE is re-arched.

re-arched ?? Did you imply that MTE is reworked to support THP ?

> 
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/pgtable.h |  2 ++
>  include/linux/huge_mm.h          | 12 ++++++++++++
>  mm/swap_slots.c                  |  2 +-
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4968845e67f..5306009df2dc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -101,6 +101,7 @@ config ARM64
>  	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	select ARCH_WANT_LD_ORPHAN_WARN
>  	select ARCH_WANTS_NO_INSTR
> +	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b6632f18364..06076139c72c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -45,6 +45,8 @@
>  	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +#define arch_thp_swp_supported !system_supports_mte

Does it check for 'system_supports_mte' as a symbol or call system_supports_mte()
to ascertain runtime MTE support ? It might well be correct, but just does not
look much intuitive.

> +
>  /*
>   * Outside of a few very special situations (e.g. hibernation), we always
>   * use broadcast TLB invalidation instructions, therefore a spurious page
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index de29821231c9..4ddaf6ad73ef 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -461,4 +461,16 @@ static inline int split_folio_to_list(struct folio *folio,
>  	return split_huge_page_to_list(&folio->page, list);
>  }
>  
> +/*
> + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> + * limitations in the implementation like arm64 MTE can override this to

A small nit.

A 'comma' here will be better. s/arm64 MTE can/arm64 MTE, can/

> + * false

Similarly a 'full stop' here will be better as well.

> + */
> +#ifndef arch_thp_swp_supported
> +static inline bool arch_thp_swp_supported(void)
> +{
> +	return true;
> +}
> +#endif
> +
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 2a65a89b5b4d..10b94d64cc25 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  	entry.val = 0;
>  
>  	if (folio_test_large(folio)) {
> -		if (IS_ENABLED(CONFIG_THP_SWAP))
> +		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
>  			get_swap_pages(1, &entry, folio_nr_pages(folio));
>  		goto out;
>  	}

- Anshuman
