Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F24D105B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiCHGfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCHGfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:35:17 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA53CA5C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:34:20 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCQQz1CQ7z1GCHB;
        Tue,  8 Mar 2022 14:29:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 14:34:17 +0800
Subject: Re: [PATCH 13/16] mm/migration: return errno when isolate_huge_page
 failed
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-14-linmiaohe@huawei.com>
 <c84c1a0a-66aa-915f-87d2-013ff0ac343c@linux.alibaba.com>
 <c6b117ba-948a-7f84-58f4-f0e3c5bd0a9c@huawei.com>
 <3d286f44-e91d-b68d-63f2-e66529e3fa54@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <257f4e4b-aaab-824c-9a68-6dc88d7f988f@huawei.com>
Date:   Tue, 8 Mar 2022 14:34:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3d286f44-e91d-b68d-63f2-e66529e3fa54@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/8 9:32, Baolin Wang wrote:
> 
> 
> On 3/7/2022 8:20 PM, Miaohe Lin wrote:
>> On 2022/3/7 10:14, Baolin Wang wrote:
>>> Hi Miaohe,
>>>
>>> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>>>> We should return errno (-EBUSY here) when failed to isolate the huge page
>>>> rather than always return 1 which could confuse the user.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>    mm/migrate.c | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 6c2dfed2ddb8..279940c0c064 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1618,10 +1618,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>>            goto out_putpage;
>>>>          if (PageHuge(page)) {
>>>> -        if (PageHead(page)) {
>>>> -            isolate_huge_page(page, pagelist);
>>>> -            err = 1;
>>>> -        }
>>>> +        if (PageHead(page))
>>>> +            err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;
>>>
>>> Could you elaborate on which case the huge page isolation can be failed in this case? Or you met a real problem? Cause now we've got this head huge page refcnt, I can not see why we'll fail to isolate this huge page.
>>
>> IIUC, this could happen when hugepage is under migration which cleared HPageMigratable. Page refcnt cannot
>> prevent isolate_huge_page from happening. Or am I miss something?
> 
> Yes, that's possible. Thanks for your explanation. It will be better if you can copy the possible scenario description to the commit log to help other understand the issue.
> 

Sounds reasonable. Will do. Many thanks for review.

> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> .

