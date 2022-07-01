Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269175629C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiGADlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiGADlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:41:21 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE067587
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:41:07 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i8-20020a056e020d8800b002d931252904so536143ilj.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Jd4zwShDPU0ZsidpPN7v1uc+f7slDYSQuG2StPqKSLg=;
        b=OvNzAvF+f3+wsAtPeJt3qR+2jsbQ1RduEOPSnaLIinfqHvraNCAe6XFvkYBbCE/Df6
         mMpJ9zMhpWeqIp3aHVueN1US5RTO3hlwo4Efl5fWmdTf3pdXu1rj4c7j9yM8rpkSZdIy
         NQ3g2VMkMknTaj6mGFGHM1lEe/qDiBYpVrTcNV5faNziObtaUeGLUPytAg7SSAwpetx9
         jaqBqGSVVSLMHIWHymwHJGrvZXpz6fkxXtSjIpA333D/Ha6V2APSB0E/tp7HzcVmr4o7
         iNI8j0CdOzJ4psvWdSQv9q1SXMzlxtgLgSNdXd4onHLZDGE0ldy+XvyiyhImZbEcp3T9
         w/Ww==
X-Gm-Message-State: AJIora9OYkwuSCSrofNQjEaA0UDo5pPwcu2m85T57aQ2n1MByt0HVZ5a
        URqlc3/s9njJEF6XWiLLh1drAr5mcvsZFWmCoTgyGLZ1o8Ig
X-Google-Smtp-Source: AGRyM1vUxrl5pWJOfY4QLnVTxwQWa9EFWgUw/40C4FiatjUze9f7xjezwN2CkIrTuFw4t04blFzpZFA5pSvUozTN+ltpF/S/nAcI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150d:b0:33e:987a:4139 with SMTP id
 b13-20020a056638150d00b0033e987a4139mr1743432jat.205.1656646867338; Thu, 30
 Jun 2022 20:41:07 -0700 (PDT)
Date:   Thu, 30 Jun 2022 20:41:07 -0700
In-Reply-To: <20220701032313.1164-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bcd1c05e2b628f0@google.com>
Subject: Re: [syzbot] WARNING in sk_stream_kill_queues (8)
From:   syzbot <syzbot+a0e6f8738b58f7654417@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in sk_psock_stop

nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based firewall rule not found. Use the iptables CT target to attach helpers instead.
BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14037, name: syz-executor244
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor244/14037:
 #0: ffff88806b374410 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff88806b374410 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x280 net/socket.c:649
 #1: ffff88807ecaed30 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1664 [inline]
 #1: ffff88807ecaed30 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_close+0x1e/0xc0 net/ipv4/tcp.c:2974
 #2: ffff88807ecaecb0 (slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:360 [inline]
 #2: ffff88807ecaecb0 (slock-AF_INET){+.-.}-{2:2}, at: __tcp_close+0x4d3/0xf50 net/ipv4/tcp.c:2897
Preemption disabled at:
[<ffffffff87dbd2fb>] local_bh_disable include/linux/bottom_half.h:20 [inline]
[<ffffffff87dbd2fb>] __tcp_close+0x4cb/0xf50 net/ipv4/tcp.c:2896
CPU: 1 PID: 14037 Comm: syz-executor244 Not tainted 5.19.0-rc4-next-20220627-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9859
 start_flush_work kernel/workqueue.c:3010 [inline]
 __flush_work+0x109/0xb10 kernel/workqueue.c:3074
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3162
 sk_psock_stop+0x4cb/0x630 net/core/skmsg.c:810
 sock_map_destroy+0x333/0x760 net/core/sock_map.c:1581
 inet_csk_destroy_sock+0x196/0x440 net/ipv4/inet_connection_sock.c:1011
 __tcp_close+0xb92/0xf50 net/ipv4/tcp.c:2963
 tcp_close+0x29/0xc0 net/ipv4/tcp.c:2975
 sock_map_close+0x3b9/0x780 net/core/sock_map.c:1607
 inet_release+0x12e/0x270 net/ipv4/af_inet.c:428
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1365
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaf1/0x29f0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f1abfde9989
Code: Unable to access opcode bytes at RIP 0x7f1abfde995f.
RSP: 002b:00007ffd0bbbdb28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1abfe5d270 RCX: 00007f1abfde9989
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000000246 R12: 00007f1abfe


Tested on:

commit:         aab35c3d Add linux-next specific files for 20220627
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f66b98080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a874f114a1e4a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=a0e6f8738b58f7654417
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b63ef4080000

