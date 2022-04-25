Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546D850E9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbiDYTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245050AbiDYTz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:55:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E743494
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:52:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so6685967ilu.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=emSNfNKC6mJeWBC9RUnL2UNChyCJyoZPYeI5WbMpK/s=;
        b=5W0NW3K0u8oGgcsMuh7b6oco6Y8YBj5UU3NWPDNOkK9pnSmUdVGxU1SDleoMS+jKHo
         Ikcz3kg2rUeKS5mA64Y8wRRBSUE7YRs0W+hFMYu+IXaJvquG7/fkmFHvn/eY6IfgpQP1
         nM2MFTkvieaHACL5bU+UFaZq+C3giR8NSbpPlX362qDNxg40unyou8EiIsWpDgkdjxlD
         axKQEbOylyNG1Npi373rysbviJuMlCTjFxcmdSomXndfx4egXwHgkjCnO3WtR/GRKwZ3
         5Wr4/Hzk+xGvA814je35jn+t0nL33hAWCaMCRU/bPbg/aVp5HDSNjgR7Jua2oGJTB5L0
         ughg==
X-Gm-Message-State: AOAM531vXhGuiX16Wism4nDD7l0Xz1PATNCXwBNuoEqDvBUwoD9KW8qn
        WOgD/JoIoj5v5eh55XDYViLG4/A7oknllBCAJW5csyfTqBTK
X-Google-Smtp-Source: ABdhPJxKz8pfXEQPFXdIekejf+xg6XNWtBSEi5MMpcNBgzFqnCsytenSpyQe2hMXnjFcyt3xXI2Opqu0fNsXqP8/e4YIjCHynLy0
MIME-Version: 1.0
X-Received: by 2002:a02:90c9:0:b0:323:98e6:1ae8 with SMTP id
 c9-20020a0290c9000000b0032398e61ae8mr8824377jag.15.1650916343552; Mon, 25 Apr
 2022 12:52:23 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:52:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000361f9005dd7fea88@google.com>
Subject: [syzbot] WARNING in wait_til_done
From:   syzbot <syzbot+3562be49b8e09d424a6f@syzkaller.appspotmail.com>
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

HEAD commit:    22da5264abf4 Merge tag '5.18-rc3-ksmbd-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123287c0f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71bf5c8488a4e33a
dashboard link: https://syzkaller.appspot.com/bug?extid=3562be49b8e09d424a6f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3562be49b8e09d424a6f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 379 at drivers/block/floppy.c:1000 schedule_bh drivers/block/floppy.c:1000 [inline]
WARNING: CPU: 2 PID: 379 at drivers/block/floppy.c:1000 wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2019
Modules linked in:
CPU: 2 PID: 379 Comm: syz-executor.0 Not tainted 5.18.0-rc3-syzkaller-00235-g22da5264abf4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:1000 [inline]
RIP: 0010:wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2019
Code: fc 41 83 fd 01 7e ac e8 0e 56 e7 fc 4c 89 e6 48 c7 c7 20 c0 8c 8c e8 5f 9b c8 fc e8 fa 55 e7 fc e9 c3 fd ff ff e8 f0 55 e7 fc <0f> 0b e9 4b fd ff ff e8 b4 e6 32 fd e9 0f fe ff ff e8 da 55 e7 fc
RSP: 0018:ffffc900282676f8 EFLAGS: 00010212
RAX: 0000000000000987 RBX: 1ffff9200504cedf RCX: ffffc90003771000
RDX: 0000000000040000 RSI: ffffffff8491daa0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8c8cbd87
R10: ffffffff8491d7e9 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff8491aab0 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88802cc00000(0063) knlGS:00000000f7f92b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000030e22000 CR3: 0000000019451000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_check_events+0x3d0/0x560 drivers/block/floppy.c:4079
 disk_check_events+0xc2/0x420 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 bdev_check_media_change+0x12c/0x310 block/disk-events.c:279
 floppy_open+0x75d/0xd70 drivers/block/floppy.c:4038
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:666
 blkdev_get_by_dev.part.0+0x5d2/0xc80 block/bdev.c:816
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:850
 blkdev_open+0x13c/0x2c0 block/fops.c:498
 do_dentry_open+0x4a1/0x11e0 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
 do_sys_open fs/open.c:1229 [inline]
 __do_compat_sys_openat fs/open.c:1289 [inline]
 __se_compat_sys_openat fs/open.c:1287 [inline]
 __ia32_compat_sys_openat+0x13f/0x1f0 fs/open.c:1287
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f97549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f92170 EFLAGS: 00000286 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f7f921c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000f6f36000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
