Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5049E2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiA0MpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiA0MpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCECC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BCB861ABD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8D0C340E4;
        Thu, 27 Jan 2022 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643287513;
        bh=tRHvbXNSxItnFTyKgs26qFkni8IsT7iEbBg+SJZGGtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0E4M1pv9O4k1l6/PZTuB5T+BWLo19uArHpzNftT87yOsH7fHi3w89beb+RZXBbJ1
         ZrXflNk5fNQpD5+qGwkNYuGwqfkajsV6es0tHrzjgc1PSSPql8aZXS27Ro6a3ycsvk
         3rYVm9GSMfS+z5VLZC/B4ZnOLKkODms8KG+zlMcR2JttMEGMXMl+Pab31qo5v2ZTZF
         aIns+8PFMmb0XnO7ggwyI+1AVgGcc9e8yT9zjrt7+s1GUVN9s0NGUFRCGhTc8AhWof
         JwTwTtu3V0i4IVUOQdrdgsTIODgf9JtTcbaYDFlVvOi7yQoyfPC+afnymAHZ20COkt
         m1IBXulbPT1Zg==
Date:   Thu, 27 Jan 2022 14:45:06 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparse: make mminit_validate_memmodel_limits() static
Message-ID: <YfKT0hs5C7Mr015v@kernel.org>
References: <20220127093221.63524-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127093221.63524-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:32:21PM +0800, Miaohe Lin wrote:
> It's only used in the sparse.c now. So we can make it static and further
> clean up the relevant code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/internal.h | 11 -----------
>  mm/sparse.c   |  2 +-
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 4c2d06a2f50b..927dfba5111f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -572,17 +572,6 @@ static inline void mminit_verify_zonelist(void)
>  }
>  #endif /* CONFIG_DEBUG_MEMORY_INIT */
>  
> -/* mminit_validate_memmodel_limits is independent of CONFIG_DEBUG_MEMORY_INIT */
> -#if defined(CONFIG_SPARSEMEM)
> -extern void mminit_validate_memmodel_limits(unsigned long *start_pfn,
> -				unsigned long *end_pfn);
> -#else
> -static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
> -				unsigned long *end_pfn)
> -{
> -}
> -#endif /* CONFIG_SPARSEMEM */
> -
>  #define NODE_RECLAIM_NOSCAN	-2
>  #define NODE_RECLAIM_FULL	-1
>  #define NODE_RECLAIM_SOME	0
> diff --git a/mm/sparse.c b/mm/sparse.c
> index d21c6e5910d0..952f06d8f373 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -126,7 +126,7 @@ static inline int sparse_early_nid(struct mem_section *section)
>  }
>  
>  /* Validate the physical addressing limitations of the model */
> -void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
> +static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>  						unsigned long *end_pfn)
>  {
>  	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
> -- 
> 2.23.0
> 
> 

-- 
Sincerely yours,
Mike.
