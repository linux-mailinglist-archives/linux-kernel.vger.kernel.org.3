Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE84CFCEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiCGLch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbiCGLcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:32:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E720F68
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:26:25 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KBx2Q3vr3zdZkt;
        Mon,  7 Mar 2022 19:25:02 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 19:26:23 +0800
Subject: Re: [PATCH 2/4] mm/memory-failure.c: fix wrong user reference report
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-3-linmiaohe@huawei.com>
 <20220304082714.GB3778609@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <227af111-9264-02fd-9e46-744d39ecfed0@huawei.com>
Date:   Mon, 7 Mar 2022 19:26:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220304082714.GB3778609@hori.linux.bs1.fc.nec.co.jp>
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

On 2022/3/4 16:27, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Feb 28, 2022 at 10:02:43PM +0800, Miaohe Lin wrote:
>> The dirty swapcache page is still residing in the swap cache after it's
>> hwpoisoned. So there is always one extra refcount for swap cache.
> 
> The diff seems fine at a glance, but let me have a few question to
> understand the issue more.
> 
> - Is the behavior described above the effect of recent change on shmem where
>   dirty pagecache is pinned on hwpoison (commit a76054266661 ("mm: shmem:
>   don't truncate page if memory failure happens"). Or the older kernels
>   behave as the same?
> 
> - Is the behavior true for normal anonymous pages (not shmem pages)?
> 

The behavior described above is aimed at swapcache not pagecache. So it should be
irrelevant with the recent change on shmem.

What I try to fix here is that me_swapcache_dirty holds one extra pin via SwapCache
regardless of the return value of delete_from_lru_cache. We should try to report more
accurate extra refcount for debugging purpose.

> I'm trying to test hwpoison hitting the dirty swapcache, but it seems that
> in my testing memory_faliure() fails with "hwpoison: unhandlable page"

Maybe memory_faliure is racing with page reclaim where page is isolated?

> warning at get_any_page().  So I'm still not sure that me_pagecache_dirty()
> fixes any visible problem.

IIUC, me_pagecache_dirty can't do much except for the corresponding address_space supporting
error_remove_page which can truncate the dirty pagecache page. But this may cause silent data
loss. It's better to keep the page stay in the pagecache until the file is truncated, hole
punched or removed as commit a76054266661 pointed out.

Thanks.

> > Thanks,
> Naoya Horiguchi
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 0d7c58340a98..5f9503573263 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -984,7 +984,6 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
>>  static int me_swapcache_dirty(struct page_state *ps, struct page *p)
>>  {
>>  	int ret;
>> -	bool extra_pins = false;
>>  
>>  	ClearPageDirty(p);
>>  	/* Trigger EIO in shmem: */
>> @@ -993,10 +992,7 @@ static int me_swapcache_dirty(struct page_state *ps, struct page *p)
>>  	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
>>  	unlock_page(p);
>>  
>> -	if (ret == MF_DELAYED)
>> -		extra_pins = true;
>> -
>> -	if (has_extra_refcount(ps, p, extra_pins))
>> +	if (has_extra_refcount(ps, p, true))
>>  		ret = MF_FAILED;
>>  
>>  	return ret;
>> -- 
>> 2.23.0

