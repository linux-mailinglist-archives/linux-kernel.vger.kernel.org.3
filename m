Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A325534862
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbiEZBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiEZBxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:53:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA161A76E7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:53:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7rXw1mvHzjX5h;
        Thu, 26 May 2022 09:52:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 09:53:15 +0800
Subject: Re: [PATCH v3 3/4] mm/migration: return errno when isolate_huge_page
 failed
To:     Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>, <peterx@redhat.com>,
        <apopple@nvidia.com>, <ying.huang@intel.com>, <david@redhat.com>,
        <songmuchun@bytedance.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220525081822.53547-1-linmiaohe@huawei.com>
 <20220525081822.53547-4-linmiaohe@huawei.com>
 <Yo3ry9rRDa5jznHC@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5ed70fbc-c582-6e85-22bc-3ccafa0d7a3f@huawei.com>
Date:   Thu, 26 May 2022 09:53:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yo3ry9rRDa5jznHC@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 16:41, Oscar Salvador wrote:
> On Wed, May 25, 2022 at 04:18:21PM +0800, Miaohe Lin wrote:
>> We might fail to isolate huge page due to e.g. the page is under migration
>> which cleared HPageMigratable. We should return errno in this case rather
>> than always return 1 which could confuse the user, i.e. the caller might
>> think all of the memory is migrated while the hugetlb page is left behind.
>> We make the prototype of isolate_huge_page consistent with isolate_lru_page
>> as suggested by Huang Ying and rename isolate_huge_page to isolate_hugetlb
>> as suggested by Muchun to improve the readability.
>>
>> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
>> Suggested-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Looks good to me, one thing below though:
> 
>> ---
>>  include/linux/hugetlb.h |  6 +++---
>>  mm/gup.c                |  2 +-
>>  mm/hugetlb.c            | 11 +++++------
>>  mm/memory-failure.c     |  2 +-
>>  mm/mempolicy.c          |  2 +-
>>  mm/migrate.c            |  5 +++--
>>  6 files changed, 14 insertions(+), 14 deletions(-)
>>
> ...
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1627,8 +1627,9 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>  
>>  	if (PageHuge(page)) {
>>  		if (PageHead(page)) {
>> -			isolate_huge_page(page, pagelist);
>> -			err = 1;
>> +			err = isolate_hugetlb(page, pagelist);
>> +			if (!err)
>> +				err = 1;
>>  		}
> 
> We used to always return 1 which means page has been queued for migration, as we
> did not check isolate_huge_page() return value.
> Now, we either return 1 or 0 depending on isolate_hugetlb(). 

Return 1 or -EBUSY just as normal page case.

> I guess that was fine because in the end, if isolate_huge_page() failed,
> the page just does not get added to 'pagelist', right? So, it is just
> confusing for the user because he might not get an error so he thinks
> the page will be migrated, and yet will not?

Yes, the hugetlb page might not be migrated due to error while it's not reported in the
__user *status. So the caller might think all of the memory is migrated and thus does
not retry to migrate the hugetlb page in the next round.

Many thanks for your review and comment! :)

> 
> 

