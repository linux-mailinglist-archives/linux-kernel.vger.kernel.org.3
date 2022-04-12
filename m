Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532724FDC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379979AbiDLKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357298AbiDLJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354741837B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:59:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kd03W5c8jzgYh5;
        Tue, 12 Apr 2022 16:57:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 16:59:13 +0800
Subject: Re: [PATCH 0/4] A few cleanup and fixup patches for migration
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
        <o451686892@gmail.com>, <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <e268117b314817ecd4c07ac48b0a6dcaf680ed69.camel@intel.com>
 <880376f0-f480-979b-261f-72cf9475474c@huawei.com>
 <e1356503b9d434ebedf209ad8a0038b8d2f99f20.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b773a90a-03d2-6c2e-852d-9a2ebbf301cb@huawei.com>
Date:   Tue, 12 Apr 2022 16:59:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e1356503b9d434ebedf209ad8a0038b8d2f99f20.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 14:33, ying.huang@intel.com wrote:
> On Tue, 2022-04-12 at 11:29 +0800, Miaohe Lin wrote:
>> On 2022/4/12 10:25, ying.huang@intel.com wrote:
>>> On Sat, 2022-04-09 at 15:38 +0800, Miaohe Lin wrote:
>>>> Hi everyone,
>>>> This series contains a few patches to remove unneeded lock page and
>>>> PageMovable check, reduce the rcu lock duration. Also we fix potential
>>>> pte_unmap on an not mapped pte. More details can be found in the
>>>> respective changelogs. Thanks!
>>>
>>> It appears that you ignored my comments for the previous version.  Can
>>> you check it?
>>
>> I do remember [1] and I tried to make isolate_huge_page consistent with isolate_lru_page.
>> But their return value conventions are different. isolate_huge_page return 0 when
>> success while isolate_huge_page returns true in this case. So make them consistent
>> would lead to many code change. I should have added this in my changelog.
> 
> If you found new problem, you can reply to the original email.  Just
> don't ignore the comments.

Sorry about it. I would take care of this next time. Thanks!

> 
> Best Regards,
> Huang, Ying
> 
>> Thanks.
>>
>> [1] https://lore.kernel.org/linux-mm/8735jsgctq.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>
>>
>>>
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> ---
>>>> v1:
>>>>   rebase [1] on mainline.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
>>>> ---
>>>> Miaohe Lin (4):
>>>>   mm/migration: reduce the rcu lock duration
>>>>   mm/migration: remove unneeded lock page and PageMovable check
>>>>   mm/migration: return errno when isolate_huge_page failed
>>>>   mm/migration: fix potential pte_unmap on an not mapped pte
>>>>
>>>>  include/linux/migrate.h |  2 +-
>>>>  include/linux/swapops.h |  4 ++--
>>>>  mm/filemap.c            | 10 +++++-----
>>>>  mm/hugetlb.c            |  2 +-
>>>>  mm/migrate.c            | 31 +++++++++++++------------------
>>>>  5 files changed, 22 insertions(+), 27 deletions(-)
>>>>
>>>
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 

