Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E384AC805
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiBGRyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356214AbiBGRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:47:47 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566EC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:47:46 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t1so6550902qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27GTKwZvXFRmqS9GkN5roFakaQWvuz+6y70M4qYZNnc=;
        b=lJDNLRLLbe6sAse6oOlpIEGHU6dfZlHOzNGE6Desg78RWe6zpiem+zL71EYbbb3LXq
         Jj0ikIDphhIMCULt2cjCMMOnjacjH8Xw46ADkOlg7hCABDADRXdFSj4H4JBWqEeww8fm
         JIw7mdzbPDLFQlZ1L7/A8qWPb5wlGk+2MKHfYduh0DK2tpxYi6uYi/U58Rk2t6O5Q3hm
         uiTo3Q901+ZRwduVxryzGniGdDBGjJ4+RSLjRgjtl0FHLYr3D1chJiSU5aNhyXf/MAIp
         fdI2ti3VUhm6Rj2aB+UcdPfzPtwuNtJA32YfO4RjpYZLikxq9YikNjM5z3Zm6OS1TGAT
         nX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27GTKwZvXFRmqS9GkN5roFakaQWvuz+6y70M4qYZNnc=;
        b=S/dM+uoERCaufp0UuMxyrXJHYTEVUG8VBnpxXgJgSaBaGBGgFoYnIfKO+n2ynQ8+lH
         INiytpOO85h1+gkY8SWUTjz9Rz9ZnFzSmUjVjQOZlMRbYYpduZDmEMrimruiEN49PfpX
         dp451GDQ7mju1fujZPUp3EXW3NFAvz/5ltyGwC+SgqyQ6Sy1Hl7FdB9YzUv1xOzMan/B
         FdOgGaJVZ1yCNUSEM6A1IUqTwNB5PjaMcaIINbi9opCTI5Px+6xPjxLn1KYVlBmi5mVp
         +7eSvneJQb7jz78cTptTim2uKIP6drArn7Xl23uXi60poxc7p25hzyzu+T6HcXL/wiym
         k+uA==
X-Gm-Message-State: AOAM530rXRhh5RhVjOxUnzmuXcdcqW2aCOmLe5mz89+Qmc/0xxzQVPOg
        7P0ky0ZVyytqMgqtDil+H1eEsQ==
X-Google-Smtp-Source: ABdhPJwgTEyO/1UNbMjbo1aWKUumLs81YdqPwdtNCfrW8xM+xa2WTA0yf/tx2Q1rQv3riIMXJABVMA==
X-Received: by 2002:a05:622a:11cb:: with SMTP id n11mr441881qtk.49.1644256065152;
        Mon, 07 Feb 2022 09:47:45 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f4sm5758878qko.72.2022.02.07.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:47:44 -0800 (PST)
Date:   Mon, 7 Feb 2022 12:47:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V11 2/3] NUMA balancing: optimize page placement for
 memory tiering system
Message-ID: <YgFbQFlZ+2rvS9Mm@cmpxchg.org>
References: <20220128082751.593478-1-ying.huang@intel.com>
 <20220128082751.593478-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128082751.593478-3-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

On Fri, Jan 28, 2022 at 04:27:50PM +0800, Huang Ying wrote:
> It's the common cases that the working-set size of the workload is
> larger than the size of the fast memory nodes.  Otherwise, it's
> unnecessary to use the slow memory at all.  So, there are almost
> always no enough free pages in the fast memory nodes, so that the
> globally hot pages in the slow memory node cannot be promoted to the
> fast memory node.  To solve the issue, we have 2 choices as follows,
> 
> a. Ignore the free pages watermark checking when promoting hot pages
>    from the slow memory node to the fast memory node.  This will
>    create some memory pressure in the fast memory node, thus trigger
>    the memory reclaiming.  So that, the cold pages in the fast memory
>    node will be demoted to the slow memory node.
> 
> b. Make kswapd of the fast memory node to reclaim pages until the
>    free pages are a little (for example, high_watermark / 4) more than
>    the high watermark.  Then, if the free pages of the fast memory
>    node reaches high watermark, and some hot pages need to be
>    promoted, kswapd of the fast memory node will be waken up to demote
>    more cold pages in the fast memory node to the slow memory node.
>    This will free some extra space in the fast memory node, so the hot
>    pages in the slow memory node can be promoted to the fast memory
>    node.
> 
> The choice "a" may create high memory pressure in the fast memory
> node.  If the memory pressure of the workload is high, the memory
> pressure may become so high that the memory allocation latency of the
> workload is influenced, e.g. the direct reclaiming may be triggered.
> 
> The choice "b" works much better at this aspect.  If the memory
> pressure of the workload is high, the hot pages promotion will stop
> earlier because its allocation watermark is higher than that of the
> normal memory allocation.  So in this patch, choice "b" is
> implemented.

I agree with that choice.

It's conceivable we'd eventually want a mix of both, where promotions
boost kswapd watermarks on-demand, such that no fast memory is wasted
if there are no references into slow memory. But that can be done when
it proves necessary, IMO.

