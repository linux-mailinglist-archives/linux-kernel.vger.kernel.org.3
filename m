Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28AA50DBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiDYIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiDYIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:54:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E0E0DB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:51:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KmzH83GVmz1JBG0;
        Mon, 25 Apr 2022 16:50:12 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 16:51:02 +0800
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     David Hildenbrand <david@redhat.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <peterx@redhat.com>, <sfr@canb.auug.org.au>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Tim C Chen <tim.c.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <8aeebc2f0b2a251d3d70402cd0edf063ba911013.camel@intel.com>
 <f88412b4-83db-e594-fc48-2f4b8b9f3be8@redhat.com>
 <6c6694965fa3e6d85d78d56703090f227a55bb83.camel@intel.com>
 <a64b1987-1f98-db78-c0e4-189690d7a45d@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <63c96d54-f16b-4a39-a665-227cc194cf96@huawei.com>
Date:   Mon, 25 Apr 2022 16:51:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a64b1987-1f98-db78-c0e4-189690d7a45d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/25 16:01, David Hildenbrand wrote:
> On 25.04.22 09:55, ying.huang@intel.com wrote:
>> On Mon, 2022-04-25 at 09:49 +0200, David Hildenbrand wrote:
>>> On 25.04.22 09:41, ying.huang@intel.com wrote:
>>>> Hi, Miaohe,
>>>>
>>>> On Sun, 2022-04-24 at 17:11 +0800, Miaohe Lin wrote:
>>>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>>>> page filled with random data is mapped into user address space.  In case
>>>>> of error, a special swap entry indicating swap read fails is set to the
>>>>> page table.  So the swapcache page can be freed and the user won't end up
>>>>> with a permanently mounted swap because a sector is bad.  And if the page
>>>>> is accessed later, the user process will be killed so that corrupted data
>>>>> is never consumed.  On the other hand, if the page is never accessed, the
>>>>> user won't even notice it.
>>>>>
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  include/linux/swap.h    |  7 ++++++-
>>>>>  include/linux/swapops.h | 10 ++++++++++
>>>>>  mm/memory.c             |  5 ++++-
>>>>>  mm/swapfile.c           | 11 +++++++++++
>>>>>  4 files changed, 31 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>> index 5553189d0215..b82c196d8867 100644
>>>>> --- a/include/linux/swap.h
>>>>> +++ b/include/linux/swap.h
>>>>> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>>>>>   * actions on faults.
>>>>>   */
>>>>>
>>>>> +#define SWP_SWAPIN_ERROR_NUM 1
>>>>> +#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
>>>>> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
>>>>> +			     SWP_PTE_MARKER_NUM)
>>>>>
>>>>>
>>>>
>>>> It appears wasteful to use another swap device number. 
>>>
>>> Do we really care?
>>>
>>> We currently use 5 bits for swap types, so we have a total of 32.
>>>
>>> SWP_HWPOISON_NUM -> 1
>>> SWP_MIGRATION_NUM -> 3
>>> SWP_PTE_MARKER_NUM -> 1
>>> SWP_DEVICE_NUM -> 4
>>> SWP_SWAPIN_ERROR_NUM -> 1
>>>
>>> Which would leave us with 32 - 10 = 22 swap devices. IMHO that's plenty
>>> for real life scenarios.
>>
>> Creating multiple swap partitions on one disk can improve the
>> scalability of swap subsystem, although we usually don't have so many
>> disks for swap. 
> 
> Exactly, and IMHO if we have 22 or 23 doesn't make a real difference
> here ...

I tend to agree with David. Thanks both!

> 

