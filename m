Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB64B9C46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiBQJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:42:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbiBQJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:42:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18B17073
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:41:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C133D21108;
        Thu, 17 Feb 2022 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645090910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wImjFANCLFR6cPTD07RUf9ZegKguk0qYibC7WDzmyME=;
        b=DDxqgEcnT6dFCJYPAAa4FQcongrOqUGxEbkkzjUHpNGsG4fIhzS+SXZE1E1dE0kw8iV+7o
        yMKcfYmcZXJGFsDw9VIOfu0uLU+NY3rgaUqNbRmjjlTrNnEGRxAXpDspDVl5eTJw5pXCWS
        7u/HnQs2GHQ+wbeLVesAC6sonjafLEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645090910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wImjFANCLFR6cPTD07RUf9ZegKguk0qYibC7WDzmyME=;
        b=XVskj/qAwLyEZce8KQOqtKiqBIfA/fDbx/lB508fJa59qjig4Lm6t25l04tNgvpcMo4KIk
        sVaBLRX5Z6NGPKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F4A013BBF;
        Thu, 17 Feb 2022 09:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nXczIl4YDmI4KQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 17 Feb 2022 09:41:50 +0000
Message-ID: <83d6e082-9289-e8cb-2e40-77650e2bb375@suse.cz>
Date:   Thu, 17 Feb 2022 10:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/6] mm/page_alloc: Track range of active PCP lists during
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
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220217002227.5739-3-mgorman@techsingularity.net>
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

On 2/17/22 01:22, Mel Gorman wrote:
> free_pcppages_bulk() frees pages in a round-robin fashion. Originally,
> this was dealing only with migratetypes but storing high-order pages
> means that there can be many more empty lists that are uselessly
> checked. Track the minimum and maximum active pindex to reduce the
> search space.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 08de32cfd9bb..85cc1fe8bcc5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1450,6 +1450,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  					struct per_cpu_pages *pcp)
>  {
>  	int pindex = 0;
> +	int min_pindex = 0;
> +	int max_pindex = NR_PCP_LISTS - 1;
>  	int batch_free = 0;
>  	int nr_freed = 0;
>  	unsigned int order;
> @@ -1475,13 +1477,20 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  		 */
>  		do {
>  			batch_free++;
> -			if (++pindex == NR_PCP_LISTS)
> -				pindex = 0;
> +			if (++pindex > max_pindex)
> +				pindex = min_pindex;
>  			list = &pcp->lists[pindex];
> -		} while (list_empty(list));
> +			if (!list_empty(list))
> +				break;
> +
> +			if (pindex == max_pindex)
> +				max_pindex--;
> +			if (pindex == min_pindex)
> +				min_pindex++;
> +		} while (1);
>  
>  		/* This is the only non-empty list. Free them all. */
> -		if (batch_free == NR_PCP_LISTS)
> +		if (batch_free >= max_pindex - min_pindex)
>  			batch_free = count;
>  
>  		order = pindex_to_order(pindex);

