Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E352D0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiESK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiESK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:57:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065C674C8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:57:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EACE41F86A;
        Thu, 19 May 2022 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uZD/sZperneDqTPmd/3WdovVji6ii5Xr/81SKEuRI4=;
        b=SPinQL3l1IrJeHOkOXoaUvW+T4FUNTVr5LsgEoOKh0t0ydiKxpj3mAwY8bV0lpIdi8E+th
        TxHLIrqz+O4LOnz4G+2x2BE5dpXSD06fCKEmxH/Qkgskm2rY50xwQXAwj76VWu8rJpnSOE
        iUijMuYueXfTDri4cKSeUZGCOFZTBqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957821;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uZD/sZperneDqTPmd/3WdovVji6ii5Xr/81SKEuRI4=;
        b=GFdxz3drPlEthQn5HQPEQgVP6OBYVfm5b3mhjwrdQffvVzpeuqVG+jYkjDFiozZEwVethz
        qAmY/KHBJIMBDpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1C3913AF8;
        Thu, 19 May 2022 10:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q/E6Ln0ihmJdWwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 19 May 2022 10:57:01 +0000
Message-ID: <5a0c9b7c-3620-3e0f-7510-d0fc3fa6ceda@suse.cz>
Date:   Thu, 19 May 2022 12:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/6] mm/page_alloc: Remove unnecessary page == NULL check
 in rmqueue
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220512085043.5234-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 10:50, Mel Gorman wrote:
> The VM_BUG_ON check for a valid page can be avoided with a simple
> change in the flow. The ZONE_BOOSTED_WATERMARK is unlikely in general
> and even more unlikely if the page allocation failed so mark the
> branch unlikely.

Hm, so that makes a DEBUG_VM config avoid the check. On the other hand,
it puts it on the path returning from rmqueue_pcplist() for all configs,
and that should be the fast path. So unless things further change in the
following patches, it doesn't seem that useful?

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/page_alloc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1c4c54503a5d..b543333dce8f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3765,17 +3765,18 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>  							migratetype);
> -	if (unlikely(!page))
> -		return NULL;
>  
>  out:
>  	/* Separate test+clear to avoid unnecessary atomics */
> -	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
> +	if (unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
>  		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>  		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
>  	}
>  
> -	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>  	return page;
>  }
>  

