Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B685242E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiELCyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiELCyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:54:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064871F929D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:54:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzGYf0lt7zhZ20;
        Thu, 12 May 2022 10:53:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 10:54:05 +0800
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d7f24648-2af5-3998-d265-c441538ce5fc@huawei.com>
Date:   Thu, 12 May 2022 10:54:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/5/12 2:35, Mike Kravetz wrote:
> On 5/11/22 08:19, Naoya Horiguchi wrote:
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> If memory_failure() fails to grab page refcount on a hugetlb page
>> because it's busy, it returns without setting PG_hwpoison on it.
>> This not only loses a chance of error containment, but breaks the rule
>> that action_result() should be called only when memory_failure() do
>> any of handling work (even if that's just setting PG_hwpoison).
>> This inconsistency could harm code maintainability.
>>
>> So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.

I'm sorry but where is hugetlb_set_page_hwpoison() defined and used ? I can't find it.

>>
>> Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> ---
>>  include/linux/mm.h  | 1 +
>>  mm/memory-failure.c | 8 ++++----
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index d446e834a3e5..04de0c3e4f9f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3187,6 +3187,7 @@ enum mf_flags {
>>  	MF_MUST_KILL = 1 << 2,
>>  	MF_SOFT_OFFLINE = 1 << 3,
>>  	MF_UNPOISON = 1 << 4,
>> +	MF_NO_RETRY = 1 << 5,
>>  };
>>  extern int memory_failure(unsigned long pfn, int flags);
>>  extern void memory_failure_queue(unsigned long pfn, int flags);
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 6a28d020a4da..e3269b991016 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1526,7 +1526,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>  			count_increased = true;
>>  	} else {
>>  		ret = -EBUSY;
>> -		goto out;
>> +		if (!(flags & MF_NO_RETRY))
>> +			goto out;
>>  	}
> 
> Hi Naoya,
> 
> We are in the else block because !HPageFreed() and !HPageMigratable().
> IIUC, this likely means the page is isolated.  One common reason for isolation
> is migration.  So, the page could be isolated and on a list for migration.
> 
> I took a quick look at the hugetlb migration code and did not see any checks
> for PageHWPoison after a hugetlb page is isolated.  I could have missed
> something?  If there are no checks, we will read the PageHWPoison page
> in kernel mode while copying to the migration target.
> 
> Is this an issue?  Is is something we need to be concerned with?  Memory
> errors can happen at any time, and gracefully handling them is best effort.

It seems HWPoison hugetlb page will still be accessed before this patch. Can we do a
get_page_unless_zero first here to ensure that hugetlb page migration should fail due
to this extra page reference and thus not access the page content? If hugetlb page is
already freezed, corrupted memory will still be consumed though. :(

Thanks!

> 

