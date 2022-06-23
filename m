Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B1557A49
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiFWM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiFWM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:26:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65935DFC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:26:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTKCw652rzShK9;
        Thu, 23 Jun 2022 20:23:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 20:26:49 +0800
Subject: Re: [PATCH 14/16] mm/huge_memory: fix comment of page_deferred_list
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <willy@infradead.org>, <zokeefe@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-15-linmiaohe@huawei.com>
 <YrQVOcF4PirjGa/M@FVFYT0MHHV2J.usts.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0b1a1633-2e07-87df-b707-3058353f5609@huawei.com>
Date:   Thu, 23 Jun 2022 20:26:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrQVOcF4PirjGa/M@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/6/23 15:24, Muchun Song wrote:
> On Thu, Jun 23, 2022 at 01:06:25AM +0800, Miaohe Lin wrote:
>> The current comment is confusing because if global or memcg deferred list
>> in the second tail page is occupied by compound_head, why we still use
>> page[2].deferred_list here? I think it wants to say that Global or memcg
>> deferred list in the first tail page is occupied by compound_mapcount and
>> compound_pincount so we use the second tail page's deferred_list instead.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/huge_mm.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 12b297f9951d..2e8062b3417a 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -294,8 +294,8 @@ static inline bool thp_migration_supported(void)
>>  static inline struct list_head *page_deferred_list(struct page *page)
>>  {
>>  	/*
>> -	 * Global or memcg deferred list in the second tail pages is
>> -	 * occupied by compound_head.
>> +	 * Global or memcg deferred list in the first tail page is
>> +	 * occupied by compound_mapcount and compound_pincount.
>>  	 */
> 
> The structure of "struct page" seems to have told us the information that
> we resue the 2nd tail page to be used as deferred_list. I am not sure the

Yes, it does.

> value of those comments. Maybe better to remove them?

IMHO above comment tries to tell us why deferred list in the second tail page is used
instead of first tail page. But it should be fine to remove the above comments as they
don't seem to provide much info (thought I'm not really sure).

Thanks.

> 
> Thanks.
> 
>>  	return &page[2].deferred_list;
>>  }
>> -- 
>> 2.23.0
>>
>>
> .
> 

