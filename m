Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7D4CF25D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiCGHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCGHEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:04:51 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73765A084
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:03:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V6QeAlb_1646636630;
Received: from 30.97.48.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6QeAlb_1646636630)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 15:03:51 +0800
Message-ID: <0e74a360-6a72-4edf-47bb-8358a3f1d883@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 15:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 14/16] mm/migration: fix potential invalid node access for
 reclaim-based migration
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ziy@nvidia.com, minchan@kernel.org, apopple@nvidia.com,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        almasrymina@google.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, mhocko@suse.com,
        riel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-15-linmiaohe@huawei.com>
 <aa367733-a1e7-10c7-6355-5ed9e502e4c9@linux.alibaba.com>
 <87ee3e5opu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87ee3e5opu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2022 1:14 PM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>>> If we failed to setup hotplug state callbacks for mm/demotion:online in
>>> some corner cases, node_demotion will be left uninitialized. Invalid node
>>> might be returned from the next_demotion_node() when doing reclaim-based
>>> migration. Use kcalloc to allocate node_demotion to fix the issue.
>>> Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes
>>> demotion")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    mm/migrate.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 279940c0c064..7b1c0b988234 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2516,9 +2516,9 @@ static int __init migrate_on_reclaim_init(void)
>>>    {
>>>    	int ret;
>>>    -	node_demotion = kmalloc_array(nr_node_ids,
>>> -				      sizeof(struct demotion_nodes),
>>> -				      GFP_KERNEL);
>>> +	node_demotion = kcalloc(nr_node_ids,
>>> +				sizeof(struct demotion_nodes),
>>> +				GFP_KERNEL);
>>
>> Nit: not sure if this is worthy of this rare corner case, but I think
>> the target demotion nodes' default value should be NUMA_NO_NODE
>> instead of 0.
> 
> The "nr" field of "struct demotion_nodes" should be initialized as 0.  I
> think that is checked before "nodes[]" field.

Right, but it will be confusing that if nr = 0, while the nodes[] still 
contains valid node id 0. While we are at this, why not initialize the 
node_demotion structure with a clear default value? Anyway, no strong 
opinion on this :)
