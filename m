Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E449E2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiA0MoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiA0MoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:44:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6919C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:44:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A770FB819C2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C350FC340E4;
        Thu, 27 Jan 2022 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643287451;
        bh=wAG19dWzrmVRY7z5bVram9oydUwz5Bz8k/viR2YEktI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kC3SGE/iemVN/a/lCg3YsF5Nk+n6KLolRWdeqBKGjVamyvIO0XWfImAhXU3gWyqBz
         WZaAOu4pWOtCGm+1EXlpKpTDSi6KBK57ancyHuXRgWJ17MnzWbfvHq72zIlx9MY55y
         0spfBiYdXoAPsrRjVST4gc2eqlacgoW+4XxDCMULXdr9VJKO+857iJpJDcR79pJSxT
         O18hZg3S7XDRyMhlCogEnqx43b3uhCs7U8FTVoxwXPAm6S4rgXqIb24hk7lTm8qVKL
         iu63Q90Vq3dat/6OJ1DQgWXi0W/+evb8eU+9n96LrEJax+a+geoBrZOTnza3saIF0y
         KDrogEx/1xdSg==
Date:   Thu, 27 Jan 2022 14:44:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmzone.h: remove unused macros
Message-ID: <YfKTlMMa3RZoF+3I@kernel.org>
References: <20220127093210.62293-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127093210.62293-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:32:10PM +0800, Miaohe Lin wrote:
> Remove pgdat_page_nr, nid_page_nr and NODE_MEM_MAP. They are unused now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mmzone.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..6c004256d943 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -920,12 +920,6 @@ typedef struct pglist_data {
>  
>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>  #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
> -#ifdef CONFIG_FLATMEM
> -#define pgdat_page_nr(pgdat, pagenr)	((pgdat)->node_mem_map + (pagenr))
> -#else
> -#define pgdat_page_nr(pgdat, pagenr)	pfn_to_page((pgdat)->node_start_pfn + (pagenr))
> -#endif
> -#define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
>  
>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
> @@ -1101,7 +1095,6 @@ static inline struct pglist_data *NODE_DATA(int nid)
>  {
>  	return &contig_page_data;
>  }
> -#define NODE_MEM_MAP(nid)	mem_map
>  
>  #else /* CONFIG_NUMA */
>  
> -- 
> 2.23.0
> 
> 

-- 
Sincerely yours,
Mike.
