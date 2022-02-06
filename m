Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60AD4AB12D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244995AbiBFSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiBFSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:13:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48686C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:13:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63E45B80E29
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2E9C340EF;
        Sun,  6 Feb 2022 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644171199;
        bh=NjhEy8t/LIGmsUj5Jg4adnjliOrIOEvCocma09gYM8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suno0EJ5R6M6zvnM9tsTiiZfhFXLudtB1aLQ9AAZ23+m6B38WfJIKOwaJBrgjMhRz
         oroExj8Yd5NZGBOxF4qgaRQa0qSiTAoHf8zCPhW7CTKsucPrh8d34Zp6rB6i+tlnXc
         zlAad3LhQANo6PqtnT6ym9Yj/bms/Q1YP0bU50gpKjHkQsVsP7xxU4fwhbf7Zt2gJw
         2cYq9Xo/Ih4PbxgfSwYWbp0WYewrMtlJ0hA2xi3q21sPkJQvUHLXFUw4pUH3Vd6jR/
         hMEDrqDFlVKMmWKzhcdBVYt6KkzFmddzgMLCJMe+hI1lNXRhMJ+KbxeWxk/mZWlIV5
         4dvOpZ8Sxgrzw==
Date:   Sun, 6 Feb 2022 20:13:11 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/75] hexagon: Add pmd_pfn()
Message-ID: <YgAPtxN7WW222SFI@kernel.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-42-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-42-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:58:18PM +0000, Matthew Wilcox (Oracle) wrote:
> I need to use this function in common code, so define it for hexagon.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/hexagon/include/asm/pgtable.h | 3 ++-

Why hexagon out of all architectures?
What about m68k, nios2, nds32 etc?

>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
> index 18cd6ea9ab23..87e96463ccd6 100644
> --- a/arch/hexagon/include/asm/pgtable.h
> +++ b/arch/hexagon/include/asm/pgtable.h
> @@ -235,10 +235,11 @@ static inline int pmd_bad(pmd_t pmd)
>  	return 0;
>  }
>  
> +#define pmd_pfn(pmd)	(pmd_val(pmd) >> PAGE_SHIFT)

I'd put it in include/linux/pgtable.h inside #ifndef pmd_pfn

>  /*
>   * pmd_page - converts a PMD entry to a page pointer
>   */
> -#define pmd_page(pmd)  (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
> +#define pmd_page(pmd)  (pfn_to_page(pmd_pfn(pmd)))
>  
>  /**
>   * pte_none - check if pte is mapped
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
