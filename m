Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEFC4C8587
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiCAHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiCAHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:52:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939FB7E597
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:51:25 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K78Xb2Zb5zBrMb;
        Tue,  1 Mar 2022 15:49:35 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 15:51:23 +0800
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
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
References: <20220221084529.1052339-1-ying.huang@intel.com>
 <20220221084529.1052339-3-ying.huang@intel.com>
 <4652446e-2089-a3c4-fbdb-321322887392@huawei.com>
 <874k4i2mp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d777f1d7-7649-72be-8b77-420f17e35c0f@huawei.com>
Date:   Tue, 1 Mar 2022 15:51:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <874k4i2mp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/1 14:47, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2022/2/21 16:45, Huang Ying wrote:
>>> With the advent of various new memory types, some machines will have
>>> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
>>> memory subsystem of these machines can be called memory tiering
>>> system, because the performance of the different types of memory are
>>> usually different.
>>>
>>> In such system, because of the memory accessing pattern changing etc,
>>> some pages in the slow memory may become hot globally.  So in this
>>> patch, the NUMA balancing mechanism is enhanced to optimize the page
>>> placement among the different memory types according to hot/cold
>>> dynamically.
>>>
>>> In a typical memory tiering system, there are CPUs, fast memory and
>>> slow memory in each physical NUMA node.  The CPUs and the fast memory
>>> will be put in one logical node (called fast memory node), while the
>>> slow memory will be put in another (faked) logical node (called slow
>>> memory node).  That is, the fast memory is regarded as local while the
>>> slow memory is regarded as remote.  So it's possible for the recently
>>> accessed pages in the slow memory node to be promoted to the fast
>>> memory node via the existing NUMA balancing mechanism.
>>>
>>> The original NUMA balancing mechanism will stop to migrate pages if
>>> the free memory of the target node becomes below the high watermark.
>>> This is a reasonable policy if there's only one memory type.  But this
>>> makes the original NUMA balancing mechanism almost do not work to
>>> optimize page placement among different memory types.  Details are as
>>> follows.
>>>
>>> It's the common cases that the working-set size of the workload is
>>> larger than the size of the fast memory nodes.  Otherwise, it's
>>> unnecessary to use the slow memory at all.  So, there are almost
>>> always no enough free pages in the fast memory nodes, so that the
>>> globally hot pages in the slow memory node cannot be promoted to the
>>> fast memory node.  To solve the issue, we have 2 choices as follows,
>>>
>>> a. Ignore the free pages watermark checking when promoting hot pages
>>>    from the slow memory node to the fast memory node.  This will
>>>    create some memory pressure in the fast memory node, thus trigger
>>>    the memory reclaiming.  So that, the cold pages in the fast memory
>>>    node will be demoted to the slow memory node.
>>>
>>> b. Make kswapd of the fast memory node to reclaim pages until the free
>>>    pages are a little more than the high watermark (named as promo
>>>    watermark).  Then, if the free pages of the fast memory node reaches
>>>    high watermark, and some hot pages need to be promoted, kswapd of the
>>>    fast memory node will be waken up to demote more cold pages in the
>>>    fast memory node to the slow memory node.  This will free some extra
>>>    space in the fast memory node, so the hot pages in the slow memory
>>>    node can be promoted to the fast memory node.
>>>
>>> The choice "a" may create high memory pressure in the fast memory
>>> node.  If the memory pressure of the workload is high, the memory
>>> pressure may become so high that the memory allocation latency of the
>>> workload is influenced, e.g. the direct reclaiming may be triggered.
>>>
>>> The choice "b" works much better at this aspect.  If the memory
>>> pressure of the workload is high, the hot pages promotion will stop
>>> earlier because its allocation watermark is higher than that of the
>>
>> Many thanks for your path. The patch looks good to me but I have a question.
>> WMARK_PROMO is only used inside pgdat_balanced when NUMA_BALANCING_MEMORY_TIERING
>> is set. So its allocation watermark seems to be as same as the normal memory
>> allocation. How should I understand the above sentence? Am I miss something?
> 
> Before allocating pages for promotion, the watermark of the fast node
> will be checked (please refer to migrate_balanced_pgdat()).  If the
> watermark is going to be lower than the high watermark, promotion will
> abort.

I see. The hot pages promotion watermark is "nr_migrate_pages" more than that of the
normal memory allocation not "_watermark[WMARK_PROMO] - _watermark[WMARK_HIGH]".

Many thanks for your kindly explanation. :)

> 
> Best Regards,
> Huang, Ying
> .
> 

