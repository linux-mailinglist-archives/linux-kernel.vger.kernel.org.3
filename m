Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135A64F810E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbiDGN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDGN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:56:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2A14B039
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DXxNPzETJNuKIBTHSCLD6jKCdsUNJU2Z62bqM3GMnPE=; b=AgcmlkO5TLsyW5xOuatXKvxlIh
        jgZhx7Bl1iJKrafqkTBWYDqb52EOVniCao4Iw8Q9+UHC/WiLmTbnEsKTi08fXNcJU6H8vOn5H6QEB
        QAnV39A9ZV+h6tTHLu+91KRNFGcj0CEZZ64WpnW6L/RVo+Ur0sWynRNZ96IQ/DUFPMT5WnCsP54yi
        5ZxNvpDqGadrw2mUmBS4rTkSeqNT2JD/Nu6YiwERsvXkU1p1tpExcVDIt2psRm0REQLRqmBwmUlAz
        2CLFeFwNVZhWHRbap0+xvXmVkEk9XCgA3mMaAf4EDu6u2gs8QuLpiZeqLAH4UB9G20fFsd7Gtl7GO
        VbM9pk9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncSax-008seI-0m; Thu, 07 Apr 2022 13:54:43 +0000
Date:   Thu, 7 Apr 2022 14:54:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix kernel NULL pointer dereference in
 page_vma_mapped_walk
Message-ID: <Yk7tIi4UKjiqQyoF@casper.infradead.org>
References: <20220407064008.71869-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407064008.71869-1-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:40:08PM +0800, zhenwei pi wrote:
> size_to_hstate(4K) returns NULL pointer, this leads kernel BUG in
> function page_vma_mapped_walk.

Yes, I think this is the right fix.  It's not immediately obvious from
the bug and the patch, but what's going on is:

page_mapped_in_vma() sets nr_pages to 1.  This is correct because we
usually only want to know about the precise page, and not about the
folio containing it.  But hugetlbfs is special (... in so many ways ...)
and actually wants to work on the entire folio.  We could set nr_pages
specially for hugetlb pages, but it's better to ignore it in
page_vma_mapped_walk() for the hugetlb case.

I'll fix up the changelog and add it to my pile of fixes that I'm
sending tomorrow.
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next

> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 1187f9c1ec5b..a39ec23581c9 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -163,7 +163,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		return not_found(pvmw);
>  
>  	if (unlikely(is_vm_hugetlb_page(vma))) {
> -		unsigned long size = pvmw->nr_pages * PAGE_SIZE;
> +		unsigned long size = huge_page_size(hstate_vma(vma));
>  		/* The only possible mapping was handled on last iteration */
>  		if (pvmw->pte)
>  			return not_found(pvmw);
> -- 
> 2.25.1
> 
