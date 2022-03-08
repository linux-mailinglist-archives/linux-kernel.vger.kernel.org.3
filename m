Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708D4D1692
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiCHLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346566AbiCHLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:47:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF025EB9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:47:02 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCYMm3qgFzbcCB;
        Tue,  8 Mar 2022 19:42:12 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:46:59 +0800
Subject: Re: [PATCH 14/16] mm/migration: fix potential invalid node access for
 reclaim-based migration
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-15-linmiaohe@huawei.com>
 <aa367733-a1e7-10c7-6355-5ed9e502e4c9@linux.alibaba.com>
 <87ee3e5opu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0e74a360-6a72-4edf-47bb-8358a3f1d883@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <64dc4cfa-96a9-f6a8-0575-223cc4c0f9d9@huawei.com>
Date:   Tue, 8 Mar 2022 19:46:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0e74a360-6a72-4edf-47bb-8358a3f1d883@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 15:04, Baolin Wang wrote:
> 
> 
> On 3/7/2022 1:14 PM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>>>> If we failed to setup hotplug state callbacks for mm/demotion:online in
>>>> some corner cases, node_demotion will be left uninitialized. Invalid node
>>>> might be returned from the next_demotion_node() when doing reclaim-based
>>>> migration. Use kcalloc to allocate node_demotion to fix the issue.
>>>> Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes
>>>> demotion")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>    mm/migrate.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 279940c0c064..7b1c0b988234 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2516,9 +2516,9 @@ static int __init migrate_on_reclaim_init(void)
>>>>    {
>>>>        int ret;
>>>>    -    node_demotion = kmalloc_array(nr_node_ids,
>>>> -                      sizeof(struct demotion_nodes),
>>>> -                      GFP_KERNEL);
>>>> +    node_demotion = kcalloc(nr_node_ids,
>>>> +                sizeof(struct demotion_nodes),
>>>> +                GFP_KERNEL);
>>>
>>> Nit: not sure if this is worthy of this rare corner case, but I think
>>> the target demotion nodes' default value should be NUMA_NO_NODE
>>> instead of 0.
>>
>> The "nr" field of "struct demotion_nodes" should be initialized as 0.  I
>> think that is checked before "nodes[]" field.
> 
> Right, but it will be confusing that if nr = 0, while the nodes[] still contains valid node id 0. While we are at this, why not initialize the node_demotion structure with a clear default value? Anyway, no strong opinion on this :)

IMO, this might not deserve initializing the node_demotion structure with a clear default value as
cpuhp_setup_state fails at init time should be a rare case.

Thanks both of you.

> .

