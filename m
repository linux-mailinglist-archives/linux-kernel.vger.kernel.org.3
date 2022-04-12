Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5F4FE452
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356247AbiDLPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiDLPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F0855BE7B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649775966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcMg4A6w1yZzg9wuJ8koxUDNZ+ppyVYaFpMl0UYBBWU=;
        b=Qs4HOQdwcClGbLa0Ej/PFcCvVHmgbD6L1GepY0hWtE/mVPoFSbA4hpd3Q8HqUI/qXDmTz5
        jt7MmC4KIOf28iFaMIeTfKMMn0ih4/qQfLAwCxtAPesCZXwsP3CXFxgaCDIcWxDMstPRmg
        WdAPwAmE48aC3U94TiPmILXI7ZRn55k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-Mxj9mScWObKbG0VucsyIPw-1; Tue, 12 Apr 2022 11:06:04 -0400
X-MC-Unique: Mxj9mScWObKbG0VucsyIPw-1
Received: by mail-wm1-f71.google.com with SMTP id p31-20020a05600c1d9f00b0038ed0964a90so376715wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XcMg4A6w1yZzg9wuJ8koxUDNZ+ppyVYaFpMl0UYBBWU=;
        b=r6CMlYNRdRLfgeBs04wc0gRa0pmMQ/lZGt2BHi4AoFrOJJew/GjCmDhhsFmcuHKGQJ
         r9N38vImdUDs1vqywRCJszuS1gLEtqjZP83vm2EubprZB2hkf2lq6EpSXaq3trpk5yLP
         reS4QWzI81qv8VdYZG6hHeTk/teT4dxgEYqeKasv98fnV1zsqYvBjvx2o4un+LTTJF7N
         b6EnROu+Zff30Flje4vdIHkPrs8MKwBERT+jchinh/YlC4HRCAmOGxqnkk4I7T1HO1ef
         0ZT5QAgXV25TKMyuvAU8BpSlxTKjW1s5bt9f3LP/RH8NNvESVBmRkJNn4DWLmXUyL5oO
         kEIg==
X-Gm-Message-State: AOAM531akp75SJvsLuesGNL8TF51ulFCDrf0neH1WkAZASxKbK6h0fd7
        afpJBsmeNgxCg6SNyqg+XMLeHlj4FL3k39xCmAKFsOJgeRnuvkFX1Fef9URwjnkbi/ilYENfEUH
        771oUgLsggqXwbU/+oES+gaxL
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr28432436wre.711.1649775963501;
        Tue, 12 Apr 2022 08:06:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUf6mPkR4HTFyBmy700+AFHseZaInznKf5AOScugwmvW/0QoMnFDweHlOBb+4v1i50K+KUow==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr28432412wre.711.1649775963050;
        Tue, 12 Apr 2022 08:06:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0038ec0c4a2e7sm2522715wmj.11.2022.04.12.08.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 08:06:02 -0700 (PDT)
Message-ID: <afa115e6-d2ae-eeff-ba31-f8b2a5715b95@redhat.com>
Date:   Tue, 12 Apr 2022 17:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for
 unmovable pages
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
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
 <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
 <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
 <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
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

