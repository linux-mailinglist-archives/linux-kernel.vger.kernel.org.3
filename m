Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1E53500C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiEZNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347650AbiEZNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09063DFF69
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SlbzwgeVcIbkiDLid8eYrVjR73Fsp4oET2KHh+9DwAY=; b=HC5DPeqs8vrqrrDyfcDTUyvArs
        MLHy0inxmzbEGqRQQpStnYry1aptGoD6Hm3nq9gM8X5GxKptCCA8dhZ/4jzrYDBO21d5HB4xQLsVV
        qlKKntVjewPTgGS8TwQLS7eqJS5mNhMyllcsnKuPUAGqXZQBowB1Es3yBi4ninf2bo3JtjQIrLs4U
        2O3evDVyqbJIbenC2u1ExWO29id/sftoUY6ZiC8oRdPt83irlDxlFVQO/4Oc9a1aZPzc8gVNIv1Nb
        I83hEqExyoiwTzAPI+EeEKEt+im338CLoQpC9RnsGe4+iygXY/r5iL719YLV1cU35RjtMgCkvkZfn
        vlZjPGew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuDdB-001HHa-6e; Thu, 26 May 2022 13:34:25 +0000
Date:   Thu, 26 May 2022 14:34:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
Message-ID: <Yo+B4b0nF+kI35pG@casper.infradead.org>
References: <20220526113350.30806-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526113350.30806-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 07:33:50PM +0800, Miaohe Lin wrote:
> ptep is unmapped too early, so ptep will be accessed while it's unmapped.
> Fix it by deferring pte_unmap() until page table checking is done.
> 
> Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/page_table_check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 3692bea2ea2c..971c3129b0e3 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
>  		pte_t *ptep = pte_offset_map(&pmd, addr);
>  		unsigned long i;
>  
> -		pte_unmap(ptep);
>  		for (i = 0; i < PTRS_PER_PTE; i++) {
>  			__page_table_check_pte_clear(mm, addr, *ptep);
>  			addr += PAGE_SIZE;
>  			ptep++;
>  		}
> +		pte_unmap(ptep);

But ptep was mutated in the loop.  So surely this needs to be:

		pte_unmap(ptep - PTRS_PER_PTE);

or you'll be unmapping the wrong page.

