Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F375559F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiFXQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiFXQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:56:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63895473AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OPltmTLrfRrhhxZYfowSC0ASyuwMwmGlEfgyWx9UTJU=; b=e0T2iCj6mnpaIGDoEPp0ur4jv6
        mLp+/pa9IbOoX8WmJ8CuS6d4xHE1LexJfqyQ48rzyHHxabkPQXxz84b3IPLEUJyq0aZEJoBfSDnv2
        3rn8s0H7u5ShshqNozHOYYVZBC3ezhRN5Aa+S3saejzuVt26mZhfwgVuJiAZtgGQ0f/9p0d/SvLW2
        FdtFkKpj9wbXFi6nXNlL3a/Z4hG/9rAHMnPfjiwuPSjBpwBv6jG+OSdf5YeWkUVWFq9uCJIShvgzx
        DbVvdQw8ENh6eQjmCxH645t4B/ALbQYczvtHpu6B/wDl1zNQlGsNOcb0FdQGXhrEKtY/EO+XHd67U
        Xb4y34Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4mbF-0094Ro-A8; Fri, 24 Jun 2022 16:56:05 +0000
Date:   Fri, 24 Jun 2022 17:56:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     rdunlap@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/radix-tree: Remove unuse argument of insert_entries
Message-ID: <YrXspV63H5Wuyd/j@casper.infradead.org>
References: <20220624131523.46153-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624131523.46153-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:15:23PM +0800, wuchi wrote:
> Function insert_entries doesn't use the 'bool replace' argument,
> and the function is only used locally, remove the argument.

Thanks.  For these kinds of patches, I like the changelog to contain the
historical context for when the code changed to make this argument unused.
Can you add that?

> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  lib/radix-tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index b3afafe46fff..3c78e1e8b2ad 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -677,7 +677,7 @@ static void radix_tree_free_nodes(struct radix_tree_node *node)
>  }
>  
>  static inline int insert_entries(struct radix_tree_node *node,
> -		void __rcu **slot, void *item, bool replace)
> +		void __rcu **slot, void *item)
>  {
>  	if (*slot)
>  		return -EEXIST;
> @@ -711,7 +711,7 @@ int radix_tree_insert(struct radix_tree_root *root, unsigned long index,
>  	if (error)
>  		return error;
>  
> -	error = insert_entries(node, slot, item, false);
> +	error = insert_entries(node, slot, item);
>  	if (error < 0)
>  		return error;
>  
> -- 
> 2.20.1
> 
