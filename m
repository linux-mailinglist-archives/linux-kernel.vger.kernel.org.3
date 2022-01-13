Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C392848D7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiAMM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbiAMM2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642076895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnfVK2fyY9BtL+cahlLSPFYi/lDkJGG3ZpACsVHPbRc=;
        b=Ip5xELiBEHUKiYPVrIoC3pU9Z/VdsZP/Ndu+CaLS8NmmuiBVqmYRtTKxh3ZOzKgeBK4ZD9
        BXrdIpcfU8xyXxGzWOgybyIE+Y+4OksWe8NbK0Msw89j4cz5Y6M/+Ci7etCjwj3F2Hu668
        NWVtjvQupIg2STvodZ0P/ecMKizzKR4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-eolVD2AdMAKu3qLoXa8EJg-1; Thu, 13 Jan 2022 07:28:14 -0500
X-MC-Unique: eolVD2AdMAKu3qLoXa8EJg-1
Received: by mail-ed1-f72.google.com with SMTP id h1-20020aa7cdc1000000b0040042dd2fe4so3927956edw.17
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hnfVK2fyY9BtL+cahlLSPFYi/lDkJGG3ZpACsVHPbRc=;
        b=AMuhBDo4Ai6GhwX7fqdM4eZ1jPmTIE1Dd9imutg2GyjiB35jQnb7bwvfMlwJ9sl8u8
         W2wj1ISl/65ZWLltsyr0NwYCO9jJaUc7E2/5C1EKNh+7lOb5bqJKT7KE1/K4AL0o+jsT
         qyEo4X+KRdR/1OcDChKrl3mkzTdgQ1qVFtTTyMFKidtjqKIXfImWlezRpUY2Q0ulOCfG
         xTkVcWszeKmRwiIrdluGKeeIsTxrmor16aBSVyrekN3+T8kH5j6KWBtPQs7G67JpOzjL
         Oy1TYtOXU54FQyiR/TigH420AX05hEYlhvTKBbY4xEQF9vYLOuJlc2l4NQz81mzUDCyf
         lG/A==
X-Gm-Message-State: AOAM530AGX5o5HJQ0TuAlw1AWubU7/EmEahk2e/0WlqMUGQK+XWKkGwB
        NiqaV/2UTiEeaBaWrxMWyzKOS3xqVUMSWuGMtPMu3mwR3ugJT/e3hpYAFqlHYY0oTpso+gtZxIm
        LkOZXjPVzwTUcpAO7Xuwbf7VN
X-Received: by 2002:a50:8d16:: with SMTP id s22mr3857827eds.141.1642076893363;
        Thu, 13 Jan 2022 04:28:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzDUme++gR+E7EfrqgLj1iyeR0r4RpB81KvaPod0mEHW3Q7ncqa9lY+1sUM8bAVvrgQ/bdNg==
X-Received: by 2002:a50:8d16:: with SMTP id s22mr3857806eds.141.1642076893116;
        Thu, 13 Jan 2022 04:28:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id la21sm830830ejc.137.2022.01.13.04.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:28:12 -0800 (PST)
Message-ID: <ae2862a0-c39c-ed2f-23fe-510c6c2fad5c@redhat.com>
Date:   Thu, 13 Jan 2022 13:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-2-zi.yan@sent.com>
 <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
 <YeAO0vtyjWWMRliF@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YeAO0vtyjWWMRliF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 12:36, Mike Rapoport wrote:
> On Wed, Jan 12, 2022 at 11:54:49AM +0100, David Hildenbrand wrote:
>> On 05.01.22 22:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
>>> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
>>> requirement for CMA and alloc_contig_range().
>>>
>>> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
>>> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
>>> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  include/linux/mmzone.h |  6 ++++++
>>>  mm/page_alloc.c        | 28 ++++++++++++++++++----------
>>>  2 files changed, 24 insertions(+), 10 deletions(-)
>>>
> 
> ...
> 
>>> @@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>>>  		struct page *endpage = page + (1 << order) - 1;
>>>  		for (; page < endpage; page += pageblock_nr_pages) {
>>>  			int mt = get_pageblock_migratetype(page);
>>> -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
>>> -			    && !is_migrate_highatomic(mt))
>>> +			/* Only change normal pageblock */
>>> +			if (migratetype_has_fallback(mt))
>>>  				set_pageblock_migratetype(page,
>>>  							  MIGRATE_MOVABLE);
>>>  		}
>>
>> That part is a nice cleanup IMHO. Although the "has fallback" part is a
>> bit imprecise. "migratetype_is_mergable()" might be a bit clearer.
>> ideally "migratetype_is_mergable_with_other_types()". Can we come up
>> with a nice name for that?
> 
> migratetype_is_mergable() kinda implies "_with_other_types", no?
> 
> I like migratetype_is_mergable() more than _has_fallback().
> 
> My $0.02 to bikeshedding :)

:)

Yeah, for me migratetype_is_mergable() would also be good enough. I
think I was at first thinking one could mistake it with a dedicated
migratetype. But such functions are historically called

is_migrate_cma/is_migrate_cma/....

-- 
Thanks,

David / dhildenb

