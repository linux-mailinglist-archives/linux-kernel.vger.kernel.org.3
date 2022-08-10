Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6958058EC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiHJMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:49:43 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5458760E8;
        Wed, 10 Aug 2022 05:49:41 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id r12so5734544uaf.7;
        Wed, 10 Aug 2022 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=sAeVHy2MKFf37s1JMRNsjpqR0QlCmYdMy70nbJ/sHBQ=;
        b=QVANk7PabgkTSwEMVKlmMzRzrYMPFJNTNHD0fFDAMkRF2eCPIorij0enBU0Sv4w7aY
         GpVRZQ9YQBgLAtZ+KppqOw32qMSvJcfp6eB2cthI/S8hOvyAMwaNeoWfscHvgv/Lkt0a
         rJXigcUqyLh1+4C+TG62is31+PWNQWmLkHRETaqSQXuSCdE124L9ao35uSK6sVwn+SJR
         t1piUDtYEM9PizzDTqgZpCwIGoee1H5ssMYk0+yfA0kJkoTVx7f75h6xSyB8i7rb7NjY
         hbjIcq67q75LtTuKV0Ct/EAir0ryzhmEY71+wBml2SGOelpW9YBiodMxsSFtFbU+TpLx
         MyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=sAeVHy2MKFf37s1JMRNsjpqR0QlCmYdMy70nbJ/sHBQ=;
        b=4L0ZjX6+eTt/KOyEJAVIC+KXmq+fZR3ET3WYYw+SOW4WKImrZdnYpV+QLcCtNUM5fp
         HVRxQGNK4KaiXEX0cdkNLOf6DI/6W1wTkUTR5PgTU8b5XYkDNf9giFG2o/eQ9vO0tKUO
         871bvxeQcqy8j4CZpLfT9IJLLA1y3W2jBqAxhHFS4fTKfvuCYyAXT5mEuSeLtdo2FgfD
         ZW6oVIwd6T/hCv/jACTx7ghrQraGitLfUWMpGgEIs8Ph0vxluNcwp/MpyNmbmvBFoQjE
         a+amliB2EdHPeVrsDi8K77olcxqDUKffnrrDLD7oTtCWPFejiHn5CAMCDghioPQEkLSM
         rbUw==
X-Gm-Message-State: ACgBeo0gpzslu7VapYOTXNjxuVwrQQGlRiVg3B8hEE5wgKVbaRXTq5W1
        hPuNGJ/JFj0xLxiSHJxRjA0u86jc9MRfj4OYE7Y=
X-Google-Smtp-Source: AA6agR6bpNefJBNJmt94Lzioyb3fFV03Jh5Tjc5LmitggOJF7V3T+I6FK+xCHY81v1NO3qk2Ghb/ig7MNjkqMmouV74=
X-Received: by 2002:ab0:38c5:0:b0:383:eed8:dd45 with SMTP id
 l5-20020ab038c5000000b00383eed8dd45mr12756451uaw.11.1660135780588; Wed, 10
 Aug 2022 05:49:40 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 10 Aug 2022 20:49:29 +0800
Message-ID: <CAB7eex+X4ZQYkLLjVyNoqK2O9_tV8cnsrcgBNewSoibz93Vb-g@mail.gmail.com>
Subject: warn in usb_stor_pre_reset in linux v5.18
To:     justin@coraid.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xyru1999@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
git tree: upstream

kernel config: https://pastebin.com/KecL2gaG
C reproducer: https://pastebin.com/9PQvFCiy
console output: https://pastebin.com/XyBzBX2F

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0x13d3, product id:
0x3340, with function: ms_null and midi_null).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

It seems that when dev_set_drvdata allocate a space and
smsusb_term_device tries to free it, while there is a UAF happened in
smsusb_term_device and eventually affect the dummy_timer, cause kernel
produce such error message.

The crash report is as follow:

