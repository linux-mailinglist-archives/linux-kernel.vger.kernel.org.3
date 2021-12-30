Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A1481DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhL3PrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:47:20 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48965 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3PrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:47:19 -0500
Received: by mail-io1-f69.google.com with SMTP id i12-20020a056602134c00b0060211f8b5b7so6719423iov.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6RS1U9AoIgbz+X3YiDBV2zoY0Pg1G9egSVvAq3dMzzc=;
        b=SmBq+MMf3tTG5VzsyE/AtRLo/bVXsS+YEE+zpY9TZpBgASMRSlaU0gTcYZPjpsGqpR
         FQ/PQ3Ny9tla5Z1IxIgQiQ7cM7ir3L9sDP24b3BThnXi2dS1UoHwPBhc1AoRKRrP95oV
         EVwVel9auSEfaVDHc5i5+E8jBis3TadQ1mR/n2G3n1quVXByLIXSHxSIDmc7CgNtT88B
         tqXLxvHW9AsD4f9SBbc9tgWDDVI/4BoCmPO3rxaAE9a0WVoQDSQXefH3DuUxVlBa0Cva
         hZq0EAEeOPay5fvqoDBPcTNuhJNxMVjfzHwx3nRmFeGlxDuqfHTvpq4gBnpl0sapvQCp
         vIXg==
X-Gm-Message-State: AOAM5317WAqmsfv3a3IeHSSn16D39tdAOWdpgFmfPvLj7621H3rX35Lq
        ojYY2f0Rbv6tN2tV32pAGWascvtZGuvCR1YewuvP5x2A3U/q
X-Google-Smtp-Source: ABdhPJx5EIR/Jje5tsKlhk7vTZRRNj0MIz0XKleUF88MJNpWtkGO292iAlBCZz/5BkUXVM/AxeKwhhndvjYFRNbv+OkPSScQq4Yp
MIME-Version: 1.0
X-Received: by 2002:a92:c547:: with SMTP id a7mr9131655ilj.116.1640879238834;
 Thu, 30 Dec 2021 07:47:18 -0800 (PST)
Date:   Thu, 30 Dec 2021 07:47:18 -0800
In-Reply-To: <000000000000bbbbcf05aec86741@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026712705d45ef8a7@google.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    eec4df26e24e Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1696bbfbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ebd4b29568807bc
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b14c1bb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ab99edb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x243/0x530 drivers/usb/core/hcd.c:774
Write of size 2 at addr ffff88801dd0d780 by task syz-executor046/3607

CPU: 1 PID: 3607 Comm: syz-executor046 Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_address_description+0x65/0x380 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:450
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 memcpy+0x3c/0x60 mm/kasan/shadow.c:66
 usb_hcd_poll_rh_status+0x243/0x530 drivers/usb/core/hcd.c:774
 call_timer_fn+0xf6/0x210 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers+0x71a/0x910 kernel/time/timer.c:1734
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1747
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:console_unlock+0xc88/0xe90 kernel/printk/printk.c:2716
Code: 00 e9 71 fa ff ff e8 a7 70 1a 00 e8 62 4b a0 08 48 83 7c 24 38 00 74 dd 66 2e 0f 1f 84 00 00 00 00 00 e8 8b 70 1a 00 fb 31 ff <44> 89 f6 e8 90 74 1a 00 31 db 45 85 f6 0f 95 c0 89 c1 0a 4c 24 0f
RSP: 0018:ffffc90001a8f0e0 EFLAGS: 00000246
RAX: ffffffff816a0d85 RBX: 0000000000000000 RCX: ffff888018638000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90001a8f2f0 R08: ffffffff816a0d3c R09: fffffbfff1bfd566
R10: fffffbfff1bfd566 R11: 0000000000000000 R12: ffffffff8d3ec5e8
R13: ffffffff8d3ec5b0 R14: 0000000000000001 R15: ffffc90001a8f160
 vprintk_emit+0xba/0x140 kernel/printk/printk.c:2245
 dev_vprintk_emit+0x2e4/0x35d drivers/base/core.c:4594
 dev_printk_emit+0xd9/0x118 drivers/base/core.c:4605
 _dev_warn+0x11e/0x165 drivers/base/core.c:4661
 checkintf drivers/usb/core/devio.c:826 [inline]
 do_proc_bulk+0x81c/0x15d0 drivers/usb/core/devio.c:1268
 proc_bulk drivers/usb/core/devio.c:1351 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2625 [inline]
 usbdev_ioctl+0x36b7/0x6d00 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc8c54137a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe10cef0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc8c54570b0 RCX: 00007fc8c54137a9
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000006
RBP: 00007ffe10cef0f0 R08: 00007ffe10ceeb40 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 00007fc8c53d2780
R13: 0000000000000000 R14: 00007ffe10cef0f0 R15: 00007ffe10cef0e0
 </TASK>