> @@ -595,16 +595,23 @@ Documentation/admin-guide/kernel-parameters.rst).
>  numa_balancing
>  ==============
>  
> -Enables/disables automatic page fault based NUMA memory
> -balancing. Memory is moved automatically to nodes
> -that access it often.
> +Enables/disables and configure automatic page fault based NUMA memory
> +balancing.  Memory is moved automatically to nodes that access it
> +often.  The value to set can be the result to OR the following,
>  
> -Enables/disables automatic NUMA memory balancing. On NUMA machines, there
> -is a performance penalty if remote memory is accessed by a CPU. When this
> -feature is enabled the kernel samples what task thread is accessing memory
> -by periodically unmapping pages and later trapping a page fault. At the
> -time of the page fault, it is determined if the data being accessed should
> -be migrated to a local memory node.
> += =================================
> +0x0 NUMA_BALANCING_DISABLED
> +0x1 NUMA_BALANCING_NORMAL
> +0x2 NUMA_BALANCING_MEMORY_TIERING
> += =================================
> +
> +Or NUMA_BALANCING_NORMAL to optimize page placement among different
> +NUMA nodes to reduce remote accessing.  On NUMA machines, there is a
> +performance penalty if remote memory is accessed by a CPU. When this
> +feature is enabled the kernel samples what task thread is accessing
> +memory by periodically unmapping pages and later trapping a page
> +fault. At the time of the page fault, it is determined if the data
> +being accessed should be migrated to a local memory node.
>  
>  The unmapping of pages and trapping faults incur additional overhead that
>  ideally is offset by improved memory locality but there is no universal
> @@ -615,6 +622,10 @@ faults may be controlled by the `numa_balancing_scan_period_min_ms,
>  numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
>  numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
>  
> +Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
> +different types of memory (represented as different NUMA nodes) to
> +place the hot pages in the fast memory.  This is implemented based on
> +unmapping and page fault too.

NORMAL | TIERING appears to be a non-sensical combination.

Would it be better to have a tristate (disabled, normal, tiering)
rather than a mask?

> @@ -2034,16 +2035,30 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  {
>  	int page_lru;
>  	int nr_pages = thp_nr_pages(page);
> +	int order = compound_order(page);
>  
> -	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
> +	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>  
>  	/* Do not migrate THP mapped by multiple processes */
>  	if (PageTransHuge(page) && total_mapcount(page) > 1)
>  		return 0;
>  
>  	/* Avoid migrating to a node that is nearly full */
> -	if (!migrate_balanced_pgdat(pgdat, nr_pages))
> +	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> +		int z;
> +
> +		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +		    !numa_demotion_enabled)
> +			return 0;
> +		if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
> +			return 0;

The encoded behavior doesn't seem very user-friendly: Unless the user
enables numa demotion in a separate flag, enabling numa balancing in
tiered mode will silently do nothing.

Would it make more sense to have a central flag for the operation of
tiered memory systems that will enable both promotion and demotion?

Alternatively, it could also ignore the state of demotion and promote
anyway if asked to, resulting in regular reclaim to make room. It
might not be the most popular combination, but would be in line with
the zone_reclaim_mode policy of preferring reclaim over remote
accesses.  It would make the knobs behave more as expected and it's
less convoluted than having flags select other user-visible flags.

> @@ -3966,6 +3967,13 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
>  	return false;
>  }
>  
> +/*
> + * Keep the free pages on fast memory node a little more than the high
> + * watermark to accommodate the promoted pages.
> + */
> +#define NUMA_BALANCING_PROMOTE_WATERMARK_DIV	4
> +#define NUMA_BALANCING_PROMOTE_WATERMARK_MIN	(10UL * 1024 * 1024 >> PAGE_SHIFT)
> +
>  /*
>   * Returns true if there is an eligible zone balanced for the request order
>   * and highest_zoneidx
> @@ -3987,6 +3995,15 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>  			continue;
>  
>  		mark = high_wmark_pages(zone);
> +		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +		    numa_demotion_enabled &&
> +		    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE) {
> +			unsigned long promote_mark;
> +
> +			promote_mark = max(NUMA_BALANCING_PROMOTE_WATERMARK_MIN,
> +				mark / NUMA_BALANCING_PROMOTE_WATERMARK_DIV);
> +			mark += promote_mark;
> +		}

I'm not sure about this formula.

The high watermark straddles both the atomic allocation pool
(min_free_kbytes) as well as the direct reclaim latency buffer
(watermark_scale_factor) on top of it. Making the promotion buffer a
quarter of the raw total number conflates the two settings.

E.g. if the user grows the atomic pool to support bursty network rx,
the two direct reclaim buffers between min, low and high stay the
same, but the tier-promotion buffer grows. This is unexpected, and not
what the user intended.

I'm thinking it would be better to do this:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c417bec8207..5e067d66f797 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8573,7 +8573,8 @@ static void __setup_per_zone_wmarks(void)
 
 		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
-		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
+		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
+		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
 
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}

and then have kswapd choose between the high and promo watermarks
depending on the numa balancing mode.

On my 32G desktop with default settings this produces the same
ballpark of values as your code - high/4=7424, tmp=7311.

This would behave more intuitively with the existing watermark tuning
knobs, and I think would make the code overall simpler as well.
