Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3104B8685
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiBPLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:17:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiBPLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:17:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ECD1AA8A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:16:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6766212C0;
        Wed, 16 Feb 2022 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645010208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xamDngz84UWWOYTwcGYy9/wM5Fem6zTjMXuclkY3poc=;
        b=n4sVdU2+b5z0wXITqOJHUvvpPsQ1YgOanWlN7iWwltTImmnj7/dGuG6hevkHYeBW0ew+Z7
        FNSjp+5mqb1Ab2b+pm66pxGJ5kO9pUWBnRy+PQQDP+UUCsPpXT2th5M4sODu/PkKe2LpLn
        ZU/vPpfA2JesRXwgJg0K4xsaKHO7Utc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645010208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xamDngz84UWWOYTwcGYy9/wM5Fem6zTjMXuclkY3poc=;
        b=UYJM8mnd9kTHbIvijySHuu5aoW8olvhYHvY0OP/F1wqlMue/KaG19bH5POJFF4syHLewMo
        +1a2yWn2yR0MCHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C74A313ADB;
        Wed, 16 Feb 2022 11:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lk8OMCDdDGLxKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 16 Feb 2022 11:16:48 +0000
Message-ID: <95a205bc-fd35-565e-5597-deaadbf8b98a@suse.cz>
Date:   Wed, 16 Feb 2022 12:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/5] mm/page_alloc: Fetch the correct pcp buddy during
 bulk free
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
 <20220215145111.27082-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220215145111.27082-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 15:51, Mel Gorman wrote:
> free_pcppages_bulk() prefetches buddies about to be freed but the
> order must also be passed in as PCP lists store multiple orders.
> 
> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..08de32cfd9bb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1432,10 +1432,10 @@ static bool bulkfree_pcp_prepare(struct page *page)
>  }
>  #endif /* CONFIG_DEBUG_VM */
>  
> -static inline void prefetch_buddy(struct page *page)
> +static inline void prefetch_buddy(struct page *page, unsigned int order)
>  {
>  	unsigned long pfn = page_to_pfn(page);
> -	unsigned long buddy_pfn = __find_buddy_pfn(pfn, 0);
> +	unsigned long buddy_pfn = __find_buddy_pfn(pfn, order);
>  	struct page *buddy = page + (buddy_pfn - pfn);
>  
>  	prefetch(buddy);
> @@ -1512,7 +1512,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			 * prefetch buddy for the first pcp->batch nr of pages.
>  			 */
>  			if (prefetch_nr) {
> -				prefetch_buddy(page);
> +				prefetch_buddy(page, order);
>  				prefetch_nr--;
>  			}
>  		} while (count > 0 && --batch_free && !list_empty(list));

