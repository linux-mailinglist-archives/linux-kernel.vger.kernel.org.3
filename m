Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630204CFF09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiCGMpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242477AbiCGMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:45:43 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E83BA6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:44:48 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KByhv6tWfzbbq5;
        Mon,  7 Mar 2022 20:39:59 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 20:44:45 +0800
Subject: Re: [PATCH 10/16] mm/migration: remove PG_writeback handle in
 folio_migrate_flags
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-11-linmiaohe@huawei.com>
 <20220306172121.50d00e8b328a6bd1dea91ee7@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <536b80dc-a37a-a5dd-fd9c-a1240dac3286@huawei.com>
Date:   Mon, 7 Mar 2022 20:44:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220306172121.50d00e8b328a6bd1dea91ee7@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/3/7 9:21, Andrew Morton wrote:
> On Fri, 4 Mar 2022 17:34:03 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> When newfolio reaches here, it's guaranteed that PG_writeback is not set
>> because caller ensures writeback must have been completed. Remove this
>> unneeded check and cleanup the relevant comment.
> 
> What guarantees that writeback cannot start after the caller has checked?

Drivers should set writeback flag under page lock. But I'am not sure this is always obeyed.

> 
> I see no such check in iomap_migrate_page()?

iomap_migrate_page acts as a migratepage callback. The check is actually done in __unmap_and_move.

> 
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -549,18 +549,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>>  	if (!folio_test_hugetlb(folio))
>>  		folio->private = NULL;
>>  
>> -	/*
>> -	 * If any waiters have accumulated on the new page then
>> -	 * wake them up.
>> -	 */
>> -	if (folio_test_writeback(newfolio))
>> -		folio_end_writeback(newfolio);

IIUC, this should also be broken too. If a page can be flagged writeback under page lock,
we can't simply do folio_end_writeback here as page might still be under the use of drivers.
More works should be done to handle the case correctly.

>> -
>> -	/*
>> -	 * PG_readahead shares the same bit with PG_reclaim.  The above
>> -	 * end_page_writeback() may clear PG_readahead mistakenly, so set the
>> -	 * bit after that.
>> -	 */
>>  	if (folio_test_readahead(folio))
>>  		folio_set_readahead(newfolio);
>>  
> 
> folio_migrate_flags() and folio_migrate_copy() are global,
> export-to-modules functions but have no interface documentation.  That
> was bad of us.  
> 
> I wonder why those two functions are exported to modules anyway.

That's really a pity.

> .
> 

Many thanks for your comment and reply!
