Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186274E4471
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiCVQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiCVQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D45B17306C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647967365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbDUOeqShz33twUSi6DXosV6ZkPSPlcuLCDCl6mkuQM=;
        b=huV0i6lhVMAF5x92a0od1Jm1e7Lkm1n0WhLmYkhwSEEzWtTqs4DqnWMFK0I+8uzq5KPcql
        I+Fl9hEJZLPYsFfeTboMbcv7KR3QZnKR+DzfzhKIGhNSJjbmqhWjbqRrR3+wuNWy/J787J
        nTbm+OQb+F0B1l2nFsVqPEqHxfBG9IQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-tKWukRRwO1aMQaxsyEzjkQ-1; Tue, 22 Mar 2022 12:42:44 -0400
X-MC-Unique: tKWukRRwO1aMQaxsyEzjkQ-1
Received: by mail-wr1-f69.google.com with SMTP id i64-20020adf90c6000000b00203f2b5e090so2150423wri.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pbDUOeqShz33twUSi6DXosV6ZkPSPlcuLCDCl6mkuQM=;
        b=RvFvb4KSdqCqie2GrqqfpzHPvYKUtLi4MtYcubxSgMj0R0CVDXw9Gp+FTxT5kayRzN
         2C02o0dE2WuY66Howh9dpC1GGHg6Y258Cp9D2ppNblszL4yZpr1FgMFF3rmz1rF5hIqc
         wphmKgNKwoFk1apCPJZIYPd1XUrzQ7WwmkCPNTFfa6+tMXzKjx1j/kn+E4hohvlNgx7p
         rz6dHgHpgfjSGyw2VaGFQZjwk5om8/gb3hNFFeKGUTi8PALgcJn3gRlnxFAhPGzpB1KQ
         jp1zimIItSopG+Of+oyddJiedsEC7qSt303FGdIqFE87TUXQwkF6PcCzV76dK04fzTcn
         fDyg==
X-Gm-Message-State: AOAM532nrCtr+HQIeD9CZMWB7UOGMkYA86wzN0w/luIdJJ9ZfcRW6EjN
        GUhoBrR+yDG3iVA1ZtiK3rppRzdZZlnSTdzwLLykmVAt97DUzR5q+KdnE43w3O/48I1BAZVZuUR
        Whnk3B8Mxyf9VcR6CjxUbIGMT
X-Received: by 2002:adf:f192:0:b0:203:e38f:afa1 with SMTP id h18-20020adff192000000b00203e38fafa1mr22986506wro.120.1647967362968;
        Tue, 22 Mar 2022 09:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd4H5zsnoSZNx8cpL6j2SFxZOQKMbrXPFzGhHlMfw61cH0xjGomBTtGVrnNwirsHukscpKkQ==
X-Received: by 2002:adf:f192:0:b0:203:e38f:afa1 with SMTP id h18-20020adff192000000b00203e38fafa1mr22986485wro.120.1647967362657;
        Tue, 22 Mar 2022 09:42:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:de00:549e:e4e4:98df:ff72? (p200300cbc708de00549ee4e498dfff72.dip0.t-ipconnect.de. [2003:cb:c708:de00:549e:e4e4:98df:ff72])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm2243869wmq.46.2022.03.22.09.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 09:42:42 -0700 (PDT)
Message-ID: <a4c81f17-b32c-8873-ff73-a8729171e93f@redhat.com>
Date:   Tue, 22 Mar 2022 17:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220317153733.2171277-1-zi.yan@sent.com>
 <20220317153733.2171277-3-zi.yan@sent.com>
 <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
 <3379379B-489B-460F-8B01-9A1D584A5036@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <3379379B-489B-460F-8B01-9A1D584A5036@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 19:23, Zi Yan wrote:
