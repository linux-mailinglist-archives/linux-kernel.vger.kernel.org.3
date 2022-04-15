Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDF50209D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348747AbiDOCpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiDOCpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:45:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD57A0BFF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649990572; x=1681526572;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+Y236hBP7nkfnh2vn34A03RyhdinQO05q3FqW+lPwk=;
  b=PujQ85iFEy6qXd9lX7cHy+KP+N51c9a73e79yGKH8IfBwhG9vnhwGCvz
   WZN0kVCAybVYWRLRtoWwaVGJHbXrGS85z1agb26x/9ExQvOpEe2Z57J1m
   FWlaplSkAV/PN5fVWfiYfgwp7jcd3t+ig8yKdSM4sTFgGRlDWAPilYz4m
   Jw+3cNZA2ZZmkXr4/QFcNGuP8CKS1eopyYhlz7A37x7Da+HejFa6yq0Zn
   VCRsAYEcgRREx5egwlTPeefVpDRFvCUYSktIBzQFq+Moned+Gv18kouUY
   u5H7xsntsJfXQx+270oMVBXetQ9ioG6wz/97q4Dsr/SUX8WIpplYpTUz9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="323523106"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="323523106"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:42:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="527646181"
Received: from ruiqifu-mobl.ccr.corp.intel.com ([10.254.213.123])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:42:34 -0700
Message-ID: <bf23f05830db51bab3b06bac6e54d4743d37e955.camel@intel.com>
Subject: Re: [PATCH 1/3] memory tiering: hot page selection with hint page
 fault latency
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Date:   Fri, 15 Apr 2022 10:42:31 +0800
In-Reply-To: <YlggP5Tub19gjF4g@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220408071222.219689-1-ying.huang@intel.com>
         <20220408071222.219689-2-ying.huang@intel.com>
         <YlggP5Tub19gjF4g@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jagdish,

On Thu, 2022-04-14 at 18:53 +0530, Jagdish Gediya wrote:
> On Fri, Apr 08, 2022 at 03:12:20PM +0800, Huang Ying wrote:
[snip]
> > +
> > +static int numa_hint_fault_latency(struct page *page)
> > +{
> > +	int last_time, time;
> > +
> > +	time = jiffies_to_msecs(jiffies);
> > +	last_time = xchg_page_access_time(page, time);
> > +
> > +	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
> 
> This code can possibly consider cold page as hot,
> 
> Assume,
> 
> LAST_CPUPID_SHIFT = 12
> PAGE_ACCESS_TIME_BUCKETS = 0
> sysctl_numa_balancing_hot_threshold = 1000
> 
> Assume while changing pte,
> jiffies_to_msecs(jiffies) = 0xAABB0100
> 
> So value saved in page->flags will be lowest 12 bits of 0xAABB0100
> which is 0x100.
> 
> Assume when numa_hint_fault_latency() gets called,
> time = jiffies_to_msecs(jiffies) = 0xAACC0100
> 
> So, time = 0xAACC0100, and last_time = 0x100,
> time - last_time = 0xAACC0100 - 0x100 = 0xAACC0000
> 0xAACC0000 & PAGE_ACCESS_TIME_MASK = 0xAACC0000 & ((1 << 12) - 1) = 0
> 
> so the return value of this function is 0, the code will consider it as
> hot page but it is cold page because actual difference is
> 0xAACC0100 - 0xAABB0100 = 110000 ms
> 

Yes.  This is possible.

> There may be more such scenarios. What do you think?

The algorithm just works statistically correct.  That is, for really hot
pages, their hint page fault latency will be short and we can promote it
when they are accessed.  For cold pages, it's still possible for them to
be identified as hot pages.  But the possibility is much lower than that
of the hot pages.

We can try to improve further here.  But as the first step, I want to
keep the algorithm as simple as possible.  Then we can try improve it
step by step and show benefit in each step to justify the further
optimization.

> > +}
> > +

Best Regards,
Huang, Ying


