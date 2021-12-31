Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6441482112
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbhLaAtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 19:49:20 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:40604 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242418AbhLaAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 19:49:19 -0500
Received: by mail-il1-f200.google.com with SMTP id n3-20020a056e021ba300b002b53500c8feso10996949ili.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZdcWEXS2IJeaqzL6j99HK08/a+lJu93wUa6RFqNnnTI=;
        b=k/ODzkwcXmUQFwuh0OA+s8QamUexOsLxLmK168KkJLuEeiVY6ey/FDsl99bwzBjvqh
         djWcslm9lIchFkWUYFSMtY0BTBKN2LzUZVcOUeps5LoA/AvXjSPcWYfGns7Zx0BNPpvK
         3ulntpK2DwBT6g120H0aLcKYqtqzIpZH1uvsMrfqLgJR60ntNor895eWys78+KsLtfik
         3y3gQlL1YGGb+Zw+5f1lThm78EYyALtqQMrfflFw5pwylfYGq8SL8tLH2ZqMdoPsf7J+
         zyS9FNEWPz7/JCNwCXawtcp5wCZTbAMlXeNqyUHpNdALHVfO4o7c9P9epkcA05MCsUZ1
         uKkg==
X-Gm-Message-State: AOAM53166MDVOWo+nFpeZopvY6/rx26CfLedJWvJ9Ma8/U4SR7y2vjL7
        FXJzGnT2rrcvKJY5O0zQ96jzAGvlS8p/i+WI/YR9SJWQTyz6
X-Google-Smtp-Source: ABdhPJwAOxTQaCSCVvu0XAuLYw6u0YoSjX8r2g7prxqYH/MuyTsi0QcCd5hgHFBwNyAhPBfeZ/2EvbeycAeC5m1DLmsL+0ig4+7d
MIME-Version: 1.0
X-Received: by 2002:a02:271f:: with SMTP id g31mr15134554jaa.147.1640911758840;
 Thu, 30 Dec 2021 16:49:18 -0800 (PST)
Date:   Thu, 30 Dec 2021 16:49:18 -0800
In-Reply-To: <Yc4RsFnaFfbCUeRy@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e5fdb05d4668af8@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
 (2)
From:   syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, jun.li@nxp.com, keescook@chromium.org,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.szyprowski@samsung.com,
        noring@nocrew.org, pastor.winkley@holytabernacleint.org,
        peter.chen@nxp.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/fortify-string.h:225 [inline]
BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x376/0x780 drivers/usb/core/hcd.c:774
Write of size 2 at addr ffff8880121ae230 by task syz-executor189/4087

CPU: 1 PID: 4087 Comm: syz-executor189 Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memcpy+0x39/0x60 mm/kasan/shadow.c:66
 memcpy include/linux/fortify-string.h:225 [inline]
 usb_hcd_poll_rh_status+0x376/0x780 drivers/usb/core/hcd.c:774
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: 48 89 ef 5d e9 b1 1c 46 00 5d be 03 00 00 00 e9 46 8c 63 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 <65> 8b 05 c9 dd 8a 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc900027ef930 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801b413a00 RSI: ffffffff815efbe1 RDI: 0000000000000003
RBP: ffffc900027ef970 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815efbd7 R11: 0000000000000000 R12: 000000000000001f
R13: ffff88801fbc1d00 R14: 0000000000000200 R15: ffffc900027efa90
 console_trylock_spinning kernel/printk/printk.c:1885 [inline]
 vprintk_emit+0x377/0x4f0 kernel/printk/printk.c:2244
 dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4594
 dev_printk_emit+0xba/0xf1 drivers/base/core.c:4605
 __dev_printk+0xcf/0xf5 drivers/base/core.c:4617
 _dev_info+0xd7/0x109 drivers/base/core.c:4663
 usbdev_do_ioctl drivers/usb/core/devio.c:2624 [inline]
 usbdev_ioctl.cold+0x7c2/0x83c drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7faa77f20799
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd37de1eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faa77f64098 RCX: 00007faa77f20799
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000006
RBP: 00007ffd37de1ee0 R08: 00007ffd37de1930 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 000000000001297d
R13: 00007ffd37de1ec4 R14: 00007ffd37de1ee0 R15: 00007ffd37de1ed0
 </TASK>

