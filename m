Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915CF4A816B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347819AbiBCJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:27:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59382 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBCJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:27:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 890311F3A8;
        Thu,  3 Feb 2022 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643880432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYpOSBzqXoi3ylme2YRtCDn1ikPZUYmP1IMgv5zMfBQ=;
        b=mSXA2svOe7ddYNz4iRKiBGqV99nGOOaf/5o6RsBRYvSyqPoiLiCetie4I93Iz0+TeDyCkc
        vso2vIHz/LqQPPx71qFDKZlK0P5LYplTv7WB88HImDadR4j+YPoi0b/SznVUqI+K/F+tr8
        DqUJW6PMV6pfbObEY04r4lRvePrKrZ8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3C72A3B84;
        Thu,  3 Feb 2022 09:27:11 +0000 (UTC)
Date:   Thu, 3 Feb 2022 10:27:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/page_alloc: add zone to zonelist if populated
Message-ID: <Yfuf759naxpCeSx2@dhcp22.suse.cz>
References: <20220203020022.3044-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203020022.3044-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-02-22 02:00:22, Wei Yang wrote:
> During memory hotplug, when online/offline a zone, we need to rebuild
> the zonelist for all nodes. Current behavior would lose a valid zone in
> zonelist since only pick up managed_zone.
> 
> There are two cases for a zone with memory but still !managed.
> 
>   * all pages were allocated via memblock
>   * all pages were taken by ballooning / virtio-mem
> 
> This state maybe temporary, since both of them may release some memory.
> Then it end up with a managed zone not in zonelist.
> 
> This is introduced in 'commit 6aa303defb74 ("mm, vmscan: only allocate
> and reclaim from zones with pages managed by the buddy allocator")'.
> This patch restore the behavior.

It has been introduced to fix a problem described in the the changelog
(FADUMP configuration making kswapd hogging a cpu). You are not
explaining why the original issue is not possible after this change.

I also think that this is more of theoretical issue than anything that
is a real life concern. It is good to state that in the changelog as
well.

That being said I am not against the change but the changelog needs more
explanation before I can ack it.

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: David Hildenbrand <david@redhat.com>
> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")

Fixes tag should be really used only if the referenced commit breaks
something. I do not really see this to be the case here.

Thanks!

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index de15021a2887..b433a57ee76f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6092,7 +6092,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
>  	do {
>  		zone_type--;
>  		zone = pgdat->node_zones + zone_type;
> -		if (managed_zone(zone)) {
> +		if (populated_zone(zone)) {
>  			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
>  			check_highest_zone(zone_type);
>  		}
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
