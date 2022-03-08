Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736584D1668
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbiCHLnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbiCHLmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:42:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BA2BB0D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:41:57 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCYKs57bQzdZMk;
        Tue,  8 Mar 2022 19:40:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:41:54 +0800
Subject: Re: [PATCH 01/16] mm/migration: remove unneeded local variable
 mapping_locked
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-2-linmiaohe@huawei.com>
 <87bkyi7c8f.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8683f5cb-ccd3-ce92-77e0-e0117f405e79@huawei.com>
Date:   Tue, 8 Mar 2022 19:41:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87bkyi7c8f.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
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

On 2022/3/7 10:00, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> When mapping_locked is true, TTU_RMAP_LOCKED is always set to ttu. We can
>> check ttu instead so mapping_locked can be removed. And ttu is either 0
>> or TTU_RMAP_LOCKED now. Change '|=' to '=' to reflect this.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 42e3a944f35c..50bc62d85eaf 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1230,7 +1230,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>>  		goto put_anon;
>>  
>>  	if (page_mapped(hpage)) {
>> -		bool mapping_locked = false;
>>  		enum ttu_flags ttu = 0;
>>  
>>  		if (!PageAnon(hpage)) {
>> @@ -1244,14 +1243,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>>  			if (unlikely(!mapping))
>>  				goto unlock_put_anon;
>>  
>> -			mapping_locked = true;
>> -			ttu |= TTU_RMAP_LOCKED;
>> +			ttu = TTU_RMAP_LOCKED;
>>  		}
>>  
>>  		try_to_migrate(src, ttu);
>>  		page_was_mapped = 1;
>>  
>> -		if (mapping_locked)
>> +		if (ttu & TTU_RMAP_LOCKED)
>>  			i_mmap_unlock_write(mapping);
>>  	}
> 
> I think this is a code style issue.  The original code looks more
> readable for me.
> 

I think "ttu |= TTU_RMAP_LOCKED;" is the product of the code changing.
And (ttu & TTU_RMAP_LOCKED) can do the right thing as mapping_locked
while removing the page_was_mapped. But if you insist on this, I will
drop this patch.

Thanks.

> Best Regards,
> Huang, Ying
> 
> .
> 

