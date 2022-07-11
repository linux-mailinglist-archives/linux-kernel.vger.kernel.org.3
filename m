Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE5570184
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGKMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiGKMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:02:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FA23AB0F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:01:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 377F91FB37;
        Mon, 11 Jul 2022 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657540917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nl3HBfd9iKeyfHwCwNnxaKOT8wpVtevnrthm2sJIei4=;
        b=h1qzbPDa2S5oID8qiFthvAuoEIsUBadp2kYRvz8/OPs9HFCFGEVUVZH5t3XwSOeOWzrLVo
        sgkiPjeTrLv6SIxE4Koy/0rYajWboEL6eZm+PSemZFYywWbS6TUIteb34srndisLjXGpW4
        I/K98HNFJlwN4IyyHKR7ay6Isu+uUpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657540917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nl3HBfd9iKeyfHwCwNnxaKOT8wpVtevnrthm2sJIei4=;
        b=XkAJn5gVOwdRlc+aACgY7HstNnfxHTv4TCIiv2sHPPNTVAVwdezQP0tNYDzSQwM6wu9GG+
        D7r4WzOedVt1KTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06C9813524;
        Mon, 11 Jul 2022 12:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sNt1ADURzGK/BQAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 11 Jul 2022 12:01:57 +0000
Date:   Mon, 11 Jul 2022 14:01:55 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 3/7] migrate_pages(): fix THP failure counting for
 -ENOMEM
Message-ID: <YswRMxPWz2juorft@localhost.localdomain>
References: <20220711084948.274787-1-ying.huang@intel.com>
 <20220711084948.274787-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711084948.274787-4-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:49:44PM +0800, Huang Ying wrote:
> In unmap_and_move(), if the new THP cannot be allocated, -ENOMEM will
> be returned, and migrate_pages() will try to split the THP unless
> "reason" is MR_NUMA_MISPLACED (that is, nosplit == true).  But when
> nosplit == true, the THP migration failure will not be counted.  This
> is incorrect.  So in this patch, the THP migration failure will be
> counted for -ENOMEM regardless of nosplit is true or false.  The
> nr_failed counting isn't fixed because it's not used.  Added some
> comments for it per Baolin's suggestion.
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
> index 794312072eb3..38e2c789a9c3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1426,11 +1426,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				/*
>  				 * When memory is low, don't bother to try to migrate
>  				 * other pages, just exit.
> -				 * THP NUMA faulting doesn't split THP to retry.
>  				 */
> -				if (is_thp && !nosplit) {
> +				if (is_thp) {
>  					nr_thp_failed++;
> -					if (!try_split_thp(page, &thp_split_pages)) {
> +					/* THP NUMA faulting doesn't split THP to retry. */
> +					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
>  						nr_thp_split++;
>  						goto retry;
>  					}
> @@ -1446,6 +1446,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				 * the caller otherwise the page refcnt will be leaked.
>  				 */
>  				list_splice_init(&thp_split_pages, from);
> +				/* nr_failed isn't updated for not used */
>  				nr_thp_failed += thp_retry;
>  				goto out;
>  			case -EAGAIN:
> -- 
> 2.30.2
> 
> 

-- 
Oscar Salvador
SUSE Labs
