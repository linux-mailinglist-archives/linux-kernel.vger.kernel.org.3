Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8C54C2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245326AbiFOHoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346795AbiFOHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:44:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD63FDA5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:44:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNHM54571z1K9tw;
        Wed, 15 Jun 2022 15:42:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:44:06 +0800
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
To:     Matthew Wilcox <willy@infradead.org>
CC:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
 <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
 <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
 <4a30f026-789a-9235-2fbd-f553e4d7b45d@huawei.com>
 <YqiJaOiGnUzzB1+W@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <40a07ce5-414a-a3b8-53ee-6c348635f03a@huawei.com>
Date:   Wed, 15 Jun 2022 15:44:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YqiJaOiGnUzzB1+W@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/6/14 21:13, Matthew Wilcox wrote:
> On Wed, Jun 08, 2022 at 08:17:35PM +0800, Miaohe Lin wrote:
>> +++ b/mm/page_alloc.c
>> @@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
>>                 set_page_count(page, 0);
>>
>>                 /*
>> -                * The first tail page stores compound_mapcount_ptr() and
>> -                * compound_order() and the second tail page stores
>> -                * compound_pincount_ptr(). Call prep_compound_head() after
>> -                * the first and second tail pages have been initialized to
>> -                * not have the data overwritten.
>> +                * The first tail page stores compound_mapcount_ptr(),
>> +                * compound_order() and compound_pincount_ptr(). Call
>> +                * prep_compound_head() after the first tail page have
>> +                * been initialized to not have the data overwritten.
>> +                *
>> +                * Note the idea to make this right after we initialize
>> +                * the offending tail pages is trying to take advantage
>> +                * of the likelihood of those tail struct pages being
>> +                * cached given that we will read them right after in
>> +                * prep_compound_head().
> 
> It's not that we'll read them again, it's that the cacheline will still
> be in cache, and therefore dirty.

Thanks for pointing this out.

> 
> Honestly, I don't think we need this extra explanation in a comment.
> Just change the first paragraph to reflect reality and leave it at that.

Will do it in next version if prep_compound_head is not moved outside loop.

> 
>>                  */
>> -               if (pfn == head_pfn + 2)
>> +               if (unlikely(pfn == head_pfn + 1))
> 
> We definitely don't need the unlikely here.

Could you please give me a more detailed explanation? IIUC, the above if condition
will only meet at a probability of 1/512. So unlikely tells the compiler to do some
optimization around it. Or am I miss something?

Thanks!

> 
>>                         prep_compound_head(head, order);
>>         }
>>  }
>>
>> Or am I miss something?
>>
>> Thanks!
>>
>>> .
>>>
>>
> 
> .
> 

