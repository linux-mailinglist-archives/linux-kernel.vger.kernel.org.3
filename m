Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9066F4EFCB3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353322AbiDAWQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353291AbiDAWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:16:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729765D07
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:14:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90F63210E7;
        Fri,  1 Apr 2022 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648851266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pe8liXZM2h2O58fZfmoQfsuWte/F3qXp4GTmZwoKHTo=;
        b=C8LKGm9NV3UCxChk+Ki0Qqi5ub/fm2rMl8CvkGWwDWUif+yFiVSVMHQ8zOX0MDlgefO7d9
        9uxTovQbdZpz6oTGnOY+3H+148DZgAFhmCnEpSkdrK3ixVee0d9bjiuHf6b30Xk4Qipq+E
        EEz6eL64kNB7x3eAcHKbAow2+JyXxfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648851266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pe8liXZM2h2O58fZfmoQfsuWte/F3qXp4GTmZwoKHTo=;
        b=agfDnaSu6LIxtuRbx0j1308aGrwrlbUC2vDiZxV8ghYOE3FnxP32itpafXxMJrfv5PfxLD
        URWvqp5wqIIoOwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DF01132C1;
        Fri,  1 Apr 2022 22:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pbouFkJ5R2LlLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 01 Apr 2022 22:14:26 +0000
Message-ID: <a085d739-aa06-eff0-d350-0df088a7f2d0@suse.cz>
Date:   Sat, 2 Apr 2022 00:14:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] mm: page_alloc: simplify pageblock migratetype
 check in __free_one_page().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220401181109.1477354-1-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220401181109.1477354-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 20:11, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Move pageblock migratetype check code in the while loop to simplify the
> logic. It also saves redundant buddy page checking code.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/linux-mm/27ff69f9-60c5-9e59-feb2-295250077551@suse.cz/
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 46 +++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 856473e54155..2ea106146686 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1054,7 +1054,6 @@ static inline void __free_one_page(struct page *page,
>  		int migratetype, fpi_t fpi_flags)
>  {
>  	struct capture_control *capc = task_capc(zone);
> -	unsigned int max_order = pageblock_order;
>  	unsigned long buddy_pfn;
>  	unsigned long combined_pfn;
>  	struct page *buddy;
> @@ -1070,8 +1069,7 @@ static inline void __free_one_page(struct page *page,
>  	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>  
> -continue_merging:
> -	while (order < max_order) {
> +	while (order < MAX_ORDER - 1) {
>  		if (compaction_capture(capc, page, order, migratetype)) {
>  			__mod_zone_freepage_state(zone, -(1 << order),
>  								migratetype);
> @@ -1082,6 +1080,22 @@ static inline void __free_one_page(struct page *page,
>  
>  		if (!page_is_buddy(page, buddy, order))
>  			goto done_merging;
> +
> +		if (unlikely(order >= pageblock_order)) {
> +			/*
> +			 * We want to prevent merge between freepages on pageblock
> +			 * without fallbacks and normal pageblock. Without this,
> +			 * pageblock isolation could cause incorrect freepage or CMA
> +			 * accounting or HIGHATOMIC accounting.
> +			 */
> +			int buddy_mt = get_pageblock_migratetype(buddy);
> +
> +			if (migratetype != buddy_mt
> +					&& (!migratetype_is_mergeable(migratetype) ||
> +						!migratetype_is_mergeable(buddy_mt)))
> +				goto done_merging;
> +		}
> +
>  		/*
>  		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
>  		 * merge with it and move up one order.
> @@ -1095,32 +1109,6 @@ static inline void __free_one_page(struct page *page,
>  		pfn = combined_pfn;
>  		order++;
>  	}
> -	if (order < MAX_ORDER - 1) {
> -		/* If we are here, it means order is >= pageblock_order.
> -		 * We want to prevent merge between freepages on pageblock
> -		 * without fallbacks and normal pageblock. Without this,
> -		 * pageblock isolation could cause incorrect freepage or CMA
> -		 * accounting or HIGHATOMIC accounting.
> -		 *
> -		 * We don't want to hit this code for the more frequent
> -		 * low-order merging.
> -		 */
> -		int buddy_mt;
> -
> -		buddy_pfn = __find_buddy_pfn(pfn, order);
> -		buddy = page + (buddy_pfn - pfn);
> -
> -		if (!page_is_buddy(page, buddy, order))
> -			goto done_merging;
> -		buddy_mt = get_pageblock_migratetype(buddy);
> -
> -		if (migratetype != buddy_mt
> -				&& (!migratetype_is_mergeable(migratetype) ||
> -					!migratetype_is_mergeable(buddy_mt)))
> -			goto done_merging;
> -		max_order = order + 1;
> -		goto continue_merging;
> -	}
>  
>  done_merging:
>  	set_buddy_order(page, order);

