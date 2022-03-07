Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2084CF25F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiCGHIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiCGHIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:08:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B35F244
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:07:16 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KBqGn0dQZzBrc6;
        Mon,  7 Mar 2022 15:05:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 15:07:13 +0800
Subject: Re: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in
 split_huge_page_to_list
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-5-linmiaohe@huawei.com>
 <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2311bee4-cc11-93fc-6992-6c327a150e3d@huawei.com>
Date:   Mon, 7 Mar 2022 15:07:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/4 16:28, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Feb 28, 2022 at 10:02:45PM +0800, Miaohe Lin wrote:
>> The huge zero page could reach here and if we ever try to split it, the
>> VM_BUG_ON_PAGE will be triggered in split_huge_page_to_list(). Also the
>> non-lru compound movable pages could be taken for transhuge pages. Skip
>> these pages by checking PageLRU because huge zero page isn't lru page as
>> non-lru compound movable pages.
> 
> It seems that memory_failure() also fails at get_any_page() with "hwpoison:
> unhandlable page" message.
> 
>   [16478.203474] page:00000000b6acdbd1 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1810b4
>   [16478.206612] flags: 0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
>   [16478.209411] raw: 0057ffffc0801000 fffff11bc6042d08 fffff11bc6042d08 0000000000000000
>   [16478.211921] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>   [16478.214473] page dumped because: hwpoison: unhandlable page
>   [16478.216386] Memory failure: 0x1810b4: recovery action for unknown page: Ignored
> 
> We can't handle errors on huge (or normal) zero page, so the current

Sorry for confusing commit log again. I should have a coffee before I make this patch.
Huge or normal zero page will fail at get_any_page because they're neither HWPoisonHandlable
nor PageHuge.

> behavior seems to me more suitable than "unsplit thp".
> 
> Or if you have some producer to reach the following path with huge zero
> page, could you share it?
> 

What I mean is that non-lru movable compound page can reach here unexpected because __PageMovable(page)
is handleable now. So get_any_page could succeed to grab the page refcnt. And since it's compound page,
it will go through the split_huge_page_to_list because PageTransHuge checks PageHead(page) which can also
be true for compound page. But this type of pages is unexpected for split_huge_page_to_list.

Does this make sense for you? Thanks Naoya.

> Thanks,
> Naoya Horiguchi
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 23bfd809dc8c..ac6492e36978 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1792,6 +1792,20 @@ int memory_failure(unsigned long pfn, int flags)
>>  	}
>>  
>>  	if (PageTransHuge(hpage)) {
>> +		/*
>> +		 * The non-lru compound movable pages could be taken for
>> +		 * transhuge pages. Also huge zero page could reach here
>> +		 * and if we ever try to split it, the VM_BUG_ON_PAGE will
>> +		 * be triggered in split_huge_page_to_list(). Skip these
>> +		 * pages by checking PageLRU because huge zero page isn't
>> +		 * lru page as non-lru compound movable pages.
>> +		 */
>> +		if (!PageLRU(hpage)) {
>> +			put_page(p);
>> +			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>> +			res = -EBUSY;
>> +			goto unlock_mutex;
>> +		}
>>  		/*
>>  		 * The flag must be set after the refcount is bumped
>>  		 * otherwise it may race with THP split.
>> -- 
>> 2.23.0

