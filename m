Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD4547D09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 02:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiFMAQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 20:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiFMAQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 20:16:22 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61633AA66
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 17:16:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id j12-20020a5d93cc000000b006692aee869fso1900255ioo.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 17:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y7RAe1tM6uWuUc078fN3uqS2Bw7kttF14LoeKPYncuI=;
        b=3PtzK1ckh1t71MGxBQbdexw2XTdDMX53akJQ6LuZfM8+RHGfQpGXFJFPVjGq/uobuA
         uJ6PjxCyzaCq0F63EFbTEGRTMGKIi2ErYW4X5MZrNAzxArN3XY4OqrcvO+FAXg+kmkNz
         hGqObZ2FWid36Ekzya9eis3W+4N6iJui45Op7N4IkqbJ/scX/Mms9NetKtpHTTaw0DQz
         i6Q8hPM1FoBN8ddBvQJJtIYnms9C3U7IaZM6xf/PzkxnwKQXC+nHEhzjNXPTSJ0XwVTO
         cvET69iO3P3Pm+UGawcd62UHsNfOlj1UNrlzlZ+na4R+kNacOmp7QIomlc1XXHqh4aQj
         oMbA==
X-Gm-Message-State: AOAM532F/UuleJhZ/zMJrlTAZwPeXr2s1fHNBS2x2Bko0uybBZZrI34K
        jMrVPfnvfUmrsJpNkwkEQY84743VQKvFtF1dZmzIgtSN3Wc4
X-Google-Smtp-Source: ABdhPJxmEopDpNumMtUV0jRz3LJuRLrccro+I+TXhNne/CGOFimVZ1OgtVrViq1FGKIYeIqNBUnUGChAGLb7z2rLsstuYziqcE7p
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:2d3:ccfe:6551 with SMTP id
 l2-20020a056e021c0200b002d3ccfe6551mr32768978ilh.134.1655079380097; Sun, 12
 Jun 2022 17:16:20 -0700 (PDT)
Date:   Sun, 12 Jun 2022 17:16:20 -0700
In-Reply-To: <000000000000e2fc3f05e141f930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086a09205e1493272@google.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
From:   syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>
To:     brauner@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106611bff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177b6230080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148207bff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4198 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
WARNING: CPU: 1 PID: 4198 at kernel/rcu/tasks.h:1664 exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
Modules linked in:
CPU: 1 PID: 4198 Comm: syz-executor403 Not tainted 5.19.0-rc1-next-20220610-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
RIP: 0010:exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 62 0f b6 85 89 04 00 00 83 e0 01 08 d8 74 0e <0f> 0b 5b 48 89 ef 5d 41 5c e9 00 d2 ff ff 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90003a2fb58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000201 RCX: 1ffff1100ebf1091
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888075f88489
RBP: ffff888075f88000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888075f88480
R13: dffffc0000000000 R14: ffff888075f88000 R15: ffffc90003a2fbe8
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556d916d0 CR3: 000000000ba8e000 CR4: 00000000003506e0
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
RIP: 0033:0x7fb21689cc79
Code: Unable to access opcode bytes at RIP 0x7fb21689cc4f.
RSP: 002b:00007fb21684d218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fb216924408 RCX: 00007fb21689cc79
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fb216924408
RBP: 00007fb216924400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb21692440c
R13: 00007ffe134b471f R14: 00007fb21684d300 R15: 0000000000022000
 </TASK>

