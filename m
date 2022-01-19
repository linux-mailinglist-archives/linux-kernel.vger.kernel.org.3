Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219E34937CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353338AbiASJzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:55:25 -0500
Received: from foss.arm.com ([217.140.110.172]:52016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240064AbiASJzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:55:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89B491FB;
        Wed, 19 Jan 2022 01:55:23 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5C253F766;
        Wed, 19 Jan 2022 01:55:21 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:55:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] arm64: don't vmap() invalid page
Message-ID: <20220119095514.GA42995@C02TD0UTHF1T.local>
References: <20220118185354.464517-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118185354.464517-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:53:54AM -0800, Yury Norov wrote:
> vmap() takes struct page *pages as one of arguments, and user may provide
> an invalid pointer, which would lead to DABT at address translation later.
> Currently, kernel checks the pages against NULL. In my case, however, the
> address was not NULL, and was big enough so that the hardware generated
> Address Size Abort.

Can you give an example of when this might happen? It sounds like you're
actually hitting this, so a backtrace would be nice.

I'm a bit confused as to when why we'd try to vmap() pages that we
didn't have a legitimate struct page for -- where did these addresses
come from?

It sounds like this is going wrong at a higher level, and we're passing
entirely bogus struct page pointers around. This seems like the sort of
thing DEBUG_VIRTUAL or similar should check when we initially generate
the struct page pointer.

Thanks,
Mark.

> Interestingly, this abort happens even if copy_from_kernel_nofault() is used,
> which is quite inconvenient for debugging purposes. 
> 
> This patch adds an arch_vmap_page_valid() helper into vmap() path, so that
> architectures may add arch-specific checks of the pointer passed into vmap.
> 
> For arm64, if the page passed to vmap() corresponds to a physical address
> greater than maximum possible value as described in TCR_EL1.IPS register, the
> following table walk would generate Address Size Abort. Instead of creating
> the invalid mapping, kernel will return ERANGE in such situation.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 41 ++++++++++++++++++++++++++++++++
>  include/linux/vmalloc.h          |  7 ++++++
>  mm/vmalloc.c                     |  8 +++++--
>  3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index b9185503feae..e9d43ee019ad 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -4,6 +4,47 @@
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  
> +static inline u64 pa_size(u64 ips)
> +{
> +	switch (ips) {
> +	case 0b000:
> +		return 1UL << 32;
> +	case 0b001:
> +		return 1UL << 36;
> +	case 0b010:
> +		return 1UL << 40;
> +	case 0b011:
> +		return 1UL << 42;
> +	case 0b100:
> +		return 1UL << 44;
> +	case 0b101:
> +		return 1UL << 48;
> +	case 0b110:
> +		return 1UL << 52;
> +	/* All other values */
> +	default:
> +		return 1UL << 52;
> +	}
> +}
> +
> +#define arch_vmap_page_valid arch_vmap_page_valid
> +static inline int arch_vmap_page_valid(struct page *page)
> +{
> +	u64 tcr, ips, paddr_size;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	tcr = read_sysreg_s(SYS_TCR_EL1);
> +	ips = (tcr & TCR_IPS_MASK) >> TCR_IPS_SHIFT;
> +
> +	paddr_size = pa_size(ips);
> +	if (page_to_phys(page) >= paddr_size)
> +		return -ERANGE;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  
>  #define arch_vmap_pud_supported arch_vmap_pud_supported
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 6e022cc712e6..08b567d8bafc 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -119,6 +119,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
>  }
>  #endif
>  
> +#ifndef arch_vmap_page_valid
> +static inline int arch_vmap_page_valid(struct page *page)
> +{
> +	return page ? 0 : -ENOMEM;
> +}
> +#endif
> +
>  /*
>   *	Highlevel APIs for driver use
>   */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..ee0384405cdd 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -472,11 +472,15 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  		return -ENOMEM;
>  	do {
>  		struct page *page = pages[*nr];
> +		int ret;
>  
>  		if (WARN_ON(!pte_none(*pte)))
>  			return -EBUSY;
> -		if (WARN_ON(!page))
> -			return -ENOMEM;
> +
> +		ret = arch_vmap_page_valid(page);
> +		if (WARN_ON(ret))
> +			return ret;
> +
>  		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
>  		(*nr)++;
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
> -- 
> 2.30.2
> 
