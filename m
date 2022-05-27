Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C4535D55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350389AbiE0JZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349784AbiE0JZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:25:20 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5996F688F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:25:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so2730034ilu.14
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bioz4H7go5J90Q3ZEufZq+kViXZ5tT6di1K26jNf73s=;
        b=TOVQrzx5xqBBgvNSl0YSlTYvSjVq0X7LrzahnpMG/JPrfZG/UFU2QawJUCSjRc+uyf
         B4cBw9IqPCHeswVVDxtkES67lp3WhBNSyFWGSwfd3Dv9zQXU7v1kKvP4FxIzlZdAQgj/
         fXBLIntJHCvph24XvjuRQT+gF4dUzEgAuXzWLeAtPkAzSHHQ7fxVM/DV/PiYExu6hL9F
         QuOlEmRiiaCitegF0h2G3Ypkmi8j6sQGx5De90rSfjYc3ph47UUOIGHSXa70jAtPvmOX
         YFdqvnqxWlQ3TYJ1tRe8EQnEzxh6YdNFFZy/FI4WZAG3YbW4EHrR2qgF+JezNGxN6Z8n
         xiqw==
X-Gm-Message-State: AOAM531zbgbkt7igxZG5me5Mn1e4wJJkeDNs3HLIuwsgKx+Ud1vXaPv4
        iEG4qugdzg/Gw2AXJf71zpI6GHbrVMEIa27Sql91/WJghFE+
X-Google-Smtp-Source: ABdhPJwU9+oPb5euZt6EIixTC316LnS7lGlY8wHMCd2LT/iyjaYKsY+BGzV/qzUuWp7h7I8Nl0xv+2yBUkS3lYmP/g5katOSesCO
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:2d3:1817:49b0 with SMTP id
 q10-20020a92ca4a000000b002d3181749b0mr1751787ilo.258.1653643519221; Fri, 27
 May 2022 02:25:19 -0700 (PDT)
Date:   Fri, 27 May 2022 02:25:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c664105dffae2eb@google.com>
Subject: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
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

HEAD commit:    97fa5887cf28 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=170ebdc3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124ad81f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d6004df00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com

kobject_add_internal failed for raw-gadget with -EEXIST, don't try to register things with the same name in the same directory.
UDC core: USB Raw Gadget: driver registration failed: -17
misc raw-gadget: fail, usb_gadget_register_driver returned -17
------------[ cut here ]------------
Unexpected driver unregister!
WARNING: CPU: 0 PID: 1308 at drivers/base/driver.c:194 driver_unregister drivers/base/driver.c:194 [inline]
WARNING: CPU: 0 PID: 1308 at drivers/base/driver.c:194 driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
Modules linked in:
CPU: 0 PID: 1308 Comm: syz-executor314 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:driver_unregister drivers/base/driver.c:194 [inline]
RIP: 0010:driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
Code: 68 4c 89 e7 e8 65 b9 db fe 48 89 ef e8 fd a0 ff ff 5d 41 5c e9 75 fa 78 fe e8 70 fa 78 fe 48 c7 c7 80 7a 81 86 e8 12 96 ee 02 <0f> 0b 5d 41 5c e9 5a fa 78 fe e8 75 93 ad fe eb 96 e8 6e 93 ad fe
RSP: 0018:ffffc90001087a78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811d184050 RCX: 0000000000000000
RDX: ffff88810902d580 RSI: ffffffff812bdce8 RDI: fffff52000210f41
RBP: ffff88811d184098 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff812b86be R11: 0000000000000000 R12: 0000000000000000
R13: ffff88811d184008 R14: ffff88811d05b1a8 R15: ffff8881008456a0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea994ab2d0 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_gadget_unregister_driver+0x48/0x70 drivers/usb/gadget/udc/core.c:1590
 raw_release+0x18a/0x290 drivers/usb/gadget/legacy/raw_gadget.c:401
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:37 [inline]
 do_exit+0xaff/0x2980 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x22df/0x24c0 kernel/signal.c:2864
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:867
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x156/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fea99520a57
Code: Unable to access opcode bytes at RIP 0x7fea99520a2d.
RSP: 002b:00007fea994aa258 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffef RBX: 00007fea994ab2d0 RCX: 00007fea99520a57
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000ffff R09: 000000000000000b
R10: 00007fea994aa300 R11: 0000000000000246 R12: 00007fea995a55e0
R13: 00007fea994aa2a0 R14: 00007fea994ac400 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
