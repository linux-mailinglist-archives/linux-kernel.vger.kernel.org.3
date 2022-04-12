Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F44FE24C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356112AbiDLNW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355702AbiDLNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A54AE52E66
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649769016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxNi3KUC9hG5+dIEHXwk8T0pk8dlLB9WdrbtBDd6QQY=;
        b=CkcnCcqJ+HVYx9BNiyo+unX+ms7tcvNC7RT4UMLP/XpOZuErh+Dl7fZ/ElOqMKLjRl0DiS
        LPBlpF1lnvSP+xigarDyc6viLLMfPUJYM1d9IMU6srBP0gcMOlZ3PAiea+FW+WSwREzyBd
        q30btojsGPirAOMfx2tOcI1WgdhJgmU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-LIxJ1Q-yP7aAPH5d7HcrHA-1; Tue, 12 Apr 2022 09:10:15 -0400
X-MC-Unique: LIxJ1Q-yP7aAPH5d7HcrHA-1
Received: by mail-wr1-f72.google.com with SMTP id f2-20020a056000036200b00207a14a1f96so1518151wrf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=cxNi3KUC9hG5+dIEHXwk8T0pk8dlLB9WdrbtBDd6QQY=;
        b=Z1G9ThR+gFYkfOS7X09Jrt4qzgyklwd2XqYzYjNbxaTM9lrQV2P9Z+fgCmKdMXyGcD
         qpaMAKh/dnFgjF2xLjkxQu0qbPMhPqIPVy0ALinrUYdAZPLgn1jsfwZwxlXwnqrBLG0F
         lpME/OjMb8F1sCHnwKM882zs8JRbIO2gMrSrFTm/PSplcevsov/p5p1G/C8dMejJPQVO
         lGpojT+a2I7U2UJQz3XdLunEOtS7CsV41vuutep9t9c9bmdZk9LWYPcjXcp9wEaWtlUt
         DnMNjK4xxFsI/3/jM+/4pld3hYMSe3x+nZQNkjeSv7UynhBy/wS1WuVfR+cHyt2CeYfL
         XOMw==
X-Gm-Message-State: AOAM530D7OK7k+jrNP9cwRn0XFWUqPTn1tIE9VPRkbevYAo4jMpLE7sn
        yPa8xb1n4JuXZh3gFsLHCJHxFA5FXH7ZylvOnAZUVe8Esyj9pRyO/0yudzAdA18IWGtpTmUFB/R
        o7h+V45mENSe0G9li96TBPivh
X-Received: by 2002:a1c:ed12:0:b0:38e:9e4e:2db2 with SMTP id l18-20020a1ced12000000b0038e9e4e2db2mr4092005wmh.96.1649769014224;
        Tue, 12 Apr 2022 06:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPO9VTOs/2MHLmQnUoLuhtZklz6TW1zHJj9EIuwagGg5Ey6vVOLVwIN01vt2AHQuMXqL4Efw==
X-Received: by 2002:a1c:ed12:0:b0:38e:9e4e:2db2 with SMTP id l18-20020a1ced12000000b0038e9e4e2db2mr4091971wmh.96.1649769013882;
        Tue, 12 Apr 2022 06:10:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm4506601wrv.19.2022.04.12.06.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 06:10:13 -0700 (PDT)
Message-ID: <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
Date:   Tue, 12 Apr 2022 15:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <20220406151858.3149821-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.22 17:18, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
> granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

[...]

>  /*
> - * This function checks whether pageblock includes unmovable pages or not.
> + * This function checks whether the range [start_pfn, end_pfn) includes
> + * unmovable pages or not. The range must fall into a single pageblock and
> + * consequently belong to a single zone.
>   *
>   * PageLRU check without isolation or lru_lock could race so that
>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
> @@ -28,12 +30,14 @@
>   * cannot get removed (e.g., via memory unplug) concurrently.
>   *
>   */
> -static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> -				 int migratetype, int flags)
> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
> +				int migratetype, int flags)
>  {
> -	unsigned long iter = 0;
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long offset = pfn % pageblock_nr_pages;
> +	unsigned long pfn = start_pfn;
> +	struct page *page = pfn_to_page(pfn);


Just do

struct page *page = pfn_to_page(start_pfn);
struct zone *zone = page_zone(page);

here. No need to lookup the zone again in the loop because, as you
document "must ... belong to a single zone.".

Then, there is also no need to initialize "pfn" here. In the loop header
is sufficient.

> +
> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>  
>  	if (is_migrate_cma_page(page)) {
>  		/*
> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		return page;
>  	}
>  
> -	for (; iter < pageblock_nr_pages - offset; iter++) {
> -		page = pfn_to_page(pfn + iter);
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +		struct zone *zone;
> +
> +		page = pfn_to_page(pfn);
> +		zone = page_zone(page);
>  
>  		/*
>  		 * Both, bootmem allocations and memory holes are marked
> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			}
>  
>  			skip_pages = compound_nr(head) - (page - head);
> -			iter += skip_pages - 1;
> +			pfn += skip_pages - 1;
>  			continue;
>  		}
>  
> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 */
>  		if (!page_ref_count(page)) {
>  			if (PageBuddy(page))
> -				iter += (1 << buddy_order(page)) - 1;
> +				pfn += (1 << buddy_order(page)) - 1;
>  			continue;
>  		}
>  
> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  	return NULL;
>  }
>  
> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
> +/*
> + * This function set pageblock migratetype to isolate if no unmovable page is
> + * present in [start_pfn, end_pfn). The pageblock must intersect with
> + * [start_pfn, end_pfn).
> + */
> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
> +			unsigned long start_pfn, unsigned long end_pfn)

I think we might be able do better, eventually not passing start_pfn at
all. Hmm.

I think we want to pull out the
start_isolate_page_range()/undo_isolate_page_range() interface change
into a separate patch.

Let me try to give it a shot, I'll try hacking something up real quick
to see if we can do better.

-- 
Thanks,

David / dhildenb

