Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCE651F82C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiEIJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiEIJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:09:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D91F9A18
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:05:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KxZr94wcszCsTD;
        Mon,  9 May 2022 17:00:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 17:04:54 +0800
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, David Hildenbrand <david@redhat.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
Date:   Mon, 9 May 2022 17:04:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/9 15:29, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Apr 28, 2022 at 10:44:15AM +0200, David Hildenbrand wrote:
>>>> 2) It happens rarely (ever?), so do we even care?
>>>
>>> I'm not certain of the rarity.  Some cloud service providers who maintain
>>> lots of servers may care?
>>
>> About replacing broken DIMMs? I'm not so sure, especially because it
>> requires a special setup with ZONE_MOVABLE (i.e., movablecore) to be
>> somewhat reliable and individual DIMMs can usually not get replaced at all.
>>
>>>
>>>> 3) Once the memory is offline, we can re-online it and lost HWPoison.
>>>>    The memory can be happily used.
>>>>
>>>> 3) can happen easily if our DIMM consists of multiple memory blocks and
>>>> offlining of some memory block fails -> we'll re-online all already
>>>> offlined ones. We'll happily reuse previously HWPoisoned pages, which
>>>> feels more dangerous to me then just leaving the DIMM around (and
>>>> eventually hwpoisoning all pages on it such that it won't get used
>>>> anymore?).
>>>
>>> I see. This scenario can often happen.
>>>
>>>>
>>>> So maybe we should just fail offlining once we stumble over a hwpoisoned
>>>> page?
>>>
>>> That could be one choice.
>>>
>>> Maybe another is like this: offlining can succeed but HWPoison flags are
>>> kept over offline-reonline operations.  If the system noticed that the
>>> re-onlined blocks are backed by the original DIMMs or NUMA nodes, then the
>>> saved HWPoison flags are still effective, so keep using them.  If the
>>> re-onlined blocks are backed by replaced DIMMs/NUMA nodes, then we can clear
>>> all HWPoison flags associated with replaced physical address range.  This
>>> can be done automatically in re-onlining if there's a way for kernel to know
>>> whether DIMM/NUMA nodes are replaced with new ones.  But if there isn't,
>>> system applications have to check the HW and explicitly reset the HWPoison
>>> flags.
>>
>> Offline memory sections have a stale memmap, so there is no trusting on
>> that. And trying to work around that or adjusting memory onlining code
>> overcomplicates something we really don't care about supporting.
> 
> OK, so I'll go forward to reduce complexity in hwpoison specific code in
> memory offlining code.
> 
>>
>> So if we continue allowing offlining memory blocks with poisoned pages,
>> we could simply remember that that memory block had any posioned page
>> (either for the memory section or maybe better for the whole memory
>> block). We can then simply reject/fail memory onlining of these memory
>> blocks.
> 
> It seems to be helpful also for other conext (like hugetlb) to know whether
> there's any hwpoisoned page in a given range of physical address, so I'll
> think of this approach.
> 
>>
>> So that leaves us with either
>>
>> 1) Fail offlining -> no need to care about reonlining

Maybe fail offlining will be a better alternative as we can get rid of many races
between memory failure and memory offline? But no strong opinion. :)

Thanks!

>> 2) Succeed offlining but fail re-onlining
> 
> Rephrasing in case I misread, memory offlining code should never check
> hwpoisoned pages finally, and memory onlining code would do kind of range
> query to find hwpoisoned pages (without depending on PageHWPoison flag).
> 
> Thanks,
> Naoya Horiguchi
> 

