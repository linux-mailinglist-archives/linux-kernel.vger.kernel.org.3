Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AF50DB99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiDYIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiDYIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:50:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94928BF24
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:47:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmzCH37Jrzfb32;
        Mon, 25 Apr 2022 16:46:51 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 16:47:42 +0800
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <20220425010804.GA3746096@hori.linux.bs1.fc.nec.co.jp>
 <febd6309-b2a5-ef79-daa2-8000af09e291@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3ab987be-614a-4757-4124-26bb09d3f160@huawei.com>
Date:   Mon, 25 Apr 2022 16:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <febd6309-b2a5-ef79-daa2-8000af09e291@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/25 15:45, David Hildenbrand wrote:
> On 25.04.22 03:08, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Sun, Apr 24, 2022 at 05:11:03PM +0800, Miaohe Lin wrote:
>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>> page filled with random data is mapped into user address space.  In case
>>> of error, a special swap entry indicating swap read fails is set to the
>>> page table.  So the swapcache page can be freed and the user won't end up
>>> with a permanently mounted swap because a sector is bad.  And if the page
>>> is accessed later, the user process will be killed so that corrupted data
>>> is never consumed.  On the other hand, if the page is never accessed, the
>>> user won't even notice it.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> Hi Miaohe,
>>
>> This bug sounds relatively serious to me, and it seems old, so is it worth
>> sending to -stable?
> 
> I'm not sure if this is worth -stable, but no strong opinion.

I have no strong opinion too. I'm just afraid someone might run into it. But swapoff is
expected to be a rare operation anyway...

> 
> The do_swap_page() part was added in 2005:
> 
> commit b81074800b98ac50b64d4c8d34e8abf0fda5e3d1
> Author: Kirill Korotaev <dev@sw.ru>
> Date:   Mon May 16 21:53:50 2005 -0700
> 
>     [PATCH] do_swap_page() can map random data if swap read fails
>     
>     There is a bug in do_swap_page(): when swap page happens to be unreadable,
>     page filled with random data is mapped into user address space.  The fix is
>     to check for PageUptodate and send SIGBUS in case of error.
>     
>     Signed-Off-By: Kirill Korotaev <dev@sw.ru>
>     Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
>     Acked-by: Hugh Dickins <hugh@veritas.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> So the do_swap_page() part has been fixed for quite a while already.

Does this mean only do_swap_page maps random data if swap read fails is observed from that time on?
So this might not be worth -stable as it's never seen more than a decade?

Thanks!

>
