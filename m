Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F0658C407
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiHHHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiHHHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:34:50 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE69FC3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:34:45 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z2-20020a056e02088200b002dc4022c15fso6143751ils.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 00:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=S+E+AcZ+5Jp2kfzZVfJIpPgTwdhmrpLpp6E7uSq7Scc=;
        b=o4uizo5XABMQK5iH3TbfuEa2WKfS4DNaA3xdidyt5veWMPBtmY8rqErEJaiqIbt2XP
         efKX4oX6Z18Rp3gD/OodrBR54fUQdGBddJ2qDmqI1VkjaI2b/CPOk0RU8j4paq03rEil
         8tQxLdJKbnn/+DcJ59pvgVapHYPiWYqHQ8OD9xwHhBW3yCi+vtmszHL+9A2gIkZwarQC
         9+xcD3gcA3RLL3cAsJSItAPCskRTxfELazZ96Vqb5j8ufsfWO+Jc57gvo9Rg6KPDMCCd
         MTkZmf0U10je6JqrF/jRoYbkBEI4wwNhJTzq5VONRg7n2JxDEhPf1/KKseHGpT2If7KX
         zV2w==
X-Gm-Message-State: ACgBeo0GHbNxzbTR7bg3sXU/el8HK4JWyZ4BuUt0/INK7D4wS14+aAb7
        8BuBDnNCpRW4t0HRvxzvrO/GOdOhR6KUTTEocTSfk/CVuf3l
X-Google-Smtp-Source: AA6agR5dXJwQ33bS2pxW2MmU7WPdYfh9tjygviom7OjGqAMyJcZm+C7aaNSJwHA8W3VCYeZqKr9awSTXWvbWXuNfiRhha5EBVO1N
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cb:b0:2dd:46cd:ae52 with SMTP id
 z11-20020a056e0217cb00b002dd46cdae52mr7899956ilu.66.1659944085215; Mon, 08
 Aug 2022 00:34:45 -0700 (PDT)
Date:   Mon, 08 Aug 2022 00:34:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008be58e05e5b5d971@google.com>
Subject: [syzbot] INFO: trying to register non-static key in gsmld_write
From:   syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1339918e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=cf155def4e717db68a12
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 3731 Comm: syz-executor.0 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf1b/0x1120 kernel/locking/lockdep.c:1292
 __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 gsmld_write+0x5e/0x140 drivers/tty/n_gsm.c:3023
 do_tty_write drivers/tty/tty_io.c:1024 [inline]
 file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
 call_write_iter include/linux/fs.h:2192 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:729
 do_iter_write+0x182/0x700 fs/read_write.c:855
 vfs_writev+0x1aa/0x630 fs/read_write.c:928
 do_writev+0x133/0x2f0 fs/read_write.c:971
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd570e89279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd572050168 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fd570f9bf80 RCX: 00007fd570e89279
RDX: 0000000000000001 RSI: 0000000020000480 RDI: 0000000000000003
RBP: 00007fd570ee3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc4cf5714f R14: 00007fd572050300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
