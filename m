Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5534ECFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351616AbiC3WbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiC3WbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2318C5BD10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD61A617C1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F106AC3410F;
        Wed, 30 Mar 2022 22:29:19 +0000 (UTC)
Date:   Wed, 30 Mar 2022 18:29:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zi Yan <zi.yan@sent.com>
Cc:     Zi Yan <ziy@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its
 migratetype.
Message-ID: <20220330182918.38276a89@gandalf.local.home>
In-Reply-To: <20220330221238.396357-1-zi.yan@sent.com>
References: <20220330221238.396357-1-zi.yan@sent.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 18:12:38 -0400
Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> Whenever a buddy page is found, page_is_buddy() should be called to
> check its validity. Add the missing check during pageblock merge check.
> 
> Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable pageblocks with others")

Link: https://lore.kernel.org/all/20220330154208.71aca532@gandalf.local.home/

> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bdc8f60ae462..6c6af8658775 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1108,6 +1108,9 @@ static inline void __free_one_page(struct page *page,
>  
>  		buddy_pfn = __find_buddy_pfn(pfn, order);
>  		buddy = page + (buddy_pfn - pfn);
> +
> +		if (!page_is_buddy(page, buddy, order))
> +			goto done_merging;
>  		buddy_mt = get_pageblock_migratetype(buddy);
>  
>  		if (migratetype != buddy_mt

