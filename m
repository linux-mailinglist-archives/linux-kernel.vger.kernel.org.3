Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC547CAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhLVBtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:49:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33889 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhLVBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:49:21 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJbpJ2yPnzcc6C;
        Wed, 22 Dec 2021 09:48:56 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 09:49:19 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 09:49:18 +0800
Subject: Re: [PATCH -next] mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20211221074908.3910286-1-liushixin2@huawei.com>
 <20211222003751.GA1529256@u2004>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <d0e572ee-0e32-371d-3f5b-7afdeb4013e4@huawei.com>
Date:   Wed, 22 Dec 2021 09:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211222003751.GA1529256@u2004>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/22 8:37, Naoya Horiguchi wrote:
> On Tue, Dec 21, 2021 at 03:49:08PM +0800, Liu Shixin wrote:
>> Hulk Robot reported a panic in put_page_testzero() when testing madvise()
>> with MADV_SOFT_OFFLINE. The BUG() is triggered when retrying get_any_page().
>> This is because we keep MF_COUNT_INCREASED flag in second try but the refcnt
>> is not increased.
> Hi Shixin, 
>
> Thanks you for the report.
>
> I'm not still sure about the logic behind the bug.
> madvise(MADV_SOFT_OFFLINE) should not work on free pages because
> madvise_inject_error() pins the target page with get_user_pages_fast()
> (MF_COUNT_INCREASED means refcount is incremented by the caller).
> The retry logic can be called when soft_offline_free_page() fails, so
> the logic assumes that the target page is a free page.  So why does
> clearing MF_COUNT_INCREASED affect and solve the issue?
>
> It seems to me that if soft_offline_page() is called on a free page
> with MF_COUNT_INCREASED set, then it's problematic itself.
>
> Thanks,
> Naoya Horiguchi

The page is not free when soft_offline_page() is called. In get_any_page(),
if MF_COUNT_INCREASED is set and !HWPoisonHandlable(page), put_page()
will be called firstly and then goto try_again. The page is freed in this period.

Thanks,
Liu Shixin
>>  page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>>  ------------[ cut here ]------------
>>  kernel BUG at include/linux/mm.h:737!
>>  invalid opcode: 0000 [#1] PREEMPT SMP
>>  CPU: 5 PID: 2135 Comm: sshd Tainted: G    B             5.16.0-rc6-dirty #373
>>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>>  RIP: 0010:release_pages+0x53f/0x840
>>  Code: 0c 01 4c 8d 60 ff e9 5b fb ff ff 48 c7 c6 d8 97 0c b3 4c 89 e7 48 83 05 0e 7b 3c 0c 01 e8 89 3d 04 00 48 83 05 11 7b 3c 0c 01 <0f> 0b 48 83 05 0f 7b 3c 0c 01 48 83 05 0f 7b 3c 0c 01 48 83 05f
>>  RSP: 0018:ffffc900015a7bc0 EFLAGS: 00010002
>>  RAX: 000000000000003e RBX: ffffffffbace04c8 RCX: 0000000000000002
>>  RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
>>  RBP: ffff88817b9acd50 R08: 0000000000000000 R09: c0000000ffefffff
>>  R10: 0000000000000001 R11: ffffc900015a79b0 R12: ffffea0005e1c900
>>  R13: ffffea0005e1de88 R14: 000000000000001f R15: ffff888100071000
>>  FS:  0000000000000000(0000) GS:ffff88842fb40000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 00007f305e8de3d4 CR3: 000000017bb6f000 CR4: 00000000000006e0
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>  Call Trace:
>>   <TASK>
>>   free_pages_and_swap_cache+0x64/0x80
>>   tlb_flush_mmu+0x6f/0x220
>>   unmap_page_range+0xe6c/0x12c0
>>   unmap_single_vma+0x90/0x170
>>   unmap_vmas+0xc4/0x180
>>   exit_mmap+0xde/0x3a0
>>   mmput+0xa3/0x250
>>   do_exit+0x564/0x1470
>>   do_group_exit+0x3b/0x100
>>   __do_sys_exit_group+0x13/0x20
>>   __x64_sys_exit_group+0x16/0x20
>>   do_syscall_64+0x34/0x80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>  RIP: 0033:0x7f30625401d9
>>  Code: Unable to access opcode bytes at RIP 0x7f30625401af.
>>  RSP: 002b:00007ffe391b0c88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f30625401d9
>>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
>>  RBP: 00007f306283d838 R08: 000000000000003c R09: 00000000000000e7
>>  R10: fffffffffffffe30 R11: 0000000000000246 R12: 00007f306283d838
>>  R13: 00007f3062842e80 R14: 0000000000000000 R15: ffffaa4fb7932430
>>   </TASK>
>>  Modules linked in:
>>  ---[ end trace e99579b570fe0649 ]---
>>  RIP: 0010:release_pages+0x53f/0x840
>>  Code: 0c 01 4c 8d 60 ff e9 5b fb ff ff 48 c7 c6 d8 97 0c b3 4c 89 e7 48 83 05 0e 7b 3c 0c 01 e8 89 3d 04 00 48 83 05 11 7b 3c 0c 01 <0f> 0b 48 83 05 0f 7b 3c 0c 01 48 83 05 0f 7b 3c 0c 01 48 83 05f
>>  RSP: 0018:ffffc900015a7bc0 EFLAGS: 00010002
>>  RAX: 000000000000003e RBX: ffffffffbace04c8 RCX: 0000000000000002
>>  RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
>>  RBP: ffff88817b9acd50 R08: 0000000000000000 R09: c0000000ffefffff
>>  R10: 0000000000000001 R11: ffffc900015a79b0 R12: ffffea0005e1c900
>>  R13: ffffea0005e1de88 R14: 000000000000001f R15: ffff888100071000
>>  FS:  0000000000000000(0000) GS:ffff88842fb40000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 00007f305e8de3d4 CR3: 000000017bb6f000 CR4: 00000000000006e0
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>
>> Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  mm/memory-failure.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 68d9a35f8908..160526f83bcb 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2288,6 +2288,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>>  	} else if (ret == 0) {
>>  		if (soft_offline_free_page(page) && try_again) {
>>  			try_again = false;
>> +			flags &= ~MF_COUNT_INCREASED;
>>  			goto retry;
>>  		}
>>  	}
>> -- 
>> 2.25.1
>>
> .
>

