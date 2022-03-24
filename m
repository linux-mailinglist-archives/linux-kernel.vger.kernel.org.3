Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41BC4E5FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348704AbiCXIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiCXIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:07:02 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05E47AC8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:05:30 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id g2-20020a056e02130200b002c837b25e60so2343898ilr.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lyJrSW4wDcuNfJrpcCLjJJ/Nl57jnLSCYWnrohs0+bE=;
        b=SkSaJpMeogn4uahqSC3DcgaSXWk8Gj6zCbBSJ7gyJP4hnOREY7ivf5p1Y8UqGb+iGM
         LHBPG1gpffp+ZnKpcNRcR0HAr/Nn42MeR3ni6ocdOFk3Rg3nglW3XTR5Ask7RbnkswCH
         MShnhTXpmDuC7+UWuFahOCNfoG5khTHJFNMIKoVgKIJcxoe5D9xUAoRE/UUA/FHGy5Go
         reEXVxFAa5cm08IjaNym7QETr3VkQdTjVkittCvkBfBBOYuDdg3wqMqnX/cBqvDqwBeb
         TqcnO+Mv/CzCZoc8Szsb5rloga95w+s0zYPOk0knh/Q93+MIJnX1o3DB7t9B36+GBkTA
         7LVA==
X-Gm-Message-State: AOAM53146EsXvj8I/OPeGUF685NOlhQFk9nuYcMaVP/wn9ydnCqumaGZ
        FtnNhHuiM0Ds+VL8KgdbZb5bFZ284ap0miizS83qwjJWp4z3
X-Google-Smtp-Source: ABdhPJznQTZc0SUPRekIeKv/BvXmumJJNy6ZG1sLE03YPeaTySKbteBgI62ZjuExhSV9kujpfOv+zUFAYnSmJxfFGxjUjRyGzX6n
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c2:b0:319:d84d:e878 with SMTP id
 l2-20020a05663814c200b00319d84de878mr2118389jak.314.1648109129411; Thu, 24
 Mar 2022 01:05:29 -0700 (PDT)
Date:   Thu, 24 Mar 2022 01:05:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035adf105daf24fba@google.com>
Subject: [syzbot] upstream boot error: WARNING in blk_release_queue
From:   syzbot <syzbot+8e08dfd9ad607062fa1b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1bc191051dca Merge tag 'trace-v5.18' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b7c1f9700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f8915481c02c4
dashboard link: https://syzkaller.appspot.com/bug?extid=8e08dfd9ad607062fa1b
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e08dfd9ad607062fa1b@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=402 set at [<ffffffff81583637>] worker_thread+0xf57/0x1300 kernel/workqueue.c:2472
WARNING: CPU: 1 PID: 10 at kernel/sched/core.c:9660 __might_sleep+0xb0/0xe0 kernel/sched/core.c:9656
Modules linked in:
CPU: 1 PID: 10 Comm: kworker/u4:1 Not tainted 5.17.0-syzkaller-02237-g1bc191051dca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue:  0x0 (events_unbound)
RIP: 0010:__might_sleep+0xb0/0xe0 kernel/sched/core.c:9656
Code: af 0c 01 42 80 3c 23 00 74 08 48 89 ef e8 78 17 7a 00 48 8b 4d 00 48 c7 c7 60 c8 8e 8a 44 89 ee 48 89 ca 31 c0 e8 f0 90 f2 ff <0f> 0b eb b7 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 72 ff ff ff 48 89
RSP: 0000:ffffc90000dd0b38 EFLAGS: 00010246
RAX: e1fd253f302a1e00 RBX: 1ffff1100248367e RCX: ffff888012419d00
RDX: 0000000080000101 RSI: 0000000080000101 RDI: 0000000000000000
RBP: ffff88801241b3f0 R08: ffffffff816b7962 R09: fffffbfff1c40ac6
R10: fffffbfff1c40ac6 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000402 R14: 00000000000002ff R15: ffffffff8c6a6052
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 blk_release_queue+0x2e/0x2a0 block/blk-sysfs.c:767
 kobject_cleanup+0x1c0/0x280 lib/kobject.c:705
 blkg_free+0x2d0/0x320 block/blk-cgroup.c:86
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xa85/0x1700 kernel/rcu/tree.c:2786
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
Code: 71 40 fd ff 90 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 be c8 41 f7 48 89 df e8 46 7a 43 f7 e8 31 2f 67 f7 fb bf 01 00 00 00 <e8> 46 dd 35 f7 65 8b 05 67 b7 dc 75 85 c0 74 02 5b c3 e8 7c a0 da
RSP: 0000:ffffc90000cf7dd8 EFLAGS: 00000286
RAX: e1fd253f302a1e00 RBX: ffff888011869800 RCX: ffffffff90e09903
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 0000000000000080 R08: ffffffff818ce770 R09: ffffed100230d301
R10: ffffed100230d301 R11: 0000000000000000 R12: ffff8880119b3c00
R13: ffff888011869858 R14: ffff888011869860 R15: dffffc0000000000
 worker_thread+0xfba/0x1300 kernel/workqueue.c:2474
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess):
   0:	71 40                	jno    0x42
   2:	fd                   	std
   3:	ff 90 53 48 89 fb    	callq  *-0x476b7ad(%rax)
   9:	48 83 c7 18          	add    $0x18,%rdi
   d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  12:	e8 be c8 41 f7       	callq  0xf741c8d5
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	e8 46 7a 43 f7       	callq  0xf7437a65
  1f:	e8 31 2f 67 f7       	callq  0xf7672f55
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 46 dd 35 f7       	callq  0xf735dd75 <-- trapping instruction
  2f:	65 8b 05 67 b7 dc 75 	mov    %gs:0x75dcb767(%rip),%eax        # 0x75dcb79d
  36:	85 c0                	test   %eax,%eax
  38:	74 02                	je     0x3c
  3a:	5b                   	pop    %rbx
  3b:	c3                   	retq
  3c:	e8                   	.byte 0xe8
  3d:	7c a0                	jl     0xffffffdf
  3f:	da                   	.byte 0xda


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
