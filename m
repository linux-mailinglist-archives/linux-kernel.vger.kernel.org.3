Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A452B733
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiERJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiERJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:46:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062B29B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:46:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E84AE2187D;
        Wed, 18 May 2022 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652867165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZiL2iT23ofTS/HVXmTv3k1ijrjRXrReMfjhRCC71q4=;
        b=gJipXj5lDe/gSgpXQvCeFxkBHzYwCgb7e0R6rDQphJXFAe5U2yjgxyEzkYaUkOEZugnCvn
        B5Qwt0RYl3ldokm5KKrZvX3ULSkbbcO8ocSxYbK4mhvjrGAHHyxEirI/NG13XC4DwygfEL
        Pk5OWsot6Ip97IfKoto8c8yskdTOtSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652867165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZiL2iT23ofTS/HVXmTv3k1ijrjRXrReMfjhRCC71q4=;
        b=MlLhLrcp9eSx/ih9hGRG9t5yHHnm5bbU0Auvo4oC5P/Tk0ZfXA3WQWQ8Cm52Sjs83KbbHP
        Hh+wlaQn+/WblBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4B30133F5;
        Wed, 18 May 2022 09:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OgfmMFzAhGJjFwAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 09:46:04 +0000
Date:   Wed, 18 May 2022 11:46:02 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] mm/swap: make page_swapcount and
 __lru_add_drain_all
Message-ID: <YoTAWjTV7Yj8FulM@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-9-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-9-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:09PM +0800, Miaohe Lin wrote:
> Make page_swapcount and __lru_add_drain_all static. They are only used
> within the file now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

I think the commit message is missing the "static" word.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/swap.h | 7 -------
>  mm/swap.c            | 2 +-
>  mm/swapfile.c        | 2 +-
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 999c7d79c2d5..8772132d21dc 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -490,7 +490,6 @@ int swap_type_of(dev_t device, sector_t offset);
>  int find_first_swap(dev_t *device);
>  extern unsigned int count_swap_pages(int, int);
>  extern sector_t swapdev_block(int, pgoff_t);
> -extern int page_swapcount(struct page *);
>  extern int __swap_count(swp_entry_t entry);
>  extern int __swp_swapcount(swp_entry_t entry);
>  extern int swp_swapcount(swp_entry_t entry);
> @@ -562,12 +561,6 @@ static inline void put_swap_page(struct page *page, swp_entry_t swp)
>  {
>  }
>  
> -
> -static inline int page_swapcount(struct page *page)
> -{
> -	return 0;
> -}
> -
>  static inline int __swap_count(swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/swap.c b/mm/swap.c
> index 7e320ec08c6a..6d2c37f781f8 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -748,7 +748,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>   * Calling this function with cpu hotplug locks held can actually lead
>   * to obscure indirect dependencies via WQ context.
>   */
> -inline void __lru_add_drain_all(bool force_all_cpus)
> +static inline void __lru_add_drain_all(bool force_all_cpus)
>  {
>  	/*
>  	 * lru_drain_gen - Global pages generation number
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 7b4c99ca2aea..133e03fea104 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1430,7 +1430,7 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
>   * This does not give an exact answer when swap count is continued,
>   * but does include the high COUNT_CONTINUED flag to allow for that.
>   */
> -int page_swapcount(struct page *page)
> +static int page_swapcount(struct page *page)
>  {
>  	int count = 0;
>  	struct swap_info_struct *p;
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