Allocated by task 4081:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:595 [inline]
 do_proc_bulk+0x2fc/0xba0 drivers/usb/core/devio.c:1292
 proc_bulk drivers/usb/core/devio.c:1351 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2625 [inline]
 usbdev_ioctl+0x586/0x36c0 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880121ae230
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff8880121ae230, ffff8880121ae238)
The buggy address belongs to the page:
page:ffffea0000486b80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x121ae
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010c41280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 2449997177, free_ts 0
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2036
 alloc_pages+0x29f/0x300 mm/mempolicy.c:2185
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1993
 ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x2fb/0x340 mm/slub.c:4419
 acpi_ns_internalize_name drivers/acpi/acpica/nsutils.c:331 [inline]
 acpi_ns_internalize_name+0xf2/0x1a1 drivers/acpi/acpica/nsutils.c:312
 acpi_ns_get_node_unlocked drivers/acpi/acpica/nsutils.c:666 [inline]
 acpi_ns_get_node_unlocked+0x1d8/0x278 drivers/acpi/acpica/nsutils.c:635
 acpi_ns_get_node+0x4b/0x6a drivers/acpi/acpica/nsutils.c:726
 acpi_ns_evaluate+0xd2/0x966 drivers/acpi/acpica/nseval.c:62
 acpi_evaluate_object+0x3db/0x7f5 drivers/acpi/acpica/nsxfeval.c:354
 acpi_evaluate_dsm+0x188/0x270 drivers/acpi/utils.c:678
 acpi_check_dsm drivers/acpi/utils.c:710 [inline]
 acpi_check_dsm+0x60/0x260 drivers/acpi/utils.c:701
 device_has_acpi_name drivers/pci/pci-label.c:44 [inline]
 acpi_attr_is_visible+0xaf/0x130 drivers/pci/pci-label.c:221
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880121ae100: fc fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc
 ffff8880121ae180: fc fc fa fc fc fc fc 00 fc fc fc fc 00 fc fc fc
>ffff8880121ae200: fc fb fc fc fc fc 01 fc fc fc fc fb fc fc fc fc
                                     ^
 ffff8880121ae280: fb fc fc fc fc fb fc fc fc fc fb fc fc fc fc fb
 ffff8880121ae300: fc fc fc fc fb fc fc fc fc fb fc fc fc fc 00 fc
==================================================================
----------------
Code disassembly (best guess):
   0:	48 89 ef             	mov    %rbp,%rdi
   3:	5d                   	pop    %rbp
   4:	e9 b1 1c 46 00       	jmpq   0x461cba
   9:	5d                   	pop    %rbp
   a:	be 03 00 00 00       	mov    $0x3,%esi
   f:	e9 46 8c 63 02       	jmpq   0x2638c5a
  14:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1a:	48 8b be b0 01 00 00 	mov    0x1b0(%rsi),%rdi
  21:	e8 b4 ff ff ff       	callq  0xffffffda
  26:	31 c0                	xor    %eax,%eax
  28:	c3                   	retq
  29:	90                   	nop
* 2a:	65 8b 05 c9 dd 8a 7e 	mov    %gs:0x7e8addc9(%rip),%eax        # 0x7e8addfa <-- trapping instruction
  31:	89 c1                	mov    %eax,%ecx
  33:	48 8b 34 24          	mov    (%rsp),%rsi
  37:	81 e1 00 01 00 00    	and    $0x100,%ecx
  3d:	65                   	gs
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


Tested on:

commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13e94c1bb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1798d2c3b00000

