Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B452F547AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiFLPj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiFLPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:39:26 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA92F67B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:39:25 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x3-20020a056e021bc300b002d1b0ccfca6so3023375ilv.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OsuKjvr8Rex0GUK7+NNppKCk58Zc6Dq+s+Iy7Kru1zE=;
        b=U2difLPYEi31C3E57gG25gZVgLkd7kOO37Ws4FdgWLSDeiaLQPt0XS0DR7qAwh5m3T
         5slwyyzRwpT/jlizHjPqwYhOJaG9NcXZw1b5jNSqMHW66kEEfxFmJAz61gLDoxr+JT96
         xLLM7DgOWvvrPtsH9UOHRRcqCPyM3RBnRFqU8lU095apupklY27U7sklTris+hyb9ONh
         YKh9j/Y0KydVqaXFRUqFK6VfL8ktf8oKgTA3mFBPSW1VdMxkYzFnhkGcjj1m/HiAM5F8
         9YrljVVZzpmWL4ikN0dj4aDf1goI2QgyA4FZEyLD8Z/yf/nx+MHWG5zs9lrD42ZGEwom
         y4KA==
X-Gm-Message-State: AOAM531jVeC9Ov2bmt/K7co/xes3lsiezyyDQDkGQM3YgIG+crrD4kpL
        OFl6Y7oXm7stUUWa+XdgihPcBMQLpECLmgoyfb6OLc+Vsjzs
X-Google-Smtp-Source: ABdhPJwiN5A7P3a4vgEJOLBCF/vP9XNMWlAFJiCy3YknqPlzQtEeaUdeDMOWE2BDHxCzxwFrRxhGmz0nSji//UGGn9KB0eAqCw6Y
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c06:b0:2d1:b240:736f with SMTP id
 l6-20020a056e021c0600b002d1b240736fmr31088256ilh.133.1655048365077; Sun, 12
 Jun 2022 08:39:25 -0700 (PDT)
Date:   Sun, 12 Jun 2022 08:39:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2fc3f05e141f930@google.com>
Subject: [syzbot] WARNING in exit_tasks_rcu_finish
From:   syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>
To:     brauner@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
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

HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b52c2ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
Modules linked in:
CPU: 1 PID: 28639 Comm: syz-executor.3 Not tainted 5.19.0-rc1-next-20220610-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
RIP: 0010:exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 62 0f b6 85 89 04 00 00 83 e0 01 08 d8 74 0e <0f> 0b 5b 48 89 ef 5d 41 5c e9 00 d2 ff ff 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc9000a497b58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000201 RCX: 1ffff11004213b89
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88802109dc49
RBP: ffff88802109d7c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802109dc40
R13: dffffc0000000000 R14: ffff88802109d7c0 R15: ffff88802109ddd0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f771379d090 CR3: 0000000051fd2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_exit+0x18f2/0x2a00 kernel/exit.c:844
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2542/0x2600 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f7713689109
Code: Unable to access opcode bytes at RIP 0x7f77136890df.
RSP: 002b:00007f77125fe218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f771379bf68 RCX: 00007f7713689109
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f771379bf6c
RBP: 00007f771379bf60 R08: 00007fff2278d080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f771379bf6c
R13: 00007fff22724c8f R14: 00007f77125fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
