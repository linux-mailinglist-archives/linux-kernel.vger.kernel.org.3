Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED95522474
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiEJS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiEJS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AFA54BE5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15ED161117
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2103CC385C2;
        Tue, 10 May 2022 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652209163;
        bh=ajpLuMXrPrNofjFAsynlZdqAggkQqVZljm1Ud2j7xMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wwx1rD46KZaErYa7By9rx5yDPlei1DEANzUTbLv1OZyvear0dGSPX2BAUnJPlCwVe
         +xXi7JGGDUHdv06EPlpIskQ/VHDKMCTDa7WvE+kqk2Le6Pp6G28tqJlxb66xGccjlo
         BYyk0KWR9PjjeooUxIKADMnzYh6Ws0PTkX0XFp6c=
Date:   Tue, 10 May 2022 11:59:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: fix missing handler for __GFP_NOWARN
Message-Id: <20220510115922.350a496ca8b91686c1758282@linux-foundation.org>
In-Reply-To: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 19:38:08 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> We expect no warnings to be issued when we specify __GFP_NOWARN, but
> currently in paths like alloc_pages() and kmalloc(), there are still
> some warnings printed, fix it.

Looks sane to me.

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -35,6 +35,17 @@ struct folio_batch;
>  /* Do not use these with a slab allocator */
>  #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
>  
> +#define WARN_ON_ONCE_GFP(cond, gfp)	({				\
> +	static bool __section(".data.once") __warned;			\
> +	int __ret_warn_once = !!(cond);					\
> +									\
> +	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
> +		__warned = true;					\
> +		WARN_ON(1);						\
> +	}								\
> +	unlikely(__ret_warn_once);					\
> +})

I don't think WARN_ON_ONCE_GFP is a good name for this.  But
WARN_ON_ONCE_IF_NOT_GFP_NOWARN is too long :(

WARN_ON_ONCE_NOWARN might be better.  No strong opinion here, really.

> @@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * We also sanity check to catch abuse of atomic reserves being used by
>  	 * callers that are not in atomic context.
>  	 */
> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
> +	if (WARN_ON_ONCE_GFP((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> +				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
>  		gfp_mask &= ~__GFP_ATOMIC;
>  
>  retry_cpuset:

I dropped this hunk - Neil's "mm: discard __GFP_ATOMIC"
(https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name)
deleted this code.

