Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533C8534244
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiEYRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiEYRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:36:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B752AF1EA;
        Wed, 25 May 2022 10:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5F88B81D03;
        Wed, 25 May 2022 17:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E799C385B8;
        Wed, 25 May 2022 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653500182;
        bh=2sZOK+u8TWT2hz1WpVc/08X2wVHPW+B9FaWItdMS6eM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkatBIHRITw6zvVX4YnXKdYK0+EGDe+CSZbCe0jc738X2QM9B/iUCZq+wM7v3dTlQ
         0PtF0mEjA0iXlCWrMv2ewqUOx7TlJXRMWCT9B9JUhbm6FlvH2Pcyy8Vb1PvY/xcYq4
         xkSOXG1qbRnW6xSDTrlgCJ7U+pIwhqCLyZj4NoRk=
Date:   Wed, 25 May 2022 10:36:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-Id: <20220525103621.987185e2ca0079f7b97b856d@linux-foundation.org>
In-Reply-To: <6CA81704-417D-4843-940E-F901803A908C@nvidia.com>
References: <20220525155401.4a72ad6b@canb.auug.org.au>
        <6CA81704-417D-4843-940E-F901803A908C@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 06:57:53 -0400 Zi Yan <ziy@nvidia.com> wrote:

> On 25 May 2022, at 1:54, Stephen Rothwell wrote:
> 
> > Hi all,
> >
> > After merging the mm tree, today's linux-next build (sparc64 defconfig)
> > produced this warning:
> >
> > In file included from include/linux/kernel.h:26,
> >                  from include/linux/cpumask.h:10,
> >                  from include/linux/smp.h:13,
> >                  from include/linux/lockdep.h:14,
> >                  from include/linux/spinlock.h:62,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/mm.h:7,
> >                  from mm/page_alloc.c:19:
> > mm/page_alloc.c: In function 'split_free_page':
> > include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
> >    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >       |                                   ^~
> > include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
> >    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
> >       |                  ^~~~~~~~~~~
> > include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
> >    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
> >       |                               ^~~~~~~~~~
> > include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
> >    45 | #define min(x, y)       __careful_cmp(x, y, <)
> >       |                         ^~~~~~~~~~~~~
> > mm/page_alloc.c:1138:35: note: in expansion of macro 'min'
> >  1138 |                 free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));
> >       |                                   ^~~
> >
> > Introduced by commit
> >
> >   29a8af92b874 ("mm: fix a potential infinite loop in start_isolate_page_range()")
> 

The min() warning says "we screwed up the types", and reexamination is
in order.

> The patch below should fix it:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6eec0211e0be..dbbfe4a079d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1123,7 +1123,9 @@ void split_free_page(struct page *free_page,
>              pfn < free_page_pfn + (1UL << order);) {
>                 int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
> 
> -               free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));
> +               free_page_order = min_t(unsigned long,
> +                                       pfn ? __ffs(pfn) : order,
> +                                       __fls(split_pfn_offset));
>                 __free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
>                                 mt, FPI_NONE);
>                 pfn += 1UL << free_page_order;

`order' has type `int'.  Inappropriately signed.  It should have been
`unsigned int'.  Too late (or too large) to make that change.

__ffs() and __fls() return `unsigned long'.  Inappropriately wide. 
Should have returned `unsigned int'.  Too late (or too large) to
change.  

So we get to live with the mess we made.  Your proposed change adds
more inappropriateness - why cast to ulong when assigning to an int?

--- a/mm/page_alloc.c~mm-fix-a-potential-infinite-loop-in-start_isolate_page_range-fix
+++ a/mm/page_alloc.c
@@ -1123,7 +1123,9 @@ void split_free_page(struct page *free_p
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
 
-		free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));
+		free_page_order = min_t(int,
+					pfn ? __ffs(pfn) : order,
+					__fls(split_pfn_offset));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
 				mt, FPI_NONE);
 		pfn += 1UL << free_page_order;
_

