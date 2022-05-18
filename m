Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613652B590
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiERJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiERJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:00:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53DD111
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:00:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4136921B7C;
        Wed, 18 May 2022 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652864428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ROjIWI9IMrZ8GeFbYrq9/y96A9g9rkDvBdm2WTR+OOU=;
        b=poNFYf9G+ZADBTc+dwd//E37a3nhptONMAI/Fxe2Twqw5CG/XWMltAahM7xseLBRGQSXNj
        ko8bnHGrgnsWgBRshGTm5ZQtTVRaBm0j3oCjKoKkZJWYPcf5uaEXMfnFMgATJUHojghrV8
        1CYvFGVhlWZGbytYfd/7Lsgq+ga5Qqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652864428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ROjIWI9IMrZ8GeFbYrq9/y96A9g9rkDvBdm2WTR+OOU=;
        b=US1f7K56O6TRjZ35FA75/7ugKgY6lRU+flq0lT8H4jcY0vAudDoeoGQBH4zOifYymik9O5
        W+Xr8rngvrzdOxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7881A13A6D;
        Wed, 18 May 2022 09:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5rJHGqu1hGJCfAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 09:00:27 +0000
Date:   Wed, 18 May 2022 11:00:25 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] mm/swap: remove unneeded return value of
 free_swap_slot
Message-ID: <YoS1qdiY4n2rTQsh@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-5-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:05PM +0800, Miaohe Lin wrote:
> The return value of free_swap_slot is always 0 and also ignored now.
> Remove it to clean up the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/swap_slots.h | 2 +-
>  mm/swap_slots.c            | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> index 347f1a304190..15adfb8c813a 100644
> --- a/include/linux/swap_slots.h
> +++ b/include/linux/swap_slots.h
> @@ -24,7 +24,7 @@ struct swap_slots_cache {
>  void disable_swap_slots_cache_lock(void);
>  void reenable_swap_slots_cache_unlock(void);
>  void enable_swap_slots_cache(void);
> -int free_swap_slot(swp_entry_t entry);
> +void free_swap_slot(swp_entry_t entry);
>  
>  extern bool swap_slot_cache_enabled;
>  
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0218ec1cd24c..2f877e6f87d7 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -269,7 +269,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>  	return cache->nr;
>  }
>  
> -int free_swap_slot(swp_entry_t entry)
> +void free_swap_slot(swp_entry_t entry)
>  {
>  	struct swap_slots_cache *cache;
>  
> @@ -297,8 +297,6 @@ int free_swap_slot(swp_entry_t entry)
>  direct_free:
>  		swapcache_free_entries(&entry, 1);
>  	}
> -
> -	return 0;
>  }
>  
>  swp_entry_t folio_alloc_swap(struct folio *folio)
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
