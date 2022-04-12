Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6A4FDC44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbiDLKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357785AbiDLJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335E2654B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:59:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15FF4210F4;
        Tue, 12 Apr 2022 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649753994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXcY0HxQD9QkaG2No5hFxre2uSwE5KR0ptaqz9/fqEk=;
        b=MGW40pK02mzEEDHBwBA/uzxo7HodeYyTTwL8q/BmidqNqZZ/3cZbod6dMpog1L3fq5jsrc
        dwfl54xzecqe7ItCAH4dWXYOKgxvpP6UhpnQvQS00d9xMw99yF6XUfTUi/R74KVhDhh6EP
        ic39NqRgonS+QdgDnmnJKQzmAU7cdIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649753994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXcY0HxQD9QkaG2No5hFxre2uSwE5KR0ptaqz9/fqEk=;
        b=YQdOsW4MALpmgNzrAteIibSpYMZY8u/lNgFKPpFXk0hcM1LSwIcmSBjgiat41EMJ+EGYPO
        eYwvI6YAIE9nc7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D8B713780;
        Tue, 12 Apr 2022 08:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uY5JG4k/VWJbIQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 12 Apr 2022 08:59:53 +0000
Date:   Tue, 12 Apr 2022 10:59:51 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
Message-ID: <YlU/h0fdE1L846Bd@localhost.localdomain>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409093500.10329-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
> is checked before. It will avoid the long term pinned pages to be swapped
> out. And we can live with short term pinned pages. Without can_split_folio
> checking we can simplify the code. Also activate_locked can be changed to
> keep_locked as it's just short term pinning.

What do you mean by "we can live with short term pinned pages"?
Does it mean that it was not pinned when we check
folio_maybe_dma_pinned() but now it is?

To me it looks like the pinning is fluctuating and we rely on
split_folio_to_list() to see whether we succeed or not, and if not
we give it another spin in the next round?

> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4a76be47bed1..01f5db75a507 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1711,20 +1711,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  					goto keep_locked;
>  				if (folio_maybe_dma_pinned(folio))
>  					goto keep_locked;
> -				if (PageTransHuge(page)) {
> -					/* cannot split THP, skip it */
> -					if (!can_split_folio(folio, NULL))
> -						goto activate_locked;
> -					/*
> -					 * Split pages without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> -					 */
> -					if (!folio_entire_mapcount(folio) &&
> -					    split_folio_to_list(folio,
> -								page_list))
> -						goto activate_locked;
> -				}
> +				/*
> +				 * Split pages without a PMD map right
> +				 * away. Chances are some or all of the
> +				 * tail pages can be freed without IO.
> +				 */
> +				if (PageTransHuge(page) && !folio_entire_mapcount(folio) &&
> +				    split_folio_to_list(folio, page_list))
> +					goto keep_locked;
>  				if (!add_to_swap(page)) {
>  					if (!PageTransHuge(page))
>  						goto activate_locked_split;
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
