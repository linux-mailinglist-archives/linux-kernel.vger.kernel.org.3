Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBCD5242F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbiELDES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244588AbiELDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:04:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B319FF40
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:04:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzGn73SvJzhZ3C;
        Thu, 12 May 2022 11:03:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 11:04:02 +0800
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
 <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d59ea7fc-c509-4166-5e01-0af0a332536f@huawei.com>
Date:   Thu, 12 May 2022 11:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 0:22, David Hildenbrand wrote:
> On 11.05.22 18:10, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Wed, May 11, 2022 at 05:11:17PM +0200, David Hildenbrand wrote:
>>> On 09.05.22 12:53, Miaohe Lin wrote:
>>>> On 2022/5/9 17:58, Oscar Salvador wrote:
>>>>> On Mon, May 09, 2022 at 05:04:54PM +0800, Miaohe Lin wrote:
>>>>>>>> So that leaves us with either
>>>>>>>>
>>>>>>>> 1) Fail offlining -> no need to care about reonlining
>>>>>>
>>>>>> Maybe fail offlining will be a better alternative as we can get rid of many races
>>>>>> between memory failure and memory offline? But no strong opinion. :)
>>>>>
>>>>> If taking care of those races is not an herculean effort, I'd go with
>>>>> allowing offlining + disallow re-onlining.
>>>>> Mainly because memory RAS stuff.
>>>>
>>>> This dose make sense to me. Thanks. We can try to solve those races if
>>>> offlining + disallow re-onlining is applied. :)
>>>>
>>>>>
>>>>> Now, to the re-onlining thing, we'll have to come up with a way to check
>>>>> whether a section contains hwpoisoned pages, so we do not have to go
>>>>> and check every single page, as that will be really suboptimal.
>>>>
>>>> Yes, we need a stable and cheap way to do that.
>>>
>>> My simplistic approach would be a simple flag/indicator in the memory block devices
>>> that indicates that any page in the memory block was hwpoisoned. It's easy to
>>> check that during memory onlining and fail it.
>>>
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 084d67fd55cc..3d0ef812e901 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -183,6 +183,9 @@ static int memory_block_online(struct memory_block *mem)
>>>         struct zone *zone;
>>>         int ret;
>>>  
>>> +       if (mem->hwpoisoned)
>>> +               return -EHWPOISON;
>>> +
>>>         zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
>>>                                   start_pfn, nr_pages);
>>>  
>>
>> Thanks for the idea, a simple flag could work if we don't have to consider
>> unpoison.  If we need consider unpoison, we need remember the last hwpoison
>> page in the memory block, so mem->hwpoisoned should be the counter of
>> hwpoison pages.
> 
> Right, but unpoisoning+memory offlining+memory onlining is a yet more
> extreme use case we don't have to bother about I think.
> 
>>
>>>
>>>
>>> Once the problematic DIMM would actually get unplugged, the memory block devices
>>> would get removed as well. So when hotplugging a new DIMM in the same
>>> location, we could online that memory again.
>>
>> What about PG_hwpoison flags?  struct pages are also freed and reallocated
>> in the actual DIMM replacement?
> 
> Once memory is offline, the memmap is stale and is no longer
> trustworthy. It gets reinitialize during memory onlining -- so any
> previous PG_hwpoison is overridden at least there. In some setups, we
> even poison the whole memmap via page_init_poison() during memory offlining.
> 

I tend to agree with David. The memmap is unreliable after memory is offline. So preventing memory
re-online until a new DIMM replacement is a good idea.

Thanks!

> Apart from that, we should be freeing the memmap in all relevant cases
> when removing memory. I remember there are a couple of corner cases, but
> we don't really have to care about that.
> 

