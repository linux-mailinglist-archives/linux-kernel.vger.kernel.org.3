Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849DB493960
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354091AbiASLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:17:38 -0500
Received: from foss.arm.com ([217.140.110.172]:54034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354083AbiASLRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:17:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1945ED1;
        Wed, 19 Jan 2022 03:17:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.3.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97B953F73D;
        Wed, 19 Jan 2022 03:17:34 -0800 (PST)
Date:   Wed, 19 Jan 2022 11:16:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Message-ID: <YefzAQ5LXJk1ytfI@FVFF77S0Q05N>
References: <20220118235244.540103-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118235244.540103-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I replied ot the original RFC before spotting this; duplicating those comments
here because I think they apply regardless of the mechanism used to work around
this.

On Tue, Jan 18, 2022 at 03:52:44PM -0800, Yury Norov wrote:
> vmap() takes struct page *pages as one of arguments, and user may provide
> an invalid pointer which would lead to DABT at address translation later. 
>
> Currently, kernel checks the pages against NULL. In my case, however, the
> address was not NULL, and was big enough so that the hardware generated
> Address Size Abort on arm64.

Can you give an example of when this might happen? It sounds like you're
actually hitting this, so a backtrace would be nice.

I'm a bit confused as to when why we'd try to vmap() pages that we
didn't have a legitimate struct page for -- where did these addresses
come from?

It sounds like this is going wrong at a higher level, and we're passing
entirely bogus struct page pointers around. This seems like the sort of
thing DEBUG_VIRTUAL or similar should check when we initially generate
the struct page pointer.

> Interestingly, this abort happens even if copy_from_kernel_nofault() is
> used, which is quite inconvenient for debugging purposes. 

I can go take a look at this, but TBH we never expect to take an address size
fault to begin with, so this is arguably correct -- it's an internal
consistency problem.

> This patch adds a pfn_valid() check into vmap() path, so that invalid
> mapping will not be created.
> 
> RFC: https://lkml.org/lkml/2022/1/18/815
> v1: use pfn_valid() instead of adding an arch-specific
>     arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..a4134ee56b10 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  			return -EBUSY;
>  		if (WARN_ON(!page))
>  			return -ENOMEM;
> +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> +			return -EINVAL;

My fear here is that for this to fire, we've already passed a bogus struct page
pointer around the intermediate infrastructure, and any of that might try to
use it in unsafe ways (in future even if we don't use it today).

I think the fundamental issue here is that we generate a bogus struct page
pointer at all, and knowing where that came from would help to fix that.

Thanks,
Mark.

>  		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
>  		(*nr)++;
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
> -- 
> 2.30.2
> 
