Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92F552C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347462AbiFUHpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbiFUHox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5DC02317A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655797491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qyHl9dKG9kw9i0XSv42hyK6a8twaYRBy8w7/SfguIo=;
        b=hM7TOFoqnhQSz9VQDaNm6vijoSj2GxvxzCWb6hPupKkJMErgBdQ3irNHVg7BUVbgGDBmST
        n/mcjuAhc9R9SOeoExnmRehKW0THkUVPibnH9FjiGYAhEmzr5QMTdW7KNfv9HPcaEWlZgf
        kVWWg3mYhHL3/2V0v3xdOUS+FiqIS1E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-qnfapHUqOvCb40tfNm3-DA-1; Tue, 21 Jun 2022 03:44:50 -0400
X-MC-Unique: qnfapHUqOvCb40tfNm3-DA-1
Received: by mail-wr1-f69.google.com with SMTP id bv8-20020a0560001f0800b002183c5d5c26so2980554wrb.20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1qyHl9dKG9kw9i0XSv42hyK6a8twaYRBy8w7/SfguIo=;
        b=zjn4D5GgOezcXk9qW3A1ceNJ6KmdLMc9MCAJv5aLt3ser1RMea7QuozunvbYekvGRL
         wo4OAVGTfQ426DOO5H9mZDg4InJtpdXn3WYFjrbF2AZ2hX2CLFcxeyBLbzjVFbqeghSQ
         IlgRvidYqiqQWk1dk3ftsieOSAqpsEGOL7HBIQMMvubZsWfTf/u6T/5cabfcNIkzbp65
         PgSfFx2MePWSWZZpFUW/dsNVvMSbUN/R75olS81hZZrFgOd1VAWntGKf5Xash41JcpDv
         LUJdnvus6p6BEzdqkEkH0uDavQQZYoZSVf9l6BGis5fnXIitLCje5T/RxiAA+C8er9y0
         k0QQ==
X-Gm-Message-State: AOAM532aVU7aY28kyWpAJqm4KQpY8kJHn9/S/BNmoZU2Jv2+dKtIOy9h
        miIXDZt7hM3pzO/WD4IWpH57/FEc0Dio8ypMTIgBoQqNUlc9CHX38KN/x47xOYOrWv2AG1pzWmB
        GqKTTLrWeRB61OF1PUGS5A4Xt
X-Received: by 2002:a05:600c:2948:b0:39c:6480:f0a9 with SMTP id n8-20020a05600c294800b0039c6480f0a9mr39453634wmd.173.1655797489183;
        Tue, 21 Jun 2022 00:44:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvaJMw/HEUBaTx1P16vU3HCLg7qkgcOwhSNvfmheubp6OWfqrNYq2d+gHVU/IWcxc8/SU8jw==
X-Received: by 2002:a05:600c:2948:b0:39c:6480:f0a9 with SMTP id n8-20020a05600c294800b0039c6480f0a9mr39453611wmd.173.1655797488899;
        Tue, 21 Jun 2022 00:44:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm29860626wms.3.2022.06.21.00.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:44:48 -0700 (PDT)
Message-ID: <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
Date:   Tue, 21 Jun 2022 09:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total pages
 and memmap pages when empty
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621041717.6355-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 06:17, Oscar Salvador wrote:
> free_area_init_node() calls calculate_node_totalpages() and
> free_area_init_core(). The former to get node's {spanned,present}_pages,
> and the latter to calculate, among other things, how many pages per zone
> we spent on memmap_pages, which is used to substract zone's free pages.
> 
> On memoryless-nodes, it is pointless to perform such a bunch of work, so
> make sure we skip the calculations when having a node or empty zone.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_alloc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..2b9b2422ba32 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7361,6 +7361,10 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  	unsigned long realtotalpages = 0, totalpages = 0;
>  	enum zone_type i;
>  
> +	/* Skip calculation for memoryless nodes */
> +	if (pgdat_is_empty(pgdat))
> +		goto no_pages;
> +
>  	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		struct zone *zone = pgdat->node_zones + i;
>  		unsigned long zone_start_pfn, zone_end_pfn;
> @@ -7393,6 +7397,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  		realtotalpages += real_size;
>  	}
>  
> +no_pages:
>  	pgdat->node_spanned_pages = totalpages;
>  	pgdat->node_present_pages = realtotalpages;
>  	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
> @@ -7610,6 +7615,12 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		size = zone->spanned_pages;
>  		freesize = zone->present_pages;
>  
> +		/* No pages? Nothing to calculate then. */
> +		if (!size) {
> +			zone_init_internals(zone, j, nid, 0);
> +			continue;
> +		}
> +
>  		/*
>  		 * Adjust freesize so that it accounts for how much memory
>  		 * is used by this zone for memmap. This affects the watermark
> @@ -7647,9 +7658,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		 */
>  		zone_init_internals(zone, j, nid, freesize);
>  
> -		if (!size)
> -			continue;
> -
>  		set_pageblock_order();
>  		setup_usemap(zone);
>  		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
> @@ -7730,7 +7738,7 @@ static void __init free_area_init_node(int nid)
>  	pgdat->node_start_pfn = start_pfn;
>  	pgdat->per_cpu_nodestats = NULL;
>  
> -	if (start_pfn != end_pfn) {
> +	if (!pgdat_is_empty(pgdat)) {
>  		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
>  			(u64)start_pfn << PAGE_SHIFT,
>  			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);


It's worth noting that the check in pgdat_is_empty() is slightly
different. I *think* it doesn't matter in practice, yet I wonder if we
should simply fixup (currently unused) pgdat_is_empty().

Anyhow

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

