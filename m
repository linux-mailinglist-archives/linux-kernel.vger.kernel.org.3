Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863E46C279
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhLGSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLGSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:15:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2E5C061574;
        Tue,  7 Dec 2021 10:11:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v11so31211929wrw.10;
        Tue, 07 Dec 2021 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mLgmJfZfsD7Y6jqLNl6vCPgUHV3Pi9HYDoh3ZpyTDjQ=;
        b=ZNSrx1hGqJFSde+godU0XYptdO9xeA4jrd9lW7ueKKon6da+0es93WO8HVD+A3+VFu
         LGSCKYAjQsA/ai/l8KSvMswLoO+doM4L2Opv1srxKzV1nFcFy9XB5iBwSnRA2MygfMmV
         8TS59BeqXOfY0cbZBK9v8J7NZzqBP+hJiaO+HAwF1Hd2iOITptFXjPQ0hYA5DCAWVFdV
         v2k1h/FFKm3p2LjTMYuD1hi2R/kM1ddKLLRdw48XR4UefyqAWn+5ZXPyM1rxHV0NPkPO
         407fOw9Kbyy18tubc2NwBdi+ccclakt2FSsgD7hhQNb4wcF7WHQZ2SYOBc2seN7c4v7+
         YgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mLgmJfZfsD7Y6jqLNl6vCPgUHV3Pi9HYDoh3ZpyTDjQ=;
        b=MeM9bmRQspVNRi+BL3heqIvzZqc9k0b41/CknTOjJCZ/IHpwK41WiC27dotsJLlFP4
         Xp1FTLzbp2uYBuCpq2e17XK3qTZKmERtaaqWo2WAE0du8LLWZvFJmbxFTzejxiFgtqU5
         /2HngM4XO1TesvXz2NvW6YKeqJGNTU7hwe3irA3X5YxV6PNMVcBRWmTt2Gp/yctFt2O7
         b6c0cweitfzSIR5LGQefmlccASR983/Px2SSlt5+aYP97WfRqKfzZ3jGApTp61W9DfGP
         MVtmfzGZ4Su1lQXop4JjF3uzyriX4KTCnbPqHCQN5gZ49dXqUy9uBuG8y8qv4Prmwunk
         iwBw==
X-Gm-Message-State: AOAM531qEytK2fDdWW/MnwU9le7An8BddSm+EI8Jg1/nlhwNmUwCbVvz
        xDg3xEsC8zOPEzUymZbVz0xhSY0wLcY=
X-Google-Smtp-Source: ABdhPJwbCSeT5FuELH8aJP52x6MLtDnhIOtZzAbmYmQfLQScRPz3E47g3C60gMjMwvvj3ZjCIkFawg==
X-Received: by 2002:a5d:5272:: with SMTP id l18mr52864596wrc.208.1638900716658;
        Tue, 07 Dec 2021 10:11:56 -0800 (PST)
Received: from [192.168.8.198] ([148.252.132.245])
        by smtp.gmail.com with ESMTPSA id b10sm419398wrt.36.2021.12.07.10.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:11:56 -0800 (PST)
Message-ID: <bf45770f-6be9-45dd-46d8-cbf68a3945e0@gmail.com>
Date:   Tue, 7 Dec 2021 18:11:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] Revert "block: add single bio async direct IO helper"
 to avoid UAF
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
 <95ea9142-9f36-981d-a04d-3efded544af7@gmail.com>
 <a3e6455c-b3a3-d98c-cda7-f05f686bd036@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <a3e6455c-b3a3-d98c-cda7-f05f686bd036@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 18:09, George Kennedy wrote:
> On 12/7/2021 12:36 PM, Pavel Begunkov wrote:
>> On 12/7/21 15:51, George Kennedy wrote:
>>> git bisect shows that commit 54a88eb838d3
>>> ("block: add single bio async direct IO helper")
>>> causes the following UAF: KASAN: use-after-free Write in io_submit_one
>>>
>>> Tried to root-cause the issue, but need the patch submitter's help in
>>> coming up with a fix.
>>
>> Hey George, thanks for the report. Do you have a reproducer?
> 
> Hi Pavel,
> 
> Forgot to include it in the cover letter. Straight from Syzkaller:

Perfect, thanks! Confirmed what I thought about is a problem, though
the diff is buggy. Will take care of it


