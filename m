Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46075702B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiGKMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiGKMkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:40:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742D60699
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:39:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93FEB1FE0E;
        Mon, 11 Jul 2022 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657543165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xU9MoVznrIVIBMvPbpouJup20DYgj7sfYLi8h4sbB5s=;
        b=EMAQ3C2JXSsXt7UTY59BN+sxHzMvUmEmfhJX48BwTe52lDfNkJMBJG35xEYYdXbRfEoOZv
        rDwqvquUfYGBAnwFiuwbP6BmZVceJ2CvLY1+G+XDCEmm8W+hLmr4B1m8pgS+bg2+GWlxBW
        xANGly8JM0mXyohItIg/HEXMqV7qhjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657543165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xU9MoVznrIVIBMvPbpouJup20DYgj7sfYLi8h4sbB5s=;
        b=RTNcHc55/ON+DdiQGrxn6/rnDtRSUGX/6e1QVwxJ6oDjc/qZuNzQzzZgliezbz2XyWSbzG
        Ne7EI7dchnSs+VDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6956313524;
        Mon, 11 Jul 2022 12:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LniXGP0ZzGL3FwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 11 Jul 2022 12:39:25 +0000
Date:   Mon, 11 Jul 2022 14:39:24 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 6/7] migrate_pages(): fix failure counting for THP
 splitting
Message-ID: <YswZ/GGdn0UMsMGB@localhost.localdomain>
References: <20220711084948.274787-1-ying.huang@intel.com>
 <20220711084948.274787-7-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711084948.274787-7-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:49:47PM +0800, Huang Ying wrote:
> If THP is failed to be migrated, it may be split and retry.  But after
> splitting, the head page will be left in "from" list, although THP
> migration failure has been counted already.  If the head page is
> failed to be migrated too, the failure will be counted twice
> incorrectly.  So this is fixed in this patch via moving the head page
> of THP after splitting to "thp_split_pages" too.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/migrate.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8cce73b7c046..557708ce13a1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1306,6 +1306,8 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
>  	lock_page(page);
>  	rc = split_huge_page_to_list(page, split_pages);
>  	unlock_page(page);
> +	if (!rc)
> +		list_move_tail(&page->lru, split_pages);
>  
>  	return rc;
>  }
> @@ -1365,7 +1367,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		thp_retry = 0;
>  
>  		list_for_each_entry_safe(page, page2, from, lru) {
> -retry:
>  			/*
>  			 * THP statistics is based on the source huge page.
>  			 * Capture required information that might get lost
> @@ -1412,7 +1413,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_thp_failed++;
>  					if (!try_split_thp(page, &thp_split_pages)) {
>  						nr_thp_split++;
> -						goto retry;
> +						break;
>  					}
>  				/* Hugetlb migration is unsupported */
>  				} else if (!no_subpage_counting) {
> @@ -1432,7 +1433,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					/* THP NUMA faulting doesn't split THP to retry. */
>  					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
>  						nr_thp_split++;
> -						goto retry;
> +						break;
>  					}
>  				} else if (!no_subpage_counting) {
>  					nr_failed++;
> -- 
> 2.30.2
> 
> 

-- 
Oscar Salvador
SUSE Labs
