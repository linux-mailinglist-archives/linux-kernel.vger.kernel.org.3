Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65EE4B0E43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiBJNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:18:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiBJNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:18:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F81BB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=07cBonba1DbDiUBmK2dO6ItNWq9O714rRPMKjF5tL9Q=; b=o4o0vDtZV6FxU8CZGgzhaGJWwr
        bTeuRXjT7it0pixyf6hKUpANq1wEjPl/ZnZc/cra8RkSuFNu74KAfCUHf+EiMwUfd2QVf0KWYzTnk
        6Hk6hBsEc6vHbY3x0IEj9ex4TCVjwbPn7kmfTULGPhQvIQIGCMwMCDd/efdm9Q8J6EGq3elPKZ7C1
        iHM++X6fXUC4Nb+sqFIVml+OOgrcUHa5B8Rk++WXQRGX3P/tnNCnp0RjlfHlEU7g0WvCSCItCEcUL
        ONBwHn82hpsY9Fg4PyrNW1qfcqvI0sgfIULEc3CtyYbMuthoJSHg4BA53HQOHaOQxgF/r9UzumNtG
        vaNLLp2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI9Kz-009SYN-UO; Thu, 10 Feb 2022 13:18:17 +0000
Date:   Thu, 10 Feb 2022 13:18:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: record context on page->mapping
Message-ID: <YgUQmYy2Tl5oYkqz@casper.infradead.org>
References: <1644483715-7981-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644483715-7981-1-git-send-email-huangzhaoyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:01:55PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Since page->mapping is vacant in the pages which used by kernel(drivers etc)
> Have it record current context to help tracking the page's owner in system
> memory dump.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c595274..2757d10 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2430,6 +2430,8 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
>  		set_page_pfmemalloc(page);
>  	else
>  		clear_page_pfmemalloc(page);
> +
> +	page->mapping = (struct address_space *)current;
>  }

You didn't actually try this patch, did you?  See page_expected_state().
Or, I don't know, just boot it.
