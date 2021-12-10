Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81C4708F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbhLJSkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:40:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242116AbhLJSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639161392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuZMXUxnRYoJ6fczszwwZGhWUdbXILWisTJH5f1GF3o=;
        b=h6NhXiAshx8h8AMhcEyh3d83NUqUTc3SmcpEn9D/1fotKZTJDAhrUEBFZcmGXn6gJtY7jh
        4VQ4adoG4pSeupPe7G/RAT8PRGQgHnzvhDOqQIjGMkSPxM30LQTBlDb7kUrbJpVjbvmEa5
        1cTohojE+8jZ45ix+/DCBS4+vG0nGNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-2OpAyktJNyWl9QYUxWXcnw-1; Fri, 10 Dec 2021 13:36:31 -0500
X-MC-Unique: 2OpAyktJNyWl9QYUxWXcnw-1
Received: by mail-wm1-f72.google.com with SMTP id j23-20020a05600c1c1700b0033283ea5facso1417001wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=UuZMXUxnRYoJ6fczszwwZGhWUdbXILWisTJH5f1GF3o=;
        b=FZPKB4N5l5b3ZSovHTTVqiins5/dVX+CNKWNJ8RbuQU0ztnRy1jiXVxSDs3GtGFTD+
         mkM5VtNh1X6a6BcxILGB0irvPnaKNs7nk+8lzmzkDk3cvyDLDXFdGSbWhj5D+jJl0VGI
         PK6Hmm/2wo9nFbT/l6yrDPGxB8fGYXPTTKzOyL96YrfNimsWzVHyze7gvl4LTogbNhoh
         Pf0lxgb0iKDmD+sWiNKSiPmSvSnvo+XOT7UNs1304Rba/D+XdN4Ck905fdhv8ug/L33o
         Tc+6Jtq7ToHQ/tc+eJQ9Wlnu0mn9qb/PJafmjEbg/7YhSs+9H3wJG1YTI/kc5guwte5b
         Os2g==
X-Gm-Message-State: AOAM532zf7BLTiyZvAWgVc1/yww2vjUR19RwQpdcAPCDDegsXPCMfCRZ
        yG2ZqqZLOeuvcTplNco0ubk3nFGqaVYXystj+weW3L7G77QnpT09xrPn5C7+C0GKPoKTPHhOmoJ
        7HV06c5H/wEIPFszMovmF3e3c
X-Received: by 2002:a1c:2397:: with SMTP id j145mr18630562wmj.113.1639161389938;
        Fri, 10 Dec 2021 10:36:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnE6mECpT6/x+6acEXXbzAagez4dMgCo4uhwD9w2DwYFQ/4FPaugRFXQx4gh8a1gwW+xf9tQ==
X-Received: by 2002:a1c:2397:: with SMTP id j145mr18630532wmj.113.1639161389702;
        Fri, 10 Dec 2021 10:36:29 -0800 (PST)
Received: from [192.168.3.132] (p5b0c60f8.dip0.t-ipconnect.de. [91.12.96.248])
        by smtp.gmail.com with ESMTPSA id v8sm3098510wrd.84.2021.12.10.10.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:36:29 -0800 (PST)
Message-ID: <19404189-3bee-c02a-a596-2e5564e0f8f5@redhat.com>
Date:   Fri, 10 Dec 2021 19:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v2 0/7] Use pageblock_order for cma and
 alloc_contig_range alignment.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.21 00:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,

Hi,

thanks for working on that!

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
> 2. but saves the pageblock migratetypes outside the specified range of
>    alloc_contig_range() and restores them after all pages within the range
>    become free after __alloc_contig_migrate_range();
> 3. splits free pages spanning multiple pageblocks at the beginning and the end
>    of the range and puts the split pages to the right migratetype free lists
>    based on the pageblock migratetypes;
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
>    range during isolation to increase successful rate of alloc_contig_range().

The issue with virtio-mem is that we'll need that as soon as we change
the granularity to pageblocks, because otherwise, you can heavily
degrade unplug reliably in sane setups:

Previous:
* Try unplug free 4M range (2 pageblocks): succeeds

Now:
* Try unplug 2M range (first pageblock): succeeds.
* Try unplug next 2M range (second pageblock): fails because first
contains unmovable allcoations.

-- 
Thanks,

David / dhildenb