On 12.04.22 17:01, Zi Yan wrote:
> On 12 Apr 2022, at 10:49, David Hildenbrand wrote:
> 
>> On 12.04.22 16:07, Zi Yan wrote:
>>> On 12 Apr 2022, at 9:10, David Hildenbrand wrote:
>>>
>>>> On 06.04.22 17:18, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> Enable set_migratetype_isolate() to check specified sub-range for
>>>>> unmovable pages during isolation. Page isolation is done
>>>>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>>>>> granularity are intended to be isolated. For example,
>>>>> alloc_contig_range(), which uses page isolation, allows ranges without
>>>>> alignment. This commit makes unmovable page check only look for
>>>>> interesting pages, so that page isolation can succeed for any
>>>>> non-overlapping ranges.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>>  /*
>>>>> - * This function checks whether pageblock includes unmovable pages or not.
>>>>> + * This function checks whether the range [start_pfn, end_pfn) includes
>>>>> + * unmovable pages or not. The range must fall into a single pageblock and
>>>>> + * consequently belong to a single zone.
>>>>>   *
>>>>>   * PageLRU check without isolation or lru_lock could race so that
>>>>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
>>>>> @@ -28,12 +30,14 @@
>>>>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>>>>   *
>>>>>   */
>>>>> -static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>> -				 int migratetype, int flags)
>>>>> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
>>>>> +				int migratetype, int flags)
>>>>>  {
>>>>> -	unsigned long iter = 0;
>>>>> -	unsigned long pfn = page_to_pfn(page);
>>>>> -	unsigned long offset = pfn % pageblock_nr_pages;
>>>>> +	unsigned long pfn = start_pfn;
>>>>> +	struct page *page = pfn_to_page(pfn);
>>>>
>>>>
>>>> Just do
>>>>
>>>> struct page *page = pfn_to_page(start_pfn);
>>>> struct zone *zone = page_zone(page);
>>>>
>>>> here. No need to lookup the zone again in the loop because, as you
>>>> document "must ... belong to a single zone.".
>>>>
>>>> Then, there is also no need to initialize "pfn" here. In the loop header
>>>> is sufficient.
>>>>
>>>
>>> Sure.
>>>
>>>>> +
>>>>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
>>>>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>>>>
>>>>>  	if (is_migrate_cma_page(page)) {
>>>>>  		/*
>>>>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  		return page;
>>>>>  	}
>>>>>
>>>>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>>>>> -		page = pfn_to_page(pfn + iter);
>>>>> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>>>> +		struct zone *zone;
>>>>> +
>>>>> +		page = pfn_to_page(pfn);
>>>>> +		zone = page_zone(page);
>>>>>
>>>>>  		/*
>>>>>  		 * Both, bootmem allocations and memory holes are marked
>>>>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  			}
>>>>>
>>>>>  			skip_pages = compound_nr(head) - (page - head);
>>>>> -			iter += skip_pages - 1;
>>>>> +			pfn += skip_pages - 1;
>>>>>  			continue;
>>>>>  		}
>>>>>
>>>>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  		 */
>>>>>  		if (!page_ref_count(page)) {
>>>>>  			if (PageBuddy(page))
>>>>> -				iter += (1 << buddy_order(page)) - 1;
>>>>> +				pfn += (1 << buddy_order(page)) - 1;
>>>>>  			continue;
>>>>>  		}
>>>>>
>>>>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  	return NULL;
>>>>>  }
>>>>>
>>>>> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>>>>> +/*
>>>>> + * This function set pageblock migratetype to isolate if no unmovable page is
>>>>> + * present in [start_pfn, end_pfn). The pageblock must intersect with
>>>>> + * [start_pfn, end_pfn).
>>>>> + */
>>>>> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
>>>>> +			unsigned long start_pfn, unsigned long end_pfn)
>>>>
>>>> I think we might be able do better, eventually not passing start_pfn at
>>>> all. Hmm.
>>>
>>> IMHO, having start_pfn and end_pfn in the parameter list would make the
>>> interface easier to understand. Otherwise if we remove start_pfn,
>>> the caller needs to adjust @page to be within the range of [start_pfn,
>>> end_pfn)
>>>
>>>>
>>>> I think we want to pull out the
>>>> start_isolate_page_range()/undo_isolate_page_range() interface change
>>>> into a separate patch.
>>>
>>> You mean a patch just adding
>>>
>>> unsigned long isolate_start = pfn_max_align_down(start_pfn);
>>> unsigned long isolate_end = pfn_max_align_up(end_pfn);
>>>
>>> in start_isolate_page_range()/undo_isolate_page_range()?
>>>
>>> Yes I can do that.
>>
>> I think we have to be careful with memory onlining/offlining. There are
>> corner cases where we get called with only pageblock alignment and
>> must not adjust the range.
> 
> In the patch below, you added a new set of start_isolate_pageblocks()
> and undo_isolate_pageblocks(), where start_isolate_pageblocks() still
> calls set_migratetype_isolate() and noted their range should not be
> adjusted. But in my patch, set_migratetype_isolate() adjusts
> the range for has_unmovable_pages() check. Do you mean

Right, that's broken in your patch. Memory onlining/offlining behavior
changed recently when "vmemmap on memory" was added. The start range
might only be aligned to pageblocks but not MAX_ORDER -1 -- and we must
not align u..

The core thing is that there are two types of users: memory offlining
that knows what it's doing when it aligns to less then MAX_ORDER -1 ,
and range allocators, that just pass in the range of interest.

> start_isolate_pageblocks() should call a different version of
> set_migratetype_isolate() without range adjustment? That can be done
> with an additional parameter in start_isolate_page_range(), like
> bool strict, right?

Random boolean flags are in general frowned upon ;)

-- 
Thanks,

David / dhildenb

