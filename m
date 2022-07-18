Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0C5786F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiGRQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiGRQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:07:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5219C2B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3XVB/nlrkvDOmjrjaiTf3FsIIT/RNdtwVa0SsHwoaZ8=; b=WyPbVehXqWMqowQ5bKPyc4QfGM
        IDfPKec/SOw6IEsOAsQJ3a94He/hMADv4zEIktxFk+Qk9W4Y99DZQtHjbaQ1Hv+oRKKksSQ689Ez3
        qPkNnK9CJkhgeDmN/H4tU3WNSEROIAjvgVxyclSsrGWe4dFzvDhbcnf89Im2zo381KhiowupCK+1b
        wuRQL88Nyn/Uw+XiI6JoJ6iFrWAG+vOIY4yGU+d8ZWOZSXdd4gEqM9vmsocP0h2mpFv7nHtEpKDe8
        V8VChy+aC0ai8bVAky66dAPlZtTYVwQW/fyygG+zcxZYcDJtzT9MOIJcsEsP5G2hthZkBsPa8QK5I
        GDvzSGuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDTGn-00CoMn-3m; Mon, 18 Jul 2022 16:06:53 +0000
Date:   Mon, 18 Jul 2022 17:06:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, steven.price@arm.com, will@kernel.org,
        aarcange@redhat.com, guojian@oppo.com, hanchuanhua@oppo.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        minchan@kernel.org, shy828301@gmail.com, v-songbaohua@oppo.com,
        ying.huang@intel.com, zhangshiming@oppo.com
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
Message-ID: <YtWFHfs0mYonWBwH@casper.infradead.org>
References: <20220718090050.2261-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718090050.2261-1-21cnbao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 09:00:50PM +1200, Barry Song wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1652a9800ebe..e1c540e80eec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -101,6 +101,7 @@ config ARM64
>  	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	select ARCH_WANT_LD_ORPHAN_WARN
>  	select ARCH_WANTS_NO_INSTR
> +	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES

Can't you avoid all the other changes by simply doing:

	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES && !ARM64_MTE

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
> -- 
> 2.25.1
> 
> 
