Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A756482219
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 06:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhLaFYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 00:24:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:52772 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhLaFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 00:24:09 -0500
Received: by mail-il1-f197.google.com with SMTP id u15-20020a056e02080f00b002b2d3206e35so15266020ilm.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 21:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IkitvZIFSTodLJerc5oqUI4seoeb7G2l7EKW1JOQgTc=;
        b=b0l/ywGL4uyPq9TrPSkPwAhfOvifoUn1rh5LCViKzgGZ6UmkGccXbQc5B8/8O5iSr/
         HQt30ntPW/U6sGLmBjGpkuPvNiNc4F25+N/UDWazy7OdNT1Sxyz1e0gx8YPPdNYTEavM
         wBAVb2EWBqgxTOMT/F+2RpwCIvFlkjR+0Mq1Yoeus3k32GVQd+DRqAVHFxvLx02BoXAe
         Q5t6sr3AD2l+zAIGPeBxDXgUD0hIg3Hll/dBImEZ0PbAJJZE3uAM8rnr2vtMZ9lMPFel
         piI6b+fcQcH8k0xfI0l4O6Wr/aT7GsHFT4qsir2ooi5bmod9LpISivcWTqLEaznCXDfN
         g+hA==
X-Gm-Message-State: AOAM531DWIPTa58SdBwiPJRiqf/vkVBLvaXnOT2cHqLx3K84HWhAdzcO
        ZIhqlBdqcAszn5fZpnAeVcZyW+H+l4VKFJDuz+qgXyh3p4TL
X-Google-Smtp-Source: ABdhPJy/XyrHPjwaZkRNOAfreAvokHqF9MWRU5nnNdjUFuN4bkRbWnN31us+k1VU2QZuzsozUuc3M+ED3o8sx8YZulmvy+ceYY8+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3454:: with SMTP id q20mr14928132jav.77.1640928249236;
 Thu, 30 Dec 2021 21:24:09 -0800 (PST)
Date:   Thu, 30 Dec 2021 21:24:09 -0800
In-Reply-To: <Yc5rgUo8dyJKX98M@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065d16005d46a614b@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
 (2)
From:   syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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
Write of size 2 at addr ffff8880127f7028 by task syz-executor029/4082

CPU: 1 PID: 4082 Comm: syz-executor029 Not tainted 5.16.0-rc7-syzkaller #0
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 aa db 15 f8 48 89 ef e8 62 51 16 f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> a3 1b 09 f8 65 8b 05 bc a0 bb 76 85 c0 74 0a 5b 5d c3 e8 d0 02
RSP: 0018:ffffc9000283f8b0 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1b22571
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8ca3bc60 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817dd258 R11: 0000000000000000 R12: ffff88801cffc240
R13: ffff88801dba4000 R14: ffff88801dba4180 R15: 0000000000000000
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 rh_queue_status drivers/usb/core/hcd.c:834 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
 usb_hcd_submit_urb+0x155c/0x2300 drivers/usb/core/hcd.c:1546
 usb_submit_urb+0x86d/0x18a0 drivers/usb/core/urb.c:594
 usbfs_start_wait_urb+0x128/0x3d0 drivers/usb/core/devio.c:1125
 do_proc_bulk+0x535/0xba0 drivers/usb/core/devio.c:1313
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
RIP: 0033:0x7fe659509799
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbcc163b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe65954d098 RCX: 00007fe659509799
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000006
RBP: 00007fffbcc163e0 R08: 00007fffbcc15e30 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 0000000000012b3a
R13: 00007fffbcc163c4 R14: 00007fffbcc163e0 R15: 00007fffbcc163d0
 </TASK>

Allocated by task 4082:
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

The buggy address belongs to the object at ffff8880127f7028
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff8880127f7028, ffff8880127f7030)
The buggy address belongs to the page:
page:ffffea000049fdc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x127f7
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010c41280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 2292076002, free_ts 0
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
 acpi_get_handle+0x129/0x211 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x6e/0xb0 drivers/acpi/utils.c:553
 acpi_is_video_device+0x154/0x210 drivers/acpi/scan.c:1226
 acpi_set_pnp_ids drivers/acpi/scan.c:1365 [inline]
 acpi_init_device_object+0xee0/0x1a60 drivers/acpi/scan.c:1747
 acpi_add_single_object+0xe4/0x1aa0 drivers/acpi/scan.c:1793
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880127f6f00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
 ffff8880127f6f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880127f7000: fb fc fc fc fc 01 fc fc fc fc fa fc fc fc fc 00
                                  ^
 ffff8880127f7080: fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc
 ffff8880127f7100: fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	aa                   	stos   %al,%es:(%rdi)
   5:	db 15 f8 48 89 ef    	fistl  -0x1076b708(%rip)        # 0xef894903
   b:	e8 62 51 16 f8       	callq  0xf8165172
  10:	81 e3 00 02 00 00    	and    $0x200,%ebx
  16:	75 25                	jne    0x3d
  18:	9c                   	pushfq
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 a3 1b 09 f8       	callq  0xf8091bd2 <-- trapping instruction
  2f:	65 8b 05 bc a0 bb 76 	mov    %gs:0x76bba0bc(%rip),%eax        # 0x76bba0f2
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	d0 02                	rolb   (%rdx)


Tested on:

commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab1f85b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14522335b00000

