Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1183B58C46F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbiHHHy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiHHHyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:54:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242CB11C29
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:54:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w6-20020a6bf006000000b006845b59a08bso2597331ioc.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 00:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=M1aIXwZE6mKX2bgj5k34xKzHGwgUSygSNxNpylwHFFk=;
        b=ViunAey/H95k71prSy51yCrQYAIPmqe1p2e7PGvI9kCBGF8egoFARpkxHdbvKz8LqZ
         e0C2QsO/fjjQwPxFDw/yDb1iC2fabkf9zFqjzbLtFciABN+7rSZygmcRcV+7NlKwwtAH
         wXACZKr4u3/yf7qZ3EI0uAj8hvvg7LXOAxQDxvTi8bS2ktjiS68x4sZPKInpJ3P8zoM1
         spVEZ0qC4pjdyFBf0akmzwB7z7WZC1xYWAwh39RCc7xkAzdLNO7yvrc1EIjKsl7BRDVI
         AmiOId5tsZ6RIZwRm8/ZCJI7fnSrr/+Q8Etj/zbGkY0gGjTi9p8mNVvEB2+oJo8Y230d
         9Pbw==
X-Gm-Message-State: ACgBeo26Ux5GyU06NFewzDm6+XWmiWeY6gofhABnZW/4VmThc1c5EA1v
        cMmQXB6PSvTp4u6WRW1xJ5scr75b0kw2IoFi5zYoWSleohZ2
X-Google-Smtp-Source: AA6agR53NZcATyFBBYB6OHl3SfTojv3wtZnYEKkX+K47WxS4FIereD7KqTjPaaCea7ThHoauzo3OxuQ66G++rfMVsMilYHDhC8iq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:2df:947e:2318 with SMTP id
 s10-20020a056e02216a00b002df947e2318mr5680117ilv.220.1659945262460; Mon, 08
 Aug 2022 00:54:22 -0700 (PDT)
Date:   Mon, 08 Aug 2022 00:54:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7352e05e5b61f84@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in gsmld_receive_buf
From:   syzbot <syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
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

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1562df51080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=e3563f0c94e188366dbb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 7b32a067 P4D 7b32a067 PUD 7e135067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4273 Comm: syz-executor.0 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000c3a7cf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888041a85000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000007d RDI: ffff888041a85000
RBP: ffffc9000c3a7da1 R08: 0000000000000001 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffc9000c3a7d90 R15: dffffc0000000000
FS:  00007f58156b4700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000025ca1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gsmld_receive_buf+0x1c2/0x2f0 drivers/tty/n_gsm.c:2861
 tiocsti drivers/tty/tty_io.c:2293 [inline]
 tty_ioctl+0xa75/0x15d0 drivers/tty/tty_io.c:2692
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5814489279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f58156b4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f581459bf80 RCX: 00007f5814489279
RDX: 0000000020000280 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 00007f58144e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd1f199d5f R14: 00007f58156b4300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000c3a7cf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888041a85000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000007d RDI: ffff888041a85000
RBP: ffffc9000c3a7da1 R08: 0000000000000001 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffc9000c3a7d90 R15: dffffc0000000000
FS:  00007f58156b4700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000025ca1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
