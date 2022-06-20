Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB18550EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiFTDY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFTDY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:24:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C9635A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655695465; x=1687231465;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=D9XE01XwM+TilxJWOF9FdLepcJrbW+dWDW1WZgjV+/E=;
  b=ZMkz37I2daj2GxW15a/N+GzUI7WOQkuLcuc1ct2RtvGp2nzko0GifJV1
   EWEQN6nNnXoFRDq6lElZEiSBBvM+O33Lt6i+HDZJun7rIRA4NhWDZR3NE
   kxS0kBA2AZrb2TnCKXlcLC6cD1CuL0cBVZkA8buJO6H463+yHdC9biOAd
   cmDM2boYsuILMgY8AHhf7AgJJYdmAmVUb1zaLdF3t4ZhqUIQbooZbhvFF
   p6SNEw97bH5+zGuGMnH/SVkrHeWv4YAyBlK2gHaKW+gA8sILWktzHrDje
   J6tY32pA3Datt7hPj8xLVRmrswee39gOZIayl1vNcHd0EsbPxWUl2MbED
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260221745"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260221745"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 20:24:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="729180271"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 20:24:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        "Zhong Jiang" <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V3 0/3] memory tiering: hot page selection
References: <20220614081635.194014-1-ying.huang@intel.com>
        <872bdaee-21a0-005b-b66c-893eb331e39a@linux.alibaba.com>
Date:   Mon, 20 Jun 2022 11:24:17 +0800
In-Reply-To: <872bdaee-21a0-005b-b66c-893eb331e39a@linux.alibaba.com> (Baolin
        Wang's message of "Mon, 20 Jun 2022 11:19:23 +0800")
Message-ID: <87czf4rp9a.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 6/14/2022 4:16 PM, Huang Ying wrote:
>> To optimize page placement in a memory tiering system with NUMA
>> balancing, the hot pages in the slow memory nodes need to be
>> identified.  Essentially, the original NUMA balancing implementation
>> selects the mostly recently accessed (MRU) pages to promote.  But this
>> isn't a perfect algorithm to identify the hot pages.  Because the
>> pages with quite low access frequency may be accessed eventually given
>> the NUMA balancing page table scanning period could be quite long
>> (e.g. 60 seconds).  So in this patchset, we implement a new hot page
>> identification algorithm based on the latency between NUMA balancing
>> page table scanning and hint page fault.  Which is a kind of mostly
>> frequently accessed (MFU) algorithm.
>> In NUMA balancing memory tiering mode, if there are hot pages in
>> slow
>> memory node and cold pages in fast memory node, we need to
>> promote/demote hot/cold pages between the fast and cold memory nodes.
>> A choice is to promote/demote as fast as possible.  But the CPU
>> cycles
>> and memory bandwidth consumed by the high promoting/demoting
>> throughput will hurt the latency of some workload because of accessing
>> inflating and slow memory bandwidth contention.
>> A way to resolve this issue is to restrict the max
>> promoting/demoting
>> throughput.  It will take longer to finish the promoting/demoting.
>> But the workload latency will be better.  This is implemented in this
>> patchset as the page promotion rate limit mechanism.
>> The promotion hot threshold is workload and system configuration
>> dependent.  So in this patchset, a method to adjust the hot threshold
>> automatically is implemented.  The basic idea is to control the number
>> of the candidate promotion pages to match the promotion rate limit.
>> We used the pmbench memory accessing benchmark tested the patchset
>> on
>> a 2-socket server system with DRAM and PMEM installed.  The test
>> results are as follows,
>> 		pmbench score		promote rate
>> 		 (accesses/s)			MB/s
>> 		-------------		------------
>> base		  146887704.1		       725.6
>> hot selection     165695601.2		       544.0
>> rate limit	  162814569.8		       165.2
>> auto adjustment	  170495294.0                  136.9
>>  From the results above,
>> With hot page selection patch [1/3], the pmbench score increases
>> about
>> 12.8%, and promote rate (overhead) decreases about 25.0%, compared with
>> base kernel.
>> With rate limit patch [2/3], pmbench score decreases about 1.7%, and
>> promote rate decreases about 69.6%, compared with hot page selection
>> patch.
>> With threshold auto adjustment patch [3/3], pmbench score increases
>> about 4.7%, and promote rate decrease about 17.1%, compared with rate
>> limit patch.
>
> I did a simple testing with mysql on my machine which contains 1 DRAM
> node (30G) and 1 PMEM node (126G).
>
> sysbench /usr/share/sysbench/oltp_read_write.lua \
> ......
> --tables=200 \
> --table-size=1000000 \
> --report-interval=10 \
> --threads=16 \
> --time=120
>
> The tps can be improved about 5% from below data, and I think this is
> a good start to optimize the promotion. So for this series, please
> feel free to add:
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> Without this patchset:
>  transactions:                        2080188 (3466.48 per sec.)
>
> With this patch set:
>  transactions:                        2174296 (3623.40 per sec.)

Thanks a lot!

Best Regards,
Huang, Ying
