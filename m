Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821F04B874D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiBPMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiBPMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:02:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B8E7F43
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:02:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3AF0321763;
        Wed, 16 Feb 2022 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645012922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kr9dETkBJpugtcSkfZO+bjcmUGF0KSfTN/IBCGVngP4=;
        b=nfePnksG+NG2Z0qM7wRUlAloNATUCtIQUk6znsvYEpA4hxSTZsw5bFcerWsG8u8cpTCe8d
        EFqsssmkAnhb6wUyRkbLkp+4dkvBgCi/kpKbIgjVAoGKU4TP7pL3+kw+KhTuaT2uck89BN
        RKLIIhI63NxuWfr0co0p9JtcCWR4e6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645012922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kr9dETkBJpugtcSkfZO+bjcmUGF0KSfTN/IBCGVngP4=;
        b=Dd1MZt1sZ8lHTN+X+ydf4DfYr812TeEkgjBiybL0cdX7B9OK5TtVvtm/FEqztwOeS8ZBwR
        xp+n6JXhvcgHoZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A04513AF3;
        Wed, 16 Feb 2022 12:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H5ShBbrnDGJqQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 16 Feb 2022 12:02:02 +0000
Message-ID: <d6f991f6-ce07-853a-e87b-5eda97a35733@suse.cz>
Date:   Wed, 16 Feb 2022 13:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
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
 <20220215145111.27082-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/5] mm/page_alloc: Track range of active PCP lists during
 bulk free
In-Reply-To: <20220215145111.27082-3-mgorman@techsingularity.net>
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
> free_pcppages_bulk() frees pages in a round-robin fashion. Originally,
> this was dealing only with migratetypes but storing high-order pages
> means that there can be many more empty lists that are uselessly
> checked. Track the minimum and maximum active pindex to reduce the
> search space.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 08de32cfd9bb..c5110fdeb115 100644
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
> @@ -1478,10 +1480,17 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			if (++pindex == NR_PCP_LISTS)

Hmm, so in the very first iteration at this point pindex is already 1. This
looks odd even before the patch, as order 0 MIGRATE_UNMOVABLE list is only
processed after all the higher orders?

>  				pindex = 0;

Also shouldn't this wrap-around check also use min_index/max_index instead
of NR_PCP_LISTS and 0?

>  			list = &pcp->lists[pindex];
> -		} while (list_empty(list));
> +			if (!list_empty(list))
> +				break;
> +
> +			if (pindex == max_pindex)
> +				max_pindex--;
> +			if (pindex == min_pindex)

So with pindex 1 and min_pindex == 0 this will not trigger until
(eventually) the first pindex wrap around, which seems suboptimal. But I can
see the later patches change things substantially anyway so it may be moot...

> +				min_pindex++;
> +		} while (1);
>  
>  		/* This is the only non-empty list. Free them all. */
> -		if (batch_free == NR_PCP_LISTS)
> +		if (batch_free >= max_pindex - min_pindex)
>  			batch_free = count;
>  
>  		order = pindex_to_order(pindex);

