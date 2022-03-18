Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593444DD419
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiCRFOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiCRFOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:14:36 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F802719
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:13:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V7UWWcn_1647580393;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7UWWcn_1647580393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 13:13:14 +0800
From:   xhao@linux.alibaba.com
Reply-To: xhao@linux.alibaba.com
Subject: Re: [RFC PATCH V1 0/3] mm/damon: Add CMA minotor support
To:     David Hildenbrand <david@redhat.com>, sj@kernel.org
Cc:     rongwei.wang@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>
References: <cover.1647378112.git.xhao@linux.alibaba.com>
 <a1e0a9e9-07ef-8d1c-a409-2b4fb12ed553@redhat.com>
 <6e6ef9fa-3916-3449-954d-efd63a959019@linux.alibaba.com>
 <d604d77e-636f-eb6d-0014-087d880de80e@redhat.com>
Message-ID: <611f2ec6-04de-440a-3d54-c2bc34f45cf3@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 13:13:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d604d77e-636f-eb6d-0014-087d880de80e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/22 12:42 AM, David Hildenbrand wrote:
> On 17.03.22 08:03, Xin Hao wrote:
>> Hi David,
>>
>> On 3/16/22 11:09 PM, David Hildenbrand wrote:
>>> On 15.03.22 17:37, Xin Hao wrote:
>>>
>>> s/minotor/monitor/
>> Thanks,  i will fix it.
>>>> The purpose of these patches is to add CMA memory monitoring function.
>>>> In some memory tight scenarios, it will be a good choice to release more
>>>> memory by monitoring the CMA memory.
>>> I'm sorry, but it's hard to figure out what the target use case should
>>> be. Who will release CMA memory and how? Who will monitor that? What are
>>> the "some memory tight scenarios"? What's the overall design goal?
>> I may not be describing exactly what  i mean，My intention is to find out
>> how much of the reserved CMA space is actually used and which is unused,
>> For those that are not used, I understand that they can be released by
>> cma_release(). Of course, This is just a little personal thought that I
>> think is helpful for saving memory.
> Hm, not quite. We can place movable allocations on cma areas, to be
> migrated away once required for allocations via CMA. So just looking at
> the pages allocated within a CMA area doesn't really tell you what's
> actually going on.

I don't think so,  the damon not looking at the pages allocate, It is 
constantly monitoring who is using CMA area pages through tracking page 
access bit

in the kernel via the kdamond.x thread, So through damon, it can tell us 
about  the hot and cold distribution of CMA memory.

--cc  SeongJae Park <sj@kernel.org>


More about damon, you can refer to this 
link：https://sjp38.github.io/post/damon/ 
<https://sjp38.github.io/post/damon/>

>
-- 
Best Regards!
Xin Hao

