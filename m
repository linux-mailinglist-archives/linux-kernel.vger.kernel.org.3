Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29635AAB9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiIBJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiIBJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:39:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F9E40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:39:46 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJtBC0ZzSzHncv;
        Fri,  2 Sep 2022 17:37:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 17:39:44 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 17:39:43 +0800
Message-ID: <9ab7d4b4-505b-0532-09fd-186814b7fc8f@huawei.com>
Date:   Fri, 2 Sep 2022 17:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] mm: add pageblock_aligned() macro
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20220902064751.17890-1-wangkefeng.wang@huawei.com>
 <20220902064751.17890-2-wangkefeng.wang@huawei.com>
 <e0405abb-d1ea-977b-6d16-859a56bf3027@redhat.com>
 <79d05f57-8b3a-2450-43bf-f45de53a8c8e@huawei.com>
 <2e7945e5-b0b0-bc44-c5eb-48d67532f78f@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <2e7945e5-b0b0-bc44-c5eb-48d67532f78f@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/2 17:04, David Hildenbrand wrote:
> On 02.09.22 11:02, Kefeng Wang wrote:
>> On 2022/9/2 16:42, David Hildenbrand wrote:
>>> On 02.09.22 08:47, Kefeng Wang wrote:
>>>> Add pageblock_aligned() and use it to simplify code.
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>> [...]
>>>
>>>> -	unsigned long nr_pgmask = pageblock_nr_pages - 1;
>>>>   	int nid = zone_to_nid(zone);
>>>>   	unsigned long nr_pages = 0;
>>>>   	int zid = zone_idx(zone);
>>>> @@ -1977,7 +1974,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>>>>   		if (!deferred_pfn_valid(pfn)) {
>>>>   			page = NULL;
>>>>   			continue;
>>>> -		} else if (!page || !(pfn & nr_pgmask)) {
>>> I didn't sleep too well this night and am tired, please tell me why I'm
>>> wrong :)
>> Wish you have a good reset :)
> Thanks, the headache isn't helping :D
>
>>> "pfn & (pageblock_nr_pages - 1)" is true if the pageblock is not aligned
>>>
>>> E.g., pfn = 1, pageblock_nr_pages = 512
>>>
>>> pfn & (pageblock_nr_pages - 1)
>>> -> 1 & (512 - 1)
>>> -> 1 & 511
>>> -> true
>>>
>>> "!(pfn & (pageblock_nr_pages - 1))" is true if the pageblock is aligned
>>> -> !(true)
>>> -> false
>>>
>>>
>>> However, "!pageblock_aligned(1)" = true
>>>
>>>
>>>> +		} else if (!page || !pageblock_aligned(pfn)) {
>> pageblock_aligned(pfn) IS_ALIGNED((unsigned long)(pfn), pageblock_nr_pages)
>>
>> #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0) (((pfn) &
>> (pageblock_nr_pages - 1)) == 0) -> ((1 & 512 -1) == 0) -> ((1 & 511) ==
>> 0) -> ((511) == 0) -> false
>> right ?
> yes ... and inverting that would give you "true", which is not what we want?
>
oops...  it's my fault, looks like I need to have a reset to save my 
brain...
> Again, sorry if I'm wrong ...
>
