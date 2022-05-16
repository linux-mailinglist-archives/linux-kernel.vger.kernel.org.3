Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2F527C51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiEPDZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiEPDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:25:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5C1C903
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:25:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L1l3K42j8zgYJM;
        Mon, 16 May 2022 11:24:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 11:25:30 +0800
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
 <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
 <20220512063558.GA249122@hori.linux.bs1.fc.nec.co.jp>
 <c424e8a2-a771-e738-396c-24ac907b557f@redhat.com>
 <04781d15-9d87-1763-02fe-e353679c50d7@huawei.com>
 <5b43d8f7-3477-a2c2-028e-e31d40ac932c@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c5bca009-9c57-2818-8bf3-88160f4d30db@huawei.com>
Date:   Mon, 16 May 2022 11:25:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5b43d8f7-3477-a2c2-028e-e31d40ac932c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 20:59, David Hildenbrand wrote:
> On 12.05.22 13:13, Miaohe Lin wrote:
>> On 2022/5/12 15:28, David Hildenbrand wrote:
>>>>>>>
>>>>>>> Once the problematic DIMM would actually get unplugged, the memory block devices
>>>>>>> would get removed as well. So when hotplugging a new DIMM in the same
>>>>>>> location, we could online that memory again.
>>>>>>
>>>>>> What about PG_hwpoison flags?  struct pages are also freed and reallocated
>>>>>> in the actual DIMM replacement?
>>>>>
>>>>> Once memory is offline, the memmap is stale and is no longer
>>>>> trustworthy. It gets reinitialize during memory onlining -- so any
>>>>> previous PG_hwpoison is overridden at least there. In some setups, we
>>>>> even poison the whole memmap via page_init_poison() during memory offlining.
>>>>>
>>>>> Apart from that, we should be freeing the memmap in all relevant cases
>>>>> when removing memory. I remember there are a couple of corner cases, but
>>>>> we don't really have to care about that.
>>>>
>>>> OK, so there seems no need to manipulate struct pages for hwpoison in
>>>> all relevant cases.
>>>
>>> Right. When offlining a memory block, all we have to do is remember if
>>> we stumbled over a hwpoisoned page and rememebr that inside the memory
>>> block. Rejecting to online is then easy.
>>
>> BTW: How should we deal with the below race window:
>>
>> CPU A			CPU B				CPU C
>> accessing page while hold page refcnt
>> 			memory_failure happened on page
>> 							offline_pages
>> 							  page can be offlined due to page refcnt
>> 							  is ignored when PG_hwpoison is set
>> can still access page struct...
>>
>> Any in use page (with page refcnt incremented) might be offlined while its content, e.g. flags, private ..., can
>> still be accessed if the above race happened. Is this possible? Or am I miss something? Any suggestion to fix it?
>> I can't figure out a way yet. :(
> 
> I assume you mean that test_pages_isolated() essentially only checks for
> PageHWPoison() and doesn't care about the refcount?

Yes, page refcount is ignored when PG_HWPoison is set.

> 
> That part is very dodgy and it's part of my motivation to question that
> whole handling in the first place.
> 
> 
> In do_migrate_range(), there is a comment:
> 
> "
>  HWPoison pages have elevated reference counts so the migration would
>  fail on them. It also doesn't make any sense to migrate them in the
>  first place. Still try to unmap such a page in case it is still mapped
>  (e.g. current hwpoison implementation doesn't unmap KSM pages but keep
>  the unmap as the catch all safety net).
> "
> 
> My assumption would be: if there are any unexpected references on a
> hwpoison page, we must fail offlining. Ripping out the page might be
> more harmful then just leaving it in place and failing offlining for the
> time being.

I tend to agree with this. :)

> 
> 
> 
> I am no export on PageHWPoison(). Which guarantees do we have regarding
> the page count?
> 
> If we succeed in unmapping the page, there shouldn't be any references
> from the page tables. We might still have GUP references to such pages,
> and it would be fair enough to fail offlining. I remember we try
> removing the page from the pagecache etc. to free up these references.
> So which additional references do we have that the comment in offlining
> code talks about? A single additional one from hwpoison code?

IIRC, memory_failure will hold one extra page refcount. This refcount will be released
in unpoison_memory.

> 
> Once we figure that out, we might tweak test_pages_isolated() to also
> consider the page count and not rip out random pages that are still
> referenced in the system.
> 

But there are some corner cases where PageHWPoison is set but page refcnt is not increased.
So we couldn't detect the page refcount reliably now. :(

Thanks!
