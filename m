Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0D5A0D43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiHYJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiHYJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:50:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA9ACA10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:48:49 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MCykN4JL2z1N7Zs;
        Thu, 25 Aug 2022 17:45:16 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 17:48:47 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 17:48:47 +0800
Message-ID: <cb9c5a05-d97d-49ff-8a69-aed0f5e73f1e@huawei.com>
Date:   Thu, 25 Aug 2022 17:48:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] mm: slince possible data races about pgdat->kswapd
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>
References: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
 <20220824071909.192535-2-wangkefeng.wang@huawei.com>
 <e5223895-6319-1911-28bf-09449ded96c9@redhat.com>
 <fe06a35b-229f-c143-0200-33dbb315f0fe@huawei.com>
 <76d906e8-4c2b-0832-dc43-5fb49b5c6cc5@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <76d906e8-4c2b-0832-dc43-5fb49b5c6cc5@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2022/8/25 16:22, David Hildenbrand wrote:
> On 25.08.22 04:34, Kefeng Wang wrote:
>> On 2022/8/24 16:24, David Hildenbrand wrote:
>>> On 24.08.22 09:19, Kefeng Wang wrote:
>>>> The pgdat->kswapd could be accessed concurrently by kswapd_run() and
>>>> kcompactd(), it don't be protected by any lock, which could leads to
>>>> data races, adding READ/WRITE_ONCE() to slince it.
>>> Okay, I think this patch here makes it clearer that we really just want
>>> proper synchronization instead of hacking around it.
>>>
>>> What speaks against protecting pgdat->kswapd this using some proper
>>> locking primitive?
>> as comments about kswapd in struct pglist_data,  pgdat->kswapd should be
>>
>> protected by mem_hotplug_begin/done(), how about this way?
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 640fa76228dd..62018f35242a 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1983,7 +1983,13 @@ static inline bool is_via_compact_memory(int order)
>>
>>    static bool kswapd_is_running(pg_data_t *pgdat)
>>    {
>> -       return pgdat->kswapd && task_is_running(pgdat->kswapd);
>> +       bool running;
>> +
>> +       mem_hotplug_begin();
>> +       running = pgdat->kswapd && task_is_running(pgdat->kswapd);
>> +       mem_hotplug_end();
>> +
>> +       return running;
>>    }
> I'd much rather just use a dedicated lock that does not involve memory
> hotplug.

The issue only occurred due memory hotplug, without mem-hotplug,

the kswapd won't stop or re-run, there is no above issue too, add a new

lock would be duplicated, but the scope of protection is smaller, I could

repost with new lock if no more comment.

>
>
