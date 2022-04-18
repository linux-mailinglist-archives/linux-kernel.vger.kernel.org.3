Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8F505B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiDRPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbiDRPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0638A7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B7560F55
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6235DC385A7;
        Mon, 18 Apr 2022 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650292994;
        bh=pCzNBiYtmbJhPHrsJO++0NSN3gB8rHy4nNJp5dK5FG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJXdSyX93GEMJI06EbNkh/Mx/o3MyrubhqW4DG+Zt2+TaUCJmVuML6PM1TO06BJrE
         MivA7r0x7D5w9wCnMwGCNcMsGQkPY7m1keQ9klUF+OgB4qPI3jOfDC6pCBwuFGTrkR
         2dOsLJySE+GWedUqzsQ95oXc3etEnJwdc/dCkS3s2aeFNrVVe/zHon4uBXpXDS0q83
         IfHD46LXVgpN6TTmSYpLGm1d02+8FJw2TtxZGUxAL32tPR2b+gc8B6ktJgtfTfUOdd
         wCLZW55kRRGz9w/mtfl8hP4/lAnBrKqAmB2e+8DzsJknmKBP0TZV/O7EMm6BmsDMzI
         SeCFP6BLXEFYA==
Date:   Mon, 18 Apr 2022 17:43:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <Yl14+RJjFU58yNpR@kernel.org>
References: <20220418075304.20259-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418075304.20259-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 09:53:04AM +0200, Fabio M. De Francesco wrote:
> `scripts/kernel-doc -none include/linux/highmem*` reports the following
> warnings:
> 
> include/linux/highmem.h:160: warning: expecting prototype for kunmap_atomic(). Prototype was for nr_free_highpages() instead
> include/linux/highmem-internal.h:256: warning: Function parameter or member '__addr' not described in 'kunmap_atomic'
> include/linux/highmem-internal.h:256: warning: Excess function parameter 'addr' description in 'kunmap_atomic'
> 
> Fix these warnings by (1) move the kernel-doc comments from highmem.h to
> highmem-internal.h (which is the file were the kunmap_atomic() macro is
> actually defined), merge it with the comment which already was in

                   ^ (2) ?

> highmem-internal.h, and (3) replace "@addr" with "@__addr".

There is also replacement of "addr" with "page", so I'd phrase (3) as
"use correct parameter names"
 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Other than that

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/highmem-internal.h | 14 +++++++++++---
>  include/linux/highmem.h          | 13 +------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index a77be5630209..7307de391288 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
>  
>  #endif /* CONFIG_HIGHMEM */
>  
> -/*
> - * Prevent people trying to call kunmap_atomic() as if it were kunmap()
> - * kunmap_atomic() should get the return value of kmap_atomic, not the page.
> +/**
> + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> + * @__addr:       Virtual address to be unmapped
> + *
> + * Counterpart to kmap_atomic().
> + *
> + * Effectively a wrapper around kunmap_local() which additionally undoes
> + * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> + * preemption. Prevent people trying to call kunmap_atomic() as if it
> + * were kunmap() because kunmap_atomic() should get the return value of
> + * kmap_atomic(), not its argument which is a pointer to struct page.
>   */
>  #define kunmap_atomic(__addr)					\
>  do {								\
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 39bb9b47fa9c..0a7a89721e5d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -37,7 +37,7 @@ static inline void *kmap(struct page *page);
>  
>  /**
>   * kunmap - Unmap the virtual address mapped by kmap()
> - * @addr:	Virtual address to be unmapped
> + * @page:	Virtual address to be unmapped
>   *
>   * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
>   * pages in the low memory area.
> @@ -145,17 +145,6 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   */
>  static inline void *kmap_atomic(struct page *page);
>  
> -/**
> - * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> - * @addr:	Virtual address to be unmapped
> - *
> - * Counterpart to kmap_atomic().
> - *
> - * Effectively a wrapper around kunmap_local() which additionally undoes
> - * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> - * preemption.
> - */
> -
>  /* Highmem related interfaces for management code */
>  static inline unsigned int nr_free_highpages(void);
>  static inline unsigned long totalhigh_pages(void);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
