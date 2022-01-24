Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49649885E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245255AbiAXSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiAXSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:31:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E97C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ZxSf7vRGmtmjPRVRuc/UAtt0g7lispoIvSffcp1Qyk=; b=g6yrZ37hc7PRrLe90OF1G9oYOT
        5dOCrI/gA/wzT/K15vRfpSwCqD1iRC10W4iuptigIekHQWhPfOktVNreow1Dq20yJEmQkIWgC6JhV
        YhpVPX1SU1+k8QPzh05WdnlpyD6H0/n9EjArlOvcwTnPUVL9hVBPivaiIgJnZlBj9n6JE1B+basIC
        tSyVzTf2zn6XwgIHtI5u8NB7CRqKR3FX7dBseDx74wr/qmQWxJYNea5eF0q00IDnk/sOwQGc1GvZ7
        lyy+CKiMGen5ZSGss9V/Bk8jWm55T5xXDO4TjUEnQ8/m3awaoICONB9FTpOUMI5oNpgqB1zd9YSNn
        ukSyu7hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC47v-001452-K9; Mon, 24 Jan 2022 18:31:39 +0000
Date:   Mon, 24 Jan 2022 18:31:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: make 'highmem' symbol ro_after_init
Message-ID: <Ye7wiwq/KFS3/bqL@casper.infradead.org>
References: <20220124170555.1054480-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170555.1054480-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:05:55PM +0100, Ard Biesheuvel wrote:
> The 'highmem' variable is only set at boot, so we can make it
> ro_after_init and prevent it from being corrupted inadvertently, or from
> ending up in a contended cacheline.

I'm not against this patch, but it'd be nice to go further and remove
it entirely for !CONFIG_HIGHMEM builds?  Adding something like

static inline bool is_high_pfn(unsigned long pfn)
{
#ifdef CONFIG_HIGHMEM
	return pfn <= max_low_pfn;
#else
	return false;
#endif
}

static inline bool is_high_phys(phys_addr_t pa)
{
	return is_high_pfn(pa / PAGE_SIZE);
}

static inline bool is_high_addr(void *addr)
{
	return is_high_phys(virt_to_phys(addr));
}

should be all the primitives you need, from a quick grep.

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..50e82cb94ccc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -106,7 +106,7 @@ EXPORT_SYMBOL(mem_map);
>   * highstart_pfn must be the same; there must be no gap between ZONE_NORMAL
>   * and ZONE_HIGHMEM.
>   */
> -void *high_memory;
> +void *high_memory __ro_after_init;
>  EXPORT_SYMBOL(high_memory);
>  
>  /*
> -- 
> 2.30.2
> 
> 
