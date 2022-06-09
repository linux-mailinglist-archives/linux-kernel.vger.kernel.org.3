Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7F5441BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiFIDEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIDEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:04:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7237DDB4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:04:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJTRP3qGZzjXNL;
        Thu,  9 Jun 2022 11:02:41 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:04:02 +0800
Subject: Re: [PATCH v2] mm/vmscan: don't try to reclaim freed folios
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220608141432.23258-1-linmiaohe@huawei.com>
 <YqDuu2KBofxl1s49@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e7178c73-9dbf-2d5f-735d-c23937fc9997@huawei.com>
Date:   Thu, 9 Jun 2022 11:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YqDuu2KBofxl1s49@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/9 2:47, Matthew Wilcox wrote:
> On Wed, Jun 08, 2022 at 10:14:32PM +0800, Miaohe Lin wrote:
>> If folios were freed from under us, there's no need to reclaim them. Skip
>> these folios to save lots of cpu cycles and avoid possible unnecessary
>> disk I/O.
> 
> Yes, but I asked how often this happened, and you said you didn't know.
> Do you have any data?  I'm reluctant to make a function which is over

This is just like the page_count == 1 case when doing page migration in unmap_and_move().

> 400 LOC already any longer.

I'm fine to resend this patch until your work is done (It will be really grateful if I
will be notified when that work is done).

Thanks!

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>> v2:
>>   use folio_ref_freeze to guard against race with GUP (fast). Many thanks
>>   Matthew for pointing this out.
>> ---
>>  mm/vmscan.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 13d34d9593bb..547ae7ae6ab1 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1610,13 +1610,19 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  		folio = lru_to_folio(page_list);
>>  		list_del(&folio->lru);
>>  
>> +		nr_pages = folio_nr_pages(folio);
>> +
>> +		if (folio_ref_count(folio) == 1 &&
>> +		    folio_ref_freeze(folio, 1)) {
>> +			/* folio was freed from under us. So we are done. */
>> +			goto free_it;
>> +		}
>> +
>>  		if (!folio_trylock(folio))
>>  			goto keep;
>>  
>>  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>>  
>> -		nr_pages = folio_nr_pages(folio);
>> -
>>  		/* Account the number of base pages */
>>  		sc->nr_scanned += nr_pages;
>>  
>> -- 
>> 2.23.0
>>
> 
> .
> 

