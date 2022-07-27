Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15582581F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiG0Erd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiG0Erb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:47:31 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8E3DBEC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:47:29 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g6-20020a056e021e0600b002ddc52f6236so638510ila.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/ub7C209U2i1ZQ26TnANhRBorghIVJMSqJvhdz+G0Mc=;
        b=7+aHMuIdknFQo02BfGpTlztvhP431Pr+AFk3chCp8cc0srnuYbwnwr1MhMuumxM0X7
         BgNrjSTUDMH786bF8rsiwvLB4P00KAQiSDJ3X3rhfwGZbjuwdcr53jfT8YoqGtD2xSfb
         ie5CE7OCgtfVb3T3jbwTB8xZi1HTZe1ltLARP2lr4uWzvbpB/YaHB74Rw8bGzPQvnVrq
         dMp3swgiv9qWrmki+NcukLAOhgbJb2OPDgUPyEsxWgbXV2p+Xa8t56C/i5e/cV2jj9KT
         W2MjN/CyLd4XQAXv427spHJ1490yIXykkU0ymGQdHoPg29t7vQ0rHO5HhFr4RwZPIE5f
         9W5w==
X-Gm-Message-State: AJIora+oH3Mb6GfLRWUOKWZizLAi9nhF5ItNIQFunua2pQOdws/O51FY
        R/ELUz1bVHTd46RTJaSQKlge+/bZi9/GHBttwlSO/44rqHOS
X-Google-Smtp-Source: AGRyM1s68Awxg2ZiqZMLrzsfJehvdtNZsvf6v6K7eWxwWGVFDxTMke9zlKfi2ry5aaec13hvHDT2k9StqPEdRA7Pj9AuwUH4cCRw
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1355:b0:63d:a9ab:7e30 with SMTP id
 i21-20020a056602135500b0063da9ab7e30mr7259013iov.119.1658897249041; Tue, 26
 Jul 2022 21:47:29 -0700 (PDT)
Date:   Tue, 26 Jul 2022 21:47:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f87b505e4c21d7b@google.com>
Subject: [syzbot] WARNING in floppy_interrupt
From:   syzbot <syzbot+7c9e87a5d6b088cd78a3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a57a8400075 vf/remap: return the amount of bytes actually..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119ac0fc080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd73026ceaed1402
dashboard link: https://syzkaller.appspot.com/bug?extid=7c9e87a5d6b088cd78a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c9e87a5d6b088cd78a3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 33 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 3 PID: 33 at drivers/block/floppy.c:999 floppy_interrupt+0x32b/0x3a0 drivers/block/floppy.c:1765
Modules linked in:
CPU: 3 PID: 33 Comm: ksoftirqd/3 Not tainted 5.19.0-rc6-syzkaller-00115-g4a57a8400075 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:floppy_interrupt+0x32b/0x3a0 drivers/block/floppy.c:1765
Code: fe ff ff e8 87 25 e0 fc 0f b6 1d 80 24 89 0c 31 ff 89 de e8 77 21 e0 fc 84 db 0f 85 30 b6 ad 04 e9 18 fe ff ff e8 65 25 e0 fc <0f> 0b e9 1a ff ff ff e8 29 e1 2c fd e9 ed fd ff ff e8 1f e1 2c fd
RSP: 0018:ffffc900005d8e58 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000100
RDX: ffff888012229d80 RSI: ffffffff849a457b RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000002
R13: ffffffff8499f800 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f6f5c034 CR3: 000000000ba8e000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 floppy_hardint+0x1ad/0x200 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0x22b/0x880 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xa7/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:817
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
 common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
 </IRQ>
 <TASK>
 asm_common_interrupt+0x22/0x40 arch/x86/include/asm/idtentry.h:640
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 ca de e3 f7 48 89 ef e8 d2 5f e4 f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 43 67 d7 f7 65 8b 05 fc fb 87 76 85 c0 74 0a 5b 5d c3 e8 90 46
RSP: 0018:ffffc900005afbe0 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1b77019
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000001
RBP: ffffffff91193240 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff2232648 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000002 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:999 [inline]
 debug_check_no_obj_freed+0x20c/0x420 lib/debugobjects.c:1020
 slab_free_hook mm/slub.c:1729 [inline]
 slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3536 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3553
 i_callback+0x3f/0x70 fs/inode.c:249
 rcu_do_batch kernel/rcu/tree.c:2578 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2838
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	ca de e3             	lret   $0xe3de
   7:	f7 48 89 ef e8 d2 5f 	testl  $0x5fd2e8ef,-0x77(%rax)
   e:	e4 f7                	in     $0xf7,%al
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
* 2a:	e8 43 67 d7 f7       	callq  0xf7d76772 <-- trapping instruction
  2f:	65 8b 05 fc fb 87 76 	mov    %gs:0x7687fbfc(%rip),%eax        # 0x7687fc32
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	90                   	nop
  3f:	46                   	rex.RX


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
