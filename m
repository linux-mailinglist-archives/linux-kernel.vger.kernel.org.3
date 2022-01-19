Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C212493206
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiASAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiASAvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:51:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSFNXBAL3L/sZMcUTYCHF8j9CNgzUTePNEfP42fi6WM=; b=ITKBmPkjINkr+kVaj6Y+dKIcDI
        BvqOngu/9IT5Rn4s9sTLn2PzesWshv2YBsi96+rofQ3+BVYoqVcjkMtC6rlUmPtTMSq/ul5NyOAI/
        q9DfCSH+rEK9qqPiFSGY2rKngDe1XMI3RfAvmOn5EOBwbK7ns9ErE/q+y6JdyZZMHbSjln06B+F5d
        HQZHhSFi8mSfC9SP34IMzIrPdTN5zgIjUDjXMh1S7jqBjTqVUJ0QXKMfoUJYqorDpNzxB298VO7vG
        XIkw1MnizDFVQjXTcqksKReY9AwdDKZBSf1YV0Kkn1jYYD8jqYGonSDHHpgNXaVS+PGt16D+BzX3X
        cqw5cPlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9zCB-009rPJ-HZ; Wed, 19 Jan 2022 00:51:27 +0000
Date:   Wed, 19 Jan 2022 00:51:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Message-ID: <Yedgj+Lo2eru8197@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118235244.540103-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:52:44PM -0800, Yury Norov wrote:
> vmap() takes struct page *pages as one of arguments, and user may provide
> an invalid pointer which would lead to DABT at address translation later.

Could we spell out 'DABT'?  Presumably that's an ARM-specific thing.
Just like we don't say #PF for Intel page faults, I think this is
probably a 'data abort'?

> Currently, kernel checks the pages against NULL. In my case, however, the
> address was not NULL, and was big enough so that the hardware generated
> Address Size Abort on arm64.
> 
> Interestingly, this abort happens even if copy_from_kernel_nofault() is
> used, which is quite inconvenient for debugging purposes. 
> 
> This patch adds a pfn_valid() check into vmap() path, so that invalid
> mapping will not be created.
> 
> RFC: https://lkml.org/lkml/2022/1/18/815
> v1: use pfn_valid() instead of adding an arch-specific
>     arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>

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
>  		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
>  		(*nr)++;
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
> -- 
> 2.30.2
> 
