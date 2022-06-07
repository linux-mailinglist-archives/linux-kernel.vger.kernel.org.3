Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502F5417DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379088AbiFGVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358204AbiFGUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:03:20 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1091C285B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:25:41 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id l10-20020a6b3e0a000000b006694bc5a982so3642773ioa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=k1e8Tc/bhXaKPbvd4ORPtFyg8YT3uAhzDyuaK7uM+Js=;
        b=qttQh9jMsL/Y/JBgTkMaZiztdmNoZEGuky4l7LR1HmG02ib9ddtNrWZSh/6nBn9IpQ
         965k6WODDGJ8wUixquC6PcK26BH0FW/FAatGGOAo6TfDPAnEvlYzVtEH7QUkzduWPZkG
         C3laBM7Cn0IoMjgIFSEugwhcQFSfZKVq7NENrNflZ7KhhmLovvgSUgPvJf0yQXJH1y0X
         sTndGUE541UVI/xnNZ0PVIIoChUCyCjTDx1Zf8XAJ6UYYHsvX+lbdgjANecxPSJd171y
         FxC1HPMmIJUH/xniZQ0EdcWah/gRRwjh7srv6kSwyd5qU5nx7jv9tJLOtm2d7+Sb/6We
         +xUA==
X-Gm-Message-State: AOAM533lzi/fuKOdGDDqzG6ITYEYC6/SyWAqIVggWGylNX0U748DvPFR
        w7nREeltk0k34B5l0oat71T9HrVJAhenE1HgW+3AKZeQM0Pt
X-Google-Smtp-Source: ABdhPJz1VGU8BKz+izWU7o5gCU8RmLnE5bPfn5dnUbUENVntlYs7SI1MIryy7TOVwCfxPjNN7UPXo4ky6Bwv6B+DmLmIj+Waeo+f
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:2d1:bb9a:bade with SMTP id
 k3-20020a056e021a8300b002d1bb9abademr17126640ilv.189.1654626321631; Tue, 07
 Jun 2022 11:25:21 -0700 (PDT)
Date:   Tue, 07 Jun 2022 11:25:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023102605e0dfb6c0@google.com>
Subject: [syzbot] general protection fault in reset_interrupt (2)
From:   syzbot <syzbot+682e25dfa0255204491a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    50fd82b3a9a9 Merge tag 'docs-5.19-2' of git://git.lwn.net/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b08fbdf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7e6d86633f6f71
dashboard link: https://syzkaller.appspot.com/bug?extid=682e25dfa0255204491a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165f5277f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171403aff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+682e25dfa0255204491a@syzkaller.appspotmail.com

c1 00                                            ..
status=d0
fdc_busy=0
cont=0000000000000000
current_req=0000000000000000
command_status=-1
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 3 PID: 3441 Comm: kworker/u16:2 Not tainted 5.18.0-syzkaller-12234-g50fd82b3a9a9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:reset_interrupt.cold+0x3d/0x88 drivers/block/floppy.c:1789
Code: e8 da f0 ff ff e9 89 61 52 fb e8 e1 39 33 f8 48 8b 1d 8a 3b dd 07 b8 ff ff 37 00 48 c1 e0 2a 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3e 48 8b 73 10 48 c7 c7 40 51 42 8a e8 5c 28 eb ff
RSP: 0018:ffffc90002d2fd08 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff89467b8f RDI: 0000000000000010
RBP: ffffffff8c8e71e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc90002d2fda8 R14: ffff888014ba4100 R15: ffff888011875800
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f751b73001d CR3: 000000001f1bf000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reset_interrupt.cold+0x3d/0x88 drivers/block/floppy.c:1789
Code: e8 da f0 ff ff e9 89 61 52 fb e8 e1 39 33 f8 48 8b 1d 8a 3b dd 07 b8 ff ff 37 00 48 c1 e0 2a 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3e 48 8b 73 10 48 c7 c7 40 51 42 8a e8 5c 28 eb ff
RSP: 0018:ffffc90002d2fd08 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff89467b8f RDI: 0000000000000010
RBP: ffffffff8c8e71e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc90002d2fda8 R14: ffff888014ba4100 R15: ffff888011875800
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f751b73001d CR3: 000000001f1bf000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 da f0 ff ff       	callq  0xfffff0df
   5:	e9 89 61 52 fb       	jmpq   0xfb526193
   a:	e8 e1 39 33 f8       	callq  0xf83339f0
   f:	48 8b 1d 8a 3b dd 07 	mov    0x7dd3b8a(%rip),%rbx        # 0x7dd3ba0
  16:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  1b:	48 c1 e0 2a          	shl    $0x2a,%rax
  1f:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 3e                	jne    0x6e
  30:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  34:	48 c7 c7 40 51 42 8a 	mov    $0xffffffff8a425140,%rdi
  3b:	e8 5c 28 eb ff       	callq  0xffeb289c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
