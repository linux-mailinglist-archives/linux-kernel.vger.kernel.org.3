Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADF4B836C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiBPIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:53:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiBPIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:53:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9473F77A8E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645001585; x=1676537585;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DvOAqye5C0k2L5I3hLstqAifXcVguIoWg4AYW46eqa4=;
  b=W3JuGwU8zJI5MxYJqNdbCDiPX60pWXcQZEWYx9rrffeg4u5fWp09alQY
   hhqJzwUvE+PlOK/2t115s5bauxO45iET3gakkedj1Gf+WM6pscrFE5uJz
   sMM0v2xEledtqt/HhsLcyDOdZiU0ic4dR7UXX1bVcxAQ6hEeJya1D/ejC
   rF3JzRYrrlJbn4B/t03OjJOLLlkcLaL6O5oPBwNNvoF7dQDTu/hGjjOrX
   Msz/ZNVjUb41Hp6DTYVS1WzeWOsp5AzWBoFiTPdzc+Cys4wJcpLuyMkzK
   zoO4jKTbAI0PMpnGzQJYqzZo5VCz5F+j9xdh8gKHH0lG197sSjMsoS9iQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248153095"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="248153095"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:53:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="544811272"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:53:00 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V12 1/3] NUMA Balancing: add page promotion counter
References: <20220216073815.2505536-1-ying.huang@intel.com>
        <20220216073815.2505536-2-ying.huang@intel.com>
        <Ygy6fg/KOTikCgLW@localhost.localdomain>
Date:   Wed, 16 Feb 2022 16:52:59 +0800
In-Reply-To: <Ygy6fg/KOTikCgLW@localhost.localdomain> (Oscar Salvador's
        message of "Wed, 16 Feb 2022 09:49:02 +0100")
Message-ID: <87sfsj9or8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Wed, Feb 16, 2022 at 03:38:13PM +0800, Huang Ying wrote:
>> In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
>> and DRAM in one socket will be put in one NUMA node as before, while
>> the PMEM will be put in another NUMA node as described in the
>> description of the commit c221c0b0308f ("device-dax: "Hotplug"
>> persistent memory for use like normal RAM").  So, the NUMA balancing
>> mechanism will identify all PMEM accesses as remote access and try to
>> promote the PMEM pages to DRAM.
>> 
>> To distinguish the number of the inter-type promoted pages from that
>> of the inter-socket migrated pages.  A new vmstat count is added.  The
>> counter is per-node (count in the target node).  So this can be used
>> to identify promotion imbalance among the NUMA nodes.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: osalvador <osalvador@suse.de>
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> ---
> ...
>
>> @@ -2072,6 +2072,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>  	pg_data_t *pgdat = NODE_DATA(node);
>>  	int isolated;
>>  	int nr_remaining;
>> +	int nr_succeeded;
>
> I think we should make this consistent and make it "unsigned int".
> That is what migrate_pages() expects, and what the other caller using
> nr_succeeded (demote_page_list()) already uses.
> Unless there is a strong reason not to do so.

Yes.  Will do that in the next version.

> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

Best Regards,
Huang, Ying
