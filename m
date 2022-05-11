Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8246B522F57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiEKJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbiEKJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:26:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434032A269
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:26:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyqG90H87zGpg6;
        Wed, 11 May 2022 17:23:29 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:26:17 +0800
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
CC:     <akpm@linux-foundation.org>, <aquini@redhat.com>,
        <ddutile@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mgorman@techsingularity.net>,
        <vvghjk1234@gmail.com>
References: <2c2900eb-886a-5bbe-f7c7-9d74a6399893@huawei.com>
 <20220511070710.5576-1-yamamoto.rei@jp.fujitsu.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <07e0ceb8-a637-b011-bbf6-ba760a0b12e4@huawei.com>
Date:   Wed, 11 May 2022 17:26:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220511070710.5576-1-yamamoto.rei@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/5/11 15:07, Rei Yamamoto wrote:
> On Wed, 11 May 2022 14:25:34 Miaohe Lin wrote:
>> On 2022/5/11 12:43, Rei Yamamoto wrote:
>>> Prevent returning a pfn outside the target zone in case that not
>>> aligned with pageblock boundary.
>>> Otherwise isolate_migratepages_block() would handle pages not in
>>> the target zone.
>>>
>>
>> IIUC, the sole caller isolate_migratepages will ensure the pfn won't outside
>> the target zone. So the below code change might not be necessary. Or am I miss
>> something ?
> 
> While block_start_pfn is ensured, this variable is not used as the argument for 
> isolate_migratepages_block():
>   -----
>   static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>   {
>   :
>           low_pfn = fast_find_migrateblock(cc);
>           block_start_pfn = pageblock_start_pfn(low_pfn);
>           if (block_start_pfn < cc->zone->zone_start_pfn)
>                   block_start_pfn = cc->zone->zone_start_pfn;  <--- block_start_pfn is ensured not outside 
>                                                                     the target zone
>   :
>           block_end_pfn = pageblock_end_pfn(low_pfn);
>   :
>           for (; block_end_pfn <= cc->free_pfn;
>                           fast_find_block = false,
>                           cc->migrate_pfn = low_pfn = block_end_pfn,
>                           block_start_pfn = block_end_pfn,
>                           block_end_pfn += pageblock_nr_pages) {
>   :
>                   if (isolate_migratepages_block(cc, low_pfn, block_end_pfn,  <--- low_pfn is passed as 
>                                                                                    the argument

Sorry, I think you're right. And could you please add the runtime effect of this issue?

Anyway, this patch looks good to me now. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

>                                                   isolate_mode))
>                           return ISOLATE_ABORT;
>   -----
> 
> So, the low_pfn passed to isolate_migratepages_block() can be outside the target zone.
> 
> Thanks,
> Rei
> .
> 

