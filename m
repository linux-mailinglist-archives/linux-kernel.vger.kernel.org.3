Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5810E4FCCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbiDLDPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbiDLDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:15:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3431235
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:13:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KcrNK3DZXzgYK6;
        Tue, 12 Apr 2022 11:11:29 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 11:13:16 +0800
Subject: Re: [PATCH 3/4] mm/migration: return errno when isolate_huge_page
 failed
To:     Christoph Hellwig <hch@infradead.org>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>,
        <ying.huang@intel.com>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
        <o451686892@gmail.com>, <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-4-linmiaohe@huawei.com>
 <YlQ26kP8zpCLWqwW@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a7a0c2ea-30c3-4f76-8d76-6516e099fb13@huawei.com>
Date:   Tue, 12 Apr 2022 11:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YlQ26kP8zpCLWqwW@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 22:10, Christoph Hellwig wrote:
> On Sat, Apr 09, 2022 at 03:38:45PM +0800, Miaohe Lin wrote:
>> We might fail to isolate huge page due to e.g. the page is under migration
>> which cleared HPageMigratable. So we should return -EBUSY in this case
>> rather than always return 1 which could confuse the user.
>>
>> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 381963231a62..044656a14ae2 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1632,10 +1632,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>  		goto out_putpage;
>>  
>>  	if (PageHuge(page)) {
>> -		if (PageHead(page)) {
>> -			isolate_huge_page(page, pagelist);
>> -			err = 1;
>> -		}
>> +		if (PageHead(page))
>> +			err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;
> 
> I think a:
> 
> 			err = isolate_huge_page(page, pagelist);
> 			if (!err)
> 				err = 1;

Many thanks for your comment. IIUC, isolate_huge_page does not return the wanted error code. So the
above code won't do the right thing.

Thanks.

> 
> would be a lot more readable here.
> 
> .
> 

