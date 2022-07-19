Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3D578F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiGSAoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGSAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:44:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DEF2BB1F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658191443; x=1689727443;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=q5+VJDL3oTtOXslCW7UyHAdL/HccBlTnRViXZUYSzxc=;
  b=GGfxA0MsBg8I5iRxtmyEtHjr7LU2FohHko3dRrBBfv5A1ZWmJXsxqJl9
   E8c/Vkbhx65dGo4zawubb8k1uNdZduDmAEaf6SpkSA3AE3FK+RTDlEFqi
   LW2a/zGGR4m7WZZM3Xiir06I+d8o1O6DaYK1KlwsQnoCzfti65738Hev7
   BRJwSFoGiA5/vPT5w+Vl7LP8jdp8Jzvo+o15tpuqELJ6cbC9YKgsXqFdJ
   6Sapb0StIRFR8ya2nPQNhYuP7PxLFFAF594+0JHlhmkExNu1ysP3dj0I/
   bKNThmIwHEP53S0RKdC5ENkjWKKuZvLzheHekWU0LsUSf80sRtinC4yGm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="372658868"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="372658868"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:44:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="572628190"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:43:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, steven.price@arm.com, will@kernel.org,
        aarcange@redhat.com, guojian@oppo.com, hanchuanhua@oppo.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        minchan@kernel.org, shy828301@gmail.com, v-songbaohua@oppo.com,
        zhangshiming@oppo.com
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
References: <20220718090050.2261-1-21cnbao@gmail.com>
Date:   Tue, 19 Jul 2022 08:43:47 +0800
In-Reply-To: <20220718090050.2261-1-21cnbao@gmail.com> (Barry Song's message
        of "Mon, 18 Jul 2022 21:00:50 +1200")
Message-ID: <87mtd62apo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> THP_SWAP has been proven to improve the swap throughput significantly
> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> splitting THP after swapped out").
> As long as arm64 uses 4K page size, it is quite similar with x86_64
> by having 2MB PMD THP. THP_SWAP is architecture-independent, thus,
> enabling it on arm64 will benefit arm64 as well.
> A corner case is that MTE has an assumption that only base pages
> can be swapped. We won't enable THP_SWAP for ARM64 hardware with
> MTE support until MTE is reworked to coexist with THP_SWAP.
>
> A micro-benchmark is written to measure thp swapout throughput as
> below,
>
>  unsigned long long tv_to_ms(struct timeval tv)
>  {
>  	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>  }
>
>  main()
>  {
>  	struct timeval tv_b, tv_e;;
>  #define SIZE 400*1024*1024
>  	volatile void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>  				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	if (!p) {
>  		perror("fail to get memory");
>  		exit(-1);
>  	}
>
>  	madvise(p, SIZE, MADV_HUGEPAGE);
>  	memset(p, 0x11, SIZE); /* write to get mem */
>
>  	gettimeofday(&tv_b, NULL);
>  	madvise(p, SIZE, MADV_PAGEOUT);
>  	gettimeofday(&tv_e, NULL);
>
>  	printf("swp out bandwidth: %ld bytes/ms\n",
>  			SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>  }
>
> Testing is done on rk3568 64bit quad core processor Quad Core
> Cortex-A55 platform - ROCK 3A.
> thp swp throughput w/o patch: 2734bytes/ms (mean of 10 tests)
> thp swp throughput w/  patch: 3331bytes/ms (mean of 10 tests)
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
>  -v3: 
>  * refine the commit log;
>  * add a benchmark result;
>  * refine the macro of arch_thp_swp_supported
>  Thanks to the comments of Anshuman, Andrew, Steven
>
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/pgtable.h |  6 ++++++
>  include/linux/huge_mm.h          | 12 ++++++++++++
>  mm/swap_slots.c                  |  2 +-
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1652a9800ebe..e1c540e80eec 100644
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
> index 0b6632f18364..78d6f6014bfb 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -45,6 +45,12 @@
>  	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +static inline bool arch_thp_swp_supported(void)
> +{
> +	return !system_supports_mte();
> +}
> +#define arch_thp_swp_supported arch_thp_swp_supported
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
> + * false
> + */
> +#ifndef arch_thp_swp_supported
> +static inline bool arch_thp_swp_supported(void)
> +{
> +	return true;
> +}

How about the following?

static inline bool arch_wants_thp_swap(void)
{
     return IS_ENABLED(ARCH_WANTS_THP_SWAP);
}

Best Regards,
Huang, Ying

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
