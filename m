Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31722533264
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiEXUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiEXUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:23:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391E5C654
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38E4CB81BB4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711B8C34100;
        Tue, 24 May 2022 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653423811;
        bh=1TBccbNXXdkA4yggnTErP3z1KQ5YvTNhTlw2uX3PD+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8uKByO78gwiPvUIrtEW+RfKKx4lPhiAP5F3d+Wq8yHlKPW5HK6fS/Hs0x6HMjtdX
         aUqaytSI5r/DeFrqaaLyeLhjGs+E3H0zChZ50QZRKRiBU7KsZ7TBZa8X/Yx8eCIHm4
         /MROOd+wzqKIesHZFh49zCSmEQ3xemCYvb2Ndqng=
Date:   Tue, 24 May 2022 13:23:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Zi Yan <zi.yan@sent.com>, Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] mm: fix a potential infinite loop in
 start_isolate_page_range().
Message-Id: <20220524132330.eaf1366967d2fa927fdaf995@linux-foundation.org>
In-Reply-To: <20220524194756.1698351-1-zi.yan@sent.com>
References: <20220524194756.1698351-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 15:47:56 -0400 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> In isolate_single_pageblock() called by start_isolate_page_range(),
> there are some pageblock isolation issues causing a potential
> infinite loop when isolating a page range. This is reported by Qian Cai.
> 
> 1. the pageblock was isolated by just changing pageblock migratetype
>    without checking unmovable pages. Calling set_migratetype_isolate() to
>    isolate pageblock properly.
> 2. an off-by-one error caused migrating pages unnecessarily, since the page
>    is not crossing pageblock boundary.
> 3. migrating a compound page across pageblock boundary then splitting the
>    free page later has a small race window that the free page might be
>    allocated again, so that the code will try again, causing an potential
>    infinite loop. Temporarily set the to-be-migrated page's pageblock to
>    MIGRATE_ISOLATE to prevent that and bail out early if no free page is
>    found after page migration.
> 
> An additional fix to split_free_page() aims to avoid crashing in
> __free_one_page(). When the free page is split at the specified
> split_pfn_offset, free_page_order should check both the first bit of
> free_page_pfn and the last bit of split_pfn_offset and use the smaller one.
> For example, if free_page_pfn=0x10000, split_pfn_offset=0xc000,
> free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 then
> 0x8000, which the original algorithm did.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1114,13 +1114,16 @@ void split_free_page(struct page *free_page,
>  	unsigned long flags;
>  	int free_page_order;
>  
> +	if (split_pfn_offset == 0)
> +		return;
> +
>  	spin_lock_irqsave(&zone->lock, flags);
>  	del_page_from_free_list(free_page, zone, order);
>  	for (pfn = free_page_pfn;
>  	     pfn < free_page_pfn + (1UL << order);) {
>  		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>  
> -		free_page_order = ffs(split_pfn_offset) - 1;
> +		free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));

Why is it testing the zeroness of `pfn' here?  Can pfn==0 even happen? 
If so, it's a legitimate value so why does it get special-cased?



