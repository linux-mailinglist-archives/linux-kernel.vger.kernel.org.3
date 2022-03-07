Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A344CFD9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiCGMFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiCGME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:04:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28116E280
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:04:02 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KBxsr1shRzdb05;
        Mon,  7 Mar 2022 20:02:40 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 20:04:00 +0800
Subject: Re: [PATCH 12/16] mm/migration: fix potential page refcounts leak in
 migrate_pages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <dave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-13-linmiaohe@huawei.com>
 <20f47ec9-3b5b-5326-b1c3-4b1a0c38ef46@linux.alibaba.com>
 <87mti25p98.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <6c65c8b7-9a62-c027-e2b9-7d1531e43dfa@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d0ff1de4-c6a3-d004-1d0f-86de999fe7c5@huawei.com>
Date:   Mon, 7 Mar 2022 20:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6c65c8b7-9a62-c027-e2b9-7d1531e43dfa@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/3/7 14:00, Baolin Wang wrote:
> 
> 
> On 3/7/2022 1:02 PM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> Hi Miaohe,
>>>
>>> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>>>> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
>>>> left in thp_split_pages list. We should move them back to migration
>>>> list so that they could be put back to the right list by the caller
>>>> otherwise the page refcnt will be leaked here. Also adjust nr_failed
>>>> and nr_thp_failed accordingly to make vm events account more accurate.
>>>> Fixes: b5bade978e9b ("mm: migrate: fix the return value of
>>>> migrate_pages()")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>    mm/migrate.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index e0db06927f02..6c2dfed2ddb8 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1422,6 +1422,15 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>                    }
>>>>                      nr_failed_pages += nr_subpages;
>>>> +                /*
>>>> +                 * There might be some subpages of fail-to-migrate THPs
>>>> +                 * left in thp_split_pages list. Move them back to migration
>>>> +                 * list so that they could be put back to the right list by
>>>> +                 * the caller otherwise the page refcnt will be leaked.
>>>> +                 */
>>>> +                list_splice_init(&thp_split_pages, from);
>>>> +                nr_failed += retry;
>>>> +                nr_thp_failed += thp_retry;
>>>
>>> Yes, I think we missed this case before, and your patch looks
>>> right. But we should also update the 'rc' to return the correct number
>>> of pages that were not migrated, right?
>>
>> Per my understanding, -ENOMEM should be returned to indicate an fatal
>> error.
>>
> 
> Ah, right. Sorry for noise.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Oh, I missed this email. So we should return -ENOMEM in this case. Many thanks for both of you.

> .

