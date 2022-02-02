Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40214A70B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbiBBMZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232638AbiBBMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643804732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Riry/Ie+x1sinW7wNxc+GkihNaf8lfeZqesrgvEVnb0=;
        b=dlqaYtvc2xTYWwZ+3y4jfY0FVRa8u3sny5EPVuwyN8eim1Z9URElNx7aCnx75u49gXIGxm
        y+X3cjBNXUxQF5FPppWSw5esxaCBG2Nu9U32ZNyCS0oGhGJ2QPepisJPfWZKZ6k+b9ykyC
        VwI1r+0ZAVZctCUWJxqUAbNvu/5RY0Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-MaAOzQIyN52JCqc01KDquA-1; Wed, 02 Feb 2022 07:25:31 -0500
X-MC-Unique: MaAOzQIyN52JCqc01KDquA-1
Received: by mail-ej1-f71.google.com with SMTP id fx12-20020a170906b74c00b006bbeab42f06so4425973ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 04:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Riry/Ie+x1sinW7wNxc+GkihNaf8lfeZqesrgvEVnb0=;
        b=0jsOS+0vRNb5K8y24Jp1izEi2ULty1nQ7jhfnEu+Fumzx7VQyCW7+4u7nv/dt2pUDZ
         tdhIFMfotSch4ex30tUSk4jXKAG0uIiyKoKbbzRsdXXkN//S7eACUAoh5cOgjJ739Xg9
         /5oOzVPli4tg+PrTZE/kQxg3xQ6zR83Tp/llh4De1BbeFwl9pRP3gtUABGK96YYo8MlR
         oVKn0Ms2pUmt3faAJ0NytUGIK67/PgyeVLZtVxCmoxlikusQIuMlNSWLH5uOVsA7V3qY
         g4DWf8zCpF+yo5r0Hf2KedzQpepkbt8g+Ku/Ns/liUyqr7CzxeqUxdpiSGwuSZGLI8+3
         U79w==
X-Gm-Message-State: AOAM532Pnujfvr7SokPUKaHJEGqEo/F6jRAraUvTS7Ehp6U9arhCQbnt
        EIoMLI0Qg3/SvQ9qEgVG+b12bUGjM3ED9AIS6T8PoGEgWpUwx/BwPzAxuQIXZQ4fGFlgu+TgMEn
        J5xkgTRn67ZCg5Oot8g4lk5cf
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr30060270edy.9.1643804730535;
        Wed, 02 Feb 2022 04:25:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgTNVg4PsKEjgBZhYvXrFMFKGRSAUL0S3jbEcFB9ylZ3e4FOsTEFQdbkPIWl6zZX7rsjy0bA==
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr30060236edy.9.1643804730176;
        Wed, 02 Feb 2022 04:25:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:f800:a55c:e484:3cd9:3632? (p200300cbc709f800a55ce4843cd93632.dip0.t-ipconnect.de. [2003:cb:c709:f800:a55c:e484:3cd9:3632])
        by smtp.gmail.com with ESMTPSA id f6sm20889436edy.18.2022.02.02.04.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 04:25:29 -0800 (PST)
Message-ID: <21c196f8-18ca-d720-4241-00c9461854d3@redhat.com>
Date:   Wed, 2 Feb 2022 13:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
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
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
 <Yfp2rv0K6d3cNmwg@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <Yfp2rv0K6d3cNmwg@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 13:18, Oscar Salvador wrote:
> On Wed, Jan 19, 2022 at 02:06:19PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Enable set_migratetype_isolate() to check specified sub-range for
>> unmovable pages during isolation. Page isolation is done
>> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
>> pages within that granularity are intended to be isolated. For example,
>> alloc_contig_range(), which uses page isolation, allows ranges without
>> alignment. This commit makes unmovable page check only look for
>> interesting pages, so that page isolation can succeed for any
>> non-overlapping ranges.
> 
> Another thing that came to my mind.
> Prior to this patch, has_unmovable_pages() was checking on pageblock
> granularity, starting at pfn#0 of the pageblock.
> With this patch, you no longer check on pageblock granularity, which
> means you might isolate a pageblock, but some pages that sneaked in
> might actually be unmovable.
> 
> E.g:
> 
> Let's say you have a pageblock that spans (pfn#512,pfn#1024),
> and you pass alloc_contig_range() (pfn#514,pfn#1024).
> has_unmovable_pages() will start checking the pageblock at pfn#514,
> and so it will mis pfn#512 and pfn#513. Isn't that a problem, if those
> pfn turn out to be actually unmovable?

That's the whole idea for being able to allocate parts of an unmovable
pageblock that are movable.

If the first part is unmovable but the second part is movable, nothing
should stop us from trying to allocate the second part.

Of course, we want to remember the original migratetype of the
pageblock, to restore that after isolation -- otherwise we'll end up
converting all such pageblocks to MIGRATE_MOVABLE. The next patch does
that IIRC.

However, devil is in the detail, and I still have to review those parts
of this series.


Note that there are no current users of alloc_contig_range() that
allocate < MAX_ORDER - 1 -- except CMA, but for CMA we immediately exit
has_unmovable_pages() either way.

-- 
Thanks,

David / dhildenb

