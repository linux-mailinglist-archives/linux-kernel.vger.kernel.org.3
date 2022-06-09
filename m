Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE55453B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiFISGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbiFISGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:06:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A68D360895
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C6FBB82F57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8DDC34114;
        Thu,  9 Jun 2022 18:06:40 +0000 (UTC)
Date:   Thu, 9 Jun 2022 19:06:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v3 1/3] mm: kmemleak: add OBJECT_PHYS flag for objects
 allocated with physical address
Message-ID: <YqI2rE+YB/+06t3w@arm.com>
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
 <20220609124950.1694394-2-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609124950.1694394-2-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:49:48PM +0800, Patrick Wang wrote:
> @@ -1125,15 +1142,18 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>   *			 address argument
>   * @phys:	physical address of the object
>   * @size:	size of the object
> - * @min_count:	minimum number of references to this object.
> - *              See kmemleak_alloc()
>   * @gfp:	kmalloc() flags used for kmemleak internal memory allocations
>   */
> -void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
> -			       gfp_t gfp)
> +void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
>  {
> +	pr_debug("%s(0x%pa, %zu)\n", __func__, &phys, size);
> +
>  	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> -		kmemleak_alloc(__va(phys), size, min_count, gfp);
> +		/*
> +		 * Create object with OBJECT_PHYS flag and
> +		 * assume min_count 0.
> +		 */
> +		create_object_phys((unsigned long)__va(phys), size, 0, gfp);
>  }
>  EXPORT_SYMBOL(kmemleak_alloc_phys);
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8e56..749abd2685c4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1345,8 +1345,8 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>   * from the regions with mirroring enabled and then retried from any
>   * memory region.
>   *
> - * In addition, function sets the min_count to 0 using kmemleak_alloc_phys for
> - * allocated boot memory block, so that it is never reported as leaks.
> + * In addition, function using kmemleak_alloc_phys for allocated boot
> + * memory block, it is never reported as leaks.
>   *
>   * Return:
>   * Physical address of allocated memory block on success, %0 on failure.
> @@ -1398,12 +1398,12 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  	 */
>  	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
>  		/*
> -		 * The min_count is set to 0 so that memblock allocated
> -		 * blocks are never reported as leaks. This is because many
> -		 * of these blocks are only referred via the physical
> -		 * address which is not looked up by kmemleak.
> +		 * Memblock allocated blocks are never reported as
> +		 * leaks. This is because many of these blocks are
> +		 * only referred via the physical address which is
> +		 * not looked up by kmemleak.
>  		 */
> -		kmemleak_alloc_phys(found, size, 0, 0);
> +		kmemleak_alloc_phys(found, size, 0);
>  
>  	return found;
>  }
> diff --git a/tools/testing/memblock/linux/kmemleak.h b/tools/testing/memblock/linux/kmemleak.h
> index 462f8c5e8aa0..5fed13bb9ec4 100644
> --- a/tools/testing/memblock/linux/kmemleak.h
> +++ b/tools/testing/memblock/linux/kmemleak.h
> @@ -7,7 +7,7 @@ static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
>  }
>  
>  static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
> -				       int min_count, gfp_t gfp)
> +				       gfp_t gfp)
>  {
>  }

If you respin, I'd move the prototype change to a separate patch (and
make it first in the series). Otherwise it looks fine:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
