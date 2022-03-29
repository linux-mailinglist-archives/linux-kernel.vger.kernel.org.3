Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950E4EA4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiC2B47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiC2B4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:56:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00B25283
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:55:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSCLL4R74zZfhb;
        Tue, 29 Mar 2022 09:54:50 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 09:55:06 +0800
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     "Huang, Ying" <ying.huang@intel.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8ff6f619-e04a-d785-fa9a-6822c04d4ee1@huawei.com>
 <20220329004535.27ps6cy4sipisxsu@master>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <135cf5e8-4153-c0a9-70b8-f0a06713b550@huawei.com>
Date:   Tue, 29 Mar 2022 09:55:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220329004535.27ps6cy4sipisxsu@master>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/29 8:45, Wei Yang wrote:
> On Mon, Mar 28, 2022 at 03:23:49PM +0800, Miaohe Lin wrote:
>> On 2022/3/28 9:08, Huang, Ying wrote:
>>> Hi, Wei,
>>>
>>> Wei Yang <richard.weiyang@gmail.com> writes:
>>>
>>>> wakeup_kswapd() only wake up kswapd when the zone is managed.
>>>>
>>>> For two callers of wakeup_kswapd(), they are node perspective.
>>>>
>>>>   * wake_all_kswapds
>>>>   * numamigrate_isolate_page
>>>>
>>>> If we picked up a !managed zone, this is not we expected.
>>>>
>>>> This patch makes sure we pick up a managed zone for wakeup_kswapd().
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> ---
>>>>  mm/migrate.c    | 2 +-
>>>>  mm/page_alloc.c | 2 ++
>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 3d60823afd2d..c4b654c0bdf0 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>>>  			return 0;
>>>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>>>> -			if (populated_zone(pgdat->node_zones + z))
>>>> +			if (managed_zone(pgdat->node_zones + z))
>>>
>>> This looks good to me!  Thanks!  It seems that we can replace
>>> populated_zone() in migrate_balanced_pgdat() too.  Right?
>>
>> This patch looks good to me too. Thanks!
>>
>> BTW: This makes me remember the bewilderment when I read the relevant code.
>> It's very kind of you if you could tell me the difference between
>> managed_zone and populated_zone. IIUC, when the caller relies on the
> 
> The difference is managed_zone means the zone has pages managed by buddy,
> while populated_zone means the zone has pages but may be reserved.

That's just what I understand. Thanks. :)

> 
>> activity from buddy system, managed_zone should always be used. I think
>> there're many places like compaction need to use managed_zone but
>> populated_zone is used now. They might need to change to use managed_zone
>> too. Or am I miss something?
> 
> This thread comes from the read of commit 6aa303defb74, which adjust the
> vmscan code. It looks like there is some mis-use in compaction, but I didn't
> get time to go through it.

I see. Thanks for the work.

> 
>>
>> Many Thanks. :)
> 

