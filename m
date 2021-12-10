Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4302246FB93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhLJHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbhLJHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:33:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C2C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 23:30:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u17so5690987plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 23:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=kqdwZyEU31KaNW+cOFp1dor6RRAOvhH6zrtcJuFenfA=;
        b=gqnhaZdO12ibnFTEUYTRcyNDsVi4fZjKWuF1d+1IX2QtK+zXEl/CleEzgCXcZCKWk4
         DeGXeYahXgF25toJDTBvItitvosjjzyrdtCOfzBPXJUv2sNA46FGCrVbWvzev5Gqa7Ak
         meZ3c5sCNkdjOENTF0nlgXWFhqmZAwIOkT71xtM4OT2BCJb5l3qSGmgij0kaSHc39jlT
         lz+NQj74lZEDNXhnwDnJm6MBPftfgIEvxzLs37o6722DhjM05TgsyYdxT05vxKbTRo5c
         paO1XE+hWA5qYswHrUze+qL1vRsNsy/KmrR7y+w/OwTPs4iJXL+3vAPXn7Z6f5NDhlEr
         bj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kqdwZyEU31KaNW+cOFp1dor6RRAOvhH6zrtcJuFenfA=;
        b=1ySWgSFWf84ELVLo962qv15ExN3oacj9ojHXRKqRNkEYrXTSrQC9wKo+BSYju9eF/U
         s+5QO9OM2beCGgV3H2V3mF+JCG9kLFlxewhUyNhPrK7GFZnKmZk9WpA6pTtDERlnaoYE
         R5YSMIeB45RXqm6Mxy18hpUWK8L3dDUUw7dVLIyvS0LnixPsTW0Fu3BzMoQpxpEAHhF3
         AISAGKQb28GZ4B0nhMu4mIPKlKK1yYObElyjKvvttvqdrPCOFLV5gaLw9bMfhs1LH6PB
         AwQtvmlNvu8W08nWYi7h3T+rJZsDa3h9RWFnhEqXCJBRgL+he/fRA4SDwgun8ZUialsZ
         IzQg==
X-Gm-Message-State: AOAM532SJ2t17rWa4Hp79S8n87x8hfzcq+TFhze7PW/Ajlb2pYShux3Q
        quy5ssC/cic/MwgO2TfEHrc=
X-Google-Smtp-Source: ABdhPJxRm9ttF7FhbBeprnb6+zsZD1lD+fI51oOUlTadE/AU/yNXP9DA3iOR8FWZWbadxSA9RFDXLw==
X-Received: by 2002:a17:902:f687:b0:141:cf6b:fee7 with SMTP id l7-20020a170902f68700b00141cf6bfee7mr71919578plg.75.1639121413466;
        Thu, 09 Dec 2021 23:30:13 -0800 (PST)
Received: from [30.240.98.4] ([205.204.117.108])
        by smtp.gmail.com with ESMTPSA id c17sm185764pfc.163.2021.12.09.23.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 23:30:13 -0800 (PST)
Message-ID: <07f11dfc-f491-3b08-a2cb-3c8f5a8102d3@gmail.com>
Date:   Fri, 10 Dec 2021 15:30:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v2 0/7] Use pageblock_order for cma and
 alloc_contig_range alignment.
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20211209230414.2766515-1-zi.yan@sent.com>
From:   Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zi Yan,

On 2021/12/10 07:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
>
> Hi all,
>
> This patchset tries to remove the MAX_ORDER - 1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make MAX_ORDER
> adjustable at boot time[1].
>
> The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
> isolates pageblocks to remove free memory from buddy allocator but isolating
> only a subset of pageblocks within a page spanning across multiple pageblocks
> causes free page accounting issues. Isolated page might not be put into the
> right free list, since the code assumes the migratetype of the first pageblock
> as the whole free page migratetype. This is based on the discussion at [2].
>
> To remove the requirement, this patchset:
> 1. still isolates pageblocks at MAX_ORDER - 1 granularity;
Then, unplug fails if either pageblock of the  MAX_ORDER - 1 page has 
unmovable page, right?

Thanks,
Eric
> 2. but saves the pageblock migratetypes outside the specified range of
>     alloc_contig_range() and restores them after all pages within the range
>     become free after __alloc_contig_migrate_range();
> 3. splits free pages spanning multiple pageblocks at the beginning and the end
>     of the range and puts the split pages to the right migratetype free lists
>     based on the pageblock migratetypes;
> 4. returns pages not in the range as it did before this patch.
>
> Isolation needs to happen at MAX_ORDER - 1 granularity, because otherwise
> 1) extra code is needed to detect pages (free, PageHuge, THP, or PageCompound)
> to make sure all pageblocks belonging to a single page are isolated together
> and later pageblocks outside the range need to have their migratetypes restored;
> or 2) extra logic will need to be added during page free time to split a free
> page with multi-migratetype pageblocks.
>
> Two optimizations might come later:
> 1. only check unmovable pages within the range instead of MAX_ORDER - 1 aligned
>     range during isolation to increase successful rate of alloc_contig_range().
> 2. make MIGRATE_ISOLATE a separate bit to avoid saving and restoring existing
>     migratetypes before and after isolation respectively.
>
> Feel free to give comments and suggestions. Thanks.
>
>
> [1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.com/
> [2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com/
>
>
> Zi Yan (7):
>    mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
>    mm: compaction: handle non-lru compound pages properly in
>      isolate_migratepages_block().
>    mm: migrate: allocate the right size of non hugetlb or THP compound
>      pages.
>    mm: make alloc_contig_range work at pageblock granularity
>    mm: cma: use pageblock_order as the single alignment
>    drivers: virtio_mem: use pageblock size as the minimum virtio_mem
>      size.
>    arch: powerpc: adjust fadump alignment to be pageblock aligned.
>
>   arch/powerpc/include/asm/fadump-internal.h |   4 +-
>   drivers/virtio/virtio_mem.c                |   6 +-
>   include/linux/mmzone.h                     |  11 +-
>   kernel/dma/contiguous.c                    |   2 +-
>   mm/cma.c                                   |   6 +-
>   mm/compaction.c                            |  10 +-
>   mm/migrate.c                               |   8 +-
>   mm/page_alloc.c                            | 203 +++++++++++++++++----
>   8 files changed, 196 insertions(+), 54 deletions(-)
>

