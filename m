Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5D513364
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbiD1MRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345829AbiD1MRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E6ADAD135
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651148033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peo0ScnOD/kREKuRjyBJPvH3MAbi5TUpXP5WbTNJH+g=;
        b=hxGrb9uYlJdARRv1tMRKq6l8zXqXnvEy1Dwo8QtWH8MSJDtLO447Tb91krx3tjqAsSIFlI
        rYDgyabcljK+f1i7/s4hioXmcDd/1i1fvkoWEbak9ftrGimnrSdStZJtwVjTQpiMwa7Ts6
        m407XQP2cJyfRdmlZwESxDS3/P4pJTg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-lYx3b5tlMMq_0I_NyAD27Q-1; Thu, 28 Apr 2022 08:13:49 -0400
X-MC-Unique: lYx3b5tlMMq_0I_NyAD27Q-1
Received: by mail-ed1-f72.google.com with SMTP id r26-20020a50aada000000b00425afa72622so2624707edc.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=peo0ScnOD/kREKuRjyBJPvH3MAbi5TUpXP5WbTNJH+g=;
        b=DwtS6M/v19TTMBVln6NTsmmgjLuSjKiHYu9vy0uBiSzs3GF8hcoy0yK1RS0iWxmFH7
         DQEmyiJ4+DDeCtagtws9g8OyI2vv9Wdpb79HVjpgxZY0olNg7gxSp5VRWXJsxWvhltgq
         vzpO0t0SFAJLjfNcAVxq6Pi66ylNEN/kvWWPUx4fcQQ/VIMAtsPeiR36kyHFaGbuAgRV
         KPODnz7JtvSnttK/+DZRyzOzT1YJJwpGXGk5FCqAKqhTUYu4hdLUnLoOvWXLUafx59Xp
         c3WHttwxlK2hjuxdeqEpKiiNTv3iSRPVfIA0LkdHVqCCJ1kZxpgKivZq1z4oO4+SR0yT
         QL/Q==
X-Gm-Message-State: AOAM530dlWVuFpqDPt38EzurJnFM8eT7CkRDyTWEiQvmyknQKwOr9PWu
        9Q3HZDlG+RYTcDBEIaJ0UciNPe7nl9GGHKPmTA4eOEZFMadpVHFU/fABGQvvSbdDrfuOxUObOum
        hUJiNFY01kD05DL/rSLMwah3R
X-Received: by 2002:a05:6402:2309:b0:41f:a5a9:fe13 with SMTP id l9-20020a056402230900b0041fa5a9fe13mr35794019eda.123.1651148028278;
        Thu, 28 Apr 2022 05:13:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyWtRVzz9fglE7R6LGmifRxKTF/DA9SAlgj9lilGJMS+YqAMwvtx7BmKuyQwqme/iq0QpQoA==
X-Received: by 2002:a05:6402:2309:b0:41f:a5a9:fe13 with SMTP id l9-20020a056402230900b0041fa5a9fe13mr35793998eda.123.1651148028036;
        Thu, 28 Apr 2022 05:13:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id cy19-20020a0564021c9300b0042617ba6386sm1461422edb.16.2022.04.28.05.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 05:13:47 -0700 (PDT)
Message-ID: <f31caf6a-fb13-0be3-9fa2-0b4959cc0810@redhat.com>
Date:   Thu, 28 Apr 2022 14:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220307150725.6810-1-osalvador@suse.de>
 <20220307150725.6810-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm/page_alloc: Do not calculate node's total pages
 and memmap pages when empty
In-Reply-To: <20220307150725.6810-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.22 16:07, Oscar Salvador wrote:
> free_area_init_node() calls calculate_node_totalpages() and
> free_area_init_core(). The former to get node's {spanned,present}_pages,
> and the latter to calculate, among other things, how many pages per zone
> we spent on memmap_pages, which is used to substract zone's free pages.
> 
> On memoryless-nodes, it is pointless to perform such a bunch of work, so
> make sure we skip the calculations when having a node or empty zone.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Sorry, I'm late with review. My mailbox got flooded.

> ---
>  mm/page_alloc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 967085c1c78a..0b7d176a8990 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7312,6 +7312,10 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  	unsigned long realtotalpages = 0, totalpages = 0;
>  	enum zone_type i;
>  
> +	/* Skip calculation for memoryless nodes */
> +	if (node_start_pfn == node_end_pfn)
> +		goto no_pages;
> +

Just a NIT:

E.g., in zone_spanned_pages_in_node() we test for
	!node_start_pfn && !node_end_pfn

In update_pgdat_span(), we set
	node_start_pfn = node_end_pfn = 0;
when we find an empty node during memory unplug.

Therefore, I wonder if a helper "is_memoryless_node()" or "node_empty()"
might be reasonable, that just checks for either
	!node_start_pfn && !node_end_pfn
or
	node_start_pfn == node_end_pfn



>  	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		struct zone *zone = pgdat->node_zones + i;
>  		unsigned long zone_start_pfn, zone_end_pfn;
> @@ -7344,6 +7348,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  		realtotalpages += real_size;
>  	}
>  
> +no_pages:
>  	pgdat->node_spanned_pages = totalpages;
>  	pgdat->node_present_pages = realtotalpages;
>  	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
> @@ -7562,6 +7567,10 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		size = zone->spanned_pages;
>  		freesize = zone->present_pages;
>  
> +		/* No pages? Nothing to calculate then. */
> +		if (!size)
> +			goto no_pages;
> +
>  		/*
>  		 * Adjust freesize so that it accounts for how much memory
>  		 * is used by this zone for memmap. This affects the watermark
> @@ -7597,6 +7606,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		 * when the bootmem allocator frees pages into the buddy system.
>  		 * And all highmem pages will be managed by the buddy system.
>  		 */
> +no_pages:
>  		zone_init_internals(zone, j, nid, freesize);
>  
>  		if (!size)

We have another size check below. We essentially have right now:

"
	if (!size)
		goto no_pages;

	[code]
no_pages:
	zone_init_internals(zone, j, nid, freesize);

	if (!size)
		continue
	[more code]
"

IMHO, it would be nicer to avoid the label/goto by just doing a:

"
	if (!size) {
		zone_init_internals(zone, j, nid, 0);
		continue;
	}

	[code]
	zone_init_internals(zone, j, nid, freesize);
	[more code]
"

Or factoring out [code] into a separate function.


Anyhow, the change itself looks sane.

-- 
Thanks,

David / dhildenb

