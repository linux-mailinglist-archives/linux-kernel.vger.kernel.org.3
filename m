Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706BD4ECE70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiC3Uza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiC3Uz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2E2B25F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439FD616A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8567FC340EC;
        Wed, 30 Mar 2022 20:53:39 +0000 (UTC)
Date:   Wed, 30 Mar 2022 16:53:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others
Message-ID: <20220330165337.7138810e@gandalf.local.home>
In-Reply-To: <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
References: <20220330154208.71aca532@gandalf.local.home>
        <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
        <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
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

On Wed, 30 Mar 2022 16:29:28 -0400
Zi Yan <ziy@nvidia.com> wrote:

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bdc8f60ae462..83a90e2973b7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1108,6 +1108,8 @@ static inline void __free_one_page(struct page *page,
> 
>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>                 buddy = page + (buddy_pfn - pfn);
> +               if (!page_is_buddy(page, buddy, order))
> +                       goto done_merging;
>                 buddy_mt = get_pageblock_migratetype(buddy);
> 
>                 if (migratetype != buddy_mt
> 

The above did not apply to Linus's tree, nor even the problem commit
(before or after), but I found where the code is, and added it manually.

It does appear to allow the machine to boot.

-- Steve
