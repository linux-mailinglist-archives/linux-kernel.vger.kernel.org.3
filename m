Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF94DE948
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiCSQWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:22:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1F4F9D9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TaPRwk54uOaTIhLcPdxclCqUMjErChJEk70TXoqt3aY=; b=YX1neCymYmxSjj4ifP3UiFHH0g
        GNK3b0HUEjqposVPxi9thgU9q9yesWoUgNm1VT6/0MyVO7avf1EigM0yA4nGNAdKUYgYCR8r9rZY5
        LT3u6mMJLGVlzfvDIeLf/yRQUFY8MM1y6diJiFjYMDm0lTYd8og8pdbfkSJu87NPish9wv4UJT/tr
        bIGx2AipfFMN/ChqOA9+wVRFyjKwI7eqrmmU5mxtIY3pbf+LI5wibt1PlJ3Dy1R/wqR4s29HYSCGJ
        fMhRSrYPx3o3utBVpz3lIru4gUm8Jp1tnilADTo3VI50xslNCdtlFP8VArDXG97Qnw/b4mzv/R27e
        Zhq26KYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVboj-008wiX-11; Sat, 19 Mar 2022 16:20:37 +0000
Date:   Sat, 19 Mar 2022 16:20:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, mike.kravetz@oracle.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
Message-ID: <YjYC1XaeDPosSIDa@casper.infradead.org>
References: <20220320051334.44502-1-linmiaohe@huawei.com>
 <20220320051334.44502-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320051334.44502-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 01:13:33PM +0800, Miaohe Lin wrote:
> invalidate_inode_page() can invalidate the pages in the swap cache because
> the check of page->mapping != mapping is removed via Matthew's patch titled
> "mm/truncate: Inline invalidate_complete_page() into its one caller". But
> invalidate_inode_page() is not expected to deal with the pages in the swap
> cache. Also non-lru movable page can reach here too. They're not page cache
> pages. Skip these pages by checking PageSwapCache and PageLRU to fix this
> unexpected issue.

I disagree with this changelog.

invalidate_inode_page() should not be called for pages which are not
in the page cache.

And then the patch shouldn't test PageLRU (which is actually wrong) or
PageSwapCache().  It should simply be:

+	if (!PageHuge(page) && !PageAnon(page))

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5444a8ef4867..ecf45961f3b6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2178,7 +2178,7 @@ static int __soft_offline_page(struct page *page)
>  		return 0;
>  	}
>  
> -	if (!PageHuge(page))
> +	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>  		/*
>  		 * Try to invalidate first. This should work for
>  		 * non dirty unmapped page cache pages.
> -- 
> 2.23.0
> 
> 
