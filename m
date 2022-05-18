Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE54452B771
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiERJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiERJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:37:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A3C8BD4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:37:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C97E121BBE;
        Wed, 18 May 2022 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652866668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HzOkeYYjSkPEtsKb0hML8fTPGO3mMqRS/q6R7KG3LyM=;
        b=Jx7fnVbOJ3gO9DN6ryDRbldgEIhfeUCubpkL9E8Ke9vXwuHlKKFWZ0zCa6LQGDlf2vwkjB
        LSLIOXTpE9vbYpAJiwWiEH0B8obcqAVK+htKlK6oei/RQ3iTJs74+K1Slro6fhbbLV1fjT
        IkuPvB/3ssIsOAG10J6OpbjNzOCohps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652866668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HzOkeYYjSkPEtsKb0hML8fTPGO3mMqRS/q6R7KG3LyM=;
        b=lzNEiCgKHyOOYmDZHGS7KQd6PbSt0MhgwODN+OrLOko2B5jPkiviP8iEUuG3DMXU8EnQ6W
        SYgAMdOe/qtQeiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93BB9133F5;
        Wed, 18 May 2022 09:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ndHkHGu+hGL1EQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 09:37:47 +0000
Date:   Wed, 18 May 2022 11:37:45 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] mm/swap: remove buggy cache->nr check in
 refill_swap_slots_cache
Message-ID: <YoS+aS+BwKhAVWAr@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-7-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-7-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:07PM +0800, Miaohe Lin wrote:
> refill_swap_slots_cache is always called when cache->nr is 0. And if
> cache->nr != 0, we should return cache->nr instead of 0. So remove
> such buggy and confusing check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

With Andrew's ammendment:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/swap_slots.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 2f877e6f87d7..2a65a89b5b4d 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -258,7 +258,7 @@ void enable_swap_slots_cache(void)
>  /* called with swap slot cache's alloc lock held */
>  static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>  {
> -	if (!use_swap_slot_cache || cache->nr)
> +	if (!use_swap_slot_cache)
>  		return 0;
>  
>  	cache->cur = 0;
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
