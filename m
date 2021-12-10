Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50ECA46FC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhLJH5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhLJH5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:57:31 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC0BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 23:53:53 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 8so7777215pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 23:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=ijVBfG1KG/aW/R5+/Gi9cb70eNCVtOkQHVClSlu2XwQ=;
        b=f9zXHqflj7w8rm18C9SRhCSZ0h8uljnpXHk4Vjg37Ib9U6eihTWF8OGGbBbjwovGIt
         WdIAiNb9SNj9vX3/WkE92YG6UOQugvY0wWCTFxfzKL15NKrL4ZQ0uOJvhbWqYEwCfDb+
         G8NUmHY1ychu8qM/0vvRjYBeLSJ92mS9HJ+K6eFJUgLaoCZeHFNNzpVRLU20oxHAz7oL
         6XRb0fJAxHVDdAaUw2xEE3YbeilVIptXXXfmGnzvQKXqOs4PEgYz5Y26V3rag1Fz5q70
         NwCHGKIS6EwduXaYhhahvciWp9RERZCsFd5bJ93Wmf7yqZ3CPDLzKlK7t5ozokyrtfAg
         Jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ijVBfG1KG/aW/R5+/Gi9cb70eNCVtOkQHVClSlu2XwQ=;
        b=6c/eW4fORTEbRqPnhUg5lJaxVagyaz8mVii3b4J/iyxXEaWMDZlbeeiGqJ9eJ0crXb
         eLQZvyrHC01yOCT3F5U4Rkswy9trMg9kJOGbCbbN4b+RjhC7smEDBIEBjaRglGIQlfFP
         dfPvT5XfDy3ghTIHjCpKN0usaFxRiQi+nhU7cN1Wpgt0RFTa7Frg0sTxYIV9Sx7MaVuk
         /oSGtWTQL8PQ34ztKAIXMiY3UcP752L/YVaM0LXW5Jwiv1jTn56xzIFlz6OvqJg2VBWQ
         yHNVMlLw0WPU3DXyyxkTrBKfbbx4ZjvGXfJbbx5k34txj2vWD+APbBCeAK5Eua+I/xzI
         OCLw==
X-Gm-Message-State: AOAM533KUHJNEcZcuQ3fUYrhPtb0c2GQNCYGC669xmYt7YXIZAnvXjai
        DJK+CqUf98+/ooxHiTHuPb0=
X-Google-Smtp-Source: ABdhPJwiYQdsfZBv/0L8jEVNhWHsAYR27PUBucnpzzQOeWrnW8MMFcsmzH8CePs6w6mAE1aeqGTsGw==
X-Received: by 2002:a65:5c82:: with SMTP id a2mr39036759pgt.370.1639122833431;
        Thu, 09 Dec 2021 23:53:53 -0800 (PST)
Received: from [30.240.98.4] ([205.204.117.108])
        by smtp.gmail.com with ESMTPSA id bt2sm1733596pjb.57.2021.12.09.23.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 23:53:52 -0800 (PST)
Message-ID: <84807a03-f7d1-83cb-16df-bacc58de4529@gmail.com>
Date:   Fri, 10 Dec 2021 15:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v2 3/7] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
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
 <20211209230414.2766515-4-zi.yan@sent.com>
From:   Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211209230414.2766515-4-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/12/10 07:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
>
> alloc_migration_target() is used by alloc_contig_range() and non-LRU
> movable compound pages can be migrated. Current code does not allocate the
> right page size for such pages. Check THP precisely using
> is_transparent_huge() and add allocation support for non-LRU compound
> pages.
Could you elaborate on why the current code doesn't get the right size?  
how this patch fixes it.

The description sounds like it's an existing bug, if so, the patch 
subject should be changed to
"Fixes ..."?

>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d487a399253b..2ce3c771b1de 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1563,7 +1563,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>   		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
>   	}
>   
> -	if (PageTransHuge(page)) {
> +	if (is_transparent_hugepage(page)) {
>   		/*
>   		 * clear __GFP_RECLAIM to make the migration callback
>   		 * consistent with regular THP allocations.
> @@ -1572,13 +1572,17 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
if (PageTransHuge(page)) {  // just give more code context
...
>   		gfp_mask |= GFP_TRANSHUGE;
>   		order = HPAGE_PMD_ORDER;
order assigned here
>   	}
> +	if (PageCompound(page)) {
> +		gfp_mask |= __GFP_COMP;
> +		order = compound_order(page);
re-assinged again as THP is a compound page?

Thanks,
Eric
> +	}
>   	zidx = zone_idx(page_zone(page));
>   	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
>   		gfp_mask |= __GFP_HIGHMEM;
>   
>   	new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
>   
> -	if (new_page && PageTransHuge(new_page))
> +	if (new_page && is_transparent_hugepage(page))
>   		prep_transhuge_page(new_page);
>   
>   	return new_page;

