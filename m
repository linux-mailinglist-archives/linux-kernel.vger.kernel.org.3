Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71C50673D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350178AbiDSI4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbiDSI4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:56:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8180220D5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:54:06 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjHbT6Y5vzFqSY;
        Tue, 19 Apr 2022 16:51:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:54:03 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:54:03 +0800
Message-ID: <477dcc83-4298-b7e4-3a6a-c8fa23b27d01@huawei.com>
Date:   Tue, 19 Apr 2022 16:54:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Peng Liu <liupeng256@huawei.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>, <yaozhenguo1@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <songmuchun@bytedance.com>,
        <liuyuntao10@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-2-liupeng256@huawei.com>
 <20220415020927.x7ylevbd5uaevfyt@offworld>
 <08896d0c-8821-000e-4cc2-9e64beda167f@huawei.com>
 <1407c3bb-89c4-ae11-7b09-d42115ab693e@huawei.com>
 <20220418214040.419a2e17254eb33f68f94b59@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220418214040.419a2e17254eb33f68f94b59@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/19 12:40, Andrew Morton wrote:
> On Sat, 16 Apr 2022 09:21:45 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> On 2022/4/15 13:41, Kefeng Wang wrote:
>>> On 2022/4/15 10:09, Davidlohr Bueso wrote:
>>>> On Wed, 13 Apr 2022, Peng Liu wrote:
>>>>
>>>>> Certain systems are designed to have sparse/discontiguous nodes. In
>>>>> this case, nr_online_nodes can not be used to walk through numa node.
>>>>> Also, a valid node may be greater than nr_online_nodes.
>>>>>
>>>>> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
>>>>> all the places that use nr_online_nodes, and repair them one by one.
>>>>>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of
>>>>> gigantic pages can't work")
>>>>> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages
>>>>> parameter to support node allocation")
>>>>> Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages
>>>>> parameter")
>>>>> Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue
>>>>> warnings")
>>>>> Signed-off-by: Peng Liu <liupeng256@huawei.com>
>>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>>>>
>>>> ... but
>>>>
>>>>> ---
>>>>> mm/hugetlb.c | 12 ++++++------
>>>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index b34f50156f7e..5b5a2a5a742f 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -2979,7 +2979,7 @@ int __alloc_bootmem_huge_page(struct hstate
>>>>> *h, int nid)
>>>>>      struct huge_bootmem_page *m = NULL; /* initialize for clang */
>>>>>      int nr_nodes, node;
>>>>>
>>>>> -    if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
>>>>> +    if (nid != NUMA_NO_NODE && !node_online(nid))
>>>> afaict null_blk could also use this, actually the whole thing wants a
>>>> helper - node_valid()?
>>>>
>>> This one should be unnecessary, and this patch looks has a bug,
>>>
>>> if a very nid passed to node_online(), it may crash,  could you
>>> re-check it,
>>>
>>> see my changes below,
>>>
>>> 1) add tmp check against MAX_NUMNODES before node_online() check,
>>>
>>>      and move it after get tmp in hugepages_setup() , this could cover
>>> both per-node alloc and normal alloc
>> sorry，for normal alloc, tmp is the number of huge pages, we don't  need
>> the movement,   only add tmp >= MAX_NUMNODES is ok
>>
> Does the v4 patch address the issues which were raised in this thread?
Yes， v4 has fix this.
>
>
> --- a/mm/hugetlb.c~hugetlb-fix-wrong-use-of-nr_online_nodes-v4
> +++ a/mm/hugetlb.c
> @@ -2986,8 +2986,6 @@ int __alloc_bootmem_huge_page(struct hst
>   	struct huge_bootmem_page *m = NULL; /* initialize for clang */
>   	int nr_nodes, node;
>   
> -	if (nid != NUMA_NO_NODE && !node_online(nid))
> -		return 0;
>   	/* do node specific alloc */
>   	if (nid != NUMA_NO_NODE) {
>   		m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
> @@ -4174,7 +4172,7 @@ static int __init hugepages_setup(char *
>   				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
>   				return 0;
>   			}
> -			if (!node_online(tmp))
> +			if (tmp >= MAX_NUMNODES || !node_online(tmp))
>   				goto invalid;
>   			node = array_index_nospec(tmp, MAX_NUMNODES);
>   			p += count + 1;
> _
>
> .
