Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19980482572
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhLaRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:44:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:45781 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhLaRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:44:07 -0500
Received: by mail-io1-f71.google.com with SMTP id y141-20020a6bc893000000b00602098c8ec8so9698888iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 09:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=n1A32bfspWbb9Zy4RFAxpiHNQqFmUvmdFs9l8Fz6f54=;
        b=zSRdBI/wS9kTaBpoEyFx61BbeMx6dE8qC6INU73Y0/hR9nkJ7jt1K0IuHElrFGQ0+p
         FgwGWVTRVm9G+jXs5eiDAqL0Uhn9aBBvss949DPWYs5IXoOVECd2soR9VvV3tl6rX/e0
         czPTmbGQqDzhXff8Z6FtaBrLDVyy5EBo98IEz79ocC1SeGSdY0WhqBvSzbf2ab26eT2f
         Z7FE6rQHe7me+N2LWngxwAajG6XQtAZ+z9fmCrM2kcofaJLhzOSoyhkya3N+23H8+J8W
         dO6sbrm8drse31LGfWmJaBsse5Ce8irDT/DphJ+lTY2UWv7GE4XDpQSE/jeQNZM4bGhs
         NOZg==
X-Gm-Message-State: AOAM5337rxtDMhud2ZM1yNNm6GeqWDXLn9puaXkYqT/HD6m52kWL3mjS
        auR99L7r5XQqnILZUGThnJ8rrajwTSIMX6ROkCKunosLb/Gp
X-Google-Smtp-Source: ABdhPJxkoErSfKLVk3hDQGfpTDWOC4Vdy38Wn35b4K96+Wu4hkF8+Lp6NvRO17pU5OVmgX4MtJjxaa5zSxQsJseTPuCa2K+qBoXT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:: with SMTP id d13mr15480387ilg.117.1640972646583;
 Fri, 31 Dec 2021 09:44:06 -0800 (PST)
Date:   Fri, 31 Dec 2021 09:44:06 -0800
In-Reply-To: <Yc8+zLP8KTB8gT71@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af950605d474b781@google.com>
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

vhci_hcd vhci_hcd.0: poll_rh_status: len 2 maxch 0 tblen 1
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/fortify-string.h:225 [inline]
BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x5f4/0x780 drivers/usb/core/hcd.c:776
Write of size 2 at addr ffff88801da403c0 by task syz-executor133/4062

CPU: 1 PID: 4062 Comm: syz-executor133 Not tainted 5.16.0-rc7-syzkaller #0
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
 usb_hcd_poll_rh_status+0x5f4/0x780 drivers/usb/core/hcd.c:776
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
Code: 74 24 10 e8 ca db 15 f8 48 89 ef e8 82 51 16 f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> c3 1b 09 f8 65 8b 05 dc a0 bb 76 85 c0 74 0a 5b 5d c3 e8 f0 02
RSP: 0018:ffffc9000289f8b0 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1b22579
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8ca3bc60 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817dd258 R11: 0000000000000000 R12: ffff88801d9a7d40
R13: ffff888147c88000 R14: ffff888147c88180 R15: 0000000000000000
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 rh_queue_status drivers/usb/core/hcd.c:836 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:843 [inline]
 usb_hcd_submit_urb+0x15ac/0x2390 drivers/usb/core/hcd.c:1548
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
RIP: 0033:0x7fecb7004799
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb13c1078 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fecb7048098 RCX: 00007fecb7004799
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000006
RBP: 00007fffb13c10a0 R08: 00007fffb13c0af0 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 00007fecb6fc3770
R13: 0000000000000000 R14: 00007fffb13c10a0 R15: 00007fffb13c1090
 </TASK>

Allocated by task 4062:
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

The buggy address belongs to the object at ffff88801da403c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff88801da403c0, ffff88801da403c8)
The buggy address belongs to the page:
page:ffffea0000769000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1da40
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010c41280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 2973, ts 21401832644, free_ts 18932450065
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2190
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1993
 ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x2fb/0x340 mm/slub.c:4419
 kmalloc include/linux/slab.h:595 [inline]
 kernfs_fop_write_iter+0x231/0x500 fs/kernfs/file.c:273
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 kasan_depopulate_vmalloc_pte+0x5c/0x70 mm/kasan/shadow.c:380
 apply_to_pte_range mm/memory.c:2518 [inline]
 apply_to_pmd_range mm/memory.c:2562 [inline]
 apply_to_pud_range mm/memory.c:2598 [inline]
 apply_to_p4d_range mm/memory.c:2634 [inline]
 __apply_to_page_range+0x686/0x1030 mm/memory.c:2668
 kasan_release_vmalloc+0xa7/0xc0 mm/kasan/shadow.c:490
 __purge_vmap_area_lazy+0x8f9/0x1c50 mm/vmalloc.c:1708
 _vm_unmap_aliases.part.0+0x3f0/0x500 mm/vmalloc.c:2111
 _vm_unmap_aliases mm/vmalloc.c:2085 [inline]
 vm_unmap_aliases+0x45/0x50 mm/vmalloc.c:2134
 change_page_attr_set_clr+0x241/0x500 arch/x86/mm/pat/set_memory.c:1743
 change_page_attr_set arch/x86/mm/pat/set_memory.c:1793 [inline]
 set_memory_nx+0xb2/0x110 arch/x86/mm/pat/set_memory.c:1941
 free_init_pages+0x73/0xc0 arch/x86/mm/init.c:894
 kernel_init+0x2e/0x1d0 init/main.c:1508
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88801da40280: fb fc fc fc fc fb fc fc fc fc fb fc fc fc fc fa
 ffff88801da40300: fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc
>ffff88801da40380: fc fc fc 00 fc fc fc fc 01 fc fc fc fc fb fc fc
                                           ^
 ffff88801da40400: fc fc fb fc fc fc fc fb fc fc fc fc fb fc fc fc
 ffff88801da40480: fc fb fc fc fc fc fa fc fc fc fc fb fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	ca db 15             	lret   $0x15db
   7:	f8                   	clc
   8:	48 89 ef             	mov    %rbp,%rdi
   b:	e8 82 51 16 f8       	callq  0xf8165192
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
* 2a:	e8 c3 1b 09 f8       	callq  0xf8091bf2 <-- trapping instruction
  2f:	65 8b 05 dc a0 bb 76 	mov    %gs:0x76bba0dc(%rip),%eax        # 0x76bba112
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	f0                   	lock
  3f:	02                   	.byte 0x2


Tested on:

commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1562008db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177bd55db00000

