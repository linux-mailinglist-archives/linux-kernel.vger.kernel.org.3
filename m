Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6058651F2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiEIDfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiEID1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:27:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7C86AD5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:24:02 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxRMc6rLNzhZ0R;
        Mon,  9 May 2022 11:23:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 11:24:00 +0800
Subject: Re: [PATCH v2 3/4] mm/migration: return errno when isolate_huge_page
 failed
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>, <ying.huang@intel.com>, <hch@lst.de>,
        <dhowells@redhat.com>, <cl@linux.com>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-4-linmiaohe@huawei.com>
 <YmvNqWhC0uBwJ2yF@FVFYT0MHHV2J.usts.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <09ccdbac-c267-15de-0d81-57e211dea6d2@huawei.com>
Date:   Mon, 9 May 2022 11:23:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YmvNqWhC0uBwJ2yF@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/29 19:36, Muchun Song wrote:
> On Mon, Apr 25, 2022 at 09:27:22PM +0800, Miaohe Lin wrote:
>> We might fail to isolate huge page due to e.g. the page is under migration
>> which cleared HPageMigratable. So we should return -EBUSY in this case
>> rather than always return 1 which could confuse the user. Also we make
>> the prototype of isolate_huge_page consistent with isolate_lru_page to
>> improve the readability.
>>
>> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
>> Suggested-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/hugetlb.h |  6 +++---
>>  mm/gup.c                |  2 +-
>>  mm/hugetlb.c            | 11 +++++------
>>  mm/memory-failure.c     |  2 +-
>>  mm/mempolicy.c          |  2 +-
>>  mm/migrate.c            |  5 +++--
>>  6 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 04f0186b089b..306d6ef3fa22 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -170,7 +170,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>>  						vm_flags_t vm_flags);
>>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>>  						long freed);
>> -bool isolate_huge_page(struct page *page, struct list_head *list);
>> +int isolate_huge_page(struct page *page, struct list_head *list);
>>  int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
>>  int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
>>  void putback_active_hugepage(struct page *page);
>> @@ -376,9 +376,9 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
>>  	return NULL;
>>  }
>>  
>> -static inline bool isolate_huge_page(struct page *page, struct list_head *list)
>> +static inline int isolate_huge_page(struct page *page, struct list_head *list)
> 
> Since you already touched all the call sites, how about renaming this
> to hugetlb_isolate()? I've always felt that huge_page is not a
> straightforward and clear name since we also have another type of
> huge page (THP).  I think hugetlb is more specific.
> 

Sorry for late respond. This suggestion looks good to me. But is isolate_hugetlb more suitable?
This could make it more consistent with isolate_lru_page? What do you think?

Thanks!

> Thanks.
>  
> .
> 