> #ifdef REF
> Syzkaller hit 'KASAN: use-after-free Write in io_submit_one' bug.
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> BUG: KASAN: use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:167 [inline]
> BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
> BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
> BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
> BUG: KASAN: use-after-free in iocb_put fs/aio.c:1161 [inline]
> BUG: KASAN: use-after-free in io_submit_one+0x496/0x2fe0 fs/aio.c:1882
> Write of size 4 at addr ffff888027c338a0 by task syz-executor873/15100
> 
> CPU: 2 PID: 15100 Comm: syz-executor873 Not tainted 5.16.0-rc1-syzk #1
> Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x89/0xb5 lib/dump_stack.c:106
>   print_address_description.constprop.9+0x28/0x160 mm/kasan/report.c:247
>   __kasan_report mm/kasan/report.c:433 [inline]
>   kasan_report.cold.14+0x7d/0x117 mm/kasan/report.c:450
>   check_region_inline mm/kasan/generic.c:183 [inline]
>   kasan_check_range+0x18e/0x1f0 mm/kasan/generic.c:189
>   __kasan_check_write+0x14/0x20 mm/kasan/shadow.c:37
>   instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>   atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:167 [inline]
>   __refcount_sub_and_test include/linux/refcount.h:272 [inline]
>   __refcount_dec_and_test include/linux/refcount.h:315 [inline]
>   refcount_dec_and_test include/linux/refcount.h:333 [inline]
>   iocb_put fs/aio.c:1161 [inline]
>   io_submit_one+0x496/0x2fe0 fs/aio.c:1882
>   __do_sys_io_submit fs/aio.c:1938 [inline]
>   __se_sys_io_submit fs/aio.c:1908 [inline]
>   __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f43c5504289
> Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 db 2c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffda542ba68 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f43c5504289
> RDX: 0000000020000400 RSI: 0000000000000001 RDI: 00007f43c5c14000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004006f0
> R13: 00007ffda542bb50 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> 
> Allocated by task 15100:
>   kasan_save_stack+0x26/0x60 mm/kasan/common.c:38
>   kasan_set_track mm/kasan/common.c:46 [inline]
>   set_alloc_info mm/kasan/common.c:434 [inline]
>   __kasan_slab_alloc+0x71/0x90 mm/kasan/common.c:467
>   kasan_slab_alloc include/linux/kasan.h:259 [inline]
>   slab_post_alloc_hook+0x55/0x230 mm/slab.h:519
>   slab_alloc_node mm/slub.c:3234 [inline]
>   slab_alloc mm/slub.c:3242 [inline]
>   kmem_cache_alloc+0x15a/0x2b0 mm/slub.c:3247
>   aio_get_req fs/aio.c:1028 [inline]
>   io_submit_one+0x122/0x2fe0 fs/aio.c:1875
>   __do_sys_io_submit fs/aio.c:1938 [inline]
>   __se_sys_io_submit fs/aio.c:1908 [inline]
>   __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Freed by task 15100:
>   kasan_save_stack+0x26/0x60 mm/kasan/common.c:38
>   kasan_set_track+0x25/0x30 mm/kasan/common.c:46
>   kasan_set_free_info+0x24/0x40 mm/kasan/generic.c:370
>   ____kasan_slab_free mm/kasan/common.c:366 [inline]
>   ____kasan_slab_free mm/kasan/common.c:328 [inline]
>   __kasan_slab_free+0xe8/0x120 mm/kasan/common.c:374
>   kasan_slab_free include/linux/kasan.h:235 [inline]
>   slab_free_hook mm/slub.c:1723 [inline]
>   slab_free_freelist_hook mm/slub.c:1749 [inline]
>   slab_free mm/slub.c:3513 [inline]
>   kmem_cache_free+0xfe/0x310 mm/slub.c:3530
>   iocb_destroy fs/aio.c:1080 [inline]
>   iocb_put fs/aio.c:1163 [inline]
>   iocb_put fs/aio.c:1159 [inline]
>   aio_complete_rw+0xa0f/0x1010 fs/aio.c:1440
>   aio_rw_done fs/aio.c:1510 [inline]
>   aio_read+0x352/0x4a0 fs/aio.c:1537
>   __io_submit_one fs/aio.c:1830 [inline]
>   io_submit_one+0x478/0x2fe0 fs/aio.c:1879
>   __do_sys_io_submit fs/aio.c:1938 [inline]
>   __se_sys_io_submit fs/aio.c:1908 [inline]
>   __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The buggy address belongs to the object at ffff888027c33800
>   which belongs to the cache aio_kiocb of size 176
> The buggy address is located 160 bytes inside of
>   176-byte region [ffff888027c33800, ffff888027c338b0)
> The buggy address belongs to the page:
> page:00000000dfee8ade refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27c33
> flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
> raw: 000fffffc0000200 ffffea0000714400 dead000000000002 ffff88810649da40
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff888027c33780: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>   ffff888027c33800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >ffff888027c33880: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>                                 ^
>   ffff888027c33900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888027c33980: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 2 PID: 15100 at lib/refcount.c:28 refcount_warn_saturate+0x111/0x200 lib/refcount.c:28
> Modules linked in:
> CPU: 2 PID: 15100 Comm: syz-executor873 Tainted: G    B 5.16.0-rc1-syzk #1
> Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x111/0x200 lib/refcount.c:28
> Code: 1d fe 0e 02 11 31 ff 89 de e8 db 75 04 fe 84 db 75 9b e8 02 75 04 fe 48 c7 c7 60 57 53 8f c6 05 de 0e 02 11 01 e8 a8 32 7a 0a <0f> 0b e9 7c ff ff ff e8 e3 74 04 fe 0f b6 1d c4 0e 02 11 31 ff 89
> RSP: 0018:ffff88801885fc90 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff816856a5
> RDX: 0000000000000000 RSI: ffff888026f78000 RDI: 0000000000000002
> RBP: ffff88801885fca0 R08: ffffed1020f27911 R09: ffffed1020f27911
> R10: ffff88810793c887 R11: ffffed1020f27910 R12: ffff888027c338a0
> R13: 0000000000000000 R14: ffff888027c33890 R15: 0000000000000000
> FS:  00007f43c5c0d740(0000) GS:ffff888107900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f43c5c14000 CR3: 00000000247fe000 CR4: 00000000000006e0
> Call Trace:
>   <TASK>
>   __refcount_sub_and_test include/linux/refcount.h:283 [inline]
>   __refcount_dec_and_test include/linux/refcount.h:315 [inline]
>   refcount_dec_and_test include/linux/refcount.h:333 [inline]
>   iocb_put fs/aio.c:1161 [inline]
>   io_submit_one+0xfd2/0x2fe0 fs/aio.c:1882
>   __do_sys_io_submit fs/aio.c:1938 [inline]
>   __se_sys_io_submit fs/aio.c:1908 [inline]
>   __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f43c5504289
> Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 db 2c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffda542ba68 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f43c5504289
> RDX: 0000000020000400 RSI: 0000000000000001 RDI: 00007f43c5c14000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004006f0
> R13: 00007ffda542bb50 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> ---[ end trace 8c5b816eed9c8016 ]---
> 
> 
> Syzkaller reproducer:
> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
> io_setup(0x3, &(0x7f0000000040)=<r0=>0x0)
> r1 = openat$nullb(0xffffffffffffff9c, &(0x7f0000000000), 0x24080, 0x0)
> io_submit(r0, 0x1, &(0x7f0000000400)=[&(0x7f0000000140)={0x0, 0x0, 0x0, 0x0, 0x0, r1, 0x0, 0xfe00}])
> 
> 
> C reproducer:
> #endif /* REF */
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> 
> #define _GNU_SOURCE
> 
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
> 
> uint64_t r[2] = {0x0, 0xffffffffffffffff};
> 
> int main(void)
> {
>          syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>      syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>      syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>                  intptr_t res = 0;
>      res = syscall(__NR_io_setup, 3, 0x20000040ul);
>      if (res != -1)
> r[0] = *(uint64_t*)0x20000040;
> memcpy((void*)0x20000000, "/dev/nullb0\000", 12);
>      res = syscall(__NR_openat, 0xffffffffffffff9cul, 0x20000000ul, 0x24080ul, 0ul);
>      if (res != -1)
>          r[1] = res;
> *(uint64_t*)0x20000400 = 0x20000140;
> *(uint64_t*)0x20000140 = 0;
> *(uint32_t*)0x20000148 = 0;
> *(uint32_t*)0x2000014c = 0;
> *(uint16_t*)0x20000150 = 0;
> *(uint16_t*)0x20000152 = 0;
> *(uint32_t*)0x20000154 = r[1];
> *(uint64_t*)0x20000158 = 0;
> *(uint64_t*)0x20000160 = 0xfe00;
> *(uint64_t*)0x20000168 = 0;
> *(uint64_t*)0x20000170 = 0;
> *(uint32_t*)0x20000178 = 0;
> *(uint32_t*)0x2000017c = -1;
>      syscall(__NR_io_submit, r[0], 1ul, 0x20000400ul);
>      return 0;
> }
> 
> Thanks,
> George
>>
>> One spot I don't like is how errors from bio_iov_iter_get_pages()
>> are handled, will test it.
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index ad732a36f9b3..211f44974d1e 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -342,7 +342,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>>          if (unlikely(ret)) {
>>              bio->bi_status = BLK_STS_IOERR;
>>              bio_endio(bio);
>> -            return ret;
>> +            return -EIOCBQUEUED;
>>          }
>>      }
>>      dio->size = bio->bi_iter.bi_size;
>>
>>
> 

-- 
Pavel Begunkov
