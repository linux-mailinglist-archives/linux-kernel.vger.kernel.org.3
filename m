Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080CA550EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiFTDT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiFTDTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:19:24 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB523B7FA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:19:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VGpdHYg_1655695156;
Received: from 30.39.237.172(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGpdHYg_1655695156)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 11:19:17 +0800
Message-ID: <872bdaee-21a0-005b-b66c-893eb331e39a@linux.alibaba.com>
Date:   Mon, 20 Jun 2022 11:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -V3 0/3] memory tiering: hot page selection
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
References: <20220614081635.194014-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220614081635.194014-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2022 4:16 PM, Huang Ying wrote:
> To optimize page placement in a memory tiering system with NUMA
> balancing, the hot pages in the slow memory nodes need to be
> identified.  Essentially, the original NUMA balancing implementation
> selects the mostly recently accessed (MRU) pages to promote.  But this
> isn't a perfect algorithm to identify the hot pages.  Because the
> pages with quite low access frequency may be accessed eventually given
> the NUMA balancing page table scanning period could be quite long
> (e.g. 60 seconds).  So in this patchset, we implement a new hot page
> identification algorithm based on the latency between NUMA balancing
> page table scanning and hint page fault.  Which is a kind of mostly
> frequently accessed (MFU) algorithm.
> 
> In NUMA balancing memory tiering mode, if there are hot pages in slow
> memory node and cold pages in fast memory node, we need to
> promote/demote hot/cold pages between the fast and cold memory nodes.
> 
> A choice is to promote/demote as fast as possible.  But the CPU cycles
> and memory bandwidth consumed by the high promoting/demoting
> throughput will hurt the latency of some workload because of accessing
> inflating and slow memory bandwidth contention.
> 
> A way to resolve this issue is to restrict the max promoting/demoting
> throughput.  It will take longer to finish the promoting/demoting.
> But the workload latency will be better.  This is implemented in this
> patchset as the page promotion rate limit mechanism.
> 
> The promotion hot threshold is workload and system configuration
> dependent.  So in this patchset, a method to adjust the hot threshold
> automatically is implemented.  The basic idea is to control the number
> of the candidate promotion pages to match the promotion rate limit.
> 
> We used the pmbench memory accessing benchmark tested the patchset on
> a 2-socket server system with DRAM and PMEM installed.  The test
> results are as follows,
> 
> 		pmbench score		promote rate
> 		 (accesses/s)			MB/s
> 		-------------		------------
> base		  146887704.1		       725.6
> hot selection     165695601.2		       544.0
> rate limit	  162814569.8		       165.2
> auto adjustment	  170495294.0                  136.9
> 
>  From the results above,
> 
> With hot page selection patch [1/3], the pmbench score increases about
> 12.8%, and promote rate (overhead) decreases about 25.0%, compared with
> base kernel.
> 
> With rate limit patch [2/3], pmbench score decreases about 1.7%, and
> promote rate decreases about 69.6%, compared with hot page selection
> patch.
> 
> With threshold auto adjustment patch [3/3], pmbench score increases
> about 4.7%, and promote rate decrease about 17.1%, compared with rate
> limit patch.

I did a simple testing with mysql on my machine which contains 1 DRAM 
node (30G) and 1 PMEM node (126G).

sysbench /usr/share/sysbench/oltp_read_write.lua \
......
--tables=200 \
--table-size=1000000 \
--report-interval=10 \
--threads=16 \
--time=120

The tps can be improved about 5% from below data, and I think this is a 
good start to optimize the promotion. So for this series, please feel 
free to add:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Without this patchset:
  transactions:                        2080188 (3466.48 per sec.)

With this patch set:
  transactions:                        2174296 (3623.40 per sec.)
