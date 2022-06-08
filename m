Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756254323E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiFHOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiFHOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:09:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854B1952E6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:09:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LJ8HL0qmrz8wsk;
        Wed,  8 Jun 2022 22:09:34 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 22:09:52 +0800
Subject: Re: [PATCH] mm/vmscan: don't try to reclaim freed folios
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220527080451.48549-1-linmiaohe@huawei.com>
 <YpDoAZtQtQf6U8D2@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f962cfb2-0e30-741a-0a56-e3e2558b69c5@huawei.com>
Date:   Wed, 8 Jun 2022 22:09:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YpDoAZtQtQf6U8D2@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/5/27 23:02, Matthew Wilcox wrote:
> On Fri, May 27, 2022 at 04:04:51PM +0800, Miaohe Lin wrote:
>> If folios were freed from under us, there's no need to reclaim them. Skip
>> these folios to save lots of cpu cycles and avoid possible unnecessary
>> disk IO.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f7d9a683e3a7..646dd1efad32 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1556,12 +1556,18 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  		folio = lru_to_folio(page_list);
>>  		list_del(&folio->lru);
>>  
>> +		nr_pages = folio_nr_pages(folio);
>> +		if (folio_ref_count(folio) == 1) {
>> +			/* folio was freed from under us. So we are done. */
>> +			WARN_ON(!folio_put_testzero(folio));
> 
> What?  No.  This can absolutely happen.  We have a refcount on the folio,
> which means that any other thread can temporarily raise the refcount,
> so this WARN_ON can trigger.  Also, we don't hold the folio locked,
> or an extra reference, so nr_pages is unstable because it can be split.

When I reread the code, I found caller holds an extra reference to the folio when
calling isolate_lru_pages(), so folio can't be split and thus nr_pages should be
stable indeed? Or am I miss something again?

Thanks!

> 
>> +			goto free_it;
>> +		}
>> +
>>  		if (!folio_trylock(folio))
>>  			goto keep;
>>  
>>  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>>  
>> -		nr_pages = folio_nr_pages(folio);
>>  
>>  		/* Account the number of base pages */
>>  		sc->nr_scanned += nr_pages;
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 