```
==================================================================
BUG: KASAN: use-after-free in dummy_timer+0x2a37/0x33b0
drivers/block/aoe/aoenet.c:163
Read of size 4 at addr ffff88801aa1e814 by task syz-fuzzer/2931

CPU: 0 PID: 2931 Comm: syz-fuzzer Not tainted 5.18.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:313 [inline]
print_report.cold+0xe5/0x659 mm/kasan/report.c:429
kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
dummy_timer+0x2a37/0x33b0 drivers/block/aoe/aoenet.c:163
call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers kernel/time/timer.c:1790 [inline]
__run_timers kernel/time/timer.c:1763 [inline]
run_timer_softirq+0x1084/0x16d0 kernel/time/timer.c:1803
__do_softirq+0x1c0/0x8ee kernel/softirq.c:571
invoke_softirq kernel/softirq.c:435 [inline]
__irq_exit_rcu kernel/softirq.c:650 [inline]
irq_exit_rcu+0xe2/0x120 kernel/softirq.c:662
sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1106
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:unwind_get_return_address arch/x86/kernel/unwind_orc.c:318 [inline]
RIP: 0010:unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:313
Code: 05 5b 31 c0 5d c3 48 8d 6b 48 48 b8 00 00 00 00 00 fc ff df 48
89 ea 48 c1 ea 03 80 3c 02 00 75 32 48 8b 7b 48 e8 56 5d 0b 00 <85> c0
74 d3 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80
RSP: 0018:ffffc90000e9f5f8 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffc90000e9f610 RCX: 0000000000000000
RDX: 1ffff920001d3ecb RSI: 0000000000000000 RDI: ffffffff81ed3c4f
RBP: ffffc90000e9f658 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90000e9f66f R11: 000000000005203e R12: ffffc90000e9f6c8
R13: 0000000000000000 R14: ffff888104ce5580 R15: 0000000000001000
arch_stack_walk+0x93/0xe0 arch/x86/kernel/stacktrace.c:26
stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:368 [inline]
____kasan_slab_free mm/kasan/common.c:328 [inline]
__kasan_slab_free+0x105/0x170 mm/kasan/common.c:374
kfree+0xcd/0x450 mm/slab.c:3795
tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
tomoyo_path_perm+0x219/0x420 security/tomoyo/file.c:822
security_inode_getattr+0xcf/0x140 security/security.c:1344
vfs_getattr+0x22/0x60 fs/stat.c:157
vfs_statx+0x170/0x360 fs/stat.c:232
vfs_fstatat+0x8c/0xb0 fs/stat.c:255
__do_sys_newfstatat+0x91/0x110 fs/stat.c:425
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x49d50a
Code: e8 1b 99 fc ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c
8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d
01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
RSP: 002b:000000c0000e5d20 EFLAGS: 00000206 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000000c000026f00 RCX: 000000000049d50a
RDX: 000000c000e7c1d8 RSI: 000000c000e6d770 RDI: ffffffffffffff9c
RBP: 000000c0000e5db0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 000000c00b596820 R15: 0000000000000177
</TASK>

Allocated by task 6:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
set_alloc_info mm/kasan/common.c:435 [inline]
____kasan_kmalloc mm/kasan/common.c:515 [inline]
____kasan_kmalloc mm/kasan/common.c:474 [inline]
__kasan_kmalloc+0x81/0xa0 mm/kasan/common.c:524
slab_want_init_on_alloc mm/slab.h:839 [inline]
slab_want_init_on_alloc mm/slab.h:832 [inline]
slab_alloc mm/slab.c:3299 [inline]
kmem_cache_alloc_trace+0x20b/0x450 mm/slab.c:3567
dev_set_drvdata include/linux/device.h:766 [inline]
usb_set_intfdata include/linux/usb.h:270 [inline]
smsusb_init_device+0xb2/0xb07 drivers/media/usb/siano/smsusb.c:400
smsusb_probe+0xda2/0xe3f drivers/media/usb/siano/smsusb.c:566
usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:396
call_driver_probe drivers/base/dd.c:555 [inline]
really_probe drivers/base/dd.c:634 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:579
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:989
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3412
usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:238
usb_probe_device+0xd9/0x2a0 drivers/usb/core/driver.c:293
call_driver_probe drivers/base/dd.c:555 [inline]
really_probe drivers/base/dd.c:634 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:579
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:989
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3412
usb_new_device.cold+0x4b8/0x10ca drivers/usb/core/hub.c:2566
hub_port_connect drivers/usb/core/hub.c:5359 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
port_event drivers/usb/core/hub.c:5663 [inline]
hub_event+0x231e/0x4170 drivers/usb/core/hub.c:5745
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2ef/0x3a0 kernel/kthread.c:346
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Freed by task 6:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:368 [inline]
____kasan_slab_free mm/kasan/common.c:328 [inline]
__kasan_slab_free+0x105/0x170 mm/kasan/common.c:374
kfree+0xcd/0x450 mm/slab.c:3795
smsusb_term_device+0xd6/0x160 drivers/media/usb/siano/smsusb.c:350
smsusb_init_device+0xa80/0xb07 drivers/media/usb/siano/smsusb.c:494
smsusb_probe+0xda2/0xe3f drivers/media/usb/siano/smsusb.c:566
usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:396
call_driver_probe drivers/base/dd.c:555 [inline]
really_probe drivers/base/dd.c:634 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:579
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:989
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3412
usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:238
usb_probe_device+0xd9/0x2a0 drivers/usb/core/driver.c:293
call_driver_probe drivers/base/dd.c:555 [inline]
really_probe drivers/base/dd.c:634 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:579
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:989
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3412
usb_new_device.cold+0x4b8/0x10ca drivers/usb/core/hub.c:2566
hub_port_connect drivers/usb/core/hub.c:5359 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
port_event drivers/usb/core/hub.c:5663 [inline]
hub_event+0x231e/0x4170 drivers/usb/core/hub.c:5745
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2ef/0x3a0 kernel/kthread.c:346
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xa1/0xb0 mm/kasan/generic.c:188
insert_work+0x4a/0x390 kernel/workqueue.c:1358
__queue_work+0x4dd/0x1140 kernel/workqueue.c:1517
queue_work_on+0xee/0x110 kernel/workqueue.c:1545
queue_work include/linux/workqueue.h:502 [inline]
schedule_work include/linux/workqueue.h:563 [inline]
smsusb_onresponse+0x594/0x780 drivers/media/usb/siano/smsusb.c:147
__usb_hcd_giveback_urb+0x2c2/0x5a0 drivers/usb/core/hcd.c:1670
usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1747
__skb_queue_head_init include/linux/skbuff.h:2272 [inline]
skbpoolfree drivers/block/aoe/aoedev.c:434 [inline]
freedev drivers/block/aoe/aoedev.c:289 [inline]
dummy_timer+0x1267/0x33b0 drivers/block/aoe/aoedev.c:365
call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers kernel/time/timer.c:1790 [inline]
__run_timers kernel/time/timer.c:1763 [inline]
run_timer_softirq+0x1084/0x16d0 kernel/time/timer.c:1803
__do_softirq+0x1c0/0x8ee kernel/softirq.c:571

Second to last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xa1/0xb0 mm/kasan/generic.c:188
insert_work+0x4a/0x390 kernel/workqueue.c:1358
__queue_work+0x4dd/0x1140 kernel/workqueue.c:1517
queue_work_on+0xee/0x110 kernel/workqueue.c:1545
queue_work include/linux/workqueue.h:502 [inline]
schedule_work include/linux/workqueue.h:563 [inline]
smsusb_onresponse+0x594/0x780 drivers/media/usb/siano/smsusb.c:147
__usb_hcd_giveback_urb+0x2c2/0x5a0 drivers/usb/core/hcd.c:1670
usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1747
__skb_queue_head_init include/linux/skbuff.h:2272 [inline]
skbpoolfree drivers/block/aoe/aoedev.c:434 [inline]
freedev drivers/block/aoe/aoedev.c:289 [inline]
dummy_timer+0x1267/0x33b0 drivers/block/aoe/aoedev.c:365
call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers kernel/time/timer.c:1790 [inline]
__run_timers kernel/time/timer.c:1763 [inline]
run_timer_softirq+0x1084/0x16d0 kernel/time/timer.c:1803
__do_softirq+0x1c0/0x8ee kernel/softirq.c:571

The buggy address belongs to the object at ffff88801aa1e000
which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2068 bytes inside of
4096-byte region [ffff88801aa1e000, ffff88801aa1f000)

The buggy address belongs to the physical page:
page:ffffea00006a8600 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x1aa18
head:ffffea00006a8600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=1)
raw: 0100000000010200 0000000000000000 dead000000000001 ffff888100043040
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL),
pid 2918, tgid 2918 (syz-fuzzer), ts 369046599373, free_ts
368942090992
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2449 [inline]
prep_new_page+0x297/0x330 mm/page_alloc.c:2456
local_lock_release include/linux/local_lock_internal.h:36 [inline]
rmqueue_pcplist mm/page_alloc.c:3703 [inline]
rmqueue mm/page_alloc.c:3730 [inline]
get_page_from_freelist+0x122b/0x27d0 mm/page_alloc.c:4195
alloc_flags_nofragment mm/page_alloc.c:4057 [inline]
__alloc_pages+0x2d5/0x6c0 mm/page_alloc.c:5423
alloc_pages+0x119/0x250 mm/mempolicy.c:2272
new_slab+0x2a9/0x3f0
___slab_alloc+0xc62/0x1080
__slab_alloc.isra.0+0x4d/0xa0
page_fixed_fake_head include/linux/page-flags.h:246 [inline]
_compound_head include/linux/page-flags.h:276 [inline]
virt_to_folio include/linux/mm.h:855 [inline]
virt_to_slab mm/slab.h:175 [inline]
memcg_slab_post_alloc_hook mm/slab.h:529 [inline]
slab_post_alloc_hook mm/slab.h:757 [inline]
slab_alloc mm/slab.c:3302 [inline]
__do_kmalloc mm/slab.c:3694 [inline]
__kmalloc+0x3b6/0x4b0 mm/slab.c:3705
kmalloc include/linux/slab.h:605 [inline]
tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
tomoyo_path_perm+0x219/0x420 security/tomoyo/file.c:822
security_inode_getattr+0xcf/0x140 security/security.c:1344
vfs_getattr+0x22/0x60 fs/stat.c:157
vfs_statx+0x170/0x360 fs/stat.c:232
vfs_fstatat+0x8c/0xb0 fs/stat.c:255
__do_sys_newfstatat+0x91/0x110 fs/stat.c:425
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
__preempt_count_dec_and_test arch/x86/include/asm/preempt.h:95 [inline]
rcu_read_unlock_sched_notrace include/linux/rcupdate.h:817 [inline]
trace_mm_page_free include/trace/events/kmem.h:160 [inline]
trace_mm_page_free include/trace/events/kmem.h:160 [inline]
free_pages_prepare mm/page_alloc.c:1322 [inline]
free_pcp_prepare+0x4f3/0xb40 mm/page_alloc.c:1421
free_unref_page_prepare mm/page_alloc.c:3343 [inline]
free_unref_page+0x19/0x490 mm/page_alloc.c:3438
__unfreeze_partials+0x3d2/0x3f0
_compound_head include/linux/page-flags.h:275 [inline]
virt_to_folio include/linux/mm.h:855 [inline]
virt_to_slab mm/slab.h:175 [inline]
memcg_slab_free_hook mm/slab.h:567 [inline]
memcg_slab_free_hook mm/slab.h:550 [inline]
___cache_free+0x12c/0x140 mm/slab.c:3444
arch_local_irq_restore arch/x86/include/asm/irqflags.h:137 [inline]
qlink_free mm/kasan/quarantine.c:171 [inline]
qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
kasan_quarantine_reduce+0x13d/0x180 mm/kasan/quarantine.c:294
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:436 [inline]
__kasan_slab_alloc+0x78/0x80 mm/kasan/common.c:469
slab_post_alloc_hook+0x4d/0x4d0 mm/slab.h:750
_compound_head include/linux/page-flags.h:272 [inline]
virt_to_folio include/linux/mm.h:855 [inline]
virt_to_slab mm/slab.h:175 [inline]
memcg_slab_post_alloc_hook mm/slab.h:529 [inline]
slab_post_alloc_hook mm/slab.h:757 [inline]
slab_alloc mm/slab.c:3302 [inline]
__do_kmalloc mm/slab.c:3694 [inline]
__kmalloc+0x19e/0x4b0 mm/slab.c:3705
kmalloc include/linux/slab.h:605 [inline]
kzalloc include/linux/slab.h:733 [inline]
tomoyo_encode2.part.0+0xec/0x3b0 security/tomoyo/realpath.c:45
tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
tomoyo_realpath_from_path+0x186/0x620 security/tomoyo/realpath.c:288
tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
tomoyo_path_perm+0x219/0x420 security/tomoyo/file.c:822
security_inode_getattr+0xcf/0x140 security/security.c:1344
vfs_getattr+0x22/0x60 fs/stat.c:157
vfs_statx+0x170/0x360 fs/stat.c:232

Memory state around the buggy address:
ffff88801aa1e700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88801aa1e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801aa1e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88801aa1e880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88801aa1e900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
0: 05 5b 31 c0 5d add $0x5dc0315b,%eax
5: c3 retq
6: 48 8d 6b 48 lea 0x48(%rbx),%rbp
a: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
11: fc ff df
14: 48 89 ea mov %rbp,%rdx
17: 48 c1 ea 03 shr $0x3,%rdx
1b: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
1f: 75 32 jne 0x53
21: 48 8b 7b 48 mov 0x48(%rbx),%rdi
25: e8 56 5d 0b 00 callq 0xb5d80
* 2a: 85 c0 test %eax,%eax <-- trapping instruction
2c: 74 d3 je 0x1
2e: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
35: fc ff df
38: 48 89 ea mov %rbp,%rdx
3b: 48 c1 ea 03 shr $0x3,%rdx
3f: 80 .byte 0x80


```
