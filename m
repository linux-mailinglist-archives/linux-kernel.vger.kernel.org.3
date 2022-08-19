Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF29599633
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbiHSHhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346845AbiHSHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:37:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F84CCD6A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:37:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M8D721sdPznTWm;
        Fri, 19 Aug 2022 15:35:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:37:23 +0800
Subject: Re: [PATCH 5/6] mm, hwpoison: kill procs if unmap fails
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-6-linmiaohe@huawei.com>
 <20220819052431.GE613144@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3043d61b-468b-58a3-b6b8-081f4663fbac@huawei.com>
Date:   Fri, 19 Aug 2022 15:37:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220819052431.GE613144@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/8/19 13:24, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Aug 18, 2022 at 09:00:15PM +0800, Miaohe Lin wrote:
>> If try_to_unmap() fails, the hwpoisoned page still resides in the address
>> space of some processes. We should kill these processes or the hwpoisoned
>> page might be consumed later. collect_procs() is always called to collect
>> relevant processes now so they can be killed later if unmap fails.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a2f4e8b00a26..5f9615a86296 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1396,7 +1396,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>>  	struct address_space *mapping;
>>  	LIST_HEAD(tokill);
>>  	bool unmap_success;
>> -	int kill = 1, forcekill;
>> +	int forcekill;
>>  	bool mlocked = PageMlocked(hpage);
>>  
>>  	/*
>> @@ -1437,7 +1437,6 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>>  		if (page_mkclean(hpage)) {
>>  			SetPageDirty(hpage);
>>  		} else {
>> -			kill = 0;
>>  			ttu |= TTU_IGNORE_HWPOISON;
>>  			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
>>  				pfn);
>> @@ -1452,8 +1451,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>>  	 * Error handling: We ignore errors here because
>>  	 * there's nothing that can be done.
> 
> This above comment might be deprecated now (I'm not sure what this really mean),
> so could you drop or update this?

Do you mean remove the below comment? In fact, this doesn't make much sense for me.

* Error handling: We ignore errors here because
* there's nothing that can be done.

> 
> Anyway, the patch looks good to me.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Many thanks for review.

Thanks,
Miaohe Lin

