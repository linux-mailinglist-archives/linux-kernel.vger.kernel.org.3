Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF794BAF51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiBRBxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:53:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiBRBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:53:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6558384
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:53:07 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0F6Q5hpQz9snD;
        Fri, 18 Feb 2022 09:51:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 09:53:05 +0800
Subject: Re: [PATCH v2 4/8] mm/memory-failure.c: fix race with changing page
 more robustly
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220216091431.39406-1-linmiaohe@huawei.com>
 <20220216091431.39406-5-linmiaohe@huawei.com>
 <20220218011351.GA2941369@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8a939237-50e2-090e-efe1-2eb04a68f6d1@huawei.com>
Date:   Fri, 18 Feb 2022 09:53:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220218011351.GA2941369@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2022/2/18 9:13, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Feb 16, 2022 at 05:14:27PM +0800, Miaohe Lin wrote:
>> We're only intended to deal with the non-Compound page after we split thp
>> in memory_failure. However, the page could have changed compound pages due
>> to race window. If this happens, we could try again to hopefully handle the
>> page next round. Also remove unneeded orig_head. It's always equal to the
>> hpage. So we can use hpage directly and remove this redundant one.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7e205d91b2d7..d66f642888be 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1690,7 +1690,6 @@ int memory_failure(unsigned long pfn, int flags)
>>  {
>>  	struct page *p;
>>  	struct page *hpage;
>> -	struct page *orig_head;
>>  	struct dev_pagemap *pgmap;
>>  	int res = 0;
>>  	unsigned long page_flags;
>> @@ -1736,7 +1735,7 @@ int memory_failure(unsigned long pfn, int flags)
>>  		goto unlock_mutex;
>>  	}
>>  
>> -	orig_head = hpage = compound_head(p);
>> +	hpage = compound_head(p);
>>  	num_poisoned_pages_inc();
>>  
>>  	/*
>> @@ -1817,13 +1816,18 @@ int memory_failure(unsigned long pfn, int flags)
>>  	lock_page(p);
>>  
>>  	/*
>> -	 * The page could have changed compound pages during the locking.
>> -	 * If this happens just bail out.
>> +	 * We're only intended to deal with the non-Compound page here.
>> +	 * However, the page could have changed compound pages due to
>> +	 * race window. If this happens, we could try again to hopefully
>> +	 * handle the page next round.
>>  	 */
>> -	if (PageCompound(p) && compound_head(p) != orig_head) {
>> -		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
>> -		res = -EBUSY;
>> -		goto unlock_page;
>> +	if (PageCompound(p)) {
>> +		if (TestClearPageHWPoison(p))
>> +			num_poisoned_pages_dec();
>> +		unlock_page(p);
>> +		put_page(p);
>> +		flags &= ~MF_COUNT_INCREASED;
> 
> Could you limit the retry chance only once by using the local variable
> "retry"?  It might be very rare to hit the race more than once in a single
> error event, but just to be safe from potential infinite loop (that could be
> opened by future changes).
> 

Sure. Will do it in V3. Thanks.

> Thanks,
> Naoya Horiguchi
> 
>> +		goto try_again;
>>  	}
>>  
>>  	/*
>> -- 
>> 2.23.0

