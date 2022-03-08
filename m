Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A774D1648
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbiCHLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiCHLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:30:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317733FD96
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:29:52 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCXzy4R46zbbnm;
        Tue,  8 Mar 2022 19:25:02 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:29:49 +0800
Subject: Re: [PATCH 03/16] mm/migration: remove unneeded local variable
 page_lru
To:     Alistair Popple <apopple@nvidia.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>,
        <ying.huang@intel.com>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-4-linmiaohe@huawei.com>
 <87wnh6rpms.fsf@nvdebian.thelocal>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6a1b2a5e-5b43-b45a-9092-1699cc3fc0c8@huawei.com>
Date:   Tue, 8 Mar 2022 19:29:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87wnh6rpms.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 2022/3/7 18:58, Alistair Popple wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> We can use page_is_file_lru() directly to help account the isolated
>> pages to simplify the code a bit as same as local variable follflags.
> 
> Looks good, but there are two independent changes here. Even though they are
> small they should probably be split into two patches.

Sounds reasonable. Will try to do this in v2. Thanks.

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index bc1867a5706c..da5a81052468 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1609,7 +1609,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>  {
>>  	struct vm_area_struct *vma;
>>  	struct page *page;
>> -	unsigned int follflags;
>>  	int err;
>>
>>  	mmap_read_lock(mm);
>> @@ -1619,8 +1618,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>  		goto out;
>>
>>  	/* FOLL_DUMP to ignore special (like zero) pages */
>> -	follflags = FOLL_GET | FOLL_DUMP;
>> -	page = follow_page(vma, addr, follflags);
>> +	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>>
>>  	err = PTR_ERR(page);
>>  	if (IS_ERR(page))
>> @@ -2033,7 +2031,6 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>>
>>  static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>  {
>> -	int page_lru;
>>  	int nr_pages = thp_nr_pages(page);
>>  	int order = compound_order(page);
>>
>> @@ -2060,8 +2057,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>  	if (isolate_lru_page(page))
>>  		return 0;
>>
>> -	page_lru = page_is_file_lru(page);
>> -	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
>> +	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
>>  			    nr_pages);
>>
>>  	/*

