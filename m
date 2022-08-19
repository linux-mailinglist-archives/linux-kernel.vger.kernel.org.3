Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6481599632
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbiHSHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbiHSHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:32:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8FE3C09
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:32:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8D0K2jjJzlWNN;
        Fri, 19 Aug 2022 15:29:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:32:27 +0800
Subject: Re: [PATCH 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-5-linmiaohe@huawei.com>
 <20220819052324.GD613144@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6dff6aec-833c-a3db-1180-09e395f6265a@huawei.com>
Date:   Fri, 19 Aug 2022 15:32:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220819052324.GD613144@hori.linux.bs1.fc.nec.co.jp>
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

On 2022/8/19 13:23, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Aug 18, 2022 at 09:00:14PM +0800, Miaohe Lin wrote:
>> After kill_procs(), tk will be freed without being removed from the to_kill
>> list. In the next iteration, the freed list entry in the to_kill list will
>> be accessed, thus leading to use-after-free issue.
> 
> kill_procs() runs over the to_kill list and frees all listed items in each
> iteration.  So just after returning from unmap_and_kill(), to_kill->next and
> to_kill->prev still point to the addresses of struct to_kill which was the
> first or last item (already freed!).  This is bad-manered, but
> collect_procs_fsdax() in the next iteration calls list_add_tail() and
> overwrites the dangling pointers with newly allocated item.  So this problem

list_add_tail will do WRITE_ONCE(prev->next, new) where prev is already freed!
Or am I miss something?

> should not be so critical?  Anyway, I agree with fixing this fragile code.
> 
>> Fix it by reinitializing
>> the to_kill list after unmap_and_kill().
>>
>> Fixes: c36e20249571 ("mm: introduce mf_dax_kill_procs() for fsdax case")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
>> ---
>>  mm/memory-failure.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7023c3d81273..a2f4e8b00a26 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1658,6 +1658,8 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>  		collect_procs_fsdax(page, mapping, index, &to_kill);
>>  		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
>>  				index, mf_flags);
>> +		/* Reinitialize to_kill list for later resuing. */
> 
> s/resuing/reusing/ ?

OK.

> 
>> +		INIT_LIST_HEAD(&to_kill);
> 
> How about adding list_del() in kill_procs()?  Other callers now use
> to_kill only once, but fixing generally looks tidier to me.

That's a good idea. Will do it in v2. Many thanks for your review, Naoya!

Thanks,
Miaohe Lin

> 
> Thanks,
> Naoya Horiguchi
> 

