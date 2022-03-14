Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D034D8A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbiCNRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiCNRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BAAD34B94
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647278041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAONPV5TRI2rOpqSpmMyMB9BD5aXa/UL7zZiN1WaZes=;
        b=Iv8yu3xc9cCQ+qBG50MiYFM0yD/JlfG1vuvaHCfkX9Mu5ZprzGUdgTsHrl9mT7E9RJz2cU
        qCYAP6F9kXTrgvNwLDAM5touw8YlCH5iCyfDKGAQ6qrUKgeAOhncM81PGbfnsumpyZ5kjJ
        oIPJi6pO5XKioD3BfRv5a7h1/neJK/g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-P_wDxSrRPp6dCESNi80gBQ-1; Mon, 14 Mar 2022 13:14:00 -0400
X-MC-Unique: P_wDxSrRPp6dCESNi80gBQ-1
Received: by mail-wm1-f70.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso9911734wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=iAONPV5TRI2rOpqSpmMyMB9BD5aXa/UL7zZiN1WaZes=;
        b=XjifD3Y7rx9J44iBb3s8zj8grE+oZRiAjYZtXX8ij0s4WBm2dRGr2m+t6sKcAkmVKV
         z2Fs1mmI4QhETJczm6HwXwLbBygtnd4vX/pdsrQzuJGVfRI22HO2XIy/lJN3YjfIBPtE
         r5S/VCyOLuI6jHBXkbmgJCZ4idYKI/7f9zuCvZ3hDEguv/uGPRvKAOfT3DtjEc/cdyL1
         VqaP7ctuaByOXG/uNTlenRxTNiqjZiVEXFDWubH9AsUkcLYYuUzDnTWhym0ArDAwKd9S
         mHqoAvF9kh4VZCqQZpMhule5XRdeBSz1Ww5nR+IMNGb904sx9+OAI4Ap1MnInDlAO5s/
         gt2w==
X-Gm-Message-State: AOAM532332+UoI5cOb62VtCJXWzZnzJuqhsREAvHCLZWYSKtDqVAd6mm
        OO1A+wdJ+atC+NhmxmMoDilifSOwGiLSrJJ4PZg38+mVW7ykGsIXP+N06IdHxOeMSmmNsQOXxea
        2gGYpf/5/XKEA/6h5DVyAXT6M
X-Received: by 2002:a05:600c:3509:b0:389:f7f9:7b9d with SMTP id h9-20020a05600c350900b00389f7f97b9dmr183471wmq.4.1647278039381;
        Mon, 14 Mar 2022 10:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMlXe0JZo7IsQjOotU0ZRoQURVItzZT4okfGXuvey2OHb8WQ8UwWZCgbE8CFf15963Z28pvQ==
X-Received: by 2002:a05:600c:3509:b0:389:f7f9:7b9d with SMTP id h9-20020a05600c350900b00389f7f97b9dmr183453wmq.4.1647278039145;
        Mon, 14 Mar 2022 10:13:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:9a00:b2c1:8682:b807:e870? (p200300cbc7049a00b2c18682b807e870.dip0.t-ipconnect.de. [2003:cb:c704:9a00:b2c1:8682:b807:e870])
        by smtp.gmail.com with ESMTPSA id s17-20020adfbc11000000b001f023d197b8sm14086221wrg.68.2022.03.14.10.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 10:13:58 -0700 (PDT)
Message-ID: <1623cd68-8437-9404-f183-153741bbf84c@redhat.com>
Date:   Mon, 14 Mar 2022 18:13:57 +0100
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
References: <20220311183656.1911811-1-zi.yan@sent.com>
 <20220311183656.1911811-3-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <20220311183656.1911811-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 19:36, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page-isolation.h | 10 ++++++++
>  mm/page_alloc.c                | 13 +---------
>  mm/page_isolation.c            | 47 +++++++++++++++++++++-------------
>  3 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index e14eddf6741a..eb4a208fe907 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
>  {
>  	return migratetype == MIGRATE_ISOLATE;
>  }
> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
> +{
> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
> +{
> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
>  #else
>  static inline bool has_isolate_pageblock(struct zone *zone)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6de57d058d3d..680580a40a35 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> -static unsigned long pfn_max_align_down(unsigned long pfn)
> -{
> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
> -static unsigned long pfn_max_align_up(unsigned long pfn)
> -{
> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 * put back to page allocator so that buddy can use them.
>  	 */
>  
> -	ret = start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype, 0);
> +	ret = start_isolate_page_range(start, end, migratetype, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b34f1310aeaa..e0afc3ee8cf9 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -16,7 +16,8 @@
>  #include <trace/events/page_isolation.h>
>  
>  /*
> - * This function checks whether pageblock includes unmovable pages or not.
> + * This function checks whether pageblock within [start_pfn, end_pfn) includes
> + * unmovable pages or not.
>   *
>   * PageLRU check without isolation or lru_lock could race so that
>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
> @@ -29,11 +30,14 @@
>   *
>   */
>  static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> -				 int migratetype, int flags)
> +				 int migratetype, int flags,
> +				 unsigned long start_pfn, unsigned long end_pfn)
>  {
> -	unsigned long iter = 0;
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long offset = pfn % pageblock_nr_pages;
> +	unsigned long first_pfn = max(page_to_pfn(page), start_pfn);
> +	unsigned long pfn = first_pfn;
> +	unsigned long last_pfn = min(ALIGN(pfn + 1, pageblock_nr_pages), end_pfn);
> +
> +	page = pfn_to_page(pfn);

I think we should get rid of the page argument completely. The caller
should pass in a reasonable [start_pfn, end_pfn) range, and to any
necessary fixups to the range outside of this function.

The goal should be to have

pfn = start_pfn

and replacing last_pfn by end_pfn.


Ideally we'd end up with "This function checks whether the range
[start_pfn, end_pfn) contains unmovable pages or not."


What would be missing to achieve that?

-- 
Thanks,

David / dhildenb