> On 21 Mar 2022, at 13:30, David Hildenbrand wrote:
> 
>> On 17.03.22 16:37, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Enable set_migratetype_isolate() to check specified sub-range for
>>> unmovable pages during isolation. Page isolation is done
>>> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
>>> pages within that granularity are intended to be isolated. For example,
>>> alloc_contig_range(), which uses page isolation, allows ranges without
>>> alignment. This commit makes unmovable page check only look for
>>> interesting pages, so that page isolation can succeed for any
>>> non-overlapping ranges.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  include/linux/page-isolation.h | 10 +++++
>>>  mm/page_alloc.c                | 13 +------
>>>  mm/page_isolation.c            | 69 ++++++++++++++++++++--------------
>>>  3 files changed, 51 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>>> index e14eddf6741a..eb4a208fe907 100644
>>> --- a/include/linux/page-isolation.h
>>> +++ b/include/linux/page-isolation.h
>>> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
>>>  {
>>>  	return migratetype == MIGRATE_ISOLATE;
>>>  }
>>> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
>>> +{
>>> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>>> +}
>>> +
>>> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
>>> +{
>>> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>>> +}
>>> +
>>>  #else
>>>  static inline bool has_isolate_pageblock(struct zone *zone)
>>>  {
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 6de57d058d3d..680580a40a35 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>>>  }
>>>
>>>  #ifdef CONFIG_CONTIG_ALLOC
>>> -static unsigned long pfn_max_align_down(unsigned long pfn)
>>> -{
>>> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>>> -}
>>> -
>>> -static unsigned long pfn_max_align_up(unsigned long pfn)
>>> -{
>>> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>>> -}
>>> -
>>>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>>> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>>  	 * put back to page allocator so that buddy can use them.
>>>  	 */
>>>
>>> -	ret = start_isolate_page_range(pfn_max_align_down(start),
>>> -				       pfn_max_align_up(end), migratetype, 0);
>>> +	ret = start_isolate_page_range(start, end, migratetype, 0);
>>>  	if (ret)
>>>  		return ret;
>>
>> Shouldn't we similarly adjust undo_isolate_page_range()? IOW, all users
>> of pfn_max_align_down()/pfn_max_align_up(). would be gone from that file
>> and you can move these defines into mm/page_isolation.c instead of
>> include/linux/page-isolation.h?
> 
> undo_isolate_page_range() faces much simpler situation, just needing
> to unset migratetype. We can just pass pageblock_nr_pages aligned range
> to it. For start_isolate_page_range(), start and end are also used for
> has_unmovable_pages() for precise unmovable page identification, so
> they cannot be pageblock_nr_pages aligned. But for readability and symmetry,
> yes, I can change undo_isolate_page_range() too.
Yeah, we should call both with the same range and any extension of the
range should be handled internally.

I thought about some corner cases, especially once we relax some (CMA)
alignment thingies -- then, the CMA area might be placed at weird
locations. I haven't checked to which degree they apply, but we should
certainly keep them in mind whenever we're extending the isolation range.

We can assume that the contig range we're allocation
a) Belongs to a single zone
b) Does not contain any memory holes / mmap holes

Let's double check


1) Different zones in extended range

...   ZONE A  ][ ZONE B ....
[ Pageblock X ][ Pageblock Y ][ Pageblock Z ]
[        MAX_ORDER - 1       ]

We can never create a higher-order page between X and Y, because they
are in different zones. Most probably we should *not* extend the range
to cover pageblock X in case the zones don't match.

The same consideration applies to the end of the range, when extending
the isolation range.

But I wonder if we can have such a zone layout. At least
mm/page_alloc.c:find_zone_movable_pfns_for_nodes() makes sure to always
align the start of ZONE_MOVABLE to MAX_ORDER_NR_PAGES. I hope it applies
to all other zones as well? :/

Anyhow, it should be easy to check when isolating/un-isolating. Only
conditionally extend the range if the zones of both pageblocks match.


When eventually growing MAX_ORDER_NR_PAGES further, could we be in
trouble because we could suddenly span multiple zones with a single
MAX_ORDER - 1 page? Then we'd have to handle that I guess.


2) mmap holes

I think that's already covered by the existing __first_valid_page()
handling.


So, I feel like we might have to tackle the zones issue, especially when
extending MAX_ORDER_NR_PAGES?

-- 
Thanks,

David / dhildenb

