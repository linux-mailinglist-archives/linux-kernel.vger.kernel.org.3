Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F011A4C8436
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiCAGlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiCAGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:41:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A710473BE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646116851; x=1677652851;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=sTdaEj+CJ6VXmMzCvIX4ApOCddLE+v7WPcrPQ46FEzc=;
  b=YsMFbH+R8hAYno7+1UqXoH55rs+GrbRh8VvYxaAr/V3Ol6DmIBEj1UwO
   t5tICV3X4/7LS/+ug3kWmEVog4i+FAfRyMCc2AUhd8VXEuLN2z8TpHtMj
   2H6CYf0V0TgBf9t5PQMF5NY2frMCBLNCzRn9P9xSOJMjDJm1zu7jJHFgE
   kkUXndWmNS9x4TDpMDY3eOY2kiwfNU2+U3gKozvTOB1W4by4B1B7EJD4H
   gGzEe/NpiELv3pX6cRHl4zWEKxzG9llz6CHoroD5sWhqCaL+P3qVYBo/T
   AlAomVp2qAixjhDcCsfpNh+8rb/iAr5q16xAecMHBWVqaJQdCuMebgtyX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251902101"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251902101"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:40:51 -0800
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="510400803"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:40:46 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
References: <20220221084529.1052339-1-ying.huang@intel.com>
        <20220221084529.1052339-3-ying.huang@intel.com>
        <YhzwO/lw1xx7EjNb@localhost.localdomain>
        <87czj6321p.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yh26v+4LtnvFnWWz@localhost.localdomain>
Date:   Tue, 01 Mar 2022 14:40:44 +0800
In-Reply-To: <Yh26v+4LtnvFnWWz@localhost.localdomain> (Oscar Salvador's
        message of "Tue, 1 Mar 2022 07:18:39 +0100")
Message-ID: <878rtu2n0z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, Mar 01, 2022 at 09:16:18AM +0800, Huang, Ying wrote:
>> Hi, Oscar,
>
> Hi Huang Ying
>
>>  b. Make kswapd of the fast memory node to reclaim pages until the free
>>     pages are a little more than the high watermark (named as promo
>>     watermark).  If we want to promote some hot pages from the slow
>>     memory to the fast memory, but the free pages of the fast memory
>>     node will become lower than the high watermark after promotion, we
>>     will wake up kswapd of the fast memory node to demote more cold
>>     pages in the fast memory node to the slow memory node firstly.  This
>>     will free some extra space in the fast memory node, so the hot pages
>>     in the slow memory node can be promoted to the fast memory node.
>
> What about this? Somehow it sounds clear to me.
>
> "b. Define a new watermark called wmark_promo which is higher than wmark_high,
>     and have kswapd reclaiming pages until free pages reach such watermark.
>     The scenario is as follows: when we want to promote hot-pages from a slow
>     memory to a fast memory, but fast memory's free pages would go lower than
>     high watermark with such promotion, we wake up kswapd with wmark_promo
>     watermark in order to demote cold pages and free us up some space.
>     So, next time we want to promote hot-pages we might have a chance of
>     doing so."

Your version looks better.  I will use it.  Thanks!

> But I am fine with your updated write up as well, so if you spin a new
> version:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

Best Regards,
Huang, Ying
