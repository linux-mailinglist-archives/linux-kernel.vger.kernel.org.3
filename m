Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59B94FBCE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbiDKNVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiDKNVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:21:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B731CF9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:19:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KcTvf40Bqz1HBL3;
        Mon, 11 Apr 2022 21:18:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 21:19:27 +0800
Subject: Re: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-2-linmiaohe@huawei.com>
 <20220411063520.GA3175313@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <792748d6-3b41-d118-27bd-75e79390ba1a@huawei.com>
Date:   Mon, 11 Apr 2022 21:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220411063520.GA3175313@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 14:35, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Apr 07, 2022 at 09:03:50PM +0800, Miaohe Lin wrote:
>> PageSwapCache is only reliable when PageAnon is true because PG_swapcache
>> serves as PG_owner_priv_1 which can be used by fs if it's pagecache page.
>> So we should test PageAnon to distinguish pagecache page from swapcache
>> page to avoid false-postive PageSwapCache test.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ef402b490663..2e97302d62e4 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2262,7 +2262,7 @@ static int __soft_offline_page(struct page *page)
>>  		return 0;
>>  	}
>>  
>> -	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>> +	if (!PageHuge(page) && PageLRU(page) && !PageAnon(page))
>>  		/*
>>  		 * Try to invalidate first. This should work for
>>  		 * non dirty unmapped page cache pages.
>> -- 
> 
> I foudn that with this change the following VM_BUG_ON_FOLIO() is triggered
> when calling soft-offline for a swapcache.  Maybe we need check both of
> PageAnon and PageSwapCache instead of either?
> 

Many thanks for your test! This is my overlook. Sorry about it! :( The root cause is that the page is
added into swapcache and lru( so that it can pass the HWPoisonHandlable check) but page anon is not
set yet due to page lock is held by __soft_offline_page. So we have the below core dump:

[   41.232172] page:0000000033d8a20c refcount:0 mapcount:0 mapping:00000000bc103d88 index:0x36d pfn:0x14359b
										^^^ page is not anon

[   41.236576] flags: 0x57ffffc0080415(locked|uptodate|lru|owner_priv_1|swapbacked|node=1|zone=2|lastcpupid=0x1fffff)
								^^^^^^^^^^^^^^^^^^ page is in swapcache

It seems we can check !PageAnon(page) && !PageSwapCache(page), as you suggested, to fix this issue. But maybe I
should drop this patch because invalidate_inode_page will always return 0 for PageAnon due to folio_mapping == NULL.
So nothing is really done for anonymous page here. And the origin !PageSwapCache(page) check should do the right work.
Or we shouldn't even try to call invalidate_inode_page with anonymous page in principle?

BTW: PageSwapCache should be reliable here as folio_test_swapbacked is checked implicitly inside it. In such case, PG_swapcache
can't serve as PG_owner_priv_1 as pagecache page shouldn't set PG_swapbacked (shmem will set PG_swapbacked but PG_owner_priv_1
is not used anyway). Or am I miss something again?

> Thanks,
> Naoya Horiguchi

Thanks a lot!

> 
> [   41.232172] page:0000000033d8a20c refcount:0 mapcount:0 mapping:00000000bc103d88 index:0x36d pfn:0x14359b
> [   41.234931] memcg:ffff8c2f84d72000
> [   41.235850] aops:swap_aops
> [   41.236576] flags: 0x57ffffc0080415(locked|uptodate|lru|owner_priv_1|swapbacked|node=1|zone=2|lastcpupid=0x1fffff)
> [   41.239221] raw: 0057ffffc0080415 ffffef2c050eda48 ffffef2c050dbe08 0000000000000000
> [   41.241216] raw: 000000000000036d 000000000000036e 00000000ffffffff ffff8c2f84d72000
> [   41.243184] page dumped because: VM_BUG_ON_FOLIO(folio_test_lru(folio))
> [   41.244872] ------------[ cut here ]------------
> [   41.246074] kernel BUG at mm/memcontrol.c:7062!
> [   41.247248] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   41.248539] CPU: 5 PID: 1036 Comm: bash Tainted: G            E     5.18.0-rc1-v5.18-rc1-220408-2310-012-gf501f+ #11
> [   41.251844] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
> [   41.254087] RIP: 0010:mem_cgroup_swapout+0x181/0x2c0
> [   41.255399] Code: 03 0f 85 37 01 00 00 65 48 ff 08 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8b a3 e0 ff 48 c7 c6 88 b7 5a aa e8 3f 26 f7 ff <0f> 0b 48 c7 c6 d0 ec 5a aa e8 31 26 f7 ff 0f 0b 66 90 8b 45 5c 48
> [   41.260408] RSP: 0018:ffffa9340218fce0 EFLAGS: 00010082
> [   41.261780] RAX: 000000000000003b RBX: ffff8c2fc180a000 RCX: 0000000000000000
> [   41.263604] RDX: 0000000000000002 RSI: ffffffffaa599561 RDI: 00000000ffffffff
> [   41.265435] RBP: ffffef2c050d66c0 R08: 0000000000000000 R09: 00000000ffffdfff
> [   41.267266] R10: ffffa9340218fad0 R11: ffffffffaa940d08 R12: 000000000000036e
> [   41.269094] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8c2fc180a008
> [   41.270911] FS:  00007f00259d3740(0000) GS:ffff8c30bbc80000(0000) knlGS:0000000000000000
> [   41.272975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.274422] CR2: 0000561d1325a973 CR3: 00000001452c2001 CR4: 0000000000170ee0
> [   41.276253] Call Trace:
> [   41.277013]  <TASK>
> [   41.277561]  __remove_mapping+0xce/0x300
> [   41.278604]  remove_mapping+0x12/0xe0
> [   41.279571]  soft_offline_page+0x834/0x8b0
> [   41.280972]  soft_offline_page_store+0x43/0x70
> [   41.282171]  kernfs_fop_write_iter+0x11c/0x1b0
> [   41.283292]  new_sync_write+0xf9/0x160
> [   41.284310]  vfs_write+0x209/0x290
> [   41.285174]  ksys_write+0x4f/0xc0
> [   41.286049]  do_syscall_64+0x3b/0x90
> [   41.286991]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   41.288328] RIP: 0033:0x7f00257018b7
> [   41.289232] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [   41.294001] RSP: 002b:00007fff3dc50748 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   41.295937] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f00257018b7
> [   41.297767] RDX: 000000000000000c RSI: 0000561d1325a970 RDI: 0000000000000001
> [   41.299600] RBP: 0000561d1325a970 R08: 0000000000000000 R09: 00007f00257b64e0
> [   41.301418] R10: 00007f00257b63e0 R11: 0000000000000246 R12: 000000000000000c
> [   41.303305] R13: 00007f00257fb5a0 R14: 000000000000000c R15: 00007f00257fb7a0
> [   41.305179]  </TASK>
> 

