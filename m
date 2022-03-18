Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622784DD948
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiCRL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiCRL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:58:27 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686F12F14F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:57:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V7W6.JF_1647604625;
Received: from 30.0.159.17(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V7W6.JF_1647604625)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 19:57:05 +0800
Message-ID: <6cb97421-ab4a-2520-2503-10fec548edd0@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 19:58:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/damon: Make the sampling more accurate
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220318104948.26387-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220318104948.26387-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 6:49 PM, sj@kernel.org wrote:
> On Fri, 18 Mar 2022 18:01:19 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>
>> On 3/18/2022 5:40 PM, sj@kernel.org wrote:
>>> Hi Baolin,
>>>
>>> On Fri, 18 Mar 2022 17:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> When I try to sample the physical address with DAMON to migrate pages
>>>> on tiered memory system, I found it will demote some cold regions mistakenly.
>>>> Now we will choose an physical address in the region randomly, but if
>>>> its corresponding page is not an online LRU page, we will ignore the
>>>> accessing status in this cycle of sampling, and actually will be treated
>>>> as a non-accessed region. Suppose a region including some non-LRU pages,
>>>> it will be treated as a cold region with a high probability, and may be
>>>> merged with adjacent cold regions, but there are some pages may be
>>>> accessed we missed.
>>>>
>>>> So instead of ignoring the access status of this region if we did not find
>>>> a valid page according to current sampling address, we can use last valid
>>>> sampling address to help to make the sampling more accurate, then we can do
>>>> a better decision.
>>>
>>> Well...  Offlined pages are also a valid part of the memory region, so treating
>>> those as not accessed and making the memory region containing the offlined
>>> pages looks colder seems legal to me.  IOW, this approach could make memory
>>> regions containing many non-online-LRU pages as hot.
>>
>> IMO I don't think this is a problem, since if this region containing
>> many non-online-LRU pages is treated as hot, which means threre are aome
>> pages are hot, right? We can find them and promote them to fast memory
>> (or do other schemes). Meanwhile, for non-online-LRU pages, we can
>> filter them and do nothing for them, since we can not get a valid page
>> struct for them.
> 
> For some of DAMOS actions that you mentioned, that could make sense.  However,
> that wouldn't make much sense for some other cases, especially for manual
> DAMON-based access pattern profiling.

I am not sure about this case, could you elaborate on how this can worse 
the case you mentioned?

Like you said as below, we can split the regions to separate the hot 
pages out of the hot regions containing some offline or non-lru pages, 
that is also a benefit to improve the regions adjustment.

> After all, we already have a mechanism for this case: adaptive regions
> adjustment (or, regions split/merge).  That mechanism will eventually separate
> out hot oneline-LRU pages in the memory regions.  Before the region is
> adjusted, reporting the whole region as hot looks like a right result to me.
> Of course, I admit that it could take too much time to converge to the optimal
> regions, and there are many rooms for improvement of the regions adjustment
> mechanism.  I think we should pursue the direction (improving the regions
> adjustment mechanism).

Yes, agree.

> FYI, I have some rough ideas for improving the mechanism including partitioning
> regions into more than 2 sub-regions if we belive it is not making a good
> progress.  Nevertheless, I'd like to first make a methodology for evaluating
> current accuracy.  For that, I am planning to implement a page-granularity
> access monitoring.

Great, I think the page-granularity monitoring will be more suitable for 
tiered memory system, which can reduce redundant demotion and promotion. 
However, I still concern the overhead if the monitoring is a 
page-granularity, especially for a large memory size. Anyway, I'd like 
to help to test or review the new page-granularity monitoring when 
you're ready to send out. Thanks.
