Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41F570360
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiGKMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:52:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808D2E9D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:52:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC66D20335;
        Mon, 11 Jul 2022 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657543956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZGUfp59m5FnFaPjISxEgR9lIENaS4sI+9rM07QEzwM=;
        b=1900n3aF21S73ivEqU/B7C/4jM3WexKmndsusOAWqd954YyOpQvo5A/fEp4xz8BmVSCyrR
        rclshqRnubBNYJWj7bhtyGtHF+1OUDeAk6spnlhZ07DpoCfcL3qW2Zgf7/K8cDw6hCeTb/
        izEJOFrYbDd2zKzozCWVpqHeWEDITQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657543956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZGUfp59m5FnFaPjISxEgR9lIENaS4sI+9rM07QEzwM=;
        b=i0+dNOHMmCItX9a6uglvKKFUDL7Ef/OyfYN4VgV0avrHT67MFkRb1Sc5A85FxqKCmcsTrV
        wneDTlikUo/6g0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C175213322;
        Mon, 11 Jul 2022 12:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TnsxLhQdzGLrHQAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 11 Jul 2022 12:52:36 +0000
Date:   Mon, 11 Jul 2022 14:52:34 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 7/7] migrate_pages(): fix failure counting for retry
Message-ID: <YswdEiBFSyKO6x+B@localhost.localdomain>
References: <20220711084948.274787-1-ying.huang@intel.com>
 <20220711084948.274787-8-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711084948.274787-8-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:49:48PM +0800, Huang Ying wrote:
> After 10 retries, we will give up and the remaining pages will be
> counted as failure in nr_failed and nr_thp_failed.  We should count
> the failure in nr_failed_pages too.  This is done in this patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 557708ce13a1..cee6fc5a2d31 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1345,6 +1345,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int thp_retry = 1;
>  	int nr_failed = 0;
>  	int nr_failed_pages = 0;
> +	int nr_retry_pages = 0;
>  	int nr_succeeded = 0;
>  	int nr_thp_succeeded = 0;
>  	int nr_thp_failed = 0;
> @@ -1365,6 +1366,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>  		retry = 0;
>  		thp_retry = 0;
> +		nr_retry_pages = 0;
>  
>  		list_for_each_entry_safe(page, page2, from, lru) {
>  			/*
> @@ -1439,7 +1441,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_failed++;
>  				}
>  
> -				nr_failed_pages += nr_subpages;
> +				nr_failed_pages += nr_subpages + nr_retry_pages;
>  				/*
>  				 * There might be some subpages of fail-to-migrate THPs
>  				 * left in thp_split_pages list. Move them back to migration
> @@ -1455,6 +1457,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					thp_retry++;
>  				else
>  					retry++;
> +				nr_retry_pages += nr_subpages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
>  				nr_succeeded += nr_subpages;
> @@ -1481,6 +1484,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	if (!no_subpage_counting)
>  		nr_failed += retry;
>  	nr_thp_failed += thp_retry;
> +	nr_failed_pages += nr_retry_pages;
>  	/*
>  	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
>  	 * counting in this round, since all subpages of a THP is counted
> -- 
> 2.30.2
> 
> 

-- 
Oscar Salvador
SUSE Labs
