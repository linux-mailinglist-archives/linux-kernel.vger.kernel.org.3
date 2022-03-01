Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ED44C8452
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiCAGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCAGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:48:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6E47AEC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646117278; x=1677653278;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GgVNOL7Ku3TgRlMR3ALd7PpCE1otCvbcR+kwYCWgXls=;
  b=gIahs9zxk3g8zYkQA/ndUfkNJRy9JgzTUCI1nGLXNL8F4ilY7nlM1iE5
   zw7ulhdzBuZQSVz517/jAEygzTQsSC88AiEHOdolmVpijQiI/SvU/dwCj
   q4vle58vjxQYQN6f7iCWjqNbThqJSfMlWFbV3PskdxvrzsFpt6ehhgod7
   EAGapkDuEB3zkp95m6CqDwvA3UiVeiw7SkJk/xVt7K4asRgxidG1QDvme
   v9WGgGRwq/BvKtneARCiAafO9nxlPs7aNkQLFqP276ApJj6CQFPr2TEON
   QES3+jxOU4ASDqVew5OT+p5BQzoGrmWIQAraE8ZBKqNSIbjROPuQNo1TF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233688516"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="233688516"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:47:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="575598003"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:47:53 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Michal Hocko" <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
References: <20220221084529.1052339-1-ying.huang@intel.com>
        <20220221084529.1052339-3-ying.huang@intel.com>
        <4652446e-2089-a3c4-fbdb-321322887392@huawei.com>
Date:   Tue, 01 Mar 2022 14:47:50 +0800
In-Reply-To: <4652446e-2089-a3c4-fbdb-321322887392@huawei.com> (Miaohe Lin's
        message of "Tue, 1 Mar 2022 14:28:13 +0800")
Message-ID: <874k4i2mp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/2/21 16:45, Huang Ying wrote:
>> With the advent of various new memory types, some machines will have
>> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
>> memory subsystem of these machines can be called memory tiering
>> system, because the performance of the different types of memory are
>> usually different.
>> 
>> In such system, because of the memory accessing pattern changing etc,
>> some pages in the slow memory may become hot globally.  So in this
>> patch, the NUMA balancing mechanism is enhanced to optimize the page
>> placement among the different memory types according to hot/cold
>> dynamically.
>> 
>> In a typical memory tiering system, there are CPUs, fast memory and
>> slow memory in each physical NUMA node.  The CPUs and the fast memory
>> will be put in one logical node (called fast memory node), while the
>> slow memory will be put in another (faked) logical node (called slow
>> memory node).  That is, the fast memory is regarded as local while the
>> slow memory is regarded as remote.  So it's possible for the recently
>> accessed pages in the slow memory node to be promoted to the fast
>> memory node via the existing NUMA balancing mechanism.
>> 
>> The original NUMA balancing mechanism will stop to migrate pages if
>> the free memory of the target node becomes below the high watermark.
>> This is a reasonable policy if there's only one memory type.  But this
>> makes the original NUMA balancing mechanism almost do not work to
>> optimize page placement among different memory types.  Details are as
>> follows.
>> 
>> It's the common cases that the working-set size of the workload is
>> larger than the size of the fast memory nodes.  Otherwise, it's
>> unnecessary to use the slow memory at all.  So, there are almost
>> always no enough free pages in the fast memory nodes, so that the
>> globally hot pages in the slow memory node cannot be promoted to the
>> fast memory node.  To solve the issue, we have 2 choices as follows,
>> 
>> a. Ignore the free pages watermark checking when promoting hot pages
>>    from the slow memory node to the fast memory node.  This will
>>    create some memory pressure in the fast memory node, thus trigger
>>    the memory reclaiming.  So that, the cold pages in the fast memory
>>    node will be demoted to the slow memory node.
>> 
>> b. Make kswapd of the fast memory node to reclaim pages until the free
>>    pages are a little more than the high watermark (named as promo
>>    watermark).  Then, if the free pages of the fast memory node reaches
>>    high watermark, and some hot pages need to be promoted, kswapd of the
>>    fast memory node will be waken up to demote more cold pages in the
>>    fast memory node to the slow memory node.  This will free some extra
>>    space in the fast memory node, so the hot pages in the slow memory
>>    node can be promoted to the fast memory node.
>> 
>> The choice "a" may create high memory pressure in the fast memory
>> node.  If the memory pressure of the workload is high, the memory
>> pressure may become so high that the memory allocation latency of the
>> workload is influenced, e.g. the direct reclaiming may be triggered.
>> 
>> The choice "b" works much better at this aspect.  If the memory
>> pressure of the workload is high, the hot pages promotion will stop
>> earlier because its allocation watermark is higher than that of the
>
> Many thanks for your path. The patch looks good to me but I have a question.
> WMARK_PROMO is only used inside pgdat_balanced when NUMA_BALANCING_MEMORY_TIERING
> is set. So its allocation watermark seems to be as same as the normal memory
> allocation. How should I understand the above sentence? Am I miss something?

Before allocating pages for promotion, the watermark of the fast node
will be checked (please refer to migrate_balanced_pgdat()).  If the
watermark is going to be lower than the high watermark, promotion will
abort.

Best Regards,
Huang, Ying