Allocated by task 3616:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:513
 kasan_kmalloc include/linux/kasan.h:269 [inline]
 __kmalloc+0x253/0x380 mm/slub.c:4423
 kmalloc include/linux/slab.h:595 [inline]
 do_proc_bulk+0x858/0x15d0 drivers/usb/core/devio.c:1292
 proc_bulk drivers/usb/core/devio.c:1351 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2625 [inline]
 usbdev_ioctl+0x36b7/0x6d00 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88801dd0d780
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff88801dd0d780, ffff88801dd0d788)
The buggy address belongs to the page:
page:ffffea0000774340 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1dd0d
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000077d900 dead000000000002 ffff888011441280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 22, ts 8565550793, free_ts 8556148454
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0x729/0x9e0 mm/page_alloc.c:4149
 __alloc_pages+0x255/0x580 mm/page_alloc.c:5369
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab+0xcc/0x540 mm/slub.c:1930
 new_slab mm/slub.c:1993 [inline]
 ___slab_alloc+0x41e/0xc40 mm/slub.c:3022
 __slab_alloc mm/slub.c:3109 [inline]
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x2eb/0x380 mm/slub.c:4419
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 smk_parse_smack+0x18e/0x220 security/smack/smack_access.c:468
 smk_import_entry+0x22/0x400 security/smack/smack_access.c:566
 smk_fetch security/smack/smack_lsm.c:300 [inline]
 smack_d_instantiate+0x6ac/0xd10 security/smack/smack_lsm.c:3417
 security_d_instantiate+0xa5/0x100 security/security.c:2040
 d_instantiate+0x51/0x90 fs/dcache.c:2008
 shmem_mknod+0x165/0x1b0 mm/shmem.c:2842
 shmem_mkdir+0x2e/0x60 mm/shmem.c:2881
 vfs_mkdir+0x44d/0x680 fs/namei.c:3883
 dev_mkdir drivers/base/devtmpfs.c:165 [inline]
 create_path drivers/base/devtmpfs.c:190 [inline]
 handle_create drivers/base/devtmpfs.c:209 [inline]
 handle drivers/base/devtmpfs.c:380 [inline]
 devtmpfs_work_loop+0x386/0x1080 drivers/base/devtmpfs.c:395
 devtmpfsd+0x44/0x50 drivers/base/devtmpfs.c:437
 kthread+0x468/0x490 kernel/kthread.c:327
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0xd1c/0xe00 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page_list+0x11f/0xa50 mm/page_alloc.c:3425
 release_pages+0x15a7/0x17d0 mm/swap.c:980
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:340
 exit_mmap+0x3dd/0x6f0 mm/mmap.c:3172
 __mmput+0x111/0x3a0 kernel/fork.c:1113
 free_bprm+0x136/0x2f0 fs/exec.c:1481
 kernel_execve+0x740/0x9a0 fs/exec.c:1978
 call_usermodehelper_exec_async+0x262/0x3b0 kernel/umh.c:112
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffff88801dd0d680: fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc
 ffff88801dd0d700: fc 00 fc fc fc fc 00 fc fc fc fc fb fc fc fc fc
>ffff88801dd0d780: 01 fc fc fc fc 00 fc fc fc fc fa fc fc fc fc fa
                   ^
 ffff88801dd0d800: fc fc fc fc fa fc fc fc fc fa fc fc fc fc 00 fc
 ffff88801dd0d880: fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc fc
==================================================================
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e9 71 fa ff ff       	jmpq   0xfffffa76
   5:	e8 a7 70 1a 00       	callq  0x1a70b1
   a:	e8 62 4b a0 08       	callq  0x8a04b71
   f:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
  15:	74 dd                	je     0xfffffff4
  17:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1e:	00 00 00
  21:	e8 8b 70 1a 00       	callq  0x1a70b1
  26:	fb                   	sti
  27:	31 ff                	xor    %edi,%edi
* 29:	44 89 f6             	mov    %r14d,%esi <-- trapping instruction
  2c:	e8 90 74 1a 00       	callq  0x1a74c1
  31:	31 db                	xor    %ebx,%ebx
  33:	45 85 f6             	test   %r14d,%r14d
  36:	0f 95 c0             	setne  %al
  39:	89 c1                	mov    %eax,%ecx
  3b:	0a 4c 24 0f          	or     0xf(%rsp),%cl

