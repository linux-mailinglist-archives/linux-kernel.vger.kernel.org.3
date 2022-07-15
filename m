Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E34576660
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGORur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGORuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66822517
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jTcOrPA+ocFbinFbt5VpQCoXRpjbOrc2oieHhF7HDbU=; b=B1PHL2D/OoKCq1vGITDu2dnvgR
        lSeZv2qJY8qSk3+YDMMci0r+pa2+qIhvYmF2748kPNIl0IwOtrvI5zSCeVML+rpNOojkFMpYfba/Q
        X8floWxTJloOg7zhAIt2yegLLvTI0L9GTJIAPWBqi38WNgUyhyMGgJOjzotJQukTVcud8tZmGpye3
        SwMdNc9D8zy9YwXSnmYIk0UWELw+eszyyPHo7kvdYtz44g8b8AofzhI/+vUhkDA6YZzKX63y5/599
        c4dpC0SQVA/rU6ynqsCQmer5e+LFDDHf2WGxeWyyuJUj5rZk0VB8vlvhC8MxRHLkmTIyx36Z1dOoc
        UOGd6o5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCPSW-00ARIe-AS; Fri, 15 Jul 2022 17:50:36 +0000
Date:   Fri, 15 Jul 2022 18:50:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: Return from zap_huge_pmd after WARN_ONCE.
Message-ID: <YtGo7GS5l4WxZA/R@casper.infradead.org>
References: <20220715092238.22663-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715092238.22663-1-zhouguanghui1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 09:22:38AM +0000, Zhou Guanghui wrote:
> After WARN_ONCE is processed, the subsequent page judgment results
> in NULL pointer access. It is more reasonable to return from the
> function here.

I'm not sure this is a good idea.  Probably better to crash than
continue.

> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> ---
>  mm/huge_memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 834f288b3769..7f5ccca6792a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1601,8 +1601,11 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			entry = pmd_to_swp_entry(orig_pmd);
>  			page = pfn_swap_entry_to_page(entry);
>  			flush_needed = 0;
> -		} else
> +		} else {
> +			spin_unlock(ptl);
>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
> +			return 1;
> +		}
>  
>  		if (PageAnon(page)) {
>  			zap_deposited_table(tlb->mm, pmd);
> -- 
> 2.17.1
> 
> 
