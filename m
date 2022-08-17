Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA8596718
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiHQCAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbiHQCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:00:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1382D6CD27
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:00:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6rjg0qlQzlW9P;
        Wed, 17 Aug 2022 09:56:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:59:58 +0800
Subject: Re: [PATCH 3/6] mm/hugetlb: fix missing call to
 restore_reserve_on_error()
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-4-linmiaohe@huawei.com> <YvwovBboCJBOJ1Wm@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <14198f4d-f9ff-8e36-d985-3719e365f913@huawei.com>
Date:   Wed, 17 Aug 2022 09:59:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YvwovBboCJBOJ1Wm@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/17 7:31, Mike Kravetz wrote:
> On 08/16/22 21:05, Miaohe Lin wrote:
>> When huge_add_to_page_cache() fails, the page is freed directly without
>> calling restore_reserve_on_error() to restore reserve for newly allocated
>> pages not in page cache. Fix this by calling restore_reserve_on_error()
>> when huge_add_to_page_cache fails.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ff991e5bdf1f..b69d7808f457 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5603,6 +5603,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>  		if (vma->vm_flags & VM_MAYSHARE) {
>>  			int err = huge_add_to_page_cache(page, mapping, idx);
>>  			if (err) {
>> +				restore_reserve_on_error(h, vma, haddr, page);
> 
> Hmmmm.  I was going to comment that restore_reserve_on_error would not handle
> the situation where 'err == -EEXIST' below.  This is because it implies we
> raced with someone else that added the page to the cache.  And, that other

Thanks for pointing this out.

> allocation, not this one, consumed the reservation.  However, I am not sure
> how that could be possible?  The hugetlb fault mutex (which we hold)
> must be held to add a page to the page cache.
> 
> Searching git history I see that code was added (or at least existed) before
> the hugetlb fault mutex was introduced.  So, I believe that check for -EEXIST
> and retry can go.

Agree with you. All call sites of huge_add_to_page_cache is protected by hugetlb fault mutex.

> 
> With that said, restore_reserve_on_error can be called here.  But, let's
> look into removing that err == -EEXIST check to avoid confusion.

Will do it in next version. Many thanks for your review and comment.

Thanks,
Miaohe Lin

