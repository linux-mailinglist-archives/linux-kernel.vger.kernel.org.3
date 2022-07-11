Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805DD5701FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiGKM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGKM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:26:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80848EAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:26:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE77C1F8EF;
        Mon, 11 Jul 2022 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657542381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDnF2RyjYcOK9I2vZApulNeXK7PDktZm4w1Nc3v6ozY=;
        b=bKLVxGz6pkRYKUT8aY0qZlrX0gtniKxJMQ9wDkAmMDRiUNBsTbLYJmMc+LNMVb00PhRJ2k
        BMaGBKo2YXwsbXKEuK+mqwVaCqQqnXOneRBu/S2+wWXwJ3VOyz7OHBM1E7wgjWh7s9W3mu
        Ie5cvalTucqAZBG+h2vyZ/ZD111dWB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657542381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDnF2RyjYcOK9I2vZApulNeXK7PDktZm4w1Nc3v6ozY=;
        b=5h4Eu/jHkBiYRKTs8AI19J8L4PPdVCUKr4ovWyozHXo1CsnUWNT0WzrpQ0m1yL8Ry7+BCd
        a1ifqPKcZv5cZbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B79113524;
        Mon, 11 Jul 2022 12:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b9T+HO0WzGIpEQAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 11 Jul 2022 12:26:21 +0000
Date:   Mon, 11 Jul 2022 14:26:20 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 5/7] migrate_pages(): fix failure counting for THP on
 -ENOSYS
Message-ID: <YswW7C5jzQNmeOsL@localhost.localdomain>
References: <20220711084948.274787-1-ying.huang@intel.com>
 <20220711084948.274787-6-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711084948.274787-6-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:49:46PM +0800, Huang Ying wrote:
> If THP or hugetlbfs page migration isn't supported, unmap_and_move()
> or unmap_and_move_huge_page() will return -ENOSYS.  For THP, splitting
> will be tried, but if splitting doesn't succeed, the THP will be left
> in "from" list wrongly.  If some other pages are retried, the THP
> migration failure will counted again.  This is fixed via moving the
> failure THP from "from" to "ret_pages".
> 
> Another issue of the original code is that the unsupported failure
> processing isn't consistent between THP and hugetlbfs page.  Make them
> consistent in this patch to make the code easier to be understood too.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  mm/migrate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4bceba143db0..8cce73b7c046 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1192,10 +1192,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  	 * tables or check whether the hugepage is pmd-based or not before
>  	 * kicking migration.
>  	 */
> -	if (!hugepage_migration_supported(page_hstate(hpage))) {
> -		list_move_tail(&hpage->lru, ret);
> +	if (!hugepage_migration_supported(page_hstate(hpage)))
>  		return -ENOSYS;
> -	}
>  
>  	if (page_count(hpage) == 1) {
>  		/* page was freed from under us. So we are done. */
> @@ -1392,6 +1390,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			 *		 page will be put back
>  			 *	-EAGAIN: stay on the from list
>  			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
>  			 *	Other errno: put on ret_pages list then splice to
>  			 *		     from list
>  			 */
> @@ -1421,6 +1420,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				}
>  
>  				nr_failed_pages += nr_subpages;
> +				list_move_tail(&page->lru, &ret_pages);

I must be missing something, but migrate_pages() calls unmap_and_move_huge_page() 
with ret being ret_pages, so

list_move_tail(&hpage->lru, ret) == list_move_tail(&page->lru, &ret_pages)

Yet, you say "This is fixed via moving the failure THP from "from" to "ret_pages"".
/me confused.


-- 
Oscar Salvador
SUSE Labs
