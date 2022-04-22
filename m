Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE85C50B2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389127AbiDVI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352963AbiDVI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3F52E64;
        Fri, 22 Apr 2022 01:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 999D161FDE;
        Fri, 22 Apr 2022 08:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B304BC385A4;
        Fri, 22 Apr 2022 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650615862;
        bh=VZe04wi9Ke1WpooTFqZ15tO/MjgK1FO8qd/uJToj3Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwwEHEHm2Ma97jStCDyTuowW/EJpEo2brMRPLwYkscX+vZ0y40ShSuC0xXJrlMZLa
         xGdHODv60Vr4GH4JG7nMd9bk3D1pTOlXGyEvTFDf1QYD4qL/WAMD9sIc8FN1r+zneJ
         mrXlAHE4xs7kzBye6xymR8SqS8XyXO8Wz0ZUUBgdHDNFdd8X2BcJu6DJRA9RuuKCnT
         Nt94O5Y2oHiNFmXK1Ws+cejfKO9o2Hoii14u/I8Rs5nMU0nivYbc5jXXV0F2NZD6RE
         xth+GpJBj1+wprn5x/k1gZHn0AzWiPa8vx7UAjg39037MaOd+BogTDYYtPD7hPcr3Z
         1tPd+eydP2kOQ==
Date:   Fri, 22 Apr 2022 11:24:14 +0300
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
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <YmJmLrS3hPR6gOaw@kernel.org>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421180200.16901-2-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:01:57PM +0200, Fabio M. De Francesco wrote:
> `scripts/kernel-doc -v -none include/linux/highmem*` reports the following
> warnings:
> 
> include/linux/highmem.h:160: warning: expecting prototype for kunmap_atomic(). Prototype was for nr_free_highpages() instead
> include/linux/highmem.h:204: warning: No description found for return value of 'alloc_zeroed_user_highpage_movable'
> include/linux/highmem-internal.h:256: warning: Function parameter or member '__addr' not described in 'kunmap_atomic'
> include/linux/highmem-internal.h:256: warning: Excess function parameter 'addr' description in 'kunmap_atomic'
> 
> Fix these warnings by (1) moving the kernel-doc comments from highmem.h to
> highmem-internal.h (which is the file were the kunmap_atomic() macro is
> actually defined), (2) extending and merging it with the comment which was
> already in highmem-internal.h, and (3) using correct parameter names.
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem-internal.h | 14 +++++++++++---
>  include/linux/highmem.h          | 15 +++------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index a77be5630209..b099a08e29d3 100644
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
> + * Unmap an address previously mapped by kmap_atomic() and re-enables

Unmap ... and re-enable

or 

Unmaps ... and re-enables

Other than that

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> + * pagefaults and preemption. Mappings should be unmapped in the reverse
> + * order that they were mapped. See kmap_local_page() for details.
> + * @__addr can be any address within the mapped page, so there is no need
> + * to subtract any offset that has been added. In contrast to kunmap(),
> + * this function takes the address returned from kmap_atomic(), not the
> + * page passed to it. The compiler will warn you if you pass the page.
>   */
>  #define kunmap_atomic(__addr)					\
>  do {								\
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 39bb9b47fa9c..c3d562b5f0c1 100644
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
> @@ -191,6 +180,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   * @vma: The VMA the page is to be allocated for
>   * @vaddr: The virtual address the page will be inserted into
>   *
> + * Returns: The allocated and zeroed HIGHMEM page
> + *
>   * This function will allocate a page for a VMA that the caller knows will
>   * be able to migrate in the future using move_pages() or reclaimed
>   *
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
