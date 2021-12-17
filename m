Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424AD4785A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhLQHk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:40:26 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:5721 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230224AbhLQHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:40:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V-t9ojA_1639726819;
Received: from 30.21.164.42(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-t9ojA_1639726819)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Dec 2021 15:40:20 +0800
Message-ID: <907015a0-43f8-3ab4-524b-9c867d1f06d8@linux.alibaba.com>
Date:   Fri, 17 Dec 2021 15:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -V10 RESEND 3/6] memory tiering: skip to scan fast memory
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Hasan Al Maruf <hasanalmaruf@fb.com>
References: <20211207022757.2523359-1-ying.huang@intel.com>
 <20211207022757.2523359-4-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211207022757.2523359-4-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 10:27 AM, Huang Ying wrote:
> If the NUMA balancing isn't used to optimize the page placement among
> sockets but only among memory types, the hot pages in the fast memory
> node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
> to scan the pages in the fast memory node via changing their PTE/PMD
> mapping to be PROT_NONE.  So that the page faults could be avoided
> too.
> 
> In the test, if only the memory tiering NUMA balancing mode is enabled, the
> number of the NUMA balancing hint faults for the DRAM node is reduced to
> almost 0 with the patch.  While the benchmark score doesn't change
> visibly.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Hasan Al Maruf <hasanalmaruf@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

LGTM. Please feel free to add:
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
