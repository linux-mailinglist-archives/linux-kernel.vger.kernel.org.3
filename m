Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812684D1689
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbiCHLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbiCHLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:45:36 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B83BA7B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:44:24 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCYJk6pM3z1GC1w;
        Tue,  8 Mar 2022 19:39:34 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:44:21 +0800
Subject: Re: [PATCH 02/16] mm/migration: remove unneeded out label
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-3-linmiaohe@huawei.com>
 <877d967c4i.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4d2dca2b-8abc-a937-3397-dde6c247874d@huawei.com>
Date:   Tue, 8 Mar 2022 19:44:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <877d967c4i.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/3/7 10:03, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> We can do prep_transhuge_page when newpage is not NULL. Thus we can remove
>> out label to simplify the code.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 50bc62d85eaf..bc1867a5706c 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2025,12 +2025,9 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>>  
>>  	newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>>  				   HPAGE_PMD_ORDER);
>> -	if (!newpage)
>> -		goto out;
>> +	if (newpage)
>> +		prep_transhuge_page(newpage);
>>  
>> -	prep_transhuge_page(newpage);
>> -
>> -out:
>>  	return newpage;
>>  }
> 
> I don't think this change is necessary.  The original code is simple and
> follows the common practice for error processing.  The new code is OK,
> but it's unnecessary to change.
> 

IMO, this out label looks 'overkill'. We should remove it and make code more succinct.
Does this make sense to you? Thanks.

> Best Regards,
> Huang, Ying
> .
> 

