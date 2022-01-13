Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DEA48DB05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiAMPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231585AbiAMPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642089041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0RQ3puUcYuHO/5UfsU4Xhhp2Gu/t2oxOAbK9fU144eE=;
        b=RwcpVaOQpoP3+Jj5f1l3w6B8jXiSIQ40wz45tKZzM54sRhUJyTkeYAENGk7VoN7J0yQnwq
        Rf7o4qiSSmFyQd2XwCKgivDua/xvusrPRcoYdu2yFKgYHuZSMsx7vyKYWlBUWmi2Pp7qax
        GejVf5xk6yZ70cHIDzqdmSENEPQ84e0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-XJJuOZR5NqOroUYvac_F4A-1; Thu, 13 Jan 2022 10:50:40 -0500
X-MC-Unique: XJJuOZR5NqOroUYvac_F4A-1
Received: by mail-ed1-f69.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso5696804edd.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0RQ3puUcYuHO/5UfsU4Xhhp2Gu/t2oxOAbK9fU144eE=;
        b=rBKLMF5xVtF7UE1fVkxwEXCZYWG36jYG74rQ7D6uaPrqgWYjw4blpc44XNnV+GfvgJ
         vQV8xRXNSHKpxv0qB27et4s5Njx/MOBNtHmwTjHYLokKiKwH5AQI1dhIGxs70j8iRF6n
         bLae/Sk6UqgE1WoF7gGmJTX7KYTk1Xy3+QpcmsgksxLgN0FaJSYO76B0H1r/tkkpraMU
         KjWZFT54Hj5GNlEVwCMgFi/FGMaXPZyQQ7h+7Bn3eY6fbjCqbgiXPVx+yjGhAxCxCAVk
         qdT4QAshygQtTtPWddPWdnoCyw9dNXSDpNIrKUHIr/PaB9hHiqdgo1/OLl5ArRFW0kwj
         Xg8w==
X-Gm-Message-State: AOAM533Ta18KWwQ3gJv3pgBRdqHgLD8vZ+rO63yB7IopfvE6KrAfeUqP
        nDhF2vUON+sXCfcKycVYP7K6hSar6kep1F4TkoEHyj7YBidmZJjqbDioGY1eFIvAwVdH9xvTG5r
        mauypU0w8aElejgIt9jBRq8RB
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr4824683edc.147.1642089039283;
        Thu, 13 Jan 2022 07:50:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNFlqW+90z8MqJGfmQJtPI4aVOG3CgxuC8pcaaa86GGnEzwNl0A4gvDtrNM26vya8mfn/rVA==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr4824671edc.147.1642089039121;
        Thu, 13 Jan 2022 07:50:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id qw4sm1026745ejc.55.2022.01.13.07.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 07:50:38 -0800 (PST)
Message-ID: <5da2e9ae-24bc-a146-053d-a43063bad73e@redhat.com>
Date:   Thu, 13 Jan 2022 16:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
 <20220105214756.91065-4-zi.yan@sent.com>
 <970ca2a4-416d-7e8f-37c7-510c5b050f4b@redhat.com>
 <15E26B9B-8AE2-4916-94E7-D0BBB2491B1B@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <15E26B9B-8AE2-4916-94E7-D0BBB2491B1B@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 16:46, Zi Yan wrote:
> On 12 Jan 2022, at 6:04, David Hildenbrand wrote:
> 
>> On 05.01.22 22:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> alloc_migration_target() is used by alloc_contig_range() and non-LRU
>>> movable compound pages can be migrated. Current code does not allocate the
>>> right page size for such pages. Check THP precisely using
>>> is_transparent_huge() and add allocation support for non-LRU compound
>>> pages.
>>
>> IIRC, we don't have any non-lru migratable pages that are coumpound
>> pages. Read: not used and not supported :)
> 
> OK, but nothing prevents one writing a driver that allocates compound
> pages and provides address_space->migratepage() and address_space->isolate_page().
> 
> Actually, to test this series, I write a kernel module that allocates
> an order-10 page, gives it a fake address_space with migratepage() and
> isolate_page(), __SetPageMovable() on it, then call alloc_contig_range()
> on the page range. Apparently, my kernel module is not supported by
> the kernel, thus, I added this patch.
> 
> Do you have an alternative test to my kernel module, so that I do not
> even need this patch myself?
> 
>> Why is this required in the context of this series?
> 
> It might not be required. I will drop it.

That's why I think it would be best dropping it. If you need it in
different context, better submit it in different context.

Makes this series easier to digest :)


-- 
Thanks,

David / dhildenb

