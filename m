Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1471449E3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbiA0Ngs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:36:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40738 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbiA0Nem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:34:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D647061BE3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF10C340E4;
        Thu, 27 Jan 2022 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643290481;
        bh=fd4J3Q09HA3HgoqBjZYSLSYqtMJ9HcItVk5HZwKUFBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSPjF8La1fKzn3JBxHgUq74VUI66bXY5zHZU4m8RrxbLYFUsE2i1D8UtQiE1y0w8w
         LzW/HL7tZqVS8oyvs7b/QYhVL4mAiq9DIDPEcb1eiP/7lDCvqGaLKmAlqUP9TR+Jvk
         BvuOKa4yOK/Iaf/sGMAD9uScehLzNnHG3oSOAbQoaMUIUcR375WMgZWS28ubHqE7U1
         vMUunrXFCT/P7LD2LwpuZTVs6xykNh9BT2Ro9ftBflO7J6lHtnoaptqOcBMhJVPlKf
         R9K/KOyJ5r4ATO1zf6GN0PnyPTmx7bUb2BUytu5QZ05avLo6KVcZPKdI1NitIyqX++
         CCHy1/GDVQmOw==
Date:   Thu, 27 Jan 2022 15:34:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 5/6] mm: make free_area_init_node aware of memory less
 nodes
Message-ID: <YfKfaIssEzcwnnY5@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-6-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-6-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:04AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> free_area_init_node is also called from memory less node initialization
> path (free_area_init_memoryless_node). It doesn't really make much sense
> to display the physical memory range for those nodes:
> Initmem setup node XX [mem 0x0000000000000000-0x0000000000000000]
> 
> Instead be explicit that the node is memoryless:
> Initmem setup node XX as memoryless
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/page_alloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 32d0189de4c5..83da2279be72 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7682,9 +7682,14 @@ static void __init free_area_init_node(int nid)
>  	pgdat->node_start_pfn = start_pfn;
>  	pgdat->per_cpu_nodestats = NULL;
>  
> -	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
> -		(u64)start_pfn << PAGE_SHIFT,
> -		end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
> +	if (start_pfn != end_pfn) {
> +		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
> +			(u64)start_pfn << PAGE_SHIFT,
> +			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
> +	} else {
> +		pr_info("Initmem setup node %d as memoryless\n", nid);
> +	}
> +
>  	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
>  
>  	alloc_node_mem_map(pgdat);
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
